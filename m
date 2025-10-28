Return-Path: <linux-spi+bounces-10898-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A12EC15729
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 16:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96F50354FA9
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE9B2BB17;
	Tue, 28 Oct 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YAUht9kW"
X-Original-To: linux-spi@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB83431F1;
	Tue, 28 Oct 2025 15:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665256; cv=fail; b=gVvRqESSWSKHKQxkJHWcmEh5J31S8Lp8uXVgkxI2Pq7i3idj37nWEA3JDlIM+IZMjuhJhVC32HJGN9CbS8hVkrcleeeyiEEPjg4XgOKVNovTHeBhJpWvk3+QdC9/RdaBuK92POQ7mKErJyJNLAJ4tKsT4ul4wLo1OPVkvpRYnnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665256; c=relaxed/simple;
	bh=Ts8TpKJf6sj4QeEU4Tbzf1+rX/RbZeka3jUieSdjpGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gMQ8zD5pBmC5nG/MR1GsxaqyB6tf1+aKpFo8CROFlvz7dW3vsCYGkvDL3GS9gVFOhD43WnF6dvjaaH3XPZChw/WjNgOiIDBMBjWLZXK2zKwlHSO6qjS21PLTAaq9dWYhjT6m8YkrlWlv6Twsi+fYmXDPUIfKJCeX6DMkhEnd7XQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YAUht9kW; arc=fail smtp.client-ip=52.101.46.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pnb5TOFk4cZ0by5SmcY8hdvL3SmR/fi2wnqRzv1sm/I4nPegv5IF+UR/7c4mWLEckgZYsyBKwrUBAq3GAmRkuIL0DfwvD8haXl1WbcEXtVaqhw4K6zp3ELNHg7xKiXQIT/vuuWo2vwD/S4VKpKgt7XSBy7cWV545TqQBJcuE4iqrwwwwComiL1T7WGGzcp1Z/MbIPg6RKbtXTvT23rg+ZzvvJ1SEI12lIQ4aTFEG2jxVbmiyjqQXsXtoif4EevdGbeH6N4eI7XjF/JPAuDs++v+bfg5lWQjPHmZ/ENJQz0XaiAA062ajtF0BMGJFl4FJZe/2kEsxauH6qKnBtvQNJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWGekwxey8n0bGNDDNe3/Lo2+kr93gBpDD65mjMoOSw=;
 b=ZvCmJSKBWJ9VweFJO6CIqTlpeFAsHO85Lh6NS/OkEszUMhCbAWDqo+f2daaC+DxhNES0Y1dHDrgdKX28oWfUxOxtv/FA6xSlljeJkuFKfc0/Tfk4GGNEMgVnMRxnzP8TdbBRbHh8ku8tav58WWbp0zWHdGPEYxH6cSSpl4SKZ7wnZK7aNu/3zRTusZkB2ctui/cNFu+REiIuk9dw0/mP+WLg0JwZQspLFhdpR3Ar8bzC21e+BLW3VbpayzPUkQ9SvBGr55ZhrKuUoxW/otzpYPy5ylHXDBtnqepSdoMeA6lAPV27keMoe3FJ25fQabvx6tN+fdljpr8/rMLOG9zoVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWGekwxey8n0bGNDDNe3/Lo2+kr93gBpDD65mjMoOSw=;
 b=YAUht9kWTSmdAflsCbdYXSJwQClRmoEg2Cn5ClwSst4NLj9c/ge67qA0lLSsIjZJg6PA+WLtbABUKuydBxYwyJatl+UQLEs/L/1Tn7DrG1QRfD2Jt7zOAnd5Fhg5JhuOfMIHpA0GrztWMaxzmA1V5EPD46qPq4IRfu2GghHy7E+6Up85qVXwKfoQoaUMh47UVIbMJ8SYw/08vOcnXLoLlt/barsQqdE9G6jn9/vt4y2fnSU/qHPdkflOMwf8wR20M90/nPVGakdKLAo4NeCnHR0RACEvbd5ZCs8C3RSmcRLNKSdGxc7IWKtrD+e4bUrz+YWg2rfyN9tgLhHdB1QFUA==
Received: from BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47)
 by SA1PR12MB6894.namprd12.prod.outlook.com (2603:10b6:806:24d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:27:31 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::34) by BYAPR04CA0034.outlook.office365.com
 (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Tue,
 28 Oct 2025 15:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Tue, 28 Oct 2025 15:27:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 28 Oct
 2025 08:27:08 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 28 Oct 2025 08:27:08 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Tue, 28 Oct 2025 08:27:04 -0700
From: Vishwaroop A <va@nvidia.com>
To: Mark Brown <broonie@kernel.org>, Thierry Reding
	<thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, "Sowjanya
 Komatineni" <skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	<smangipudi@nvidia.com>, <kyarlagadda@nvidia.com>
CC: Vishwaroop A <va@nvidia.com>, <linux-spi@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/3] spi: tegra210-quad: Refactor error handling into helper functions
Date: Tue, 28 Oct 2025 15:25:16 +0000
Message-ID: <20251028152517.4144609-3-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SA1PR12MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: fd12f8f5-c914-4788-9cbc-08de1636827f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fHazqK057eJ0s6k6Zx8Rkjvja9GuBDhP6AGH7TedyFc8TVDotHFGlRtYBL9+?=
 =?us-ascii?Q?ulvEX+oC0aKENkkbcoPNa8R498X4XqnG+D2H5R1yZPEopiEUo0BWI/EmO6HX?=
 =?us-ascii?Q?I0G9tUkoW2OcdNOVF0jSgbo9m3EprGymmXaW+pAFMp2Cv/0/7HbFsKAJRg+I?=
 =?us-ascii?Q?GHx2MEhZrU3wHI+k7JgRZpP15G2uvjpvh8bOSpwxdLXk4Gq+G/Iqf6hEKET4?=
 =?us-ascii?Q?abmafKut763r5GgXEdlMwRtdbpW2Maz+l2cLJp47dXadh4lM8SGG8BblCUSc?=
 =?us-ascii?Q?AKJxhzxpQc/xW7bUxPVxNDlqhwOqw2UFfQ8C7wzXWwKZWQ+Y1Oy+XRR55vr0?=
 =?us-ascii?Q?0cXhvXsM9bT0NbX6Lgb4u3/8yUDJ+p5DwK9QlMtviudSG/daibe1Gfb6A1fI?=
 =?us-ascii?Q?r3TFbboP/XVUnM07Bt8OrJZnsCrijwmwv4ryRQHpd/agQu03FOhoonamLX0H?=
 =?us-ascii?Q?tftXyYjenngquC18YhcRiMN+rc9aWCQsLV5NTjlS4g77rZsUbA7aL+uOPJ83?=
 =?us-ascii?Q?n8vAX+lMpug7rd4JZSRhY++YEhRpTosZLpX/EfT9gXBTxGk7DX8DryWBLZ6Y?=
 =?us-ascii?Q?5he/I32rMW/N+75rUJoIvEsukDneNZ/bduSpzQ3KJ/p6ZoKlDGDgun3hHNXe?=
 =?us-ascii?Q?aoSOjbfH/p8NxXcDWcjNvOOkMjvwYke0DKHjfmq/WVVcIfjOaT+1/Tm6ws+z?=
 =?us-ascii?Q?Zk2a6g7dR1bw8YbBp7e/FXJaFTwxPnh4xw58yxlLwzRI8dnWyrBGbxxfCtoe?=
 =?us-ascii?Q?5fREC5cQ6Kp+WXc4BE0jpWEuzMEJcq98zrCyHvxx9scAtbB01w5XqAryWG5i?=
 =?us-ascii?Q?DJrWOtxg3MRfhnQOCJlowT0ty+kz89xVSbnnovMd6h5bK6H55cpjkC3FcfMn?=
 =?us-ascii?Q?wiQL6TyCITgE0NuyZjydc+wREEcTJd2oWlpSsNIcOkSiOAoaUhQIILcgdVrX?=
 =?us-ascii?Q?fDmL3WWZq757Js1FtZ1zDHPHtJjl0zhaE8tmbMMNksdsaFRU45JtXPMXumOx?=
 =?us-ascii?Q?dXwb3rpDGL+r+0ZKsLhXbRyc4iTM2fGNVH8hsPC5FXJpVmaALLsAB2hjjANC?=
 =?us-ascii?Q?XTN63uwmpNrgiz3wJH62p2c/cOg8djOgato6hM1tzRveGchO+ShH2pVKCGww?=
 =?us-ascii?Q?RpjH+nBRX98lovKDsqdN9apgFLdXpa/Z8F7vzcep8VI1Ye4O0L0xMTn22fq6?=
 =?us-ascii?Q?SFOigATkGZx61+MQ/oGr77kx3l0V5LA6BPntqttFOX/d1fijXtjeGZ8+rF8s?=
 =?us-ascii?Q?HH1KyYIv4OMRw4/mnyf6n3o2ZbFgYJk2E5yNO3+Phgkdu36OzAFWglX6SJiH?=
 =?us-ascii?Q?059m81vNEJn7QZEFtE0cWmguYbykfb3rPvUT1CJ+3PW5zmStgH7ElNsgbdNz?=
 =?us-ascii?Q?G7wiRAm0/mBeFZ3V/wfChuzvmVP7Da1myELxr0rBvk696GQnmVKgcorKf6tt?=
 =?us-ascii?Q?Wz1k0uzDFT4uyEsHGcomYd4Xey7u8azvUxLZGZ2AYlkkkhe11VMAvQfCReAr?=
 =?us-ascii?Q?Zf5NJm7SzqDnTHEeCXkbWHMRNR9SBpaS7Ysj1vVoBhRUsU2QXrRVzec1pOpl?=
 =?us-ascii?Q?2/XRmH5JYiabX2tBn2A=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:27:30.6253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd12f8f5-c914-4788-9cbc-08de1636827f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6894

Extract common cleanup code into dedicated helper functions to simplify
the code and improve readability. This refactoring includes:

- tegra_qspi_reset(): Device reset and interrupt cleanup
- tegra_qspi_dma_stop(): DMA termination and disable
- tegra_qspi_pio_stop(): PIO mode disable

No functional changes. This is purely a code reorganization to prepare
for improved timeout handling in subsequent patches.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 84 +++++++++++++++++----------------
 1 file changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index d9ca3d7b082f..69defb4ffe49 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1019,17 +1019,22 @@ static void tegra_qspi_dump_regs(struct tegra_qspi *tqspi)
 		tegra_qspi_readl(tqspi, QSPI_FIFO_STATUS));
 }
 
-static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
+static void tegra_qspi_reset(struct tegra_qspi *tqspi)
 {
-	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
-	tegra_qspi_dump_regs(tqspi);
-	tegra_qspi_flush_fifos(tqspi, true);
 	if (device_reset(tqspi->dev) < 0) {
 		dev_warn_once(tqspi->dev, "device reset failed\n");
 		tegra_qspi_mask_clear_irq(tqspi);
 	}
 }
 
+static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
+{
+	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
+	tegra_qspi_dump_regs(tqspi);
+	tegra_qspi_flush_fifos(tqspi, true);
+	tegra_qspi_reset(tqspi);
+}
+
 static void tegra_qspi_transfer_end(struct spi_device *spi)
 {
 	struct tegra_qspi *tqspi = spi_controller_get_devdata(spi->controller);
@@ -1074,6 +1079,30 @@ static u32 tegra_qspi_addr_config(bool is_ddr, u8 bus_width, u8 len)
 	return addr_config;
 }
 
+static void tegra_qspi_dma_stop(struct tegra_qspi *tqspi)
+{
+	u32 value;
+
+	if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
+		dmaengine_terminate_all(tqspi->tx_dma_chan);
+
+	if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
+		dmaengine_terminate_all(tqspi->rx_dma_chan);
+
+	value = tegra_qspi_readl(tqspi, QSPI_DMA_CTL);
+	value &= ~QSPI_DMA_EN;
+	tegra_qspi_writel(tqspi, value, QSPI_DMA_CTL);
+}
+
+static void tegra_qspi_pio_stop(struct tegra_qspi *tqspi)
+{
+	u32 value;
+
+	value = tegra_qspi_readl(tqspi, QSPI_COMMAND1);
+	value &= ~QSPI_PIO;
+	tegra_qspi_writel(tqspi, value, QSPI_COMMAND1);
+}
+
 static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					struct spi_message *msg)
 {
@@ -1081,7 +1110,7 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 	struct spi_transfer *xfer;
 	struct spi_device *spi = msg->spi;
 	u8 transfer_phase = 0;
-	u32 cmd1 = 0, dma_ctl = 0;
+	u32 cmd1 = 0;
 	int ret = 0;
 	u32 address_value = 0;
 	u32 cmd_config = 0, addr_config = 0;
@@ -1150,39 +1179,16 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err_ratelimited(tqspi->dev,
 						    "QSPI Transfer failed with timeout\n");
-				if (tqspi->is_curr_dma_xfer) {
-					if ((tqspi->cur_direction & DATA_DIR_TX) &&
-					    tqspi->tx_dma_chan)
-						dmaengine_terminate_all(tqspi->tx_dma_chan);
-					if ((tqspi->cur_direction & DATA_DIR_RX) &&
-					    tqspi->rx_dma_chan)
-						dmaengine_terminate_all(tqspi->rx_dma_chan);
-				}
 
 				/* Abort transfer by resetting pio/dma bit */
-				if (!tqspi->is_curr_dma_xfer) {
-					cmd1 = tegra_qspi_readl
-							(tqspi,
-							 QSPI_COMMAND1);
-					cmd1 &= ~QSPI_PIO;
-					tegra_qspi_writel
-							(tqspi, cmd1,
-							 QSPI_COMMAND1);
-				} else {
-					dma_ctl = tegra_qspi_readl
-							(tqspi,
-							 QSPI_DMA_CTL);
-					dma_ctl &= ~QSPI_DMA_EN;
-					tegra_qspi_writel(tqspi, dma_ctl,
-							  QSPI_DMA_CTL);
-				}
+				if (tqspi->is_curr_dma_xfer)
+					tegra_qspi_dma_stop(tqspi);
+				else
+					tegra_qspi_pio_stop(tqspi);
 
 				/* Reset controller if timeout happens */
-				if (device_reset(tqspi->dev) < 0) {
-					dev_warn_once(tqspi->dev,
-						      "device reset failed\n");
-					tegra_qspi_mask_clear_irq(tqspi);
-				}
+				tegra_qspi_reset(tqspi);
+
 				ret = -EIO;
 				goto exit;
 			}
@@ -1276,12 +1282,10 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 					  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tqspi->dev, "transfer timeout\n");
-			if (tqspi->is_curr_dma_xfer) {
-				if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
-					dmaengine_terminate_all(tqspi->tx_dma_chan);
-				if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
-					dmaengine_terminate_all(tqspi->rx_dma_chan);
-			}
+
+			if (tqspi->is_curr_dma_xfer)
+				tegra_qspi_dma_stop(tqspi);
+
 			tegra_qspi_handle_error(tqspi);
 			ret = -EIO;
 			goto complete_xfer;
-- 
2.17.1



