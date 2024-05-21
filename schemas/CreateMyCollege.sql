USE master

CREATE DATABASE MyCollege

GO

Use MyCollege

GO

CREATE TABLE [dbo].[Courses](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[CourseNumber] [int] NULL,
	[CourseDescription] [varchar](50) NOT NULL,
	[CourseUnits] [int] NOT NULL,
	[DepartmentID] [int] NOT NULL,
	[InstructorID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


CREATE TABLE [dbo].[Departments](
	[DepartmentID] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](40) NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Instructors](
	[InstructorID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](25) NOT NULL,
	[FirstName] [varchar](25) NULL,
	[Status] [char](1) NOT NULL,
	[DepartmentChairman] [bit] NOT NULL,
	[HireDate] [date] NULL,
	[AnnualSalary] [money] NOT NULL,
	[DepartmentID] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InstructorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[StudentCourses](
	[StudentID] [int] NOT NULL,
	[CourseID] [int] NOT NULL
) ON [PRIMARY]


CREATE TABLE [dbo].[Students](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](25) NOT NULL,
	[FirstName] [varchar](25) NOT NULL,
	[EnrollmentDate] [datetime2](0) NOT NULL,
	[GraduationDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

CREATE TABLE [dbo].[Tuition](
	[PartTimeCost] [smallmoney] NOT NULL,
	[FullTimeCost] [smallmoney] NOT NULL,
	[PerUnitCost] [smallmoney] NOT NULL
) ON [PRIMARY]

SET IDENTITY_INSERT [dbo].[Courses] ON 

INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (1, 36598, N'Beginning Accounting', 3, 1, 1)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (2, 48926, N'Abstract Algebra', 3, 4, 5)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (3, 14862, N'Primary Education', 3, 2, 8)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (4, 54321, N'Anatomy', 3, 6, 16)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (5, 82754, N'Social Psychology', 3, 7, 9)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (6, 13524, N'Statistical Analysis', 3, 1, 11)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (7, 24653, N'Intro to Marketing', 3, 1, 4)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (8, 22679, N'Intro to Calculus', 3, 4, 5)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (9, 98765, N'Intermediate Accounting', 3, 1, 1)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (10, 96032, N'Social Media', 3, 1, 4)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (11, 58230, N'Physiology', 3, 6, 16)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (12, 81256, N'Intro to Management', 3, 1, 7)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (13, 64321, N'Secondary Education', 3, 2, 8)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (14, 32751, N'Business Writing', 2, 1, 10)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (15, 46972, N'Biology', 4, 6, 3)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (16, 15487, N'Music Theory', 3, 5, 12)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (17, 28177, N'Classic Literature', 3, 3, 15)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (18, 90908, N'Educational Theory', 3, 2, 13)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (19, 55783, N'Shakespeare', 3, 3, 15)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (20, 63284, N'Population and Demographics', 3, 7, 9)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (21, 74832, N'Creative Writing', 3, 3, 2)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (22, 33218, N'Marching Band', 2, 5, 12)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (23, 37645, N'Composition', 3, 3, 10)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (24, 84937, N'Microbiology', 4, 6, 3)
INSERT [dbo].[Courses] ([CourseID], [CourseNumber], [CourseDescription], [CourseUnits], [DepartmentID], [InstructorID]) VALUES (25, 44386, N'Trigonometry', 3, 4, 14)

SET IDENTITY_INSERT [dbo].[Courses] OFF
SET IDENTITY_INSERT [dbo].[Departments] ON 

INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName]) VALUES (1, N'Business')
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName]) VALUES (2, N'Education')
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName]) VALUES (3, N'English')
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName]) VALUES (4, N'Mathematics')
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName]) VALUES (5, N'Music')
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName]) VALUES (8, N'Political Science')
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName]) VALUES (6, N'Science')
INSERT [dbo].[Departments] ([DepartmentID], [DepartmentName]) VALUES (7, N'Sociology')

SET IDENTITY_INSERT [dbo].[Departments] OFF
SET IDENTITY_INSERT [dbo].[Instructors] ON 

INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (1, N'Brown', N'Billy', N'F', 1, CAST(N'2016-01-10' AS Date), 77500.0000, 1)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (2, N'Thomas', N'William', N'P', 0, CAST(N'2016-03-30' AS Date), 38500.0000, 3)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (3, N'Amundsen', N'Rachel', N'F', 1, CAST(N'2016-06-05' AS Date), 79000.0000, 6)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (4, N'Green', N'Gene', N'F', 0, CAST(N'2016-08-02' AS Date), 75000.0000, 1)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (5, N'McGregor', NULL, N'F', 1, CAST(N'2017-01-03' AS Date), 74000.0000, 4)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (6, N'Paxton', N'Arnold', N'P', 0, CAST(N'2017-07-15' AS Date), 36000.0000, 5)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (7, N'Rogers', NULL, N'P', 0, CAST(N'2017-10-22' AS Date), 38000.0000, 1)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (8, N'Smith', N'John', N'F', 1, CAST(N'2018-02-05' AS Date), 73000.0000, 2)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (9, N'Connors', N'Daniel', N'F', 1, CAST(N'2018-03-04' AS Date), 71500.0000, 7)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (10, N'Jones', N'Sally', N'F', 1, CAST(N'2018-09-21' AS Date), 74000.0000, 3)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (11, N'Vilma', N'Jonathan', N'P', 0, CAST(N'2018-11-18' AS Date), 35500.0000, 1)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (12, N'Thomas', N'Derrick', N'P', 0, CAST(N'2019-01-17' AS Date), 35500.0000, 5)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (13, N'Black', N'Bill', N'P', 0, CAST(N'2019-04-20' AS Date), 34000.0000, 2)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (14, N'Warren', N'Angela', N'P', 0, CAST(N'2019-07-14' AS Date), 33000.0000, 4)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (15, N'Drew', N'Daniel', N'F', 0, CAST(N'2019-08-25' AS Date), 72000.0000, 3)
INSERT [dbo].[Instructors] ([InstructorID], [LastName], [FirstName], [Status], [DepartmentChairman], [HireDate], [AnnualSalary], [DepartmentID]) VALUES (16, N'Gallegos', N'Tomas', N'F', 0, CAST(N'2020-03-23' AS Date), 64000.0000, 6)

SET IDENTITY_INSERT [dbo].[Instructors] OFF

INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (5, 10)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (5, 12)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (5, 15)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (5, 21)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (8, 1)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (8, 7)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (8, 19)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (9, 6)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (9, 8)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (9, 10)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (10, 2)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (10, 24)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (11, 7)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (11, 13)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (11, 14)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (13, 1)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (13, 7)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (13, 12)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (15, 6)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (15, 8)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (15, 15)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (16, 2)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (16, 24)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (17, 7)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (17, 14)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (17, 25)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (18, 1)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (18, 12)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (18, 25)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (19, 3)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (19, 11)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (19, 17)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (20, 4)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (20, 16)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (21, 7)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (21, 12)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (21, 14)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (21, 22)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (22, 8)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (22, 10)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (22, 14)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (24, 5)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (24, 25)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (25, 8)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (25, 19)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (25, 24)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (26, 4)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (26, 9)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (26, 20)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (27, 6)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (27, 12)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (27, 13)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (28, 5)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (28, 13)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (28, 19)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (29, 9)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (29, 17)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (29, 25)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (30, 7)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (30, 10)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (30, 12)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (30, 16)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (31, 6)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (31, 20)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (32, 4)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (32, 8)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (32, 23)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (33, 19)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (33, 21)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (34, 9)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (34, 13)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (34, 21)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (35, 5)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (35, 11)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (35, 17)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (36, 6)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (36, 20)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (37, 1)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (37, 7)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (37, 12)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (37, 23)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (38, 3)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (38, 5)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (38, 16)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (39, 6)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (39, 9)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (39, 14)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (40, 16)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (40, 22)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (41, 2)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (41, 13)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (41, 17)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (42, 4)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (42, 11)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (42, 20)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (42, 25)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (43, 4)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (43, 12)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (43, 17)
INSERT [dbo].[StudentCourses] ([StudentID], [CourseID]) VALUES (43, 21)
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (1, N'Howard', N'Amber', CAST(N'2015-12-18T16:44:26.0000000' AS DateTime2), CAST(N'2019-12-14' AS Date))
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (2, N'White', N'George', CAST(N'2015-12-20T11:12:26.0000000' AS DateTime2), CAST(N'2019-12-14' AS Date))
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (3, N'MacNamara', N'Tony', CAST(N'2015-12-21T09:21:55.0000000' AS DateTime2), CAST(N'2019-05-07' AS Date))
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (4, N'Welch', N'Jonathan', CAST(N'2015-12-21T13:23:10.0000000' AS DateTime2), CAST(N'2019-12-14' AS Date))
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (5, N'Taylor', N'Donna', CAST(N'2015-12-28T10:32:16.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (6, N'Price', N'Rose', CAST(N'2016-01-02T12:37:31.0000000' AS DateTime2), CAST(N'2019-12-14' AS Date))
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (7, N'Rodriguez', N'Jesse', CAST(N'2016-01-03T13:08:37.0000000' AS DateTime2), CAST(N'2019-05-07' AS Date))
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (8, N'Williams', N'Bonnie', CAST(N'2016-01-03T15:44:56.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (9, N'Kent', N'Thomas', CAST(N'2016-07-15T11:14:23.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (10, N'Kramer', N'Maggie', CAST(N'2016-07-15T17:02:45.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (11, N'DeLorean', N'Cameron', CAST(N'2016-07-18T12:48:43.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (12, N'Sanchez', N'Frank', CAST(N'2016-07-20T09:37:53.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (13, N'Smith', N'Roberta', CAST(N'2016-07-22T11:18:25.0000000' AS DateTime2), CAST(N'2019-12-14' AS Date))
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (14, N'Hoffman', N'Wilma', CAST(N'2016-12-10T15:31:28.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (15, N'Bonwell', N'Brian', CAST(N'2016-12-12T14:22:53.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (16, N'Clement', N'Cal', CAST(N'2016-12-14T16:42:11.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (17, N'Patrick', N'Charles', CAST(N'2016-12-22T08:43:48.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (18, N'Landry', N'William', CAST(N'2017-01-02T11:28:49.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (19, N'Morrisey', N'Monica', CAST(N'2017-01-04T10:42:06.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (20, N'Butler', N'George', CAST(N'2017-07-12T13:05:41.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (21, N'Yount', N'Anderson', CAST(N'2017-07-18T14:21:07.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (22, N'Rincon', N'Anthony', CAST(N'2017-12-08T09:55:15.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (23, N'Hallowell', N'Jimmy', CAST(N'2017-12-19T13:44:25.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (24, N'Flores', N'Jesus', CAST(N'2018-01-03T16:23:47.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (25, N'Camden', N'James', CAST(N'2018-01-04T11:12:31.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (26, N'Easton', N'Barney', CAST(N'2018-01-04T14:14:02.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (27, N'Sommers', N'Tanya', CAST(N'2018-07-22T15:41:12.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (28, N'Jones', N'Andrew', CAST(N'2018-07-24T10:53:26.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (29, N'Jackson', N'Floyd', CAST(N'2018-07-25T09:27:53.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (30, N'Geary', N'Annette', CAST(N'2018-07-12T09:33:47.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (31, N'Osborne', N'Letitia', CAST(N'2018-12-12T17:14:22.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (32, N'Manning', N'Vincent', CAST(N'2018-12-14T15:37:43.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (33, N'Goodell', N'Conner', CAST(N'2019-01-02T14:21:58.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (34, N'Griffin', N'Gerald', CAST(N'2019-01-02T16:04:04.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (35, N'Gardner', N'Faye', CAST(N'2019-07-22T08:15:57.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (36, N'Franks', N'Karen', CAST(N'2019-07-23T10:42:03.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (37, N'Johnson', N'Timothy', CAST(N'2019-08-04T09:01:04.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (38, N'Walker', N'Andrew', CAST(N'2019-08-05T13:48:26.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (39, N'Cramsden', N'Walter', CAST(N'2019-12-15T10:18:37.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (40, N'Lisle', N'Lisa', CAST(N'2019-12-17T11:42:28.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (41, N'George', N'Mona', CAST(N'2019-12-22T15:29:44.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (42, N'Silver', N'Stanley', CAST(N'2020-01-04T11:16:19.0000000' AS DateTime2), NULL)
INSERT [dbo].[Students] ([StudentID], [LastName], [FirstName], [EnrollmentDate], [GraduationDate]) VALUES (43, N'Biden', N'Jonas', CAST(N'2020-01-05T13:47:21.0000000' AS DateTime2), NULL)
SET IDENTITY_INSERT [dbo].[Students] OFF

INSERT [dbo].[Tuition] ([PartTimeCost], [FullTimeCost], [PerUnitCost]) VALUES (750.0000, 1250.0000, 62.5000)

