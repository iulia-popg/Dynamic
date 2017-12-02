

CREATE PROCEDURE [dbo].[sp_Insert_Scale_Up_Data_In_Table]
	@tablename varchar(20) = '',
	@starting_counter int = 0,
	@number_of_copies int = 10
AS
begin
	declare @script varchar(max) ='';
	declare @select varchar(500) = 'select *, [M_LoanID]+';
	declare @temp_table varchar(50) = '#temp_table_'+ @tablename;
	declare @first_after_select varchar(100) = ' as new_loan_id into '+ @temp_table;
	declare @from varchar(100) = ' from '
	declare @union varchar(20) = ' union all '
	declare @update_id_column varchar(200) = '; 
		update ' + @temp_table +
		' set [M_LoanID] = new_loan_id ;
		alter table ' + @temp_table+ ' drop column new_loan_id; ';
	declare @insert_into varchar (300) = 'insert into ' + @tablename +
		' select * from ' + @temp_table + ';';
	declare @counter int = @starting_counter;
	declare @max_counts int = @starting_counter + @number_of_copies;
while @counter < @max_counts
	begin
	set @script = @script +
	@select + '''' + cast(@counter as varchar) + '''' + 
	case @counter when @starting_counter then @first_after_select else '' end 
	+ @from +@tablename + 
		case 
		when @counter = @max_counts - 1 then ''
		else @union
		end
	;
	set @counter = @counter + 1;
	end;
set @script = @script + @update_id_column + @insert_into;
--select @script;
exec (@script);

RETURN 0
end
