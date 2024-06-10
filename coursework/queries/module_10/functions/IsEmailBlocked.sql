USE [RealTimeWW2];

-- NOTE: This function is used for CHECK constraints in the database, so it is defined in the
--       main `FinalProjectDb.sql` file. This constraint is also tested here

GO
PRINT 'Should return 0 for unblocked email';
DECLARE @IsEmailBlockedResult INT = dbo.IsEmailBlocked('unblocked@email.com');
IF NOT (@IsEmailBlockedResult = 0) BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected 0, got ' + CAST(@IsEmailBlockedResult AS VARCHAR(255));
  THROW 1337001, @Msg, 1;
END;

GO
PRINT 'Should return 1 for blocked email';
DECLARE @BlockedEmail VARCHAR(320) = 'blocked@email.com';
INSERT INTO [BlockedUsers] VALUES (@BlockedEmail);
DECLARE @IsEmailBlockedResult INT = dbo.IsEmailBlocked(@BlockedEmail);
IF NOT (@IsEmailBlockedResult = 1) BEGIN
  DECLARE @Msg VARCHAR(255) = 'Expected 1, got ' + CAST(@IsEmailBlockedResult AS VARCHAR(255));
  THROW 1337001, @Msg, 1;
END;

GO
PRINT 'Should not be able to create user with a blocked email'
DECLARE @BlockedEmail VARCHAR(320) = 'blocked@email.com';
BEGIN TRY
  INSERT INTO [Users] (UserEmail, UserAlias, UserUnsubscribeKey) VALUES
    ('blocked@email.com', 'Blocked User', 'exampleUnsubscribeKey1');
  THROW 1337001, 'Should have thrown an error', 1;
END TRY BEGIN CATCH
  IF NOT (ERROR_NUMBER() = 547) BEGIN
    DECLARE @Msg VARCHAR(255) =
      'Expected error number 547. Got error number ' + CAST(ERROR_NUMBER() AS VARCHAR(255));
    THROW 1337001, @Msg, 1;
  END; 
END CATCH

GO
PRINT 'Clean up';
DELETE [BlockedUsers] WHERE BlockedUserEmail = 'blocked@email.com';
DELETE [Users] WHERE UserEmail = 'blocked@email.com';
