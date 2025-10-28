Return-Path: <linux-spi+bounces-10904-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CE5C15AA8
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 17:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62A14504875
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97B4342141;
	Tue, 28 Oct 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/zQRnbS"
X-Original-To: linux-spi@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1718B340D9D;
	Tue, 28 Oct 2025 15:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667061; cv=fail; b=lUPjt/BFMoRd/BGHTnpcJzHpJWD+uhSWzzcixwYvOwhhK23EdBk1s1WXEso4c1ddff6dR/x9UmorD7Ji4w1mxiDJyWJ0wFbbNi5pBnULL87pF4iDOyxIGBo6zCD3qyP8F2ABmf1nFkaiKzYvpD699iEDpLTdWzc8kNQp3iK61Ec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667061; c=relaxed/simple;
	bh=IGJwx5jK6OrH2M+NWR/c/WMMpQtLjfOir2T4kGyAkIs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NzPT8oYsgMarvszdfWHCpuTjRcNFjvsILcZZ748jfwByRKuj/msWbIS/VlWWMzlFrywHM4gDTBsXwGSpmgUln7D28YD8eK2c6lcnBazcxNzTk9hdKsrQgdEJPxBqMTkzk7LaNO/1ZJI49Yj7cDFJjhfB9PHoHPDKBFYLRmNHsu0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W/zQRnbS; arc=fail smtp.client-ip=40.93.196.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1M7jpd2Av9xqG8YfYdlaJ8eIeumVxjMEVKyZGmiFnLV6xBEhPjEpTQyayxtazC65Bczw1NYrLGO//o7Qya9mq1R/0SwrrY0UXJqKfuz61Me3pzupTiKsYxTGHEiG8A1LFxjhI/pEzJ1GYHP3fz/6/5dIJ/JdRAOiPNRg2/pPdbysCT4O1zp4ymfeY5ooLgGx/ja7bP5XSBXt1l24v5kvt+rgeTAhm2qzYlJhh8xTgOsiB1Ou5o3KXmUmn0YPD1FanYo8OfrLZnSD1ucyMx05t9ptFD6aGIlYHPGuSOUpZVOikF7RHZUk/m5w4rzsxRVL+Qu31/xYwDCo4iRThaM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PPaXuQeMPiSW2gKTdCzfQGgDy+u0w8AYKgMifcnWNY=;
 b=cyVMwtDPlnY66q2N0Rdv23flUYHwEfWTHxQu45xu6KY5WPRmONH+8M+Nfsjhc0XbMctshL1bIv0H82Fbf/DKmTYlJHOUVTkB1NZheNOEuztBRF9w1KuSevxZGr7MHE3JlXDQNcCZv93NlHfaH/QoXVEGH1p/WSCVcwcHsiqPFqwuPTVJ/sDtR2J8PtrEfl50ve6TvtJ95yyqDl8tmnwHsHhQ3L7XOSP72q0lWzJrNZ8YRsMuZoSKFYEqf1KY6EeMZKWqHUzmanJef6OSqHHRzucNnQogur9UxFGkxvsq0aNtITeLCS8Yijl3fFhzY2dh80pdnwfcrrc+UVuQ6YOFCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PPaXuQeMPiSW2gKTdCzfQGgDy+u0w8AYKgMifcnWNY=;
 b=W/zQRnbSUgoIDVktyIWbwKu0Belkiohr7UAae3A9Di3LElmuXJ7XTR/Mi2TsllwkiXhi1jjgBkWgBSSc5ZlAb8KHTz74rquMQ73xUx4vZvSEqfbTyw8PTdFX6jrz8PVPOgkIUog1i8P2qzE5rlvvf+qeKGdLc6/BRDtWrodUoDl08ZHRZ3PSNwAIgRScTIrASFh+VRKS5cB+OYRBTD11tbEnYf5MMA2iK3R/5qyIz/+trPnCp/e1w7bB3Lkj2xtdVEuXjvrVYcn+PpTyyLFuSpfMmEuF4eTEVp1k+5la9Tx6oXHAGcIgjZqujdLUTaL2/zaltddrl6B0XktedbhIfA==
Received: from BY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:1d0::11)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Tue, 28 Oct
 2025 15:57:37 +0000
Received: from MWH0EPF000989E6.namprd02.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::44) by BY5PR04CA0001.outlook.office365.com
 (2603:10b6:a03:1d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Tue,
 28 Oct 2025 15:56:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E6.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 15:57:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 08:57:17 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 28 Oct
 2025 08:57:16 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 28 Oct 2025 08:57:12 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Thierry Reding
	<treding@nvidia.com>
Subject: [PATCH v5 1/3] spi: tegra210-quad: Fix timeout handling
Date: Tue, 28 Oct 2025 15:57:01 +0000
Message-ID: <20251028155703.4151791-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251028155703.4151791-1-va@nvidia.com>
References: <20251028155703.4151791-1-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E6:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 50cc6795-7539-4ea6-a5e3-08de163ab73c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ostNnzjHjsJMZAp0vQ1HVIwXLp225BMwb6/YkQ1JxZRkRZ4fYCW+y26DnT2y?=
 =?us-ascii?Q?TyPig2ZO6NjQ53sHnzFMZJkkAuYkAiPodqLr4+PlfSH7q6Kjju0UuGxFPPsK?=
 =?us-ascii?Q?LfojlyrdPVcor6eCyfKH+7SotCkFEA2lROiSsQGV0dx/c7DJ0hG7KgsynqTN?=
 =?us-ascii?Q?VvZsQ6TsGk4Ipy9d9afp6q1ZEBPKOXposOKNZqPXTaYkW0+FrMDchJNaS4gF?=
 =?us-ascii?Q?9P9FBJ0MB7k1NgHhGfX8ujCvHFxw4hP601sBh8z5mzaOlKnciIEN2LOSCQsf?=
 =?us-ascii?Q?7OJUocxXYxoLLlxhrQdg/J54OjHyh3PkyZtpNa2x7Kg5r9KEhTpX4keQYx1u?=
 =?us-ascii?Q?PlfDNEdZEFud1LjRy+2ddV7OgjeycnxOsZKDU1meAgAb53woNK98+JK/uObq?=
 =?us-ascii?Q?gBU07eWZ+yRj6wqZzSxAc0D2E3qpgHBMnk9W6C4kq/2vPjNLlnDjbIiZNG+b?=
 =?us-ascii?Q?1jdY6bFRLAEMHjbXlpPvSuBjincF11p3PFubfA8HxYk5j9I5fjkr0tVVGjSU?=
 =?us-ascii?Q?N+v/BPPdPcudiTxrx8eNE3I5vnLcfg9DuyoElyM0Bm7uqbpE/GIiRMwXnsGD?=
 =?us-ascii?Q?wiFZi3p2AW8gAKhmTllpWrIMkSDCMPyVJnDd1DEKwVskPzBDCnF59jKiz3hP?=
 =?us-ascii?Q?DFncXLw582FtCNVcGizDe8TZPpHsEqSeJmUNrYQLzeS2iU38FyRROvJVlrEe?=
 =?us-ascii?Q?hcWrjt9Cli7KDcoLmjgg7L6oRhFKhBW5FZBeBKFsCOM1svpKoyrYgMHnPHsr?=
 =?us-ascii?Q?hJaFvlVO9Pz2Kx0KPlznWx1XPeZ1+uPLe/V+TigdA/KFdKHlCSgO5cU7CJ1n?=
 =?us-ascii?Q?kbs1vGpsm+H23fOkN1jrYf5A1aHOfl+UbTlNxO3C/82zXB31vKSfuI2L59/y?=
 =?us-ascii?Q?R3kmqDOfvQs5HvXyoVfgdEoKYxjwxzPJxx9I6I3GEUZlPwUAMhxIz86VLhdP?=
 =?us-ascii?Q?aUybBMJjAXYJXycpWJOyLQYq7Xbw4ixUw2n9KRWvdAILrlkKPyqF01Xghhs/?=
 =?us-ascii?Q?UhJA8ERQ986kaB+gCVxD3Xs7YCLpHOcBoaE/5iotpyz5vazFNRXOmFucDQXF?=
 =?us-ascii?Q?dg0wltvPMZ9JQCE27T52wJPyySzwmZjaQ1Ak2YH4D2ygtuzdFWW6sebtOtle?=
 =?us-ascii?Q?ebnWOSMvVXNQzxJT3o1BqctnawDYkcNGjIYrwX7dR4apyF84MDViQjT9OJab?=
 =?us-ascii?Q?32CMIcnhTPaLwyDfYmIkumdSVCnvXbDni1FPbz4OLIbD+G9ilXlHEg/+Y7Bx?=
 =?us-ascii?Q?vilDwh9Cmp1Cv67rAaZQ148dEWJg+he8vOeEQ7AsTOh9yVRrEvZJNPkivKCW?=
 =?us-ascii?Q?eGMGt/EjIxQMCGXMX//VE04v7/KEgTHIg4fUtRa+GW9DmOtSL0T0ka0PVmo5?=
 =?us-ascii?Q?pC2Okaas6Dryp8MztO2lIWezlzmD/nZLcN6BdDl1Sp3ems0vk1qasCL0vEU/?=
 =?us-ascii?Q?0X8dQomIX8PDacxNrAVQRE+iM02hMQGES7wkSrqDKCifnHlzqYNUsHajYD/E?=
 =?us-ascii?Q?p0rWKfcEAPWadazci0wNFhVCnYxMnGB5PtsnEWd2zHoBYphvZN9WmcD3sj6J?=
 =?us-ascii?Q?PYjoZcX4tosyaITiV8o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:57:37.0396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cc6795-7539-4ea6-a5e3-08de163ab73c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123

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
 drivers/spi/spi-tegra210-quad.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 3be7499db21e..d9ca3d7b082f 100644
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
@@ -1176,9 +1178,11 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 				}
 
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
@@ -1200,11 +1204,13 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			tegra_qspi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
 		}
+		tqspi->curr_xfer = NULL;
 		transfer_phase++;
 	}
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
@@ -1395,6 +1403,7 @@ static irqreturn_t handle_cpu_based_xfer(struct tegra_qspi *tqspi)
 	tegra_qspi_calculate_curr_xfer_param(tqspi, t);
 	tegra_qspi_start_cpu_based_transfer(tqspi, t);
 exit:
+	tqspi->curr_xfer = NULL;
 	spin_unlock_irqrestore(&tqspi->lock, flags);
 	return IRQ_HANDLED;
 }
@@ -1480,6 +1489,15 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 {
 	struct tegra_qspi *tqspi = context_data;
 
+	/*
+	 * Occasionally the IRQ thread takes a long time to wake up (usually
+	 * when the CPU that it's running on is excessively busy) and we have
+	 * already reached the timeout before and cleaned up the timed out
+	 * transfer. Avoid any processing in that case and bail out early.
+	 */
+	if (!tqspi->curr_xfer)
+		return IRQ_NONE;
+
 	tqspi->status_reg = tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS);
 
 	if (tqspi->cur_direction & DATA_DIR_TX)
-- 
2.17.1


