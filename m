Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFFB327C55
	for <lists+linux-spi@lfdr.de>; Mon,  1 Mar 2021 11:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbhCAKfn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Mar 2021 05:35:43 -0500
Received: from mail-db8eur05on2058.outbound.protection.outlook.com ([40.107.20.58]:30065
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234529AbhCAKer (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 1 Mar 2021 05:34:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5JUjav6wHy1WXxBIp4LBBhLN2UBa8QwgMkGUbd8/xBtv1pAGtJ4oSHZHasfTJp2gzk33fZoYflaxaBmXI7up6ySP3c9vt3PoZesUFtiWgnLAM4yurqh8cqjIYpBj+45U6URro/3ct4fxdLzPZ7r6Zb58NtRu6mvMixMFdPyoYVABN7nCDwF2se5IcdyO1c9pHNETcBZwk3zCQKdupW4zwl/DvSkhXL7W66aNZX+Thvu4pY+gpR1vIeCk7xqp7ce844Co91GaYM6Ta0mtBr7MXXJPRm8NAVQIk95kD30UA0YtGfcBp+MPd0IhD8Xev/iVeg5dI/mpqgnm/jx483ZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+nFiHfFsRaPkGmsIh+NQxftSzcBvei4591GfU8ZTPQ=;
 b=F7MaveRBzUOEXR4mNLHYXZHnWXmU+4VnwewWkm1hkl71+Wc0KhEBFwZo6JKm6ojbDZyH9xYszDjML8XyP38941/56nZxitqoaXocwhAPiKYTyUhWlzGXxhs+tK3muhit3HGsSWQLftm1NzkyFuLXjw5WKzNFh0dXpry0KvjE0FTDhW6hf1uz1hK/R2tSaUQP4KrerPJsQOaBdkqliwvhKiix5elPtA746kt6jeC5Ijsr1Z6epe/5NsYK/rlgvJmegdBOfzU1ZBe9r3BOBQXNKyVA14D0rDHPTQTJzsBn2ifaB2b3PAtTKtIX3EBa+PhGaOS7EUB6MxVCHPnO0HLU6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t+nFiHfFsRaPkGmsIh+NQxftSzcBvei4591GfU8ZTPQ=;
 b=iioPvQuqh/6e+dr7cHGjrVxXFgwsi9aGIJs2vKNKDJude6Vg1evA0wrffyj+X3AtNDB7f6EjIu5x16ML+O4b046OoVJ8a03aOz2KVPXxhveNlDuN5cOA/QRzh54/AxjyI3sRFrcSY5j37tPXwClyBnFMLw059JMN6FBUjnWNbKc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB7PR04MB4236.eurprd04.prod.outlook.com (2603:10a6:5:27::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Mon, 1 Mar
 2021 10:32:59 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 10:32:59 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 3/3] spi: spi-nxp-fspi: Implement errata workaround for LS1028A
Date:   Mon,  1 Mar 2021 16:02:30 +0530
Message-Id: <20210301103230.1816168-4-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
References: <20210301103230.1816168-1-kuldeep.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 10:32:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dad9ab8a-f4c3-41bb-ca8c-08d8dc9d6274
X-MS-TrafficTypeDiagnostic: DB7PR04MB4236:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB42368596BA73B22D064725D9E09A9@DB7PR04MB4236.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SnOzIUOKT8KS9oCQmR8TMcjucD1bQK8PqOjV8G13PSRJ+JgIMDCwuPcDXSwgYbmaBjaT6N3z/X92HrFb1MSCKgoeEIqO9sPTd6UEQViStFO9Ax2cuEx7DFeNLg36CBKHN1f3xo20A+wD3v3oveMjWia0T7HVMUznDYVchCRSgrrUhPBPERmYhOyJC31p52j5D8eJa6HQEr3iCnQnwDSrKyFsCzeyYTbAOSBzMlyDVg8tKh4UHhZSixCPpXs84sF/3bXZNMubMvV7NCU8mi3TFH8Mo5/QzsUUz/1D+QiVbQ+g/iu019h5t89VnD1MRjDaIsMQxPrxT/UxQ0d4zi3HIRRxQT8eUEx0a+LwauU8I86xTIXuPxkWNyOgB0ToEh3Prd33zRg2RsIaJBgdjzgOTj8FHPtKU8NfmFo/mrM1u3e2AsytWKodYfXKFJYQDnYYU24ii21RmmGGhEIVIYzzlHOLSd49GxXv7jtsnkx8C8hckPIX38pXeZrJiERAUA7GrbBURpk/Mrq7kPwGJrJE7bcrKTS1ps5XvxSwgqyqRGY2y2niteDvTlrFD9tDLsHqLKI6MJcTNk0dgBZeX7bL0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(86362001)(1006002)(5660300002)(7696005)(52116002)(6666004)(66556008)(66476007)(66946007)(54906003)(316002)(478600001)(16526019)(1076003)(55236004)(36756003)(186003)(4326008)(26005)(956004)(2906002)(44832011)(8676002)(6486002)(8936002)(2616005)(83380400001)(110426009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ns3BVE/HaIMQXXRZnSfXh0+KiJOyFkRmelu9QepZNF4T1wMtD1HOsRwDPnVa?=
 =?us-ascii?Q?PgIsutXxO7dcaOks47EJG2rnI/lQEDHOEcPe7D9SDPIkpOOtMjiarKCPvNcH?=
 =?us-ascii?Q?8SeFwkY2SH62ojZQDQxe8PZTDI4IKzTr128eaWxy7FK2TVeecQq5VLfPuTN6?=
 =?us-ascii?Q?JL4UHydHL5ymBACUdzei/p0tdGGtQm5e5junE7jcw7UqbGIF0p62MejwNTjb?=
 =?us-ascii?Q?kvd+82oe3K/RzwrVpddieqh3HjMXBXp6FKeb58J907L2QP+TEYta6ImTVuPq?=
 =?us-ascii?Q?hW+pzWsEcxPiIKaStrJKscD/i8oq7zPJfLpkJydcYMbzTefLKXKgSt+P68kk?=
 =?us-ascii?Q?4YNS267Zt94eEO5Il2YfYzNumRP7g4RKuUkkhorbbCRad675FFU9wm/wwYba?=
 =?us-ascii?Q?/nX4QqwtKKuRCyYeSRPcWBFEuKeZhKEa8W+t8X8sPdrSOnFquJujJpFazxaX?=
 =?us-ascii?Q?dcKp540jRSI7RLqV23DbFCU6NVZRRn7f8uesmxJvbNp9OPVBU8i2cbf3Q0uU?=
 =?us-ascii?Q?pjARc807QgXgqr8ufR/0sezuOGTMwTHjbCji3GfpsmAFMrpLfbbJtDxwkQJe?=
 =?us-ascii?Q?tKlJk4x7nxx89IyQ33G5Ime6J1698YSDZqHfkjzCHE5SCvCjsb7pYYSHwODj?=
 =?us-ascii?Q?9r+3T9E1Cr8pVCF0Bn9LK9gmNU3w8geOcRgiF70oqriFq5/EaGQKZ6mmtxLh?=
 =?us-ascii?Q?L+KFa/vmmxAdTIYJ+0GB9OCHYafbpgavry/APX3o+wIfbij06ppG2++8zPGN?=
 =?us-ascii?Q?p5HyeoSAisKDK2txZBxaqT40mPHmMPMTfFImO2FAQ5GNFKv0C7O3KOlVqaYa?=
 =?us-ascii?Q?v360IlHAdrzrCHBfej7QrRRLmWZMgEmDpoWzAiDTQ85hCXO8RPRqNfLVv3lt?=
 =?us-ascii?Q?QnV46+oUPZv44rmEJ4EA7mjPBkasqGk4kGC49Nlkq4f6lKXBVepUtNnLfJJX?=
 =?us-ascii?Q?fG3F3yxkTvNm/oxy1oTYVWYsr10hZ7A2WWxCRzc+6uLnmjwYEW0u3r1IklfU?=
 =?us-ascii?Q?aOOO1++D5CaYRJkvpdX+4ADZ8cisGjmTP93K+BDm1RgcpvV8AURSoersTJfi?=
 =?us-ascii?Q?a9xmuYhzZSstzSHIjyP9SskzIf5+TOp0KMzS2GEafIpkmKh7AL1h0o+fgJcA?=
 =?us-ascii?Q?8XaMEwWun85XspLOZS86pZcjid6HCrwSA3ekAwR0Acy0UD3AHZrKEMROaLWX?=
 =?us-ascii?Q?qNR6gT514y56Nt945SJXhVbE99W0LBfyr5FcE1l0YEA2S1jR84mhJqnNR3t3?=
 =?us-ascii?Q?XrO+kix30/9FpXjc5l7uPQks2IqOs5GZdaMjUc50/d68/S8OKCca8JLkmNjI?=
 =?us-ascii?Q?m0mJarESmBPlZHZU0SDh7PrO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad9ab8a-f4c3-41bb-ca8c-08d8dc9d6274
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 10:32:59.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E42hychlzlUKNJObIc8SeosfCQrxEyI0wvtBbuVhTexza8yoS2tEDL37PwqKtCRNY60JB/QMV4LJ0ClwTYPg8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4236
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

