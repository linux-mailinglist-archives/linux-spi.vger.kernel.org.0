Return-Path: <linux-spi+bounces-12343-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE901D196C5
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 325D53046DB3
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52969284896;
	Tue, 13 Jan 2026 14:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gr76A86q"
X-Original-To: linux-spi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0893027B353;
	Tue, 13 Jan 2026 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313864; cv=fail; b=DO5eCmVjuhyY6/Xf77BXTz7NS8VJAqrsMmdvsKZiYLEvomPQdPN2PbrwvWCuJTUSQ41YSDlm2lKHA3I6cw0EBkNPOcmA7Mc34O0QsrrykUocdYsu68A6dyd7Q5X2AZy7DNJBRVqd7LwUrI4xwlVIIakR1g/M40Ua6wFJ3dUWPUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313864; c=relaxed/simple;
	bh=v61YWtfUmxQi1m7QYnFQZ6skoGmt/WVB631XFFH+S50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=auXPtfTIq0IjttYjxBanHMQv5Ybpi+DRBobEi8byHUn5O4gBSvE/AU9SGkhhYL5//KFrKAyLGxt4c4odldkBfauAeQbkXJ4cWkX129XHMPU9ZFOW+AkuiI12/S0BwiWEjQLtHyMiu+Y/c05BGBeeh0Py/aqxGqhoAbubkW+VjWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=gr76A86q; arc=fail smtp.client-ip=52.101.85.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sCERRXVevPUE3pKfVDdXhPeSxSexTKo7U47lW2R1xQeNoSS1ecosRk4tWM6uPWAKA33GPuZtcUHknI9uwSU1JcZnHy8QFzLht7wcWEJkxThAwG7nQH9Rus0Kg66/yVqASLyKdqAYGiBrYM8BRETQ+13BU6fjaRSJpt+LbVz1TVgQwIcYARwLF2LBtCPDQ8/59AR0OvDUGtqgzX+kOFez7gvXrHjDG3QTkUe1ct5ehZxXak2LucBRLACudTc+8xbuxXmGbVwyA4ccUgx3m/fzm+y36WzUOUN4P9jmoTIXT2DrJIEzooIirpaGy+ZxTp1ifseGKQQdQNfjyleot7wANA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE25dewre7+KBX3ZNpZWC0AIHXXDlyTfs+uRQfChM00=;
 b=zMJ8ouDBKdqsRRAaP1sgkRJ/+BXk+X7jHtDTltfGOVJdUeVCw3Y8MaxB1K74+ffELBuye0WTzIY30CGpM+Hh1wfIUUCS71wjUy0TSoQHySo5WwTkbcoNvw9Qlk1W0TTup9nad4Y7PWwKSLhkiKqZHWDFYBrrWAbq8xEQKl3/JvGOPMBxK9nGF1ckLy2n7n3yH0m9BW5cYi93z27C+LCHRlDKCRdsFz3a5Eh/2yaxOk/F/lukD74PeqiFBapo5bxcw6UNGjaXDiTaE5BD8xbxfOPysxvKI5RYCrEBRYZxGibH0kbtgM4so4uLVO7ZxqPNbc9Xm2lvi2PJW6gOWs94Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE25dewre7+KBX3ZNpZWC0AIHXXDlyTfs+uRQfChM00=;
 b=gr76A86qXa4a86CjbnG79tO004ATbNRZvpKpo8m2vbl8CBx5pQtsQaSomkRbR9xMUPKplSJWS3a4iV0F/+2UxDoTVZ6ZbqlD2ntjuNBywLvOAzbyiaqbeUp3qtEBya/zNg5EWKLIEpyOGFeAFOdwcuJOWcq3o2N4/jAKU5N9tok=
Received: from BL0PR02CA0093.namprd02.prod.outlook.com (2603:10b6:208:51::34)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:17:40 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::94) by BL0PR02CA0093.outlook.office365.com
 (2603:10b6:208:51::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.8 via Frontend Transport; Tue,
 13 Jan 2026 14:17:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:17:38 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:19 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:18 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:17:18 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLos2381510;
	Tue, 13 Jan 2026 08:17:13 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 09/12] spi: cadence-quadspi: add PHY tuning infrastructure
Date: Tue, 13 Jan 2026 19:46:14 +0530
Message-ID: <20260113141617.1905039-10-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260113141617.1905039-1-s-k6@ti.com>
References: <20260113141617.1905039-1-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d69ccaa-d774-47b0-f4ca-08de52ae8163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uzMZhDkhA7WJkFa57kOkiMQhp/J7Ybw973MkYzICkWas/oahc2UmUsl2qjYF?=
 =?us-ascii?Q?kEZEPPw4ECwTE5vgV/dGAEPRY6BEoUIMl3/XdalkFbH8WEx/ni9NwKHiJzDR?=
 =?us-ascii?Q?rx3SJmkN+hRVCfIHZh4zfQ2yJwjGVEKgLyt3fH4097JSpAlyMv1OOwYjaBAH?=
 =?us-ascii?Q?QBgkKpLPF9e4uHhe6iU5QtR0T9IjljRVmhjWUUpgtU4er/0VBQUjUcevdaQg?=
 =?us-ascii?Q?YBM2TriJyCMNUUFpJABfqsuJv6LwbpeqHfvsa70sD40oVe1VpXJ8hVn8ubuL?=
 =?us-ascii?Q?SLmwrCyjMQiyCZZeKhLpGW1+O+3SvQNZuubeES8eVnLYukd1nZiaKscoyyw1?=
 =?us-ascii?Q?YkcSYb3Ba5gmaZYPBbSsYRERENnsXUMUxYQJy2ivMaYgiPHi8UogmCKYtgJj?=
 =?us-ascii?Q?/1RXIrIgEybKorVFvAAvZX4+Pk+o1bjKbf6KtuFxQ5r1L70WSXGRbiVPpVJF?=
 =?us-ascii?Q?KLqo70naKMv9C/hfQymhssyCuJ0fmqAFGVqcwJOht2JbNT6SPz7B10Y33CQf?=
 =?us-ascii?Q?b3LvH/FFxIK+0LFi+EaKc2YkmSVd4e+n5x4k6tbH4rrssNFIxEwMMQIDqNEF?=
 =?us-ascii?Q?wZEZPtYcc4mPxmMiwrkVSIQRNpprO0Ein6dFxylAaqgkRCconNV7rosBxg13?=
 =?us-ascii?Q?F/edaLwxwq9gKwwwYvIspfVux+Ib5EtIlGAtkWUUGO/gZd7iI0xIT5yy+md/?=
 =?us-ascii?Q?xzcsLKolly4U2k5uKG+ec4Z4xxTSM12RqyPmcxDWfxNW2YKI9/ACG3MxTa1h?=
 =?us-ascii?Q?2QI+Jrs7t5TYpNYhhzrGcpWf+LivgKqyjSu7LVIlDEYxf/ZiPjLAOnUXunQD?=
 =?us-ascii?Q?amkaWlX/9AAmuNTNpQuD2T5z0YqQO+fou7IA868tjlrk30EUi71IWyZe74Ru?=
 =?us-ascii?Q?KgVQevpLhV0xCPm1tGZqpnchSH8Ix6fPzq+aKImpy6RifBnLX90A84TGbJrb?=
 =?us-ascii?Q?cmWb5xpA76H4o68PgJV3Pqq8oNkZDSD9DZoV6/GsOJVc5v+Qbrr7kcWh7Ikl?=
 =?us-ascii?Q?ROBBMLWgXSRL9KXEBN2GwUO1m59GVq/vRFTG3z9V99pymevQLyenm6mOF7wE?=
 =?us-ascii?Q?MECdgeanO7Me/tNzgDuMF0bampq2TJ4t/Hd12wYi7yLIFnaR/bufa4vF4xg7?=
 =?us-ascii?Q?9HnfURTYeqBWC0n1XY8UoEZ2WmhwtTJFPrZ9LGdCfPA1Q1gE6ldkAr6K3l8E?=
 =?us-ascii?Q?zcFPAkz68v+io5tQBHviDcMEMFN+pSCT8E1r2zvqe6OOpCG8a65AIy5bpgAa?=
 =?us-ascii?Q?lfleJHKXWAIGF1iLPAuDPfZwKCMJewn7AJEAJFdEMgEVWlLyv4NTFQq8ycZI?=
 =?us-ascii?Q?yH5n6mKYY+KQXELXCYFGjPdGhfwE95ap6vgAtqlY2i6FeByZiC6OB9GgqdxC?=
 =?us-ascii?Q?BCQnhIF/budNTbmV3/43xLyi4q9ODAFF65nWDEmPayr71XHZXHcqLyKSfh0d?=
 =?us-ascii?Q?jVpYrNO94d44iQp4e/fWCTzmZDGuH3UCOv+RPQkDru/oQo4scTlkebj/ppFW?=
 =?us-ascii?Q?xZ1dabIHmZtSJkLa5Dd+kR4LXqwzCCSMk1mrAQovKwwfq4hLa8t/1D4ienv8?=
 =?us-ascii?Q?Sh6RTc9ebYToxNl2xfxgIQJQRN1gONwkia/kAIAN?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34020700016)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:17:38.0562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d69ccaa-d774-47b0-f4ca-08de52ae8163
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815

Implement the spi_controller_mem_ops execute_tuning callback to enable
PHY tuning support for the Cadence controller. PHY tuning optimizes data
capture timing at high frequencies by calibrating the read data capture
delay through the controller's PHY interface.

Tuning algorithm functions (cqspi_phy_tuning_ddr/sdr and
cqspi_phy_pre/post_config) are placeholders to be implemented
in subsequent commits.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 241 ++++++++++++++++++++++++++++++
 1 file changed, 241 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 0df286d24256..b8b0e85f4f68 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -32,6 +32,7 @@
 
 #define CQSPI_NAME			"cadence-qspi"
 #define CQSPI_MAX_CHIPSELECT		4
+#define CQSPI_AM654_NON_PHY_CLK_RATE	25000000
 
 static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 
@@ -65,6 +66,7 @@ struct cqspi_st;
 struct cqspi_flash_pdata {
 	struct cqspi_st	*cqspi;
 	u32		clk_rate;
+	u32		non_phy_clk_rate;
 	u32		read_delay;
 	u32		tshsl_ns;
 	u32		tsd2d_ns;
@@ -72,6 +74,8 @@ struct cqspi_flash_pdata {
 	u32		tslch_ns;
 	bool		has_dqs;
 	u8		cs;
+	struct spi_mem_op	phy_read_op;
+	struct spi_mem_op	phy_write_op;
 };
 
 struct cqspi_st {
@@ -124,6 +128,9 @@ struct cqspi_driver_platdata {
 	u32 (*get_dma_status)(struct cqspi_st *cqspi);
 	int (*jh7110_clk_init)(struct platform_device *pdev,
 			       struct cqspi_st *cqspi);
+	int (*execute_tuning)(struct spi_mem *mem, struct spi_mem_op *read_op,
+			      struct spi_mem_op *write_op);
+	u32 (*get_non_phy_clk_rate)(struct cqspi_st *cqspi);
 };
 
 /* Operation timeout value */
@@ -314,6 +321,25 @@ struct cqspi_driver_platdata {
 
 #define CQSPI_REG_VERSAL_DMA_VAL		0x602
 
+/*
+ * PHY tuning pattern for calibrating read data capture delay. This 128-byte
+ * pattern provides sufficient bit transitions across all byte lanes to
+ * reliably detect timing windows at high frequencies.
+ */
+static const u8 phy_tuning_pattern[] __aligned(64) = {
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0x00, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0x00, 0x00, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0xFE, 0x00, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0xFE, 0x00, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0xFE, 0x00, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0x00, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0xFE, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0x00, 0xFE, 0xFE, 0xFE, 0x01, 0xFF, 0xFF, 0xFF, 0xFF,
+	0xFF, 0x00, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0xFE, 0xFE,
+	0xFE, 0xFF, 0x01, 0x01, 0x01, 0x01, 0x01, 0xFE, 0xFE, 0xFE, 0xFE, 0x01,
+	0x01, 0x01, 0x01, 0xFE, 0xFE, 0xFE, 0xFE, 0x01,
+};
+
 static int cqspi_wait_for_bit(const struct cqspi_driver_platdata *ddata,
 			      void __iomem *reg, const u32 mask, bool clr,
 			      bool busywait)
@@ -1550,6 +1576,214 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static int cqspi_write_pattern_to_cache(struct cqspi_flash_pdata *f_pdata,
+					struct spi_mem *mem,
+					struct spi_mem_op *write_op)
+{
+	struct device *dev = &f_pdata->cqspi->pdev->dev;
+	int ret;
+
+	write_op->data.nbytes = sizeof(phy_tuning_pattern);
+	write_op->data.buf.out = phy_tuning_pattern;
+
+	ret = spi_mem_exec_op(mem, write_op);
+	if (ret) {
+		dev_err(dev, "Failed to write PHY pattern to cache: %d\n", ret);
+		return ret;
+	}
+	dev_dbg(dev, "PHY pattern (%zu bytes) written to cache\n",
+		sizeof(phy_tuning_pattern));
+
+	return 0;
+}
+
+static int cqspi_get_phy_pattern_offset(struct device *dev, u32 *offset)
+{
+	struct device_node *np, *flash_np = NULL;
+	struct device_node *partition_np, *part_np;
+	const char *label;
+	const __be32 *reg;
+	int len;
+
+	if (!dev || !dev->of_node)
+		return -EINVAL;
+
+	for_each_child_of_node(dev->of_node, np) {
+		if (of_node_name_prefix(np, "flash")) {
+			flash_np = np;
+			break;
+		}
+	}
+
+	if (!flash_np)
+		return -ENODEV;
+
+	partition_np = of_get_child_by_name(flash_np, "partitions");
+	if (!partition_np) {
+		of_node_put(flash_np);
+		return -ENODEV;
+	}
+
+	for_each_child_of_node(partition_np, part_np) {
+		if (of_property_read_string(part_np, "label", &label) ||
+		    !strstr(label, "phypattern"))
+			continue;
+
+		reg = of_get_property(part_np, "reg", &len);
+		if (reg && len >= sizeof(__be32)) {
+			*offset = be32_to_cpu(reg[0]);
+			of_node_put(part_np);
+			of_node_put(partition_np);
+			of_node_put(flash_np);
+			return 0;
+		}
+	}
+
+	of_node_put(partition_np);
+	of_node_put(flash_np);
+	return -ENOENT;
+}
+
+static int cqspi_phy_check_pattern(struct cqspi_flash_pdata *f_pdata,
+				   struct spi_mem *mem)
+{
+	struct spi_mem_op op;
+	u8 *read_data;
+	int ret;
+
+	read_data = kmalloc_array(1, sizeof(phy_tuning_pattern), GFP_KERNEL);
+	if (!read_data)
+		return -ENOMEM;
+
+	op = f_pdata->phy_read_op;
+	op.data.buf.in = read_data;
+	op.data.nbytes = sizeof(phy_tuning_pattern);
+
+	ret = spi_mem_exec_op(mem, &op);
+	if (ret)
+		goto out;
+
+	if (memcmp(read_data, phy_tuning_pattern, sizeof(phy_tuning_pattern)))
+		ret = -EAGAIN;
+
+out:
+	kfree(read_data);
+	return ret;
+}
+
+static void cqspi_phy_pre_config(struct cqspi_st *cqspi,
+				 struct cqspi_flash_pdata *f_pdata,
+				 const bool bypass)
+{
+	/* Placeholder for PHY pre-configuration */
+}
+
+static void cqspi_phy_post_config(struct cqspi_st *cqspi,
+				  const unsigned int delay)
+{
+	/* Placeholder for PHY post-configuration */
+}
+
+static int cqspi_phy_tuning_ddr(struct cqspi_flash_pdata *f_pdata,
+				struct spi_mem *mem)
+{
+	/* Placeholder for DDR mode PHY tuning algorithm */
+	return 0;
+}
+
+static int cqspi_phy_tuning_sdr(struct cqspi_flash_pdata *f_pdata,
+				struct spi_mem *mem)
+{
+	/* Placeholder for SDR mode PHY tuning algorithm */
+	return 0;
+}
+
+static int cqspi_am654_ospi_execute_tuning(struct spi_mem *mem,
+					   struct spi_mem_op *read_op,
+					   struct spi_mem_op *write_op)
+{
+	struct cqspi_st *cqspi =
+		spi_controller_get_devdata(mem->spi->controller);
+	struct cqspi_flash_pdata *f_pdata;
+	struct device *dev = &cqspi->pdev->dev;
+	int ret;
+	u32 phy_offset;
+
+	f_pdata = &cqspi->f_pdata[spi_get_chipselect(mem->spi, 0)];
+
+	if (read_op->max_freq <= f_pdata->non_phy_clk_rate) {
+		dev_dbg(dev,
+			"Frequency %u Hz below PHY threshold %u Hz, skipping tuning\n",
+			read_op->max_freq, f_pdata->non_phy_clk_rate);
+		return 0;
+	}
+
+	if (write_op) {
+		ret = cqspi_write_pattern_to_cache(f_pdata, mem, write_op);
+		if (ret) {
+			dev_warn(dev,
+				 "failed to write pattern to cache: %d, skipping PHY tuning\n",
+				 ret);
+			return ret;
+		}
+
+		f_pdata->phy_write_op = *write_op;
+	} else {
+		ret = cqspi_get_phy_pattern_offset(dev, &phy_offset);
+		if (ret) {
+			dev_warn(dev,
+				 "PHY pattern partition not found: %d, skipping PHY tuning\n",
+				 ret);
+			return ret;
+		}
+
+		read_op->addr.val = phy_offset;
+	}
+
+	f_pdata->phy_read_op = *read_op;
+
+	ret = cqspi_phy_check_pattern(f_pdata, mem);
+	if (ret) {
+		dev_err(dev, "PHY pattern not found: %d, skipping PHY tuning\n",
+			ret);
+		return ret;
+	}
+
+	if (read_op->cmd.dtr || read_op->addr.dtr || read_op->dummy.dtr ||
+	    read_op->data.dtr) {
+		cqspi_phy_pre_config(cqspi, f_pdata, false);
+		ret = cqspi_phy_tuning_ddr(f_pdata, mem);
+	} else {
+		cqspi_phy_pre_config(cqspi, f_pdata, true);
+		ret = cqspi_phy_tuning_sdr(f_pdata, mem);
+	}
+
+	if (ret)
+		dev_warn(dev, "PHY tuning failed: %d\n", ret);
+
+	cqspi_phy_post_config(cqspi, f_pdata->read_delay);
+
+	return ret;
+}
+
+static u32 cqspi_am654_ospi_get_non_phy_clk_rate(struct cqspi_st *cqspi)
+{
+	return CQSPI_AM654_NON_PHY_CLK_RATE;
+}
+
+static int cqspi_mem_op_execute_tuning(struct spi_mem *mem,
+				       struct spi_mem_op *read_op,
+				       struct spi_mem_op *write_op)
+{
+	struct cqspi_st *cqspi =
+		spi_controller_get_devdata(mem->spi->controller);
+
+	if (!cqspi->ddata->execute_tuning)
+		return -EOPNOTSUPP;
+
+	return cqspi->ddata->execute_tuning(mem, read_op, write_op);
+}
+
 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 				    struct cqspi_flash_pdata *f_pdata,
 				    struct device_node *np)
@@ -1584,6 +1818,10 @@ static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 		return -ENXIO;
 	}
 
+	if (f_pdata->cqspi->ddata->get_non_phy_clk_rate)
+		f_pdata->non_phy_clk_rate =
+			f_pdata->cqspi->ddata->get_non_phy_clk_rate(f_pdata->cqspi);
+
 	f_pdata->has_dqs = of_property_read_bool(np, "spi-has-dqs");
 
 	return 0;
@@ -1725,6 +1963,7 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
 	.get_name = cqspi_get_name,
 	.supports_op = cqspi_supports_mem_op,
+	.execute_tuning = cqspi_mem_op_execute_tuning,
 };
 
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
@@ -2136,6 +2375,8 @@ static const struct cqspi_driver_platdata k2g_qspi = {
 static const struct cqspi_driver_platdata am654_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL | CQSPI_SUPPORTS_QUAD,
 	.quirks = CQSPI_NEEDS_WR_DELAY,
+	.execute_tuning = cqspi_am654_ospi_execute_tuning,
+	.get_non_phy_clk_rate = cqspi_am654_ospi_get_non_phy_clk_rate,
 };
 
 static const struct cqspi_driver_platdata intel_lgm_qspi = {
-- 
2.34.1


