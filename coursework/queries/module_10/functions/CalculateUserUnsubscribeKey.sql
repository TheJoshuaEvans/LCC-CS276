USE [RealTimeWW2];

/*
  Takes a user email and uses secret in the indicated config set to generate the user's
  unsubscribe key. This is done by generating the SHA 256 hash of the user's email address, plus
  the secret from the config set as a salt
*/
DROP FUNCTION IF EXISTS CalculateUserUnsubscribeKey;
GO
CREATE FUNCTION CalculateUserUnsubscribeKey(@UserEmail VARCHAR(320), @ConfigSetId INT = 0) 
RETURNS VARCHAR(64) AS
BEGIN
  DECLARE @UnsubscribeLinkSecret VARCHAR(255) = (
    SELECT UnsubscribeLinkSecret FROM ConfigSets WHERE ConfigSetId = @ConfigSetId
  );
  DECLARE @Result VARCHAR(64) = CONVERT(
    VARCHAR(64), HASHBYTES('SHA2_256', @UserEmail + @UnsubscribeLinkSecret), 2
  );
  RETURN @Result;
END;
GO

GO
PRINT 'Should generate a known key with known values';
-- Use a custom config set so we are sure to use the right values
SET IDENTITY_INSERT [ConfigSets] ON;
DELETE [ConfigSets] WHERE ConfigSetId = 3194;
INSERT INTO [ConfigSets] (ConfigSetId, EmailHeaderImageLink, UnsubscribeLinkSecret, UserLoginSecret) VALUES
  (3194, 'some-link', 'k8m1lQmwQa45DtK?5NuUJuLhXH?Ec5e?iu@pnJev', 'val')

DECLARE @CalculateUserUnsubscribeKeyResult VARCHAR(64) = dbo.CalculateUserUnsubscribeKey('test@email.com', 3194)
DECLARE @ExpectedKey CHAR(64) = 'C225D313CEF76524E21E12187A9D86544A31CB16045B7A37E6A1AFAA294D512A';
IF NOT (@CalculateUserUnsubscribeKeyResult = @ExpectedKey) BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected ' + @ExpectedKey + ', got ' + @CalculateUserUnsubscribeKeyResult;
  THROW 1337000, @Msg, 1;
END;
