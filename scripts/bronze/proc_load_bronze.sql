/*
==============================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==============================================================

Script Purpose:
This stored procedure loads data into the 'bronze' schema from external CSV files.
It performs the following actions:
- Truncates the bronze tables before loading data.
- Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
None.

This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

==============================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time= GETDATE();
		PRINT '===============================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===============================================================';




		PRINT'-----------------------------------------------------------------';
		PRINT'Loding CRM Tables';
		PRINT'-----------------------------------------------------------------';


		-- bulk insert of cust_info
		SET @start_time= GETDATE();
		PRINT'>>  Truncating Table:bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT'>>  Inserting Data into:bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\Admin\Downloads\data\Sql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR= ',',
			TABLOCK
			);
		SET @end_time= GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------------------------';

		-- bulk insert of dales_details
		SET @start_time= GETDATE();
		PRINT'>>  Truncating Table:bronze.crm_dales_details';
		TRUNCATE TABLE bronze.crm_dales_details;
		PRINT'>>  Inserting Data into:bronze.crm_dales_details';
		BULK INSERT bronze.crm_dales_details
		FROM 'C:\Users\Admin\Downloads\data\Sql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\dales_details.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR= ',',
			TABLOCK
			);
		SET @end_time= GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------------------------';

		-- bulk insert of prd_ino
		SET @start_time= GETDATE();
		PRINT'>>  Truncating Table:bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		PRINT'>>  Inserting Data into:bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\Admin\Downloads\data\Sql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR= ',',
			TABLOCK
			);
		SET @end_time= GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------------------------';

		PRINT'-----------------------------------------------------------------';
		PRINT'Loding ERP Tables';
		PRINT'-----------------------------------------------------------------';

		-- bulk insert of cust_az12
		SET @start_time= GETDATE();
		PRINT'>>  Truncating Table:bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		PRINT'>>  Inserting Data into:bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\Admin\Downloads\data\Sql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR= ',',
			TABLOCK
			);
		SET @end_time= GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------------------------';

		-- bulk insert of loc_a101
		SET @start_time= GETDATE();
		PRINT'>>  Truncating Table:bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		PRINT'>>  Inserting Data into:bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\Admin\Downloads\data\Sql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR= ',',
			TABLOCK
			);
		SET @end_time= GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------------------------';

		-- bulk insert of px_cat_g1v2
		SET @start_time= GETDATE();
		PRINT'>>  Truncating Table:bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		PRINT'>>  Inserting Data into:bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\Admin\Downloads\data\Sql\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW= 2,
			FIELDTERMINATOR= ',',
			TABLOCK
			);
		SET @end_time= GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '---------------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '============================================';
		PRINT 'Loading Bronze Layer is Completed';
		PRINT 'Total Load Duration: '+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';

		END TRY
		BEGIN CATCH
			PRINT '============================================';
			PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER';
			PRINT'Error MESSAGE' + ERROR_MESSAGE();
			PRINT'Error MESSAGE' + CAST (ERROR_NUMBER() AS NVARCHAR);
			PRINT '============================================';

		END CATCH  

	
END
	
