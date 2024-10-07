USE SupplyChain_DWH

go

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  NAME = 'Dim_Customer'
                  AND type = 'U')
  DROP TABLE Dim_Customer

go

CREATE TABLE Dim_Customer
  (
     Customer_SK         INT NOT NULL IDENTITY(1, 1),-- surrogate key
     Customer_BK          INT NOT NULL,--alternate key, business key
     Fname               NVARCHAR(255),
     Lname               NVARCHAR(255),
	 Cust_Street         NVARCHAR(255),
	 Cust_City           NVARCHAR(255),
	 Cust_State          NVARCHAR(255),
	 Cust_Country        NVARCHAR(255),
	 Zipcode             INT,
     Segment_BK          INT not null,
     Segment_Name        NVARCHAR(255),
     -- Metadata
     SSC                 TINYINT NOT NULL,
     -- SCD
     start_date          DATETIME NOT NULL DEFAULT (Getdate()),
     end_date            DATETIME,
     is_current          TINYINT NOT NULL DEFAULT (1),
     CONSTRAINT pk_Dim_Customer PRIMARY KEY CLUSTERED (Customer_SK)
  );


-- NonClustered Index on Customer_ID for faster lookup
CREATE UNIQUE NONCLUSTERED INDEX IDX_Customer_SK ON Dim_Customer (Customer_SK);

-- NonClustered Index on Segment_ID for fater query
CREATE NONCLUSTERED INDEX IDX_Segment_BK ON Dim_Customer (Segment_BK);
