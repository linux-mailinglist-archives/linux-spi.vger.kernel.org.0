Return-Path: <linux-spi+bounces-10526-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD807BCDC91
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB1F3AB327
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2F12F8BFC;
	Fri, 10 Oct 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W1zTQ5yd"
X-Original-To: linux-spi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1482F618B;
	Fri, 10 Oct 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760109639; cv=fail; b=JM+SoSdf5XfnDD7P7ZtzBVdubRg4kffCBm99puJ66spjwFtD8zKZ1IF4lwVOTQCYRr4ztyTk37LCtht/oHfotXjiKeplu++pLiLZ2xLeUDgzU3eBq29iufwgTegE0tHLpouYfkmoUZjbUKByaa3dNY8RJ8cOhUd+AUq+SH80Tqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760109639; c=relaxed/simple;
	bh=JqxVqtbxZSu3ffNX6YfWKxUxhjtg+As8BsEcz1tK/BY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxt/pZ1jAx9aQ9CzJVTfpNSrf71uUhQrli98gsGOZoQe2bceoXWzutT1u2zI3epcm7NultVJuBzY5akzIymqZt+RC+HCpV/+HSw/s3gASq8XlK2d9kTCvW1QyLp5C4Bv8NAIhOJcPY5Uwb1vLFtz6wGACpb30DUU0sfoXoO02wQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W1zTQ5yd; arc=fail smtp.client-ip=52.101.43.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OnqjCpJK4Ah9Z3rMlLuT3T/sxHu6o3LNwkjPoASHEkogLrugjQTXzXUQOxYv5cf9EoYa/vJZoiFMY5OmeImO6rPeQWLN+V6kdrmx+csJ8eaBLSN//QBNvtpqJosabimekCKlc0vX/+sDn8e1CQqH7lzBuolctScszWgCUxX55l+0l9bRL4XI3jdTYZP17uxd4nHvQ8BoU2ki4VlQLw+v4coV+y6nBluieihmVfJH68GaS7EIfgoPw5rrS5y/GlzhL9AZt5um/Lz2sA3VV6HKgkEMLy7fODwtC85fri723ts89HifNlx81V1/vFPVYGvJOnLRI8ERUxDbpy9mFY5a9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PaO8y6DKPjvcQBgtWYjmBfKpsZ1xEjcuwS7khBcltk=;
 b=GrTme0JW2lsnIA+/0FcOJsgou67gYadyB57jvShezbUgmoKFXZJJYg2OCSg0iqkKVg3YaQmML2qrP0q6VMIUY7MG2Fo1e1kNL8ISWTYuFhBwnXZwmUqpAIa1yzwmcc/sjpgI3AA8GafhfvQjNtLKUwk73TpNIvqFzN+X4GDYNVlLq+bP4OHG2/ocoP49sGxkFq6qZZ8lEoXkpHsS6dmWIl5g5C32BW0XJbN5HibPmi2sokYuo6W/p3xkaIJlecdYaN/qPTGViik89jShesNZTUyxFz6j7y5gnQjHmLoDH7HqmaLn4JNdyyJfq76iwcjkGvsQrXfYKhXp7ynu9xU+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PaO8y6DKPjvcQBgtWYjmBfKpsZ1xEjcuwS7khBcltk=;
 b=W1zTQ5ydZLA3A2T9T00pZXDgL8GABXDecLvrobmpLkvzoOeGs92xBo6Xrq3Fw0TWbErqgXQvrAvAgrLnsog6RUUuT/4OoVPwqvXf6XyWzxWxwvGHx77HbccDJv2wVhE+RjdJpVhfgNsoOcGcMF83OEFgobMTU3itJ8xSW23kk1cKV0A7W1EXS1PrAnXBrtIsOwisrNgxOHQub+TAcKkMBQR9cgdbYquDPuIfK4s3Svp5XcUebalxmiGJRcGuDl5G4MFXol5VSi7gxvGqbTZVfu7kzb05HnqsRobRdHfO57baEX5tRN0pj1DMJYwyzJAdVZmqG+cmZJazr3eINFJUYA==
Received: from BN9PR03CA0949.namprd03.prod.outlook.com (2603:10b6:408:108::24)
 by MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 15:20:30 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::3e) by BN9PR03CA0949.outlook.office365.com
 (2603:10b6:408:108::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.16 via Frontend Transport; Fri,
 10 Oct 2025 15:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.0 via Frontend Transport; Fri, 10 Oct 2025 15:20:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Fri, 10 Oct
 2025 08:20:13 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 10 Oct
 2025 08:20:13 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Fri, 10 Oct 2025 08:20:09 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thierry Reding
	<treding@nvidia.com>
Subject: [PATCH v1 1/2] spi: tegra210-quad: Fix timeout handling
Date: Fri, 10 Oct 2025 15:20:00 +0000
Message-ID: <20251010152001.2399799-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251010152001.2399799-1-va@nvidia.com>
References: <20251010152001.2399799-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 79a06250-f53c-4c3e-37dd-08de08108cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yvscNt5jGC5gPKndNDo1yd/LvLKTuxD2seCx6pcM1gt11TNqjvDk+wBtUV5/?=
 =?us-ascii?Q?BmvyR35ZViUz4oM6Bim7yT44BItvC5nKYiO3ZTe+XV86+Y+IJgbJcD3Xs4Ql?=
 =?us-ascii?Q?EoAdq03ensT92BRPXovSletIzkR/WrHe69oR/SR8NMIh3Xm9N6ghHf2sFca1?=
 =?us-ascii?Q?2HR/e75MDUDqTogH8Omk6XlipSPVoJu7zPGO+Sx8zO/K0XWOn28ayRFlXS5p?=
 =?us-ascii?Q?FPe3ZsPNYQQOGjplbf9EVjj0IkgDmIjrbDE4Qe3fra6nPCzIDRgTyYJU3krh?=
 =?us-ascii?Q?O/+RbJh4EqXVVbdaAIEOoLCrLtX4U2+GxMXWj5QcsLWkc9tdgOiTEVK6Unja?=
 =?us-ascii?Q?vHJxY/59xuLZh2cvYtOWQulH7zI3js2x/IHOWz4e5jiSANko2ZymL8qj+p2Y?=
 =?us-ascii?Q?RmWSTFzk8HJPy/g1uVslrq1sFbnuqiqHAZ+YiFYnO0cVLiuCE8SLmTo8ByVA?=
 =?us-ascii?Q?PAAJLjcrm1UxbN8boyARFji9g+KRCCqrFREg0d8quOK1lxeA/57zhZzjtsKe?=
 =?us-ascii?Q?MQHB6oh9fKV6BIfAqdwkPxr4pOGgGL7PrimyQkHCdm3qVg/SREHp3EDlZeDt?=
 =?us-ascii?Q?0x4LTQRye3ZFj4B00LCOouu+dTYC29k7B66/ngVdZ7gZVsm9T3AcGesUfacg?=
 =?us-ascii?Q?hYuWfGrLJ6WmkjEpanm5CfISd5L/KHEH/Faz91B2xME0D/wHj6jPDerqhmK1?=
 =?us-ascii?Q?0gS7g0itJaGWNQqX9Nqo28NsRt9cMd+Tg4+pFPmyd8bdGfS5YvgnzCKF6xks?=
 =?us-ascii?Q?8iyWWHq4MGdb5HsNXqt4BSWgq0qMko5yj8DlJKK6/891SsncD8xdq/YyHf/B?=
 =?us-ascii?Q?HkCvW1Lo8I8KclBfM2IfToEb3ADuQqXOGNvKAw5Y28cLIqbCFCw+A6oDBC/U?=
 =?us-ascii?Q?z/R2xNkoPB2OcMpgc/ffbUApPREgNv1uBlObmcVj0Dzy/EVG75GadJL3R12v?=
 =?us-ascii?Q?8uhJRH6mVJgsvIj5nascWPUbGJb00nGkoVd+lwwUzHHaFbbKiIJvshnB5Htm?=
 =?us-ascii?Q?7tMNulyYJv/6CePLyk4pDmIRw+Rwx1DFrPWUd6vj8cy67S82ks9hGEoAR7+n?=
 =?us-ascii?Q?P7JpgoQJm3LJyRhgAzxH3cB/rgB8TP+833y7ArbMn7EE4JoOwR9+MJ+NX8TE?=
 =?us-ascii?Q?BK33q48mAXmSF7gLkrrzosprxcyv1qJMPkwWXLPU7Wj83r7+t6bl+d+4ugJ2?=
 =?us-ascii?Q?LSheNPyd2SCs9HLeJJMaZ8FvW8H0sgHw5VM7VHKnodHS9aJPEY3WcMsCRhD2?=
 =?us-ascii?Q?nmNxb63RvrRMOAcZO4m7jW8IKm92qNVq4WaHXnkyOL+JG5vOfNXLUTxRAXaX?=
 =?us-ascii?Q?N7E/FKxaKQE5Aw25UquQeZRH1kfyY6At8tCgAAS4KaKPbD0Tsxqd9rVIPZuW?=
 =?us-ascii?Q?rff6E547LZWNqHzK/gwUxMHdednccA4rBuiT3c8kfwY5/4fpGpRU+p3AmW02?=
 =?us-ascii?Q?02FHHBg219kZ40gwZVan3/tpJmbhUl4YIt2vFzmaB3UTdduzVyJ8RTLqEH57?=
 =?us-ascii?Q?NL4qHOIYI2rO3pLnNeNrvrZiR0rLQhwP9xZ/LLVIEAhlxEflpQ0+KHztHGHZ?=
 =?us-ascii?Q?R5NK/kOXsEHaDpZYn9c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 15:20:30.4924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79a06250-f53c-4c3e-37dd-08de08108cbb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

When the CPU that the QSPI interrupt handler runs on (typically CPU 0)
is excessively busy, it can lead to rare cases of the IRQ thread not
running before the transfer timeout is reached.

While handling the timeouts, any pending transfers are cleaned up and
the message that they correspond to is marked as failed, which leaves
the curr_xfer field pointing at stale memory.

To avoid this, clear curr_xfer to NULL upon timeout and check for this
condition when the IRQ thread is finally run.

While at it, also make sure to clear interrupts on failure so that new
interrupts can be run.

A better, more involved, fix would move the interrupt clearing into a
hard IRQ handler. Ideally we would also want to signal that the IRQ
thread no longer needs to be run after the timeout is hit to avoid the
extra check for a valid transfer.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3be7499db21e..c2f880d08109 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1024,8 +1024,10 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
 	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
 	tegra_qspi_dump_regs(tqspi);
 	tegra_qspi_flush_fifos(tqspi, true);
-	if (device_reset(tqspi->dev) < 0)
+	if (device_reset(tqspi->dev) < 0) {
 		dev_warn_once(tqspi->dev, "device reset failed\n");
+		tegra_qspi_mask_clear_irq(tqspi);
+	}
 }
 
 static void tegra_qspi_transfer_end(struct spi_device *spi)
@@ -1175,12 +1177,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 							  QSPI_DMA_CTL);
 				}
 
-				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0)
-					dev_warn_once(tqspi->dev,
-						      "device reset failed\n");
-				ret = -EIO;
-				goto exit;
+			/* Reset controller if timeout happens */
+			if (device_reset(tqspi->dev) < 0) {
+				dev_warn_once(tqspi->dev,
+					      "device reset failed\n");
+				tegra_qspi_mask_clear_irq(tqspi);
+			}
+			ret = -EIO;
+			goto exit;
 			}
 
 			if (tqspi->tx_status ||  tqspi->rx_status) {
@@ -1196,6 +1200,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			goto exit;
 		}
 		msg->actual_length += xfer->len;
+		tqspi->curr_xfer = NULL;
 		if (!xfer->cs_change && transfer_phase == DATA_TRANSFER) {
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
@@ -1205,6 +1210,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	ret = 0;
 
 exit:
+	tqspi->curr_xfer = NULL;
 	msg->status = ret;
 
 	return ret;
@@ -1290,6 +1296,8 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 		msg->actual_length += xfer->len + dummy_bytes;
 
 complete_xfer:
+		tqspi->curr_xfer = NULL;
+
 		if (ret < 0) {
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
@@ -1480,6 +1488,15 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
 
+	/*
+	 * Occasionally the IRQ thread takes a long time to wake up (usually
+	 * when the CPU that it's running on is excessively busy) and we have
+	 * already reached the timeout before and cleaned up the timed out
+	 * transfer. Avoid any processing in that case and bail out early.
+	 */
+	if (tqspi->curr_xfer == NULL)
+		return IRQ_NONE;
+
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 
 	if (tqspi->cur_direction & DATA_DIR_TX)
-- 
2.17.1


