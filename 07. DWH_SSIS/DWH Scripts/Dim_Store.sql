USE SupplyChain_DWH

go

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  NAME = 'Dim_Store'
                  AND type = 'U')
  DROP TABLE Dim_Store

go

CREATE TABLE Dim_Store
  (
     Store_SK           INT NOT NULL IDENTITY(1, 1),-- surrogate key
     Store_BK           INT NOT NULL,--alternate key, business key
     Latitude            decimal(18, 8),
	 Longitude           decimal(18, 8),
     
     -- Metadata
      SSC                 TINYINT NOT NULL,
     -- SCD
     start_date          DATETIME NOT NULL DEFAULT (Getdate()),
     end_date            DATETIME,
     is_current          TINYINT NOT NULL DEFAULT (1),
     CONSTRAINT pk_Dim_Store PRIMARY KEY CLUSTERED ( Store_SK )
  );


-- NonClustered Index on Product_ID for faster lookups
CREATE UNIQUE NONCLUSTERED INDEX IDX_Store_BK ON Dim_Store(Store_BK);

