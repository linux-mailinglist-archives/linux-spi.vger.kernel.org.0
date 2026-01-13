Return-Path: <linux-spi+bounces-12336-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3A9D196B2
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CCCC83008F34
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007B284662;
	Tue, 13 Jan 2026 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VBVoGlVv"
X-Original-To: linux-spi@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DADA284880;
	Tue, 13 Jan 2026 14:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313817; cv=fail; b=Gp+GDub2NDz/WDQxMwrh1sd/Ph6UjiD+uBoreh+CdVcNoVlDpXl4Vh0p/HSva7r1B9PB6AzE7njefsvnxOF07udzgakdejGFVKXOyQNbC/FpUeNVbbaG0e+wI5kOdBmZcNKOpb79OUe8U3utX7dsCB9gtmUfOl3131aTx6LSW+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313817; c=relaxed/simple;
	bh=IhpvXGTKKPS74zNqi1mCEpJV4cHD6XJw668dstAzLhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXeApceNR+ax+dMsxZmCIeimr9duPSE/6mO9td1LMIzg+nSgrss3wwZCPIQW9iUaPIfo7RR/WVMW2oESf7Y/fE9M+5TaGJApJK+8Hm2HZXfNrZsRhSn5iOUt048hGYtqgx2Tvza5L/Lx0glF+J5rzp0fnUmjWEorC4XMeWVXouo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VBVoGlVv; arc=fail smtp.client-ip=52.101.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLcs9yexHhL9Adr56juIRh1Nv7YfbyHBATjNKQprA578ZoOqVqNDdB1vMGZhVZTBfqGaaI4nMS9kugHtdTBOMwdht0NPQ0xnF5ZMI/acWego23Xxy8R9wI/r15dnqf6pxQKHtPzXU4UJCgCwbkHb2gdT8EUoT6YNr1J2nQBwaV1ABDDsFg3j8U9xW6bKmHvaLl/5cuinsxA9zM5eNwbb45H0G1Em3IV9TdkLCUT71Gaosl5vUQZt/uAyyEQ1R69u3bUlTW7b9Tw68L/OLHNna34eGhL2Df9CI5NVJXyZD6IoWfDpeU0CxJVGSaJL1ijgWNFo/t095oTHdNEQYTsN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LBn5Eu8KTGZEF7ujDNE9IJrb5SbK5+wqP92XrBtT7y4=;
 b=ATmoHUQVhU4mpD1vdQLIpKYe6LQuOGtj7ulAZOqHzCS04yNLLg7vgf4iyd6AJY5OS/NWALe6m8criWtKLZS3zxIaSF8vaBFTPgUYyyJdWvfiIQMZaLIHWupj79ePi3Fc6UxC3oWoRfFajBNsSQcbJvPZBPeXpUKztbj3v06jvTvOY4LHm83R0/KJOYSJEe7zZjdXgF/Lb2IKZN9NreiKG/Hkffy8s1c5NBJb38c9UvFx8B1Mc0LgvYGGw6Ffw53a7azEJN0YPGOulUQlwwby7s7h/3uPeovXLXRulDrgdM627HVck8kECPeAHqNh+g5sRameXOXTDXgWFANThmKG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LBn5Eu8KTGZEF7ujDNE9IJrb5SbK5+wqP92XrBtT7y4=;
 b=VBVoGlVvnL4vRukHwOqtchQSHRrsq6xdDjCOL+FOrtzD91GpqtMqJubPSiZ/3YS7wdAwvZ8y5B8rD1hqRZMxS88zniX1ogl4KT043cxigWzLSdZCJFogmSqvnV4zqIUQNF4otQz1JDInjXuZxrLKI3KBGmtjciYh8faddkBbdSc=
Received: from BLAPR03CA0077.namprd03.prod.outlook.com (2603:10b6:208:329::22)
 by LV0PR10MB997612.namprd10.prod.outlook.com (2603:10b6:408:33e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:16:52 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:329:cafe::52) by BLAPR03CA0077.outlook.office365.com
 (2603:10b6:208:329::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 14:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:16:52 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:45 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:16:44 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:16:44 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLom2381510;
	Tue, 13 Jan 2026 08:16:39 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 03/12] mtd: spinand: perform controller tuning during probe
Date: Tue, 13 Jan 2026 19:46:08 +0530
Message-ID: <20260113141617.1905039-4-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|LV0PR10MB997612:EE_
X-MS-Office365-Filtering-Correlation-Id: d1f5df55-46d9-4a9a-79ee-08de52ae6602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|34020700016|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bGuabbhaKyPNUTFqPjntMrAntMmNlaxv0YNseoTZMfA7G8COvL48OJNECRFA?=
 =?us-ascii?Q?f12JOlAKiqyAAD4NzoNaJiSYQxGDtg71GHYfH694XvU2xjGgziN0Id8ogCno?=
 =?us-ascii?Q?DtvigQimAEaQKPytFbuzoBhfRHjBwwxP6P44WwRFsAo+Tt5QIQtE2FJ3Mrf8?=
 =?us-ascii?Q?7kXHczxVyvxHIw9FXlkoBYn7T8DJaujcPJJjSdA3X7AUYILKwPlhxwMQOMk9?=
 =?us-ascii?Q?8Eq50YdxlUw3wF2kHrHBYw8mos+FkTNPGpBnAG4XkrhAV3FZrPpzUkVWw9+0?=
 =?us-ascii?Q?Bvt8f6SWHyzqK9pwA/aV5KgQJ8rk/uub++5uujs7biJQMHAi872Ktg0syo0P?=
 =?us-ascii?Q?MlzBNq/vT7cEKZqtY1czzstyivM4uzf65ngCARFb9TMOyI+wd3qJMqD9CbE+?=
 =?us-ascii?Q?YMaMcu5LeqCW7jlb610RQilJ1Bl6eF35pp3UNzSfjr9D0wDxT+TvO/dc8mV5?=
 =?us-ascii?Q?pBNHZlAU1RFH3ArDWUYtIUZ/yNfbTbTFdrWp08fmBbi1hWj5WnmKyJsZIeMw?=
 =?us-ascii?Q?mTBmIwndhUpc6iR2u94I52GHPHhZnxXH7D6C7b0Rs8ZeIRqRu9RHNana8OYA?=
 =?us-ascii?Q?X1MaoOuXktd+4+dpKNAMkIM3v0CJcfMOxnIdiiZ3U16WTrTz5+k1gf0OuTW1?=
 =?us-ascii?Q?nTyXMX9a9aHQ5V2eMRqwl9UvBixYhj2LEDsOgK17fNOh9+4nRF8UwPSLLjAg?=
 =?us-ascii?Q?xBDUS63Z8A3XF3DXTFNxyO1JJlVSr6sOIdIw5Xu6GzSMDSwuEDsi5nBkhhkO?=
 =?us-ascii?Q?AG1nsgMjXjKRDrO1mskJSbb+dAh9b9O3VvrdG4yom7hxVwnfaA/znuxd5hlx?=
 =?us-ascii?Q?v4+FxHeBvkl3ytZBZiYT95L1Po6KoYWRA06DANDRH5t4cZlshpY8jdDvyY1I?=
 =?us-ascii?Q?XgO+hU4FD+JsaMZ98vwGChUtDMZK5g+ZIKUy5tgheVqBsieI0QUJrWhNRSTp?=
 =?us-ascii?Q?a+bbt/+Zv8OwBdlxf5u9UKcNoRK8GFXQ/nvMcRs6Mt+2Y2sKgg4WXlxoESsn?=
 =?us-ascii?Q?d7Lxit9VK3r4AfERWcUaa5WlpRvZ/Gi1EZG1TX1sX02s5X8LIuvlOpU6T98R?=
 =?us-ascii?Q?e9DewcX1dIK1tLBHHuhhpboicIhfM7jwQfm4z2lRdJxRBOdtH5C8qZbE+qLx?=
 =?us-ascii?Q?4M+cdDuWYoaL0SJtSpVSW1SxUDi+T0XIxHYFoGeOFk2gZjGT8IlQjgp31mh3?=
 =?us-ascii?Q?VPTR/jnSQhyZkxivwef1yksmKJGigbqOjACtB5LFc5XBoHD/3Bjw6fzfFxow?=
 =?us-ascii?Q?21TFv0paO2aWgCnsNeicUT6wJqG7cC3avWG7m5fsjl2PQiN+2TxMfOv3YuXK?=
 =?us-ascii?Q?LE8ktOcYcmqbXUVFc00IYOtQsPtm5bRlHpPLDBFFvNxf6qAHMZMZQSqnU18W?=
 =?us-ascii?Q?8e8hepPNDRhRGP7rf+QggY6LWFEWkzxJ3AqPlxAgYqcvExwxIkw10rO9cCxn?=
 =?us-ascii?Q?P3isr1PxeH7bBpMGwK3KunmSil92kBk2GLdZI1l+RBzLhUwzq6ADT2tCObJj?=
 =?us-ascii?Q?wwWLvkbGyGEz4QFt0Cq62t3uKRSZ/Mw0bjgQGP+oz91SvG1I3eRIrIKdPBBT?=
 =?us-ascii?Q?ToHjeIGMypBnX0ou6esIx150L1ySjd8Tc5yQ/Nf1?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(34020700016)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:16:52.1180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1f5df55-46d9-4a9a-79ee-08de52ae6602
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997612

SPI controllers may need tuning for reliable high-speed operation.
Without it, controllers use conservative timing that limits performance.

Call spi_mem_execute_tuning() during probe to optimize timing for
the device's read and write operations. Failures are non-fatal as
controllers fall back to default timing.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/mtd/nand/spi/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 0346916b032b..2a45d1047736 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1658,6 +1658,7 @@ static int spinand_probe(struct spi_mem *mem)
 {
 	struct spinand_device *spinand;
 	struct mtd_info *mtd;
+	struct spi_mem_op read_op, write_op;
 	int ret;
 
 	spinand = devm_kzalloc(&mem->spi->dev, sizeof(*spinand),
@@ -1676,6 +1677,19 @@ static int spinand_probe(struct spi_mem *mem)
 	if (ret)
 		return ret;
 
+	read_op = *spinand->op_templates.read_cache;
+	write_op = *spinand->op_templates.write_cache;
+
+	ret = spi_mem_execute_tuning(mem, &read_op, &write_op);
+	if (ret && ret != -EOPNOTSUPP) {
+		dev_warn(&mem->spi->dev, "Failed to execute PHY tuning: %d\n",
+			 ret);
+		/*
+		 * Tuning failure is non-fatal; the controller falls back to
+		 * default timing, reducing speed but ensuring operation.
+		 */
+	}
+
 	ret = mtd_device_register(mtd, NULL, 0);
 	if (ret)
 		goto err_spinand_cleanup;
-- 
2.34.1


