Return-Path: <linux-spi+bounces-4238-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 004DE957EFD
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 09:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244561C210AB
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 07:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C923158541;
	Tue, 20 Aug 2024 07:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NifO7c68"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011062.outbound.protection.outlook.com [52.101.70.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019AF18E34A;
	Tue, 20 Aug 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724137591; cv=fail; b=CytkuwRfVL5IXlSlf3Q5UrmBZOk31f4yeIXqX5fLBjvoxtNwb5IG9im1ypxdrc8+EhkKE1s3Ls/jgqbyK+u4QqnpOSJNEnKTj4t5k3WwORizWcjlkjrdtvv1hWHdagTbYJ+4ET9K7VuSoYL5mo/UHKJpTTIbrKpxF+urQYSNtNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724137591; c=relaxed/simple;
	bh=vL+d5rThX/3FDpurpyNARGk28B0HdwTuZ5nRkawfq/I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hF4Q5+pHo+b0RXYncH+XgVH9p/jCFobbU9vCeeOxclktxTClCuimDTjFCnYPEjbSYknp59Yt6yB3bdOkvIlW7kXOdn/oB/3hlkFNzSNwt6lug602AcfDfVUKCOrslaUob2FFllrS9PdmMYfb/yZ/bngfst9V+h1qqgFPV2Xqwy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NifO7c68; arc=fail smtp.client-ip=52.101.70.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udTaejV5lm+o4YHQohrXzr6CgNXjXkew1FLwVVMkuaBI7+LrV5HAxI+kcYtnxlvy3AN4UIrQvDWmnWHY3jl4p7fXBYdzz/Mdk2FLKc1KX8+2vL2ISF5u5IoTjKTRTOjzj9i+Jitvg0295XYle2RFsCyvLtMba6I3ssTk8cwo10CP92a2+oLAl0MJZPk/A6g051uTSaow3rE0cqM5V3+sklsjnIWlnlGabIM6juCVPGlVx8mvvzCm3JgQtQWTk+IWVSw/MIIoEuZ8HOedISXZJWOz0s+3z3ESyLDoUxOxDNEBDzwRky5BHmPrv9s/8iYBr5i/5aodgI3kySVi3vf1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IM9fS+3eFH+Y0ftoEjqZdif/Vns9AsqSwe7eskJHtfI=;
 b=VgncMX/YUS9hi1x6fz264gm4uZwEpZoIInsgW1qDZrmuatu0InGdUqJVu4fsS1c7+gIfIK1GJNxgTIEoVyGl0G6sKtI+zk6K/mysqxuFacex0Y1/eF8q16ESrGtAWlcapsG464EWDZo4CvwEIry8IffvoPj1vPE5+fAurvv7KD4gozEFi3Tj9NG/aG27EYmG/pZ3neYBR5vdGPpMRtOk9vdHvItHdTUNtI6bCduhuqungtQWlYZ295cpFHu0h5qVf83SbeCGJ7J0T56ihd7Dyj7Ow5Q5s2VIJ5+QkzBWSAjiOVgiKJ/I0f2VXqYRpmy5OmIaMUyyHb1Rm84FHQsNbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IM9fS+3eFH+Y0ftoEjqZdif/Vns9AsqSwe7eskJHtfI=;
 b=NifO7c68ZOkShMbzME1pMoN2xqbEXqmUbkxdXkS+t+Q5TvI8dwujXUih2jck4tV24Gxc6W39FyoW055KJXDTqDNoCvuanrkRFRnTos/W5Wnvur7CSGzo/uF/Wy800iUoBd1646WHQm8R3cUcUVZaCFQRbMtnDVnP1TIMTzckB+UqITAzeAzf6c5gEZ+IzO0+r/T+J4JF3t+Xs3b3CjSwFVl2Ne9Mtm3v0e6yoilJbOomW2nEgkynM5f1b61ssD4FfFYbgXHrLELGkWFIXSlOd7ihVpwgxAfOWXl3v01jGHe+J0pTK9TYUf+VEQqYZgLjxFHmXE0uaEcVENk0Pq5yAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Tue, 20 Aug
 2024 07:06:26 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::3a57:67cf:6ee0:5ddb%4]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 07:06:25 +0000
From: carlos.song@nxp.com
To: broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] spi: spi-fsl-lpspi: limit PRESCALE bit in TCR register
Date: Tue, 20 Aug 2024 15:06:58 +0800
Message-Id: <20240820070658.672127-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::17) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5005:EE_|AS8PR04MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 42f1fe91-d91a-4e55-3465-08dcc0e69adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fz1ChvTq5WQymET13qCo7CLWT55SzkPFFN5Mw7sPKfLiNWM6N64oY6Ph8D9G?=
 =?us-ascii?Q?TTvPyPAcEqtUoaNayYlWiVIoLYQJYMo4dpDRBQBZMAMItxKE6RlbHS6YjZ3a?=
 =?us-ascii?Q?hSI1RbIITwINcX3HF8Il61o7RIzligKY4vC9Vpdw/A7HOjNYaXeXoUngrW3C?=
 =?us-ascii?Q?Q7i4edZkF98tcAzMGv64iXXnNn+HVxVAvVgMgvV3nhXa7wpkxaQZNgfRKR3x?=
 =?us-ascii?Q?wgMo+jW5xUAQHzohqVDzuyXFWG1jOz4sc3fszQftcpbV40J3FW9apYPEJWcs?=
 =?us-ascii?Q?q0GU/PX6gQ8kJDw8cTQPzDb9hOeNZKNJK2xOvYovh+49SLBL6kYrAFSi817Z?=
 =?us-ascii?Q?bl/w6po1Dp5rXOmERocoJrCYS/vVNanzAv7ODK0fx4FULOwW5iPaFcdfV+Dj?=
 =?us-ascii?Q?wczxZudapkmTsa3POXkCJQbH/wD7P/mJutiG/nlGm/RszILU60HKXBWTMkPy?=
 =?us-ascii?Q?n15MIv7B4/k/OvcfDP1ujMhFtbYwVvqkmP0MPHUkon9wA/nOCSM8UIy1y4A/?=
 =?us-ascii?Q?kOO8BN1DTB8PCXjLyXNDsKxTUOwRUbcf3TJtVZhEnqdMP6atEuwi6ko5VEsT?=
 =?us-ascii?Q?Wt49b/Ago+yWkZvfiagkQG+atkg5UamJf0FKAWArtyvyIYTpnxKnvfw1lR+Z?=
 =?us-ascii?Q?hxx798u2G00J9qa9E4fXDuZwonCdjicJBWDdwYPhMwDMR8jD3j2ZKYP4tKpo?=
 =?us-ascii?Q?y6x+IswlLJ8MZGqy7AgobhPus46JUFrtS7jKl9xI/AJZNdqSejdZ0xNmu+5f?=
 =?us-ascii?Q?6rWcoADwf/Cux0s/8hSVrfcfIr+zG+Kt8Vmd4zz4ICgdPiIQGietDx7eTKLO?=
 =?us-ascii?Q?c0bwrdLLiRkCkysvuZnR3C3QJtG+dwuab0LF75NIMpL5VLFwkeh3x+QTlmJN?=
 =?us-ascii?Q?qfDk0SJFuSLMnOX2ZC3naLLdAtiMVLPPCuLqAYtZRAoa42B/7vMEFFgJIiUv?=
 =?us-ascii?Q?ETyRaosJEiGkxwTkWw6M07od5phq3RbFrRm67UoSyu89nTr6WBRrDm5zhYO2?=
 =?us-ascii?Q?GvYjcNLo53PWWJe+KpCsTELh2eiG9Sudalm62rUrQCtUeng8MQLMn4oZbb9C?=
 =?us-ascii?Q?Q9WJ8m16+OGTUQnE0/rYEpgrTkNEpWozU+l+89Y5KzRzhz6cEkStlqVD9UIs?=
 =?us-ascii?Q?2TY4UhfRtaUo9QSvKK3pjohFqqHCDQ9FwTjCqGp4DErMu+lXYNMOTY2ogvJv?=
 =?us-ascii?Q?HexHdrzvuXD4jQwp5N16owJ7CE0lr3k3C0KPLandjV6GCM8IWgrNfMOLCvGy?=
 =?us-ascii?Q?swwBVa7i3PaJnNDVcI9OKO2k+qpBiTBaqtj3gSYEA/k42NZ/xUlxaamSNE/I?=
 =?us-ascii?Q?xLtgReX7DkpHaDikNLtMC8xRECqxFX62T6rydALbrP1prHcnyDT7E+V7TepY?=
 =?us-ascii?Q?sMwUa7l9j+lA7kh1jTfD/7CpFUSBLaBia/NEyxjNzxQFL7UKzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WhYnwCqjMMlaHbqjjplBFWlZh/65nna3thZ5Q4moF9/zMWo/Pse0QKyzKWB7?=
 =?us-ascii?Q?4N3KnSc1Zb5cLO6nFF0FShNRtrDN7TqwR3MkyLfoASuzTjCDuQYdkkfcPJM+?=
 =?us-ascii?Q?W0pOQiosrY9+kML20i4KFMME9hXTKS3Fm5S0MGmQDZzCyxdETBJNOXjqRYxU?=
 =?us-ascii?Q?JUNKQiQkssZKqhw0hpODlxlZaT6phJULgwRyUm/eWC5AgZRHlZuxC+BIbaw7?=
 =?us-ascii?Q?znWJlbz1n5GJA6PAzmJJlbK+TE0I77OqRPMwYv6BSpfU1vXIAbjQgqfxRVkB?=
 =?us-ascii?Q?n4ytqj5bH/E1LAp42NGOTy4Rn5z23N2XytHvseUxiROh5rOyootC8PmODW84?=
 =?us-ascii?Q?Ge+nPfGB/HpNj2qcbKhlboPCeZKj5GLTf0BvGNaEV+dEL8s3Tu9VG92UYtMH?=
 =?us-ascii?Q?dPVu38rhqfrCzP5mxG6z90lRWwen3lHWOexJdQyggkHUOvVxQNFARkYsuhkP?=
 =?us-ascii?Q?yVlcF2TfM5NYp1EFcRPTbDsfd32IdzOc03BzY+v1lesoHXA5GLpq6bVzwLSn?=
 =?us-ascii?Q?GhPglColR7JmhIVFPIYFlyaZjCUybpy3WSC6OcmAvWJLtDntwCc8oM/IF9qS?=
 =?us-ascii?Q?oBdx++Xb3BjqPu2+xl63Qxmoo8RIvdCWqUd5MbqFUnBF4zhWBnPoGwsFjZmy?=
 =?us-ascii?Q?IZOtZaD90UJB+5TKbVJeaVzCcR2JJYkvfuFtPQNuikNoWZ6q6bcZ8iMGM0Lk?=
 =?us-ascii?Q?a5Sd1hdMW/C6u+urNiIQuRgrao17u0gOn11WPowOGHLC8Fp0sVk/EhFp6NZk?=
 =?us-ascii?Q?Td43BUAu2xMTFIJfWpAJWU8RheRmyOcJPEWYm4i5CWavvhr5ntlnnFxG3bE8?=
 =?us-ascii?Q?eZghXp7fwFnHxhhe4g2y3Ax2dvWWH0kBfvm496CRv7GHVgOXt0UkTmVTLmC+?=
 =?us-ascii?Q?VRNSSnQC4qE48tHkcfkQUERLFkYNNF8HWEV8zLY0WjDGfreJ0CbWEeyqKseZ?=
 =?us-ascii?Q?C6rkDTfOj0svl9mszPHye5/+u5YVZqH0t9P3+6ODum/XExOb/XVkC+7VyD44?=
 =?us-ascii?Q?d52LiylQLc4WUuEVsY9UjQLdANp53ZfZsy2cWGjBiwUURCzMHFxuGRtJh3fa?=
 =?us-ascii?Q?9k8O/OYYm+TE3KBr0Nj03Ed0+yLN4LxwqjpQSsrwEAnjF4U1G4sLS7hhpHZr?=
 =?us-ascii?Q?RGqfBjBd9lq7YGd1nRld4oD/ZYf2X8lLJL2D1Hj/I26SkU9kVLuCVzvQe00P?=
 =?us-ascii?Q?ufeS8STk9/8GG4DDtqd7ZCds1tgyRGAGzte+8WB77F0OPL7GisuYjPCMpg5n?=
 =?us-ascii?Q?jTbpJDqkNUgJwjDb5Xbu34FH0WV/bD4MomKO8uvif/fUUmwnEGbFHnyVDY7J?=
 =?us-ascii?Q?HzhdSfljzfDHtW21E/fkpf1dmOSs6s1PiiRL+dStexglUCuOc8xTyKZ1pQlO?=
 =?us-ascii?Q?bTGu8svOS4rdm81vORDXGNET0kFnS+sk8bjrCodTQQ85lGvq12dJ+2A/9NE7?=
 =?us-ascii?Q?9Bwxrr/yLOcP0KZ5fBOVwp8r4HUgWSZeM+J726D8/+SEhyEc4WX/g/cSuJec?=
 =?us-ascii?Q?2uRFEsG3WTEIHMjnUDYpE0cE5jaPrEK7xpsakWAiDY1d+VRzdKEWpiV8B2Er?=
 =?us-ascii?Q?9Ck0l2x8l8if8EaR7PAzzDi1dEYs7vAd3G1luhRv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f1fe91-d91a-4e55-3465-08dcc0e69adb
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 07:06:25.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ji93yhnAddITOVkR/kskLsUhgoV99KqiFv3CvTlFYShijVR88bTxKS2lWxwXWDBy2kJL+uECapKXXB+39s5Nkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7621

From: Carlos Song <carlos.song@nxp.com>

Referring to the errata ERR051608 of I.MX93, LPSPI TCR[PRESCALE]
can only be configured to be 0 or 1, other values are not valid
and will cause LPSPI to not work.

Add the prescale limitation for LPSPI in I.MX93. Other platforms
are not affected.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index be261ac09df8..350c5d91d869 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -82,6 +82,10 @@
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
 
+struct fsl_lpspi_devtype_data {
+	u8 prescale_max;
+};
+
 struct lpspi_config {
 	u8 bpw;
 	u8 chip_select;
@@ -119,10 +123,25 @@ struct fsl_lpspi_data {
 	bool usedma;
 	struct completion dma_rx_completion;
 	struct completion dma_tx_completion;
+
+	const struct fsl_lpspi_devtype_data *devtype_data;
+};
+
+/*
+ * ERR051608 fixed or not:
+ * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
+ */
+static struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
+	.prescale_max = 1,
+};
+
+static struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
+	.prescale_max = 8,
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
-	{ .compatible = "fsl,imx7ulp-spi", },
+	{ .compatible = "fsl,imx7ulp-spi", .data = &imx7ulp_lpspi_devtype_data,},
+	{ .compatible = "fsl,imx93-spi", .data = &imx93_lpspi_devtype_data,},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_lpspi_dt_ids);
@@ -297,9 +316,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config = fsl_lpspi->config;
 	unsigned int perclk_rate, scldiv, div;
+	u8 prescale_max;
 	u8 prescale;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
+	prescale_max = fsl_lpspi->devtype_data->prescale_max;
 
 	if (!config.speed_hz) {
 		dev_err(fsl_lpspi->dev,
@@ -315,7 +336,7 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 
 	div = DIV_ROUND_UP(perclk_rate, config.speed_hz);
 
-	for (prescale = 0; prescale < 8; prescale++) {
+	for (prescale = 0; prescale < prescale_max; prescale++) {
 		scldiv = div / (1 << prescale) - 2;
 		if (scldiv < 256) {
 			fsl_lpspi->config.prescale = prescale;
@@ -822,6 +843,7 @@ static int fsl_lpspi_init_rpm(struct fsl_lpspi_data *fsl_lpspi)
 
 static int fsl_lpspi_probe(struct platform_device *pdev)
 {
+	const struct fsl_lpspi_devtype_data *devtype_data;
 	struct fsl_lpspi_data *fsl_lpspi;
 	struct spi_controller *controller;
 	struct resource *res;
@@ -830,6 +852,10 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	u32 temp;
 	bool is_target;
 
+	devtype_data = of_device_get_match_data(&pdev->dev);
+	if (!devtype_data)
+		return -ENODEV;
+
 	is_target = of_property_read_bool((&pdev->dev)->of_node, "spi-slave");
 	if (is_target)
 		controller = devm_spi_alloc_target(&pdev->dev,
@@ -848,6 +874,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->is_target = is_target;
 	fsl_lpspi->is_only_cs1 = of_property_read_bool((&pdev->dev)->of_node,
 						"fsl,spi-only-use-cs1-sel");
+	fsl_lpspi->devtype_data = devtype_data;
 
 	init_completion(&fsl_lpspi->xfer_done);
 
-- 
2.34.1


