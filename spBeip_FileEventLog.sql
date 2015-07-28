Create Table
	x01_Id			integer, -- PK autofill
	x01_sInitFn		nvarchar(256),
	x01_sTranType	nvarchar(32),
	x01_InPath		nvarchar(256),
	x01_InFileName	nvarchar(256),
	x01_OutPath		nvarchar(256),
	x01_OutFileName	nvarchar(256),
	x01_sInfo		nvarchar(256),
	x01_sSystemUser	nvarchar(260), --autofill
	x01_dtStamp		smalldatetime --autofill

Create Proc spBeip_FileEventLog
(
	@sInitFn		nvarchar(),
	@sTranType		nvarchar(),
	@sInPath		nvarchar(),
	@sInFileName	nvarchar(),
	@sOutPath		nvarchar(),
	@sOutFileName	nvarchar(),
	@sInfo			nvarchar()
)
as
begin
Set NoCount On
-- 20150711v1.0, listlchr, init
-- Sp should log file transactions (copy file, move file etc.)
-- each row is one filetransaction
-- it may also contain db transactions like import to and export to

begin -- s0010: Debug handling
	declare @sSpName nvarchar(128)
	set @sSpName = 'spBeip_FileEventLog'
	declare @nDebugLevel tinyint
	select @nDebugLevel = dbo.fnBeip_GetParameter('DebugLevel','CurrentState')
end
if @nDebugLevel>0 spBeip_EventLog_Ins (@sSpName,'s0010_InitSp')


begin -- s0020
	insert into Beip_FileEventLog
	(
		x01_sInitFn,
		x01_sTranType,
		x01_InPath,
		x01_InFileName,
		x01_OutPath,
		x01_OutFileName,
		x01_sInfo
	)
	values
	(
		@sInitFn,
		@sTranType,
		@sInPath,
		@sInFile,
		@sOutPath,
		@sOutFile,
		@sInfo
	)
end

Set NoCount off
return(1)
end
go