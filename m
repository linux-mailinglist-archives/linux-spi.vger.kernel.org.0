Return-Path: <linux-spi+bounces-5786-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAD69D3A58
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 13:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 550A91F23277
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 12:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2201AA1D3;
	Wed, 20 Nov 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xRKi7l5C"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A581AA1DE;
	Wed, 20 Nov 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732104648; cv=fail; b=ZaRZbGAddmiyDTgtCakTb0XMm7TRJInxwfM93bCBsLpS5lN64YAE5Y7Cph6R66U82DM1B9cJK+02gqM7FUJfZMP9T0qSrWYGcrhlEGhH3Kj2mN0ftoNAAbV8JTxdtgvFT221WJaMYzBoqZug7pUpXG+OIHCU4j/2qEEAadPWqzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732104648; c=relaxed/simple;
	bh=9U2Vkj1GpajCtUz+Si0+mXuF7R7Kz6H4SIsgYagXV/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OcFGdLXJMqhhlzgiuxD7wgXFndKDBdMFuD7oktQJE2J6hwbVKvdumVx6f4Py9NBH2ZPSi1WKu1jrDDDroPzAHK3oLjVrfAWhFZ2PYsw+3DjOLC1iOi12eqyyqNu/RhSZOc3I/0ogod5+pKRfrEqZ3wu9JmcFpl03xvEdk/DbobQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xRKi7l5C; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5bSjncpCaQdihcyytQUFrWblyqH+P/m4IQ1egHzmrDy5nlbf4cMC+Cjn3qvPaoWUX571Ovco3tyktxuv2Mp5yFmd8r1bE0FxTfmgs99ozAnRNjXLAY+x20pzV/HKzeiQT3OPi90RVCZBNFipxfytUCTDUMCBI7cbo01AJ/mVZTkDmvDr6MIs63Jf7iV8vtmiz+48XewFN7a+tMD5xUgyQ7S05txCD3mbTqEuN9HNeedRnmg55QnGTfVjJbIAQzCRSpSIihBG/rSzr37h+CRUZad0mEGvmfa92dPRQSLpeKFRj+g4T2pK+Xnz9y7pzUhdPa95GUjt39x+Zvsn7WaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NqgKUJVuo769CX/pxCJfVX59x8jYHinECEaEyoW5Eko=;
 b=qjqWMYEUWHJDSo65WZUWhmmX0PANL94DcR+UlzZMUTruQkCIPpz2sk+vbe0U0L7e7EQ85lz1+tUro22z3FYF6FXNhTUxmvWUER1abla96MLes1xqCVkMMBaIsPpGsHzS5NxwnJNZUEVCK8v7AQoe7+K4MVJi+pScWQtquAA8v+jqsXEQA1zZxL6gE87Pd1Wp601BL7quSAsXC86rJ/IpkXLy3O2W2zV0KiDj2PHjNWY/a+st0axqjG0sJD7v9T8k3Kqhq/tJoh7vSFIrJeqDfxWu2vICrJZ9p+jJMIYBp63ibyzt0M+80DJYGs8uGGhrA+0TnH4XVxu8AwAV2kDGYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NqgKUJVuo769CX/pxCJfVX59x8jYHinECEaEyoW5Eko=;
 b=xRKi7l5CPpO4oy4VdVpn/0IzzwoukmuqAXWfylc9Yv1TFoYhzlalaN+GV6cEAv+hpTFAxycdqSq9H3g6wcsZDfb7vaIRnP9sIAdv1MZMxc9Gv+gEWVYc2EkJuLpbl8Ets897QYJHpgOLHHCLZSr06v47CYziyflFzlFsE3+cgDk=
Received: from SN7PR04CA0104.namprd04.prod.outlook.com (2603:10b6:806:122::19)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 12:10:43 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::41) by SN7PR04CA0104.outlook.office365.com
 (2603:10b6:806:122::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Wed, 20 Nov 2024 12:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 12:10:42 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Nov
 2024 06:10:35 -0600
Received: from xhdakumarma40u.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Nov 2024 06:10:32 -0600
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <vaishnav.a@ti.com>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <srinivas.goud@amd.com>,
	<radhey.shyam.pandey@amd.com>, <srikanthboyapally2016@gmail.com>,
	<srikanth.boyapally@amd.com>, <sai.krishna.potthuri@amd.com>
Subject: [PATCH 3/3] spi: cadence-quadspi: Support for device reset via OSPI controller
Date: Wed, 20 Nov 2024 17:39:51 +0530
Message-ID: <20241120120951.56327-4-srikanth.boyapally@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241120120951.56327-1-srikanth.boyapally@amd.com>
References: <20241120120951.56327-1-srikanth.boyapally@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: srikanth.boyapally@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 83dd6e20-fa53-4c06-0d3e-08dd095c5b4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U72UXeN8zF6k4E0MW4GV1KjHZtU+9T4196AYV4JG7MT0dAo7Asplu51t5UNI?=
 =?us-ascii?Q?dVN9+KAKbqsLt9KZZbkK9511RgUOhHYt0AWaciX5qlSBdXxSCsdbVo9tZi/9?=
 =?us-ascii?Q?oi4ftPYoqf2nxjUqn9Gm6w/b0MHsRoXQoQZYuDsgsiaT5qrZ5v3ALhcKBI/j?=
 =?us-ascii?Q?b7axSisVKVvMJfAoB6WHTi1U1xtHopn3WYgxENWd+wR2csR5H4uXYx7GyuJ4?=
 =?us-ascii?Q?Jp0l56TSDEqbNaIlGIVmb/SpXJXPZHus1XE1JAzP1uOcMboX1yusozHRomBA?=
 =?us-ascii?Q?OSPNRZodLtxKd8ucqEKYwqIB/GyzjwMcOb5qQkThXNakPZABrEUoTYLY84N/?=
 =?us-ascii?Q?s4AR38zynt+0Lh7qjcoqV8Ct5TgvrHf0ecp8tY+MASIgyhcDmMLAUlUEtLqR?=
 =?us-ascii?Q?gvoxk5bIB1ZQSXAvUFRUfY6yS2wdSIsYm0OXRC/ognr5jR+u7CQISesguSUX?=
 =?us-ascii?Q?qT5crahFvnYp8qMcZbt0xCJ+D0AMld3iKPsNhEUFDMKG46YclC0kL8tfgG/8?=
 =?us-ascii?Q?f4IR4p5R8OZGl1u1CUD6hEPyQ3UTtvcTzhA6MpJpYe9+gftJmKurSfO1WIhq?=
 =?us-ascii?Q?y3qznP4Q8YlG9ROGF8YQ+RxVU41cZlmv+/9XIXEy2YWfc1SEGEn2A16x5y1m?=
 =?us-ascii?Q?S9vgWgvUJP+nZHJgsPXLs2/Ew8qzLcagOhMJlIe637US/mE9pxotbMnAqlgq?=
 =?us-ascii?Q?DVGE3CSytzB5u8MRD/i5XHWxcbzu2SZzMOyJiKPwLL/kxWthaWy7Uz9e02Cy?=
 =?us-ascii?Q?+xqmOoKfPjvl6r5CWLM4idfT1juEG/g2l5QVBK1gYBTYPo3xD0sJ4UXi/lev?=
 =?us-ascii?Q?/+Bgj1VyYLuHC+tXfGugoXAXxHfoID0mR+Kpyk3KqAT1Ym+f+ZkW2HcjKofc?=
 =?us-ascii?Q?v88ZWjR4jSz2rITcUAt0pB2UhmFXBcgiW5tr3ukilYRGA+toFoTAyV880W5X?=
 =?us-ascii?Q?xQmeQ6gRk4ljS+MBCNrhvsJYSpWuG+ti1bTrvB1k9H5jQHlZXAb3/fsekuDg?=
 =?us-ascii?Q?ZY/RicyhuvhW+2l+VLoV4ccFcOZnBonU+F2vKkSEajKj3YdN1ZAIptu19y6i?=
 =?us-ascii?Q?B50R8AUpQNTf3+m9ZnKpGRWJrwIoMlwpa1N1kmgahyQK1J2cTsMCcpi0TrGO?=
 =?us-ascii?Q?I0Q7LiEruUylxLptajAwLOvn5w/pztqQkpTL+271xBhPahQoK7OEt5MYvZJS?=
 =?us-ascii?Q?sknQSm8DebI2Hyf4Fxy5NSiB5fgrtaN2bA4yqNy7T0BcJ+Iu7HJl9JSBICrG?=
 =?us-ascii?Q?7G+NyBenpKgRmuTVHz4vsGkn/vHWiD3yFDwdc4xNEQhwDV6J3i+JJt2f56+M?=
 =?us-ascii?Q?f6VVHw62u8HXuaqSNRoTrUJfkGcb7P8M1NOOI+xTva4lsDzfQI2ieRdE/Qtm?=
 =?us-ascii?Q?DMJyyJ7kxjaoeykD2Yd5ilZbc60T5G/j/8Mn4ssZWnD7Oo+1zA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 12:10:42.8892
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83dd6e20-fa53-4c06-0d3e-08dd095c5b4c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705

Add support for flash device reset via ospi controller, instead of
using GPIO, as ospi IP has device reset feature on Versal Gen2 platform.

Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 40 ++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index fb75400518e0..82df3d0683d6 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -44,6 +44,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_CS_CNT_MAX);
 #define CQSPI_NEEDS_APB_AHB_HAZARD_WAR	BIT(5)
 #define CQSPI_RD_NO_IRQ			BIT(6)
 #define CQSPI_DMA_SET_MASK		BIT(7)
+#define CQSPI_SUPPORT_DEVICE_RESET	BIT(8)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -110,7 +111,7 @@ struct cqspi_st {
 
 struct cqspi_driver_platdata {
 	u32 hwcaps_mask;
-	u8 quirks;
+	u16 quirks;
 	int (*indirect_read_dma)(struct cqspi_flash_pdata *f_pdata,
 				 u_char *rxbuf, loff_t from_addr, size_t n_rx);
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
@@ -145,6 +146,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_CONFIG_IDLE_LSB		31
 #define CQSPI_REG_CONFIG_CHIPSELECT_MASK	0xF
 #define CQSPI_REG_CONFIG_BAUD_MASK		0xF
+#define CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK    BIT(5)
+#define CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK    BIT(6)
 
 #define CQSPI_REG_RD_INSTR			0x04
 #define CQSPI_REG_RD_INSTR_OPCODE_LSB		0
@@ -831,6 +834,25 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_device_reset(struct cqspi_st *cqspi)
+{
+	u32 reg;
+
+	reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK;
+	writel(reg, cqspi->iobase + CQSPI_REG_CONFIG);
+	/*
+	 * NOTE: Delay timing implementation is derived from
+	 * spi_nor_hw_reset()
+	 */
+	writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, cqspi->iobase + CQSPI_REG_CONFIG);
+	usleep_range(1, 5);
+	writel(reg | CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, cqspi->iobase + CQSPI_REG_CONFIG);
+	usleep_range(100, 150);
+	writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, cqspi->iobase + CQSPI_REG_CONFIG);
+	usleep_range(1000, 1200);
+}
+
 static void cqspi_controller_enable(struct cqspi_st *cqspi, bool enable)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1912,6 +1934,9 @@ static int cqspi_probe(struct platform_device *pdev)
 
 	host->num_chipselect = cqspi->num_chipselect;
 
+	if (ddata->quirks & CQSPI_SUPPORT_DEVICE_RESET)
+		cqspi_device_reset(cqspi);
+
 	if (cqspi->use_direct_mode) {
 		ret = cqspi_request_mmap_dma(cqspi);
 		if (ret == -EPROBE_DEFER)
@@ -2054,6 +2079,15 @@ static const struct cqspi_driver_platdata versal_ospi = {
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
+static const struct cqspi_driver_platdata versal2_ospi = {
+	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA
+			| CQSPI_DMA_SET_MASK
+			| CQSPI_SUPPORT_DEVICE_RESET,
+	.indirect_read_dma = cqspi_versal_indirect_read_dma,
+	.get_dma_status = cqspi_get_versal_dma_status,
+};
+
 static const struct cqspi_driver_platdata jh7110_qspi = {
 	.quirks = CQSPI_DISABLE_DAC_MODE,
 	.jh7110_clk_init = cqspi_jh7110_clk_init,
@@ -2106,6 +2140,10 @@ static const struct of_device_id cqspi_dt_ids[] = {
 		.compatible = "mobileye,eyeq5-ospi",
 		.data = &mobileye_eyeq5_ospi,
 	},
+	{
+		.compatible = "amd,versal2-ospi",
+		.data = &versal2_ospi,
+	},
 	{ /* end of table */ }
 };
 
-- 
2.34.1


