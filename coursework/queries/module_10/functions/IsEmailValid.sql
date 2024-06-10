USE [RealTimeWW2];

-- NOTE: This function is used for CHECK constraints in the database, so it is defined in the
--       main `FinalProjectDb.sql` file. This constraint is also tested here

GO
PRINT 'Should pass a valid email address';
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('valid@email.com');
IF NOT (@IsEmailValidResult = 'TRUE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "valid@email.com" to be valid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should pass a valid email address with dots before the @';
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('still.a.valid@email.com');
IF NOT (@IsEmailValidResult = 'TRUE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "still.a.valid@email.com" to be valid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should reject an empty address'
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('');
IF NOT (@IsEmailValidResult = 'FALSE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "" to be invalid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should reject an email address with nothing before the @ symbol'
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('@email.com');
IF NOT (@IsEmailValidResult = 'FALSE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "@email.com" to be invalid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should reject an email address with no @ symbol'
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('invalidEmail.com');
IF NOT (@IsEmailValidResult = 'FALSE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "invalidEmail.com" to be invalid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should reject an email address with nothing after the @ symbol'
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('invalid@');
IF NOT (@IsEmailValidResult = 'FALSE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "invalid@" to be invalid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should reject an email address with no dot'
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('invalid@emailCom');
IF NOT (@IsEmailValidResult = 'FALSE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "invalid@emailCom" to be invalid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should reject an email address with no dot after the @'
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('still.invalid@emailCom');
IF NOT (@IsEmailValidResult = 'FALSE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "still.invalid@emailCom" to be invalid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should reject an email address with nothing after the dot'
DECLARE @IsEmailValidResult BIT = dbo.IsEmailValid('invalid@email.');
IF NOT (@IsEmailValidResult = 'FALSE') BEGIN
  DECLARE @Msg VARCHAR(255) =
    'Expected email "invalid@email." to be invalid';
  THROW 1337002, @Msg, 1;
END;

GO
PRINT 'Should not be able to create a blocked user with an invalid email'
DECLARE @InvalidEmail VARCHAR(320) = 'invalidEmail.com';
BEGIN TRY
  INSERT INTO [BlockedUsers] VALUES ('invalidEmail.com');
  THROW 1337002, 'Should have thrown an error', 1;
END TRY BEGIN CATCH
  IF NOT (ERROR_NUMBER() = 547) BEGIN
    DECLARE @Msg VARCHAR(255) =
      'Expected error number 547. Got error number ' + CAST(ERROR_NUMBER() AS VARCHAR(255));
    THROW 1337002, @Msg, 1;
  END; 
END CATCH

GO
PRINT 'Should not be able to create a user with an invalid email'
DECLARE @InvalidEmail VARCHAR(320) = 'invalidEmail.com';
BEGIN TRY
  INSERT INTO [Users] (UserEmail, UserAlias, UserUnsubscribeKey) VALUES
    ('invalidEmail.com', 'Invalid User', 'exampleUnsubscribeKey1');
  THROW 1337002, 'Should have thrown an error', 1;
END TRY BEGIN CATCH
  IF NOT (ERROR_NUMBER() = 547) BEGIN
    DECLARE @Msg VARCHAR(255) =
      'Expected error number 547. Got error number ' + CAST(ERROR_NUMBER() AS VARCHAR(255));
    THROW 1337002, @Msg, 1;
  END; 
END CATCH

GO
PRINT 'Clean up';
DELETE [BlockedUsers] WHERE BlockedUserEmail = 'invalidEmail.com';
DELETE [Users] WHERE UserEmail = 'invalidEmail.com';
