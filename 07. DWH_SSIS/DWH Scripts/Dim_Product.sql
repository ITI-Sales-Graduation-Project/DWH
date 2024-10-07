USE SupplyChain_DWH

go

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  NAME = 'Dim_Product'
                  AND type = 'U')
  DROP TABLE Dim_Product

go

CREATE TABLE Dim_Product
  (
     Product_SK         INT NOT NULL IDENTITY(1, 1),-- surrogate key
     Product_BK          INT NOT NULL,--alternate key, business key
     Product_Name        NVARCHAR(255),
     Product_Price       decimal(7,2),
     Category_BK         int not null,
     Category_Name       NVARCHAR(255),
     Department_BK       INT NOT NULL,
     Department_Name     NVARCHAR(255),
     -- Metadata
      SSC  TINYINT NOT NULL,
     -- SCD
     start_date          DATETIME NOT NULL DEFAULT (Getdate()),
     end_date            DATETIME,
     is_current          TINYINT NOT NULL DEFAULT (1),
     CONSTRAINT pk_Dim_Product PRIMARY KEY CLUSTERED (Product_SK)
  );


-- NonClustered Index on Product_ID for faster lookup
CREATE UNIQUE NONCLUSTERED INDEX IDX_FK_Product ON Dim_Product (Product_SK);

-- NonClustered Index on Category_ID for faster category queries
CREATE NONCLUSTERED INDEX IDX_Category_BK ON Dim_Product (Category_BK);

-- NonClustered Index on Department_ID for faster department queries
CREATE NONCLUSTERED INDEX IDX_Department_BK ON Dim_Product (Department_BK);