USE [petition]
GO

/****** Object:  UserDefinedDataType [dbo].[TSeq]    Script Date: 09/03/2006 14:31:43 ******/
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TSeq' AND ss.name = N'dbo')
CREATE TYPE [dbo].[TSeq] FROM [char](14) NOT NULL
GO
/****** Object:  View [dbo].[peti_sortedColumns]    Script Date: 09/03/2006 14:31:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Table [dbo].[petition]    Script Date: 09/03/2006 14:31:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[petition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[petition](
	[seq] [varchar](max) NOT NULL,
	[category] [int] NULL,
	[worldId] [int] NULL,
	[accountName] [varchar](max) NOT NULL,
	[accountId] [int] NOT NULL,
	[charName] [varchar](max) NOT NULL,
	[charUid] [int] NOT NULL,
	[content] [varchar](max) NOT NULL,
	[forcedGmAccountName] [varchar](max) NOT NULL,
	[forcedGmAccountUid] [int] NOT NULL CONSTRAINT [DF_petition_forcedGmAccountUid]  DEFAULT ((0)),
	[forcedGmCharName] [varchar](max) NOT NULL,
	[forcedGmCharUid] [int] NOT NULL CONSTRAINT [DF_petition_forcedGmCharUid]  DEFAULT ((0)),
	[quotaAtSubmit] [int] NOT NULL,
	[SubmitTime] [datetime] NOT NULL,
	[state] [tinyint] NOT NULL CONSTRAINT [DF_petition_state]  DEFAULT ((2)),
	[checkOutGmAccountName] [varchar](max) NOT NULL CONSTRAINT [DF_petition_checkOutGmAccountName]  DEFAULT (''),
	[checkOutGmAccountId] [int] NOT NULL CONSTRAINT [DF_petition_checkOutGmAccountId]  DEFAULT ((0)),
	[checkOutGmCharName] [varchar](max) NOT NULL CONSTRAINT [DF_petition_checkOutGmCharName]  DEFAULT (''),
	[checkOutGmCharUid] [int] NOT NULL CONSTRAINT [DF_petition_checkOutGmCharUid]  DEFAULT ((0)),
	[checkOutTime] [datetime] NULL CONSTRAINT [DF_petition_checkOutTime]  DEFAULT (NULL),
	[grade] [tinyint] NOT NULL CONSTRAINT [DF_petition_grade]  DEFAULT ((1))
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[history]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[history]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[history](
	[historySeq] [int] NOT NULL,
	[seq] [char](14) NOT NULL,
	[time] [datetime] NOT NULL,
	[actor] [varchar](max) NOT NULL,
	[action] [tinyint] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ChatLog]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ChatLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ChatLog](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[seq] [char](14) NOT NULL,
	[talker] [varchar](max) NOT NULL,
	[message] [text] NOT NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_ChatLog] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[NCDBA7]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NCDBA7]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NCDBA7](
	[dbkey] [int] NOT NULL,
	[connstr] [varchar](max) NOT NULL,
	[timeout] [int] NOT NULL,
	[maxconn] [int] NOT NULL,
	[connname] [varchar](max) NOT NULL,
 CONSTRAINT [PK_NCDBA7] PRIMARY KEY CLUSTERED 
(
	[dbkey] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[GmStatus]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GmStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GmStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[worldId] [int] NOT NULL,
	[status] [int] NOT NULL,
	[gmname] [varchar](max) NOT NULL,
 CONSTRAINT [PK_GmStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Memo]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Memo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Memo](
	[seq] [varchar](max) NOT NULL,
	[memoSeq] [int] NOT NULL,
	[charName] [varchar](max) NOT NULL,
	[content] [text] NOT NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_Memo] PRIMARY KEY NONCLUSTERED 
(
	[memoSeq] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

/****** Object:  Index [IX_Memo]    Script Date: 09/03/2006 14:31:48 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Memo]') AND name = N'IX_Memo')
CREATE CLUSTERED INDEX [IX_Memo] ON [dbo].[Memo] 
(
	[memoSeq] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[peti_sortedColumns]'))
EXEC dbo.sp_executesql @statement = N'
CREATE VIEW [dbo].[peti_sortedColumns]
AS
SELECT     cast(worldId as tinyint) as worldId_exp,
 seq, 
cast(category as tinyint) as e2, 
cast(grade as tinyint) as e3, 
accountName, accountId, charName, charUid, 
checkOutGmAccountName, checkOutGmAccountId, checkOutGmCharName,checkOutGmCharUid, 
cast(0 as tinyint) AS Expr1, 
[content], 
SubmitTime, 
cast(state as tinyint) as e4, 
forcedGmAccountName, forcedGmAccountUid, forcedGmCharName, forcedGmCharUid, 
cast(quotaAtSubmit as tinyint) as e5,checkOutTime
FROM         dbo.petition
' 
GO


/****** Object:  StoredProcedure [dbo].[up_Server_InsertPetition]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_InsertPetition]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'




-- =============================================
-- Author:		<Aralyon>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_InsertPetition] 
	-- Add the parameters for the stored procedure here
@seq varchar(max),
@category int,
@worldId int,
@accountName varchar(max),
@accountuId int,
@charName varchar(max),
@charUid int,
@content varchar(max),
@forcedGmAccountName varchar(max),
@forcedGmAccountUid int,
@forcedGmCharName varchar(max),
@forcedGmCharUid int,
@quotaAtSubmit int,
@time datetime
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into petition (seq,category,worldId,accountName,accountId,charName,charUid,[content],forcedGmAccountName,forcedGmAccountUid,forcedGmCharName,forcedGmCharUid,quotaAtSubmit,SubmitTime) 
		values(@seq,@category,@worldId,@accountName,@accountuId,
		@charName,@charUid,@content,@forcedGmAccountName,@forcedGmAccountUid,@forcedGmCharName,
	   @forcedGmCharUid,@quotaAtSubmit,@time)
END





' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_UserCancel]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_UserCancel]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<Description,,>
-- =============================================
  

CREATE PROCEDURE [dbo].[up_Server_UserCancel]
	-- Add the parameters for the stored procedure here
@seq char(14),
@historySeq int,
@accountName varchar(max),
@accountUid int,
@charName varchar(max),
@charUid int,
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--delete from petition where charUid = @charUid and accountid=@accountUid
	insert into history values (@historySeq,@seq,@time,@charName,13);
	update petition set state=13 where seq=@seq
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_ModifyCategory]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_ModifyCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<aralyon>
-- Create date: <22.8.2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_ModifyCategory]
	-- Add the parameters for the stored procedure here
@seq char(14),
@category int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update petition set category = @category where seq=@seq
END

' 
END
GO
/****** Object:  Table [dbo].[L2Info]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[L2Info]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[L2Info](
	[petitionSeq] [char](14) NOT NULL,
	[race] [int] NOT NULL,
	[class] [int] NOT NULL,
	[level] [int] NOT NULL,
	[disposition] [int] NOT NULL,
	[ssPosition] [int] NOT NULL,
	[newChar] [int] NOT NULL,
	[coordinate] [varchar](max) NOT NULL,
 CONSTRAINT [PK_L2Info] PRIMARY KEY CLUSTERED 
(
	[petitionSeq] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[feedback]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[feedback]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[feedback](
	[seq] [char](14) NOT NULL,
	[score] [int] NOT NULL,
	[comment] [text] NOT NULL,
 CONSTRAINT [PK_feedback] PRIMARY KEY CLUSTERED 
(
	[seq] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_UpdateTemplate]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_UpdateTemplate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<aralyon>
-- Create date: <22.8.2006>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[up_Server_UpdateTemplate]
	-- Add the parameters for the stored procedure here
@gmAccountUid int,
@gmAccount varchar(max),
@code int,
@name varchar(max),
@type int,
@content text,
@category int,
@resultCode int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update templates set [name]=@name,[type]=@type,[content]=@content,[category]=@category where gmAccountUid = @gmAccountUid and [code]=@code
	set @resultCode = 1
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_DeleteTemplate]    Script Date: 09/03/2006 14:31:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_DeleteTemplate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<aralyon>
-- Create date: <22.8.2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_DeleteTemplate]
	-- Add the parameters for the stored procedure here
@gmAccountUid int,
@code int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	delete from templates where gmAccountUid=@gmAccountUid and [code]=@code
END
' 
END
GO
/****** Object:  Table [dbo].[templates]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[templates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[templates](
	[gmAccountUid] [int] NOT NULL,
	[gmAccount] [varchar](max) NOT NULL,
	[code] [int] NOT NULL,
	[name] [varchar](max) NULL,
	[type] [int] NULL,
	[content] [text] NULL,
	[category] [int] NULL,
	[offset] [int] NOT NULL CONSTRAINT [DF_templates_offset]  DEFAULT ((1)),
 CONSTRAINT [PK_templates_1] PRIMARY KEY CLUSTERED 
(
	[gmAccountUid] ASC,
	[offset] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[message]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[message]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[message](
	[ssq] [char](14) NOT NULL,
	[teller] [varchar](max) NOT NULL,
	[message] [text] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_GetTemplateList]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_GetTemplateList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Aralyon>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_GetTemplateList] 
	-- Add the parameters for the stored procedure here
@gmAccountUid int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select [code],[name],[type],[content],category,offset from template where gmAccountUid = @gmAccountUid
END
' 
END
GO
/****** Object:  Table [dbo].[category]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[category](
	[game] [tinyint] NOT NULL,
	[code] [tinyint] NOT NULL,
	[name] [nvarchar](20) NOT NULL,
	[deleted] [bit] NOT NULL CONSTRAINT [DF_category_deleted]  DEFAULT ((0)),
 CONSTRAINT [PK_category] PRIMARY KEY CLUSTERED 
(
	[game] ASC,
	[code] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  UserDefinedFunction [dbo].[FormatNumber]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FormatNumber]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create FUNCTION [dbo].[FormatNumber] 
(
	-- Add the parameters for the function here
	@value int
)
RETURNS varchar(2)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @res varchar(2);

	-- Add the T-SQL statements to compute the return value here
	if (@value<10) set @res = ''0''+cast(@value as varchar(2));
	else set @res = @value

	-- Return the result of the function
	RETURN @res

END' 
END

GO
/****** Object:  StoredProcedure [dbo].[up_Server_GetPastPetitionList]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_GetPastPetitionList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Aralyon>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_GetPastPetitionList] 
	-- Add the parameters for the stored procedure here
@seq TSeq,@offset int,@size int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT TOP @size *
	--	FROM (SELECT TOP (@offset+@size) * FROM peti_SortedColums ORDER BY seq) as T
	--	ORDER BY seq DESC
	select * from peti_SortedColums where ROW_NUMBER() OVER (order by seq) between @offset and @offset+@size
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_GetMessage]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_GetMessage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_GetMessage]
	-- Add the parameters for the stored procedure here
@seq TSeq 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from memo
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_GetHistoryList]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_GetHistoryList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_GetHistoryList]
	-- Add the parameters for the stored procedure here
@seq TSeq
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [time],actor,[action] from history where seq=@seq
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_GetMemoList]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_GetMemoList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_GetMemoList]
	-- Add the parameters for the stored procedure here
@seq TSeq 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT [time],charName,[content] from memo where memo.seq=@seq
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_UndoCheckOut]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_UndoCheckOut]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'


-- =============================================
-- Author:		<aralyon>
-- Create date: <2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_UndoCheckOut] 
	-- Add the parameters for the stored procedure here
@seq TSeq,
@historySeq int,
@accountName varchar(max),
@charName varchar(max),
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into history values (@historySeq,@seq,@time,@charName,11);
	update petition set state=11 where seq=@seq;
END



' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_ChatStart]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_ChatStart]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<aralyon>
-- Create date: <2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_ChatStart] 
	-- Add the parameters for the stored procedure here
@seq TSeq,
@historySeq int,
@accountName varchar(max),
@charName varchar(max),
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update petition set state=4 where seq=@seq;
	insert into history values (@historySeq,@seq,@time,@charName,4);
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_ChatEnd]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_ChatEnd]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<aralyon>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_ChatEnd] 
	-- Add the parameters for the stored procedure here
@seq TSeq,
@historySeq int,
@accountName varchar(max),
@charName varchar(max),
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into history values (@historySeq,@seq,@time,@charName,10);
	update petition set state=10 where seq=@seq;
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_ForwardCheckIn]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_ForwardCheckIn]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<dunno>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_ForwardCheckIn]
	-- Add the parameters for the stored procedure here
@seq TSeq,
@historySeq int,
@accountName varchar(max),
@charName varchar(max),
@grade int,
@flag int,
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into history values (@historySeq,@seq,@time,@charName,7);
	update petition set state=7 where seq=@seq;
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_CheckOut]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_CheckOut]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'



-- =============================================
-- Author:		<aralyon>
-- Create date: <22.6.2006>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[up_Server_CheckOut]
	-- Add the parameters for the stored procedure here
@seq TSeq,
@historySeq int,
@accountName varchar(max),
@accountUid int,
@charName varchar(max),
@charUid int,
@time datetime

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update petition set state=3,checkOutGmAccountName=@accountName,checkOutGmAccountId=@accountUid,checkOutGmCharName=@charName,checkOutGmCharUid=@charUid,checkOutTime=@time where seq=@seq;
	insert into history values (@historySeq,@seq,@time,@charName,3);
END




' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_MessageCheckIn]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_MessageCheckIn]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<dunno>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_MessageCheckIn] 
	-- Add the parameters for the stored procedure here
@seq TSeq,
@historySeq int,
@accountName varchar(max),
@charName varchar(max),
@message text,
@flag int,
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into history values (@historySeq,@seq,@time,@charName,9);
	update petition set state=9 where seq=@seq;
    insert into [message] values (@seq,@charName,@message)
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_AddChatLog]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_AddChatLog]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.6.2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_AddChatLog] 
	-- Add the parameters for the stored procedure here
@seq TSeq,
@talker varchar(max),
@message text,
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into ChatLog(seq,talker,[message],[time]) values (@seq,@talker,@message,@time)
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_ChattingCheckIn]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_ChattingCheckIn]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		Aralyon
-- Create date: 22.8.2006
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_ChattingCheckIn]
	-- Add the parameters for the stored procedure here
@seq TSeq,
@historySeq int,
@accountName varchar(max),
@charName varchar(max),
@flag int,
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into history values (@historySeq,@seq,@time,@charName,12);
	update petition set state=12 where seq=@seq;
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_ChattingCheckInWithMessage]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_ChattingCheckInWithMessage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<dunno>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_ChattingCheckInWithMessage] 
	-- Add the parameters for the stored procedure here
@seq TSeq,
@historySeq int,
@accountName varchar(max),
@charName varchar(max),
@message text,
@flag int,
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into history values (@historySeq,@seq,@time,@charName,12);
	update petition set state=12 where seq=@seq;
    insert into [message] values (@seq,@charName,@message)
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_AddL2Info]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_AddL2Info]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_AddL2Info] 
	-- Add the parameters for the stored procedure here
@petitionSeq TSeq,@race int,@class int,@level int,@disposition int,@ssPosition int,
@newChar int,@coordinate varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into L2Info values(@petitionSeq ,@race ,@class ,@level ,@disposition ,@ssPosition ,@newChar ,@coordinate )
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_GetActivePetitionList]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_GetActivePetitionList]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_GetActivePetitionList] 
	-- Add the parameters for the stored procedure here
@worldId tinyint
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--SELECT worldId,seq,category,grade,accountName,accountId,charName,charUid,checkOutGmAccountName,checkOutGmAccountId,checkOutGmCharName,checkOutGmCharUid,0,[content],SubmitTime,state,forcedGmAccountName,forcedGmAccountuId,forcedGmCharName,forcedGmCharUid,CheckOutTime FROM petition where worldId=@worldId
	select * from peti_sortedColumns p where p.worldId_exp=@worldId and e4 < 9
END


' 
END
GO
/****** Object:  StoredProcedure [dbo].[lp_GetDBConnectionStringNCDBA7]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[lp_GetDBConnectionStringNCDBA7]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<ARALYON>
-- Create date: <21.8.2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[lp_GetDBConnectionStringNCDBA7] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * from NCDBA7;
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_UpdateGmStatus]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_UpdateGmStatus]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<Dunno know yet, some ncsoft crap ;)>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_UpdateGmStatus] 
	-- Add the parameters for the stored procedure here
	@action int,
	@worldId int,
	@gmCharName varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
    if @action = 0
	begin
		update GmStatus set status = 0;
	end
	else if @action = 1
	begin
		if (select count(*) from GmStatus where worldId = @worldId and gmname = @gmCharName) = 0
		begin
			insert into GmStatus (worldId,status,gmname) values (@worldId,1,@gmCharName);
		end
		else 
			update GmStatus set status = 1 where worldId = @worldId and gmname = @gmCharName;
	end
	else if @action = 2
	begin
		update GmStatus set status = 0 where worldId = @worldId and gmname = @gmCharName;
	end
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_AddMemo]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_AddMemo]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<hadej pyco>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_AddMemo]
	-- Add the parameters for the stored procedure here
@seq varchar(max), 
@memoSeq int,
@charName varchar(max),
@content varchar(max), 
@time datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into memo values(@seq,@memoSeq,@charName,@content,@time)
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_ReadL2Info]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_ReadL2Info]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<aralyon>
-- Create date: <22.8.2006>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_ReadL2Info]
	-- Add the parameters for the stored procedure here
@seq char(14)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT race,class,[level],disposition,ssPosition,newChar,coordinate from L2Info where petitionSeq=@seq
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_ReportFeedback]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_ReportFeedback]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_ReportFeedback] 
	-- Add the parameters for the stored procedure here
@seq char(14),
@score int,
@comment text
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into feedback values(@seq,@score,@comment)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_DownloadTemplate]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_DownloadTemplate]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<aralyon>
-- Create date: <22.8.2006>
-- Description:	<Description,,>
-- =============================================

create PROCEDURE [dbo].[up_Server_DownloadTemplate]
	-- Add the parameters for the stored procedure here
@gmAccountUid int,
@gmAccount varchar(max),
@code int,
@resultCode int OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	insert into templates (gmAccountUid,gmAccount,[code]) values (@gmAccountUid,@gmAccount,@code)
	set @resultCode = 1
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_UpdateTemplateOrder]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_UpdateTemplateOrder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<aralyon>
-- Create date: <Create Date,,>
-- Description:	<22.8.>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_UpdateTemplateOrder] 
	-- Add the parameters for the stored procedure here
@gmAccountUid int,
@code int,
@offset int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	update templates set offset=@offset where gmAccountUid=@gmAccountUid and [code]=@code
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_GetCurrentCategory]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_GetCurrentCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
-- =============================================
-- Author:		<Aralyon>
-- Create date: <22.8.2006>
-- Description:	<ncsoft crap>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_GetCurrentCategory] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT code,name from category where deleted = 0
END

' 
END
GO
/****** Object:  StoredProcedure [dbo].[up_Server_GetCurrentSeqSerial]    Script Date: 09/03/2006 14:31:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[up_Server_GetCurrentSeqSerial]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'





-- =============================================
-- Author:		<Aralyon>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[up_Server_GetCurrentSeqSerial]
	-- Add the parameters for the stored procedure here
@now datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @prefix char(9);
	set @prefix = (SELECT cast(year(getdate()) as varchar(max))+ dbo.FormatNumber(month(getdate()))+dbo.FormatNumber(day(getdate()))+''%'');
    -- Insert statements for procedure here
	if (select count(*) from petition where seq like @prefix) <> 0
		SELECT cast(max(substring(seq,9,6)) as int) from petition
END
' 
END

delete from category;
insert into category values (2,1,'Immobility','False');
insert into category values(2,2,'Game tips','False');
insert into category values(2,3,'Bug report','False');
insert into category values(2,4,'Quest related','False');
insert into category values(2,5,'Suggestions','False');
insert into category values(2,6,'Report a bad user','False');
insert into category values(2,8,'Recovery related','False');
insert into category values(2,9,'Operation related','False');
insert into category values(2,255,'Other','False');

delete from NCDBA7;
insert into NCDBA7 values (1,'connection string',10000,30,'petition');