
CREATE EXTERNAL TABLE [dbo].[dimWeatherObservationSites_EXT]
(
	[StationId] [nvarchar](20) NOT NULL,
	[SourceAgency] [nvarchar](10) NOT NULL,
	[StationName] [nvarchar](150) NULL,
	[CountryCode] [varchar](2) NULL,
	[CountryName] [nvarchar](150) NULL,
	[StatePostalCode] [varchar](3) NULL,
	[FIPSCountyCode] [varchar](5) NULL,
	[StationLatitude] [decimal](11, 8) NULL,
	[StationLongitude] [decimal](11, 8) NULL,
	[NWSRegion] [nvarchar](30) NULL,
	[NWSWeatherForecastOffice] [nvarchar](20) NULL,
	[GroundElevation_Ft] [real] NULL,
	[UTCOffset] [nvarchar](10) NULL
)
WITH
(DATA_SOURCE = [Ready_store],
LOCATION = N'loading/dimWeatherObservationSites',
FILE_FORMAT = [TextFileFormat_Ready],
REJECT_TYPE = VALUE,
REJECT_VALUE = 0)
GO

CREATE TABLE [dbo].[dimWeatherObservationSites]
WITH
(
	DISTRIBUTION = REPLICATE,
	HEAP
)
AS SELECT * FROM [dbo].[dimWeatherObservationSites_EXT]
GO

CREATE TABLE [dbo].[factWeatherMeasurements]
WITH
(
	DISTRIBUTION = HASH([fpscode])
	)
AS SELECT * FROM [staging].[STG_text_load]
GO