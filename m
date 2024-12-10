Return-Path: <linux-spi+bounces-5985-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABAA9EAFE2
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 12:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FCF288319
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 11:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA5B19D082;
	Tue, 10 Dec 2024 11:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R3YiOxzu"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2067.outbound.protection.outlook.com [40.107.103.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F41DC9BD;
	Tue, 10 Dec 2024 11:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830109; cv=fail; b=A2rDWFJQU5ZDpelCpaV8ZsLtB3cy7WrT4rg7EOdijpEunNaKlGoC7eKryUWhDM2Ji/D4duUc8ri//uAQ0WBOhBChp9zHZ9mvdegWrEFS0WE2npH+Fk7LOhvvNjb3UwXn4VbfwXlNzOeot911jiKiX3hP3pGioJFduRg40tYGJu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830109; c=relaxed/simple;
	bh=oEflPgDNFo6QWeqYEMMyOfF8TftqRAp/58UIe9VrR+I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ckvQmacSykRilXtVfi6vQuaD+wnbB72qkUE+C7pSLA738QzmCqqPe1mkP8Nn88Z84jqgWRJo3HLOyYWn8cy9JzX4Qdei4jc6FxBwaHuPHvDaJltQmuu9bt2G2lp5o9bRQRdXxA1dDMwHMKl3iwjCBdDTmiF82PZxKYzZxa/JTEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R3YiOxzu; arc=fail smtp.client-ip=40.107.103.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/wnqVgcxatHyEYl3wn+e2Z0FYyqmZ3e8ehW7BxXxqxuQlcfsQGd3/E7nQ/jbNhpTWq8RRNpmyezRnTfL0ejdKsNwc6XOMzfdQzAZV9Xmcm0MP++B8CLSVUS8zhCfCpPbcoj4tJkeTsOhdS4nKtWASfHTUQm7Hi2uczxitt1cP4yMEhnG3ZLWg2e2wk5gXuCfCPDEuR/yX11M+OCB4dMK2lONBYnKuXhFZJpN1wjJR5K7IhBt2TQaT0ftp0DZVodYgP/iI6cSk8HFSybbuDY1OzSK1FnmbfYpbH/nWR+16gL1LKsHjNKLEV32p0+Bp4diqVAmp+i2kcqKUhnEjS8+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RPG8a5D19tiOViJ6A4p259Hlf2GhDvtSUoJzOLyTPn0=;
 b=prF4/+Pn5BBbxVB+Xw4pVgAky4A0fAU/5uJHJszrf5L2wuf9BwrnXkmK95S3+7GzFqggCkSKr4pSfeZ2vSyPVFPf+jW8ttgv24e0f/+LHgbEmld+0728zdfpTfqHkT9mjsengAmPU8OzSsymwKYgIyr14lLFLX2P67e6a1BYr88XaMZnrSfeS0oP0X3FPsjW+y+FQ4PILr6+AinQS5ELAd7AD+7fNrO4eklq4HyX4zVnlcEuizD/l6tbvymWPwPI0ig3MToN8rEQLmDGtAMEAvCeddkZmLOSWD+02gzkjkXF4on/GM+Fh1vWVbJfKOAvQfTfDJNDpKn9rbg1x0gvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPG8a5D19tiOViJ6A4p259Hlf2GhDvtSUoJzOLyTPn0=;
 b=R3YiOxzuBVcE/zZXumbXJZkw8JPtorezzUiMtqZH3Cm26Mdcj6JhvZ70qQ2GVtBlxiUOuSDgnl69w9+Et62HY8YEF70P0KGeku4rwySLaX7tiMVyYyvseW6xccO8dlUmMtuYpzHoErPicjkIpIlNql8NjqLBNeE/gBi9Cc8n/RkSsRjDAMLNLWmxaNsmuebdpgSaGd/O46darE30swm5Q5Cm3xQqH7unokVaXU5H0tPqdBhvBjTZUlVjACyccJFu/bJLjmj6rJHY4nrCHQJotvQAyHocV/EbkJHaNGmdttDw4urZVwFfXa8ETMMhPw1tROplOJKTjD26luwffF8OUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7935.eurprd04.prod.outlook.com (2603:10a6:102:b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.20; Tue, 10 Dec
 2024 11:28:24 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%6]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 11:28:24 +0000
From: haibo.chen@nxp.com
To: broonie@kernel.org,
	bbrezillon@kernel.org,
	frieder.schrempf@exceet.de
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	han.xu@nxp.com,
	chengminglin@mxic.com.tw,
	stable@vger.kernel.org,
	haibo.chen@nxp.com,
	jason.hui.liu@nxp.com
Subject: [PATCH] spi: spi-mem: check the dummy buswidth only for rx mode
Date: Tue, 10 Dec 2024 19:27:12 +0800
Message-Id: <20241210112712.483893-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0032.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::18) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA4PR04MB7935:EE_
X-MS-Office365-Filtering-Correlation-Id: 916ef4b5-1810-4e6b-e43b-08dd190dc205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FMizqfeZSLof4j4PHMIHTAnHWye/CdpnLSj1vlFItEGUrVxDU2+OfX4lD2Xx?=
 =?us-ascii?Q?j4Oslvvq1CvtXh+tEKT44KEyymojv7FVz2IYwWkRY4T3Qhpy3KBbetwvdG9U?=
 =?us-ascii?Q?rzp41kE4JXT0qGNuw1R4Za2EIW1oOofp82Cuvm9S89zqteatMx2xMkgf0spA?=
 =?us-ascii?Q?vqwsQeBcLyeWx1RFjiSmLpUIuXw1bLtuWbkGIGsem/UYk+ZIfDKcjiFVb7op?=
 =?us-ascii?Q?1Z4N43jNbz8aOy79IPk+H8DtH0IjC9MtMm355rj9pWyP9IXSpj2h3dHU6TKJ?=
 =?us-ascii?Q?7QnJTVwpD/xBxjf8W68myfbDIbhOuVzrJqYzgmfV3q6Dr0stwwaf3Hh/LiRy?=
 =?us-ascii?Q?K/vOBfFiYOeWvMnXDj1BwtFumAVD52kjsuofDW8Iqc89wsjHNiGcuwBUB4n3?=
 =?us-ascii?Q?/k71aOHkh4G0mi2aCypZSlPj8VP2vX9JoHtkkighCW+1PnYn/3nUQ6jgnAjN?=
 =?us-ascii?Q?hRRqqaJMRCjHTsRmi10lLcHyJCfxh2n77RV7/BcmnP7OBwYoKnZ0oUSPe0Hc?=
 =?us-ascii?Q?5d/daEYyLdsRpabdVAcsCLCRgbVEdXoOs6ErhtrhpLUUph4qbrujiG/52iIT?=
 =?us-ascii?Q?PC6RpyS1FnTN16xJD9MP/mOGwKy9vIXt/SSQMflja1+V04G1rSaUVQ4PlmK7?=
 =?us-ascii?Q?1KnDiu9fKLsbz32Zo4ZHvEuMgGlSQdFQ+rcWSNWBmW/dV5LhF/BsdkR8FTI5?=
 =?us-ascii?Q?TubBwqgjQCZAA/E3mMx4PnC7eOnOQySH8I8zMKBf2U+uL5/PBztqEk70Zs3x?=
 =?us-ascii?Q?Ck59rWHKZmKS3hGi2Awt6ngWP91nQ4cGb1yK7VDIZfrko1XM+ouDMadawxm7?=
 =?us-ascii?Q?8W0e1tfVxLI9uuuTH5un9Hv4VCXMdEd+ZTqeXLOreMIZPOoFr9FEStOgyOqw?=
 =?us-ascii?Q?kXfdcuw/iKHsZ0KSZfnnR95An7j+q8hIw5Rod1S+iwv2DvmnLt7CAkDsDDoa?=
 =?us-ascii?Q?6a9mj220mkTupX9UCpATOAESQ8DADxW09UE0MKEhusap7BwkZlv5LImXDmMO?=
 =?us-ascii?Q?h7X6ZUiCr++xw6kazh43cTYFkDvOjGI4SyWzEZ2otEyDw3JcmJhkLYDazFAL?=
 =?us-ascii?Q?a11efe8KuqieGAY5N+Pul4aBNROZUIUYlMgSkRTflaEkIwHOuzkphteYlkmx?=
 =?us-ascii?Q?ribpw0LEwvF59NkZec5X/td2tBb5nNyXxt8VALeAitHSBxtF8VzXZFsmc3H+?=
 =?us-ascii?Q?gx3BG/q4AigzrvJaORP9SZqDRxyAPjZ28fYppbclq1hieoevDzTvcIiaJDqC?=
 =?us-ascii?Q?Bje2gIW38S65MEPmqacJcF6fWI5qXsA81SWF9Q4ZkJaXtYn8npwPWI11Txdl?=
 =?us-ascii?Q?8j+f0Hl4qe/xK9azE54OpnKaMSni/fe0u7ldBI2ZFC183ESkXRHqTqA5Bs8K?=
 =?us-ascii?Q?LVI3v/lZt3c90IiKbwGXWGeeh44BuLZynFFi0mbaYz3aDs9TqQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tClDLe8V9I8EQJtg1gQKaC46G5nogxMwsHvLocQqurQxJU3AAzT1kQ5vlu6F?=
 =?us-ascii?Q?Ger+rPS+7y3uD1dImfPdRvW/YV+P+uXHMiEP7b8AAJ8rLvPluQQxOQb4fhjq?=
 =?us-ascii?Q?05ce08k+yQfh7rH48e23BfA3Xur88LPsZQK+rLKP1I8kLINgtksh88L+kJ82?=
 =?us-ascii?Q?3zTxCGWKjXGBrPWPIwwCL8YGGKKgYwpCB4xNudnJ7tTPzBIg07hk/QLJ0EMX?=
 =?us-ascii?Q?QSVn6XmOmW8sculccY7V0LT1hPBSXg0U8PNHczY2+ADNpAhj0VxzN9mBJjGx?=
 =?us-ascii?Q?9unfBk4ptD9hjzqM9RXlWHuG4n1HQ0XcdgSFf6gjdJjxCGTffxXEBsQVPZ4l?=
 =?us-ascii?Q?DNP1MIlwO4NDRpDGn33dfMRBeLfM3Ppjx6DVSps2/SENfS7K3fB9Rx5d9u7D?=
 =?us-ascii?Q?w2uJAp17SPGXZP6Z7JY/addNBXd0MJvigSmeyhohVjR2jJalW9lsRNFRQm9m?=
 =?us-ascii?Q?mM5QwhcC+g/2hvf2TavL+WYL9dTuvgIRIXK4JjBV8Ci+DETgenGGGCesz/Kt?=
 =?us-ascii?Q?nvik9ed5c955/VG6Wyeg5USVkB722SVAP7JmRDFz6Co/wb3KaZEoRIeaDvjl?=
 =?us-ascii?Q?51ZcnCKvqsfOEhXyRBCyOQ2XGtljBQDJY6sdbpgIDQO2Latqoq74QGLFbZzt?=
 =?us-ascii?Q?04SoazieX67l7snbSTT5tWFoZ1lZPpOGfryQ6WOZFXiUug+VYir2hSwiscdj?=
 =?us-ascii?Q?SjhNFBlwLoALVuCx0KGSocFFueNloTfqMaLxeE9P1s4dR1k3LpbDbm1aHinR?=
 =?us-ascii?Q?40EzaiREttu6OpdC7UgesuhYtaPf1y82JybIdoJLKRV7ezaPrMGcFWIYsiFe?=
 =?us-ascii?Q?ciobb3WlgbBIBzkWmO0KAIlk7s6vj9YNqH+zHWgfW3/7GsNtxo0Kz7rQvznj?=
 =?us-ascii?Q?YB0nm4pczSm4iKBzysq7h+HM74IB3ZuhO16m+TaOKWSr8mXdwORZ8b91AZMQ?=
 =?us-ascii?Q?Y2OcaUQVfGAJwcAvTRmWj9cUE9qoGS31pdylAbxN8FW3ycRIqVD4+mQhYKwi?=
 =?us-ascii?Q?SICc6vTLyH1dD9e5jwCPQ9tChsdQAzzlKK78OPb8EJh9JOidD23ArmKYbAOK?=
 =?us-ascii?Q?G/nn4ngRC/WmXmLuRY1Rwc40IFtpdsOvB5pP+vhyFlIqZzsB7gItVTOlUX6a?=
 =?us-ascii?Q?mGt41T0P5ePCPmoIzsWnE8N6y8+luY1dyzjdQ/L0fBWwMoBp6CsIAmhL1rGL?=
 =?us-ascii?Q?rl2a3TNE2pH3CfhzbS+40Bwm2eBz1kTy+aEB+W41cLFP2z6tg9EdvIrzAitv?=
 =?us-ascii?Q?BmF/vPl9FKI8yN9mj+vpyhvwN3YY1FCx1XYfXxzaHngcC2z2Zmzp2mqjP0lX?=
 =?us-ascii?Q?BPbyMd+xLOYPAOEtySPu8UUrNfYAnUn8EJbZdZoZrFvF+1AufT3LQErPc+Xe?=
 =?us-ascii?Q?eImjBf13fTpPXAIvoRAI/ckTghMCJ5XnJBny9gjmzCFywTSiSp2WP0sMtY4L?=
 =?us-ascii?Q?Qz3Ga5WA9rbD7+jDtdKYIsAD7vLM7elq/uMtckl0mlLLSlmRoeIblnPLiQ1l?=
 =?us-ascii?Q?fqpVz1A0dN5VNzuQyY9ASb9kaGHlY3aCy3oaWM4j3Tpwht+rNk75sRYxvEGM?=
 =?us-ascii?Q?qoqulUh+/rKMLV3xIhiaYhbd/oEkQ0swL5mM46cX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 916ef4b5-1810-4e6b-e43b-08dd190dc205
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 11:28:23.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQmHEjaf9JOj6nXO6EgUVuVwe5O7hOjlDM5dQnnibyLT37lkNU/cAYdwzWVHeLcPXOD0HjKSpDRyrvAAcFoKBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7935

From: Haibo Chen <haibo.chen@nxp.com>

Dummy usually used for rx, so combine the dummy buswidth check only
for rx mode.

Find issue after commit 98d1fb94ce75 ("mtd: spi-nor: core: replace
dummy buswidth from addr to data") on imx8mn-ddr4-evk board. On this
board, rx=4, tx=1, without the upper commit, chose SNOR_CMD_READ_1_1_4,
after this commit, chose SNOR_CMD_READ(1_1_1). This is because when
dummy buswidth = 4, spi_check_buswidth_req(mem, op->dummy.buswidth, true)
do not return the expected result.

Combine the cmd.buswidth and addr.buswidth check to tx is reasonable,
but for dummy buswidth, need to check the rx mode.

Fixes: c36ff266dc82 ("spi: Extend the core to ease integration of SPI memory controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index abc6792e738c..bc9f09a9e5a0 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -150,7 +150,7 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 		return false;
 
 	if (op->dummy.nbytes &&
-	    spi_check_buswidth_req(mem, op->dummy.buswidth, true))
+	    spi_check_buswidth_req(mem, op->dummy.buswidth, false))
 		return false;
 
 	if (op->data.dir != SPI_MEM_NO_DATA &&
-- 
2.34.1


