Return-Path: <linux-spi+bounces-256-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7A7810D05
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 10:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E40A281615
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF791EB58;
	Wed, 13 Dec 2023 09:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m38rVIoX"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25524B7
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 01:08:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9hoEYEtHlKXLN1rs5cqHliIOZSqxSMx0WWaKgnyyIrnWL7XU3ZGQNgCMmWUxSzIvLOJ5ToumASW4GU+kcnep380POlRZSiROvgngJmrD6J4XPmQHGcnNb7ua8IpoFqHEKIpiPfqBWyyjhxEuUpqC29xFHYTE5KPaKm9HxpmEniyUEPKGzD3X/K/T59spUejH7JYgy7ev1pQ8ZZWppFVunBGZQbV+SDLFVAbVoodQAJ0dpbeDwVu/QwQ9qXyIZSBSmKIScfF1WHx53LaO/AOUwEXxugQaG95Rpu8Q/eVDu8Z/DffYB6WDgnxIQdv9/wV+japALr9L3q3qBdiB3Tbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TltRCOk2np5xXB26QpaZ7nFgjPicBT79DnkZ+hVlk/k=;
 b=H2IBh2ulnRMo06yhXQOQ5zog2VNC2BrQrZLG1zQnA1Qi7GOTUKSz7Nfs91ebPaRhm/s62n7gx43yNsS0dj7c5agyN51Bx4OX4UlHqjYXWusjlYLg9H2zreSdwM/Cirq8FzkQrvXup3h+hS8u21BDuAShazWigo3Zu79XFJiqKA4mxt4r4A/WCcS8OJM/xDEsb+DBAsbBibwxfsfqgxGNddLYFgvTR9w5L+iS/t6DKq/Q4xNQ8A7A3CPTm0VD7k2jXhY8qbb5MUw1UHoTIHKaS2M5UwqfRVMB5hpkbTHj/UYMbN7ppvdGfTcWHaI6LhYnPVMAngdmRcR544Q62ptZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TltRCOk2np5xXB26QpaZ7nFgjPicBT79DnkZ+hVlk/k=;
 b=m38rVIoX33tx3lMkb1RMIkf3cHwl7OW3xhfZSoPesm4mlBcGvGFQrZUl+VpHywvt5nTp9CJ6yAiNZz9UurBPeL2lWaTI3CkJBydqFwI61C+gFgOkZhonf4SRqNYEOZUIvpYbmtT4fkX2Kv/4DElXTiDCBPbyXHUYHek/xZBjA0Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:08:42 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:08:42 +0000
From: haibo.chen@nxp.com
To: broonie@kernel.org,
	yogeshgaur.83@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-imx@nxp.com,
	haibo.chen@nxp.com,
	han.xu@nxp.com
Subject: [PATCH 3/5] spi: spi-nxp-fspi: add DTR mode support
Date: Wed, 13 Dec 2023 17:13:44 +0800
Message-Id: <20231213091346.956789-3-haibo.chen@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM7PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ca36db-aa1e-44e9-88b8-08dbfbbb1a20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Js0uadX5lPub0ckT6TN9BGKtNpMDHABHqCZQ8T7hFZ9w7wU9qwqmlWmOK3PsfDCLYsPGSg8xYsTHyc8YD8CtlbNLLalR2ET61iMxH9NXZcupWmrErPu3qLQEbceFnuCx8iThcMHJ9BjHLTJXnsUsZSUZobXtToba8s7/c9P+5fXvdiTaNBzkGEtQVyY7TmJtPtG9hjQzFvO2yJAWUp2oqRn5Nlf8Dn/Zm/zeEctQslKIeHpLSEcP0S7UK/MCCrkHc4QpAVUiAvqwZT0GOEIK1bxoSuMKP49zmtFdQ3cTIZ/A0UfLNYUWKpqqWTsV3LCwdHMDLsAYsnhfu/5gODC3piGdkkff76CCL50Ih2iZMVP2IA0HJlACmmBVcx2/wVWvCDU3NZIzRJY370XmP+mYLDXQLwXodN7zBWyerR0SATXZUuOffuqeT6KWN0kU9Aj5cx8eDQ7FYs9AdcDqfzb8yFG1cm51e6vr+UJLef7MeMcy3mhtI+/YP0M3b2LaKMab3uLwDvafVpeJyQ6Nhi009raSuTE9MEP8jm7fDVe7LvC26P9kj+yYurHnEJxQYgKsnLgNIOftU6MEkeFirtIx3DSf6KbaiDxxrPAkcbEOXq1Vd16AjCncq751wpRqzMqL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(2616005)(38350700005)(86362001)(38100700002)(36756003)(83380400001)(5660300002)(9686003)(6512007)(52116002)(6506007)(8936002)(66946007)(8676002)(66556008)(6486002)(316002)(66476007)(41300700001)(2906002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fIlNZhjV/yzynMx/rulj1TzqyjjYIBG24lZWJNrM5aZVmlCi2TVwCGSuAC4p?=
 =?us-ascii?Q?X5zwM+pePI8Cu3Us8ngYR1PbDeLpFlpxrM8ttTWtgIWh7nzXJTCC6npTfHGx?=
 =?us-ascii?Q?c0lcsrTy6O+PcU+TD3ucHMmeFGW0hDUz81FImy30wsuJC0cE4Qrm7mRl/Mzh?=
 =?us-ascii?Q?SPUWde3NTHN8KGvu6zFRvRjaQXmNTuHWbVCG+EOVqMav33HSzTiHh32t6yD3?=
 =?us-ascii?Q?fjPZI0WzS9BA8H/ZXVjtFDRuJ8LKxA6PAp5ESWgRLEbJsRkCK5zBxrAKucNs?=
 =?us-ascii?Q?Wkdk+5lOXXLlfiyxA4ylMEOx4RVrvi82JoKH332PvwQ+KWGXcNFZRoHeZieW?=
 =?us-ascii?Q?qXrxdEX+A+MtTfIx7koxh+6CWF4+lfcM+4Ecne3BO+4eaMPTxGxvzF+9dSup?=
 =?us-ascii?Q?RsHaVlobPoZMTIZWr2zbsY0Uo2OgEihlW2DUvyNNghsTMLpaRoFD8QcKfQbz?=
 =?us-ascii?Q?0Mcw3qziC7zHYllsh0jyM6314Igm4mGGvdp+vrzxOS39dlLAoQqv2noc3Qa9?=
 =?us-ascii?Q?pVpf1XEe9VCIqct+xvdUUpumQX37FJ9YOTnx9KIHN2wuSMXTL7+bhxJeqGXM?=
 =?us-ascii?Q?BowML5mLM7TBooY32VhqfX8WMDsI36bNCeeFZb+GDGo3940lM1UcC2cm6tFF?=
 =?us-ascii?Q?0xSchs4sfatvI+wLxjFdLsGhsvAU4tmfL8ndha8iP34gKRDlQ2bxhVygP99p?=
 =?us-ascii?Q?TcP2yJTLTY2uBJjc1htqAXlbjCB7r7NvXnfOp/79IGfr4t1fzD30nU4+dgLf?=
 =?us-ascii?Q?YTgUnIB8ggbsO8Abply+N6uBqfOg6C395PWycxjZlTY71M7PleTHF66+cXpR?=
 =?us-ascii?Q?RhFHwhwEO/6omrsng108Me4nc9FJ0FtvPlvhTogRW+Wbi77p5jAU7VApPAWt?=
 =?us-ascii?Q?Eu3Zj7yCGaSLq92ry94u7hH4wyX7VltH30X0eAygNFVa2PizdhOEDBNGTZyw?=
 =?us-ascii?Q?JxM0b8noFyom6sNlu76e91Srhz7eQZ6v9vJyqjT8cW7USVNKDbWRcT0oZ87e?=
 =?us-ascii?Q?mDbjfS380wJm+o8f+kY8dNktz/KL6ZgWwaw7+BEpbtK/Yknm9sn0zwgC7eQc?=
 =?us-ascii?Q?zhiaWiq/vrfLart1xXKT9ub1rt0uV5GW7KrO/f3t5gwANi6tVtFPNAHyeNB2?=
 =?us-ascii?Q?hsgItMNC3jxVmM9KFgglDdv4qxOeXQrhZm97N6wV5KhVqAQX1a3l4rVzm50O?=
 =?us-ascii?Q?MQCFbqa3dPkbdBS/FwKg5jWaLFzjnIZym8cK6ooV134YTQCJ7AWA4H0XDDTm?=
 =?us-ascii?Q?W+xXgen1fXHj61ZgVi8L1A5ZEJm7gSOK+EED4dtayU/6IBjh50yILmJkPVtz?=
 =?us-ascii?Q?ZJJ7BYJjQPRp5DLqJcZadtWBxX9clKkKoivJNfU4tFNMU4jG9ekDksxetedG?=
 =?us-ascii?Q?uHH5d6yBowXtPKwEmhxVCBij3apLLpKh+86XXqqIWxLMfmPFTfJ6SGYxY7Fo?=
 =?us-ascii?Q?AzRwrPP1U++RJcMO2Zq9z03APHjNicpNm3Fae1Z8+iWloVxpEEdnTvYGxxI8?=
 =?us-ascii?Q?8x1TJDw/3lWUPIliYonh6q5Jf+hD7D9mc+x08DbZvTABoMDQzwwoFzQ0oKAb?=
 =?us-ascii?Q?mDt925EN/3c+0gDhJ5nEjD3z4OwYTq5RcWq+5fdx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ca36db-aa1e-44e9-88b8-08dbfbbb1a20
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:08:42.0667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /k9WbUZEvpBqB+Mks+aTFlpfFn1H1E1L06ZktJFuvNNv2C2q3qaZnlFt0D+RsUib49+qHRTbMxrPfGZW5Wz58w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981

From: Haibo Chen <haibo.chen@nxp.com>

For LUT, add DTR command support.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 9d6b4d22263c..2562d524149e 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -552,12 +552,22 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	int lutidx = 1, i;
 
 	/* cmd */
-	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
-			     op->cmd.opcode);
+	if (op->cmd.dtr) {
+		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode >> 8);
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
+					      LUT_PAD(op->cmd.buswidth),
+					      op->cmd.opcode & 0x00ff);
+		lutidx++;
+	} else {
+		lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode);
+	}
 
 	/* addr bytes */
 	if (op->addr.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?
+					      LUT_ADDR_DDR : LUT_ADDR,
 					      LUT_PAD(op->addr.buswidth),
 					      op->addr.nbytes * 8);
 		lutidx++;
@@ -565,7 +575,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 
 	/* dummy bytes, if needed */
 	if (op->dummy.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->dummy.dtr ?
+					      LUT_DUMMY_DDR : LUT_DUMMY,
 		/*
 		 * Due to FlexSPI controller limitation number of PAD for dummy
 		 * buswidth needs to be programmed as equal to data buswidth.
@@ -580,7 +591,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	if (op->data.nbytes) {
 		lutval[lutidx / 2] |= LUT_DEF(lutidx,
 					      op->data.dir == SPI_MEM_DATA_IN ?
-					      LUT_NXP_READ : LUT_NXP_WRITE,
+					      (op->data.dtr ? LUT_READ_DDR : LUT_NXP_READ) :
+					      (op->data.dtr ? LUT_WRITE_DDR : LUT_NXP_WRITE),
 					      LUT_PAD(op->data.buswidth),
 					      0);
 		lutidx++;
@@ -1152,6 +1164,10 @@ static const struct spi_controller_mem_ops nxp_fspi_mem_ops = {
 	.get_name = nxp_fspi_get_name,
 };
 
+static struct spi_controller_mem_caps nxp_fspi_mem_caps = {
+	.dtr = true,
+};
+
 static int nxp_fspi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
@@ -1254,6 +1270,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	ctlr->bus_num = -1;
 	ctlr->num_chipselect = NXP_FSPI_MAX_CHIPSELECT;
 	ctlr->mem_ops = &nxp_fspi_mem_ops;
+	ctlr->mem_caps = &nxp_fspi_mem_caps;
 
 	nxp_fspi_default_setup(f);
 
-- 
2.34.1


