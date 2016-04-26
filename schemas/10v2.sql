DROP TABLE IF EXISTS pluto_10v2;

create table pluto_10v2 (
  Borough text,
  Block integer,
  Lot integer,
  CD smallint,
  CT2000 text,
  CB2000 text,
  SchoolDist smallint,
  Council smallint,
  ZipCode char(5),
  FireComp text,
  HealthArea text,
  HealthCtr text,
  PolicePrct text,
  Address text,
  ZoneDist1 text,
  ZoneDist2 text,
  ZoneDist3 text,
  ZoneDist4 text,
  Overlay1 text,
  Overlay2 text,
  SPDist1 text,
  SPDist2 text,
  LtdHeight text,
  AllZoning1 text,
  AllZoning2 text,
  SplitZone boolean,
  BldgClass char(2),
  LandUse smallint,
  Easements integer,
  OwnerType char(1),
  OwnerName text,
  LotArea bigint,
  BldgArea bigint,
  ComArea bigint,
  ResArea bigint,
  OfficeArea bigint,
  RetialArea bigint,
  GarageArea bigint,
  StrgeArea bigint,
  FactryArea bigint,
  OtherArea bigint,
  AreaSource text,
  NumBldgs integer,
  NumFloors numeric,
  UnitsRes integer,
  UnitsTotal integer,
  LotFront numeric,
  LotDepth numeric,
  BldgFront numeric,
  BldgDepth numeric,
  ProxCode char(1),
  IrrLotCode boolean,
  LotType char(1),
  BsmtCode char(1),
  AssessLand bigint,
  AssessTotal bigint,
  ExemptLand bigint,
  ExemptTotal bigint,
  YearBuilt smallint,
  BuiltCode char(1),
  YearAlter1 smallint,
  YearAlter2 smallint,
  HistDist text,
  Landmark text,
  BuiltFAR numeric,
  MaxAllwFAR numeric,
  BoroCode char(1),
  BBL char(10),
  CondoNo text,
  Tract2000 text, 
  XCoord integer,
  YCoord integer,
  ZoneMap text,
  ZMCode char(1),
  Sanborn text,
  TaxMap text,
  EDesigNum text,
  APPBBL char(10),
  APPDate date,
  RPADDate text,
  DCASDate text,
  ZoningDate text,
  MajPrpDate text,
  LandmkDate text,
  DTMDate text,
  MASDate text,
  PoliDate text,
  EDesigDate text,
  PLUTOMapID char(1)
);
