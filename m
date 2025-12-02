Return-Path: <linux-spi+bounces-11712-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADFEC9A983
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 08:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2998D3A7972
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 07:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 648EE305E08;
	Tue,  2 Dec 2025 07:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eArAYRGy"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013063.outbound.protection.outlook.com [40.107.162.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698C306491;
	Tue,  2 Dec 2025 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662186; cv=fail; b=D20iFPQQQI1055vvxpGHXAHTVZUySGrK0VlT4r/SNmswYCINk1tzZWPb6niTu2TJW8//T4cmLG5S7Bh+6/4SkGA2mrIn1dEEIXCFo0Gg5UWC6aWlfsH5n3G/akXrUFycZxM3x/PvsaDF5aB5ne3je+BfnsRPSiRQoJnHEPOqM3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662186; c=relaxed/simple;
	bh=Mpz2OIgrs4/t/ylG/dc7+6JtXkfDbybQ6lRWAcfp6EQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JpYa++Le0FO5E7vbaLdv0DSSjBuI1Ll6e2CdeEOiAHiE5+Ft/tLkvA4RbvJTfOClGAWAPukrAKkCapJzyPm6mM4K+tfRSyy+hyD6B03tCRwfFjhLhnrqU5sfC1nwwKSDHgieXLuwoMcyw1PQECPvvVaCnTueGxSswzm+sWbyRqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eArAYRGy; arc=fail smtp.client-ip=40.107.162.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u45WmZ+UvcAM/liGMqTLvaNtkDL/T4wHLYOZtmSbkDiHAtIKTxUiEwTgOWyrq3fNa6w3eApHQc0GeWX8qA4JP4ORR+yiOvZG8BVfkYouEmQdhWUT9j4/KGcES+oF/9rB5LESvcksJGwkzIjntQ7YSv+t2oFHqqIR26+vgIqfHxXR0QGUQlPkMPpi0w1hdY4TnXRC0aTGpOubjqgdwnacFva6hzlThNHjHT3+oW1KJXB27aD7TjhlmzB/AjJC86WMM2qNaOK8yoi5MjlomH9zWBCk+8AZXmSdIVT4gXt4LaEqVnwokrrQCMUnnNtZM7KjUnP+73nvUQzUsW8/tRO+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjn92W/vcT6KJHTdltkE2l/+CUit+h35dfkz3Rn6KCU=;
 b=VwAnSrURhN7OxXXPmWV7p3BUysZqYGG2mYyTqysFKn7dPw4p1TM963anCacOXz38s5JQp5q1zBlRWb1Y839MNKXMr0XJSrqptD4f4KxhR/LTiL5KJ383J6VVY/9lokc0I66ex+FZaqTkZ1cqHm4rqLh18nJsW18inwBPaXEEWXHV4rme+5O/ihJbIC5EpBUa7XDwasiRm/Lk6R1p58mPCe0zveqG+JT9GWs8kh1fu+QNZetqh0VZewh8yz2kr2jT3KhJVei4WZlgQ7GdseXupNJkj4znB49K7ttjsJBUbwC4A09Q4M/F429kQMCGGeII9CoJLg7kGlpc0TSZFQkwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjn92W/vcT6KJHTdltkE2l/+CUit+h35dfkz3Rn6KCU=;
 b=eArAYRGyZKUVnalSnxm+e8ddKD93FIZZQOk27fJgnOl4YAzfWjwsS/Zud6pNtYvmeWZMfTCXkERaTXvc7DVz5UxGGusDcgstPxjllBaxuiSDAJchW+AOYI6CmXjxgaIPoZtaOIBS0/cW3LKQnhWHksDTVPkVGimNFzGvom/GuBqMwQboeWil/CrcyNEvpKJoWDpGOx9ijA+a7RRVU6zRkXtdXyZM0s8Lv75aU6JSYaY/A5j6ekRH6LkqiTGjXq8J5orbwVkUhPiF4ROZNcfGVJaxW1UUe0Dpa61Wl6YFKesetodoXyxk11Bq+vXhhyLeCyFrzQmgTHrIbJyOwPCeAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by VI2PR04MB11171.eurprd04.prod.outlook.com
 (2603:10a6:800:29a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 07:56:18 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 07:56:18 +0000
From: Carlos Song <carlos.song@nxp.com>
To: frank.li@nxp.com,
	mkl@pengutronix.de,
	broonie@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	Carlos Song <carlos.song@nxp.com>
Subject: [PATCH v2 6/6] spi: imx: enable DMA mode for target operation
Date: Tue,  2 Dec 2025 15:55:03 +0800
Message-Id: <20251202075503.2448339-7-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251202075503.2448339-1-carlos.song@nxp.com>
References: <20251202075503.2448339-1-carlos.song@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0052.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::21) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|VI2PR04MB11171:EE_
X-MS-Office365-Filtering-Correlation-Id: dee8e4b4-0799-427c-d14e-08de3178463f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IBhSwrAZu5P5wchRN98GBqtLKCj2qcjQIq/J+reqPH8dgiLGHkUgBzqD7OZl?=
 =?us-ascii?Q?T+stuKAvyGsg12zjGvjom+KELBm09Idj1HxmPx87JTkAt4cjVFjvziHLWVY4?=
 =?us-ascii?Q?TvD/K7Zhr1N2HdR36u+4WS2Pf96T5gIjgiwAn+wjQ0WQ3Y6gUXqEp9877s4T?=
 =?us-ascii?Q?6c8FtJxedl5lzCUEGWGcuN1Y9mS8xdViyoW6dt+BAjSUAaXDEO1sj9+4kUtd?=
 =?us-ascii?Q?xq54dhJrq21oQCQdxBoTioD/DH76h7wi8dKkviMcCn1CLx9h46BtZjCo4qmD?=
 =?us-ascii?Q?tZtb+Y9xNil39Hlbeg0rj+5OBTt19SMEwu+jCqK9DK2FT9kEUTDbkD/q9b/W?=
 =?us-ascii?Q?xxkhbOAPd2YLEI9FCbjgp0QXGjteqfuGE5tvE9bAE4F+q65Enh5Ul/cFN1ku?=
 =?us-ascii?Q?gQCmN7PEfeMpK3uuPDJH1uLVXDYjaBx7HHVhsvEqlyjl6UkZUPi1Sp8dCmeq?=
 =?us-ascii?Q?pspNdXWJSoJcv73qtXNFhCuiDCqTHNZGBvlKSco9ooc0Fg5afXR5lo+Ba/qD?=
 =?us-ascii?Q?+kqUBpTrdGmaCVKgM7OHdvBcI9Cg9hAPv3fUXqdQJrgx8+dn6Tr8Wby9z5VO?=
 =?us-ascii?Q?opcFo7O0H0zj6cusdJ+zTa8O4L5G8L4hwkHnBjMTGMfpuiv42JW0pMEbxc8E?=
 =?us-ascii?Q?79Kicn9r+BMRzXxr5xc/UPmng4e2Y3aNjE1M8v3KTXAZkoxTSlkUPJ5PkBo5?=
 =?us-ascii?Q?AhXFBqAvW6VOeeW7U0QKtj/WqQi6H2RBVIeOn26YuXCemUAgh5VbOUOZkF+w?=
 =?us-ascii?Q?zeCppDhZkNQ3gllMZ4+55nhnNe+YAPuSH14cl+egA3y/GwLdNDwFKaP1i7GX?=
 =?us-ascii?Q?keGXX4jjRvMWLtN7g8+ioZuwltE8tjuPIyhGhSwvTsOrs5KzUZUO4MiablGe?=
 =?us-ascii?Q?Jf8UFt+EHsn3tk72umgCIMirKyBPBG6mBlCKu+5214Fh15vx8LPgFmmWwVCE?=
 =?us-ascii?Q?+RjXkCqTWEoyhIgAweaX4N3rcy9xZYjVOsXfES8fGh38ygQjpXfivyA/c15n?=
 =?us-ascii?Q?GZPXrkO4qWq+AUvZ4+4fGIqMVDAphHc2UogK1aXUQZQIL3r8nRvNoDfMElHU?=
 =?us-ascii?Q?iNhhFzE4ds+qmS10QxvAWGcKWKabnpsJC4iPZXDQS/0siDcTGHvdxdSe9+K3?=
 =?us-ascii?Q?R4eNtPNA5h+YjUp5kPdE/ve+WJJEMub1Fi3c6nr06x61qcnbYncPV77kQXzd?=
 =?us-ascii?Q?5Hnm41BF6awr6kLck794p88WOwD1J3xCxAQfLZKa8hMv8mwMvW5996Ar00b5?=
 =?us-ascii?Q?CBOMQHmSFDVXARL8dBxcN3dV0btXr7RjwJtf1fsKlsVs0/uMVbZ8ncYtb89L?=
 =?us-ascii?Q?sXb+7Y3j1qOkNa650TDENy8qPBlPAfr6e4JmX5tZMFC7tBXmxmVeWP08SQEA?=
 =?us-ascii?Q?unAFpNPutIBLOUyBxFkTpXdIuMRC1t/Y0KSJx8K6Jl47V8iAlK4BMHlxbxa0?=
 =?us-ascii?Q?0yME4BxNo7pCwbvsQ5t7gmcxHclD67xr2NYd9zbInLzDwKNC495rntz1vsTF?=
 =?us-ascii?Q?GV8dsubG4qKo3o/+VmM/dobk3zrMd6KhFZCD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dcof/sdFy6xHh6WS07DzHE1ibmBGhPSyaMgBMe3FjPGJGFE7KeZSMmJZPsKc?=
 =?us-ascii?Q?r0Af17PP3dLVkbTXjU/Q4U6rt3KIM1XPCN482VJIKcp4RYmoj6eqtDToT+dD?=
 =?us-ascii?Q?tQDi2oX/EIi+6tVq2Tv7fZT3iDHLQwpxGewVSKej0LqOJDCG5sOlMLfNAVxK?=
 =?us-ascii?Q?wX/pBJquMgOTNdnnsCO3iv7FxrKVutKcmv3UG+Z6zfUZJCAAzHE5GlLW74aa?=
 =?us-ascii?Q?E6yJ7OEm34O1VoMWPBHPaZ2nJx/1PM3NcxuxengqAkTI4m+UASXn8oladnHQ?=
 =?us-ascii?Q?SaXAIcNrVODkd+lEutsTA2RgU9vYBMfm8yKGxgGixRirWlxG7abfJycUPYKc?=
 =?us-ascii?Q?NkdVpZJjKMXVjLB3VP/QB5Pu3hn3pK9vfi5ABVkyVYChGnENPfBlPjBpHOJ1?=
 =?us-ascii?Q?SGV3Qgip8fNjrJt9bCEH3TdarpnoUN4K9b3CKKn+rDItIXnNi1M2WsKuVUgk?=
 =?us-ascii?Q?WtpReQGpN/hUSj8rkDMxwggziiI0I8UURtdyeY0f7+FRUE6JB5VnLNNadSS+?=
 =?us-ascii?Q?rW9E1tn5Hkg7RC1uEg5DS9NT8fDIQe31nkJvoJYrIAGjnfYmV0z0cNqJU4J/?=
 =?us-ascii?Q?San8lnCQYKFiap3BxVeMb2Mu7Aoc0i4hjAWN8Ol09HRth7TMPiYQvCrWqzR8?=
 =?us-ascii?Q?JqNGdkb3fl4vG3Rd645YE9z2Xbufpez8cjCyqsu1/db1hh0asrlhbRbRG43q?=
 =?us-ascii?Q?CA7LE0H5dQJHQzqn7IqhN9OVODSJiK6ySVBhdXlhRCgDH4CXRx5sCQTCxNtE?=
 =?us-ascii?Q?WTDlrKFV0wpRNJvlIkxeZgu6P5xvxm0n7RIDuzogeJQdWxmVkMHs8MfyDjJu?=
 =?us-ascii?Q?CsWBBOft+XT3G8H0gHXYhrXvMIalwZr/D4ref7QaeWNB1ll0koD5cDOHFGUJ?=
 =?us-ascii?Q?995F1GWpJpSg7g5RFcRjssm4+XQdNUyP9Dww0TPEsoT3Ha0E1iLdF2Sg0hXS?=
 =?us-ascii?Q?TYiAuvqh7gXgbwj/VKkTEKPzzU+7173l3/32TTnpzvdI9Nq5K+8Trj8JnI27?=
 =?us-ascii?Q?cVb3p8S3UCUzvcbQiv81Sz3IkIRhIhX66IruLoh7QeIVfjhez8gi2wsJt1mi?=
 =?us-ascii?Q?IqS1QjH99DbhXtFNl5WS1wxW09a0tTwvrhuro7XGEaONqM+4exHKXdUkELnH?=
 =?us-ascii?Q?rcVMLJR5UfGd3++hWHeZViQi0CjaZNwvZumDC7v4eRN6OfJ6Fm2mvLoKeuPo?=
 =?us-ascii?Q?BS9mN7DoON/pfzteMT3ItD1Cw6N9b2BGXlpWCsTzeWhdRxthGdgP+pLgq0cw?=
 =?us-ascii?Q?PGecrdXzcQnISAQigaVefft1nk3K6MOnAvVZag/joF2scRWkVc6F4CTqCzAq?=
 =?us-ascii?Q?buOKtjiHPlfIfmDxLzYPJDls2/xix5+fvkdNqZ9+1iMmSLOjPaGR5n9d7W/N?=
 =?us-ascii?Q?T5mIcBaxqr64oYYFDTs9rDYG8jkO0R/LqD/l4a/xcYvmuQHZweVna5n8Knb8?=
 =?us-ascii?Q?Ks/cwaZb5LHdimM06zuPm4ZZ+DYYpsaizL4a69CbEdQsry6lvBvVyYKVsE8f?=
 =?us-ascii?Q?UrNTVReoes9ylK7trpUh83uIXQB716p9MvqMZo4dg3EgFmPe33QsrkyxXZb+?=
 =?us-ascii?Q?taLKzGOLzMhoEVVUn3pjV6MktEyqbHDKck/7gxfg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dee8e4b4-0799-427c-d14e-08de3178463f
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 07:56:18.1958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzmSxeb2Sw8uYYHCwtTlFcbzxgJ4FnvK5KaPclawEIaAaQjt1sCE3rv0hsm/6LcqellGmBWP9Fq6HeGrMVdVVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11171

Enable DMA mode for SPI IMX in target mode. Disable the word delay feature
for target mode, because target mode should always keep high performance
to make sure it can follow the master. Target mode continues to operate in
dynamic burst mode.

Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-imx.c | 77 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 57 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 045f4ffd680a..e37d786a5276 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -264,7 +264,13 @@ static bool spi_imx_can_dma(struct spi_controller *controller, struct spi_device
 	if (!controller->dma_rx)
 		return false;
 
-	if (spi_imx->target_mode)
+	/*
+	 * Due to Freescale errata ERR003775 "eCSPI: Burst completion by Chip
+	 * Select (SS) signal in Slave mode is not functional" burst size must
+	 * be set exactly to the size of the transfer. This limit SPI transaction
+	 * with maximum 2^12 bits.
+	 */
+	if (transfer->len > MX53_MAX_TRANSFER_BYTES && spi_imx->target_mode)
 		return false;
 
 	if (transfer->len < spi_imx->devtype_data->fifo_size)
@@ -1763,23 +1769,51 @@ static int spi_imx_dma_submit(struct spi_imx_data *spi_imx,
 
 	transfer_timeout = spi_imx_calculate_timeout(spi_imx, transfer->len);
 
-	/* Wait SDMA to finish the data transfer.*/
-	time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
-						transfer_timeout);
-	if (!time_left) {
-		dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
-		dmaengine_terminate_all(controller->dma_tx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -ETIMEDOUT;
-	}
+	if (!spi_imx->target_mode) {
+		/* Wait SDMA to finish the data transfer.*/
+		time_left = wait_for_completion_timeout(&spi_imx->dma_tx_completion,
+							transfer_timeout);
+		if (!time_left) {
+			dev_err(spi_imx->dev, "I/O Error in DMA TX\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			return -ETIMEDOUT;
+		}
 
-	time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
-						transfer_timeout);
-	if (!time_left) {
-		dev_err(&controller->dev, "I/O Error in DMA RX\n");
-		spi_imx->devtype_data->reset(spi_imx);
-		dmaengine_terminate_all(controller->dma_rx);
-		return -ETIMEDOUT;
+		time_left = wait_for_completion_timeout(&spi_imx->dma_rx_completion,
+							transfer_timeout);
+		if (!time_left) {
+			dev_err(&controller->dev, "I/O Error in DMA RX\n");
+			spi_imx->devtype_data->reset(spi_imx);
+			dmaengine_terminate_all(controller->dma_rx);
+			return -ETIMEDOUT;
+		}
+	} else {
+		spi_imx->target_aborted = false;
+
+		if (wait_for_completion_interruptible(&spi_imx->dma_tx_completion) ||
+		    READ_ONCE(spi_imx->target_aborted)) {
+			dev_dbg(spi_imx->dev, "I/O Error in DMA TX interrupted\n");
+			dmaengine_terminate_all(controller->dma_tx);
+			dmaengine_terminate_all(controller->dma_rx);
+			return -EINTR;
+		}
+
+		if (wait_for_completion_interruptible(&spi_imx->dma_rx_completion) ||
+		    READ_ONCE(spi_imx->target_aborted)) {
+			dev_dbg(spi_imx->dev, "I/O Error in DMA RX interrupted\n");
+			dmaengine_terminate_all(controller->dma_rx);
+			return -EINTR;
+		}
+
+		/*
+		 * ECSPI has a HW issue when works in Target mode, after 64 words
+		 * writtern to TXFIFO, even TXFIFO becomes empty, ECSPI_TXDATA keeps
+		 * shift out the last word data, so we have to disable ECSPI when in
+		 * target mode after the transfer completes.
+		 */
+		if (spi_imx->devtype_data->disable)
+			spi_imx->devtype_data->disable(spi_imx);
 	}
 
 	return 0;
@@ -1902,7 +1936,7 @@ static int spi_imx_dma_package_transfer(struct spi_imx_data *spi_imx,
 static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 				struct spi_transfer *transfer)
 {
-	bool word_delay = transfer->word_delay.value != 0;
+	bool word_delay = transfer->word_delay.value != 0 && !spi_imx->target_mode;
 	int ret;
 	int i;
 
@@ -2108,7 +2142,7 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 	while (spi_imx->devtype_data->rx_available(spi_imx))
 		readl(spi_imx->base + MXC_CSPIRXDATA);
 
-	if (spi_imx->target_mode)
+	if (spi_imx->target_mode && !spi_imx->usedma)
 		return spi_imx_pio_transfer_target(spi, transfer);
 
 	/*
@@ -2120,7 +2154,10 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
 		ret = spi_imx_dma_transfer(spi_imx, transfer);
 		if (transfer->error & SPI_TRANS_FAIL_NO_START) {
 			spi_imx->usedma = false;
-			return spi_imx_pio_transfer(spi, transfer);
+			if (spi_imx->target_mode)
+				return spi_imx_pio_transfer_target(spi, transfer);
+			else
+				return spi_imx_pio_transfer(spi, transfer);
 		}
 		return ret;
 	}
-- 
2.34.1


