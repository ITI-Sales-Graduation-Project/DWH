USE SupplyChain_DWH

go

IF EXISTS (SELECT *
           FROM   sys.tables
           WHERE  NAME = 'Fact_Sales')
  DROP TABLE Fact_Sales;
go

CREATE TABLE Fact_Sales
  (
     DateKey       INT,
	 TimeKey       INT,
     FK_Product    INT NOT NULL,
     FK_Customer   INT NOT NULL,
     FK_Store      INT NOT NULL,
     FK_Order      INT NOT NULL,
	 OrderItem_BK   INT Not nULL,
     Quantity       INT,
     ProductPrice     decimal(18, 2),
     Discount           decimal(18, 2),
     Sales              decimal(18, 2),
     Total_Sales        decimal(18, 2),
     BenifitPerOrder    decimal(18, 2),
    
    
     CONSTRAINT pk_Fact_Sales PRIMARY KEY CLUSTERED (OrderItem_BK),
	 	 CONSTRAINT fk_Fact_Sales_Dim_Order FOREIGN KEY (FK_Order) REFERENCES Dim_Order(Order_SK),
     CONSTRAINT fk_Fact_Sales_Dim_Product FOREIGN KEY (FK_Product) REFERENCES Dim_Product(Product_SK),
     CONSTRAINT fk_Fact_Sales_Dim_Customer FOREIGN KEY (FK_Customer) REFERENCES Dim_Customer(Customer_SK),
     CONSTRAINT fk_Fact_Sales_Dim_Store FOREIGN KEY (FK_Store) REFERENCES Dim_Store(Store_SK),
     CONSTRAINT fk_Fact_Sales_DimDate FOREIGN KEY (DateKey) REFERENCES DimDate([DateSK]),
	 CONSTRAINT fk_Fact_Sales_DimTime FOREIGN KEY (TimeKey) REFERENCES DimTime([TimeSK])
  );


-- Index on Product_Key for faster lookups on product-related queries
CREATE NONCLUSTERED INDEX IDX_Product_Key ON Fact_Sales (FK_Product);

-- Index on Customer_Key for faster lookups on customer-related queries
CREATE NONCLUSTERED INDEX IDX_Customer_Key ON Fact_Sales (FK_Customer);

-- Index on Store_Key for faster lookups on store-related queries
CREATE NONCLUSTERED INDEX IDX_Store_Key ON Fact_Sales (FK_Store);

-- Index on Order_Key for faster lookups on order-related queries
CREATE NONCLUSTERED INDEX IDX_Order_Key ON Fact_Sales (FK_Order);

