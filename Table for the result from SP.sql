USE [master]
GO

ALTER TABLE [dbo].[t_finalresult] DROP CONSTRAINT [DF__t_billing__last___23893F36]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[t_finalresult]') AND type in (N'U'))
DROP TABLE [dbo].[t_finalresult]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[t_finalresult](
	[id_referensi] [int] NOT NULL,
	[customer_id] [varchar](100) NULL,
	[kode_tabung] [varchar](50) NULL,
	[tanggal_kirim] [datetime] NULL,
	[tanggal_ambil] [datetime] NULL,
	[isi_awal] [float] NULL,
	[isi_akhir] [float] NULL,
	[co2] [float] NULL,
	[n2] [float] NULL,
	[specific_gravity] [float] NULL,
	[t_awal] [float] NULL,
	[t_akhir] [float] NULL,
	[fpv2_awal] [float] NULL,
	[fpv2_akhir] [float] NULL,
	[vol_awal_sm3] [float] NULL,
	[vol_akhir_sm3] [float] NULL,
	[volume_total_sm3] [float] NULL,
	[harga_satuan] [float] NULL,
	[total_tagihan_idr] [float] NULL,
	[last_sync] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id_referensi] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[t_finalresult] ADD  DEFAULT (getdate()) FOR [last_sync]
GO


