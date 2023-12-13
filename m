Return-Path: <linux-spi+bounces-258-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86614810D07
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 10:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DC728149C
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 09:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2F1EB51;
	Wed, 13 Dec 2023 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R7u5IKeK"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2048.outbound.protection.outlook.com [40.107.103.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CD9EA
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 01:08:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akhoATN41iMfZzX1/oiKXF0wQLj5OZtzzwf0XCz4ULS+B2F/FbCf8vgA8HvMr9eopmn/edNT6w6OAmRCNoGh0cPh7aAbGtk4BdJI5eikorXwyEE+tXTOje0gY2RGlQCbbZ9fUqsre0m9FyqMtcSnc33/FVVu2g4n6g5+M86lETOdyt7IwjSF6sRaWRr3QlVFLovJD/oqV4jUm9peZFuRw8wxBVK7rZv0lV7M2GcA1cWnx0TQfLruL0BQ297ipL/o0wRFg7AXd02veDW6i7ZZMMoZXsQ3A00bo1+ZIWHa7MhFPqM+HTU0bd92VpfRTD0Hn2UIjb6yefUpthPl0+5ILQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQFBBpXSnEdKkon1kJzJbqJ2+O/14haFTmVcsHIPlDo=;
 b=Ox4fMSIi6yvKb+mPSVQwH9eO/9ObOe1fV/tZKnHKwGQnjh7B3SXPstw62O9JwzV71pzMC5twG6YrH2EP/Wfn4Eukrqfvm1f2dfF3ZL96mSiwlW6hV8tqmP2wWK6AggZ/T9GBpVo9yjSSARySBjdMw2WLh/Lvi2YPDk6/b1d1YVw5obL+v5dNrdfqqYFZ/5bAQdJ054v4bXubaG5Aen/RELI/NAOqHDnWB624wqPd06vR9K6k+cXy9+uKoGo1nlbiEuxzwzH7rainS9r+/J5k1+c//wqtl7HT6+h+LmpUFRSZi/p+fOpS3YHBPXLpBybuoA4cj2gYXAo3z/I0+KQKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQFBBpXSnEdKkon1kJzJbqJ2+O/14haFTmVcsHIPlDo=;
 b=R7u5IKeKdG8bqXKyegfNv7yOBgULjcemKCFl6eqa8iplaQJAesXeYRyHYZiU9G3zoMFt95d+GgwYr2gR6G+nsU8GS4BvYezten/IF+dgpfmR+4DIJU1IqfTmpzKTuwnfqoAkVx3SOChWwvSF3506wDWoPt7N7iWRAH4lerQv4XY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 PAWPR04MB9814.eurprd04.prod.outlook.com (2603:10a6:102:37f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:08:47 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:08:47 +0000
From: haibo.chen@nxp.com
To: broonie@kernel.org,
	yogeshgaur.83@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-imx@nxp.com,
	haibo.chen@nxp.com,
	han.xu@nxp.com
Subject: [PATCH 5/5] spi: spi-nxp-fspi: Add quirk to disable DTR support
Date: Wed, 13 Dec 2023 17:13:46 +0800
Message-Id: <20231213091346.956789-5-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231213091346.956789-1-haibo.chen@nxp.com>
References: <20231213091346.956789-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|PAWPR04MB9814:EE_
X-MS-Office365-Filtering-Correlation-Id: af807ea8-411f-4b14-1346-08dbfbbb1d19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ddBuqHg2VfEaA/kVhlh+r59O4oigE7nnhjeh0rUjuzJ3VjMpLeaKdnSotkBUnIpiF7C+GmoJC+WlY/1w3F/3M+kany+/Ud5BCjCQ6Vmm3MJ/2g3er6X0Dh+e4damfhaL8QRgZAyG+RgF2ARBY1vZ7aw4K73yGc5HXMMBxMXLRZEGgzcZyGC6q8V6ZTjuLBHFCOCTuJFGHgxjCM7qSbNOpYwxC5pluICpmWRXsMyuzpyAPxPQa3vl5ToOGxhBJZJPlQlJgMqBKy9WgDUyk/pYRykFJ0QpoXe9dYlTcCgWDOgmqqU3WYPBdaySZDrkInKpqMFpThb+LiSDOqR6uhF+4fF69XHcgIJzaK/zrAF9Z5/L2/MNkb2TsNW4Z9dUSPaApM5dMpxuhxCj6naoKAT7M84hfTKElVBp251vLbcnJHJNtKqz4YbysGUETSKT/ru9KOv5iL3R9o7IYFjIRS9dR2l4Mc+EPJjA1nBWu1IFknEGu9FVcCvN5hit5E+Kus6G3W9v1zFnVBRYHjBdQyMna+XrMixBY/E+NHp979XXWS/LJ3Hx10g6ipniYUjbTUNBR/mxG799v9bZnR4KkjXbIbyV1959TFvmVPtTkcmVgKY5jPvorxS42MsDByEwMTBO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(26005)(1076003)(2616005)(6512007)(6506007)(52116002)(9686003)(83380400001)(5660300002)(41300700001)(4326008)(478600001)(2906002)(6486002)(66946007)(316002)(8676002)(66476007)(66556008)(8936002)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zf9zVScdRuDX8MR38E2G05Kz0YzDthcFPDAHWMZMNyfGpytXwFqAwf6LzvUF?=
 =?us-ascii?Q?IhEC0QGST1VtjfohL5qQtVGpcITUW82XIbzH3bG8N46DfyqbKQfNbTgtasul?=
 =?us-ascii?Q?bRP2OvffSwEUtXwIDnKTR2oOvd/6RXQBbUWNh409bzcD1u6qCr/q/yfGYMXi?=
 =?us-ascii?Q?M2o+LDA4NXozTagll2DBGSK63P8ilXynFF6Wtc3b9GgHhkJmdfmd4P0GBTuq?=
 =?us-ascii?Q?Rp8Hbq68ad5d3PnzLKuiA+sBhFYpCQsGH/cDBDAhcSJA54tUHINp3m/nsJtf?=
 =?us-ascii?Q?IDMEJYSyeB/k0zJ0KAkQcXD7qMfhdOjUoLUQtbNfLVK4Zby0ZT3gmkyofUCK?=
 =?us-ascii?Q?ddZcG9cKhfvqpYlkoy0VtCPrukTrk0KXav6Zsz9xLxWA2UCjcHInoOSu58V2?=
 =?us-ascii?Q?deSgaoOHQEcZ6rk8dpgn60pdCjdPbF3oMvzltdR1B6LY+1zda/SA5yAfMFs/?=
 =?us-ascii?Q?THxa6GJLMp0jkAkcgMZ/6Anf8e4ZsMScVXhqDtNh6X4RqoDBDHoQriIcuMfj?=
 =?us-ascii?Q?+U9RkBVEsA9HtbYnq0YXPN9p5m5Lhdn2aLAIF2WyNNIJMy9ZnqePXSUmfXLw?=
 =?us-ascii?Q?SBhvkJ1ayyQqyg4OhHwnvzmJfiiZ78Fgci7Haf2lggGATDeFHqLKNUOOR4Oe?=
 =?us-ascii?Q?VIqOaUSEh9q0PvZuh2DdItATqy8NWXPIIBz078leLBZ1Dn0OJAunoFKKWKt2?=
 =?us-ascii?Q?MlNsiTxio6LH363pYxIKiGN3HCm1/n+vksyA853iRrA/EV+i4am8Uqk27ZUq?=
 =?us-ascii?Q?REY7t5xidWvGqU2b84Rx4x48UdB+qsQZ4r8V1hIr5IHbRkR0UKvDA2238qqf?=
 =?us-ascii?Q?TRsI7AfcwqOmw+GjQ/mdObEL3aSgiwlXagSl0TbHF6I1ScQ1FPFRBf5tQZBD?=
 =?us-ascii?Q?jMNeaPLy06Fjwb942DYZcUCVxH7f9pIyDWtJbInRh/fmiklKAChS8ElfYZme?=
 =?us-ascii?Q?6UdwvdcijGYKJfOSMUIT+xiR8fDFedpX9BdkSTuGV3vLBQctUQfLRDuqI+po?=
 =?us-ascii?Q?qD6tVVxsb/iMVLaE7hp3yVM8yQTSLZDzftM14eMLhmcjX+D3+lKpDxYxaPLG?=
 =?us-ascii?Q?IiOBSqr+KU6JfsFZQmxjTXPOvA3Bfrpao/kNz0kzlBxbnFUonuC6MQ5HwTyj?=
 =?us-ascii?Q?VJoFu158qrovPXRwCXBj3ccF/V21pVsiH+KDI4Wfaf8fC08wjhJd1wZKAL6Z?=
 =?us-ascii?Q?/Q4lqFl5TPFfemcwGq8+uR9Cd5bh5hKPFK6zjTqyaGL+61MIdffHn0oM2n94?=
 =?us-ascii?Q?fxpmHmXXF7fzLE41emE7as2j05alM6d+J/LeK3yII8hPTo1JgR6RThwt04+6?=
 =?us-ascii?Q?0sS1ZcDdvbgbB06VWTNwR0Boxs/ondb2NcWL25ZE33uRu4jVoC6fogeNuirS?=
 =?us-ascii?Q?LTEG6qXEmbLVVr20RgTQsbvyOk4HFPVeNpRh0j/UqZ8RryDIaGHarUMy25f1?=
 =?us-ascii?Q?opHEmkXQZ4XA6I827hE0o2f31XPoySx1JfQJy0+iQUY4luQOdf1n0FagN2SF?=
 =?us-ascii?Q?lIky3jJUsclVRXpTTkfwNRg3im4s2umbr4YPX1mekMwRa2Ka+fWlKiO573kj?=
 =?us-ascii?Q?4dDE9dvgnObaskgNgvWc2cF2lArjRHOz/IsYkBgi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af807ea8-411f-4b14-1346-08dbfbbb1d19
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:08:47.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xlLl1j4tIWqj+lF6QeUNa7oy0xJufqtpTwo5Yckj5Qg7GoFJA29S5/prvsJYYEdKSE1/osjJe7ym0w/XGaxmYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9814

From: Haibo Chen <haibo.chen@nxp.com>

Not all platform currently supports octal DTR mode. lx2160a do not
implement DQS, this causes flash probe failure and therefore, provide
an option of quirk FSPI_QUIRK_DISABLE_DTR for platforms not support
DTR mode.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 0330454b76c6..3d470129a477 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -340,6 +340,9 @@
 /* Access flash memory using IP bus only */
 #define FSPI_QUIRK_USE_IP_ONLY	BIT(0)
 
+/* Disable DTR */
+#define FSPI_QUIRK_DISABLE_DTR	BIT(1)
+
 struct nxp_fspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
@@ -352,7 +355,7 @@ static struct nxp_fspi_devtype_data lx2160a_data = {
 	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
 	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
 	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
-	.quirks = 0,
+	.quirks = FSPI_QUIRK_DISABLE_DTR,
 	.little_endian = true,  /* little-endian    */
 };
 
@@ -1211,10 +1214,14 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
 	.get_name = nxp_fspi_get_name,
 };
 
-static struct spi_controller_mem_caps nxp_fspi_mem_caps = {
+static const struct spi_controller_mem_caps nxp_fspi_mem_caps = {
 	.dtr = true,
 };
 
+static const struct spi_controller_mem_caps nxp_fspi_mem_caps_quirks = {
+	.dtr = false,
+};
+
 static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -1317,7 +1324,10 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
-	ctlr->mem_caps = &nxp_fspi_mem_caps;
+	if (f->devtype_data->quirks & FSPI_QUIRK_DISABLE_DTR)
+		ctlr->mem_caps = &nxp_fspi_mem_caps_quirks;
+	else
+		ctlr->mem_caps = &nxp_fspi_mem_caps;
 
 	nxp_fspi_default_setup(f);
 
-- 
2.34.1


