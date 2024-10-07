USE master
go

IF Db_id('SupplyChain_DWH') IS NOT NULL
  DROP DATABASE SupplyChain_DWH;

CREATE DATABASE SupplyChain_DWH
go 