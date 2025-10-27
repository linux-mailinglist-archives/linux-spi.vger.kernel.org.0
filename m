Return-Path: <linux-spi+bounces-10842-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B98C0C634
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 09:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6971891F4E
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AE22F5473;
	Mon, 27 Oct 2025 08:42:50 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022093.outbound.protection.outlook.com [40.107.75.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D012F068F;
	Mon, 27 Oct 2025 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554570; cv=fail; b=rCEKbJAVC3vahwOcefLhCq4ZhP6VQOGHfbLvnJ6E2VQ7F8vO0zW3Q8cxJsLzm48GwKqfEXraTGTMEKrKbLFi2KAQEr9Sov5V+kQoYf/KIXKkAYRXFGOtmbfl/NR+iv62VJhpb+WBUuJjdK1RW+mDiKd9G99VZDUdTZoEZBqJq3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554570; c=relaxed/simple;
	bh=VkH7qvCLQOtyLje/bgY2elPfc05szlSZ9xbEO5HIhGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxXF1G64xzHmlG/higfmQVJ92i+lL/QRAV7qeT+7iE1A9XtmQQIZQXzjQexOuj2AJYLs+GKXELiftTS/1lAaZA+/Oowo/HaH/yo820FdrHpSwAJ8JJ7LWj1OIdwgpZvmDAqFtNlRsWy/FluE01D9UhEt3AOjSRkuBDQtg+xSHGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KOi/CkJbPkWlQuKHdNoJhC6Kz1i9VpzdZ+KmAYEx9UvvDexeGl2Lc4L0wGvl1pWjgc7hAIOnHEVgsRfpflmjrAPRFada5UaScOWwaZQuCPkQNrQE9z9anCGW4nbTFV3Je4ZB8emZJVyv3A7ALqPcFgjj2licTvo+SpNc8DVA8yvxc5Tkz2EFSVpKSYq58DgV2auOz9iZDYogk4Ynl6MYd9XW1yPIlQ3U07P73wVDJzaHlGVVSYAh7Kl6sUVCy4iU4NIRoshIOHowLpUB0UxJH/CCX3a+g/jWqwtPXLsoyvKJnUVjyD+FvdjxEI35KOdn330bx6AfjvJAacP+cAYUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wce4tNWUEqmy3zx/t/UI+3vfZvOd9+aZ0wiSmODCESU=;
 b=MIeAJpal4L61Ym+bRPeNyHDhkUcT2veLEgBnzWcvXcGKjhDXY12rEf7VDHtW3LeE8jRqvEjrEMcaAX+MiQH8IaI9XXL8y0KhoVNQWMLJPMzSpxSKI9M8BmKutxNyVjd43JOU/I8AdnyGS2n/0NCant1f4k6CMhnX00KVic3HtlT51+zbm2W+zBrDy+KOleWToTCqnHhmKOOqmHcOiaQVp3L+T5WLLpPwix6moK44wEFqve818FIJXSimnrTBlIZgIIqJ5P1eC4dajBXy/ztZqitYdokHo1ja2J/TL3+iQg5LHdcASUjHeRrEKoqLm/0dbPfd4BBxwW2DpUGNAdGREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0030.apcprd02.prod.outlook.com (2603:1096:4:195::17)
 by PUZPR06MB6248.apcprd06.prod.outlook.com (2603:1096:301:119::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 08:42:43 +0000
Received: from SG2PEPF000B66CE.apcprd03.prod.outlook.com
 (2603:1096:4:195:cafe::78) by SI2PR02CA0030.outlook.office365.com
 (2603:1096:4:195::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.18 via Frontend Transport; Mon,
 27 Oct 2025 08:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CE.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Mon, 27 Oct 2025 08:42:43 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 2FFDB40A5A13;
	Mon, 27 Oct 2025 16:42:41 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	michal.simek@amd.com,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH v2 3/3] spi: spi-cadence: supports transmission with bits_per_word of 16 and 32
Date: Mon, 27 Oct 2025 16:42:39 +0800
Message-Id: <20251027084239.2610141-4-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027084239.2610141-1-jun.guo@cixtech.com>
References: <20251027084239.2610141-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CE:EE_|PUZPR06MB6248:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 713d70e3-f47c-47d2-b083-08de1534cbbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wtE97W30gffDFkP/pjTygiUnREAMDUEua7h7DUEAoVxAnXVqrl0bbQyrF2yt?=
 =?us-ascii?Q?jc3KQ7oU0TROZWFHnb9J+BqVbf5Cn+muFSeYmkBEsF72y0Ir0EchbZzRuhRu?=
 =?us-ascii?Q?pY4wSZdlKhAdimxcB/f2jgrpxdl5m824VQ0L2LZzx8VztVxTpzvtMrOPQSXR?=
 =?us-ascii?Q?qEYzdVgqWNVTZ6DNVopk76xq0rMii3AzP9/diJgSqBkrWYsoO+aKSpeOA5XB?=
 =?us-ascii?Q?ACA2v1BURULDOt2eOkLbLqXkKyvJgaSgGxFn7DcN4opJD4ThiH3KuzsF+jmF?=
 =?us-ascii?Q?NGc1sLQnBR3AimAI1oW+wFKa2rokl22nZaiyw3Oe/Z0uxh9gimm0jp7Pmh/2?=
 =?us-ascii?Q?sX1usXY2wCOnG+mK9D1UxJNwbUoN0dQAS0//yt9Ee8QXCIlHXwu0RRBg9gdS?=
 =?us-ascii?Q?8NTFvY6WA48fh2lRx0evaBr4eHOLCIa0HfvsBW/gdlXgUmksAmYeifWAnZ+K?=
 =?us-ascii?Q?+e/Q3+BuWPdrZtjEfMICvmgxDEsvZBfxYyGJ3JlcbuiBNcpLqbWEbGL6WN+P?=
 =?us-ascii?Q?eS77VgvSuggFhg8Vo0tTXTh2ZDX7iZaV7ilF/PD1fJZ5pEov6mDhyDBr3hbq?=
 =?us-ascii?Q?f+bRrkYS9Q58dCNlf9C60O++AChZGX/IBhcv+Ghuutl+M/MNsX3FGhE76hkc?=
 =?us-ascii?Q?Qp9EJ4YjlNq93c0d/PEAQ+aJEhFXRULcOzMUYDjyb8CGuRuB0U3+Jdz66SFC?=
 =?us-ascii?Q?wj5G1qUENyyx8suYHAU04yL8ri+KtN48uSKmu8iWt9hYcK9bhAYIk0P/Bszg?=
 =?us-ascii?Q?QgshmJmrCZnP7sN1bWGYUBFrbw0ot9c4Cw/uvd6SX7pR7PXgIR42sNRfJZJw?=
 =?us-ascii?Q?0KHN1ges8ydN1R7mEmcsHf+K0JupyuLQ1GlJkLZYhZSfqWi3K1d0n0hQclod?=
 =?us-ascii?Q?SptXYRisDdXHac4IpcVzXjtX4qKUfq9OlJEuszhnETzz95Z/x+jxifRr4bQa?=
 =?us-ascii?Q?GrcO4Omw3XzyKEGX3UMsSvO9MhrCNpYKY8EG1N4LWMBN5WjTSH9rhpmiJctE?=
 =?us-ascii?Q?eVtEfNIK+p/C+v5bLNpzDl8aQaY0xKsFHDmFoWS9BET/dj4Cfx5wSdzXhUBX?=
 =?us-ascii?Q?aLlkW/WCvKZcNK5KxswBfJG/nLkrQltsxqudqUmjmQRyrfvnQ/3dz8mdV2jp?=
 =?us-ascii?Q?dBYXlZnOgPv2Mmo2odaLLWDUCUkV55P+Dln7O0gTJxjy8mddQGKuNHTC6pUS?=
 =?us-ascii?Q?Ck622U933sBkrpWW9/yYAjs6iBrvPyiFEkZTUC1GPxR8/j64YWeEluzJScVT?=
 =?us-ascii?Q?p7ddq4LsJzFOVBm2otQ48gtyjZMoPCbovcUUD/jEMOTBt6EKOhK07TvaCOCa?=
 =?us-ascii?Q?eqTpmcuwAPYTaZ6OHnXDioTH/2stS7Q94SYu1z4cnFlgok5WaCvwVuTM7MnZ?=
 =?us-ascii?Q?Pai5tAp2RXzr/7JpLZtkYlnHj/Jv3rwBKFdl2MZhZAYMgMudFi+Zk1ckiMX1?=
 =?us-ascii?Q?phGmIwM1OXmHJ9Q34NlW66HOGEbcsxGU+fT0EEnOefuhbUpFUD/0m9Fd21Vo?=
 =?us-ascii?Q?03MoPPCsATspEPX32bIhUJSTxRtPf6hHwSB9lptFjFNyOMFky2cWU9Fe6fWk?=
 =?us-ascii?Q?1Dg5NFbmNGK/HBybmtc=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 08:42:43.1999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713d70e3-f47c-47d2-b083-08de1534cbbc
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CE.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6248

The default FIFO data width of the Cadence SPI IP is 8 bits, but
the hardware supports configurations of 16 bits and 32 bits.
This patch enhances the driver to support communication with both
16-bits and 32-bits FIFO data widths.

Signed-off-by: Jun Guo <jun.guo@cixtech.com>
---
 drivers/spi/spi-cadence.c | 106 +++++++++++++++++++++++++++++++++-----
 1 file changed, 93 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 5ae09b21d23a..47054da630d0 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -109,6 +109,7 @@
  * @rxbuf:		Pointer to the RX buffer
  * @tx_bytes:		Number of bytes left to transfer
  * @rx_bytes:		Number of bytes requested
+ * @n_bytes:		Number of bytes per word
  * @dev_busy:		Device busy flag
  * @is_decoded_cs:	Flag for decoder property set or not
  * @tx_fifo_depth:	Depth of the TX FIFO
@@ -120,16 +121,24 @@ struct cdns_spi {
 	struct clk *pclk;
 	unsigned int clk_rate;
 	u32 speed_hz;
-	const u8 *txbuf;
-	u8 *rxbuf;
+	const void *txbuf;
+	void *rxbuf;
 	int tx_bytes;
 	int rx_bytes;
+	u8 n_bytes;
 	u8 dev_busy;
 	u32 is_decoded_cs;
 	unsigned int tx_fifo_depth;
 	struct reset_control *rstc;
 };
 
+enum cdns_spi_frame_n_bytes {
+	CDNS_SPI_N_BYTES_NULL = 0,
+	CDNS_SPI_N_BYTES_U8 = 1,
+	CDNS_SPI_N_BYTES_U16 = 2,
+	CDNS_SPI_N_BYTES_U32 = 4
+};
+
 /* Macros for the SPI controller read/write */
 static inline u32 cdns_spi_read(struct cdns_spi *xspi, u32 offset)
 {
@@ -305,6 +314,78 @@ static int cdns_spi_setup_transfer(struct spi_device *spi,
 	return 0;
 }
 
+static u8 cdns_spi_n_bytes(struct spi_transfer *transfer)
+{
+	if (transfer->bits_per_word <= 8)
+		return CDNS_SPI_N_BYTES_U8;
+	else if (transfer->bits_per_word <= 16)
+		return CDNS_SPI_N_BYTES_U16;
+	else
+		return CDNS_SPI_N_BYTES_U32;
+}
+
+static inline void cdns_spi_reader(struct cdns_spi *xspi)
+{
+	u32 rxw = 0;
+
+	if (xspi->rxbuf && !IS_ALIGNED((uintptr_t)xspi->rxbuf, xspi->n_bytes)) {
+		pr_err("%s: rxbuf address is not aligned for %d bytes\n",
+		       __func__, xspi->n_bytes);
+		return;
+	}
+
+	rxw = cdns_spi_read(xspi, CDNS_SPI_RXD);
+	if (xspi->rxbuf) {
+		switch (xspi->n_bytes) {
+		case CDNS_SPI_N_BYTES_U8:
+			*(u8 *)xspi->rxbuf = rxw;
+			break;
+		case CDNS_SPI_N_BYTES_U16:
+			*(u16 *)xspi->rxbuf = rxw;
+			break;
+		case CDNS_SPI_N_BYTES_U32:
+			*(u32 *)xspi->rxbuf = rxw;
+			break;
+		default:
+			pr_err("%s invalid n_bytes %d\n", __func__,
+			       xspi->n_bytes);
+			return;
+		}
+		xspi->rxbuf = (u8 *)xspi->rxbuf + xspi->n_bytes;
+	}
+}
+
+static inline void cdns_spi_writer(struct cdns_spi *xspi)
+{
+	u32 txw = 0;
+
+	if (xspi->txbuf && !IS_ALIGNED((uintptr_t)xspi->txbuf, xspi->n_bytes)) {
+		pr_err("%s: txbuf address is not aligned for %d bytes\n",
+		       __func__, xspi->n_bytes);
+		return;
+	}
+
+	if (xspi->txbuf) {
+		switch (xspi->n_bytes) {
+		case CDNS_SPI_N_BYTES_U8:
+			txw = *(u8 *)xspi->txbuf;
+			break;
+		case CDNS_SPI_N_BYTES_U16:
+			txw = *(u16 *)xspi->txbuf;
+			break;
+		case CDNS_SPI_N_BYTES_U32:
+			txw = *(u32 *)xspi->txbuf;
+			break;
+		default:
+			pr_err("%s invalid n_bytes %d\n", __func__,
+			       xspi->n_bytes);
+			return;
+		}
+		cdns_spi_write(xspi, CDNS_SPI_TXD, txw);
+		xspi->txbuf = (u8 *)xspi->txbuf + xspi->n_bytes;
+	}
+}
+
 /**
  * cdns_spi_process_fifo - Fills the TX FIFO, and drain the RX FIFO
  * @xspi:	Pointer to the cdns_spi structure
@@ -321,23 +402,14 @@ static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
 
 	while (ntx || nrx) {
 		if (nrx) {
-			u8 data = cdns_spi_read(xspi, CDNS_SPI_RXD);
-
-			if (xspi->rxbuf)
-				*xspi->rxbuf++ = data;
-
+			cdns_spi_reader(xspi);
 			nrx--;
 		}
 
 		if (ntx) {
-			if (xspi->txbuf)
-				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
-			else
-				cdns_spi_write(xspi, CDNS_SPI_TXD, 0);
-
+			cdns_spi_writer(xspi);
 			ntx--;
 		}
-
 	}
 }
 
@@ -454,6 +526,10 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
 	if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
 		udelay(10);
 
+	xspi->n_bytes = cdns_spi_n_bytes(transfer);
+	xspi->tx_bytes = DIV_ROUND_UP(xspi->tx_bytes, xspi->n_bytes);
+	xspi->rx_bytes = DIV_ROUND_UP(xspi->rx_bytes, xspi->n_bytes);
+
 	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
 
 	cdns_spi_write(xspi, CDNS_SPI_IER, CDNS_SPI_IXR_DEFAULT);
@@ -654,6 +730,9 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
 
+	if (of_device_is_compatible(pdev->dev.of_node, "cix,sky1-spi-r1p6"))
+		ctlr->bits_per_word_mask |= SPI_BPW_MASK(16) | SPI_BPW_MASK(32);
+
 	if (!spi_controller_is_target(ctlr)) {
 		ctlr->mode_bits |=  SPI_CS_HIGH;
 		ctlr->set_cs = cdns_spi_chipselect;
@@ -797,6 +876,7 @@ static const struct dev_pm_ops cdns_spi_dev_pm_ops = {
 
 static const struct of_device_id cdns_spi_of_match[] = {
 	{ .compatible = "xlnx,zynq-spi-r1p6" },
+	{ .compatible = "cix,sky1-spi-r1p6" },
 	{ .compatible = "cdns,spi-r1p6" },
 	{ /* end of table */ }
 };
-- 
2.34.1


