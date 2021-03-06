USE [MoCSRefactor]
GO
/****** Object:  Table [dbo].[Tournament]    Script Date: 01/29/2010 21:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tournament](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Tournament] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Team]    Script Date: 01/29/2010 21:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](50) NOT NULL,
	[Members] [nvarchar](500) NULL,
	[IsAdmin] [bit] NOT NULL,
	[Score] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Assignment]    Script Date: 01/29/2010 21:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Assignment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[FriendlyName] [nvarchar](100) NULL,
	[Tagline] [nvarchar](100) NULL,
	[Path] [nvarchar](500) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Assignment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TournamentAssignment]    Script Date: 01/29/2010 21:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentAssignment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AssignmentOrder] [int] NOT NULL,
	[Points1] [int] NOT NULL,
	[Points2] [int] NOT NULL,
	[Points3] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[TournamentId] [int] NOT NULL,
	[AssignmentId] [int] NOT NULL,
 CONSTRAINT [PK_TournamentAssignment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssignmentEnrollment]    Script Date: 01/29/2010 21:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssignmentEnrollment](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsActive] [bit] NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[TournamentAssignmentId] [int] NOT NULL,
	[TeamId] [int] NOT NULL,
 CONSTRAINT [PK_AssignmentEnrollment] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Submit]    Script Date: 01/29/2010 21:11:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Submit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[SubmitDate] [datetime] NOT NULL,
	[SecondsSinceEnrollment] [bigint] NOT NULL,
	[IsProcessed] [bit] NOT NULL,
	[ProcessingDetails] [nvarchar](4000) NOT NULL,
	[FileName] [nvarchar](100) NOT NULL,
	[FileContents] [nvarchar](4000) NOT NULL,
	[Data] [varbinary](max) NOT NULL,
	[TeamId] [int] NOT NULL,
	[AssignmentEnrollmentId] [int] NOT NULL,
	[TournamentAssignmentId] [int] NOT NULL,
 CONSTRAINT [PK_Submit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  ForeignKey [FK_TournamentAssignment_Assignment]    Script Date: 01/29/2010 21:11:56 ******/
ALTER TABLE [dbo].[TournamentAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TournamentAssignment_Assignment] FOREIGN KEY([AssignmentId])
REFERENCES [dbo].[Assignment] ([Id])
GO
ALTER TABLE [dbo].[TournamentAssignment] CHECK CONSTRAINT [FK_TournamentAssignment_Assignment]
GO
/****** Object:  ForeignKey [FK_TournamentAssignment_Tournament]    Script Date: 01/29/2010 21:11:56 ******/
ALTER TABLE [dbo].[TournamentAssignment]  WITH CHECK ADD  CONSTRAINT [FK_TournamentAssignment_Tournament] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournament] ([Id])
GO
ALTER TABLE [dbo].[TournamentAssignment] CHECK CONSTRAINT [FK_TournamentAssignment_Tournament]
GO
/****** Object:  ForeignKey [FK_AssignmentEnrollment_Team]    Script Date: 01/29/2010 21:11:56 ******/
ALTER TABLE [dbo].[AssignmentEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_AssignmentEnrollment_Team] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[AssignmentEnrollment] CHECK CONSTRAINT [FK_AssignmentEnrollment_Team]
GO
/****** Object:  ForeignKey [FK_AssignmentEnrollment_TournamentAssignment]    Script Date: 01/29/2010 21:11:56 ******/
ALTER TABLE [dbo].[AssignmentEnrollment]  WITH CHECK ADD  CONSTRAINT [FK_AssignmentEnrollment_TournamentAssignment] FOREIGN KEY([TournamentAssignmentId])
REFERENCES [dbo].[TournamentAssignment] ([Id])
GO
ALTER TABLE [dbo].[AssignmentEnrollment] CHECK CONSTRAINT [FK_AssignmentEnrollment_TournamentAssignment]
GO
/****** Object:  ForeignKey [FK_Submit_AssignmentEnrollment]    Script Date: 01/29/2010 21:11:56 ******/
ALTER TABLE [dbo].[Submit]  WITH CHECK ADD  CONSTRAINT [FK_Submit_AssignmentEnrollment] FOREIGN KEY([AssignmentEnrollmentId])
REFERENCES [dbo].[AssignmentEnrollment] ([Id])
GO
ALTER TABLE [dbo].[Submit] CHECK CONSTRAINT [FK_Submit_AssignmentEnrollment]
GO
/****** Object:  ForeignKey [FK_Submit_Team]    Script Date: 01/29/2010 21:11:56 ******/
ALTER TABLE [dbo].[Submit]  WITH CHECK ADD  CONSTRAINT [FK_Submit_Team] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Team] ([Id])
GO
ALTER TABLE [dbo].[Submit] CHECK CONSTRAINT [FK_Submit_Team]
GO
/****** Object:  ForeignKey [FK_Submit_TournamentAssignment]    Script Date: 01/29/2010 21:11:56 ******/
ALTER TABLE [dbo].[Submit]  WITH CHECK ADD  CONSTRAINT [FK_Submit_TournamentAssignment] FOREIGN KEY([TournamentAssignmentId])
REFERENCES [dbo].[TournamentAssignment] ([Id])
GO
ALTER TABLE [dbo].[Submit] CHECK CONSTRAINT [FK_Submit_TournamentAssignment]
GO
