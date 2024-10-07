USE SupplyChain_DWH

go

-- Drop and create the table
IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  NAME = 'Dim_Order'
                  AND type = 'U')
  DROP TABLE Dim_Order

go

CREATE TABLE Dim_Order
  (
     Order_SK                INT NOT NULL IDENTITY(1, 1),-- surrogate key
     Order_BK                 INT NOT NULL,--alternate key, business key
     Order_City               NVARCHAR(255),
     Order_State              NVARCHAR(255),
	 Order_Country            NVARCHAR(255),
	 Order_Zipcode            INT NULL,
	 Real_DayForShipping      INT NULL,
	 Schedule_DayForShipment  INT NULL,
	 LateDeliveryRisk         INT NULL,
	 Order_Date               datetime,
     Shipping_Date            datetime,

	 Market_BK                INT NOT NULL, --businessKey
	 Market_Name              NVARCHAR(255),
	 Rejon_BK                 INT NOT NULL, --businessKey
	 Rejon_Name               NVARCHAR(255),
     Payment_BK               INT NOT NULL, --businessKey
	 Payment_Type             NVARCHAR(255),
	 Delivery_Status_BK       INT NOT NULL, --businessKey
	 Delivery_Status          NVARCHAR(255),
	 Ship_Mode_BK            INT NOT NULL, --businessKey
	 Ship_Mode                NVARCHAR(255),
	 Order_Status_BK          INT NOT NULL,--businessKey
	 Order_Status             NVARCHAR(255),

     -- Metadata
     SSC  TINYINT NOT NULL,
     -- SCD
     start_date          DATETIME NOT NULL DEFAULT (Getdate()),
     end_date            DATETIME,
     is_current          TINYINT NOT NULL DEFAULT (1),
     CONSTRAINT pk_Dim_Order PRIMARY KEY CLUSTERED (Order_SK)
  );


-- NonClustered Index on Order_ID for faster lookups
CREATE UNIQUE NONCLUSTERED INDEX IDX_Order_BK ON Dim_Order (Order_BK);

-- NonClustered Index on Market_ID for faster category-based queries
CREATE NONCLUSTERED INDEX IDX_Market_BK ON Dim_Order (Market_BK);

-- NonClustered Index on Rejon_ID  for faster category-based queries
CREATE NONCLUSTERED INDEX IDX_Rejon_BK  ON Dim_Order (Rejon_BK );

-- NonClustered Index on Payment_ID  for faster category-based queries
CREATE NONCLUSTERED INDEX IDX_Payment_BK  ON Dim_Order (Payment_BK );

-- NonClustered Index on Delivery_Status_ID  for faster category-based queries
CREATE NONCLUSTERED INDEX IDX_Delivery_Status_BK  ON Dim_Order (Delivery_Status_BK );

-- NonClustered Index on Ship_Mode_IDfor faster category-based queries
CREATE NONCLUSTERED INDEX IDX_Ship_Mode_BK ON Dim_Order (Ship_Mode_BK);

-- NonClustered Index on Order_Status_ID  for faster category-based queries
CREATE NONCLUSTERED INDEX IDX_Order_Status_BK  ON Dim_Order (Order_Status_BK );


