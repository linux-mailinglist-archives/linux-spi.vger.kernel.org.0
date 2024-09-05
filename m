Return-Path: <linux-spi+bounces-4661-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E928596D3C9
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 11:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A132028987C
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 09:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A941991B8;
	Thu,  5 Sep 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LSxLKJTP"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11C81990C8;
	Thu,  5 Sep 2024 09:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529511; cv=fail; b=CZCv4OKeTQFiP7mKC68PHtTxWnoUIRM2t3hoZ53T7Mhk5bnZPkHU32q9sNo/yYLHdsOyoFx08pbnEzOT5Np2ysbfsbGbenNbTluO2UYVFBa9K67z+PR/quFGrEAq4/uqw2p5jccGxq6UPSIpyKXLIPr8ASwU5iLhHO7eN/0+yAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529511; c=relaxed/simple;
	bh=+rnzpKrraH0h2bYJD7CK7D0vYIERtyA6avJCs4+0/bo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rxykgpYDlgAuFh69HfhzjmSqIATO0cUvP8saIQvNsexdtlERFrUyVENqYBUXzK8+3WcT7dIJi4JJC8Ea/YWP9w3lK4Tc/xTU9SCZ5FnAT+lk+bb61WtmSI1xhuPBWOPJJMXeA7ePLLFCfMDjiju0bcrdKqM/XaROffYW0kNo96o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LSxLKJTP; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8Wd72B3zvn+pgV1hev2q+jDtt+uX0F59BzsvTOPc67xnwoP8XsJUbW+pZWoy7/Ri4vLeMsgm1txlGAyddUWVNeT2b6Wehp1VNZzd0xGIGrpr2wY6ZLczg9toxuU38sqLeOX7l/T0M5hfMK/ecMAPcp7u0tCglqTFzw4EGTFRkW/Zlq0VsMJRz9C6/0BnDLVBvda/s217pZ89EEDWNSSKSBwVnyrENUKQKJeB2uKRr83HPLhhRrWa5T2uyBJT9vi/Yj5PrIJI623KGr8xzluysjY2Y2MLaJG3DfVyOxyMEGF4+nUkGpRTDnIXsVMh9OY7cOrzUMa+pdnbxjIRnZjVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5DOIcT+K2RMRm8g2YmmN51MmSBtg76QWoltVLmtXZA=;
 b=m++a2m3LcBDj8fbhcp2SmZbFDS1Pf2FWC2VZLVQy8CsBSzUai9SkyS9JYe4mqK4AY7Gr3vFelkaPXApy5vgESbXanQsb5EcXQLPBKz3D8iVsAXdwMMl3CJmMD6MrQg/ZzXtVBEURP5fKGsGARWmEz1bhnAOkTq0Cki4/YBvDhCj77KzqiHOnNSiOZ7GGXOpnF9MAkHzXkHlvuU+COeY5aEAAZHJ5eeWAxWfHIx4HMtsXAgT+eYxdGG7fLS0Tmj9ShGFB6WAuF6h4PqCRGzQPmwNGJj6O8JEPTgp5MLrBAoD8UvweHThks5uMZ1YOYFSlVZ6+lhqyZrcXPsDoRyWZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5DOIcT+K2RMRm8g2YmmN51MmSBtg76QWoltVLmtXZA=;
 b=LSxLKJTP7Mn58DVmpt3+iAYTR2qaQuLtAc1q0CLLNrQmkJU9N8GkZrR3D88yAZ5mLRofgHTvf06UFigcDXiMz+s6dv6Vk3+PtVnY+CT7QZ5HYrGV+5x3BAjCZz7j5pDNOKCGYCM9LbZXR5f1oxUTjJPhgKJKCXMJ+ZQDXTuShgi++Xs3+hBRuAnEEyIB89LRM9JgqiRXOt+Jl00MlNqvSkDQu7HPnZIyuL2goruMmSS7RXxlANVsvIU+IYUCMpd3Wd2z6SUeeexQhMmFdviD0g4pCSmnwZ0sqwJTxWI0HgcuUAJGAHTnx12ATs9gkq+dZp74Q1Bd3DTiJWwSdTD/Mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10306.eurprd04.prod.outlook.com (2603:10a6:150:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 09:45:08 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:45:08 +0000
From: haibo.chen@nxp.com
To: han.xu@nxp.com,
	yogeshgaur.83@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	singh.kuldeep87k@gmail.com,
	hs@denx.de,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	stable@kernel.org
Subject: [PATCH v3 3/4] spi: fspi: add support for imx8ulp
Date: Thu,  5 Sep 2024 17:43:37 +0800
Message-Id: <20240905094338.1986871-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905094338.1986871-1-haibo.chen@nxp.com>
References: <20240905094338.1986871-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10306:EE_
X-MS-Office365-Filtering-Correlation-Id: 487af6ba-2a7f-4f49-3f09-08dccd8f6d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tquxmhjysCSZapNrs3nphIB1Q6Jzq048l0gVw3omcX1NFrPEg9Br/bijJqFk?=
 =?us-ascii?Q?yaoIyNJXWg/qa25DwCoLA6O3pEMrkTTeFAyTaMCJ0CAlTAo2i5T49OvRCoJ8?=
 =?us-ascii?Q?K6tL12HL5zYRL6MmzACsSBf7tC8ViYWbR4hPMSDqBDqUrLCeI09toCZ2TMkB?=
 =?us-ascii?Q?Mb1bDVa240sf2aJzERstabVTYabT7fN1kYa5+zgbfsQoOhmadEfh7RGpT+36?=
 =?us-ascii?Q?Ehb6QUp9lBoiijrXqvItJE+ztTLUbHZqUWFsfNcqJHF4pE/UhST/0g1diGFb?=
 =?us-ascii?Q?+5VdUzGmTgwU++f7GybQc00nc61qGxIGTkgvfjWH6rMfxf6yhxNB3Mng1ntx?=
 =?us-ascii?Q?+LGGhfSQ4jXdnDRMX3qvT61X4QPHNDtogNVl+wI2Y//nJWplOg1+Js3TVUgm?=
 =?us-ascii?Q?a5N4OdMuknYglHVd+HokzuG81LX1BPx8KadkyIrtM9dN9AdUX1gxJvLMFicl?=
 =?us-ascii?Q?Sk2SCwX2dmLlCc6yA60IPcD9+6gWk5Wh44/+v6IQklgo/zz3xhdqXZZIXDDF?=
 =?us-ascii?Q?G9eGOTS/2I/17cHTrsuzZ7Cq1bGI60+K2xIZcmVF/aAPr9zIYk+FOVo85QU5?=
 =?us-ascii?Q?lnPN4cYu2ArWnhRgSNWl80QyPtFzHeopTvtdC5TGkewiOT7lg/PIhjUlWTnR?=
 =?us-ascii?Q?c66GIqjq3ruS8Sl2IYNTNCYc+pjDSudxQe9WGbqu70UuSpJcrrdjEuK5N8Zs?=
 =?us-ascii?Q?725nH9jdAzyNKz3uHY/Tfmh8cYUw9zFMVgdZo6VS3FhoLlhG5H/Vcod4eCPl?=
 =?us-ascii?Q?KiI4BY2MQQU49MWEFpgJaa+C4syDL7qh9JAOiFfq4XsF0R4srQ3ID0Ksw+JW?=
 =?us-ascii?Q?lGTUjhoaBn2dgZef01iC1w1VSlbu5689E6x02x1TiKMMxhIWurcndNDINFi9?=
 =?us-ascii?Q?kQpo4WVZ6JAd7QOmFPCs353zhFVPzyVFPlI4SG7lICHJ6oH83TaMuY/ZvzAp?=
 =?us-ascii?Q?zC2byy7b0WHoMtUju2HjZgdLcD0Ky9ufrZRnGD9Oso79QalDmnOTEMc27LsC?=
 =?us-ascii?Q?4qAE5TEBxic9R2VGpWh0QdaaJj9USxP9zByklUkIpvt0rjTialv1/93j0m7j?=
 =?us-ascii?Q?KFMljmRtSyw+eZa3hsklGEsV9Y5R4IGDjSJxHVlm+fzVa5lB+BfrJRoEXrni?=
 =?us-ascii?Q?7GygHtXAnW2nIslpi0Vjq0yaZSQndGUxjVhv1JnnyshFaJq9S6wzvxNQCWCv?=
 =?us-ascii?Q?uW2JeM9VNQgTVHQuyayCm/Zlc5Vl8HVilalHTM3FSd4LqmG/aC4zd4VPB7ck?=
 =?us-ascii?Q?eTxp+1q5V7c0cDP6L9tsUIE77+4l3+Hh3bz7/C6MG2JwmNSBcoXpORzf/fEu?=
 =?us-ascii?Q?nrEEZPMno37+ELF3bIvUOPzMnVfi88Vy5jftSXBQ7iSzgEKeczH27Y7/917V?=
 =?us-ascii?Q?aYPfm5uvei1Bt2EDlmdEmd7O7buOTJPN3TShWoVmof2BhDN4UQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siHp5LMeJ7sDUlC4BFLLwsVal16gq2WhznfmTdYFenODST4yyp09dWnbP4nx?=
 =?us-ascii?Q?AGhKNAyTbQm0/PZuBLasiBiJoYIr3Lg1Qc6Zqd120cslEyiGlPC+l6a8P4o/?=
 =?us-ascii?Q?BMA5ojmH9mB4SDcEJt27RFfjY4l4wOfSZLsz+1MuPN4Oo4VCTuEMvbpqLYak?=
 =?us-ascii?Q?ZW59cFPGg1DB8RKnO5cQHpjGrboqOb4cIkEizGobVxJ98eMKl8JXvaw6gxzi?=
 =?us-ascii?Q?6d3ub0t7fv31iroGbiOCXOrQ8R0udeaEJj/bI78OawUKIRqRZrFDyZAy3Fgg?=
 =?us-ascii?Q?Y+h4yVnFKteTZb8hKHuVwoW1sSATISxbCYNKc36WDaXn/hnDbKdePVx22zVh?=
 =?us-ascii?Q?V7ec1pqol4ZAgzljFFTRDeB9zYTKJ5wleRA/d5ylfK3xiQWsiZ5BasnthI6n?=
 =?us-ascii?Q?fOkCDFTjz9P3rPXdUYeshnBZuQtfkvrCzPKfnWB1fO+3EkLRRBIdcoMZp6kr?=
 =?us-ascii?Q?TR6S7X/88/T3ABr+Kf7OIvFv+aMOWl1DhCm0X48CWIrGLvcRNNi2M4aWTfIs?=
 =?us-ascii?Q?yYnCp6VlD1V3feLb+DVA+Jwr4oU23w2u+i0YOdSiR428iSTIx8VL5a21IBL0?=
 =?us-ascii?Q?aR/qINa5ZMH78JzXUnA5xSYh4K6nYskirQgxTdgRcE+YQx6TbSPsduH8XYlb?=
 =?us-ascii?Q?45vPey0P870EPmW1CJi4nKDH69eQOi0Hi0UUBb486cVso1/X+ULE8PTpg/tP?=
 =?us-ascii?Q?5gTDfR2+idpbdO8zaPH3azCxjpn8mA511zVAsI5NrALM3SGvCa9d+EntmFCO?=
 =?us-ascii?Q?cD5ooARqZd39wbvgVG490Brwdq52SD+HDTGmVfyw7kO+Kk0stwIDmqstlA2d?=
 =?us-ascii?Q?Q46/ipYaMgrLU4v4LPdYSIaPkCnm84zBceL7RrLjihjUmHnerD5Tt+MmUBHC?=
 =?us-ascii?Q?v/BV75556obiyr1lFtSEqjzqkcoUGHBPU0l4gy3584kL3Oks5xEFd55Om8ZO?=
 =?us-ascii?Q?NAL5ztY36ZRgG6+JYhX6CI/X3vqmX89cXmv5dK5YazmgvQokSXObOdc5Mh7a?=
 =?us-ascii?Q?b8df55l+LWM8ivZaiS8EFm6OsxG1tLRO1IZ1dcCOWPiDK1usWena/kj9PKwz?=
 =?us-ascii?Q?Xvdohm3/mnI8RCHw9NWMagnYWFe6ur42mLeKnlGrpQSh9RwQTV6G6GlvA9uC?=
 =?us-ascii?Q?WVaZkObKPZL10W2GCLbcsKI1k6VywQFbWBw+gmL+upUFv8tMG6uG17QlihfU?=
 =?us-ascii?Q?Z8H2qfEX/NOjsMy8QgJJvEefgFtNyBcKuaUAzBdPe3xeaw8RwOxZHx9s0GVq?=
 =?us-ascii?Q?ijwRcbSE93WgcQsZ6gz5OIThkRBP/sWVf0mEQIXgYE/MgHqMetb4xsdqO/9+?=
 =?us-ascii?Q?r52d+/4wwA7HU1CGLaTexfh6djlT34IXKmQbLccisXdlZs3DpdvTdoyF+Z5x?=
 =?us-ascii?Q?XCi5Pu2EIcSr7OKidFChuJXiaWQ87OtiVVJOC+rVOatvvyKXQE7dPOW18n8B?=
 =?us-ascii?Q?cD/qOWyOx25U0b28e90TSs06Z/RFV8fMeDq8U/C2qq+33Cpf7b5uAOP+JKkX?=
 =?us-ascii?Q?vOfw1z3a9AJsYhIUlUxk8PNug9NgStt51Vy9rr6QcaosAt8sImgjgRcT8a/T?=
 =?us-ascii?Q?8NuPJxsbGhunV/NaCtkguc3dbWL00MQ86CMDQ12D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487af6ba-2a7f-4f49-3f09-08dccd8f6d83
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 09:45:08.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACl2X3gAjABfSpHzHi/+P5PnxrF04eAHbDTvz51PODsW6SvnzmZxR/0dB58tgVpR3zm6SXfd9uLaDRSwQTiLKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10306

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8ulp only has 16 LUTs, different with others which
have up to 32 LUTs.

Add a separate compatible string and nxp_fspi_devtype_data to support
flexspi on imx8ulp.

Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
Cc: stable@kernel.org
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index f42c14d80289..69e427b1903b 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -371,6 +371,15 @@ static struct nxp_fspi_devtype_data imx8dxl_data = {
 	.little_endian = true,  /* little-endian    */
 };
 
+static struct nxp_fspi_devtype_data imx8ulp_data = {
+	.rxfifo = SZ_512,       /* (64  * 64 bits)  */
+	.txfifo = SZ_1K,        /* (128 * 64 bits)  */
+	.ahb_buf_size = SZ_2K,  /* (256 * 64 bits)  */
+	.quirks = 0,
+	.lut_num = 16,
+	.little_endian = true,  /* little-endian    */
+};
+
 struct nxp_fspi {
 	void __iomem *iobase;
 	void __iomem *ahb_addr;
@@ -1295,6 +1304,7 @@ static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,imx8mp-fspi", .data = (void *)&imx8mm_data, },
 	{ .compatible = "nxp,imx8qxp-fspi", .data = (void *)&imx8qxp_data, },
 	{ .compatible = "nxp,imx8dxl-fspi", .data = (void *)&imx8dxl_data, },
+	{ .compatible = "nxp,imx8ulp-fspi", .data = (void *)&imx8ulp_data, },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nxp_fspi_dt_ids);
-- 
2.34.1


