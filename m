Return-Path: <linux-spi+bounces-7134-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF6CA5FF74
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 19:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D7F4226D3
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 18:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320BC1F181F;
	Thu, 13 Mar 2025 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A+pHRf3k"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2054.outbound.protection.outlook.com [40.107.101.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EAF1F0990;
	Thu, 13 Mar 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741890975; cv=fail; b=QfYtt+8m5S/lNWK6mXrxs785frOQpRm94HMPPFs1U0+si/UMfPXZLxONrhB8QUf4NOupQDGAt+6Z0PbJinzVde7iouXLg0L/8dGBptpjtlqg5K98HY+3Yu0PiRr2VbwEOPRUc+MzoOsgEmcV6M2xU/MO/ieQr/NOhWDsIC0iK2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741890975; c=relaxed/simple;
	bh=MOhIAO/MgceUyoSy8atn8t6SZiRGoT1FBPrHnv7DTlQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+J5pALpH0nZAzI9MqsQTbaJ6ZNVxwxzoAas2REgxS1P2Hoj6rkXnpzP8zMoAmPLogHM7hbQqMMo0xl72ZkI+OOPC8x3ITZK8FHGE4cgnKo5Df4ydP2kmgFTu+ffJcX2bdYbit/zh7SWDsyulKKAKHgDlzARG0twKEe/fpsHCDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A+pHRf3k; arc=fail smtp.client-ip=40.107.101.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGDuIbsexwx99PsHIRgp+3RCvNW8E3e3tZjJN224VKD3oPSwCkiL5rCn9GEvz4GEKzsxdWBZy/F2GGuWonTnV8++NUHuNt9XsUGC4kLKjCWkb8EScFz/KoeCRV/5Cac40R1QTzvczx2PnZr/Wh4PvTDmCw0LLSEHojstpa1WgrPjQ5uObfdpiAD0HO3L4/06tgID4lDA6Q+lA28qn5Q2UvSjU6Q4CXWjfOIzh3fug3EqvZQ+Zv9sV3PRNLJQpNQ4kKJe6qIhPviLf8wz60w/axRP5z1PnK7PwvEFAjYn+lg/QmV+X5hHa3j/NU95f10cNgYB9eCWEq8mcCojl0OQKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTTmlTjDWm1tLxRuVsp9NkQjtIrcTAvS1pqvB8RuzbE=;
 b=uOV0nfqB76Sk6YovM/hIJq86zwqFNh6UsWkLkRmHTVEDkwoB+fH9LYVqwGEWp7bjqz8wce7CH+5Rygjs5xc1DlxJVq1vZJUUPY2DUO+AFPEXSkI6uVrW4BdoXSKL2Yy/ya3u9T1PNdATC1luheBUuCihz6NIPIuvGIhiUIKa8V5nRLuXWaRaWrpchwhfJ0/VYk/omdsCJisoDMxp+5Q0kv6jByKLyAoAEJqevJsMA9NsR79sR31J8AvUh5UIQn7Be+5bK6Oy610O7iHkQt1nkJwmnxVJ1fScWLdI0GKPEDNP5+p2DQUq1/sskYbIM8EQprfj1UD9jObbZEuO5D/fAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTTmlTjDWm1tLxRuVsp9NkQjtIrcTAvS1pqvB8RuzbE=;
 b=A+pHRf3kUpIiCcABnHRuz64CzUrRfcqxeQt2Tqf8gzNzkKodFlLDDYWDXx2A8YkTE90fZ8u5DQaJS083PKxAQxQ09rWEFbZFUZZBQBjeBM3BdMsHKJzPjd3j+vL+0YLGGcYiKVw+KIDeJcNavgPY7z54MK+la6+tyIjtwQlJbBg=
Received: from SA9PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:6e::8)
 by SN7PR12MB7024.namprd12.prod.outlook.com (2603:10b6:806:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 18:36:07 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:6e:cafe::8e) by SA9PR11CA0003.outlook.office365.com
 (2603:10b6:806:6e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Thu,
 13 Mar 2025 18:36:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 13 Mar 2025 18:36:07 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Mar
 2025 13:36:04 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <Raju.Rangoju@amd.com>, <krishnamoorthi.m@amd.com>,
	<akshata.mukundshetty@amd.com>
Subject: [PATCH 08/10] spi: espi_amd: Add support for IO/MMIO configuration
Date: Fri, 14 Mar 2025 00:04:38 +0530
Message-ID: <20250313183440.261872-9-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250313183440.261872-1-Raju.Rangoju@amd.com>
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SN7PR12MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a74e4b3-bb2f-45ef-3141-08dd625deb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9va9e+oZULPHUHXrzS9t8A0SEnq7i/dke8etNDwzgNOl8/Uhsy4TnxIyCHwT?=
 =?us-ascii?Q?5YM3itTrAN7pQNPSxvMXExoAd3tX+nkrqK1qxkh5F1Ln2tt0uwbYw9vWAqAL?=
 =?us-ascii?Q?OxMZx/H9TFZIvN7dvi+kxrr58ugPVpHifDqGFw/gZRDY41OXZ2C9j7EroYeE?=
 =?us-ascii?Q?af+hnr5MT6cG0DPh99qxitXhVgu93Opda97chTCOWRDYkkjBNQ+3c1GI1T/a?=
 =?us-ascii?Q?40l8iQTNPfEUSqz6U+/7ocGv7UtCyvucFW9hl0JVJmAgUe8Agvrdu9PsU6MV?=
 =?us-ascii?Q?ELm38KpWjtlmX+nO8334HzZ2eXbL2Jb+LWzB3CbrWHw/Mtuux6vLm7t51wxS?=
 =?us-ascii?Q?MWvC+E+VfRZ1WeuSqZMVxiF2FvN7KKM7zwXnYVP74uBdokrAYZ04gYgvevrC?=
 =?us-ascii?Q?eD90OofdEaPkhcdSa4LO7sAMlbUES64SlSWByMaFH3hVGg0X31tf4IqD3XpK?=
 =?us-ascii?Q?shsRKt3eH3HzWptXDh63/4Gpqeonz2XyFSDOmpeFFxL6oEOrtodlQWMV7s1o?=
 =?us-ascii?Q?i4l45q9OmFIMZ4hbUBDpV85sfOw/baNRRONIj6I9y7CYnxx3A35TDhszQ0AE?=
 =?us-ascii?Q?+tUYJO8yxM2xdBGgR2FfWbUim+8UVNH3de9S/jOKVzSrGo9xICAX1pFbucRm?=
 =?us-ascii?Q?WWmpt7rqosvo3sHUHSOKli9FlwcLcwFtsA99vIj0gLEJk/58hnGInOgHMGRX?=
 =?us-ascii?Q?+AmnUGWKPUgg0+hUQrpFX4ZiTHcBeSe5it7weQwHeBz9muvmhdyBB6p8PD8k?=
 =?us-ascii?Q?i6jMbFgTOd28e2gKiZc2Www4a48iLx/FCxfstHARA+iaQ29Rbq0NyO6i3hdE?=
 =?us-ascii?Q?O2o34Iqz49O39k9/mI5vpAXsi9IwT0DBV2EF8tD2SvSdfsMu1deX3razhQAe?=
 =?us-ascii?Q?73qd3QS90tEN1WZZ3a7RkonHaD1y1WbzUFFuVuidsjeEWl5NqfWT0gvx3/Ay?=
 =?us-ascii?Q?gmywkT2Tw72m32dKpyPKv/dkJXHEmdw8WKhZyBRaM0jTSmP7CktbXYhGHG0U?=
 =?us-ascii?Q?E3UhmAcjI2eE/7KoRouNWFFb/mO8n6t6Y8Y/PL58UG+jjMuJgxpgxHNm5K4d?=
 =?us-ascii?Q?Ie3yvjiNt+3H3riUbsS9phELEiz4rWzz4JXkBl69GT0LUZcfpa03/uYRGgWO?=
 =?us-ascii?Q?MY1MWvPvtu1c11A5Fk9+uVBAsnoybw8vY9O2ZbtSfBO4I0h+jrb3EVuM47dn?=
 =?us-ascii?Q?i7jSBqadddKC2UVVdeJh5c1qgtkjWhIuDzg6ntkTVEdhcx0YNKL1yJogk6R7?=
 =?us-ascii?Q?wid0ptcRh5NdZjO5ZFUp309Q/fYsKAQlORjdS2oodbGRtJAPMo7iwoFuD9aB?=
 =?us-ascii?Q?8sMBEYPiG3BvOF4fp4H9sv1kKSliNLcyPI9B4gmIExjC3Y0ZcawwE3SX6NOa?=
 =?us-ascii?Q?dMUztrnNavTdMr/wad17scdchTo7TH35Gamdro6O61iWNhWU9j1Syk1CVKtt?=
 =?us-ascii?Q?RxyY2e49FLmiwJIPDHHwCSBD6HdpkXSvAGgTZgIZif3sdGW7Gz/E4w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 18:36:07.3531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a74e4b3-bb2f-45ef-3141-08dd625deb36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024

Add support to configure the eSPI slave0 IO/MMIO address before
initiating the peripheral channel IO/MMIO read and write operations.
This patch introduces new IOCTLs to enable, disable and read IO/MMIO
configurations.

Co-developed-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Signed-off-by: Krishnamoorthi M <krishnamoorthi.m@amd.com>
Co-developed-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Akshata MukundShetty <akshata.mukundshetty@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/spi/espi-amd-core.c | 157 ++++++++++++++++++++++++++++++++++++
 drivers/spi/espi-amd-dev.c  |  53 ++++++++++++
 drivers/spi/espi-amd.h      |  91 +++++++++++++++++++++
 3 files changed, 301 insertions(+)

diff --git a/drivers/spi/espi-amd-core.c b/drivers/spi/espi-amd-core.c
index 72a625b8b16d..3704cbd816ae 100644
--- a/drivers/spi/espi-amd-core.c
+++ b/drivers/spi/espi-amd-core.c
@@ -553,6 +553,163 @@ int amd_espi_setup_vw_channel(struct amd_espi *amd_espi, u32 slave_caps)
 			CHANNEL_MODE_VW);
 }
 
+void amd_espi_get_io_mmio_decode_info(struct amd_espi *amd_espi,
+				      struct io_mmio_decode_config *config)
+{
+	config->io_mmio_dc_enable = readl(ESPI_BASE + AMD_ESPI_SLAVE0_DECODE_EN_REG);
+	config->range0.val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_IO_BASE_REG0_REG);
+	config->range1.val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_IO_BASE_REG1_REG);
+	config->range2.val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_IO_SIZE_REG);
+	config->mmio_target_range0 = readl(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_BASE_REG0);
+	config->mmio_target_range1 = readl(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_BASE_REG1);
+	config->mmio_target_range2 = readl(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_BASE_REG2);
+	config->mmio_target_range3 = readl(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_BASE_REG3);
+	config->mmio_range4.val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_SIZE_REG0);
+	config->mmio_range5.val = readl(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_SIZE_REG1);
+}
+
+void amd_espi_set_io_mmio_decode_config(struct amd_espi *amd_espi,
+					struct io_mmio_decode_config *config)
+{
+	struct io_mmio_decode_config io_dc_conf;
+
+	amd_espi_get_io_mmio_decode_info(amd_espi, &io_dc_conf);
+	writel(((~(config->io_mmio_dc_enable) & io_dc_conf.io_mmio_dc_enable) |
+		config->io_mmio_dc_enable), (ESPI_BASE + AMD_ESPI_SLAVE0_DECODE_EN_REG));
+
+	/* IO RANGE-0 configuration */
+	if (config->io_mmio_dc_enable & IO_DECODE_RANGE0) {
+		if (config->range0.base_addr_range0 != io_dc_conf.range0.base_addr_range0) {
+			writel(((io_dc_conf.range0.val & CNTRL_IO_DECODE_ADDR_MASK(0)) |
+				config->range0.val),
+				(ESPI_BASE + AMD_ESPI_SLAVE0_IO_BASE_REG0_REG));
+			writel(((io_dc_conf.range2.val & CNTRL_IO_DECODE_SIZE_MASK(0)) |
+				config->range2.val), (ESPI_BASE + AMD_ESPI_SLAVE0_IO_SIZE_REG));
+		}
+	}
+
+	/* IO RANGE-1 configuration */
+	if (config->io_mmio_dc_enable & IO_DECODE_RANGE1) {
+		if (config->range0.base_addr_range1 != io_dc_conf.range0.base_addr_range1) {
+			writel(((io_dc_conf.range0.val & CNTRL_IO_DECODE_ADDR_MASK(16)) |
+				config->range0.val),
+				(ESPI_BASE + AMD_ESPI_SLAVE0_IO_BASE_REG0_REG));
+			writel(((io_dc_conf.range2.val & CNTRL_IO_DECODE_SIZE_MASK(8)) |
+				config->range2.val), (ESPI_BASE + AMD_ESPI_SLAVE0_IO_SIZE_REG));
+		}
+	}
+
+	/* IO RANGE-2 configuration */
+	if (config->io_mmio_dc_enable & IO_DECODE_RANGE2) {
+		if (config->range1.base_addr_range2 != io_dc_conf.range1.base_addr_range2) {
+			writel(((io_dc_conf.range1.val & CNTRL_IO_DECODE_ADDR_MASK(0)) |
+				config->range1.val),
+				(ESPI_BASE + AMD_ESPI_SLAVE0_IO_BASE_REG1_REG));
+			writel(((io_dc_conf.range2.val & CNTRL_IO_DECODE_SIZE_MASK(16)) |
+				config->range2.val), (ESPI_BASE + AMD_ESPI_SLAVE0_IO_SIZE_REG));
+		}
+	}
+
+	/* IO RANGE-3 configuration */
+	if (config->io_mmio_dc_enable & IO_DECODE_RANGE3) {
+		if (config->range1.base_addr_range3 != io_dc_conf.range1.base_addr_range3) {
+			writel(((io_dc_conf.range1.val & CNTRL_IO_DECODE_ADDR_MASK(16)) |
+				config->range1.val),
+				(ESPI_BASE + AMD_ESPI_SLAVE0_IO_BASE_REG1_REG));
+			writel(((io_dc_conf.range2.val & CNTRL_IO_DECODE_SIZE_MASK(24)) |
+				config->range2.val), (ESPI_BASE + AMD_ESPI_SLAVE0_IO_SIZE_REG));
+		}
+	}
+
+	/* MMIO RANGE-0 configure */
+	if (config->io_mmio_dc_enable & MMIO_DECODE_RANGE0) {
+		if (config->mmio_target_range0 != io_dc_conf.mmio_target_range0) {
+			writel(config->mmio_target_range0,
+			       (ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_BASE_REG0));
+			writel(((io_dc_conf.mmio_range4.val & CNTRL_MMIO_DECODE_SIZE_MASK(0)) |
+				config->mmio_range4.val),
+				(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_SIZE_REG0));
+		}
+	}
+
+	/* MMIO RANGE-1 configure */
+	if (config->io_mmio_dc_enable & MMIO_DECODE_RANGE1) {
+		if (config->mmio_target_range1 != io_dc_conf.mmio_target_range1) {
+			writel(config->mmio_target_range1,
+			       (ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_BASE_REG1));
+			writel(((io_dc_conf.mmio_range4.val & CNTRL_MMIO_DECODE_SIZE_MASK(16)) |
+				config->mmio_range4.val),
+				(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_SIZE_REG0));
+		}
+	}
+
+	/* MMIO RANGE-2 configure */
+	if (config->io_mmio_dc_enable & MMIO_DECODE_RANGE2) {
+		if (config->mmio_target_range2 != io_dc_conf.mmio_target_range2) {
+			writel(config->mmio_target_range2,
+			       (ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_BASE_REG2));
+			writel(((io_dc_conf.mmio_range5.val & CNTRL_MMIO_DECODE_SIZE_MASK(0)) |
+				config->mmio_range5.val),
+				(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_SIZE_REG1));
+		}
+	}
+
+	/* MMIO RANGE-3 configure */
+	if (config->io_mmio_dc_enable & MMIO_DECODE_RANGE3) {
+		if (config->mmio_target_range3 != io_dc_conf.mmio_target_range3) {
+			writel(config->mmio_target_range3,
+			       (ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_BASE_REG3));
+			writel(((io_dc_conf.mmio_range5.val & CNTRL_MMIO_DECODE_SIZE_MASK(16)) |
+				config->mmio_range5.val),
+				(ESPI_BASE + AMD_ESPI_SLAVE0_MMIO_SIZE_REG1));
+		}
+	}
+}
+
+void amd_espi_disable_io_decode_range(struct amd_espi *amd_espi, u32 io_range)
+{
+	u32 io_mmio_dc_enable = readl(ESPI_BASE + AMD_ESPI_SLAVE0_DECODE_EN_REG);
+
+	switch (io_range) {
+	case 1:
+		if (io_mmio_dc_enable & IO_DECODE_RANGE0)
+			io_mmio_dc_enable = io_mmio_dc_enable ^ IO_DECODE_RANGE0;
+		break;
+	case 2:
+		if (io_mmio_dc_enable & IO_DECODE_RANGE1)
+			io_mmio_dc_enable = io_mmio_dc_enable ^ IO_DECODE_RANGE1;
+		break;
+	case 3:
+		if (io_mmio_dc_enable & IO_DECODE_RANGE2)
+			io_mmio_dc_enable = io_mmio_dc_enable ^ IO_DECODE_RANGE2;
+		break;
+	case 4:
+		if (io_mmio_dc_enable & IO_DECODE_RANGE3)
+			io_mmio_dc_enable = io_mmio_dc_enable ^ IO_DECODE_RANGE3;
+		break;
+	case 5:
+		if (io_mmio_dc_enable & MMIO_DECODE_RANGE0)
+			io_mmio_dc_enable = io_mmio_dc_enable ^ MMIO_DECODE_RANGE0;
+		break;
+	case 6:
+		if (io_mmio_dc_enable & MMIO_DECODE_RANGE1)
+			io_mmio_dc_enable = io_mmio_dc_enable ^ MMIO_DECODE_RANGE1;
+		break;
+	case 7:
+		if (io_mmio_dc_enable & MMIO_DECODE_RANGE2)
+			io_mmio_dc_enable = io_mmio_dc_enable ^ MMIO_DECODE_RANGE2;
+		break;
+	case 8:
+		if (io_mmio_dc_enable & MMIO_DECODE_RANGE3)
+			io_mmio_dc_enable = io_mmio_dc_enable ^ MMIO_DECODE_RANGE3;
+		break;
+	default:
+		break;
+	}
+
+	writel(io_mmio_dc_enable, (ESPI_BASE + AMD_ESPI_SLAVE0_DECODE_EN_REG));
+}
+
 static int amd_espi_get_master_cap(struct amd_espi *amd_espi, struct espi_master *master)
 {
 	u32 master_cap_reg, info;
diff --git a/drivers/spi/espi-amd-dev.c b/drivers/spi/espi-amd-dev.c
index 9f1968566980..31fb06f4a3ff 100644
--- a/drivers/spi/espi-amd-dev.c
+++ b/drivers/spi/espi-amd-dev.c
@@ -286,9 +286,49 @@ static int amd_espi_ioctl_set_freq(struct amd_espi *amd_espi, unsigned long arg)
 	return ret;
 }
 
+static int amd_espi_ioctl_get_io_decode_conf(struct amd_espi *amd_espi, unsigned long arg)
+{
+	struct io_mmio_decode_config *io_dc_config;
+	int ret = 0;
+
+	io_dc_config = kzalloc(sizeof(*io_dc_config), GFP_KERNEL);
+	if (!io_dc_config)
+		return -ENOMEM;
+
+	amd_espi_get_io_mmio_decode_info(amd_espi, io_dc_config);
+
+	if (copy_to_user((void __user *)arg, io_dc_config, sizeof(struct io_mmio_decode_config)))
+		ret = -EFAULT;
+
+	kfree(io_dc_config);
+	return ret;
+}
+
+static int amd_espi_ioctl_enable_io_decode_conf(struct amd_espi *amd_espi, unsigned long arg)
+{
+	struct io_mmio_decode_config *io_dc_config;
+	int ret = 0;
+
+	io_dc_config = kzalloc(sizeof(*io_dc_config), GFP_KERNEL);
+	if (!io_dc_config)
+		return -ENOMEM;
+
+	if (copy_from_user(io_dc_config, (void __user *)arg,
+			   sizeof(struct io_mmio_decode_config))) {
+		ret = -EFAULT;
+		goto decode_config_free;
+	}
+	amd_espi_set_io_mmio_decode_config(amd_espi, io_dc_config);
+
+decode_config_free:
+	kfree(io_dc_config);
+	return ret;
+}
+
 static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct amd_espi *amd_espi = filp->private_data;
+	u32 io_range = 0;
 	int ret = 0;
 
 	/* Check type and command number */
@@ -316,6 +356,19 @@ static long amd_espi_ioctl(struct file *filp, unsigned int cmd, unsigned long ar
 	case  ESPI_SET_FREQ:
 		ret = amd_espi_ioctl_set_freq(amd_espi, arg);
 		break;
+	case ESPI_GET_IODECODE_CONFIG:
+		ret = amd_espi_ioctl_get_io_decode_conf(amd_espi, arg);
+		break;
+	case ESPI_EN_IODECODE_CONFIG:
+		ret = amd_espi_ioctl_enable_io_decode_conf(amd_espi, arg);
+		break;
+	case ESPI_DS_IODECODE_CONFIG:
+		if (copy_from_user(&io_range, (void __user *)arg, sizeof(unsigned int))) {
+			ret = -EFAULT;
+			break;
+		}
+		amd_espi_disable_io_decode_range(amd_espi, io_range);
+		break;
 	default:
 		dev_err(amd_espi->dev, "ESPI command not found, returning error\n");
 		ret = -EINVAL;
diff --git a/drivers/spi/espi-amd.h b/drivers/spi/espi-amd.h
index e5760db7c1d3..ae76243786f0 100644
--- a/drivers/spi/espi-amd.h
+++ b/drivers/spi/espi-amd.h
@@ -33,6 +33,19 @@
 #define AMD_ESPI_MISC_CNTRL_REG0	0x38
 #define AMD_ESPI_MISC_CNTRL_REG1	0x3c
 
+/* Slave-0 registers IO and MMIO config registers */
+#define AMD_ESPI_SLAVE0_DECODE_EN_REG		0x40
+#define AMD_ESPI_SLAVE0_IO_BASE_REG0_REG	0x44
+#define AMD_ESPI_SLAVE0_IO_BASE_REG1_REG	0x48
+#define AMD_ESPI_SLAVE0_IO_SIZE_REG		0x4C
+#define AMD_ESPI_SLAVE0_MMIO_BASE_REG0		0x50
+#define AMD_ESPI_SLAVE0_MMIO_BASE_REG1		0x54
+#define AMD_ESPI_SLAVE0_MMIO_BASE_REG2		0x58
+#define AMD_ESPI_SLAVE0_MMIO_BASE_REG3		0x5C
+#define AMD_ESPI_SLAVE0_MMIO_SIZE_REG0		0x60
+#define AMD_ESPI_SLAVE0_MMIO_SIZE_REG1		0x64
+#define AMD_ESPI_MMIO_ADDR_LEN			4
+
 /* Slave-0 configuration and interrupt registers */
 #define AMD_ESPI_SLAVE0_CONFIG_REG		0x68
 #define AMD_ESPI_SLAVE0_INT_EN_REG		0x6C
@@ -136,6 +149,20 @@
 #define ESPI_CNTRL_SET_OP_FREQ(conf, freq) (((conf) & ESPI_CNTRL_OP_MODE_MASK) |\
 					    ((freq) << ESPI_CNTRL_SLAVE0_FREQ_SHIFT))
 
+/* Slave-0 IO and MMIO decode enable configurations */
+#define IO_DECODE_RANGE0	BIT(8)
+#define IO_DECODE_RANGE1	BIT(9)
+#define IO_DECODE_RANGE2	BIT(10)
+#define IO_DECODE_RANGE3	BIT(11)
+#define MMIO_DECODE_RANGE0	BIT(12)
+#define MMIO_DECODE_RANGE1	BIT(13)
+#define MMIO_DECODE_RANGE2	BIT(14)
+#define MMIO_DECODE_RANGE3	BIT(15)
+
+#define CNTRL_IO_DECODE_ADDR_MASK(val)   (~(GENMASK(15, 0) << (val)))
+#define CNTRL_IO_DECODE_SIZE_MASK(val)   (~(GENMASK(3, 0) << (val)))
+#define CNTRL_MMIO_DECODE_SIZE_MASK(val) (~(GENMASK(15, 0) << (val)))
+
 #define ESPI_BASE		((u8 __iomem *)amd_espi->io_remap_addr)
 
 /* IOCTL calls */
@@ -146,6 +173,9 @@
 #define ESPI_SET_IO_MODE             _IOW(ESPI_MAGIC_NUMBER, 0x4, struct config)
 #define ESPI_SET_CHAN_MODE           _IOW(ESPI_MAGIC_NUMBER, 0x5, struct config)
 #define ESPI_SET_FREQ                _IOW(ESPI_MAGIC_NUMBER, 0x6, struct config)
+#define ESPI_GET_IODECODE_CONFIG     _IOWR(ESPI_MAGIC_NUMBER, 0x7, struct io_mmio_decode_config)
+#define ESPI_EN_IODECODE_CONFIG      _IOWR(ESPI_MAGIC_NUMBER, 0x8, struct io_mmio_decode_config)
+#define ESPI_DS_IODECODE_CONFIG      _IOWR(ESPI_MAGIC_NUMBER, 0x9, u32)
 
 /*
  * enum amd_espi_versions - eSPI controller versions
@@ -282,6 +312,62 @@ struct espi_txcmd {
 	u32 expected_status_codes;
 };
 
+/* IO/MMIO decode configuartions */
+union io_target_range0 {
+	u32 val;
+	struct {
+		u16 base_addr_range0;
+		u16 base_addr_range1;
+	};
+};
+
+union io_target_range1 {
+	u32 val;
+	struct {
+		u16 base_addr_range2;
+		u16 base_addr_range3;
+	};
+};
+
+union io_target_range2 {
+	u32 val;
+	struct {
+		u32 io_range0_size:8;
+		u32 io_range1_size:8;
+		u32 io_range2_size:8;
+		u32 io_range3_size:8;
+	};
+};
+
+union mmio_target_range4 {
+	u32 val;
+	struct {
+		u32 mmio_range0_size : 16;
+		u32 mmio_range1_size : 16;
+	};
+};
+
+union mmio_target_range5 {
+	u32 val;
+	struct {
+		u32 mmio_range2_size : 16;
+		u32 mmio_range3_size : 16;
+	};
+};
+
+struct io_mmio_decode_config {
+	u32 io_mmio_dc_enable;
+	union io_target_range0 range0;
+	union io_target_range1 range1;
+	union io_target_range2 range2;
+	u32 mmio_target_range0;
+	u32 mmio_target_range1;
+	u32 mmio_target_range2;
+	u32 mmio_target_range3;
+	union mmio_target_range4 mmio_range4;
+	union mmio_target_range5 mmio_range5;
+};
+
 /* Function prototypes */
 int amd_espi_device_create(struct amd_espi *amd_espi, struct device *dev);
 void amd_espi_device_remove(struct amd_espi *amd_espi);
@@ -297,4 +383,9 @@ int amd_espi_get_channel_config(struct amd_espi *amd_espi);
 int amd_espi_setup_periph_channel(struct amd_espi *amd_espi, u32 slave_caps);
 int amd_espi_setup_vw_channel(struct amd_espi *amd_espi, u32 slave_caps);
 void amd_espi_clr_all_intr(struct amd_espi *amd_espi);
+void amd_espi_get_io_mmio_decode_info(struct amd_espi *amd_espi,
+				      struct io_mmio_decode_config *config);
+void amd_espi_set_io_mmio_decode_config(struct amd_espi *amd_espi,
+					struct io_mmio_decode_config *config);
+void amd_espi_disable_io_decode_range(struct amd_espi *amd_espi, u32 io_range);
 #endif
-- 
2.34.1


