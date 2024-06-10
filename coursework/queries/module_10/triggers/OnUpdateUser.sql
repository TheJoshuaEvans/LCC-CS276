USE [RealTimeWW2];

-- REQUIRES
-- functions/CalculateUserUnsubscribeKey.sql

/*
  Replacement trigger that fires when updating users. This trigger will automatically generate
  the `UserUnsubscribeKey` value for the item
*/
DROP TRIGGER IF EXISTS [OnUpdateUser];
GO
CREATE TRIGGER [OnUpdateUser] ON [Users] INSTEAD OF UPDATE AS
  UPDATE [Users] SET
    UserEmail = [inserted].UserEmail,
    UserAlias = [inserted].UserAlias,
    UserUnsubscribeKey = dbo.CalculateUserUnsubscribeKey([inserted].UserEmail, default),
    UserEnabled = [inserted].UserEnabled
  FROM [Users] JOIN [inserted]
  ON [Users].UserId = [inserted].UserId
GO

GO
PRINT 'Should automatically calculate unsubscribe key on update'
INSERT INTO [Users] (UserEmail, UserAlias, UserUnsubscribeKey) VALUES
  ('onUpdateUser@email.com', 'OnUpdateUser Test', 'val');
UPDATE [Users] SET UserEmail = 'test@email.com' WHERE UserEmail = 'onUpdateUser@email.com';

DECLARE @UserUnsubscribeKey CHAR(64) = (
  SELECT UserUnsubscribeKey FROM [Users] WHERE UserEmail = 'test@email.com'
);
DECLARE @ExpectedKey CHAR(64) = 'C225D313CEF76524E21E12187A9D86544A31CB16045B7A37E6A1AFAA294D512A';
IF NOT (@UserUnsubscribeKey = @ExpectedKey) BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected ' + @ExpectedKey + ', got ' + @UserUnsubscribeKey;
  THROW 1337000, @Msg, 1;
END;

GO
PRINT 'Clean up';
DELETE [Users] WHERE UserEmail = 'onUpdateUser@email.com';
DELETE [Users] WHERE UserEmail = 'test@email.com';
