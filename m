Return-Path: <linux-spi+bounces-12339-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BFAD196B4
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 15:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 477BF3072ECE
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jan 2026 14:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0483280309;
	Tue, 13 Jan 2026 14:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BwYpqSxY"
X-Original-To: linux-spi@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010067.outbound.protection.outlook.com [52.101.56.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D141DEFE9;
	Tue, 13 Jan 2026 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313831; cv=fail; b=QPWLz9xuuxcQFuG1z7/aM+rTfGYbK10LayJcjn4L9NImF8Y684cf+sDzvXN/a9/yJLSMvtrQ1K0g3HDF/Yn6xChOmJXwNQ6vH5vXTZbv8eEmc0BmTbSEFfnvP/a5GlZv27vb/4yR13QqbJjGxTyZmp0Rdv7Xf7OOMYDXDVOJWJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313831; c=relaxed/simple;
	bh=jWJVPp12dr7CS03tE9zUaYRygQ86gxFV8WfHQP0oVmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IcOqLFjChJahQ4pM/0bsD8BxTbYFZgKZyJ0+IKTmbOrTpN7XNwaDUC9zMuZTH2UOgo16Ouaej5YVhDnVKumvtsjJY8SveXmGh89iAr79NloFG8fLNHdBiEmO1eCdhMwkGxr1/4qilwyTdbeprgYD9Ldf7gzlgStVpeUd9Jw3BbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BwYpqSxY; arc=fail smtp.client-ip=52.101.56.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vTigFFXvX5LKkxkVNs9sQSJOuOTnk4VRzEr6dOgA3C+kLXcWxi1dmTScfGpih27D+FT2AwguYHIoqcQPXEFbzR7Ngb330ag3bfHuOQfabIURAOY0jRd1zTONS6IgdTaBNrcSgyFHCjGST11dGzjrCsiXLViMcfDVvcqkgmXIV4GVzeq4DWqgz0mVJ+9o4J1ieWTLJ77J0cn5R2AQ3Q9E7KK265otX2xgG49480+ozm379/pHOV3hU62GcaZsIdY15aAPejMH2rVa+fZFKfaJpSrCDSPkwpRCuymappdmmMSp7NCmhGZXF0hBZHUk1wVYaw8SMgsRzLj5H3kIlGq//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvu/GG1eB5CCQ2YjhSW/X9lc1BagUZktkNNziacNRRM=;
 b=oGLDXH26NrmQ94SzEID/hvtG07x7qwIX3jG9GWkwxLL1O+R+8MKuZdX5Uxf20+hvj/h8WTgDaSgu0pDweSX8oACGMJQEv9T9hx9HNsQYvf3IsLqil8eRSCLr797NlrQ4lXSBthqlOlP/KYOIg8+QQJUuhARBIdTXqnBkTq9DAJV0HRx1eDWYzmqJWs6vx+T8J0kD/w8fjVyCLRXRdOgfeInWGZ8dnZVc8W9/ptRa8b94oF/pMc1pHLc5wOdledHzziYxAZ69WKTja2dusB4HHmSPu6dNRUYsptv8NBuzgfGeqNOlkUIpr3j/zbDdaD/tBPRjkYg96l1KtsxCal50ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvu/GG1eB5CCQ2YjhSW/X9lc1BagUZktkNNziacNRRM=;
 b=BwYpqSxY1Z/imlU0hGp/FaFvtzC1jpxx0Uhl8F6xjoF9Us6HTD+Z0WIdc9bejCtmQP56GGKvZt+ZZtqgwGTKzOcBpDGPCNRi0Wz/CDdwGMklA0ZA1VLR52tB30TI1E7SAbzeD59LscctPQcZk0PWXfZCPh2rygYl2iaxAZqGIYY=
Received: from PH8PR15CA0002.namprd15.prod.outlook.com (2603:10b6:510:2d2::29)
 by PH3PPFE7CE61147.namprd10.prod.outlook.com (2603:10b6:518:1::7d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 14:17:03 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::1b) by PH8PR15CA0002.outlook.office365.com
 (2603:10b6:510:2d2::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 14:17:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 14:17:02 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:02 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 08:17:01 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 08:17:01 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com [172.24.233.254])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DEGLop2381510;
	Tue, 13 Jan 2026 08:16:56 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <tudor.ambarus@linaro.org>, <pratyush@kernel.org>,
	<mwalle@kernel.org>
CC: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
	<praneeth@ti.com>, <u-kumar1@ti.com>, <p-mantena@ti.com>, <a-dutta@ti.com>,
	<s-k6@ti.com>
Subject: [RFC PATCH v2 06/12] spi: cadence-quadspi: move cqspi_readdata_capture earlier
Date: Tue, 13 Jan 2026 19:46:11 +0530
Message-ID: <20260113141617.1905039-7-s-k6@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH3PPFE7CE61147:EE_
X-MS-Office365-Filtering-Correlation-Id: 05556bbc-4311-4832-8980-08de52ae6c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|34020700016|82310400026|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l4eoqHVLqGEkBCGIcBj0HLJAu8DMivUQ8/Fl1uFRaQopY9ZeJPNlaXXEqyBL?=
 =?us-ascii?Q?c0fz6ijtUlJQHXv2EyPaPEBnMjrDc2ic9WeHMECWbT4FXzCXPUSdWbl2eG2c?=
 =?us-ascii?Q?vV7OnqewG+UOHAGSqN8zf+5XJlCKhuSQYMaJVNbxYMJaqF+NTeiex9LPBuiq?=
 =?us-ascii?Q?vhnZgwStdRoquK5HgpkgLlV+VIyosWNIAy6FXq0l7wy8RtoYcoGLYnHIimXt?=
 =?us-ascii?Q?hR0rTo9HwYZrg3fEJcPlzp2vCtGunezDkCYbOYz9T7OYKKi4b0Z5X500UM8y?=
 =?us-ascii?Q?q9FWgZ8Dj8En8ajO8uEW6/mFvfQ6Z6gjkF6J9Kzj5C4fCjriTeK6Zi4+zpyv?=
 =?us-ascii?Q?hCpNWNALBSesRqTFbNgsOBftP6WpbInIWeGl0/mOxnjlJPu38AITr94PRCiD?=
 =?us-ascii?Q?UK3jcttx0rwrUKE3jkNd6WzkPSNARVsFFkMp4eEWiX+fLOCZXb+rmdFJdQ/Q?=
 =?us-ascii?Q?hdVy0ROiPNEzv7SWubD1ErEWUeW+g7DHV/huFzv3m9Q1gAL85mezkT+2/Nod?=
 =?us-ascii?Q?YKZOvy7ZqpJzsYcCVrcaLsRb6JdPAxNOjk5tWPN0WQCR3R/7VTp/o+5jACbU?=
 =?us-ascii?Q?oaL83D5ZJpo5/cU67RXGvp70X+eg+Uf+AC9rsdVtol1CSFDV5buVfTsxFKw6?=
 =?us-ascii?Q?Ojxdq/foTh9k3P3k7ZVpwux7Hu0xQh17bg9zgMQg1Ez3HjeyS4CR7MOZCTI1?=
 =?us-ascii?Q?MZ4LLzL/uXHFCznbZH/OVfnFbXfJ7BD/RWe4FRSkJGh/N5noHvbjviCiBs4U?=
 =?us-ascii?Q?MlFWxOtCbI05vACzHbhmL5N5CAGsYc5Lef3uwFAZUjUWV8fRmjd5JPHS7gYU?=
 =?us-ascii?Q?nNNvP+pRs8S/nCgEvANC9OCRrei3d+H8LbBwRgbzYfi/EViWtnVh6ZK4nmym?=
 =?us-ascii?Q?ZVnLA4nc+5xBshk8bp7/V221QTLY8CDDs0z9dXm6+tguae/z7gqnKWsfFFAQ?=
 =?us-ascii?Q?Kb5RqsvhGi4qPprXwHeJ8T0D24OsL9ZbyDqQSpvzViWYcOFM06bqKoUjtLVO?=
 =?us-ascii?Q?onhX7BzDgJC7yfS9bVwwSVqrIuIA17cbPr9Wt56fhR7pydyHJm6qIHDnVkXm?=
 =?us-ascii?Q?aZdmuMoQ8D9QWZC16wSP0ARydYDN+GyItWq3b3l7a9rSzONY1Qjyr5NkIbgu?=
 =?us-ascii?Q?bmJP7v75DoxwBCWLK8RgrFkzpRoe9w++AtlIa93+ps+HZqpko8P5szsRTMGO?=
 =?us-ascii?Q?WxhtgufoTSBIVSgL9h+5pumj3he1nQxntx0D4jDye1cH7S7lN0w/IO/W0QVF?=
 =?us-ascii?Q?103qrtPGkyMrZsQq2TlTPBpL58BARoSwgT3V1Q5h1uudbhXIkrOBiYXaO4E8?=
 =?us-ascii?Q?CDPB7e4+NpGS0DBMyVWeYKf/rTOesLDDaRCoOZLR3H8RSQnRaRNu3QvY8xu+?=
 =?us-ascii?Q?mDrJpZ+7T/kbjdCMzwx1Z7Zpz+/UihnmS+7LAjGDB71TwZyTSDieDhnIFuDD?=
 =?us-ascii?Q?M8EVuxF7oXSTbeBk/gOpzv+X1A/rnmmvhCxmy9AphB26LwvU0LkOZGC58wYp?=
 =?us-ascii?Q?U31GYeySpNKCJAYQy0BoJ2XC8+vWNLGhw8rnSMZ4KZfjZvVThW5KrRxC8nad?=
 =?us-ascii?Q?ijLx9OSfyl/CBjJCl7yXLSY0BfV9DuMfBrcycEUD?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(34020700016)(82310400026)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 14:17:02.5010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05556bbc-4311-4832-8980-08de52ae6c2c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFE7CE61147

Move cqspi_readdata_capture() function earlier in the file. This is
preparatory refactoring for upcoming PHY tuning support for read and
write operations.

No functional changes.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 45 +++++++++++++++----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b1cf182d6566..303064fdfe2c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -450,6 +450,28 @@ static int cqspi_wait_idle(struct cqspi_st *cqspi)
 	}
 }
 
+static void cqspi_readdata_capture(struct cqspi_st *cqspi, const bool bypass,
+				   const unsigned int delay)
+{
+	void __iomem *reg_base = cqspi->iobase;
+	unsigned int reg;
+
+	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
+
+	if (bypass)
+		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+	else
+		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
+
+	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
+		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
+
+	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
+	       << CQSPI_REG_READCAPTURE_DELAY_LSB;
+
+	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
+}
+
 static int cqspi_exec_flash_cmd(struct cqspi_st *cqspi, unsigned int reg)
 {
 	void __iomem *reg_base = cqspi->iobase;
@@ -1267,29 +1289,6 @@ static void cqspi_config_baudrate_div(struct cqspi_st *cqspi)
 	writel(reg, reg_base + CQSPI_REG_CONFIG);
 }
 
-static void cqspi_readdata_capture(struct cqspi_st *cqspi,
-				   const bool bypass,
-				   const unsigned int delay)
-{
-	void __iomem *reg_base = cqspi->iobase;
-	unsigned int reg;
-
-	reg = readl(reg_base + CQSPI_REG_READCAPTURE);
-
-	if (bypass)
-		reg |= BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-	else
-		reg &= ~BIT(CQSPI_REG_READCAPTURE_BYPASS_LSB);
-
-	reg &= ~(CQSPI_REG_READCAPTURE_DELAY_MASK
-		 << CQSPI_REG_READCAPTURE_DELAY_LSB);
-
-	reg |= (delay & CQSPI_REG_READCAPTURE_DELAY_MASK)
-		<< CQSPI_REG_READCAPTURE_DELAY_LSB;
-
-	writel(reg, reg_base + CQSPI_REG_READCAPTURE);
-}
-
 static void cqspi_configure(struct cqspi_flash_pdata *f_pdata,
 			    unsigned long sclk)
 {
-- 
2.34.1


