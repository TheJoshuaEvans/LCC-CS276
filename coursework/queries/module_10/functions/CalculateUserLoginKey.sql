USE [RealTimeWW2];

/*
  Takes a user email and uses secret in the indicated config set to generate the user's
  login key. This is done by generating the SHA 256 hash of the user's email address, plus
  the secret from the config set as a salt
*/
DROP FUNCTION IF EXISTS CalculateUserLoginKey;
GO
CREATE FUNCTION CalculateUserLoginKey(@UserEmail VARCHAR(320), @ConfigSetId INT = 0) 
RETURNS VARCHAR(64) AS
BEGIN
  DECLARE @LoginLinkSecret VARCHAR(255) = (
    SELECT UserLoginSecret FROM ConfigSets WHERE ConfigSetId = @ConfigSetId
  );
  DECLARE @Result VARCHAR(64) = CONVERT(
    VARCHAR(64), HASHBYTES('SHA2_256', @UserEmail + @LoginLinkSecret), 2
  );
  RETURN @Result;
END;
GO

GO
PRINT 'Should generate a known key with known values';
-- Use a custom config set so we are sure to use the right values
SET IDENTITY_INSERT [ConfigSets] ON;
DELETE [ConfigSets] WHERE ConfigSetId = 5209;
INSERT INTO [ConfigSets] (ConfigSetId, EmailHeaderImageLink, UnsubscribeLinkSecret, UserLoginSecret) VALUES
  (5209, 'some-link', 'val', 'b4JTG6P!Ms6DYbG3i3ArpJCjb3#TjFiFKspReJEo')

DECLARE @CalculateUserLoginKeyResult VARCHAR(64) = dbo.CalculateUserLoginKey('test@email.com', 5209)
DECLARE @ExpectedKey CHAR(64) = '1D8186C5DE16A3B571C3869AC0EAEEDE15FC686417F5396D5B74379D535DD10D';
IF NOT (@CalculateUserLoginKeyResult = @ExpectedKey) BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected ' + @ExpectedKey + ', got ' + @CalculateUserLoginKeyResult;
  THROW 1337000, @Msg, 1;
END;
