Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C118336C133
	for <lists+linux-spi@lfdr.de>; Tue, 27 Apr 2021 10:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhD0IwI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Apr 2021 04:52:08 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:53860
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229487AbhD0IwH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Apr 2021 04:52:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIe32HcKNKs0VMqsuYUJ9amWos5rQ8WkWdmJdf2OiqJzSgrcN/xHGHSo/LH3cJ+ILbpbuT9pqrr5NTgUrkGH9Lc+1uQi9PpYVYPznOWNAsPuwPJ5cVk50SzkIPz1nwWuQEQstYAE0a+ou2hx+kf5tMNtei9r/+0+ceLXWgTWG8WSIAjdLeJt3lcWf/Hh9I5P8xX6I2yXQb0T5r4/tPIKiLZh9vk6MD7Ut/TnE9VpZd0ZU5pexLbwlJ+WCVf5PgH0B3X0l2UHd1g4dgICG76RdjU2RrTHCSx6oQflajj5dT3PimBt6GyBapHuraq4S5ImOx1W7raGVyJ6p9lU0HOsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbf87D7zu5HLIj2mVAx+mNkpZgK977JmClXpPclMlKw=;
 b=ln+PLfYSuFYvpnxViuAjW8iN9+WYIkBwoTdyGpmFOxpevsldBr/BBzF2zQDpRwRlBJ2ZS7RXyWDRrhXGtz2M3xz7x9hWTUOEXEALK/J3Z1ty/XPkokT8gnp6EgEVX8K8olw34SDHyhlMhPKFbsxNBbFZ9sLwfAy48CjgPhymO6FxLgXuKsM86p5180UPjusZUzs0cRGmuD0qkVsjkEcehELh4crg61Ftp21CPcdNunQtkMZRT54J0IQgfOAroJhS0q+Ftl1UDEEQFCSotkHYHWC1HHIt7C6bfosgmZIwjTsNXQS/XaNjlCrXMQDIPxebcVr3JXXK2sL1Peuut/cYpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbf87D7zu5HLIj2mVAx+mNkpZgK977JmClXpPclMlKw=;
 b=jBSc9xUJ4/opIYDkcIyPI9fZLdC41cPBu+hjdDOfXJmPw0khg2SzIYAMmv4a2Q/5Mwm03lrDO4fUVfO69Bmm7vGM9Ihw6ECyy4vyEzV9U0UWBY/wbkzRRktCBNaC6karVqa+L3xaCumuyEg1/ccUmjwd9DV2fIB2+tkT6515SCE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB6277.eurprd04.prod.outlook.com (2603:10a6:20b:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 08:51:22 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::e9eb:9619:1265:de3a]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::e9eb:9619:1265:de3a%5]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 08:51:22 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: remove CLK calculation and divider in slave mode
Date:   Tue, 27 Apr 2021 16:52:11 +0800
Message-Id: <20210427085211.299756-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: HK2PR0401CA0014.apcprd04.prod.outlook.com
 (2603:1096:202:2::24) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by HK2PR0401CA0014.apcprd04.prod.outlook.com (2603:1096:202:2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Tue, 27 Apr 2021 08:51:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2eab1eb-cf14-43f0-5c96-08d90959a1d8
X-MS-TrafficTypeDiagnostic: AM6PR04MB6277:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6277B6BFB038CB9C48DF23FCF3419@AM6PR04MB6277.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hyn2/sX9C5cNqS25YyC+Pa0ekSniwxxQRWh4pWgFeLKL34ZGsuDJMNHrAil3CQGCY/D++oeLPtjHEdyALEUbYLM5uZij28toCStFQijk7/rujk9lev2qxXsXAxnwKyS7+lbuVlsDiZDwu6Skp8k5gmbM4/qCoFFL0KCrwCdXR+c9T4wFO1CiYF+toBYtKj8NzIemNAE1iG3/Yg/EIUs1FnCutOH8JCrTp82rR8GKGlM2MHFG+7EDB0FSMOm/dq0WVorZGusHiadqRM3IoMHK6kQ1IpbXnEkuOzuQvQVj42QdUYtFbPP15g0wNLSca2KFYqWMPDs2pEuxkvJvHZ3+04wmMkgRu4/WK3348n+QmgC/biclvmUAiciCuKSFA08vtQYdphTtInrnWKNFtP4oZNN/7oB4ll9PLyaXf6jwylaL4ExUK1NsdG0XS2XBhpo8tfVxbiBcTjlKRNyhpxYGos19DUFga2SDe997XdeAKd7FOs+2KeQWLLpiRdTYOz+cQLRRkFqXKmLSHBvjseMyPfaWJW9bHMGWsrDr95sMTGxWa/ifVRQvpWL0XhAQQbae2zdp4y5FvuuMno5V5IIqNLegRDM6zL1doU2rWFZFf5ioxxFM1yey9LzMRoWZ2fkWg4zXR6dgu8FmfdeeCZON12+TpZWWmP22hj+VtU0xoDjGBa13zCXX3wPJrcCvMwVf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(38350700002)(36756003)(52116002)(83380400001)(26005)(5660300002)(498600001)(66476007)(6486002)(956004)(2616005)(1076003)(4326008)(86362001)(6916009)(66946007)(6506007)(8676002)(8936002)(6666004)(16526019)(186003)(6512007)(38100700002)(2906002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qJeVJngsQA9/qFoOOPx96+vxXGgETJ2+rldFs+fBJFjXhR8XNTvHRR+ir07A?=
 =?us-ascii?Q?DhRjS2tg0k+nFhTVPmGZ01MoRKsYko+dDJFv8epWDBZ0cPJJdtDahDT4Cd63?=
 =?us-ascii?Q?geEFU6N+E3RTdTg935woAAR5lR7hefSTG6lJVSg9ETKozEUahvQm4sTdxa50?=
 =?us-ascii?Q?pX+41oIDo3UA3czmuXRYf4O5eVsn6U/GF9pfyglozeoiuYZ+JZxGPEiamdY8?=
 =?us-ascii?Q?amKMPGFlyz+3EwWctpSL3WvVEBk60I93E8Pd+mZvAG/YjlSR0HPBVMMWJznE?=
 =?us-ascii?Q?hFa6HWRB3CthqJ9575geGXnZ1ANC6V77oWswtexkzZ/bNXVUFzBIyMDeRAwo?=
 =?us-ascii?Q?dyRY6uH48VIgqIu+UQjYJdEQad98MVW88OUA69qmclpfO5PQvO+VOhfqMi+b?=
 =?us-ascii?Q?8O2RCe5aG+yFLcsjsz+Qx9RCUwV8Ddt0WmklALU6/jeBAPNP+sIxz/mjTMBY?=
 =?us-ascii?Q?RrTqskaTNnCcS/L6fqmpwRaRo1QK4lGjlulSEXFdMffk8Z0fYQUMDEhTFrbn?=
 =?us-ascii?Q?S22/OYo/R6dNSogPtkINqhFY1KRswDaPkmgSRiNZyD8gRMWMwTJEjUoydbTu?=
 =?us-ascii?Q?qPqUdzrcZQmawq2jo1fnaBMrPHTPtxVgF/LeaI1CRdu4W93mOHQDWtUOAtQg?=
 =?us-ascii?Q?GzCmLVtssG8ph0DNz1NdjIzBu2uuBS7n1DaZekdZel+GMT1qLHl0lamDTwS4?=
 =?us-ascii?Q?j+o2d7HN6/AX6qRVU/iTIWyYdcnX55WdameAmZc5FksUkqy+O2p0SU49PxYt?=
 =?us-ascii?Q?x8JV4DWDrPjLfZX0Hr42w6ZR6Bl/JYrDCLYCOWJ3mYo+griRHaUv5adZ+uwL?=
 =?us-ascii?Q?G7Wbk6tGD3zluzlJhg0X1Qe4lmaBjHAauZxzHTKgVhQMPisRziYFJs4okkgI?=
 =?us-ascii?Q?OiCM0ldJRxnftOJcjCbtqkYyNco480i6PKXxX41582ZlOLXhZ/7eroIuNBX0?=
 =?us-ascii?Q?QlmLWvbfeg/Bg8LtevJ/5yHbA9d/dEvMETj24stTEKxcp6J7GvqYNbHQW4u9?=
 =?us-ascii?Q?Dnh2NYauRc/NHTxJeeoEbNWibHKejXusa71ns1E8g/d02G1bqmHE5Tv+fuDU?=
 =?us-ascii?Q?q0lH7hQHTY4FJua+4SKN5p9D2TsnMAHj8FEyWcuVmIm8BPZY868HV2WLPBxz?=
 =?us-ascii?Q?7S/b9/UOs4RBSHwPN8iCyJtvBXMqPmAEE1L+rJVc09LOyRHp7os0jcqg2frN?=
 =?us-ascii?Q?TibdrekEdgsdmL8b8C8ZwcfmeexcQ/IsARxZdOLJTH+9Si6/oQ/5g5nnpHJZ?=
 =?us-ascii?Q?Fqyf84ZtWyvAEJXhxO1tkkoyQeIQL48LR+3qykLUt1/Rz5LkefYRRkBBJKDs?=
 =?us-ascii?Q?EPNqWmjIACRA34UeRs3log1o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2eab1eb-cf14-43f0-5c96-08d90959a1d8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 08:51:22.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e57M5m+a7rw4qIVEeh752oJjY+o2dbgi8DfAaib94Fnbe3PrYp1WNpGofUqv2JmYgclrux+H9PHYpsZUE2Ta3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6277
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In the slave mode, the clock signal is controlled by the master.
The slave does not need to calculate and configure the clock
frequency division. The slave can directly use the root clock
to sample the SCL signal.
Therefore, remove the calculation and frequency division
function of the clock in the slave mode.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Please remove the patch(4df2f5e1372e spi: imx: add a check for speed_hz before
calculating the clock) first and then apply this patch.
Sorry about this. Thank you!
---
 drivers/spi/spi-imx.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 24ba7ab1b05d..68cdd87404f6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -33,6 +33,7 @@ module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Enable usage of DMA when available (default)");
 
 #define MXC_RPM_TIMEOUT		2000 /* 2000ms */
+#define MXC_DEFAULT_SPEED	500000 /* 500KHz */
 
 #define MXC_CSPIRXDATA		0x00
 #define MXC_CSPITXDATA		0x04
@@ -599,8 +600,10 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	/* set clock speed */
 	ctrl &= ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
 		  0xf << MX51_ECSPI_CTRL_PREDIV_OFFSET);
-	ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
-	spi_imx->spi_bus_clk = clk;
+	if (!spi_imx->slave_mode) {
+		ctrl |= mx51_ecspi_clkdiv(spi_imx, t->speed_hz, &clk);
+		spi_imx->spi_bus_clk = clk;
+	}
 
 	if (spi_imx->usedma)
 		ctrl |= MX51_ECSPI_CTRL_SMC;
@@ -717,9 +720,11 @@ static int mx31_prepare_transfer(struct spi_imx_data *spi_imx,
 	unsigned int reg = MX31_CSPICTRL_ENABLE | MX31_CSPICTRL_MASTER;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, t->speed_hz, &clk) <<
-		MX31_CSPICTRL_DR_SHIFT;
-	spi_imx->spi_bus_clk = clk;
+	if (!spi_imx->slave_mode) {
+		reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, t->speed_hz, &clk) <<
+			MX31_CSPICTRL_DR_SHIFT;
+		spi_imx->spi_bus_clk = clk;
+	}
 
 	if (is_imx35_cspi(spi_imx)) {
 		reg |= (spi_imx->bits_per_word - 1) << MX35_CSPICTRL_BL_SHIFT;
@@ -823,9 +828,11 @@ static int mx21_prepare_transfer(struct spi_imx_data *spi_imx,
 	unsigned int max = is_imx27_cspi(spi_imx) ? 16 : 18;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, t->speed_hz, max, &clk)
-		<< MX21_CSPICTRL_DR_SHIFT;
-	spi_imx->spi_bus_clk = clk;
+	if (!spi_imx->slave_mode) {
+		reg |= spi_imx_clkdiv_1(spi_imx->spi_clk, t->speed_hz, max, &clk)
+			<< MX21_CSPICTRL_DR_SHIFT;
+		spi_imx->spi_bus_clk = clk;
+	}
 
 	reg |= spi_imx->bits_per_word - 1;
 
@@ -898,9 +905,11 @@ static int mx1_prepare_transfer(struct spi_imx_data *spi_imx,
 	unsigned int reg = MX1_CSPICTRL_ENABLE | MX1_CSPICTRL_MASTER;
 	unsigned int clk;
 
-	reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, t->speed_hz, &clk) <<
-		MX1_CSPICTRL_DR_SHIFT;
-	spi_imx->spi_bus_clk = clk;
+	if (!spi_imx->slave_mode) {
+		reg |= spi_imx_clkdiv_2(spi_imx->spi_clk, t->speed_hz, &clk) <<
+			MX1_CSPICTRL_DR_SHIFT;
+		spi_imx->spi_bus_clk = clk;
+	}
 
 	reg |= spi_imx->bits_per_word - 1;
 
@@ -1485,8 +1494,6 @@ static int spi_imx_transfer(struct spi_device *spi,
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
 
-	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
-
 	/* flush rxfifo before transfer */
 	while (spi_imx->devtype_data->rx_available(spi_imx))
 		readl(spi_imx->base + MXC_CSPIRXDATA);
@@ -1494,6 +1501,8 @@ static int spi_imx_transfer(struct spi_device *spi,
 	if (spi_imx->slave_mode)
 		return spi_imx_pio_transfer_slave(spi, transfer);
 
+	transfer->effective_speed_hz = spi_imx->spi_bus_clk;
+
 	if (spi_imx->usedma)
 		return spi_imx_dma_transfer(spi_imx, transfer);
 
@@ -1593,6 +1602,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master = master;
 	spi_imx->dev = &pdev->dev;
 	spi_imx->slave_mode = slave_mode;
+	spi_imx->spi_bus_clk = MXC_DEFAULT_SPEED;
 
 	spi_imx->devtype_data = devtype_data;
 
-- 
2.25.1

