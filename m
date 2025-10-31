Return-Path: <linux-spi+bounces-10928-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA1CC238C8
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 08:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631601A6375E
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 07:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C38A329E7F;
	Fri, 31 Oct 2025 07:30:13 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022112.outbound.protection.outlook.com [40.107.75.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D3329E44;
	Fri, 31 Oct 2025 07:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895813; cv=fail; b=deE4rjM4WpE7/jYgPW8Juw6sCTlTL+yRBE/wDkQRz8bOc3GS3qnajo8E5qFKfzFE1hw17e25kWwkaxHCbgJqVytUiR8SaTZ0p/x8IjNc6Fkjy32kQaMPPkFMGquE3QZ4GLN4HwZO9DcqSHGEBN6r1Kd4cZ2Jhxl7R5wOAA4lmbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895813; c=relaxed/simple;
	bh=VkH7qvCLQOtyLje/bgY2elPfc05szlSZ9xbEO5HIhGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aeYmkZjnN1avVin+p7h8eePwPLfj6QvRCxZL03XVogCiTN/ncs0T80vprQDEr5o8ptZpMbfByGBCCLN8mm49Pcwq/ypgq2spCFIICMgaOG8flNVHs5LZpcaJa/B1BNrtO+PUVgSp0jeYG0/NePlCldCwu7W08DuprE04FTgbELs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=40.107.75.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DT+3CV1mMtqdqJwmcffGLt/UYd6bEsHZ1wBFKlBCD9oN6L43hXPfr43ERo7pce+RuJIWRLSQiES5gJyvYA/sJwNp17rze+1wM/a2qzOIc4Q/OEt3+5TlnM9zwKTWCAXoSZer13g/ndrA1y8TQh5sjFdzQCDuxyamor6aSLIVzUsJy1es5valrr0aBuWxbIhcJpKtGw4N0zx4J/gf1ac8edh8w9ko+92QOpEnKqvunPmUTsZnVoWeWAiHy3yknmKZHIXbBCaJK9Je31E1rBRXLxLcoV3FHOoRo6ZEngO/nUL223GDZoLV9eU+jUio2HVGfX9N73GsqLSioD6jjXItuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wce4tNWUEqmy3zx/t/UI+3vfZvOd9+aZ0wiSmODCESU=;
 b=PoKi3yiqoyfEzGaxJ0INIvgdAfU23CvLw/go5UzF75AoRnrpkTKUxNq+auen+qatH9lW2oIfF4pRzqLvOw4h311F1wjhknwDcx5bSpsqJj7zJcZ+Pv87/B6lxTvjx2z9AU+lbRDR2EFZP8Yb4LbT2Za4ABy6VsIPMtRvtTzZIdQsElHKgVNoL0L5bQqUjLharuW9EeC5Yogfmjpg/OW85l7QMD4WcREHEt+L+yGjSLEASy9+DnP3IQUVC0Fh5NrRUnFOnXVubV8MQwN/Dn981amMoJT0PzQLMK9NprEdB531E+h+TIS6q3jZTNr2dodHFg/vCZdK9yZwp2fOem0c3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=amd.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR02CA0035.apcprd02.prod.outlook.com (2603:1096:300:59::23)
 by KL1PR06MB6323.apcprd06.prod.outlook.com (2603:1096:820:e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 07:30:06 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:300:59:cafe::ae) by PS2PR02CA0035.outlook.office365.com
 (2603:1096:300:59::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 07:30:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 07:30:05 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 39DB240A5A13;
	Fri, 31 Oct 2025 15:30:04 +0800 (CST)
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
Subject: [PATCH v3 2/3] spi: spi-cadence: supports transmission with bits_per_word of 16 and 32
Date: Fri, 31 Oct 2025 15:30:02 +0800
Message-Id: <20251031073003.3289573-3-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251031073003.3289573-1-jun.guo@cixtech.com>
References: <20251031073003.3289573-1-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|KL1PR06MB6323:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 274f1441-788f-4026-eaf7-08de184f4fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?icQTyGzeVqAwkXUioE9vOxvi6wfZwjsJ8vi5ljIxxP9BD3JjMHZCnBx6qRes?=
 =?us-ascii?Q?RBiIuisz7kgNeb5ZUoko6/bmPEOeEHHXiiLRUW3R/gM4LeJAAXjcgwSFnriK?=
 =?us-ascii?Q?NUhzbOAVJcyzUbK1hCnLaXxRPwoFZAGu7LwmbjEwTciRv2pWvwRgLN9T+2Ir?=
 =?us-ascii?Q?ONJaQKtw/UgOCvskEIw3ruf/whpROuP6np2762+eNodmfV09rvG/otPhmhEx?=
 =?us-ascii?Q?sQKn0SlrVjby6oMZbk7I+12Kj5Gr9ppTlnyBiQIEfrwYSQHl22QHwzjauQo+?=
 =?us-ascii?Q?DXG1NWXhzZSAd2DDMjuFJFDBXrgP0UqQ10GydCfdiqF4XNhLQ+ydmCc3q3ya?=
 =?us-ascii?Q?OI8vqLuugYRg7Akc32fek0awCbK1n5/1CSGp27VZo3RZpkYzg2Og3xF8Ethp?=
 =?us-ascii?Q?qj55s/8XMhvk8+tEQDK5h0yhx1T2y4JBktlEVZB/xpXufr0a7uEEmtcMkK1u?=
 =?us-ascii?Q?qHmneGsiJGsvW56DiXzvwjHIBGW1g/qt7AfUsrC6NQ9crIY2YowH7gfpGS5j?=
 =?us-ascii?Q?E4QBeOv87+MyE9fV1V2rPeVEjSSY1D1Pb24lcuApF16XY3lZW6g46u549DJ0?=
 =?us-ascii?Q?0U6/F/IYf26KPC9YTBEjgeblBby1zNcuHlcklcnOSfO3ZvObiC9/Rj7nqpvf?=
 =?us-ascii?Q?zN2WgbH+lHfoP/qqXMVjsgWvqJ2qpHLYgpJMrz6wotsf/MhGTNdqvEUeiAFs?=
 =?us-ascii?Q?jiVGnNlRdtePYBf2lvR9ffAv55ZPSXf7VVJ2H3FYqAHhgsZK4rTD/Nso+4S0?=
 =?us-ascii?Q?avghhxa4+II8GVsMj0iafe6WV/yrjyBLEmeZA0lXg3xf1nQxAQQgKLoFKRra?=
 =?us-ascii?Q?1vZETjRBVZPsd1C1QoCuxNBWHdKhCDv4wleLxsHVl3R3zJwOl5MYck+5hFum?=
 =?us-ascii?Q?hvJRbpG0qgU9LBC7p0LRw1j/vVWE8BzsXsucQzuEdNMVIcOLF8cxsXIV1xXg?=
 =?us-ascii?Q?qq9Hj8BqUqKWH5pk94pMg50RStRQALqJ2cB0DmKB8alSgFSggJO4XnpSyB0x?=
 =?us-ascii?Q?w8fXKVk+SpMhkK5aQk21RRFJYSkcUoo9fBxuz4MkBcV+po4PjcIEYToPOexp?=
 =?us-ascii?Q?4n9cr9kfMxs3RY/8OFm+aaMpSBwF2TdWnabA51qQVM045COLCDx6c9xerz2e?=
 =?us-ascii?Q?oqIynG3jAh9xXyFHAFSRk1Gq3iGgFj415sZYOYk5MIcQUtWU6z2Qs9i5Dj27?=
 =?us-ascii?Q?xx1axw7cK2nw9xIgeQ7xC5MXfET6q0+5q9iJ+HBCjSLarfP8HtJFbpd+xGH4?=
 =?us-ascii?Q?bNrhVJKgdKrwqfIh7O0iNJqsm+Qrg/ybY0pm6PnHCTwPZZHcD+LpBCexszHo?=
 =?us-ascii?Q?4QOFslERrHFa1fyJvyR4EgdA5FFWglTlCZ+KxpGKKGTduzM4meu75rUCYL6A?=
 =?us-ascii?Q?ufv5hvabotL8pt+pwfa0kH9Vthonbtk7gpimXh143dF4ssAzCc/SYJK4gNHX?=
 =?us-ascii?Q?hoZI98ShTvB3gLsbeKzdSjhFROQCKElTjoEv3r8O2sQ5PMvGliUX/RSf1xPd?=
 =?us-ascii?Q?cVYPRcVo/in/XTkzXUe6d7qFK+wZJCm3s8OlqJ91JYd+BAfn3Rswc5tHjBKz?=
 =?us-ascii?Q?Zb7kaXt8qZH2NzK9m3I=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 07:30:05.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 274f1441-788f-4026-eaf7-08de184f4fdc
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6323

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


