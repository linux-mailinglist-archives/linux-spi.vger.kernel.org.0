Return-Path: <linux-spi+bounces-8659-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15EBADF08A
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50DCB3B7E83
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4BA2F19A8;
	Wed, 18 Jun 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lnnp4f96"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011037.outbound.protection.outlook.com [52.103.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BEC2F199A;
	Wed, 18 Jun 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258498; cv=fail; b=kz1D7Qm8Y0wXzcHnPkHNInSadehTOzZBF0bOcfL7gDeqtDXvQPekJeVel1s1tBaZljq9wGe42b2XyzXVdWFg1EIFM3y4GxjySExxhsiG8+ptGDdSmZ2fZsWtxxmns/ur1sBeagrA+X2vcvj13m4zFfYRDz1am4Mmj+A/l9ogKEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258498; c=relaxed/simple;
	bh=DwD7wEqWK+IK1EKkpu1uT/OUt3toPPDRljIyhl6O7Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sS8Q3hQH6oPkRgvWbVYROt9TZNRPFfF+eKAHHwW5irDe+enVg9SIYP4P0uniCPMGg/hTy410qTstESTu7FC7ZnhSP48Tcn1s89nTCoK7qDCvgE/prPEts5N4vKDTS6VuddGFGvXSXePYmIH1PBHJX7pjiT6BA1hyHAPW674VV1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lnnp4f96; arc=fail smtp.client-ip=52.103.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKlrMdbRITrFMD0qRxEE5TVkwZOo88lP5jgwF1CsMr5LADb0SgIbY0DRDKJGunIgHBKNtsn9AYCQG7l0AWLTj6D4RTTF9oc+oObAmuNGDVHvrRzxgkSx4gjaOG2NbEjHnbt0cxhoWhQcr39bnZhG6JWDVMahLAl2w7lbAn4xsdsUuDq6UQdrYFMD5o7TJKGev+EhgNq0DR8Um3XcsAzHtz0ZVaZo/kHFatGHxZzWf8wggfI/mu6MtqOGkrt6CQ26uhGOx6EuFXuR11im6GQefl9WkCsb6l8SWN9EG5EjP0FnFHSi/bMG1GfYEOD5TTyguvnW384YyeNGD1wioWx77A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDUbyxu+FYyGVVLp5OG997qJ5uM03qOJENpsefKGSi8=;
 b=bWMqMipZjlyKqBrkPu3dD/3gof8++mbESECNvvuvs+WuGe/whwQnmIGd44jUvp0i2u05WLXN42AKVGUWSJWlA9nUZYSjkie47hDwbDBDJaO6WTBo/fulVR6EUgw1wqlIcPhTNmKVGQ9zymBmWNLaIpY2thiEoSrmIq7rK8kyGXyCZQS5sUJvgDz+kikPYOtH4n01TtAYG2YsyVrPzb1qiwl5ulQL8D6fmsBsSS8Nsth95ZXIP+21JkpxlSNF9qrEf/z3RMb4qav01f6iTnpXoG9/d/9R3HUjjN+Db8GM/XKLavILtNz3fiEAd38soKUf12DaGgpZZsQzjsm0Tkezwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDUbyxu+FYyGVVLp5OG997qJ5uM03qOJENpsefKGSi8=;
 b=lnnp4f96ptTpdamHe6H+6E88CUMGs63RkHThh/S7aXaPcMBnQ8d6aoOa4KXkZQi2BgzG5JZu4WRBhVyAPdKmhdTFIFUsu/sOIh53BVHFHO4f/kdbW7/4g0tBQ16TI4SwKXiZhWKRGLSexvUE+A8X0/hgVDS5DVZReQiS1Ke2AtHnxOrcq1oQmjU60p1qsw60V7wQwBp7npqXdy6LVctjKwhfgQEz0qRfKyENs3M2OoPjYl5Klx7Ao3JELGQs9sPofkFsXunb1QlFVJAhdnKYhIi1smNLRfiNSp1wiXIvTwxWqsl4Ea9dta3QriAkkwt8iDc1lpWrYI4qnkK75RT22g==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:53 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:53 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 16/16] spi: falcon: mark falcon_sflash_xfer() as static
Date: Wed, 18 Jun 2025 22:53:29 +0800
Message-ID:
 <OSBPR01MB16705BE87E549B6210CD6BCABC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-17-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 962a9db9-f1ca-4146-2d9f-08ddae7814fe
X-MS-Exchange-SLBlob-MailProps:
	quCBMN2EvO/3DulB83avQEM5mXo46VcBd525QhmmLboPealE7d++ie95uj02iMI7DadW/T3Jc/77wgvb1VKh3MWjxfC/pa5d8tJvMPKoDmGBv0gEbEiF00jfELgpph2ZnJ0SMAMIR/vWa/lozQpiB67WJQeK8+j5W7UUuFyhfe5buaEVuoKbg1RXD4PVPOb5xFxc7aB2DWQfsUZkMPIIDVw1BwomK8B8BOzhlgZDeWeaooCHlUlqSLxDU4gqS1FZa2ZqL2aOeuJwTMcS7LCkl6X9lUKeeG5KEoZipiYFppjMhknU9UqSGFki+4Nz4RG1xN4xfVfng13oa+GazzfifGekQiXCOcBQ+hKgYqJjXwswtYRkmT+QgSsdH5oaWHBuQV2p4TqPHUrt9R2w1jBPc4675e909QhRZM3iPuF+7mx/U3kHpSlzo+qvdgre3lD5tDH4jvhWoMLPpkxONkKTgQlNWUEWkNUBOkXP3ojnULKEcO8UGW4Og0Cx+nUvctAt34+lhz0olvl7Hae+IqcVAPKWNXk8u41ZCC1cDCM4tqnlZ5H0Ayx2g9h4ykfzAuj3AEBp4DzUYQk/SCKT+uURBwoHRlaXzsFSh6jQufspfjuGj4a0jaPIAgt9MVlPPuaJYN6/RKvAyRcFb9bYJ12fSx+v8qYIJ1+4UpvbIiqinyluOC4U2VRvsgDaG7PEVM/LAmbWEAyENfvQ3JVYRgC3nA==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|12121999007|8060799009|19110799006|15080799009|5072599009|461199028|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZlmaWg0ytqOOqwBbuIWXkKoHurd8qbGuoYvaAkjChJ/DgbfFwKQD5agN+iAy?=
 =?us-ascii?Q?Mkq8NL/hJ2Fj7ZHQyfiiXifb4zUWH5usIMOcpOr0zuH3l38cfqT3CRasybnw?=
 =?us-ascii?Q?btn82q/sXLA2SAEgLzmt493MkwUJajDjtpFEIbhMOPkJ4zKAiB+AeJMf+FRH?=
 =?us-ascii?Q?5KnlMOGLW+Otel11Q8wCDJ18FkJzE105VQ1XIHwUbZfS7DLlsxv7ZGGUjETG?=
 =?us-ascii?Q?u9QdCpjg9TKljdATIqpCNJH5LSZ7+Mf/kB2dhXqegOWAIYoc4JJQnIXLVtrr?=
 =?us-ascii?Q?sI73giAUN2A3cEcGLBSeUhzggSQ6JIOhRhH1Ta+Ie9DefW3559QwsNqJ8BDZ?=
 =?us-ascii?Q?28HfPi91kRgqTdXYY5XG6sXJJ9D7yq9rlEi0fjWE4ZDm9KCS/Ua0YIe1bT1l?=
 =?us-ascii?Q?9fae8mwwFBdIDjlCj0Nuovg53pc2K8VboPorhLY39MgLydlBZ6RB/22IU68e?=
 =?us-ascii?Q?N/kkDN/fIwZIfcRW87Gy0fxRqQ8s1bQ6BJrCunVGXIqMXuTLmCDbgBplWjD5?=
 =?us-ascii?Q?5Tj+uyN5yb7TkjyhUuDN/Fn8UZBpBjhepb9wo9IAog3tiHRap6GwfuMU0Bmp?=
 =?us-ascii?Q?0X1Uspz1/isE6Y06Sfp2N5ty1sofMs7MVSwPTkBDXwJWUm2Z+J4Sc7D+9vVx?=
 =?us-ascii?Q?M58cdF67Eb5BZR1+vemuyFmZGVmxeoADx+e0Bioarau+6CuH9yPhXleK8rpQ?=
 =?us-ascii?Q?9zUUTpsceLEtYzlGJGacmRZafEXm3B4Uvww3XvnWQ1QRC+ndMF2d5Ki4khqN?=
 =?us-ascii?Q?FURmup9IQVyfWB2lMrK3N0vfGxZiAK1rUdcHw9z86xmC/YaTY98H0a7k4bEC?=
 =?us-ascii?Q?jZFbNW1cCj+O+6DEwL/cx4jZ5xI8HTKQHkANSB8EExlKLSed9Ap9Ez+4R/zD?=
 =?us-ascii?Q?6jA7kqdn2H25Hczq/i4PR+VLv3RyxP296ZLH3cBbPhBGw7Gqga+dyuAJbTfi?=
 =?us-ascii?Q?ldgeuQaslsk7qspj1k5qg58tzjNGAukX0Wnpk3JMenkFCc8Z3xZrWhMwgIcO?=
 =?us-ascii?Q?98hnacEk4a77eQBSTiLpVivhfqiz1uLr1qKhV5PBgZNpPQi4OeeX/rbPQ+Mi?=
 =?us-ascii?Q?0zCjNiVaTYDZeuoA+T4Hv3WqX8LGv30eV39gvduU4jHUMu7dc0rRmYkTBeo6?=
 =?us-ascii?Q?uYMzGRDLVd/WhI+9lHuOphH6FiaL/0Z78f2xrkLKedq5MbyacCh2kW1uIyQT?=
 =?us-ascii?Q?p7FEuu+69eNJepLGmp6tRwFUXk8+2fhXvag8lJSFPJXVBZ89kQI2cTRxtqw?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Axr1GCgPukn5QvCsaiSQau2J9UwCRshK1AfA+9HiJVFBSJRpZs7PaVoB+toN?=
 =?us-ascii?Q?TGy2k2r3ySwpmNro69Fwc21C8LHlnb0c/+RxsFm4X8xBm6BJPVvEfbkl8yGT?=
 =?us-ascii?Q?p3vpRkFNLFaAuyw1RyQf1Q6nJd42YNPirvv0rMomm3c+Esx0yP6PyVNkNJDk?=
 =?us-ascii?Q?kazvnLHbfDuN+igVkj222FKZ7gimlinV3v5FEXydWnRsCAGSgJQYfvyirWk/?=
 =?us-ascii?Q?HMukXEOfRtuBHhbwlwWVuccQwEEXpYSt8gAHi1WGuX8ahnAsbiz3kiNhqwYT?=
 =?us-ascii?Q?HVx4jU/T2PKUdhlxQYXYOMGCt+1TXKiHuz/Mn82UU9OsDakeOjgBeClcIVKe?=
 =?us-ascii?Q?BmCbCS3FNlCDO0MKUWKR/B8pPU4diqWJpjc7xXKKHg/O3SoeomB6+H6vXlBh?=
 =?us-ascii?Q?5fj+NF4nSQRIHPHelqYFUfPKmgpOY9UBtbcChNHu33xoMrGkt5jkAp/eVO7f?=
 =?us-ascii?Q?UVjnM3P2oGgXrpbYherczkkzZmlaMmXBnXUdWXa+T/7B5r/WXddp/gsLqaeV?=
 =?us-ascii?Q?hosxJqKrTvWUexwhVisboPe0Lk8uOEMoO1x82pWSYjY+2y7T6nZpCFlmjv0j?=
 =?us-ascii?Q?8cr7XIb10ZB6FXLzpS0HsIaZ+KVY43kRtMKSBJ1fREvpG4x+BxWCqXon2z06?=
 =?us-ascii?Q?DaoVKG7j61KRLy8ugLEL2QqwBOPZuub6CNkPQ30LhjIKG0Sd5zqHPm6PVkpI?=
 =?us-ascii?Q?pBOUqr9G1dZp+ULf1AaZwQtki42c2Uj1Sd9lF0MHfDhxNXheCt2p/Ug0Q1+t?=
 =?us-ascii?Q?U3IYZb0xiHbRy4bQw8PUCdT1c/demPJsntTc0YV4rbTU9JlydhjDqNzah+80?=
 =?us-ascii?Q?mvw89HmTuSPfkA6O678jTtSHlbs3yYLRbEORKtYRp48bvjHG7LcSp0B9KAUg?=
 =?us-ascii?Q?JEjAiDL0eoiFEwfCRaaRI0lY9UNtslZyveuh2sIfwOZYI0dfGhqUxy5axryz?=
 =?us-ascii?Q?1wWlPr8vbORV6H3Lzqdvft70ZZGr45ntR0XVQxFZRyF8KAueDdy92HbUZUhg?=
 =?us-ascii?Q?yGPvcKgpPaeIuyKxhqb5QbLCyetj3Atvs7A5r5DT+b4OB2jDMRCpK8IUd8YH?=
 =?us-ascii?Q?Xd7TAegl6nYkicuEhgxITsd5ghJ/0/r1ihnyjKMTbakjMhWMKvfpWE7N6dok?=
 =?us-ascii?Q?a4aMHIRNt3X6GKNIA9wj74c1cr341YsteWJ1IS1QFffZQej5DyIzvC52Jdxo?=
 =?us-ascii?Q?ASRIKCXdYljMKxPD0x3ICqGEGoU1uEG8dfdjXSw0gOV3pjekZyKETaqkomL5?=
 =?us-ascii?Q?kgV2E3YXzsqlbQJrp2Um?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962a9db9-f1ca-4146-2d9f-08ddae7814fe
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:53.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following missing-prototypes build warning:

drivers/spi/spi-falcon.c:97:5: error: no previous prototype for 'falcon_sflash_xfer' [-Werror=missing-prototypes]
   97 | int falcon_sflash_xfer(struct spi_device *spi, struct spi_transfer *t,
      |     ^~~~~~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/spi/spi-falcon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
index 84279058f..faa893f83 100644
--- a/drivers/spi/spi-falcon.c
+++ b/drivers/spi/spi-falcon.c
@@ -94,8 +94,9 @@ struct falcon_sflash {
 	struct spi_controller *host;
 };
 
-int falcon_sflash_xfer(struct spi_device *spi, struct spi_transfer *t,
-		unsigned long flags)
+static int
+falcon_sflash_xfer(struct spi_device *spi, struct spi_transfer *t,
+		   unsigned long flags)
 {
 	struct device *dev = &spi->dev;
 	struct falcon_sflash *priv = spi_controller_get_devdata(spi->controller);
-- 
2.50.0


