Return-Path: <linux-spi+bounces-10811-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3C0C046C7
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 07:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D24C4F82BE
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 05:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676302580CA;
	Fri, 24 Oct 2025 05:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NywJJKn8"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB7F239E9A;
	Fri, 24 Oct 2025 05:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761285025; cv=fail; b=TpKVBCjNC532hdOTziWu7rt759A/o6OdhIFzoCUSc4Zt1u72YK2ga8U/641W23U1QWHDqcz4qBBuQa9VgqqhIuT07F3mNwCNgmoZEH6H1DPtmybZWDcpLuhb3zCl8ezqrgmpl78ClhrSXEYzWOivd3m5kCY+Iq3GlLTa0DtIQ58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761285025; c=relaxed/simple;
	bh=4kC3iSXYKHCT9OMxd+/Mjo+uscgQYXeZPaf51bbHQ9k=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t90CEPYPI4xxuGQrC4hLO3AZWOUfMKBKqwDtUNYpcJbpD2XgDiEXHReiI5/tsM2nAXeKIRfWSfJGRTd07S8ydWExIgkGpG60BAkdpNLzfxN93DADm10F90773LCwCq2XqzHK00A8a5qdEc4QrEwe3ioNTpoXnKk3SowB+jShrO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NywJJKn8; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afJKOkykNmOEETd/BxeaHj2g3aAi/nvTWzCBm/m/Zfd9yE9CCbZsKgO5b89dCMlJhaCZiDkF9xrM5LkFNEdCdw3N2gBo9STqkYUnQ+z/r0wtHqW5bOlkz7FQB/5lZ8QOn7s+roJ9+dDrqQZnNvgNl9+6qsQVkVf8R1gLlIc6D296XcL76gXfpn8f3+4vNTjkTZxqSWAtdqxFsgTHpG8KwWAtUizxSHwDOT8KLc2IOFacVVtVeQwLLj7bRJLvepj7F2ZjXXoMp18BP3ow7Bw+ADiCFMj6/18u0nvpGc+Q41o7wSx8WH5f+w7kRGS2jfD152Wmwd1vNrbutrYOySKmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rThjEDLsddPcdAKS7gWCVd7WUc1FhoP3gX9woXFZcAs=;
 b=VnG9NrEjSdNMcdaby4tL0722k7VKfsK9DfUz3latONZV3RGt2OhTpd3aomkOc3U0qRf/RVEaKolL3Haez5IG5ksGmyd2zMN4s/+1N5I5XIaRX0mTiqP+p9Vp05RGTXCT1nu0MIzCMcphuxtPmAs+nTejUAYx95WKkcC3xz2dCif3fJ4hPNVewWdOGymiNWA0VGFkK9jiamUQKw7IG6fVvZdGWBYffIg7gHu/IJbcuRCz9xhhtxaHsA0aOnXhz4Z9EaWmPWH0/P607mY8fY3csihaNpd+owRSj7Lh7anjU8HjD7X34IN2Rd/BFk+5JK5q3Cm3anp1+zGuCMk95H/qkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rThjEDLsddPcdAKS7gWCVd7WUc1FhoP3gX9woXFZcAs=;
 b=NywJJKn8kdHuCavNjHtsPMqF5R6wKGx769SnVURm64ywGgHgfBFVT21zghXNiFg1z/jQ83/R+I3AzSmvgJP0gc++r+25lkZUd65I/0ZtSRRIlSAhi9sUa9GLZV7kzTynBVtlualPqaUdTX8/zqT24r2oxbVUfO08mFZkLgVrtT7Uecz7TU72Al7eKoBUibhvr1H1FafVWYGJgxE5l/eq3+sdPnsAOY7JcxW4NzTangSZ5FatkiUG2+W+Heju9Ym8bwnHdOcNNuGGtHLT8Qs2cYM23w6CUtovgEDNvMk8tqPP1R5tnfKdCtIWrtg6MAAmyCOpDKngu7GYmwpSB01FDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA2PR04MB10123.eurprd04.prod.outlook.com
 (2603:10a6:102:403::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 05:50:19 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 05:50:19 +0000
From: carlos.song@nxp.com
To: frank.li@nxp.com,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: add 16/32 bits per word support for target mode
Date: Fri, 24 Oct 2025 13:49:52 +0800
Message-Id: <20251024054952.408393-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::16) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|PA2PR04MB10123:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a3b1db-06e6-4ec3-0317-08de12c13696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evl1SXogNvyt1rl5wIv6LyoIsM12nArgRsOu1suvubWyRq3Lhe5AYr6Hq85n?=
 =?us-ascii?Q?CpxfTfM7FUTVZr5VRe9yUP9fQk+NzZ5RHEH3s+4kkkFNXwhRmEPs7FZzH5HS?=
 =?us-ascii?Q?L6k64QuxeVfr8Z/8ZQPthTBy+wozd4BaQglEkYQ2eClBGqMV3Ktk31wGV4+w?=
 =?us-ascii?Q?G0clh5SP/mfzkbwFP+W0pjYTc+XghvU7ZY+tCU51IsuJpJ2XCA8LKtdpNVW9?=
 =?us-ascii?Q?xDkkdVLiwbwfbl75iofTcaCLpF7UY2aWUoyX/hJ3iEe3gSPqvv2Rwb68ASEF?=
 =?us-ascii?Q?XhyEWFGTsgMlUhXOB3EhyqLhDQc9GwiEqGyLzcsTDpxPFkMTB9dMKc4eBaPo?=
 =?us-ascii?Q?bTAkQt+PzruRBMcLuNREFytFlAuzvpzC9X1YW3Ac2+564yIjGJW1ZUclWfe5?=
 =?us-ascii?Q?127XIQml0y3LvSH8JbHarGA0AAVc10TzhBDhTTpGrGHu32wDQrPgbRTTbpfW?=
 =?us-ascii?Q?fTtDb111sl6uJHQ+HWYTmRUbEeJb7foFY4vPmULSKUe1Qe1809C16gISLoxa?=
 =?us-ascii?Q?uR8vOAxPcLJ3owva2QEh+Opi6v/kATAlsin5BMBkXx2ZgbD0bDCp2WesaMWt?=
 =?us-ascii?Q?kQ5t4WzjjEgW8HjE0hBqS5YeTAwoBmOIC5vVl/M+hddipOrQMUWvCgpHBX7k?=
 =?us-ascii?Q?RNn2eIU+uM7l4HFHpXOJRKK+00/O7VtX9+XlxCirzNwgPU1aMIid9mcuyDBi?=
 =?us-ascii?Q?KoiXv6OqROJbJ0eXCgy+vbDJkLHUoMMRuWkr29tx3Ls54UaH3/tge/CbFYXk?=
 =?us-ascii?Q?ehNxcvxIy7lQwXA59lNWrPV+uctPIBkZJwrRDeR6adQp4qX2HBzu9lp0oi0o?=
 =?us-ascii?Q?fzXqk3dP3Nqj6D+B9TKUHXSHh/Ohrdr+UKluoePTaJ/XpDh3PAMGgUlN5Bny?=
 =?us-ascii?Q?CMUFW4tWMasuVpqe5uMcunNXWTqR0TBu/jYd31gpnOf+dpFDFmu9DVdHH0eh?=
 =?us-ascii?Q?kI8vR1OcHRd7feTjGUPby7tHMKO2d5Z/uDLspdxjyGXShVI0BrJBzvoG7wYo?=
 =?us-ascii?Q?pJBGu4INXMSia4aYvE2JHsnfk/30UZgICvYsuq5NZqYH8+OSg3DPVKDR2h3C?=
 =?us-ascii?Q?ilWLptPOwXfpr706EUV4GuplfPJjvMlypgw0TnrELG5S5h1Hv8caTZYJSw0e?=
 =?us-ascii?Q?ipnDeGqdQdRXmSKIUCdQrr0aMic4BNd742KooGzgLn0JNFXlGYZXjyxKkq9w?=
 =?us-ascii?Q?+mgMB5UphFlpnx4RWmI+6HPKKoGqFRdmg4N4snF8PbFGlzSkffNrs1pRmDmx?=
 =?us-ascii?Q?FM3mNLMbZIukP/b1wdDrx7VHWcwsMqPCxx/H8frx9WpUptwSL7z6UjBTKRNA?=
 =?us-ascii?Q?xvD1V+8LDCLQ+eWMQl2dSbQQQFVsu57VXk24jwBBFqRG49zX+dFFrbtH+yN+?=
 =?us-ascii?Q?Z2ZNSpvzSkNolo4YyKRBirsNY2fv1wjJn1gILFcWF7OMmmaarYErBZk+7MHL?=
 =?us-ascii?Q?LISfR9RS7/LCS4jSd8eYe6MtAj7FHXkI0le6/vKi0x2EigU+BTQU/ooM4oFw?=
 =?us-ascii?Q?FL/l8TVhQNUey5OrdlQ7c7x3SCl8ovTuU7Cy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QFW6+YoTHCXw0NMrZCaYPyIi8kxHQhkB3Rvz/ZYA27bC7y5r3pjoTPSYI/9H?=
 =?us-ascii?Q?f47FiFNJ5/TQ4JjvW6vLERfkoTDpc6PeOiPnDTLUnyVokDkGLwoYccn8n/LL?=
 =?us-ascii?Q?E4IlDZcLWx/LSax4JLuqkcRtdSTaZiglmnrqKSQOcqxYl6pss7drpy8Pc40o?=
 =?us-ascii?Q?pegrN6ncR/84ZZqyDgDPIYCEetuQxWsC6MU5sJpAZvvgJKNGUlWt3yV3lkuH?=
 =?us-ascii?Q?8IdRc/1IB4vGN7gNUDLHCB0zCXXIC0oPrwe0VzRez81LALl1EoClGH3gFlIK?=
 =?us-ascii?Q?2BsSN3HO0X/b0/XN8x1GFhWO+nnnRDwMz7/nbSbaMIHFnGOQxEnyg7ZQ8N91?=
 =?us-ascii?Q?ilVr8Bu9yxqew0x2UB1gumCIscYA+CA+2EPNm9B4qGOSFrNdaKlmKeqq2ISh?=
 =?us-ascii?Q?0RF3oDNgttEoPoICpLpcexMAg1dK+nXAKgxuAb0yQ+nkKUBgYvzF8Lz43YID?=
 =?us-ascii?Q?I/xK6NLSp275pL9h/QwP8OM00fSGmhiVwE0X5BFMSlmZ+0ULZFZD+j7uX+nd?=
 =?us-ascii?Q?Ja+IFlU5yIV5068ucyK1d4vQB4tDuE91FdDz+jyiUAnifVT0EMgF1vjSpgoj?=
 =?us-ascii?Q?u2Zf8KJSS2EkxojsY5c/6c28NVjwITT28INgpaHmLLgFlOMqXR91bYAwpUcx?=
 =?us-ascii?Q?NmxAUcLhbp0LAWqnrpqKFx45Diz0jKRgpSMuI2OdRjcS3GIKabuI/V49WS5s?=
 =?us-ascii?Q?HDQwNBBqPV2cmoTXXceVCtVdZGYbtIqd2JaIsYVpjgRlDk1oJm3zcKIm1SG5?=
 =?us-ascii?Q?+aAwOc/rCcgV814TAqxL1jKL/LTJFFWiMSUyaE90ygDirC4EdM2L3ooUpGFD?=
 =?us-ascii?Q?xU3jv4laLzayVG7n1bRPKrakI1mg8j1TN6VcTL8Y62LietBC9OyH1TJA5IIt?=
 =?us-ascii?Q?uM5mUjadHCgRZZ9XxgKg/kdjndrJFNxWbuZqgDjDKcW+Y8jeY2pGaKGHDpk2?=
 =?us-ascii?Q?uXV1dyyb3kR2HeV3cS2eof0RmRGTvxYDTIXIAQuwHe00sLdRJ4EQ7rxk0G0T?=
 =?us-ascii?Q?qCQlAEbR/JAfwjWL5hdmyRvzK53QzmAUe+BONxBtcU5ZgtpfRilu5uHEmWKB?=
 =?us-ascii?Q?dYJcQMvf7fRjlr0FZVzaxJ8cv4ZUu8YD5BVZrPxb6eDodoQjrvYGamf6eHOF?=
 =?us-ascii?Q?ZEpERuBqmCtUAPiwbCOgxf0SW8uI0wzyGwEtSzyVnwj95CZW3I5Q4hK8cxro?=
 =?us-ascii?Q?Kn59hghWuMK4VnBV6eDC9hML+qP+9xrsTLrpLyt8k0AuKHd1bO6dLQ2lnK06?=
 =?us-ascii?Q?qtnUaVvmSPDUAm+ngLAPTSdzdwsXq/2BF0YZVtcifUNNV2INhuIe5+3qYPTW?=
 =?us-ascii?Q?JKvuJYYtOBFXQTkqWUqGSBTKYNeXY0zynEIlew8RC6vT6IxDPL1Tai4U9ljR?=
 =?us-ascii?Q?JZIYqtci+dHr45fFmFgMQbMI3S98urIJuj30DDJSBAp/mvjFO5Q/XIl1MgLL?=
 =?us-ascii?Q?vxfK30OCubi1rjTt/1nDTk/ojkqlM0pXOgVloHvVf75yeOZD7kU9Kzhw+IG0?=
 =?us-ascii?Q?ngExRYX7Yl0QCNnMJ7VWqWSx8dHQ1etsqsTLJmP7goKdinP569ayUExVCH3u?=
 =?us-ascii?Q?3dz3qOallrXKwzVkLBnos3i7AaCubUOvYvd9EacR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a3b1db-06e6-4ec3-0317-08de12c13696
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 05:50:19.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZ/Ip0HqqZ9fYjNjqiSTD4JFBd6pmjv0S60tT//jboXyV27bcT+FptHBMcmfI/vu94A4lTABZCer4CGVt61XCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10123

From: Clark Wang <xiaoning.wang@nxp.com>

Now for ECSPI only support 8 bits per word in target mode.
Enable 16/32 bits per word support for spi-imx target mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-imx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 155ddeb8fcd4..4ffee6c5d5c4 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -424,8 +424,12 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 
 static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)
 {
-	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
+	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
 
+	if (spi_imx->bits_per_word <= 8)
+		val = be32_to_cpu(val);
+	else if (spi_imx->bits_per_word <= 16)
+		val = (val << 16) | (val >> 16);
 	if (spi_imx->rx_buf) {
 		int n_bytes = spi_imx->target_burst % sizeof(val);
 
@@ -453,12 +457,16 @@ static void mx53_ecspi_tx_target(struct spi_imx_data *spi_imx)
 	if (spi_imx->tx_buf) {
 		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
 		       spi_imx->tx_buf, n_bytes);
+		if (spi_imx->bits_per_word <= 8)
+			val = cpu_to_be32(val);
+		else if (spi_imx->bits_per_word <= 16)
+			val = (val << 16) | (val >> 16);
 		spi_imx->tx_buf += n_bytes;
 	}
 
 	spi_imx->count -= n_bytes;
 
-	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
 }
 
 /* MX51 eCSPI */
-- 
2.34.1


