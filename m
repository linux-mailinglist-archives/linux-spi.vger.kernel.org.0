Return-Path: <linux-spi+bounces-10899-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BC4C1572F
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3945A1B24FE4
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA20C343D6E;
	Tue, 28 Oct 2025 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ALw8FZ9M"
X-Original-To: linux-spi@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F284333FE26;
	Tue, 28 Oct 2025 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665265; cv=fail; b=TKq7OQaUJ1tI5bn9Zf8/3HJYR6qarOGLXwhZxsZCOvPQqSOyqMxahTYDQWEp2ZJK1PyEn557uNHZwucWVYlHcLF7Nk4b79C0zUoLrSSvlL8oLDQOpsxHwlBX0PpDw2WGw+lYpjv0btdTSVz7Z9y4N7AFGLPZCEmyWp01v+Odchk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665265; c=relaxed/simple;
	bh=CuvqdSl2nkmmrI+FMApsh6wmDB+yHeeBl1VAdmNwRsU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqbhlcHKqaxV6712ydhTQXGon0sYbQHuydE6oB1JgIEP3Oyn+xl5r/3CQgr2HtQ5gzvSyW5KCWWHJ389mZs4KBOb+sqqvO9P+ufAGE0+0QN7N1fzc9LbzfaB/C0NVgvQn/opy8S/kOjJ8c2q5AE+2UTN0Uq+F3uzRFhezIcL9AE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ALw8FZ9M; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgFxejtgRUhN7ol7ORkWZ1AOFontJoxs9rAca4ikvAAJALC3BaAgDQ6fnlMpNyOGD+cHw0UnKDtaQtLQkrmqVBd7I0AMG912lUgWJGX9M+QV9grhOVVBIWXywsgKvjzJ+H574BunYdak9tw7rh6jv4AMrxsB7Zk4igZWd3OBcOsTQqFBgdkebQbiEWwpFdiYOdzSiLIZjugWLWLlTwseBs0afv6nC/0DhEWZhDAxrvIDtikUn7hlQ68p3jdKDuXB2sVaKmZrC53EdMsj4gKrjBTGajsKCXknVwE12uGTgRh+p9WSoro89ELo75sXWN6PCfI7IWNdfrj8YDDkCMXCug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tCjSBuUryYOM8imQmAcR08yeziUoZvmzheD+np5jb8=;
 b=HpTHMlauVtxFwoIa48Ng/uzUX5xQtN0i7TstobkDMtWccDJfxmr39X4dumIts2S5s3KvA362xnOAvdfMhz8lmn/87yGteurEytxS/fWZ2cczQwQQPF8OC5V3ZRCiQ4v9Vw6yY3KbiI5BSqCGzYe9lXAdy0yeMYV1MRefr7tKEx7WI4TmIAzlmni0EFpMj6S8AID+JwnTnWUjAVWcbjl5SXrmsTbLnBbm4Bncins1RTLR1Q7hO52B5JXzTAUHKzV23wkMBkGbgxVfU1NZrETinifwb+xwoGjSyzZz+DNhABOB83iYQczM6nrH4yHCOiHG3jyqLmNSymWji4Slw1dq0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tCjSBuUryYOM8imQmAcR08yeziUoZvmzheD+np5jb8=;
 b=ALw8FZ9MXTnY7wibzmsDYzMn5abaYZ0TPz2Dy9rmO2ZwtSBu/ZF2g8GWPo5sFllLSeN7nzFy67N8C76+HTNr13pRNmZXlE29r1DtmxBI6gm2GUzLOWMUTmOGADmUHRbdqnOE0sawnM4Bvm/U/C935GuzfUNPRpa4ngggJPsVC7IVhulF7lxU7XEdax1AXcM3FGeSh4O77zT/ukdTTcjY8odG6UWUaATmTtUhYLWIDS8vtUE1zBsG/Rq1uHlzajIWWWDSF/O39ZwlV6lFyroRujO3l+tUSUq2oTeAXHFHd8D4Du9NqyGPQdu/NM1wg2bEIKBHN1jQH0KTtxdJULkvlA==
Received: from SJ0PR13CA0236.namprd13.prod.outlook.com (2603:10b6:a03:2c1::31)
 by DM4PR12MB6301.namprd12.prod.outlook.com (2603:10b6:8:a5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Tue, 28 Oct
 2025 15:27:39 +0000
Received: from SJ5PEPF000001EC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::d7) by SJ0PR13CA0236.outlook.office365.com
 (2603:10b6:a03:2c1::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 15:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EC.mail.protection.outlook.com (10.167.242.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 28 Oct 2025 15:27:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 08:27:14 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Oct 2025 08:27:14 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 28 Oct 2025 08:27:10 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] spi: tegra210-quad: Check hardware status on timeout
Date: Tue, 28 Oct 2025 15:25:17 +0000
Message-ID: <20251028152517.4144609-4-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251028152517.4144609-1-va@nvidia.com>
References: <20251028152517.4144609-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EC:EE_|DM4PR12MB6301:EE_
X-MS-Office365-Filtering-Correlation-Id: 64530823-aef6-4b01-7c24-08de16368761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BFQ6R7o+LM/xui6Lf7OqovFfUIkDvJrhwmkz0opzzV6NapHJWV/OhBFPBm8Z?=
 =?us-ascii?Q?QnKVY2dmjG/vHvBcqeVg3/nO/QtZmqSE0Wh5vou4MnsxBaV1rMTWtnLr3ELD?=
 =?us-ascii?Q?EBQ9f7deOosIYVschFTI5wvpcUOhPSGrT+I3fKk23vCxf5WA7pxWMZUOTIXO?=
 =?us-ascii?Q?B07uChXonxmqf476ouXMkU/CLnCKBqK7HNBZ+DmVecnjA32M4VBtpwNQfca5?=
 =?us-ascii?Q?DSh1ohk2J9FSUdBKsJHnJ1HxBaI8Jd7T5WU+rtl9QW58+WpqmiqAeMvUUzcD?=
 =?us-ascii?Q?Q5oJ5yPBSv3Kk5QNKHSTcRtx5t1KLL1JiSTGnw18yhN3o2mffqHAtXYYOBR5?=
 =?us-ascii?Q?fgByWORJiTG0ZJt2tcbfjUVG4iLMj2PG0SUQZLQaL46jg4kJNWuDhL3YSwPu?=
 =?us-ascii?Q?9gO+9YdLKZIaYKlD/+tVwOa3lRFLyCsqSJqk1cfNpsSmqx5sYzLx3X4lpluJ?=
 =?us-ascii?Q?aIq8i/aovuIGu2L3uQFS2Ov/7i7FPrO8WNqB38v/aINGeoUOmFgP+Y+kxdI1?=
 =?us-ascii?Q?XT0JAQlC9mtdtvhSXaViNAr0lpCe4j0CHq7PnEt8GU7794bFNNddDMsWMZgh?=
 =?us-ascii?Q?lCSbb4psRasL0GDcinHUqc8Qh/vQCpOXtNLBRk/xhGERFFE5as9Ttluoxy9X?=
 =?us-ascii?Q?mvGhcCIsvNa7h4GLrdkwAxhMqVBv9wkU8Z8H8JUPfEGL8P4n7chM+thZ/lRT?=
 =?us-ascii?Q?5R+eHC6+Xf3tJvwW12jNacS9KcAA0XBWP9TO+9o192FBkXghDlFswutUyMsz?=
 =?us-ascii?Q?9TAbO23sMBjH37DdCEv574F45X9Wq+oxw/yz4gjOPJHcZXZF+5a/ZM8moJfP?=
 =?us-ascii?Q?1vKL4Y55KkY+01HcSm0moIEgZhW8OfvcAZj1pRaPoJ33diPQ8jzH5buJ2Roz?=
 =?us-ascii?Q?FVaMLE/MZ8T4HulbG+JlHeaD2ZNXsTErgFwNo6kMoK4MVP2+Mfyc7UTEHpBD?=
 =?us-ascii?Q?gvWsx8yoAP8tONWsp03kosgeyQAD/2R1WVy6cpTpzmRFRqQ8+zmlXQwfzpBT?=
 =?us-ascii?Q?FPuVpyqE3cX6Zs2f7aEQrqkreuWUgeRagGLNvFGwwf1oslJdYMK6ppst0W1K?=
 =?us-ascii?Q?PqU6TaXyeEVJl9rVcONfpZnXJiEqsKeSgLnvxoNScFaFk4DGrVUXfmA9KoU1?=
 =?us-ascii?Q?7Mvo2B5bIFs1F2UnnhmqCY32Gq/nDXOibMyo9hzpVVygpL3Wgq6xvnPh159K?=
 =?us-ascii?Q?YQxUPxA/xumrPhFCUixVKLnDqFgNP70De+GRL9R5ngYdDD6FinUfGC0hdtb+?=
 =?us-ascii?Q?SOiDhwny7XpOGwA/VtYn9fEPhg3Y9OLfzqIaFUbaDns5fNVRXQ9tewcefOkW?=
 =?us-ascii?Q?CUeEfRicOkTbEszqwFBMXvQ2jYj/912F1R3ueUK3OlfMuDa1Xx3attXsOFNq?=
 =?us-ascii?Q?Vi9izIjbRJTU03AHFoLSUlQ5V5A3oc4sP2BgIYjZAD/SXsp7HboAoQmb2/uD?=
 =?us-ascii?Q?n/nfoFY/cr7b7vhV8lEnHpR4i1VV8ugRrzt7CRlSGuzVULtMDUAByV2VtG64?=
 =?us-ascii?Q?oGPYg3IzjveMvfRp5RWrKaDhF9eKCbrNGcaVRfMPPFUHzM1pc2JTz0WKejLN?=
 =?us-ascii?Q?YMtTlWZ7TccFSu3SZ2k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:27:38.8365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64530823-aef6-4b01-7c24-08de16368761
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6301

Under high system load, QSPI interrupts can be delayed or blocked on the
target CPU, causing wait_for_completion_timeout() to report failure even
though the hardware successfully completed the transfer.

When a timeout occurs, check the QSPI_RDY bit in QSPI_TRANS_STATUS to
determine if the hardware actually completed the transfer. If so, manually
invoke the completion handler to process the transfer successfully instead
of failing it.

This distinguishes lost/delayed interrupts from real hardware timeouts,
preventing unnecessary failures of transfers that completed successfully.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 100 +++++++++++++++++++++++++-------
 1 file changed, 80 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 69defb4ffe49..cdc3cb7c01f9 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1048,6 +1048,49 @@ static void tegra_qspi_transfer_end(struct spi_device *spi)
 	tegra_qspi_writel(tqspi, tqspi->def_command1_reg, QSPI_COMMAND1);
 }
 
+static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi);
+static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi);
+
+/**
+ * tegra_qspi_handle_timeout - Handle transfer timeout with hardware check
+ * @tqspi: QSPI controller instance
+ *
+ * When a timeout occurs but hardware has completed the transfer (interrupt
+ * was lost or delayed), manually trigger transfer completion processing.
+ * This avoids failing transfers that actually succeeded.
+ *
+ * Returns: 0 if transfer was completed, -ETIMEDOUT if real timeout
+ */
+static int tegra_qspi_handle_timeout(struct tegra_qspi *tqspi)
+{
+	irqreturn_t ret;
+	u32 status;
+
+	/* Check if hardware actually completed the transfer */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	if (!(status & QSPI_RDY))
+		return -ETIMEDOUT;
+
+	/*
+	 * Hardware completed but interrupt was lost/delayed. Manually
+	 * process the completion by calling the appropriate handler.
+	 */
+	dev_warn_ratelimited(tqspi->dev,
+			     "QSPI interrupt timeout, but transfer complete\n");
+
+	/* Clear the transfer status */
+	status = tegra_qspi_readl(tqspi, QSPI_TRANS_STATUS);
+	tegra_qspi_writel(tqspi, status, QSPI_TRANS_STATUS);
+
+	/* Manually trigger completion handler */
+	if (!tqspi->is_curr_dma_xfer)
+		ret = handle_cpu_based_xfer(tqspi);
+	else
+		ret = handle_dma_based_xfer(tqspi);
+
+	return (ret == IRQ_HANDLED) ? 0 : -EIO;
+}
+
 static u32 tegra_qspi_cmd_config(bool is_ddr, u8 bus_width, u8 len)
 {
 	u32 cmd_config = 0;
@@ -1177,20 +1220,28 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				QSPI_DMA_TIMEOUT);
 
 		if (WARN_ON_ONCE(ret == 0)) {
-			dev_err_ratelimited(tqspi->dev,
-					    "QSPI Transfer failed with timeout\n");
-
-			/* Abort transfer by resetting pio/dma bit */
-			if (tqspi->is_curr_dma_xfer)
-				tegra_qspi_dma_stop(tqspi);
-			else
-				tegra_qspi_pio_stop(tqspi);
-
-			/* Reset controller if timeout happens */
-			tegra_qspi_reset(tqspi);
-
-			ret = -EIO;
-			goto exit;
+			/*
+			 * Check if hardware completed the transfer
+			 * even though interrupt was lost or delayed.
+			 * If so, process the completion and continue.
+			 */
+			ret = tegra_qspi_handle_timeout(tqspi);
+			if (ret < 0) {
+				/* Real timeout - clean up and fail */
+				dev_err(tqspi->dev, "transfer timeout\n");
+
+				/* Abort transfer by resetting pio/dma bit */
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
+				else
+					tegra_qspi_pio_stop(tqspi);
+
+				/* Reset controller if timeout happens */
+				tegra_qspi_reset(tqspi);
+
+				ret = -EIO;
+				goto exit;
+			}
 		}
 
 		if (tqspi->tx_status ||  tqspi->rx_status) {
@@ -1281,14 +1332,23 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		ret = wait_for_completion_timeout(&tqspi->xfer_completion,
 					  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
-			dev_err(tqspi->dev, "transfer timeout\n");
+			/*
+			 * Check if hardware completed the transfer even though
+			 * interrupt was lost or delayed. If so, process the
+			 * completion and continue.
+			 */
+			ret = tegra_qspi_handle_timeout(tqspi);
+			if (ret < 0) {
+				/* Real timeout - clean up and fail */
+				dev_err(tqspi->dev, "transfer timeout\n");
 
-			if (tqspi->is_curr_dma_xfer)
-				tegra_qspi_dma_stop(tqspi);
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
 
-			tegra_qspi_handle_error(tqspi);
-			ret = -EIO;
-			goto complete_xfer;
+				tegra_qspi_handle_error(tqspi);
+				ret = -EIO;
+				goto complete_xfer;
+			}
 		}
 
 		if (tqspi->tx_status ||  tqspi->rx_status) {
-- 
2.17.1



