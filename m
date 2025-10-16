Return-Path: <linux-spi+bounces-10694-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 70305BE3B4D
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD2B0503EE9
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 13:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C746339B50;
	Thu, 16 Oct 2025 13:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TSkfiAp2"
X-Original-To: linux-spi@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6441DF982;
	Thu, 16 Oct 2025 13:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760621396; cv=fail; b=jlo8tIUOPaHoPXDX6/oq2IsRQpD+R8h+7nUZcDZoE93mH9HO/djB8AFcYY6F9UucZoXAHrgi6/pmHeXroxIfkfQClNtuvvhp5Axw9qYBy64zO2jN3QmowLqZuU8ixOupGYIXKe5vE01Bmbtc8wNdBMW+WbedEvqMifr18m3fUek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760621396; c=relaxed/simple;
	bh=TAstTnBl+19ZoZdiUJFSHmyotgaFs4cLE56Lyln2bf8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7kt4/p0w2jfYzes6tI8tZ/YafnhMu1UsGUq3Jjw85yII9ZLkmHPNykjnrMiTZd+JthXos10UA+PR423e5ZPzBweHmXlIURGC2xlUJVh5Nh8nrWe6aqHj//V6r1sUu1D4jnQvKR37jLAlvOz87fxHd6R5HK6K+BwcrxoGAuOmyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TSkfiAp2; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTDT879y/ZdyPdwaDh6mhYcHbZ/XaOtnMQU6iX2zldbBdzcm4K12RY/Qlaml9zF6mw/LNKtlHkacXjs5MAdfIg9eywJZ5tuHWJPnL/nYs4SJ/jPDu00xczFP9yq6odegv5Iy4XhvoWGK++1UJDAKlExoMJwa/m2sTHjJsg1gNIucIDR8Oq0Pj4kTnU4uN7VqSCdFQcdk+TemGuDcSoZheCNmNG3uwZ2cvmQb3huemL7173hjRchnNYAuLiHClkkZKZ043amDxVf7H6y2wGlqoVECkn1IiFvMLacb0HYfka7vwx0Na170aNCrbV8Ai/B6PdGjFmqRowJZi1qaWUCJ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iT4n0/wPzC2bXLbxhsJlqwW94PuI9jsFJtJxrG1uMs=;
 b=zMyRzyPdWe7IwSK9Q0H24qzHrrDk4wGiWNDM/JAN3BPqTZPkX3vbYynRPaIHa+jRYrhnYSEtGMpjrdgCRrMXQwoNwfiwtoLXiyLVaxcvqYNFKDazmFclbD5XZ2FDL9p4268E7bpkPIm10siKFjt9S3eUb9vSxehVpuko456W+P/HyrOjB3eH82jtsTEucb5bhemzCKinSyOEuwYr6ScTWLNLZQnACLEScsgrpvMQCLXPHjVtR33GzDbHDZIT4Y71vEVORgM4jAhboxrhG28qISvDtb6IvNQovWseHpl+ympEmOwQ9itMMyuW/4kKF1WbyV45rghLo0vfBJKE16yX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iT4n0/wPzC2bXLbxhsJlqwW94PuI9jsFJtJxrG1uMs=;
 b=TSkfiAp2bB+a1UG7hPy+RITnZoCviayHXjqh0Uds9C4e3yjwzX1EvO3wKOrRUe9EB+5+lrc+oiN2JAWtKHJEuNCkWrbs9/nZQ8kohRSAmjyZcf2IWi4JsfEqaDxlI9xtBuiFOe8Ezl84uh4itbfPU6lUeokTe5nRiVbE/tAcOUtdGcBc8bG7OJqer3IPvIexx65cydPZTB/V7nvaAZyaSXrvbdIrPSbAsan49cgp4sLig30ezQBpde5s860Y/xSZhFQp7n69SSCTQQ6r9JeBGygwzpPRdVa1tqHD+wty8Ftif65yyBy/6ZXciBwbsmfrojTXeeVL1u09YWABRpODnA==
Received: from BLAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:208:36e::14)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 13:29:49 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:36e:cafe::89) by BLAPR05CA0005.outlook.office365.com
 (2603:10b6:208:36e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Thu,
 16 Oct 2025 13:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 13:29:48 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 16 Oct
 2025 06:29:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 16 Oct 2025 06:29:36 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Thu, 16 Oct 2025 06:29:32 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thierry Reding
	<treding@nvidia.com>
Subject: [PATCH v2 1/2] spi: tegra210-quad: Fix timeout handling
Date: Thu, 16 Oct 2025 13:29:22 +0000
Message-ID: <20251016132923.3577429-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251016132923.3577429-1-va@nvidia.com>
References: <20251016132923.3577429-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c70ef9-fa51-4a88-1c37-08de0cb81481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yFHoi876kCFqpd6vR6e3N4mQuUX6j0kK79ARM7+iIg7ajPLfyw4p3qUGg8Oe?=
 =?us-ascii?Q?3pnUpRiqomGOa/yG4/+uUcX4YPKgC95jhQoniOq5dplQqTHBS1ndw7krbI4K?=
 =?us-ascii?Q?FQaRfLEmgA2zMjREhcPRAOEW+wcBcmsDZpdZUNrENt0ix2xRvwVCRtwISiHq?=
 =?us-ascii?Q?Qonb+CTl1u85Hjodc/yR3AE7l/iYfglR6PriOigdrfCYu4caSl+p5yYlIMQ9?=
 =?us-ascii?Q?nMi6735bgqRERvXc1FV48C5PSiCXpncyAObVtkJ65Wu+WsafQoeY1vl0P0+5?=
 =?us-ascii?Q?bnStbccCSWCaixagi//CuiPGgWCkQ5/ebuqGdHjJRNGC/qjM0bIQY43kRvam?=
 =?us-ascii?Q?NRUKs+8+1a2Obf8Ka1ScFc2pWmsiAmQd+H0M+Xgqq+OCbPGmI8qT/c8fl8Vo?=
 =?us-ascii?Q?9h+OaIaOZ4xDXmC8XLHi6ZzzL0R55XdAFWzDJQHh5SA+HvIFVTvW8b697Na1?=
 =?us-ascii?Q?+OLATDRscvm8Aymos7dFyKN+47XPjsq+a0EDM0h7UJUddXNqYGWP4riVRkl+?=
 =?us-ascii?Q?Su1TQa29d+9O2UWtHRmGJVh0DcZrDN0YXEYQntjNeOCbQtsw2bGqBG1CIbPa?=
 =?us-ascii?Q?wEtIMq4sfwaUUI48r1XBxQqmFdkLkHpmq5LcgC/Kpf9RWJoECTdDHsUbAY3Q?=
 =?us-ascii?Q?6nJ5uTmre2QtcKZVf6ANQ20EZbwW573wO2V6d4pSyVSiL0ULhVAnR3AuUcyz?=
 =?us-ascii?Q?7pBjPBQsrwSezFmqsz6Fr3pjyAFJyS9SHTItC/DG4i4xxIzClgUtluo3j9hd?=
 =?us-ascii?Q?0h+gJ120YAkLEhgQYYZxYBMygDtMmclpRYLTI4LzNlxnO0XGp7oaE8ppFz+d?=
 =?us-ascii?Q?3t73JMfzI8giAipXjnbHsN6eAa20iKdKUep/TiDoUDovvggMdNUDqMqLec/6?=
 =?us-ascii?Q?Xh8WRU+3A3he6iKnshoIVPrPG3P1YQv+hrjdKOJKmzGfCxo2g91zMSntrbBb?=
 =?us-ascii?Q?siyCtw5jyhzRMLJaKuYtFhFXSRL/Tze0RFMelRq3NYCRzuiPREdNzKQMBplp?=
 =?us-ascii?Q?ERqvmcVqKigOW7RX+5lwMUWcRX4U9+VyKdGWg3lgstzAf3aewTs0Xu9A2kyT?=
 =?us-ascii?Q?7Q0sFBrqX1Zhaxs6gUSJrRCARk5NhndIuJNHyVjXqeX01ff+q8zA1dK8dCkE?=
 =?us-ascii?Q?u7s2rkw9XWKi0dUu45bW81x5ITNCzVTefguVsJ/uG4U7WJgWgizMMyCVirvI?=
 =?us-ascii?Q?Xi3rGoXcSEEJ0b9SRZ4RJxE1SsLfNkXYxJyKlH2pN728sqTh5Reie9TKzoxR?=
 =?us-ascii?Q?eyInFdlXL7lrO/EUt+9z9TbSdGhpl0V/8BfE5AX9TrUSgbJp82l03A4thQeT?=
 =?us-ascii?Q?i3V7CQfixPZBXkg7RdaWuD1pcupkrrpRPD7lw59uaOhG+lIHzrWdZ8ZY02ad?=
 =?us-ascii?Q?X3UDnt7L1koWKHqmzbrbgLGqsAvPeJ55h2BCPAABbXHrZgT8k0kMEPvFSsJM?=
 =?us-ascii?Q?vMPAOls03vabGpb89V6Szt0Dr3aVCmVDFvtuks2VR+Rd9czUgc+Q8fe7NmiE?=
 =?us-ascii?Q?VIWSOyEr+FYewFNNYN+rFQsdJti6qu2JQi5dW91LWn8ooIIRFMhHC5osVrKx?=
 =?us-ascii?Q?HwdBEqfwqDXCffkwfdU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:29:48.8876
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c70ef9-fa51-4a88-1c37-08de0cb81481
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

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
 drivers/spi/spi-tegra210-quad.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3be7499db21e..10e56d8ef678 100644
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
@@ -1173,12 +1175,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					dma_ctl &= ~QSPI_DMA_EN;
 					tegra_qspi_writel(tqspi, dma_ctl,
 							  QSPI_DMA_CTL);
-				}
+			}
 
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0)
+				if (device_reset(tqspi->dev) < 0) {
 					dev_warn_once(tqspi->dev,
 						      "device reset failed\n");
+					tegra_qspi_mask_clear_irq(tqspi);
+				}
 				ret = -EIO;
 				goto exit;
 			}
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


