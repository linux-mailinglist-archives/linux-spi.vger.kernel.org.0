Return-Path: <linux-spi+bounces-8112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D03AB5D7F
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 22:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC02D4A818D
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 20:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAAE2BFC72;
	Tue, 13 May 2025 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MPGh13Uc"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C150C2C0325;
	Tue, 13 May 2025 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166493; cv=fail; b=CZuk2f4EGOCkaGXF7VkautvRMSehRtu/phigBiHHTeKiiMLpxJodYEfaRnxwg0Ybn7j8RkdOoUUdmC5ZRROzmzMJB3e+JWe/zl6t1BSf0B4xTKG4SygI2MSWK3DDYj99r8G1IUkSN7H8e6Gu5OYXksa96omFIPztEf3KEqtgBkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166493; c=relaxed/simple;
	bh=7JkzD1FAZzN7YLgFpLlLl64SjvT2bmPlqElqDWpuI+k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f65hzXPeS5/HPFWahZM3lFZuu7HTembholZZf8P22gdx67JVymZZ0QtnFkOyDHcn+VLzZOyjDyA1kxnJswxExjxkNKibgHQJN6BlVx/k6MXBcv+W2khxwDkFQCT6YdUzycRhb090KZUObS4b0aKOFlCZCV8oC/6Mo4d7AqPsNvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MPGh13Uc; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3sMHYXsHCfq7PdKdllwTx/05qA1Kmaadh+lWr8MA1Y3mTJvDLa3Iyxtm85LF32YFbwM1mcbYauoXlFTVPY2b2A9UjJPtjtmNXzDXBBpx7R3ZqqS/1PrjFKh23v6sT+1LJQnLGbrnjc1cfXL4EErIvUIJkDQPAtVGRYkUDBRoyyypOWIuKltYqtBLTAr2/yT+NWW/glcCYX+4oPdA8obGSQD9DKE4VhUI7+WJxJzZO4LYeCAuM0gLpYUks2iAfWaUjiYqGDvzis4gznMXEG9z6Qo0nFTjgWnojAJ5Ow6ImE88fKhSFMHK/6Yb0GqHtwWH8JFAzLY2/OfOAOKyvok6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcaOOKPMiOW3cLlBib7iHuqj5zVrHH1zX08A2kTGwPo=;
 b=M8pK+S+RqYjcl+frJNcHGwFukqeqRw5crNTFdcKi5362kOwDuDnhc1PhiiHy42yva284nMB46p2RcdWlOPVlvGrIpuhHgvVF9gXwDcEhoQnmic/RicDNk1AWnZ/807zgR2pohPWEEC9LZ9EFgeVQK242JGxG/tKGmpCrSnU4DGVfD0KZ6I5UC9zIwolOEkGxdzXAaeo1cbFo1XBulzRljR0h3ic6mU1YK1rksaulzSIxJERP2chbDnkj9YVjx8Hg+va1ftuh4BUWgVC5rMMcj0DFr6XyTgZ9tPNQNh3NDKoGon+14Q6MJFJDO3IEtlVhoDtfmwaLV0oKP27rYQAyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcaOOKPMiOW3cLlBib7iHuqj5zVrHH1zX08A2kTGwPo=;
 b=MPGh13UcsjXMyhuXFKtmjU4aqSKIbrZrJ4yBLwvXW1+2F9j2qHaCV4q6wY6XV4ZRF+hvp31llzW88AYb4fGaMVCb/ueTzbtxIiQ6hNj+eTi1R0NFuW7SN+SvC1OT0dtughvfAr6ni7XanHuEuzEQd09slGj3sjRb+gzJMjjq/JaRpHBPX2kS+TzisumMQY6WrxqlUSp9s5s7rWI7cks4hukZw596JcazLQuuwsD+FTYH4/xwEZRVsDJc8Cga98yd/+IFd0MDtNMvEBvpzEyY7FWPwA1Cgkpnad90Gl+Ywy85gdItnilxV3N8lPR+XP5imG07sI/c7Mhty/80EFBBXg==
Received: from SA9PR11CA0006.namprd11.prod.outlook.com (2603:10b6:806:6e::11)
 by DS7PR12MB8323.namprd12.prod.outlook.com (2603:10b6:8:da::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.23; Tue, 13 May 2025 20:01:25 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::38) by SA9PR11CA0006.outlook.office365.com
 (2603:10b6:806:6e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Tue,
 13 May 2025 20:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 13 May 2025 20:01:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 13 May
 2025 13:01:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 13 May
 2025 13:01:05 -0700
Received: from build-va-bionic-20241022.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via
 Frontend Transport; Tue, 13 May 2025 13:01:00 -0700
From: Vishwaroop A <va@nvidia.com>
To: <krzk@kernel.org>, <broonie@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
	<kyarlagadda@nvidia.com>, <smangipudi@nvidia.com>, <bgriffis@nvidia.com>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishwaroop A <va@nvidia.com>
Subject: [PATCH V4 2/2] spi: tegra210-quad: Add support for internal DMA
Date: Tue, 13 May 2025 20:00:43 +0000
Message-ID: <20250513200043.608292-2-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250513200043.608292-1-va@nvidia.com>
References: <20250513200043.608292-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS7PR12MB8323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fb9c242-da62-457b-0038-08dd9258f0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Cz+M8iElRPvLcjgIC+RIL3SrWi632gR/c++twIfW4bo3QwJTvyVh5RlbCRl?=
 =?us-ascii?Q?wLygLSrq9Q+Mi/JeP3uX0I7BGEP3C3ju+SzF1czfk2Jae7otF/H0eIFplcc5?=
 =?us-ascii?Q?/+cX/HJAUwgc724rnrnc9CYsDFKSmqhlpJphse+XBoda1mK5/37c2UFeQIuM?=
 =?us-ascii?Q?34TrAZNx1mZZgHSh3oUpJvQVUSIURFg8f6LpXzH9m7a4DW15774kyvwNDOlW?=
 =?us-ascii?Q?mZbNTjDM+DT2Dg+VkzoDBCqPh/4fU6HnXrgA0ShB4/1t6QT3LRIylE3Yi2YV?=
 =?us-ascii?Q?CR3YrDwlG8KHCBaHuucpiX3egghyDucO4hAbo5i7on7fJachFgADuONB0kQi?=
 =?us-ascii?Q?ip3hIpOOpOd26d3KuswjA/7CNlQr+YbPKSpyLOqHWsryyPvDRe7CW47LoBCc?=
 =?us-ascii?Q?dMuboIsnkey4WFxa0E1H7JqULvrg99m081oVkLPgCOClnkPhJE+HMRJTIJz4?=
 =?us-ascii?Q?/eP/iutZSXPDfIcBsf7/STYxHPxuff5/n6AC8A3hB6dLZj2UodhbauOY/Kh0?=
 =?us-ascii?Q?SWTzhM9UU3rJ6TdgH0Jiw2Vu94qZayTQznpxGcBoRcjhy0AFSm89pVOpjWUO?=
 =?us-ascii?Q?4msMEChyS8CTXmaokKoas4uhLPnh1q9rHUtHOgToQY/LnSik5t7pXbXqJiN0?=
 =?us-ascii?Q?MQ9/WQCCqJ148ZJwDIdVRMGSE3HiPWWgKK9yEuHxtUbncYjNMusqIK6Eyvnf?=
 =?us-ascii?Q?7gNvhpPsz0ESkS8SFHtnXk+HQQ8CSsWYr/XSB7octbYHl4pJLpCIaEwQHcQ+?=
 =?us-ascii?Q?Byxs1nQXAwa2JgVnEDtBEVUBjSht92/5Vw2geC3MILatoXj77HFxBMgCLksu?=
 =?us-ascii?Q?IlCEwe+xkSQCxBQma2hve269CfKjBmP0yeyHUcjAkLf95TgoWEaOf4PPw1yq?=
 =?us-ascii?Q?2Yst7P/I1vrfHXuWtLGmT3b+OoZpZj9Czo6EDDW/Y+L0q+E8WdlL3QvG9drm?=
 =?us-ascii?Q?k88dODkAGIX8nIq/3huYYZduCD24XB3Qb31Su5RO+IQTOLeDfqTeWgjNnIm5?=
 =?us-ascii?Q?gBPdCK9u07ASRvK0E24owKinFyty7ptwszvS6NUmWnjsIMmLePgBgUNVcaTu?=
 =?us-ascii?Q?MxnOXlncHrtq9jUgpXF0a+jyizBN2qyYW4uNliFO4Xeih97jnw23Q0T/mMlW?=
 =?us-ascii?Q?EFmgKM5TgbwU9tII7mwy34GhlTBWl1nYCqdYqwZdKqWUwu5EqfJ+bQZbluQO?=
 =?us-ascii?Q?21MFThCkrHEuJwHkK3turlGa4LNAClkhPnN6H0NTRmBs+DzkopD9YsfTaNKN?=
 =?us-ascii?Q?VHShCOkcfO7L2qOvyqzrKblF/TA50EvkQl0Rstjzgs18+OM7+BS8hT/kTImM?=
 =?us-ascii?Q?sxGqs7mavEr6HLv60pJjYuR9j6kun7+spkAv2qTEUGj1kxSeiDoIq3hXhn0N?=
 =?us-ascii?Q?2a2INqA/67sJg8XIQIAUvVYNF5VBkQe3Gvc/ZiR0zLLL5qNJSKZhQ6/ecEj+?=
 =?us-ascii?Q?LvtMcGFns5/DhcCGxvlQkjdtOf4AM3sC1TWpX6qb7i6AMxZiMgEX7ODUqVRv?=
 =?us-ascii?Q?s8OzJnEFhNkumQjMzL3DDLXO3ctFIga7FGl40OBK4R5yTvTi+ToxX8/kGg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 20:01:25.2157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb9c242-da62-457b-0038-08dd9258f0ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8323

Add support for internal DMA in Tegra234 devices. Tegra234 has an
internal DMA controller, while Tegra241 continues to use an external
DMA controller (GPCDMA). This patch adds support for both internal
and external DMA controllers.

Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 225 +++++++++++++++++++-------------
 1 file changed, 131 insertions(+), 94 deletions(-)

Changes since v3:
- No changes from v2

Changes since v2:
- Fixed version number to match the actual version
- Added proper changelog section
- No functional changes from v2

Changes since v1:
- Added support for Tegra241 device which uses external DMA controller (GPCDMA)
- Renamed variable 'err' to 'num_errors' for better clarity
- Added DMA mapping functions for buffer management
- Added support for internal DMA controller on Tegra234
- Added new DMA registers QSPI_DMA_MEM_ADDRESS and QSPI_DMA_HI_ADDRESS
- Modified DMA initialization to handle both internal and external DMA controllers
- Updated DMA transfer logic to support both internal and external DMA paths
- Added proper error handling for DMA transfers
- Updated SoC data to reflect DMA controller type (internal vs external)

Initial Version:
- Initial implementation of internal DMA support for Tegra234 QSPI
- Added DMA channel initialization and configuration
- Implemented DMA mapping functions for buffer management
- Added support for both transmit and receive paths
- Renamed variable 'err' to 'num_errors' for better clarity
- Added support for Tegra241 device with external DMA controller

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index a93e19911ef1..3581757a269b 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -111,6 +111,9 @@
 #define QSPI_DMA_BLK				0x024
 #define QSPI_DMA_BLK_SET(x)			(((x) & 0xffff) << 0)
 
+#define QSPI_DMA_MEM_ADDRESS			0x028
+#define QSPI_DMA_HI_ADDRESS			0x02c
+
 #define QSPI_TX_FIFO				0x108
 #define QSPI_RX_FIFO				0x188
 
@@ -167,9 +170,9 @@ enum tegra_qspi_transfer_type {
 };
 
 struct tegra_qspi_soc_data {
-	bool has_dma;
 	bool cmb_xfer_capable;
 	bool supports_tpm;
+	bool has_ext_dma;
 	unsigned int cs_count;
 };
 
@@ -605,13 +608,16 @@ static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_trans
 
 	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
 
-	dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
-	dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
+	if (t->tx_buf)
+		dma_unmap_single(tqspi->dev, t->tx_dma, len, DMA_TO_DEVICE);
+	if (t->rx_buf)
+		dma_unmap_single(tqspi->dev, t->rx_dma, len, DMA_FROM_DEVICE);
 }
 
 static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
 {
 	struct dma_slave_config dma_sconfig = { 0 };
+	dma_addr_t rx_dma_phys, tx_dma_phys;
 	unsigned int len;
 	u8 dma_burst;
 	int ret = 0;
@@ -634,60 +640,86 @@ static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct
 		len = tqspi->curr_dma_words * 4;
 
 	/* set attention level based on length of transfer */
-	val = 0;
-	if (len & 0xf) {
-		val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
-		dma_burst = 1;
-	} else if (((len) >> 4) & 0x1) {
-		val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
-		dma_burst = 4;
-	} else {
-		val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
-		dma_burst = 8;
+	if (tqspi->soc_data->has_ext_dma) {
+		val = 0;
+		if (len & 0xf) {
+			val |= QSPI_TX_TRIG_1 | QSPI_RX_TRIG_1;
+			dma_burst = 1;
+		} else if (((len) >> 4) & 0x1) {
+			val |= QSPI_TX_TRIG_4 | QSPI_RX_TRIG_4;
+			dma_burst = 4;
+		} else {
+			val |= QSPI_TX_TRIG_8 | QSPI_RX_TRIG_8;
+			dma_burst = 8;
+		}
+
+		tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
 	}
 
-	tegra_qspi_writel(tqspi, val, QSPI_DMA_CTL);
 	tqspi->dma_control_reg = val;
 
 	dma_sconfig.device_fc = true;
+
 	if (tqspi->cur_direction & DATA_DIR_TX) {
-		dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
-		dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.dst_maxburst = dma_burst;
-		ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
-			return ret;
-		}
+		if (tqspi->tx_dma_chan) {
+			dma_sconfig.dst_addr = tqspi->phys + QSPI_TX_FIFO;
+			dma_sconfig.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			dma_sconfig.dst_maxburst = dma_burst;
+			ret = dmaengine_slave_config(tqspi->tx_dma_chan, &dma_sconfig);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
+				return ret;
+			}
 
-		tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
-		ret = tegra_qspi_start_tx_dma(tqspi, t, len);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
-			return ret;
+			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
+			ret = tegra_qspi_start_tx_dma(tqspi, t, len);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed to starting TX DMA: %d\n", ret);
+				return ret;
+			}
+		} else {
+			if (tqspi->is_packed)
+				tx_dma_phys = t->tx_dma;
+			else
+				tx_dma_phys = tqspi->tx_dma_phys;
+			tegra_qspi_copy_client_txbuf_to_qspi_txbuf(tqspi, t);
+			tegra_qspi_writel(tqspi, lower_32_bits(tx_dma_phys),
+					  QSPI_DMA_MEM_ADDRESS);
+			tegra_qspi_writel(tqspi, (upper_32_bits(tx_dma_phys) & 0xff),
+					  QSPI_DMA_HI_ADDRESS);
 		}
 	}
 
 	if (tqspi->cur_direction & DATA_DIR_RX) {
-		dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
-		dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		dma_sconfig.src_maxburst = dma_burst;
-		ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
-			return ret;
-		}
-
-		dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
-					   tqspi->dma_buf_size,
-					   DMA_FROM_DEVICE);
+		if (tqspi->rx_dma_chan) {
+			dma_sconfig.src_addr = tqspi->phys + QSPI_RX_FIFO;
+			dma_sconfig.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+			dma_sconfig.src_maxburst = dma_burst;
+			ret = dmaengine_slave_config(tqspi->rx_dma_chan, &dma_sconfig);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed DMA slave config: %d\n", ret);
+				return ret;
+			}
 
-		ret = tegra_qspi_start_rx_dma(tqspi, t, len);
-		if (ret < 0) {
-			dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
-			if (tqspi->cur_direction & DATA_DIR_TX)
-				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			return ret;
+			dma_sync_single_for_device(tqspi->dev, tqspi->rx_dma_phys,
+						   tqspi->dma_buf_size, DMA_FROM_DEVICE);
+			ret = tegra_qspi_start_rx_dma(tqspi, t, len);
+			if (ret < 0) {
+				dev_err(tqspi->dev, "failed to start RX DMA: %d\n", ret);
+				if (tqspi->cur_direction & DATA_DIR_TX)
+					dmaengine_terminate_all(tqspi->tx_dma_chan);
+				return ret;
+			}
+		} else {
+			if (tqspi->is_packed)
+				rx_dma_phys = t->rx_dma;
+			else
+				rx_dma_phys = tqspi->rx_dma_phys;
+
+			tegra_qspi_writel(tqspi, lower_32_bits(rx_dma_phys),
+					  QSPI_DMA_MEM_ADDRESS);
+			tegra_qspi_writel(tqspi, (upper_32_bits(rx_dma_phys) & 0xff),
+					  QSPI_DMA_HI_ADDRESS);
 		}
 	}
 
@@ -726,9 +758,6 @@ static int tegra_qspi_start_cpu_based_transfer(struct tegra_qspi *qspi, struct s
 
 static void tegra_qspi_deinit_dma(struct tegra_qspi *tqspi)
 {
-	if (!tqspi->soc_data->has_dma)
-		return;
-
 	if (tqspi->tx_dma_buf) {
 		dma_free_coherent(tqspi->dev, tqspi->dma_buf_size,
 				  tqspi->tx_dma_buf, tqspi->tx_dma_phys);
@@ -759,16 +788,29 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	u32 *dma_buf;
 	int err;
 
-	if (!tqspi->soc_data->has_dma)
-		return 0;
+	if (tqspi->soc_data->has_ext_dma) {
+		dma_chan = dma_request_chan(tqspi->dev, "rx");
+		if (IS_ERR(dma_chan)) {
+			err = PTR_ERR(dma_chan);
+			goto err_out;
+		}
 
-	dma_chan = dma_request_chan(tqspi->dev, "rx");
-	if (IS_ERR(dma_chan)) {
-		err = PTR_ERR(dma_chan);
-		goto err_out;
-	}
+		tqspi->rx_dma_chan = dma_chan;
 
-	tqspi->rx_dma_chan = dma_chan;
+		dma_chan = dma_request_chan(tqspi->dev, "tx");
+		if (IS_ERR(dma_chan)) {
+			err = PTR_ERR(dma_chan);
+			goto err_out;
+		}
+
+		tqspi->tx_dma_chan = dma_chan;
+	} else {
+		if (!device_iommu_mapped(tqspi->dev)) {
+			dev_warn(tqspi->dev,
+				 "IOMMU not enabled in device-tree, falling back to PIO mode\n");
+			return 0;
+		}
+	}
 
 	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
@@ -779,14 +821,6 @@ static int tegra_qspi_init_dma(struct tegra_qspi *tqspi)
 	tqspi->rx_dma_buf = dma_buf;
 	tqspi->rx_dma_phys = dma_phys;
 
-	dma_chan = dma_request_chan(tqspi->dev, "tx");
-	if (IS_ERR(dma_chan)) {
-		err = PTR_ERR(dma_chan);
-		goto err_out;
-	}
-
-	tqspi->tx_dma_chan = dma_chan;
-
 	dma_buf = dma_alloc_coherent(tqspi->dev, tqspi->dma_buf_size, &dma_phys, GFP_KERNEL);
 	if (!dma_buf) {
 		err = -ENOMEM;
@@ -1128,15 +1162,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 			if (WARN_ON_ONCE(ret == 0)) {
 				dev_err_ratelimited(tqspi->dev,
 						    "QSPI Transfer failed with timeout\n");
-				if (tqspi->is_curr_dma_xfer &&
-				    (tqspi->cur_direction & DATA_DIR_TX))
-					dmaengine_terminate_all
-						(tqspi->tx_dma_chan);
-
-				if (tqspi->is_curr_dma_xfer &&
-				    (tqspi->cur_direction & DATA_DIR_RX))
-					dmaengine_terminate_all
-						(tqspi->rx_dma_chan);
+				if (tqspi->is_curr_dma_xfer) {
+					if ((tqspi->cur_direction & DATA_DIR_TX) &&
+					    tqspi->tx_dma_chan)
+						dmaengine_terminate_all(tqspi->tx_dma_chan);
+					if ((tqspi->cur_direction & DATA_DIR_RX) &&
+					    tqspi->rx_dma_chan)
+						dmaengine_terminate_all(tqspi->rx_dma_chan);
+				}
 
 				/* Abort transfer by resetting pio/dma bit */
 				if (!tqspi->is_curr_dma_xfer) {
@@ -1251,10 +1284,12 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 						  QSPI_DMA_TIMEOUT);
 		if (WARN_ON(ret == 0)) {
 			dev_err(tqspi->dev, "transfer timeout\n");
-			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_TX))
-				dmaengine_terminate_all(tqspi->tx_dma_chan);
-			if (tqspi->is_curr_dma_xfer && (tqspi->cur_direction & DATA_DIR_RX))
-				dmaengine_terminate_all(tqspi->rx_dma_chan);
+			if (tqspi->is_curr_dma_xfer) {
+				if ((tqspi->cur_direction & DATA_DIR_TX) && tqspi->tx_dma_chan)
+					dmaengine_terminate_all(tqspi->tx_dma_chan);
+				if ((tqspi->cur_direction & DATA_DIR_RX) && tqspi->rx_dma_chan)
+					dmaengine_terminate_all(tqspi->rx_dma_chan);
+			}
 			tegra_qspi_handle_error(tqspi);
 			ret = -EIO;
 			goto complete_xfer;
@@ -1323,7 +1358,7 @@ static bool tegra_qspi_validate_cmb_seq(struct tegra_qspi *tqspi,
 			return false;
 		xfer = list_next_entry(xfer, transfer_list);
 	}
-	if (!tqspi->soc_data->has_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
+	if (!tqspi->soc_data->has_ext_dma && xfer->len > (QSPI_FIFO_DEPTH << 2))
 		return false;
 
 	return true;
@@ -1384,41 +1419,43 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	unsigned int total_fifo_words;
 	unsigned long flags;
 	long wait_status;
-	int err = 0;
+	int num_errors = 0;
 
 	if (tqspi->cur_direction & DATA_DIR_TX) {
 		if (tqspi->tx_status) {
-			dmaengine_terminate_all(tqspi->tx_dma_chan);
-			err += 1;
-		} else {
+			if (tqspi->tx_dma_chan)
+				dmaengine_terminate_all(tqspi->tx_dma_chan);
+			num_errors++;
+		} else if (tqspi->tx_dma_chan) {
 			wait_status = wait_for_completion_interruptible_timeout(
 				&tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
 			if (wait_status <= 0) {
 				dmaengine_terminate_all(tqspi->tx_dma_chan);
 				dev_err(tqspi->dev, "failed TX DMA transfer\n");
-				err += 1;
+				num_errors++;
 			}
 		}
 	}
 
 	if (tqspi->cur_direction & DATA_DIR_RX) {
 		if (tqspi->rx_status) {
-			dmaengine_terminate_all(tqspi->rx_dma_chan);
-			err += 2;
-		} else {
+			if (tqspi->rx_dma_chan)
+				dmaengine_terminate_all(tqspi->rx_dma_chan);
+			num_errors++;
+		} else if (tqspi->rx_dma_chan) {
 			wait_status = wait_for_completion_interruptible_timeout(
 				&tqspi->rx_dma_complete, QSPI_DMA_TIMEOUT);
 			if (wait_status <= 0) {
 				dmaengine_terminate_all(tqspi->rx_dma_chan);
 				dev_err(tqspi->dev, "failed RX DMA transfer\n");
-				err += 2;
+				num_errors++;
 			}
 		}
 	}
 
 	spin_lock_irqsave(&tqspi->lock, flags);
 
-	if (err) {
+	if (num_errors) {
 		tegra_qspi_dma_unmap_xfer(tqspi, t);
 		tegra_qspi_handle_error(tqspi);
 		complete(&tqspi->xfer_completion);
@@ -1444,9 +1481,9 @@ static irqreturn_t handle_dma_based_xfer(struct tegra_qspi *tqspi)
 	/* continue transfer in current message */
 	total_fifo_words = tegra_qspi_calculate_curr_xfer_param(tqspi, t);
 	if (total_fifo_words > QSPI_FIFO_DEPTH)
-		err = tegra_qspi_start_dma_based_transfer(tqspi, t);
+		num_errors = tegra_qspi_start_dma_based_transfer(tqspi, t);
 	else
-		err = tegra_qspi_start_cpu_based_transfer(tqspi, t);
+		num_errors = tegra_qspi_start_cpu_based_transfer(tqspi, t);
 
 exit:
 	spin_unlock_irqrestore(&tqspi->lock, flags);
@@ -1474,28 +1511,28 @@ static irqreturn_t tegra_qspi_isr_thread(int irq, void *context_data)
 }
 
 static struct tegra_qspi_soc_data tegra210_qspi_soc_data = {
-	.has_dma = true,
+	.has_ext_dma = true,
 	.cmb_xfer_capable = false,
 	.supports_tpm = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra186_qspi_soc_data = {
-	.has_dma = true,
+	.has_ext_dma = true,
 	.cmb_xfer_capable = true,
 	.supports_tpm = false,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra234_qspi_soc_data = {
-	.has_dma = false,
+	.has_ext_dma = false,
 	.cmb_xfer_capable = true,
 	.supports_tpm = true,
 	.cs_count = 1,
 };
 
 static struct tegra_qspi_soc_data tegra241_qspi_soc_data = {
-	.has_dma = false,
+	.has_ext_dma = true,
 	.cmb_xfer_capable = true,
 	.supports_tpm = true,
 	.cs_count = 4,
-- 
2.17.1


