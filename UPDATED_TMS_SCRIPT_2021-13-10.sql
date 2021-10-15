USE [TASK_MANAGEMENTDB]
GO
/****** Object:  StoredProcedure [dbo].[TASK_SP_WORKFLOW_SEARCH_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[TASK_SP_WORKFLOW_SEARCH_CRUD]
GO
/****** Object:  StoredProcedure [dbo].[Task_SP_TaskWorkFlow_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[Task_SP_TaskWorkFlow_CRUD]
GO
/****** Object:  StoredProcedure [dbo].[TASK_SP_TASKQUEUE_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[TASK_SP_TASKQUEUE_CRUD]
GO
/****** Object:  StoredProcedure [dbo].[Task_SP_TaskActivity_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[Task_SP_TaskActivity_CRUD]
GO
/****** Object:  StoredProcedure [dbo].[TASK_SP_JSON_METADATA_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[TASK_SP_JSON_METADATA_CRUD]
GO
/****** Object:  StoredProcedure [dbo].[Task_SP_Insert_ExceptionLog]    Script Date: 13-10-2021 17:13:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[Task_SP_Insert_ExceptionLog]
GO
/****** Object:  StoredProcedure [dbo].[Task_SP_GET_UNASSIGNED_TASK_LIST]    Script Date: 13-10-2021 17:13:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[Task_SP_GET_UNASSIGNED_TASK_LIST]
GO
/****** Object:  StoredProcedure [dbo].[TASK_SP_ESCALATION]    Script Date: 13-10-2021 17:13:50 ******/
DROP PROCEDURE IF EXISTS [dbo].[TASK_SP_ESCALATION]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Task_Workflow]') AND type in (N'U'))
ALTER TABLE [dbo].[Task_Workflow] DROP CONSTRAINT IF EXISTS [FK_Task_Workflow_SupportCodeList2]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Task_Workflow]') AND type in (N'U'))
ALTER TABLE [dbo].[Task_Workflow] DROP CONSTRAINT IF EXISTS [FK_Task_Workflow_SupportCodeList1]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Task_Workflow]') AND type in (N'U'))
ALTER TABLE [dbo].[Task_Workflow] DROP CONSTRAINT IF EXISTS [FK_Task_Workflow_SupportCodeList]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Task_QueueUserRoleAssignment]') AND type in (N'U'))
ALTER TABLE [dbo].[Task_QueueUserRoleAssignment] DROP CONSTRAINT IF EXISTS [FK_Task_QueueUserRoleAssignment_Task_Queue]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Task_Activity]') AND type in (N'U'))
ALTER TABLE [dbo].[Task_Activity] DROP CONSTRAINT IF EXISTS [FK_TaskActivity_Task_Esc]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Task_Activity]') AND type in (N'U'))
ALTER TABLE [dbo].[Task_Activity] DROP CONSTRAINT IF EXISTS [FK_Task_Activity_Task_Workflow]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Task_Activity]') AND type in (N'U'))
ALTER TABLE [dbo].[Task_Activity] DROP CONSTRAINT IF EXISTS [FK_Task_Activity_SupportCodeList]
GO
/****** Object:  Index [FK_UNIQUE_CODETYPE]    Script Date: 13-10-2021 17:13:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SupportCodeList]') AND type in (N'U'))
ALTER TABLE [dbo].[SupportCodeList] DROP CONSTRAINT IF EXISTS [FK_UNIQUE_CODETYPE]
GO
/****** Object:  Table [dbo].[Task_Workflow_Search]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_Workflow_Search]
GO
/****** Object:  Table [dbo].[Task_Workflow]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_Workflow]
GO
/****** Object:  Table [dbo].[Task_QueueUserRoleAssignment]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_QueueUserRoleAssignment]
GO
/****** Object:  Table [dbo].[Task_Queue]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_Queue]
GO
/****** Object:  Table [dbo].[Task_ExceptionLog]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_ExceptionLog]
GO
/****** Object:  Table [dbo].[Task_Escalation]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_Escalation]
GO
/****** Object:  Table [dbo].[Task_Config]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_Config]
GO
/****** Object:  Table [dbo].[Task_Activity_Note]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_Activity_Note]
GO
/****** Object:  Table [dbo].[Task_Activity]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[Task_Activity]
GO
/****** Object:  Table [dbo].[SupportCodeList]    Script Date: 13-10-2021 17:13:50 ******/
DROP TABLE IF EXISTS [dbo].[SupportCodeList]
GO
/****** Object:  Table [dbo].[SupportCodeList]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupportCodeList](
	[CODE] [bigint] NOT NULL,
	[CODETYPE] [varchar](50) NOT NULL,
	[DESCRIPTION] [varchar](100) NULL,
	[SORTSEQUENCE] [int] NULL,
	[DELETED] [bit] NOT NULL,
 CONSTRAINT [PK_SupportCodeList] PRIMARY KEY CLUSTERED 
(
	[CODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_Activity]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_Activity](
	[ACTIVITY_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TASK_ID] [bigint] NOT NULL,
	[MESSAGE] [nvarchar](max) NULL,
	[NOTE] [nvarchar](max) NULL,
	[USER_ID] [nvarchar](128) NULL,
	[ACTIVITY_DT_TIME] [datetime] NULL,
	[DUE_DT] [datetime] NULL,
	[TIMEFRAME] [int] NOT NULL,
	[TASKSTATUSCODE] [bigint] NOT NULL,
	[ESCALATION_UID] [bigint] NOT NULL,
	[ESCALATIONSTAGE] [int] NOT NULL,
 CONSTRAINT [PK_Task_Activity] PRIMARY KEY CLUSTERED 
(
	[ACTIVITY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_Activity_Note]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_Activity_Note](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TASKACTIVITY_ID] [bigint] NOT NULL,
	[DESCRIPTION] [nvarchar](4000) NULL,
 CONSTRAINT [PK_Task_Activity_Node] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_Config]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_Config](
	[ID] [tinyint] NOT NULL,
	[WAITTIMEFRAMEINMIN] [int] NULL,
	[WAITTIMEGAPINSEC] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_Escalation]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_Escalation](
	[ESCALATION_UID] [bigint] IDENTITY(1,1) NOT NULL,
	[ESCALATIONSTAGE] [int] NOT NULL,
	[ESCALATIONTITLE] [nvarchar](200) NOT NULL,
	[DESCRIPTION] [nvarchar](400) NULL,
	[PRIMARYEMAIL] [nvarchar](200) NOT NULL,
	[CCEMAILS] [nvarchar](400) NULL,
	[CREATE_TS] [datetime] NULL,
	[CREATEDBY] [nvarchar](40) NULL,
	[MODIFY_TS] [datetime] NULL,
	[MODIFIEDBY] [nvarchar](40) NULL,
	[ISACTIVE] [bit] NULL,
 CONSTRAINT [PK_Task_Escalation] PRIMARY KEY CLUSTERED 
(
	[ESCALATION_UID] ASC,
	[ESCALATIONSTAGE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_ExceptionLog]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_ExceptionLog](
	[ExceptionLogUID] [bigint] IDENTITY(1,1) NOT NULL,
	[ErrorNumber] [int] NOT NULL,
	[ErrorState] [int] NOT NULL,
	[ErrorSeverity] [int] NOT NULL,
	[ErrorLine] [int] NOT NULL,
	[ErrorProcedure] [nvarchar](100) NOT NULL,
	[ErrorMessage] [xml] NOT NULL,
	[TaskManagementUID] [bigint] NOT NULL,
 CONSTRAINT [PK_Task_ExceptionLog] PRIMARY KEY CLUSTERED 
(
	[ExceptionLogUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_Queue]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_Queue](
	[ENTITY_ID] [bigint] NOT NULL,
	[TITLE] [nvarchar](50) NULL,
	[TASKDESCRIPTION] [nvarchar](100) NULL,
	[CREATE_TS] [datetime] NULL,
	[CREATEDBY] [nvarchar](50) NULL,
	[MODIFY_TS] [datetime] NULL,
	[MODIFIEDBY] [nvarchar](50) NULL,
	[ISACTIVE] [bit] NULL,
 CONSTRAINT [PK_Task_Queue] PRIMARY KEY CLUSTERED 
(
	[ENTITY_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_QueueUserRoleAssignment]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_QueueUserRoleAssignment](
	[RELATIONSHIP_ID] [bigint] NOT NULL,
	[ENTITY_ID] [bigint] NOT NULL,
	[USER_ID] [nvarchar](128) NULL,
	[ROLE] [nvarchar](50) NULL,
	[CREATE_DT] [datetime] NULL,
	[CREATE_USER_ID] [nvarchar](128) NULL,
	[LAST_UPDATE_USER_ID] [nvarchar](128) NULL,
	[LAST_UPDATE_TS] [datetime] NULL,
	[DELETED] [bit] NULL,
 CONSTRAINT [PK_Task_QueueUserRoleAssignment] PRIMARY KEY CLUSTERED 
(
	[RELATIONSHIP_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_Workflow]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_Workflow](
	[TASK_ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ENTITY_ID] [int] NOT NULL,
	[ASSIGNEDUSER_ID] [nvarchar](128) NULL,
	[TASKTITLE] [nvarchar](100) NULL,
	[TASKDESCRIPTION] [nvarchar](max) NULL,
	[DUE_DT] [datetime] NULL,
	[TASKPRIORITY] [bigint] NOT NULL,
	[TIMEFRAME] [int] NULL,
	[POLICYACTIVITY_ID] [nvarchar](100) NULL,
	[POLICYNUMBER] [nvarchar](50) NULL,
	[TASKTYPECODE] [bigint] NOT NULL,
	[TASKMETADATA] [nvarchar](max) NULL,
	[TASKSTATUSCODE] [bigint] NOT NULL,
	[LOBTYPE] [nvarchar](30) NULL,
	[TASKASSIGNMENTTYPE] [char](1) NULL,
	[CREATE_DT] [datetime] NOT NULL,
	[CREATE_USER_ID] [nvarchar](128) NOT NULL,
	[LAST_UPDATE_USER_ID] [nvarchar](128) NULL,
	[LAST_UPDATE_TS] [datetime] NULL,
	[DELETED] [bit] NULL,
 CONSTRAINT [PK_Task_Workflow] PRIMARY KEY CLUSTERED 
(
	[TASK_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Task_Workflow_Search]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Task_Workflow_Search](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[TASK_ID] [bigint] NOT NULL,
	[TASKSEARCHKEY] [nvarchar](100) NULL,
	[TASKSEARCHVALUE] [nvarchar](100) NULL,
 CONSTRAINT [PK_Task_Workflow_Search] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (1, N'P', N'Pending', 1, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (2, N'C', N'Completed', 4, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (3, N'GEN', N'General', 3, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (4, N'L', N'Low', 1, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (5, N'M', N'Medium', 2, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (6, N'H', N'High', 3, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (7, N'IP', N'In-Progress', 2, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (8, N'OH', N'On-Hold', 3, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (9, N'ESC', N'Escalated', 5, 0)
GO
INSERT [dbo].[SupportCodeList] ([CODE], [CODETYPE], [DESCRIPTION], [SORTSEQUENCE], [DELETED]) VALUES (10, N'A', N'Assigned', 2, 0)
GO
SET IDENTITY_INSERT [dbo].[Task_Activity] ON 
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (1, 65, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:31:15.600' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (2, 66, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:31:27.637' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (3, 67, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:34:57.157' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (4, 68, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:35:14.570' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (5, 69, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:36:38.497' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (6, 70, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:39:10.183' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (7, 71, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:39:58.380' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (8, 72, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:40:13.640' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (9, 73, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:41:02.650' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (10, 74, N'Task Created', NULL, NULL, CAST(N'2021-09-17T14:41:24.950' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (11, 65, N'Task Assigned', NULL, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', CAST(N'2021-09-20T10:50:30.757' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (12, 65, N'Task status changed to In-Progress', N'', N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', CAST(N'2021-09-20T10:51:25.140' AS DateTime), CAST(N'2021-09-20T11:06:25.140' AS DateTime), 15, 7, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (13, 67, N'Task Assigned', NULL, N'106237f9-9918-4415-be6c-ba23bed32a47', CAST(N'2021-09-20T12:08:31.120' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (15, 68, N'Task Assigned', NULL, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', CAST(N'2021-09-20T15:01:24.287' AS DateTime), NULL, 15, 1, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (19, 65, N'Task Escalated', NULL, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', CAST(N'2021-09-20T16:58:49.207' AS DateTime), CAST(N'2021-09-20T11:06:25.140' AS DateTime), 15, 9, 1, 1)
GO
INSERT [dbo].[Task_Activity] ([ACTIVITY_ID], [TASK_ID], [MESSAGE], [NOTE], [USER_ID], [ACTIVITY_DT_TIME], [DUE_DT], [TIMEFRAME], [TASKSTATUSCODE], [ESCALATION_UID], [ESCALATIONSTAGE]) VALUES (20, 77, N'jzcbshivhs', N'0 remark added to bucket', NULL, CAST(N'2021-09-24T00:00:00.000' AS DateTime), CAST(N'2021-09-24T00:00:00.000' AS DateTime), 15, 1, 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Task_Activity] OFF
GO
SET IDENTITY_INSERT [dbo].[Task_Activity_Note] ON 
GO
INSERT [dbo].[Task_Activity_Note] ([ID], [TASKACTIVITY_ID], [DESCRIPTION]) VALUES (2, 106, N'abhddwedilwe')
GO
INSERT [dbo].[Task_Activity_Note] ([ID], [TASKACTIVITY_ID], [DESCRIPTION]) VALUES (3, 107, N'dvkkqufvqfeeqg')
GO
INSERT [dbo].[Task_Activity_Note] ([ID], [TASKACTIVITY_ID], [DESCRIPTION]) VALUES (4, 108, N'jay')
GO
INSERT [dbo].[Task_Activity_Note] ([ID], [TASKACTIVITY_ID], [DESCRIPTION]) VALUES (5, 109, N'jay')
GO
INSERT [dbo].[Task_Activity_Note] ([ID], [TASKACTIVITY_ID], [DESCRIPTION]) VALUES (6, 110, N'hi jay user available')
GO
INSERT [dbo].[Task_Activity_Note] ([ID], [TASKACTIVITY_ID], [DESCRIPTION]) VALUES (7, 111, N'hi jay user available')
GO
INSERT [dbo].[Task_Activity_Note] ([ID], [TASKACTIVITY_ID], [DESCRIPTION]) VALUES (8, 119, N'uygksfugfiewo')
GO
SET IDENTITY_INSERT [dbo].[Task_Activity_Note] OFF
GO
INSERT [dbo].[Task_Config] ([ID], [WAITTIMEFRAMEINMIN], [WAITTIMEGAPINSEC]) VALUES (1, 15, 30)
GO
SET IDENTITY_INSERT [dbo].[Task_Escalation] ON 
GO
INSERT [dbo].[Task_Escalation] ([ESCALATION_UID], [ESCALATIONSTAGE], [ESCALATIONTITLE], [DESCRIPTION], [PRIMARYEMAIL], [CCEMAILS], [CREATE_TS], [CREATEDBY], [MODIFY_TS], [MODIFIEDBY], [ISACTIVE]) VALUES (1, 1, N'Task Escalation', N'Task gone escalated from Underwriter.', N'tapas.mishra@qalibre.in', NULL, CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', NULL, NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[Task_Escalation] OFF
GO
SET IDENTITY_INSERT [dbo].[Task_ExceptionLog] ON 
GO
INSERT [dbo].[Task_ExceptionLog] ([ExceptionLogUID], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [TaskManagementUID]) VALUES (1, 515, 2, 16, 88, N'dbo.Task_SP_TaskWorkFlow_CRUD', N'Cannot insert the value NULL into column ''UserId'', table ''QalibreEMS.dbo.Task_Activity''; column does not allow nulls. INSERT fails.', 0)
GO
INSERT [dbo].[Task_ExceptionLog] ([ExceptionLogUID], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [TaskManagementUID]) VALUES (2, 547, 0, 16, 88, N'dbo.Task_SP_TaskWorkFlow_CRUD', N'The INSERT statement conflicted with the FOREIGN KEY constraint "FK_TaskActivity_Task_Esc". The conflict occurred in database "QalibreEMS", table "dbo.Task_Escalation".', 0)
GO
INSERT [dbo].[Task_ExceptionLog] ([ExceptionLogUID], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [TaskManagementUID]) VALUES (3, 515, 2, 16, 170, N'dbo.Task_SP_TaskWorkFlow_CRUD', N'Cannot insert the value NULL into column ''TaskId'', table ''TASK_MANAGEMENT.dbo.Task_Activity''; column does not allow nulls. INSERT fails.', 0)
GO
INSERT [dbo].[Task_ExceptionLog] ([ExceptionLogUID], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [TaskManagementUID]) VALUES (4, 515, 2, 16, 170, N'dbo.Task_SP_TaskWorkFlow_CRUD', N'Cannot insert the value NULL into column ''TaskId'', table ''TASK_MANAGEMENT.dbo.Task_Activity''; column does not allow nulls. INSERT fails.', 0)
GO
INSERT [dbo].[Task_ExceptionLog] ([ExceptionLogUID], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [TaskManagementUID]) VALUES (5, 515, 2, 16, 170, N'dbo.Task_SP_TaskWorkFlow_CRUD', N'Cannot insert the value NULL into column ''TaskId'', table ''TASK_MANAGEMENT.dbo.Task_Activity''; column does not allow nulls. INSERT fails.', 0)
GO
INSERT [dbo].[Task_ExceptionLog] ([ExceptionLogUID], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [TaskManagementUID]) VALUES (6, 515, 2, 16, 170, N'dbo.Task_SP_TaskWorkFlow_CRUD', N'Cannot insert the value NULL into column ''TaskId'', table ''TASK_MANAGEMENT.dbo.Task_Activity''; column does not allow nulls. INSERT fails.', 0)
GO
INSERT [dbo].[Task_ExceptionLog] ([ExceptionLogUID], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [TaskManagementUID]) VALUES (7, 515, 2, 16, 46, N'dbo.Task_SP_TaskWorkFlow_CRUD', N'Cannot insert the value NULL into column ''CreatedByUserId'', table ''TASK_MANAGEMENT.dbo.Task_Workflow''; column does not allow nulls. INSERT fails.', 0)
GO
INSERT [dbo].[Task_ExceptionLog] ([ExceptionLogUID], [ErrorNumber], [ErrorState], [ErrorSeverity], [ErrorLine], [ErrorProcedure], [ErrorMessage], [TaskManagementUID]) VALUES (8, 515, 2, 16, 46, N'dbo.Task_SP_TaskWorkFlow_CRUD', N'Cannot insert the value NULL into column ''CreatedByUserId'', table ''TASK_MANAGEMENT.dbo.Task_Workflow''; column does not allow nulls. INSERT fails.', 0)
GO
SET IDENTITY_INSERT [dbo].[Task_ExceptionLog] OFF
GO
INSERT [dbo].[Task_Queue] ([ENTITY_ID], [TITLE], [TASKDESCRIPTION], [CREATE_TS], [CREATEDBY], [MODIFY_TS], [MODIFIEDBY], [ISACTIVE]) VALUES (1, N'NBS', N'New Business', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', NULL, NULL, 1)
GO
INSERT [dbo].[Task_Queue] ([ENTITY_ID], [TITLE], [TASKDESCRIPTION], [CREATE_TS], [CREATEDBY], [MODIFY_TS], [MODIFIEDBY], [ISACTIVE]) VALUES (2, N'REN', N'Renewal', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', NULL, NULL, 1)
GO
INSERT [dbo].[Task_Queue] ([ENTITY_ID], [TITLE], [TASKDESCRIPTION], [CREATE_TS], [CREATEDBY], [MODIFY_TS], [MODIFIEDBY], [ISACTIVE]) VALUES (3, N'END', N'Endorsement', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', NULL, NULL, 1)
GO
INSERT [dbo].[Task_QueueUserRoleAssignment] ([RELATIONSHIP_ID], [ENTITY_ID], [USER_ID], [ROLE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (1, 1, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', N'UnderWriter', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', N'', NULL, 0)
GO
INSERT [dbo].[Task_QueueUserRoleAssignment] ([RELATIONSHIP_ID], [ENTITY_ID], [USER_ID], [ROLE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (2, 1, N'106237f9-9918-4415-be6c-ba23bed32a47', N'UnderWriter', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', N'', NULL, 0)
GO
INSERT [dbo].[Task_QueueUserRoleAssignment] ([RELATIONSHIP_ID], [ENTITY_ID], [USER_ID], [ROLE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (3, 2, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', N'UnderWriter', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', N'', NULL, 0)
GO
INSERT [dbo].[Task_QueueUserRoleAssignment] ([RELATIONSHIP_ID], [ENTITY_ID], [USER_ID], [ROLE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (4, 2, N'106237f9-9918-4415-be6c-ba23bed32a47', N'UnderWriter', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', N'', NULL, 0)
GO
INSERT [dbo].[Task_QueueUserRoleAssignment] ([RELATIONSHIP_ID], [ENTITY_ID], [USER_ID], [ROLE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (5, 3, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', N'UnderWriter', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', N'', NULL, 0)
GO
INSERT [dbo].[Task_QueueUserRoleAssignment] ([RELATIONSHIP_ID], [ENTITY_ID], [USER_ID], [ROLE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (6, 3, N'106237f9-9918-4415-be6c-ba23bed32a47', N'UnderWriter', CAST(N'2021-09-01T00:00:00.000' AS DateTime), N'1b6c31ee-130c-4d83-8912-f76c5db3f546', N'', NULL, 0)
GO
SET IDENTITY_INSERT [dbo].[Task_Workflow] ON 
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (65, 1, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', N'Task 1 - NBS Approved application', N'Approved application', CAST(N'2021-09-20T11:06:25.140' AS DateTime), 6, 15, N'CS00000101', N'FPT000001', 3, N'{''PolicyActivityId'':''CS00000101'', ''PolicyNumber'': ''FPT000001''}', 9, N'CSVC', N'A', CAST(N'2021-09-17T14:31:15.600' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', CAST(N'2021-09-20T10:51:25.140' AS DateTime), 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (66, 1, NULL, N'Task 2 - NBS Approved application', N'Approved application', NULL, 5, 15, N'CS00000102', N'FPT000002', 3, N'{''PolicyActivityId'':''CS00000102'', ''PolicyNumber'': ''FPT000002''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:31:27.637' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, NULL, 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (67, 3, N'106237f9-9918-4415-be6c-ba23bed32a47', N'Task 3 - END Submitted endorsments', N'Submitted endorsments', NULL, 6, 15, N'CS00000103', N'FPT000003', 3, N'{''PolicyActivityId'':''CS00000103'', ''PolicyNumber'': ''FPT000003''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:34:57.157' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, NULL, 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (68, 3, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', N'Task 4 - END Submitted endorsments', N'Submitted endorsments', NULL, 6, 15, N'CS00000104', N'FPT000004', 3, N'{''PolicyActivityId'':''CS00000104'', ''PolicyNumber'': ''FPT000004''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:35:14.570' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', N'ec06e317-fd8f-46e0-a0a8-602b15dfee26', CAST(N'2021-09-20T10:48:58.597' AS DateTime), 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (69, 1, NULL, N'Task 5 - NBS Underwriting referal', N'Underwriting referal', NULL, 5, 15, N'CS00000105', N'FPT000005', 3, N'{''PolicyActivityId'':''CS00000105'', ''PolicyNumber'': ''FPT000005''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:36:38.497' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, NULL, 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (70, 1, NULL, N'Task 6 - NBS Underwriting referal', N'Underwriting referal', NULL, 6, 15, N'CS00000106', N'FPT000006', 3, N'{''PolicyActivityId'':''CS00000106'', ''PolicyNumber'': ''FPT000006''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:39:10.183' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, NULL, 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (71, 1, NULL, N'Task 7 - RWL Renewal Quotes', N'Renewal Quotes', NULL, 4, 15, N'CS00000107', N'FPT000007', 3, N'{''PolicyActivityId'':''CS00000107'', ''PolicyNumber'': ''FPT000007''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:39:58.380' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, NULL, 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (72, 1, NULL, N'Task 8 - RWL Renewal Quotes', N'Renewal Quotes', NULL, 4, 15, N'CS00000108', N'FPT000008', 3, N'{''PolicyActivityId'':''CS00000108'', ''PolicyNumber'': ''FPT000008''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:40:13.640' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, NULL, 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (73, 1, NULL, N'Task 9 - RWL Underwriting review', N'Underwriting review', NULL, 5, 15, N'CS00000109', N'FPT000009', 3, N'{''PolicyActivityId'':''CS00000109'', ''PolicyNumber'': ''FPT000009''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:41:02.650' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, NULL, 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (74, 1, NULL, N'Task 10 - RWL Underwriting review', N'Underwriting review', NULL, 6, 15, N'CS00000110', N'FPT000010', 3, N'{''PolicyActivityId'':''CS00000110'', ''PolicyNumber'': ''FPT000010''}', 1, N'CSVC', N'A', CAST(N'2021-09-17T14:41:24.950' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, NULL, 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (77, 1, NULL, N'NewBusiness', N'Task Has been created', CAST(N'2021-09-24T00:00:00.000' AS DateTime), 6, 15, N'CS000001699', N'FPT0000321', 1, N'{"PolicyActivityId":"CS000001699", "PolicyNumber": "FPT0000321"}', 1, N'NBS', N'A', CAST(N'2021-09-24T00:00:00.000' AS DateTime), N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', NULL, CAST(N'2021-09-24T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (83, 1, N'0c3fb559-d81d-4bef-a379-e48fdc96d5bf', N'Task 11-Renewal', N'Task has been escalated', CAST(N'2021-09-24T00:00:00.000' AS DateTime), 1, 15, N'CS00001789', N'FPT0000233', 3, NULL, 7, N'CSVC', N'A', CAST(N'2021-09-24T00:00:00.000' AS DateTime), N'0c3fb557-d81d834658', NULL, CAST(N'2021-09-24T00:00:00.000' AS DateTime), 0)
GO
INSERT [dbo].[Task_Workflow] ([TASK_ID], [ENTITY_ID], [ASSIGNEDUSER_ID], [TASKTITLE], [TASKDESCRIPTION], [DUE_DT], [TASKPRIORITY], [TIMEFRAME], [POLICYACTIVITY_ID], [POLICYNUMBER], [TASKTYPECODE], [TASKMETADATA], [TASKSTATUSCODE], [LOBTYPE], [TASKASSIGNMENTTYPE], [CREATE_DT], [CREATE_USER_ID], [LAST_UPDATE_USER_ID], [LAST_UPDATE_TS], [DELETED]) VALUES (87, 1, N'1239438597kf56', N'Task 12-NewBusiness', N'Task Has been escalated ', CAST(N'2021-09-25T00:00:00.000' AS DateTime), 1, 15, N'CS00002500', N'FPT0000444', 3, NULL, 7, N'TNCF', N'A', CAST(N'2021-09-24T00:00:00.000' AS DateTime), N'0c4b44d56697', N'2021-09-24', CAST(N'2021-09-24T00:00:00.000' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[Task_Workflow] OFF
GO
SET IDENTITY_INSERT [dbo].[Task_Workflow_Search] ON 
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (1, 1, N'f', N'f')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (2, 49, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (3, 49, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (4, 52, N'PolicyActivityId', N'CS900031')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (5, 52, N'PolicyNumber', N'FPT00031')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (6, 53, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (7, 53, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (8, 54, N'PolicyActivityId', N'CS000001691')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (9, 54, N'PolicyNumber', N'FPT0000324')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (10, 55, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (11, 55, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (12, 56, N'PolicyActivityId', N'CS000001693')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (13, 56, N'PolicyNumber', N'FPT0000323')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (14, 123, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (15, 123, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (16, 123, N'TaskStatusCode', N'6')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (17, 123, N'TaskTitle', N'this is jay')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (18, 123, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (19, 123, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (20, 123, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (21, 123, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (22, 123, N'TaskTitle', N'New Business')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (23, 123, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (24, 123, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (25, 123, N'TaskTitle', N'New Business')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (26, 123, N'TaskPriority', N'6')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (27, 123, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (28, 123, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (29, 123, N'TaskTitle', N'New Business')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (30, 123, N'TaskPriority', N'6')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (31, 123, N'TaskStatusCode', N'3')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (32, 123, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (33, 123, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (34, 123, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (35, 123, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (36, 123, N'TaskTitle', N'jay')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (37, 1234, N'PolicyActivityId', N'CS000001699')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (38, 1234, N'PolicyNumber', N'FPT0000321')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (39, 1234, N'TaskTitle', N'jay')
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (40, 67, N'PolicyActivityId', NULL)
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (41, 67, N'PolicyNumber', NULL)
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (42, 1, N'POLICYACTIVITYID', NULL)
GO
INSERT [dbo].[Task_Workflow_Search] ([ID], [TASK_ID], [TASKSEARCHKEY], [TASKSEARCHVALUE]) VALUES (43, 1, N'POLICYNUMBER', NULL)
GO
SET IDENTITY_INSERT [dbo].[Task_Workflow_Search] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [FK_UNIQUE_CODETYPE]    Script Date: 13-10-2021 17:13:50 ******/
ALTER TABLE [dbo].[SupportCodeList] ADD  CONSTRAINT [FK_UNIQUE_CODETYPE] UNIQUE NONCLUSTERED 
(
	[CODETYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Task_Activity]  WITH CHECK ADD  CONSTRAINT [FK_Task_Activity_SupportCodeList] FOREIGN KEY([TASKSTATUSCODE])
REFERENCES [dbo].[SupportCodeList] ([CODE])
GO
ALTER TABLE [dbo].[Task_Activity] CHECK CONSTRAINT [FK_Task_Activity_SupportCodeList]
GO
ALTER TABLE [dbo].[Task_Activity]  WITH CHECK ADD  CONSTRAINT [FK_Task_Activity_Task_Workflow] FOREIGN KEY([TASK_ID])
REFERENCES [dbo].[Task_Workflow] ([TASK_ID])
GO
ALTER TABLE [dbo].[Task_Activity] CHECK CONSTRAINT [FK_Task_Activity_Task_Workflow]
GO
ALTER TABLE [dbo].[Task_Activity]  WITH CHECK ADD  CONSTRAINT [FK_TaskActivity_Task_Esc] FOREIGN KEY([ESCALATION_UID], [ESCALATIONSTAGE])
REFERENCES [dbo].[Task_Escalation] ([ESCALATION_UID], [ESCALATIONSTAGE])
GO
ALTER TABLE [dbo].[Task_Activity] CHECK CONSTRAINT [FK_TaskActivity_Task_Esc]
GO
ALTER TABLE [dbo].[Task_QueueUserRoleAssignment]  WITH CHECK ADD  CONSTRAINT [FK_Task_QueueUserRoleAssignment_Task_Queue] FOREIGN KEY([ENTITY_ID])
REFERENCES [dbo].[Task_Queue] ([ENTITY_ID])
GO
ALTER TABLE [dbo].[Task_QueueUserRoleAssignment] CHECK CONSTRAINT [FK_Task_QueueUserRoleAssignment_Task_Queue]
GO
ALTER TABLE [dbo].[Task_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_Task_Workflow_SupportCodeList] FOREIGN KEY([TASKPRIORITY])
REFERENCES [dbo].[SupportCodeList] ([CODE])
GO
ALTER TABLE [dbo].[Task_Workflow] CHECK CONSTRAINT [FK_Task_Workflow_SupportCodeList]
GO
ALTER TABLE [dbo].[Task_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_Task_Workflow_SupportCodeList1] FOREIGN KEY([TASKSTATUSCODE])
REFERENCES [dbo].[SupportCodeList] ([CODE])
GO
ALTER TABLE [dbo].[Task_Workflow] CHECK CONSTRAINT [FK_Task_Workflow_SupportCodeList1]
GO
ALTER TABLE [dbo].[Task_Workflow]  WITH CHECK ADD  CONSTRAINT [FK_Task_Workflow_SupportCodeList2] FOREIGN KEY([TASKTYPECODE])
REFERENCES [dbo].[SupportCodeList] ([CODE])
GO
ALTER TABLE [dbo].[Task_Workflow] CHECK CONSTRAINT [FK_Task_Workflow_SupportCodeList2]
GO
/****** Object:  StoredProcedure [dbo].[TASK_SP_ESCALATION]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- AUTHOR:		<AUTHOR,JAY>
-- CREATE DATE: <MODIFIED ON,2021-09-20>
-- DESCRIPTION:	<DESCRIPTION,GET ESCALATED TASK LIST>
-- =============================================
CREATE PROCEDURE [dbo].[TASK_SP_ESCALATION]
@ASSIGNEDUSER_ID NVARCHAR(128)  NULL

AS
BEGIN
    DECLARE @ACTIVITYID AS BIGINT  
    DECLARE @ERROR_NUMBER AS INT,
    @ERROR_STATE AS INT,
    @ERROR_SEVERITY AS INT,
    @ERROR_PROCEDURE AS NVARCHAR(100),
    @ERROR_LINE AS INT,
    @ERROR_MESSAGE AS NVARCHAR(4000);
	BEGIN TRY
	--THIS IS FOR RETRIVING ESCALATED DATA
	IF @ASSIGNEDUSER_ID IS NULL 
	SELECT  TASK_ID,
	ENTITY_ID,
	ASSIGNEDUSER_ID,
	TASKTITLE,
	TASKDESCRIPTION,
	DUE_DT ,
	TASKPRIORITY,
	TIMEFRAME,
	TASKTYPECODE ,
	TASKMETADATA,
	TASKSTATUSCODE,
	LOBTYPE ,
	CREATE_DT ,
	CREATE_USER_ID ,
	LAST_UPDATE_USER_ID ,
	LAST_UPDATE_TS,
	TIMEFRAME ,
	POLICYNUMBER ,
	POLICYACTIVITY_ID,
	TASK_WORKFLOW.DELETED,
	CODETYPE,
	TASKASSIGNMENTTYPE FROM TASK_WORKFLOW 
	LEFT OUTER JOIN SUPPORTCODELIST  ON TASK_WORKFLOW.TASKPRIORITY = SUPPORTCODELIST.CODE WHERE (TASKSTATUSCODE =7 AND DUE_DT <= GETDATE())  
	ELSE IF @ASSIGNEDUSER_ID IS NOT NULL
	SELECT  TASK_ID,
	ENTITY_ID,
	ASSIGNEDUSER_ID,
	TASKTITLE,
	TASKDESCRIPTION,
	DUE_DT ,
	TASKPRIORITY,
	TIMEFRAME,
	TASKTYPECODE ,
	TASKMETADATA,
	TASKSTATUSCODE,
	LOBTYPE ,
	CREATE_DT ,
	CREATE_USER_ID ,
	LAST_UPDATE_TS ,
	LAST_UPDATE_TS,
	TIMEFRAME ,
	POLICYNUMBER ,
	POLICYACTIVITY_ID,
	TASK_WORKFLOW.DELETED ,
	CODETYPE ,
	TASKASSIGNMENTTYPE FROM TASK_WORKFLOW 
	LEFT OUTER JOIN SUPPORTCODELIST  ON TASK_WORKFLOW.TASKPRIORITY = SUPPORTCODELIST.CODE WHERE (TASKSTATUSCODE =7 AND DUE_DT <= GETDATE())  AND @ASSIGNEDUSER_ID=ASSIGNEDUSER_ID
    -- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
	-- INTERFERING WITH SELECT STATEMENTS.
SET NOCOUNT ON;
END TRY
BEGIN CATCH
SELECT
    @ERROR_NUMBER = ERROR_NUMBER(),
    @ERROR_STATE = ERROR_STATE(),
    @ERROR_SEVERITY=  ERROR_SEVERITY(),
    @ERROR_PROCEDURE = ERROR_PROCEDURE(),
    @ERROR_LINE = ERROR_LINE(),
    @ERROR_MESSAGE = ERROR_MESSAGE();
                        
    EXECUTE DBO.TASK_SP_INSERT_EXCEPTIONLOG @ERRORNUMBER = @ERROR_NUMBER, @ERRORSTATE = @ERROR_STATE, @ERRORSEVERITY = @ERROR_SEVERITY, @ERRORLINE = @ERROR_LINE, @ERRORPROCEDURE = @ERROR_PROCEDURE, @ERRORMESSAGE = @ERROR_MESSAGE, @TASKMANAGEMENTUID = 0
END CATCH
END
GO
/****** Object:  StoredProcedure [dbo].[Task_SP_GET_UNASSIGNED_TASK_LIST]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Task_SP_GET_UNASSIGNED_TASK_LIST]          

AS
BEGIN
	SET NOCOUNT ON;
	SELECT  TASK_ID,
		ENTITY_ID, 
		ASSIGNEDUSER_ID, 
		TASKTITLE, 
		TASKDESCRIPTION, 
		DUE_DT,
		TASKPRIORITY,
		CODETYPE AS TASKPRIORITYCODE,
		TASKTYPECODE,
		TASKMETADATA, 
		TASKSTATUSCODE,
		LOBTYPE,
		CREATE_DT,
		CREATE_USER_ID,
		LAST_UPDATE_USER_ID,
		LAST_UPDATE_TS,
		TIMEFRAME,
		POLICYNUMBER,
		POLICYACTIVITY_ID,
		TASK_WORKFLOW.DELETED,
		TASKASSIGNMENTTYPE FROM
		TASK_WORKFLOW(NOLOCK) JOIN SUPPORTCODELIST(NOLOCK) ON TASK_WORKFLOW.TASKPRIORITY = SUPPORTCODELIST.CODE 
		WHERE TASK_WORKFLOW.DELETED = 0 AND ASSIGNEDUSER_ID IS NULL ORDER BY SUPPORTCODELIST.SORTSEQUENCE DESC;
END
GO
/****** Object:  StoredProcedure [dbo].[Task_SP_Insert_ExceptionLog]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Task_SP_Insert_ExceptionLog]

	@ErrorNumber int,
	@ErrorState int,
	@ErrorSeverity int,
	@ErrorLine int,
	@ErrorProcedure nvarchar(100),
	@ErrorMessage XML,
	@TaskManagementUID bigint
AS
BEGIN
	Insert into Task_ExceptionLog(
	 ErrorNumber,
	 ErrorState,
	 ErrorSeverity,
	 ErrorLine,
	 ErrorProcedure,
	 ErrorMessage,
	 TaskManagementUID
	 )
	 values(
	 @ErrorNumber,
	 @ErrorState,
	 @ErrorSeverity,
	 @ErrorLine,
	 @ErrorProcedure,
	 @ErrorMessage,
	 @TaskManagementUID)


END
GO
/****** Object:  StoredProcedure [dbo].[TASK_SP_JSON_METADATA_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TASK_SP_JSON_METADATA_CRUD]  
	  @TASK_ID BIGINT NULL,
	  @TASKMETADATA NVARCHAR(MAX) NULL
AS
  BEGIN
    --DECLARE @TASKMETADATA NVARCHAR(MAX) 
    DECLARE @ERROR_NUMBER AS INT,
    @ERROR_STATE AS INT,
    @ERROR_SEVERITY AS INT,
    @ERROR_PROCEDURE AS NVARCHAR(100),
    @ERROR_LINE AS INT,
    @ERROR_MESSAGE AS NVARCHAR(4000);
   
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION SP_UNIT_TEST_CRUD
		BEGIN
		--THIS IS FOR SELECTION
		
		SELECT J.[KEY], J.VALUE
		FROM OPENJSON(@TASKMETADATA) AS J
		   END

		--THIS IS FOR INSERTION
		INSERT INTO TASK_WORKFLOW_SEARCH (TASK_ID, TASKSEARCHKEY, TASKSEARCHVALUE)
         SELECT TASK_ID=@TASK_ID , J.[KEY], J.VALUE FROM  OPENJSON(@TASKMETADATA) AS J ;
		
       
        
	--SET XACT_ABORT OFF;
	 COMMIT TRANSACTION SP_UNIT_TEST_CRUD  
    END TRY
           
    BEGIN CATCH
    ----ERROR HANDLING
        
        --IF (XACT_STATE()) = -1 OR @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION SP_UNIT_TEST_CRUD
        --SET XACT_ABORT OFF;
        SELECT
            @ERROR_NUMBER = ERROR_NUMBER(),
            @ERROR_STATE = ERROR_STATE(),
            @ERROR_SEVERITY=  ERROR_SEVERITY(),
            @ERROR_PROCEDURE = ERROR_PROCEDURE(),
            @ERROR_LINE = ERROR_LINE(),
            @ERROR_MESSAGE = ERROR_MESSAGE();
                        
        EXECUTE DBO.TASK_SP_INSERT_EXCEPTIONLOG @ERRORNUMBER = @ERROR_NUMBER, @ERRORSTATE = @ERROR_STATE, @ERRORSEVERITY = @ERROR_SEVERITY, @ERRORLINE = @ERROR_LINE, @ERRORPROCEDURE = @ERROR_PROCEDURE, @ERRORMESSAGE = @ERROR_MESSAGE, @TASKMANAGEMENTUID = 0
    END CATCH;
END







GO
/****** Object:  StoredProcedure [dbo].[Task_SP_TaskActivity_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Task_SP_TaskActivity_CRUD]
    @ACTIVITY_ID BIGINT NULL= 0,              
    @TASK_ID BIGINT NULL,
	@MESSAGE NVARCHAR(MAX) NULL,
	@USER_ID NVARCHAR(128) NULL,
	@ACTIVITY_DT_TIME DATETIME NULL,
	@DUE_DT DATETIME NULL,
	@TIMEFRAME INT NULL,
	@TASKSTATUSCODE NVARCHAR(10) NULL,
	@ESCALATION_UID BIGINT NULL,
	@ESCALATIONSTAGE INT NULL,
	@RESPONSEMESSAGE VARCHAR(200) OUTPUT , 
    @RESPONSESTATUS BIT OUTPUT ,
	@RESPONSEDETAILS BIGINT OUTPUT,
	@ACTION NVARCHAR(30)
AS
BEGIN

    DECLARE @ERROR_NUMBER AS INT,
    @ERROR_STATE AS INT,
    @ERROR_SEVERITY AS INT,
    @ERROR_PROCEDURE AS NVARCHAR(100),
    @ERROR_LINE AS INT,
    @ERROR_MESSAGE AS NVARCHAR(4000);
    
                -- SET NOCOUNT ON added to prevent extra result sets from
                -- interfering with SELECT statements.
                SET NOCOUNT ON;
                SET XACT_ABORT ON;
                
                BEGIN TRY
                                BEGIN TRANSACTION Task_Activity_CRUD
          ----SQL Statements
		 IF @Action='SELECT'
		 BEGIN
		
			SELECT  ENTITY_ID, 
            ASSIGNEDUSER_ID, 
            TASKTITLE, 
            TASKDESCRIPTION, 
            DUE_DT ,
            TASKPRIORITY,
            TASKTYPECODE ,
            TASKMETADATA, 
            TASKSTATUSCODE,
            LOBTYPE ,
            CREATE_DT ,
            CREATE_USER_ID,
            LAST_UPDATE_USER_ID ,
            LAST_UPDATE_TS ,
            TIMEFRAME ,
            POLICYNUMBER ,
            DELETED ,
            TASKASSIGNMENTTYPE FROM
			Task_Workflow 
		END
--This is for insertion
            IF @ACTION='INSERT'
			BEGIN
            INSERT INTO Task_Activity(ACTIVITY_ID,
			TASK_ID ,
			 
			[MESSAGE] ,
			USER_ID ,
			ACTIVITY_DT_TIME,
			DUE_DT ,
			TIMEFRAME ,
			TASKSTATUSCODE ,
			ESCALATION_UID ,
			ESCALATIONSTAGE
			 )
            VALUES (@ACTIVITY_ID,
			@TASK_ID ,
				 
	        @MESSAGE ,
	        @USER_ID ,
	        @ACTIVITY_DT_TIME ,
	        @DUE_DT ,
	        @TIMEFRAME ,
	        @TASKSTATUSCODE ,
	        @ESCALATION_UID ,
	        @ESCALATIONSTAGE)
      END
			

--THIS IS FOR UPDATION
     ELSE IF @Action='UPDATE'
      BEGIN
            UPDATE Task_Activity
            SET TASK_ID=@TASK_ID,
			 
			[MESSAGE] =  @MESSAGE,
			USER_ID =@USER_ID,
			ACTIVITY_DT_TIME= @ACTIVITY_DT_TIME,
			DUE_DT= @DUE_DT,
			TIMEFRAME= @TIMEFRAME,
			TASKSTATUSCODE = @TASKSTATUSCODE,
			ESCALATION_UID = @ESCALATION_UID,
			ESCALATIONSTAGE= @ESCALATIONSTAGE
		         WHERE ACTIVITY_ID=@ACTIVITY_ID
		   END
 
			 -- THIS IS FOR DELETION
		 ELSE IF @Action='DELETE'
		 BEGIN
			  DELETE FROM  Task_Activity
			  WHERE ACTIVITY_ID=@ACTIVITY_ID
	     END
               COMMIT TRANSACTION Task_Activity_CRUD


                                SET @ResponseStatus = 1;
                                SET @ResponseMessage = 'Transaction Successfully';
								SET @ResponseDetails = 2
                                SET XACT_ABORT OFF;
                END TRY
                BEGIN CATCH
                    ----Error Handling
					SET @ResponseStatus = 0;
                    SET @ResponseMessage = 'Transaction Failed';
					SET @ResponseDetails = -999;
	
                    IF (XACT_STATE()) = -1 OR @@TRANCOUNT > 0  
                                    ROLLBACK TRANSACTION Task_Activity_CRUD
                    SET XACT_ABORT OFf;
                    SELECT
                        @ERROR_NUMBER = ERROR_NUMBER(),
                        @ERROR_STATE = ERROR_STATE(),
                        @ERROR_SEVERITY=  ERROR_SEVERITY(),
                        @ERROR_PROCEDURE = ERROR_PROCEDURE(),
                        @ERROR_LINE = ERROR_LINE(),
                        @ERROR_MESSAGE = ERROR_MESSAGE();
                    EXECUTE dbo.Task_SP_Insert_ExceptionLog @ErrorNumber = @ERROR_NUMBER, @ERRORSTATE = @ERROR_STATE, @ErrorSeverity = @Error_Severity, @ErrorLine = @Error_Line, @ErrorProcedure = @Error_Procedure, @ErrorMessage = @Error_Message, @TaskManagementUID = 0
                END CATCH;
END

GO
/****** Object:  StoredProcedure [dbo].[TASK_SP_TASKQUEUE_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TASK_SP_TASKQUEUE_CRUD]  
      
	@ENTITY_ID	BIGINT,
	@TITLE	NVARCHAR(50),
	@TASKDESCRIPTION NCHAR(100),
	@CREATE_TS DATETIME,
	@CREATEDBY	NVARCHAR(40),
	@MODIFY_TS DATETIME,
	@MODIFIEDBY	NVARCHAR(40),
	@ISACTIVE	BIT,
	@RESPONSEMESSAGE VARCHAR(200) OUTPUT, 
    @RESPONSESTATUS BIT OUTPUT,
    @RESPONSEDETAILS BIGINT OUTPUT,
    @ACTION NVARCHAR(30)
		
AS
BEGIN
    DECLARE @ERROR_NUMBER AS INT,
    @ERROR_STATE AS INT,
    @ERROR_SEVERITY AS INT,
    @ERROR_PROCEDURE AS NVARCHAR(100),
    @ERROR_LINE AS INT,
    @ERROR_MESSAGE AS NVARCHAR(4000);
    



    -- SET NOCOUNT ON ADDED TO PREVENT EXTRA RESULT SETS FROM
    -- INTERFERING WITH SELECT STATEMENTS.
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
                
    BEGIN TRY
    BEGIN TRANSACTION TASK_QUEUE_CRUD
            
    IF @ACTION='SELECT'                    ----SQL STATEMENTS
    BEGIN
    SELECT
	ENTITY_ID,
    TITLE, 
    TASKDESCRIPTION, 
    CREATE_TS, 
    CREATEDBY,
    MODIFY_TS,
    MODIFIEDBY,
    ISACTIVE
    
    FROM
    TASK_QUEUE
    END
    --THIS IS FOR INSERTION
    IF @ACTION = 'INSERT'
    BEGIN
    
    INSERT INTO TASK_QUEUE(
     
    ENTITY_ID,
    TITLE, 
    TASKDESCRIPTION, 
    CREATE_TS, 
    CREATEDBY ,
    MODIFY_TS,
    MODIFIEDBY,
    ISACTIVE
    )
    VALUES (
    @ENTITY_ID,
    @TITLE, 
    @TASKDESCRIPTION, 
    @CREATE_TS, 
    @CREATEDBY ,
    @MODIFY_TS,
    @MODIFIEDBY,
    @ISACTIVE)
    END
            
            
   
--THIS IS FOR UPDATION
    ELSE IF  @ACTION= 'UPDATE'
    BEGIN
         UPDATE TASK_QUEUE
         SET ENTITY_ID = @ENTITY_ID, 
         TITLE=@TITLE, 
         TASKDESCRIPTION=@TASKDESCRIPTION, 
         CREATE_TS=@CREATE_TS, 
         CREATEDBY = @CREATEDBY ,
         MODIFY_TS=@MODIFY_TS,
         MODIFIEDBY=@MODIFIEDBY,
         ISACTIVE=@ISACTIVE
         WHERE ENTITY_ID= @ENTITY_ID
      END
 
     --THIS IS FOR DELETION
     ELSE IF @ACTION= 'DELETE' 
     BEGIN
        UPDATE TASK_QUEUE
        SET ISACTIVE= 1 WHERE  ENTITY_ID= @ENTITY_ID  
      END
      COMMIT TRANSACTION TASK_QUEUE_CRUD
	  
	  
      
      SET @RESPONSESTATUS = 1;
      SET @RESPONSEMESSAGE = 'TRANSACTION SUCCESSFULLY';
      SET @RESPONSEDETAILS = 2;
      SET XACT_ABORT OFF;
      END TRY
      
      BEGIN CATCH
      ----ERROR HANDLING
          SET @RESPONSESTATUS = 0;
          SET @RESPONSEMESSAGE = 'TRANSACTION FAILED ';
          SET @RESPONSEDETAILS = -999;
                                
                    


       IF (XACT_STATE()) = -1 OR @@TRANCOUNT > 0  
                       ROLLBACK TRANSACTION TASK_QUEUE_CRUD
       SET XACT_ABORT OFF;
       
       SELECT
           
           @ERROR_NUMBER = ERROR_NUMBER(),
           @ERROR_STATE = ERROR_STATE(),
           @ERROR_SEVERITY=  ERROR_SEVERITY(),
           @ERROR_PROCEDURE = ERROR_PROCEDURE(),
           @ERROR_LINE = ERROR_LINE(),
           @ERROR_MESSAGE = ERROR_MESSAGE();
           
       EXECUTE DBO.TASK_SP_INSERT_EXCEPTIONLOG @ERRORNUMBER = @ERROR_NUMBER, @ERRORSTATE = @ERROR_STATE, @ERRORSEVERITY = @ERROR_SEVERITY, @ERRORLINE = @ERROR_LINE, @ERRORPROCEDURE = @ERROR_PROCEDURE, @ERRORMESSAGE = @ERROR_MESSAGE, @TASKMANAGEMENTUID = 0
       END CATCH;
END







GO
/****** Object:  StoredProcedure [dbo].[Task_SP_TaskWorkFlow_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Task_SP_TaskWorkFlow_CRUD]  

@TASK_ID INT NULL= 0,
@ENTITY_ID INT  NULL,
@ASSIGNEDUSER_ID NVARCHAR(128)  NULL,
@TASKTITLE NVARCHAR(100) NULL,
@TASKDESCRIPTION NVARCHAR(MAX) NULL,
@DUE_DT DATETIME NULL,
@TASKPRIORITY BIGINT NULL,
@TIMEFRAME INT NULL,
@POLICYACTIVITY_ID NVARCHAR(100) NULL,
@POLICYNUMBER NVARCHAR(50) NULL,
@TASKTYPECODE  BIGINT  NULL,
@TASKMETADATA NVARCHAR(MAX) NULL,
@TASKSTATUSCODE  BIGINT NULL,
@LOBTYPE NVARCHAR(30) NULL,
@TASKASSIGNMENTTYPE  CHAR(1) NULL,
@CREATE_DT DATETIME NULL,
@CREATE_USER_ID NVARCHAR(128) NULL,
@LAST_UPDATE_USER_ID NVARCHAR(128) NULL,
@LAST_UPDATE_TS DATETIME NULL,
@MESSAGE NVARCHAR(MAX),
@REMARK NVARCHAR(MAX),
@DELETED BIT NULL,						
@RESPONSEMESSAGE VARCHAR(200) OUTPUT,
@RESPONSESTATUS BIT OUTPUT,
@RESPONSEDETAILS BIGINT OUTPUT,
@ACTION NVARCHAR(30)


AS
BEGIN
    DECLARE @ERROR_NUMBER AS INT,
    @ERROR_STATE AS INT,
    @ERROR_SEVERITY AS INT,
    @ERROR_PROCEDURE AS NVARCHAR(100),
    @ERROR_LINE AS INT,
    @ERROR_MESSAGE AS NVARCHAR(4000);
   
    SET NOCOUNT ON;
    SET XACT_ABORT ON;
                
    BEGIN TRY
        BEGIN TRANSACTION Trans_Workflow

           --This is for insertion
            IF @Action = 'INSERT'
            BEGIN
				INSERT INTO Task_Workflow(

					ENTITY_ID ,
					ASSIGNEDUSER_ID ,
					TASKTITLE ,
					TASKDESCRIPTION ,
					DUE_DT ,
					TASKPRIORITY ,
					TIMEFRAME ,
					POLICYACTIVITY_ID ,
					POLICYNUMBER ,
					TASKTYPECODE  ,
					TASKMETADATA ,
					TASKSTATUSCODE ,
					LOBTYPE ,
					TASKASSIGNMENTTYPE  ,
					CREATE_DT ,
					CREATE_USER_ID ,
					LAST_UPDATE_USER_ID ,
					LAST_UPDATE_TS,
					DELETED 		
				
				       )
				VALUES (
					@ENTITY_ID ,
					@ASSIGNEDUSER_ID ,
					@TASKTITLE ,
					@TASKDESCRIPTION ,
					@DUE_DT ,
					@TASKPRIORITY ,
					@TIMEFRAME ,
					@POLICYACTIVITY_ID ,
					@POLICYNUMBER ,
					@TASKTYPECODE  ,
					@TASKMETADATA ,
					@TASKSTATUSCODE ,
					@LOBTYPE ,
					@TASKASSIGNMENTTYPE  ,
					@CREATE_DT ,
					@CREATE_USER_ID ,
					@LAST_UPDATE_USER_ID ,
					@LAST_UPDATE_TS,
					@DELETED 		
				
				)
            
				--Inserting Data into Task_Activity
				--select @TaskId = MAX(TaskId) From Task_Workflow
				select @TASK_ID= @@IDENTITY;
				
				INSERT INTO Task_Activity(
					TASK_ID,
					[MESSAGE],
					NOTE,
					USER_ID ,
					ACTIVITY_DT_TIME,
					DUE_DT,
					TIMEFRAME,
					TASKSTATUSCODE,
					ESCALATION_UID,
					ESCALATIONSTAGE
				    )
				VALUES (
					@TASK_ID,
					@MESSAGE,
					@REMARK,
					@ASSIGNEDUSER_ID ,
					@CREATE_DT ,
					@DUE_DT,
					@TIMEFRAME,
					@TASKSTATUSCODE,
					1,
					1
					)
					SELECT @POLICYACTIVITY_ID = POLICYACTIVITY_ID , @POLICYNUMBER = POLICYNUMBER
				FROM OPENJSON(@TASKMETADATA)  
				WITH (
					POLICYACTIVITY_ID NVARCHAR(100) '$.POLICYACTIVITY_ID',
					POLICYNUMBER NVARCHAR(100) '$.POLICYNUMBER'
				)
				
				INSERT INTO Task_Workflow_Search(
				TASK_ID,
				TASKSEARCHKEY,
				TASKSEARCHVALUE)	
				VALUES (
				@TASK_ID,
				'POLICYACTIVITY_ID',
				@POLICYACTIVITY_ID)

				INSERT INTO Task_Workflow_Search(
				TASK_ID,
				TASKSEARCHKEY,
				TASKSEARCHVALUE)	
				VALUES (
				@TASK_ID,
				'POLICYNUMBER',
				@POLICYNUMBER)
			END   
    
			--THIS IS FOR UPDATION
			ELSE IF  @Action= 'UPDATE'
			BEGIN
				UPDATE Task_Workflow
				SET TASKSTATUSCODE = @TASKSTATUSCODE,
				ASSIGNEDUSER_ID = @ASSIGNEDUSER_ID,
				DUE_DT = @DUE_DT,
				LAST_UPDATE_USER_ID = @LAST_UPDATE_USER_ID,
				LAST_UPDATE_TS = @LAST_UPDATE_TS
				WHERE TASK_ID = @TASK_ID

				--Inserting Data into Task_Activity

				INSERT INTO Task_Activity(
					TASK_ID,
					[MESSAGE],
					NOTE,
					USER_ID,
					ACTIVITY_DT_TIME,
					DUE_DT,
					TIMEFRAME,
					TASKSTATUSCODE,
					ESCALATION_UID,
					ESCALATIONSTAGE
				)
				VALUES (
					@TASK_ID,
					@MESSAGE,
					@REMARK,
					@ASSIGNEDUSER_ID,
					@LAST_UPDATE_TS,
					@DUE_DT,
					@TIMEFRAME,
					@TASKSTATUSCODE,
					1,
					1
				)
			END

			--THIS IS FOR STATUS UPDATION
			ELSE IF  @Action= 'PUPDATE'
			BEGIN
				UPDATE Task_Workflow
				SET TASKPRIORITY = @TASKPRIORITY,
				LAST_UPDATE_USER_ID = @LAST_UPDATE_USER_ID,
				LAST_UPDATE_TS = @LAST_UPDATE_TS
				WHERE TASK_ID = @TASK_ID
			END

			--THIS IS FOR STATUS UPDATION
			ELSE IF  @Action= 'SUPDATE'
			BEGIN
				UPDATE Task_Workflow
				SET TaskStatusCode = @TaskStatusCode,
				DUE_DT = @DUE_DT,
				LAST_UPDATE_USER_ID = @LAST_UPDATE_USER_ID,
				LAST_UPDATE_TS = @LAST_UPDATE_TS
				WHERE TASK_ID = @TASK_ID

				--Inserting Data into Task_Activity

				INSERT INTO Task_Activity(
					TASK_ID,
					[MESSAGE],
					NOTE,
					USER_ID,
					ACTIVITY_DT_TIME,
					DUE_DT,
					TIMEFRAME,
					TASKSTATUSCODE,
					ESCALATION_UID,
					ESCALATIONSTAGE
				)
				VALUES (
					@TASK_ID,
					@MESSAGE,
					@REMARK,
					@ASSIGNEDUSER_ID,
					@LAST_UPDATE_TS,
					@DUE_DT,
					@TIMEFRAME,
					@TASKSTATUSCODE,
					1,
					1
				)
			END
 
			--THIS IS FOR DELETION
			ELSE IF @Action= 'DELETE' 
			BEGIN
				UPDATE Task_Workflow
				SET DELETED = 1 WHERE TASK_ID=@TASK_ID  
			END
            
		COMMIT TRANSACTION Trans_Workflow

        SET @ResponseStatus = 1;
        SET @ResponseMessage = 'Transaction Completed Successfully';
        SET @ResponseDetails = 2;
        SET XACT_ABORT OFF;
    END TRY
                
    BEGIN CATCH
    ----Error Handling
        SET @ResponseStatus = 0;
        SET @ResponseMessage = 'Transaction Failed ';
        SET @ResponseDetails = -999;
        IF (XACT_STATE()) = -1 OR @@TRANCOUNT > 0  
        ROLLBACK TRANSACTION Trans_Workflow
        SET XACT_ABORT OFf;
        SELECT
            @ERROR_NUMBER = ERROR_NUMBER(),
            @ERROR_STATE = ERROR_STATE(),
            @ERROR_SEVERITY=  ERROR_SEVERITY(),
            @ERROR_PROCEDURE = ERROR_PROCEDURE(),
            @ERROR_LINE = ERROR_LINE(),
            @ERROR_MESSAGE = ERROR_MESSAGE();
                        
        EXECUTE dbo.Task_SP_Insert_ExceptionLog @ErrorNumber = @ERROR_NUMBER, @ERRORSTATE = @ERROR_STATE, @ErrorSeverity = @Error_Severity, @ErrorLine = @Error_Line, @ErrorProcedure = @Error_Procedure, @ErrorMessage = @Error_Message, @TaskManagementUID = 0
    END CATCH;
END







GO
/****** Object:  StoredProcedure [dbo].[TASK_SP_WORKFLOW_SEARCH_CRUD]    Script Date: 13-10-2021 17:13:50 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TASK_SP_WORKFLOW_SEARCH_CRUD]  
	  ----@ID	BIGINT NULL,
	  @TASK_ID	BIGINT NULL,
	  ----@TASKSEARCHKEY	NVARCHAR(100) NULL,
	  @TASKMETADATA NVARCHAR(MAX) NULL
      --   @TASKSEARCHVALUE	NVARCHAR(100) NULL,
      --   @RESPONSEMESSAGE VARCHAR(200) OUTPUT, 
      --   @RESPONSESTATUS BIT OUTPUT,
      --   @RESPONSEDETAILS BIGINT OUTPUT,
      --   @ACTION NVARCHAR(30)
AS
  BEGIN
   DECLARE  @POLICYACTIVITYID NVARCHAR(100);
   DECLARE @POLICYNUMBER NVARCHAR(100);
   --SET @TASKMETADATA = N'{"POLICYACTIVITYID":"CS000001699", "POLICYNUMBER": "FPT0000321"}';

    DECLARE @ERROR_NUMBER AS INT,
    @ERROR_STATE AS INT,
    @ERROR_SEVERITY AS INT,
    @ERROR_PROCEDURE AS NVARCHAR(100),
    @ERROR_LINE AS INT,
    @ERROR_MESSAGE AS NVARCHAR(4000);
   
    SET NOCOUNT ON;
    --SET XACT_ABORT ON;
                
    BEGIN TRY
        --BEGIN TRANSACTION SP_WORKFLOW_SEARCH_CRUD

			SELECT @POLICYACTIVITYID = POLICYACTIVITYID, @POLICYNUMBER = POLICYNUMBER
			FROM OPENJSON(@TASKMETADATA)  
			WITH (
				POLICYACTIVITYID NVARCHAR(100) '$.POLICYACTIVITYID',
				POLICYNUMBER NVARCHAR(100) '$.POLICYNUMBER'
			)
			--THIS IS FOR INSERTION
			INSERT INTO TASK_WORKFLOW_SEARCH(
			TASK_ID,
	        TASKSEARCHKEY,
	        TASKSEARCHVALUE)	
			VALUES (
			@TASK_ID,
	        'POLICYACTIVITYID',
	        @POLICYACTIVITYID)

			INSERT INTO TASK_WORKFLOW_SEARCH(
			TASK_ID,
	        TASKSEARCHKEY,
	        TASKSEARCHVALUE)	
			VALUES (
			@TASK_ID,
	        'POLICYNUMBER',
	        @POLICYNUMBER)
   
		--COMMIT TRANSACTION SP_WORKFLOW_SEARCH_CRUD

        --SET XACT_ABORT OFF;
    END TRY
                
    BEGIN CATCH
    ----ERROR HANDLING
        
        --IF (XACT_STATE()) = -1 OR @@TRANCOUNT > 0  
        --ROLLBACK TRANSACTION SP_WORKFLOW_SEARCH_CRUD
        --SET XACT_ABORT OFF;
        SELECT
            @ERROR_NUMBER = ERROR_NUMBER(),
            @ERROR_STATE = ERROR_STATE(),
            @ERROR_SEVERITY=  ERROR_SEVERITY(),
            @ERROR_PROCEDURE = ERROR_PROCEDURE(),
            @ERROR_LINE = ERROR_LINE(),
            @ERROR_MESSAGE = ERROR_MESSAGE();
                        
        EXECUTE DBO.TASK_SP_INSERT_EXCEPTIONLOG @ERRORNUMBER = @ERROR_NUMBER, @ERRORSTATE = @ERROR_STATE, @ERRORSEVERITY = @ERROR_SEVERITY, @ERRORLINE = @ERROR_LINE, @ERRORPROCEDURE = @ERROR_PROCEDURE, @ERRORMESSAGE = @ERROR_MESSAGE, @TASKMANAGEMENTUID = 0
    END CATCH;
END







GO
