USE [RealTimeWW2];

-- REQUIRES
-- functions/CalculateUserUnsubscribeKey.sql

/*
  Replacement trigger that fires when inserting users. This trigger will automatically generate
  the `UserUnsubscribeKey` value for the new item, making it no longer required when creating
  new values
*/
DROP TRIGGER IF EXISTS [OnInsertUser];
GO
CREATE TRIGGER [OnInsertUser] ON [Users] INSTEAD OF INSERT AS
  INSERT INTO [Users] (UserEmail, UserAlias, UserUnsubscribeKey, UserEnabled)
    SELECT 
      [inserted].UserEmail,
      [inserted].UserAlias,
      dbo.CalculateUserUnsubscribeKey([inserted].UserEmail, default),
      [inserted].UserEnabled
    FROM [inserted];
GO

GO
PRINT 'Should automatically calculate unsubscribe key on insert'
INSERT INTO [Users] (UserEmail, UserAlias) VALUES ('test@email.com', 'OnInsertUser Test');

DECLARE @UserUnsubscribeKey CHAR(64) = (
  SELECT UserUnsubscribeKey FROM [Users] WHERE UserEmail = 'test@email.com'
);
SELECT * FROM [Users];
SELECT UserUnsubscribeKey FROM [Users] WHERE UserEmail = 'test@email.com'
IF @UserUnsubscribeKey IS NULL BEGIN
  DECLARE @NullErrMsg VARCHAR(255) = 'Got null value';
  THROW 1337000, @NullErrMsg, 1;
END;

DECLARE @ExpectedKey CHAR(64) = 'C225D313CEF76524E21E12187A9D86544A31CB16045B7A37E6A1AFAA294D512A';
IF NOT (@UserUnsubscribeKey = @ExpectedKey) BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected ' + @ExpectedKey + ', got ' + @UserUnsubscribeKey;
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Clean up';
DELETE [Users] WHERE UserEmail = 'test@email.com';
