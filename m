Return-Path: <linux-spi+bounces-10820-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08687C06088
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 13:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E577A1C24FD2
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 11:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19BF3148C5;
	Fri, 24 Oct 2025 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PATCronU"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868FA313E3E;
	Fri, 24 Oct 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761305497; cv=fail; b=oAFuVP4fz+Avre8DPweHU0OZcCtO3IngP0VMTgoSxbGjvOhLWBphEUf1rGRFZAvq/aDK8IxH2YQ/snnlKhYJ75HTcOEVoKEsw0Rhj22UmAdf+MlAy94FfaCeZNsuB+UwP25Jv9WqbfptaWR7QL4GbfVaVGBUjTuLIxR0Pxp4KP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761305497; c=relaxed/simple;
	bh=JDSWD56zEXSSVPlSbbpW8gMuVK2gsrT6gt9tvMIcy3E=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q1Ozpc9wjAt8cADpDI8/8InMfVUYASPecsgiI+wYtSCeeH/H+mSpC6uxCF1PzuUYpAGcIHg+MVeU/l4Tt0QUSq7ZgQrqhgsdthyfp3BLO6xIB4Ro7TKSgnsMiOUfmwy42QIBsS/IH+GPv09h5ZMH/umTVRMFDNooQ/7KwwFeLvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PATCronU; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmg/VJjGttCrH0uHPb9Z2BRfFyCHLUM+pZyJCfymVVtx5O1B7GSeLX1/CpRalb86Bfr/yVNU00BaBFI0J1ledb6m2sZTnaotvmFtZhT9kjXu7Tq3VXM+b4O3HESrjyYKWhDfH9V9WBrCWcH8YCaHWj9qspyqsi1gj9FRmlXKR/sNVaPxc/MW203aKLrax1b/2emOEReZGtJZqFow2kpxkxRWyP3r4OjNH578GE709KHzKfzUH/cGqJjsKWPSuuAW3cnf5Xu5dnxCX4Q7hytgM0INbd7ollhcKkkgQI3VORkL2A8smorRWyo9VDLpbVoyg0uoqqXanRxB0eq9gfcHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zifqyXgWpynRb/R2i8u8iGNpv22hRnZMacIBOExAgMY=;
 b=HVQESNRd8oFX2taECKEQTaZDjBllo6f2OmvpZ4pRvTZg5xnolWh4FhPkK7IepnAnDA05RZ07iO0Lw/xIVv5iAE0nZ2otN05K+8MFXVvncx04wt2QZk9h3LPKSVKbOR6p6zI2d7RILQZamXq1LBVod6vteIcfgl9Ks5udjTqoLD83nfGaRtFqgDI+a0leSlz9Ypl+IKZWe4xEatlOXIvBrJjtbzbVR1ULP3ONrXChjI0OUyxBx6Mo9zqS2Lk4OSMLOXFhFFcJuNeuJfwAYai95prhoDeGsrzeri7JI3DNaGa10Y4jcYAJIA8UeOpi0lwJD04skiMnM9lamMI4BRAqIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zifqyXgWpynRb/R2i8u8iGNpv22hRnZMacIBOExAgMY=;
 b=PATCronUPBwB9osgHiZp6jL9dNDqmh1kotCbj5Mil7ncuXOqB/FFYFdj+EBYxzO7Qm6UYxEqJ977losBHdiGyIVyM6tR8gGjL95tjIiLqQ/DXiegS7UNZZBBc14KusriNyjDjMleMk6ckfqugtNENZCQgqhx1rjMPzOnyNxmxLERCeIkhri4fFHpddJ0NVw30bmtfUYX8VS0R7ejE5Yteb1/M2RJpJrWLBglC/gOmcqr2w9k8a+a1p0YbBL5eaFsrea8MLvitPZtjgSEk3L33PEn2shjmvEqFDv6lyBo+LJESN19YwQA/DSDOtBiYE+WZDuekQVcADHML+F4uZxH3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DU2PR04MB8598.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 11:31:32 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 11:31:32 +0000
From: carlos.song@nxp.com
To: mkl@pengutronix.de,
	frank.li@nxp.com,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PACTH v2] spi: imx: add 16/32 bits per word support for target mode
Date: Fri, 24 Oct 2025 19:31:07 +0800
Message-Id: <20251024113107.513604-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0057.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::6) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|DU2PR04MB8598:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5e2bfd-17c7-4de6-cbb6-08de12f0e1a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bc7O/MZHOwR5A/Ndqc9zkGSTrvAmrCGX/CiYN2WKGDzha18S5SyRMFc5kWYt?=
 =?us-ascii?Q?g5c0tTzEU3Evudm+Qa6zfQsdT3EjgjBbnV+E+eFTrEU/4VJVoqEjrgrUnNyQ?=
 =?us-ascii?Q?nUuYDX3xF/Eh9ollG9kjYCYvVI+Mfnb7TqN7vncLS6H3wM8yfIbXXJccYyNX?=
 =?us-ascii?Q?i6AVFfVIC4BHhni1C2cXLjDzaGyf0VW527nUdFE7fWPJqArREROx+DzPVFf6?=
 =?us-ascii?Q?jd8SMTf5IMt6Em1hR0Z89hyYGU3qngRFR74VbtoRWcBD539VE+rqumRrBDHg?=
 =?us-ascii?Q?+fNzM5VIZwelayU7S0WBw7WmB1/yfPZKSuTROywpZJwn6yiTb9Pr8oVIO3Sc?=
 =?us-ascii?Q?PFIOKPiFsrsuzasJLRy+R/UlH3/asVps20JXs5d9Ys+FYf6gDM5sEjFyC7Wq?=
 =?us-ascii?Q?Qt6lI2Ull46bPRhuxPERBsaaNuzYGZVIUxNVv2BQOwiDpN7B/0pbV9YZla3b?=
 =?us-ascii?Q?NsOx+lte1yMwiwBW5IKChnrDJbJkChlBvyw+w1LzqV3IcxvRoOpqJ9e2+tHX?=
 =?us-ascii?Q?BsqPI0zVi3J5xAtTMVqaCMiKiW5vqhg1ysWv8lPBSVHXPxeJUbsZGdmwENUW?=
 =?us-ascii?Q?TKLU3DmNhjz0ijuDNGDXYJpxsPR/M5+Dj44Xs/BIRiR+aTWhzx4woMRuuYvR?=
 =?us-ascii?Q?VFbPxOyDi5Wr27+9nZ6vZdjOcv5cn/BzyV+dsINOVjqyaMtzEUKwl5FuS+mR?=
 =?us-ascii?Q?Jf1JyiSzQaObenKz74uoGdvWLesiyWaQKKF30u9UG3mxMbSrZ6NkitFHsslY?=
 =?us-ascii?Q?dVHMbOgpLxXMa1+iKWtiDCFkKDNoj34nLKF/MZr+5Btl70XCzbGovzX0aPnO?=
 =?us-ascii?Q?9qdKmD/dtx6NR3+Y/L1eT1jGNggBdqWHozbZQXm9GBpDxMcL3wLfaTFpQS3Q?=
 =?us-ascii?Q?o2VtvEULZJKGLibFhND8brRTg5hZcyREZ5mD4h6wyZyKuvEPplvWYSL60duA?=
 =?us-ascii?Q?n3woD9Sx6lEqkNBd7p11NfdZdgUKWJ5v+N5yUWi3E4p1xLlA9+kQZrCu/dDf?=
 =?us-ascii?Q?Jd3xrSIPPGXJR62YFVNi5q5O4TFz4RXMrK6uVPeSqIW9nenbEnW/Mpl7svfx?=
 =?us-ascii?Q?PNsZMY7C5Q57O7YbTRLxI1BvVpBjpGGUgaUDfFP+oxmy+l2eajNXd0kZMidk?=
 =?us-ascii?Q?t5RGGhfEN0JDMO5H9D0w8KFgXs4nc2O+J9qH1XIQrxD4Tof7QQDfe7oadL4c?=
 =?us-ascii?Q?bzUX72/DWKaCaV/GF1/e69PEvGY5a4Gpmyl06mRtzI96hjay3lgZlQXJYawu?=
 =?us-ascii?Q?bemrXAqXUsiSbNTMULuUxmRFO/gzQa3IJL8RJYbB1fmtxZ8478r9ih1Rt0WG?=
 =?us-ascii?Q?0SaA56UaNq6L+nFmfDy61l+AJn7mtTaKZUk+EaPuQ3htF4YDS86RBWqEP9nY?=
 =?us-ascii?Q?2gLKreI3DVuytWXPd9SXD94OUrhSY4MKuXAYE13G/tN14QmkEsyyUD1aa/b0?=
 =?us-ascii?Q?P30WndfQ+g+qg/woyz/PU7BRCVDHZng5kqLLgqSrv27dVWtCUQ5wvCCXklrH?=
 =?us-ascii?Q?GahlPTQPt0opF0c6rBjCxQHlqZcjgIuC5Ls0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+9w5yKWzIHJBB35zLL1NIdbNW4WybPhjPVjDTn87zbx0lqM0jL8sp19l4y36?=
 =?us-ascii?Q?WDeMyctzYN+CY3/70zI3SnhFJxwaYOFc/Aef7eMi+vSjHiOsja9a3RxG0jwR?=
 =?us-ascii?Q?NU6Obc5Wk4hFrAsDw6QBPQxrOvZQ4dqWQ5u4lJxJKXHUay4YwmsSjpQVr2Ju?=
 =?us-ascii?Q?vU+iGXVO9EgOtZr04Nn6saLL2jzlCEGN7kN827zlA1Yi2vFZ37Ctq9irntpr?=
 =?us-ascii?Q?lL23NhBTBoi/49/iim4jORySTCMl9kQZZZw7lig0V+juLZfu6DxLho93qccd?=
 =?us-ascii?Q?ROJLjw4RgIt+Xk4tH0kslnyiUWRMIGZPYSsz8QGKTuCpF6oxqsJAdqhyJ+3t?=
 =?us-ascii?Q?oYejM8DTvFpcWSP5aQ7yhR2JGJ2/gDQog2DYkwBZRWUyNAlts1U/+TT5NbCI?=
 =?us-ascii?Q?5zGbxfoHrjcuQIsTt7SOGT/A7HCxkMJZYo+4xq4nKRAcYrgGPFbVAj3uD5bv?=
 =?us-ascii?Q?J8f72Us6RCv334DGGR00yvFxgKAiu+PS2P9Xt5yV166i4HqveOGZF3pWUzZg?=
 =?us-ascii?Q?aTAy5KWYeWYVHFG/n/llt+KQYqX9NYq/scWTBeaTWFyXTQhc/BGSSv3Z7aRv?=
 =?us-ascii?Q?HZNwZKoKu57PnvcHPc0OX4l6jpvQa7qxso1Pc5IJK/2CwaOti4qzZj0dQRsP?=
 =?us-ascii?Q?rSdDJSITSbhkeJgson8pt18/s7iTSQYuHdqH76N4eFHqJ5wFbm6Pj8fhyfa0?=
 =?us-ascii?Q?hftHfcoC46so7FeukQqn1hfnVucDWeExD7unxHm/OeGn6Ratakh3N88iecrr?=
 =?us-ascii?Q?Du/t2N+KyIqYM/m3NTudrvjFWTxgwCXp837+2J/rNGhufsRFq5PrmwkZupA+?=
 =?us-ascii?Q?cCwVTHirHYhcWQ0EKslry+a6lWduB1MnE1Pn4gbOyM49/cq/Jbq12Uh0Yelg?=
 =?us-ascii?Q?QRUd1qTwvrJ7XAeAWU0frt8aPPhy1JziIXhdRc7yk/1X3+6ULDYCuFaE7ADx?=
 =?us-ascii?Q?EKu1jlZzYpngoNLWAP5tTgtuUSrN6JtSc3RqUWgwx16Sy02I4dMiANzsyyHu?=
 =?us-ascii?Q?5pB7+ARv2A5ON/T3IZdYXkmUY49wGATDSwX62vRtAHIW8ikdWJFaERZnfk3r?=
 =?us-ascii?Q?kweDsqsNBohJ1UrUReeNRpXml3hI3CMxuQQC6YT5HGQ5Tx00UteI+7L/AWC/?=
 =?us-ascii?Q?7C9HA6nkK3jssQt/uwT3FxDouvbdsoHprOHMxz3IkjAmLWHKKm3bw3xo71WT?=
 =?us-ascii?Q?FvM5qtAVCOzFsvcoNoE9ROH2XuVk9YT8VkhjvyrYpoxFP5kVURI2xZqkyNs/?=
 =?us-ascii?Q?iz2ufo8lxCCABXS5XI5b7YQd6ieOgaKP7476If2ExdMQxawfaVlz+k9L9BNc?=
 =?us-ascii?Q?qm34FBA/jspWqyO/SGMUUfDhv3NxJcSVa2/v0wnDWeRmxwO+8d6JfyiGqdQJ?=
 =?us-ascii?Q?zlOvYlwiHN9FgkvMbnDqOcwKhs2JgEj85ObeHOYiz4Z9u5v1BWti+vZFpIvY?=
 =?us-ascii?Q?Nvh6APyoEKHnjtVijkbCLa1mcG3UFag/XinQtmlKCUUM44xTPIY9TYct4bp+?=
 =?us-ascii?Q?cNj16fAr4MkNFeagQUcelTdI3gw8TfiqoCx9gP3ydN8uU0eX1l3HdvMG9I6E?=
 =?us-ascii?Q?hOlta0D2LUVcrDD/MxHZJVnyFUsfjy4zxn35r8zp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5e2bfd-17c7-4de6-cbb6-08de12f0e1a9
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 11:31:32.5032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqGC4N65ivUCWjkwUMI6i5EEdQFj2caPXzxCpGLQh1A+d9G29nkUBwtfIJzk4InxJ/OV/1C2B+OLMj5lLSmWlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8598

From: Carlos Song <carlos.song@nxp.com>

Now for ECSPI only support 8 bits per word in target mode.
Enable 16/32 bits per word support for spi-imx target mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 155ddeb8fcd4..017f83f5dfdf 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -424,8 +424,12 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 
 static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
 {
-	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
+	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
 
+	if (spi_imx->bits_per_word <= 8)
+		swab32s(&val);
+	else if (spi_imx->bits_per_word <= 16)
+		swahw32s(&val);
 	if (spi_imx->rx_buf) {
 		int n_bytes = spi_imx->target_burst % sizeof(val);
 
@@ -453,12 +457,16 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
 	if (spi_imx->tx_buf) {
 		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
 		       spi_imx->tx_buf, n_bytes);
+		if (spi_imx->bits_per_word <= 8)
+			swab32s(&val);
+		else if (spi_imx->bits_per_word <= 16)
+			swahw32s(&val);
 		spi_imx->tx_buf += n_bytes;
 	}
 
 	spi_imx->count -= n_bytes;
 
-	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
 }
 
 /* MX51 eCSPI */
-- 
2.34.1


