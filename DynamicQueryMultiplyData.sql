--select	*,
--		[M_LoanID]+'1' as new_loan_id
--into #testing
--from	[dbo].[Income]
--union all

--create table script_text
--(script_text text = '',
--table_name varchar(20)
--);
--insert into script_text ('','Loan');

declare @script varchar(max) ='';
declare @tablename varchar(15) = 'Mortgage';
declare @select varchar(500) = 'select *, [M_LoanID]+';
declare @temp_table varchar(50) = '#temp_table_'+@tablename;
declare @first_after_select varchar(100) = ' as new_loan_id into '+ @temp_table;
declare @from varchar(100) = ' from '
declare @union varchar(20) = ' union all '
declare @update_id_column varchar(200) = '; 
	update ' + @temp_table +
	' set [M_LoanID] = new_loan_id ;
	alter table ' + @temp_table+ ' drop column new_loan_id; ';
declare @insert_into varchar (300) = 'insert into ' + @tablename +
	' select * from ' + @temp_table + ';';
---select @first_after_select;
declare @counter int = 0;
declare @max_counts int = 63;
while @counter < @max_counts
	begin
	--select @counter;
	set @script = @script +
	--update script_text 
	--set script_text = script_text + 
	@select + '''' + cast(@counter as varchar) + '''' + 
	case @counter when 0 then @first_after_select else '' end 
	+ @from +@tablename + 
		case 
		when @counter = @max_counts - 1 then ''
		else @union
		end
	;
	--select 	@script;
	set @counter = @counter + 1;
	end;
set @script = @script + @update_id_column + @insert_into;
--update script_text 
--	set script_text = script_text + @update_id_column + @insert_into;
--'; select * from #temp_table_Rates;';
--select @script;
exec (@script);

select count(*) 
--delete 
from Loan
join Mortgage ON Loan.M_LoanID = Mortgage.M_LoanID;

--where DATALENGTH(M_LoanID) > 64;

exec [dbo].[sp_Insert_Scale_Up_Data_In_Table] 'Loan',400,10
