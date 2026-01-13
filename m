Return-Path: <linux-spi+bounces-12347-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0516DD1974B
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58549302B991
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5783B28DEE9;
	Tue, 13 Jan 2026 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QY01MfMJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA3B27B353;
	Tue, 13 Jan 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313900; cv=fail; b=tg9YeF1YoxXI52pFY29uGROppS2LbtcDg8WWJKcGrNIvUvs6Zl1s7nqyzTRdhyar4hX2mjUIXK9wcBl+4XDyleC8/GP3ZM2LWaxV9quTg85OeMlOIZyk0+Hx/fiWrm+B7QLSPFA1wZAU2hFZGRCVC39Vqwftp+VxsZEwVdqQ8dE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313900; c=relaxed/simple;
	bh=ZtmYj06csuF15LU1jMeOTTuo1AvBsMoM4DrJNLqLp0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXhS6M6xGWDCTAgGaCJUFThCMA8tya4Xb+hSxktF0hhyJa6M7CiDKkr8XKexh83057mQuQiW61ZY/Llpr5oAa2SLyz1rv+vWdDomJiiEasc6vDj2W2IXx/SIwfS3Byiae9jNMqtExDvkYd2Z0bt3AFXKSpDwxmnOtazcDJot8zo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QY01MfMJ; arc=fail smtp.client-ip=52.101.85.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3k6N7uHWhPVLvblTf2x7QJucQ/IjDvHUflVJq+MzxzjDyWzk5i3+oXGqjnOfkcjRTfnavHU2Z1ReTkPLYInODZGTmjeY42uscnAuGIRR5V8WJrTM1IF9xyQ6olShBq4qt1qFy4NkVdOku5W/xlmeMLuBRnlg38hjGtEvcUWWq3g7lOxQBAHS2M8AYGDiVmMD85kYJHTa6G0nMntr5R9Aeal96M9Nhi50C8kKKrFiaDpRnZMP9iwDuJ+wwHu96gyFy0wscyJBElIZPdBKMwG2P7XI5dV59pK7jhqCKVJDD7sIoNiR0xFJZjmS5slxAx3MBk3xMIL1fe8gLxDMZfw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfE9C6oing1XSrvwEGDY22K2aCrgY8v0f9ScgeN+KwU=;
 b=uOcTtOGRgXqbTD7AEtgu8DO3Hf0qlY+ex/9yHEyliLl91Sdh/tXXN16rxLwxRElLpiv0XONDIHMgvSyUNAyhqXMqvXHnRQfje7LeKm+tpYVeAvKE+3kcUoEASZc8TNkckPtaRTXZCKtPMLYZ0VMjBufZR9vccKW/hASjwdq3KIrlwrVc2aH7Hq1l96qhayd/8XBRMrxs1iVaZsaMOoGj1SFGBi2UmBOPM7zXAL7Dxe42m63S6zG8gw0ffQBYe9W5SBbuxBxVBTPWrnY1tPLjwbxeuCCOEqM9GAlRsbPdbySVvv/cs5IcnBuKYeN2/qK4R8ADVmbJNEiWmmpM8jLAXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfE9C6oing1XSrvwEGDY22K2aCrgY8v0f9ScgeN+KwU=;
 b=QY01MfMJVr3i1T5EeVwOimBXs35QtRxRMQ/J6gISBnZPY7k/Qst6xr5noD/gx3ztHPIF1qku4UegtoHbIbGpca+zz/PJElrMWpi8Bdz1xjgp1DEdDx9oqSXIE7rXDPbcQNHdLct6JU26hkbuLrULibrTL6crej6FGXjWTbS/DVg=
Received: from BL0PR02CA0073.namprd02.prod.outlook.com (2603:10b6:208:51::14)
 by CYYPR10MB7650.namprd10.prod.outlook.com (2603:10b6:930:b8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:18:11 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:208:51:cafe::a4) by BL0PR02CA0073.outlook.office365.com
 (2603:10b6:208:51::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 14:18:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:18:09 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:36 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:17:36 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLov2381510;
	Tue, 13 Jan 2026 08:17:30 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 12/12] spi: cadence-quadspi: enable PHY for direct reads and writes
Date: Tue, 13 Jan 2026 19:46:17 +0530
Message-ID: <20260113141617.1905039-13-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CYYPR10MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: ca6933dd-b4f1-4f64-1e84-08de52ae9460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|34020700016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uHB2J0C5cl6h/JKPZ1mscCBJEPz0jmE+dvCNZc+DxwO7wf6X90eagkNdZetb?=
 =?us-ascii?Q?7MyhXTP9NtNoBoPeOHoTScM3p4ykrBno2jvGx7txyUhmwFt8XK4oL4l8gJFE?=
 =?us-ascii?Q?Nzkhcrx7um8OJjguAQptIn1LypYENeg5iKlgVMrzsu39Mwag9Fu3pT0rCrTo?=
 =?us-ascii?Q?RcDej5WcjnzTMh9gSha1QEBtOPgCMNcVWVvPtzjK3hbjNxO3nmSWz1T/OIUq?=
 =?us-ascii?Q?UyUbOUPQBfzgBoYBuMHomgovPdWuA2malSYGGDxJB+xkNzsOywjNbf3Zgi55?=
 =?us-ascii?Q?7BTCRGfvBxmGp5p6b+tsNCf/cng0H/BOBPL1pxmUYjnNoDJPP2adszNHKoOy?=
 =?us-ascii?Q?0DJVkzAgd3SLctRVbcfHH/iaE2bde7eVONth6kucQWLP2R9F7pQg/ZCAPkzX?=
 =?us-ascii?Q?hSH3JqqsX2sQx2gPP0exx/09VAda9qoD+Pm3+pvTF1hW8/vxHWiTRUMHVHkY?=
 =?us-ascii?Q?CzeFaZw+Ez1hz1iOTp7MT5v8bFi6ccTgGn6FhBGZceL+twFUE4tohkSDfCGU?=
 =?us-ascii?Q?hE+s75/eB9IetXQIygMWY/fNK3Yas7fCoXYDtgrXQ0PjRlIYKcZxNRWWavps?=
 =?us-ascii?Q?L4z7i1RXwoFZXjwuNHitfjkiZoYCqJO4jVV+uIarNX1eq4iyKFTsisthLVsi?=
 =?us-ascii?Q?PS+xaSCzlzlLVG3QOlK927/DgGZWdbXmy/gtScLJlgP4+cQ2dX5VR+EMnyNm?=
 =?us-ascii?Q?ly73TrxkBKSTV1nkrj3SuUvxNCqs3SwNTIwQ3QFL7XeAhtgTXuUN9Pq3Ism4?=
 =?us-ascii?Q?AvzgGkuWPBPVtLgBe2yb3KGOvRVMTPqEq7T+jdgvT56ghpxmgGA6p9vJhG4Z?=
 =?us-ascii?Q?SPZc7NU3rfkPYuQkvlolXMVtA64d3W8H7hDYihKNnDoDQ11rhrUp8BVLE+/I?=
 =?us-ascii?Q?23kTZ9ryHCiZDihOgHGehxXUrkNMTcGs9D0SYc9MyGea9UAL8+BS+Xl27AGr?=
 =?us-ascii?Q?jeIDwISRgfHz+c6FRbDbdlb0AWHXxK3DATXJFyQLwhTgGn81JZdoE9S9nDDu?=
 =?us-ascii?Q?INVkbGVUU40hS5ssFOMcQxqIwBDYITpCcA5WdulACHf0P+PaI2fxJ0p7KJql?=
 =?us-ascii?Q?ZmENw6Gjof4t4gKuBfUdu/y8j1l17yhJPeDV9c3l3ptGlQtI4B+tw9DrLcnT?=
 =?us-ascii?Q?kuqqHJh+W/jLUTV3+zqBLRz1oWyROoCNqhcxaq2Y5sa29dJqGPehtWKEJghm?=
 =?us-ascii?Q?z9MX3LFIB24HYu+Qbu8EzfLaCmLZX6agpDZVUm1OzNNvzqqUwrEKZp2E9IjK?=
 =?us-ascii?Q?EYDR6Pery7oeVS/Ef+pOpgvEZcVfvaziyRJs2urJ63yjB5PK3Hy+AyCCq8qG?=
 =?us-ascii?Q?wmycx1InGRb0clwgO/IAhV3BJci9QNypAZ5YziRam56QbwpqSzzkoPlTdvRS?=
 =?us-ascii?Q?wZcNhrWXGWW5jliQdUtewG4aJX/UZDdf9gsBkOBiT2MDM11nG2fTClo6ELnR?=
 =?us-ascii?Q?e4bGJZG9i93/AKIeBBp1L8D0qR6MOR5ucD/xALZXzyn4IfW0D45ywJakv5HX?=
 =?us-ascii?Q?JaeTeXkfH312krT+zFRjmcCJW0zUlqU/43n/JwqtYFWb2+SWHiWmI8vU7wIJ?=
 =?us-ascii?Q?8Z68N1xFgXYgHx/esv36dgKodiUwapyVZnu2dr1N?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(34020700016)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:18:09.9155
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6933dd-b4f1-4f64-1e84-08de52ae9460
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7650

Enable PHY mode for direct memory-mapped reads and large indirect writes
(>= 1KB) to leverage calibrated RX/TX timing delays for high-frequency
operations.

PHY mode requires 16-byte alignment. For reads, split unaligned transfers
into non-PHY head, PHY-enabled middle, and non-PHY tail. Small transfers
use CPU copy to avoid DMA setup overhead.

PHY mode requires one less dummy cycle due to improved timing margins.
Adjust dummy cycles when toggling PHY mode.

Add optimized I/O copy for 8D-8D-8D operations using 4-byte bulk reads
for 32-bit platform compatibility.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 177 ++++++++++++++++++++++++++++--
 1 file changed, 167 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 3669936ae4e1..8ed6b2f5b573 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -565,6 +565,59 @@ static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
 	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
 }
 
+static void cqspi_phy_enable(struct cqspi_flash_pdata *f_pdata, bool enable)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	void __iomem *reg_base = cqspi->iobase;
+	u32 reg;
+	u8 dummy;
+
+	if (enable) {
+		cqspi_readdata_capture(cqspi, true, f_pdata->has_dqs,
+				       f_pdata->phy_setting.read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg |= CQSPI_REG_CONFIG_PHY_EN | CQSPI_REG_CONFIG_PHY_PIPELINE;
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/* PHY mode requires one less dummy cycle */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy--;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	} else {
+		cqspi_readdata_capture(cqspi, !cqspi->rclk_en, false,
+				       f_pdata->read_delay);
+
+		reg = readl(reg_base + CQSPI_REG_CONFIG);
+		reg &= ~(CQSPI_REG_CONFIG_PHY_EN |
+			 CQSPI_REG_CONFIG_PHY_PIPELINE);
+		writel(reg, reg_base + CQSPI_REG_CONFIG);
+
+		/* Restore original dummy cycle count */
+		reg = readl(reg_base + CQSPI_REG_RD_INSTR);
+		dummy = FIELD_GET(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  reg);
+		dummy++;
+		reg &= ~(CQSPI_REG_RD_INSTR_DUMMY_MASK
+			 << CQSPI_REG_RD_INSTR_DUMMY_LSB);
+		reg |= FIELD_PREP(CQSPI_REG_RD_INSTR_DUMMY_MASK
+					  << CQSPI_REG_RD_INSTR_DUMMY_LSB,
+				  dummy);
+		writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+	}
+
+	cqspi_wait_idle(cqspi);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1192,6 +1245,7 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	void __iomem *reg_base = cqspi->iobase;
 	unsigned int remaining = n_tx;
 	unsigned int write_bytes;
+	bool use_phy_write;
 	int ret;
 
 	if (!refcount_read(&cqspi->refcount))
@@ -1227,6 +1281,12 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	if (cqspi->apb_ahb_hazard)
 		readl(reg_base + CQSPI_REG_INDIRECTWR);
 
+	/* Use PHY only for large writes where setup overhead is amortized */
+	use_phy_write = n_tx >= SZ_1K && f_pdata->use_phy;
+
+	if (use_phy_write)
+		cqspi_phy_enable(f_pdata, true);
+
 	while (remaining > 0) {
 		size_t write_words, mod_bytes;
 
@@ -1267,6 +1327,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 		goto failwr;
 	}
 
+	if (use_phy_write)
+		cqspi_phy_enable(f_pdata, false);
+
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
@@ -1278,6 +1341,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	return 0;
 
 failwr:
+	if (use_phy_write)
+		cqspi_phy_enable(f_pdata, false);
+
 	/* Disable interrupt. */
 	writel(0, reg_base + CQSPI_REG_IRQMASK);
 
@@ -1448,8 +1514,17 @@ static void cqspi_rx_dma_callback(void *param)
 	complete(&cqspi->rx_dma_complete);
 }
 
-static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
-				     u_char *buf, loff_t from, size_t len)
+static bool cqspi_use_phy(struct cqspi_flash_pdata *f_pdata,
+			  const struct spi_mem_op *op)
+{
+	if (!f_pdata->use_phy || op->data.nbytes < 16)
+		return false;
+
+	return op->max_freq > f_pdata->non_phy_clk_rate;
+}
+
+static int cqspi_direct_read_dma(struct cqspi_flash_pdata *f_pdata, u_char *buf,
+				 loff_t from, size_t len)
 {
 	struct cqspi_st *cqspi = f_pdata->cqspi;
 	struct device *dev = &cqspi->pdev->dev;
@@ -1461,19 +1536,14 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	dma_addr_t dma_dst;
 	struct device *ddev;
 
-	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
-		memcpy_fromio(buf, cqspi->ahb_base + from, len);
-		return 0;
-	}
-
 	ddev = cqspi->rx_chan->device->dev;
 	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(ddev, dma_dst)) {
 		dev_err(dev, "dma mapping failed\n");
 		return -ENOMEM;
 	}
-	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src,
-				       len, flags);
+	tx = dmaengine_prep_dma_memcpy(cqspi->rx_chan, dma_dst, dma_src, len,
+				       flags);
 	if (!tx) {
 		dev_err(dev, "device_prep_dma_memcpy error\n");
 		ret = -EIO;
@@ -1507,6 +1577,93 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	return ret;
 }
 
+static void cqspi_memcpy_fromio(const struct spi_mem_op *op, void *to,
+				const void __iomem *from, size_t count)
+{
+	if (op->data.buswidth == 8 && op->data.dtr) {
+		unsigned long from_addr = (unsigned long)from;
+
+		/* Handle unaligned start with 2-byte read */
+		if (count && !IS_ALIGNED(from_addr, 4)) {
+			*(u16 *)to = __raw_readw(from);
+			from += 2;
+			to += 2;
+			count -= 2;
+		}
+
+		/* Use 4-byte reads for aligned bulk (no readq for 32-bit) */
+		if (count >= 4) {
+			size_t len = round_down(count, 4);
+
+			memcpy_fromio(to, from, len);
+			from += len;
+			to += len;
+			count -= len;
+		}
+
+		/* Handle remaining 2 bytes */
+		if (count)
+			*(u16 *)to = __raw_readw(from);
+
+		return;
+	}
+
+	memcpy_fromio(to, from, count);
+}
+
+static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
+				     const struct spi_mem_op *op)
+{
+	struct cqspi_st *cqspi = f_pdata->cqspi;
+	loff_t from = op->addr.val;
+	loff_t from_aligned, to_aligned;
+	size_t len = op->data.nbytes;
+	size_t len_aligned;
+	u_char *buf = op->data.buf.in;
+	int ret;
+
+	if (!cqspi->rx_chan || !virt_addr_valid(buf) || len <= 16) {
+		cqspi_memcpy_fromio(op, buf, cqspi->ahb_base + from, len);
+		return 0;
+	}
+
+	if (!cqspi_use_phy(f_pdata, op))
+		return cqspi_direct_read_dma(f_pdata, buf, from, len);
+
+	/* Split into unaligned head, aligned middle, unaligned tail */
+	from_aligned = ALIGN(from, 16);
+	to_aligned = ALIGN_DOWN(from + len, 16);
+	len_aligned = to_aligned - from_aligned;
+
+	if (from != from_aligned) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, from,
+					    from_aligned - from);
+		if (ret)
+			return ret;
+		buf += from_aligned - from;
+	}
+
+	if (len_aligned) {
+		cqspi_phy_enable(f_pdata, true);
+		ret = cqspi_direct_read_dma(f_pdata, buf, from_aligned,
+					    len_aligned);
+		cqspi_phy_enable(f_pdata, false);
+		if (ret)
+			return ret;
+		buf += len_aligned;
+	}
+
+	if (to_aligned != (from + len)) {
+		ret = cqspi_direct_read_dma(f_pdata, buf, to_aligned,
+					    (from + len) - to_aligned);
+		if (ret)
+			return ret;
+		buf += (from + len) - to_aligned;
+	}
+
+	return 0;
+}
+
 static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 			  const struct spi_mem_op *op)
 {
@@ -1523,7 +1680,7 @@ static ssize_t cqspi_read(struct cqspi_flash_pdata *f_pdata,
 		return ret;
 
 	if (cqspi->use_direct_mode && ((from + len) <= cqspi->ahb_size))
-		return cqspi_direct_read_execute(f_pdata, buf, from, len);
+		return cqspi_direct_read_execute(f_pdata, op);
 
 	if (cqspi->use_dma_read && ddata && ddata->indirect_read_dma &&
 	    virt_addr_valid(buf) && ((dma_align & CQSPI_DMA_UNALIGN) == 0))
-- 
2.34.1


