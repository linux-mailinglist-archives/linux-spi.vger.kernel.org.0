Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4056332A5E8
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446213AbhCBN22 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:28:28 -0500
Received: from mail-db8eur05on2086.outbound.protection.outlook.com ([40.107.20.86]:10720
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1447302AbhCBMwI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Mar 2021 07:52:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6v7lhptSxayTW4VcUjVX1+3utgBUL4BREUUG0vhmOCZxEa723J5rjmuzi5Bbm1Lj5FAcK/Q4ZpjU3maLByeAHhrztk2G0ZDSmUyq5Ke9VhhJQU9lIJbxu6RIYr6xpcvQIUFAAlId2oEAYZG6MWXfJ5SDcwsnqhp9H7PMwXoi7VVohNyNcmzdye2yP+KLSkpc6iF9+9mmfSNQlxgpDfmzwwMANFJTEBYUgSnYih50+mqY0xydkq4poEi29w5fsCwbCih1jArxoVI+BMg4SEtxFV4hGKMvV/7rEZjjVRM+Nnw0z6dBolo4hbKLGbvNGqW1SxneAqufq+u6ttn6B5bfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRB9EXUXg5EWxzD1MqX8kjLtwfQYExy61tUl+QohOoQ=;
 b=g3TE9jdcNWPhntMXa8jz45lIJw0XCeqpMknCwDWfeFa+gpK+fmBmnhVlD4WAj1fbJpHhy0BJ/t090S6Wr1E9EEXmzx/s9NkrUfxWXlX8wapbc7/bz+DqG1Ks3PxbGkkLrVCq/nALvyqPQeHkHib7cuWeEpKqwSIgQnfsMUAiS8eEqVDWnDBfw2C8nroynZd+bxa6Yux00P3nwi7W87zrhmR7+ibSGFIvai6zizyWspuSObX4EdgFgUqRUKje/9eVFwVfLk9cbJVFVNf3dKCtDHlxis1Sz7seHqhDy4HgCSyQSbwbhYiybd8O1PPdGJxLx+Bvl1lw0jBl3Pv6XgCZmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRB9EXUXg5EWxzD1MqX8kjLtwfQYExy61tUl+QohOoQ=;
 b=TPQPpDv94j80I02ha1Q8TJUqzJ7VRmsLTs9CxFN5E+nUXNdNc2M0WBqO8Bcw7hHCdLku2ONNEBXFe484zhRypu4sQNRLWdAdiEsJjx/5HKtJgdWUgb2sRWm9apywlHn22wyRViyY5YDURgQyAEaPEUEenna/YOqud9dmBqCyHIU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 12:50:17 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 12:50:17 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 4/4] spi: spi-nxp-fspi: Implement errata workaround for LS1028A
Date:   Tue,  2 Mar 2021 18:19:36 +0530
Message-Id: <20210302124936.1972546-5-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
References: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 12:50:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4581b26-c25f-4ffc-b141-08d8dd79bb31
X-MS-TrafficTypeDiagnostic: DB8PR04MB7180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB718099EB5380A2CC8773A1C7E0999@DB8PR04MB7180.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9P0hbuCJI3X419QnPDg8mRlkOrSTEfuyrDBXaxYLrFeJ9WYLmCkKdKtytoKmWOJsHyv7NtYHmDY7y5LaHVbSqskthqPfQlBmiaC1Fe3i7ZFLCj4VAjFk+hxkcHs5DedlGs32DiI1kbIh7Y++BLmTCEQYCFpglzL/SSbSYcyuFE59YKaznrBlp4pjfP1GqbtAzrsDs3FmgqhGdj/3D776qHReTBpIS9uwcyx/T17CfIYdAXbnOIIEStl7VV0hursHiWcI+LlBkcgTikhwCmmRG/p9Bgo8pYyIJxJ5d6QlXPHN+PfdqFf0aqUZaYSjw45lgrS6M3tTpG1jIZUPosLwuA5L3GPILwl8GS9XEYztW88Wwm0uLVa9MHmBTeYvSdURlJvq3deKA0+j9Ruj8IkBz4L/FbtQIvT0RmiNLpwH2MMCEeH5GT7XOXHYk7Y96Glo2pOQHtnY1QL1Pm6A86eUNjKdckmN8J+wlR7gcGMojFNi2ziXzQqyJV8Jp7ivgUXXxyPnJmm4ufyWXPZDfjl00hRbPWP9DJrMEn8tc9s4lQS4cgXXQeI3hJIzFySHehWm0+wrjvZSM2VctyjaILE7A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39850400004)(136003)(52116002)(7696005)(8676002)(8936002)(26005)(54906003)(66946007)(66476007)(316002)(66556008)(83380400001)(186003)(16526019)(478600001)(6486002)(5660300002)(4326008)(6666004)(1006002)(44832011)(55236004)(2906002)(86362001)(1076003)(2616005)(956004)(36756003)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YE/n2MLfHrxp3qx0CHj6QtN0hprp8nD39tcjOQoO0ti1ccEf3IXdeuP7GLA+?=
 =?us-ascii?Q?k9PQildr5TlsEE0zXWMva6+s0fA3yvfjQ82fFpVO/fQwaqUIIG2IuYdOvqgz?=
 =?us-ascii?Q?uwEwDTpPEZfU64RdnC6G+9IA2RK1GZNo6PBuYwlDTbZyGieYfFXKG9U4I0No?=
 =?us-ascii?Q?rKN1TNJQMnERgS45msofThZg/JtiFrqbLsDKg2bm7607Vi8PDUt48fv31tky?=
 =?us-ascii?Q?GRhGqv1xGkvDPRIEcsBTVDtmpKv6NOsMzn5p1HaAHLMn6GYrnd+E7Q3YL/9m?=
 =?us-ascii?Q?2vjnJLdrQgdY5nOv9nF1rFEhz8D7k76XdhOE6GdKbqSfW+jRbzvqHac0vGuS?=
 =?us-ascii?Q?6/yC3m9r8mcEVIYCQpK1iTwF315VLVJWcVZcCDzd6jtGEY0/ctkU3hOA38S+?=
 =?us-ascii?Q?X1sLCvd8SoHSsdnyCHQZyItzvipv+g5vd0a0HHQZfaxpOKR/5omyJa1hK3qq?=
 =?us-ascii?Q?gHACAr62mmikTYG9TOnIR5PE5F+w/q7g135g6R75ina/uRGw5jhrsaBIow6W?=
 =?us-ascii?Q?AK+r/hLFfIqyccuUDXKCPgHrz46cmWIGCTo52d8FRzc6r4MQmshipnpF5m1G?=
 =?us-ascii?Q?T/KqCX6JWoky1L5lIynf3Pi7a5sqTySiQ+Hpo4JLQ2ElYH7IdR+fCUym2XOo?=
 =?us-ascii?Q?f9Iw3pDvY2xMN06uR7fh3pyoeO3a8q89TGeiZY2jvwzZ5YrgEl4DPvXCbPBQ?=
 =?us-ascii?Q?8FbQVxUYq81ydkt93CnE05vaSV3BRrfJuXu1i9pMCaxlc9YqhGs5Pm9lSqee?=
 =?us-ascii?Q?pMd5xFE+2O75D3WdAYaa9uyJ1hEkPSq6SkTCdCk01B/wmN1Z4uI8Kauex2Kh?=
 =?us-ascii?Q?pYF7CG1slwXQWWwjLWgD4zl9WqnQjppbxBauhRallJwtaH4MFwBbMYmqtZxS?=
 =?us-ascii?Q?8DPkDgPZN9P5uQn8sGZWKX6k7BZo+Fh4tCt3l4QzXozT3IFe3jYa10/k91G1?=
 =?us-ascii?Q?ZkgqCZu6naaLqjCZ8UbBPpJndhg/lAQBOPiDmStZJ8WUnV4cKoFI9tHpBt1l?=
 =?us-ascii?Q?dp6WBB0ggUVyl5If5mF6uFUlNJLOfrx440lygp1Km9NVm84SalmzF4LAvsfv?=
 =?us-ascii?Q?McBzV2e/fxMaGyV8Uh2uamNQUTVWZ1+8ZmOi+CcCx+VD0Mi8Kf4rzXmjMDAW?=
 =?us-ascii?Q?S8oW358WEs1a7NMyjuJgK7Q/ZoAHiFXx2IMKgkUXhuxuN5eOqbYU6t0c+VkZ?=
 =?us-ascii?Q?x6VP3VLHPE8KMvpkMLwvswIhV4EpXFhNyp2g7nsT1zF75N1zCphH6j/r5cMj?=
 =?us-ascii?Q?0h6Z5xoAJ7cJ0mHnjwfRGMBRtBO0t1Zria2iVVxDRkiYYubwdAdUoR1nl4HH?=
 =?us-ascii?Q?FZfxUuwEuZCQMumSO2XnOx/J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4581b26-c25f-4ffc-b141-08d8dd79bb31
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 12:50:17.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/0WfzhTMY985QDpzNqEgjGBv97zxCknLgUOja3GA79Y+CYsO2yjjDLOYos4h6qf2j4i0SZrXiqePVUPKbgUig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Errata ERR050568 description says that "Flash access by FlexSPI AHB
command may not work with platform frequency equal to 300 MHz" on
LS1028A.

By default, smaller length reads(equal to RX FIFO size) are done by IP
bus and larger length reads using AHB bus. For adding errata workaround,
use IP bus to read entire flash contents and disable AHB path when
platform frequency is 300Mhz.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
v2: No update

 drivers/spi/spi-nxp-fspi.c | 79 +++++++++++++++++++++++++++++++++++---
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 80a9278d91ed..ed1e888c7ece 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -49,8 +49,11 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
+#include <linux/regmap.h>
 #include <linux/sizes.h>
+#include <linux/sys_soc.h>
 
+#include <linux/mfd/syscon.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
@@ -311,6 +314,8 @@
 #define NXP_FSPI_MAX_CHIPSELECT		4
 #define NXP_FSPI_MIN_IOMAP	SZ_4M
 
+#define DCFG_RCWSR1		0x100
+
 /* Access flash memory using IP bus only */
 #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
 
@@ -322,7 +327,7 @@ struct nxp_fspi_devtype_data {
 	bool little_endian;
 };
 
-static const struct nxp_fspi_devtype_data lx2160a_data = {
+static struct nxp_fspi_devtype_data lx2160a_data = {
 	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
@@ -330,7 +335,7 @@ static const struct nxp_fspi_devtype_data lx2160a_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
-static const struct nxp_fspi_devtype_data imx8mm_data = {
+static struct nxp_fspi_devtype_data imx8mm_data = {
 	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
@@ -338,7 +343,7 @@ static const struct nxp_fspi_devtype_data imx8mm_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
-static const struct nxp_fspi_devtype_data imx8qxp_data = {
+static struct nxp_fspi_devtype_data imx8qxp_data = {
 	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
@@ -346,7 +351,7 @@ static const struct nxp_fspi_devtype_data imx8qxp_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
-static const struct nxp_fspi_devtype_data imx8dxl_data = {
+static struct nxp_fspi_devtype_data imx8dxl_data = {
 	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
@@ -364,7 +369,7 @@ struct nxp_fspi {
 	struct clk *clk, *clk_en;
 	struct device *dev;
 	struct completion c;
-	const struct nxp_fspi_devtype_data *devtype_data;
+	struct nxp_fspi_devtype_data *devtype_data;
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
@@ -915,6 +920,59 @@ static int nxp_fspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 	return 0;
 }
 
+static void erratum_err050568(struct nxp_fspi *f)
+{
+	const struct soc_device_attribute ls1028a_soc_attr[] = {
+		{ .family = "QorIQ LS1028A" },
+		{ /* sentinel */ }
+	};
+	struct device_node *np;
+	struct regmap *map;
+	u32 val = 0, sysclk = 0;
+	int ret;
+
+	/* Check for LS1028A family */
+	if (!soc_device_match(ls1028a_soc_attr)) {
+		dev_dbg(f->dev, "Errata applicable only for LS1028A\n");
+		return;
+	}
+
+	/* Compute system clock frequency multiplier ratio */
+	map = syscon_regmap_lookup_by_compatible("fsl,ls1028a-dcfg");
+	if (IS_ERR(map)) {
+		dev_err(f->dev, "No syscon regmap\n");
+		goto err;
+	}
+
+	ret = regmap_read(map, DCFG_RCWSR1, &val);
+	if (ret < 0)
+		goto err;
+
+	/* Strap bits 6:2 define SYS_PLL_RAT i.e frequency multiplier ratio */
+	val = (val >> 2) & 0x1F;
+	WARN(val == 0, "Strapping is zero: Cannot determine ratio");
+
+	/* Compute system clock frequency */
+	np = of_find_node_by_name(NULL, "clock-sysclk");
+	if (!np)
+		goto err;
+
+	if (of_property_read_u32(np, "clock-frequency", &sysclk))
+		goto err;
+
+	sysclk = (sysclk * val) / 1000000; /* Convert sysclk to Mhz */
+	dev_dbg(f->dev, "val: 0x%08x, sysclk: %dMhz\n", val, sysclk);
+
+	/* Use IP bus only if PLL is 300MHz */
+	if (sysclk == 300)
+		f->devtype_data->quirks |= FSPI_QUIRK_USE_IP_ONLY;
+
+	return;
+
+err:
+	dev_err(f->dev, "Errata cannot be executed. Read via IP bus may not work\n");
+}
+
 static int nxp_fspi_default_setup(struct nxp_fspi *f)
 {
 	void __iomem *base = f->iobase;
@@ -933,6 +991,15 @@ static int nxp_fspi_default_setup(struct nxp_fspi *f)
 	if (ret)
 		return ret;
 
+	/*
+	 * ERR050568: Flash access by FlexSPI AHB command may not work with
+	 * platform frequency equal to 300 MHz on LS1028A.
+	 * LS1028A reuses LX2160A compatible entry. Make errata applicable for
+	 * Layerscape LS1028A platform.
+	 */
+	if (of_device_is_compatible(f->dev->of_node, "nxp,lx2160a-fspi"))
+		erratum_err050568(f);
+
 	/* Reset the module */
 	/* w1c register, wait unit clear */
 	ret = fspi_readl_poll_tout(f, f->iobase + FSPI_MCR0,
@@ -1036,7 +1103,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	f = spi_controller_get_devdata(ctlr);
 	f->dev = dev;
-	f->devtype_data = device_get_match_data(dev);
+	f->devtype_data = (struct nxp_fspi_devtype_data *)device_get_match_data(dev);
 	if (!f->devtype_data) {
 		ret = -ENODEV;
 		goto err_put_ctrl;
-- 
2.25.1

