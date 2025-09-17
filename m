Return-Path: <linux-spi+bounces-10079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC30B820F9
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 23:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D3C580750
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 21:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B230F80F;
	Wed, 17 Sep 2025 21:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="U0hQnDVq"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC1930EF9D;
	Wed, 17 Sep 2025 21:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146352; cv=fail; b=iqL3NNKKjxExitD3ab0B0hreVHN4sCTcRAKbw0ShHON4EEpACWR3R6nTfmThn2oW5V2OjcfHScrKH1EWKHWj2QrxkYmweJAaMcd0lbuotcoM5cSllB3JTSHHshvmMmPUzXknh3W+blVCNENZjzbF0CY5RaQiKL5vY7Ltlp1GK4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146352; c=relaxed/simple;
	bh=ePjsoeZZzg/griX4kSV0rVTb4AjMBla21bv3wlqzAAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PpmYOG870tY7rbmSDG4m1rcQZ7KjhYihOg92hMZDysCZILiJiYJ+Tg9MAxa1SLOy/5yqA+j4dxfj019gyQw3S1bps44v9oKqvqv6wHNbC1kR0v4gS9lQr2HRKU1hFfOGF9kXobzB7g3518iHr3FTuy0TUQVZNn/UK05ZqTttbSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=U0hQnDVq; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L50EDElbrdGBhbk0CG6glJMRfH32gTuLxl2PjZdBn/RPtLOxGcnTeeMZ3abQzJn0XOSs+/tLkgLiE3q97LixjSgjpQgwfOv1qn3c2nWcAkw0e0v1K0Dq1VwK4IDOSHdqJInwz/uzy8blkMukG/zlBdmMAgepK+dF6TF+kewXsJOmYohTw8ZvImX6U+Wugx3SLTzZyw8FnsqPuNa7Cj6IERaiNnNnrXImQ3jeOvkvjdr2I51/vGQasQ6cJbaEnRQLuhfJbPxxeNd6lXt0C4PTBjbKh7/4OPt2xn1LZ6dtrZazliTjGqEi2Te8vmX6doU0SxJXUsszMr3AIF6mj0gkPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URx0qNoovSMJ7D588DDoEUns+ZQALca7bPxiuQFxhT8=;
 b=uR81qW0SsXXhdXXPJpdJwjiwe1vnSvqD9CF1MthX3Hqg+Wbgv8wN+CVOJvkp/HlphFWm4wsPiqeVQz2z4iN4mQjnzsh0nCGG9MSqWnJnLzn4bC2Hftw0Dl8XYhECd4OvTvuOTbk/U2FGyA3pRolQoIsk6FGVTbej9ivA/3DHiRuaGzY5+Wjd/09E3Zu1AKgHcSGrSD8CV0udyeO2fqlYE969x2lEORRjz8xWhq29mig2CUv3MogEAiCfi46gEufmzOpyS3ak+fLByuz2LL5jl06+DXk6SrabcQJ2FRkCd9qgW5OERQ3nVUqXM6BhEtMpE8G5ztpcV5lzIHkDehZxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URx0qNoovSMJ7D588DDoEUns+ZQALca7bPxiuQFxhT8=;
 b=U0hQnDVq2X1+bVg28H4BLYIz2JnCfXIDiBXUK4ZvIJtkT+dhU3s5XoK1xaZwv266RG3+ZSQkk4XBrV23yLmg06BBJ9P5VaQ+doNrrZq9u3o8vI/BdmNClAfdue/0iHSZ6hbaOjdYSeDaEuifH8CCTdCGu6NAYZrOe/0SzgCQCOEnf+FHxVyL8uwfuQl+Ub/Iu2amn6b/q3mjWZuxO156mIEj+iFSlH66+ISrgiV+uWDG3UwjrpBJXze9PGMDhZWfOjN+hJjBWL9pzAwWRRGvraDmKxeyLHvBvW+MmnYdzAwds6BZxp9xrJWCY7qkptCwHoyynxJjZ8WKaYcbaSYoaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:07 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:07 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH RESEND v5 05/13] spi: airoha: switch back to non-dma mode in the case of error
Date: Thu, 18 Sep 2025 00:58:41 +0300
Message-ID: <20250917215849.19720-6-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250917215849.19720-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: ad269e33-7e29-4dad-0732-08ddf6356c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BgTZ9ZbDskoOc5IDUvhX0vOpxhjuBzStMiggVvSTgliGSRjlebm/cZLcUMON?=
 =?us-ascii?Q?nueg2+K4xZpmQyX0nqmTR9Sm2Du8lMD3+0Ln5I3+G+0IGllyMppB29n9PRM+?=
 =?us-ascii?Q?L/dBifh0FFigQb1H38XTfpB6ttWZa00lZIGGygPOvcLXn1rKKLRoIq3yStQg?=
 =?us-ascii?Q?5mqOBAvOP6TW7lEPW9ny88lWUvmi+BFY558sqJBuFJRHDtKKrgBWazOK7yZm?=
 =?us-ascii?Q?y08zf6Pqp5ZE2fQ0vVVc7x0xYFxLwqIdlCBXgwRXs+/R6SkqnPY+JAS6okJq?=
 =?us-ascii?Q?KdSDHumcc3wFcgfFtLroA+oD+vg1m809xQbUdeXr68xwEqBpJ6B82Dgnm+oI?=
 =?us-ascii?Q?rMj+z0UtpD4QjU+63KdO8GeepQwJd6d0FibZBSOGkXCCXAZSS/20Zi3CJ2dV?=
 =?us-ascii?Q?DL5yzoimm4MgUBIDALfQhI0sA9UTSPw8PhBAi1XTH2QxS7uzQjFxll3DMAyG?=
 =?us-ascii?Q?l7rbNvKroS2yve8p6JO6MYDEjl6D5v7ii80WIoY0am9ptzAEWhtvDSp34X6K?=
 =?us-ascii?Q?3bjoSAKR2HxueLk6q8A6oKsYF7Yr24zxe4QtN0f0F47/ZNJj6yCfXktG4bie?=
 =?us-ascii?Q?o/+Er5YbdYQkX8XA5zdmIT8cRbsY16m/JSiFxBsPSzkPUN6ygrbkbfgD94yd?=
 =?us-ascii?Q?lzegBenRow8lWBbUINZb6bawbUO5aKbN7VLWs28KhlpbvUOJCiVl9qBcNLXk?=
 =?us-ascii?Q?peQvQZvQ+8Omg7wObLMsiZERVVGj2fhNT9WICiScWMS4V5VNH67dk3OvfUoZ?=
 =?us-ascii?Q?vnhGDlyIKbFb94dTZ+IpP/D6zB+wT999Tuvs4wMFWMTn7Cmns8W3uNN3vBKu?=
 =?us-ascii?Q?GCGFVBDvvgEPL3mpoheD7At3dvUp9zxA8sieXXYIGjiuOC3OpTjt6f/lUARx?=
 =?us-ascii?Q?yyrXIqSH0Q/iJOb9+RxHA2BIcbHC6WU8NkXUX+0QLzatG08tmfPsrrlHghnw?=
 =?us-ascii?Q?gwMppd8JuBq/O6aD3C+c+zq/7n91NWspUf4Mocbt0B8lAw/DzkloK/47KmWp?=
 =?us-ascii?Q?ilLoUG1MpHGjH/ZaBg6Qy/CuHaMaJKznFtLE0vNs7AvVEuvaP/HwTDSTahAl?=
 =?us-ascii?Q?C3dXXtj1HGSPLSTbaknnpm2jhNz02wDpWdIxJu4rndqajbttKdVBHcKYu7hS?=
 =?us-ascii?Q?KEH91AzdJeEOlU1U4xm2Mr2Xubw8ea+3VstVPs/xqFM5g5vhp2wGO5DqJamN?=
 =?us-ascii?Q?TefB7Pm52pb/1PRh8+0Ahg+17WfI/Kzw9VsxWehktI3dALuvuCB6VGsPCTkU?=
 =?us-ascii?Q?9KTyYIUPv3H9DjiKMYMSWrWFiDWr2aErpDuEW3ZijB1ygYna9xzR0kZpL1Sw?=
 =?us-ascii?Q?dzPvTimBSXLTj8qPyigB5LB+fvwHKAY9gNezxNm9bbSURTPXvkdK4uBOj1MK?=
 =?us-ascii?Q?tSnvfkHN+BiqBC/elibTiRsVrlPtlxJKUgnVgZHZPb18nmUoaLLsVu9A3EQy?=
 =?us-ascii?Q?CHcBoTi9Mfq4YOdK4MgqDJX3SZ3EYSfsvBvco+p7c0LNd39HtgzrhA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+hM3JTtq2LRuEuq/5LRyPKxXesOgN6qJWlVT4AQFKuk5RneynZqc0UZ5hstn?=
 =?us-ascii?Q?bvDqqRxMsMdG2GCDDgntE0szcxM40JtQ8sbU4ZcqYYiRqRDZCyOlTMHMtLJ+?=
 =?us-ascii?Q?lzqIgkPqkDuricsM5ETw3ShV7yieNdmxCYVADPI/mUh4oCkOM+WCGWWaozd8?=
 =?us-ascii?Q?+HDaUvcg6sfI6s0LnnKpEm/VPfXUdD0aDr1kNB7QDg1qdItEyJlCkXCsa1r/?=
 =?us-ascii?Q?zbgBEjGQ4ZKHJf54OVuW9KxLmZHOLHVPCdk9xkYHWQDKvM3IxS+cxhdShUdi?=
 =?us-ascii?Q?sqLMFijmZeWiPo7pOoDf5ouxE0E1XfV/wSHRZikJX7wYkRojIDop2hR8lz8i?=
 =?us-ascii?Q?U2+zNp994oHa/rk4rX/sB08qTbpxExOfvMvYcqBIviSnIn426d4da41J5hv7?=
 =?us-ascii?Q?uhdLX7D+Ig946m1GGFaNNic3uu3aspTr2YEH1upp2j+oL3+tcEql272bTouf?=
 =?us-ascii?Q?/LKbum9mN152etTvRPh12LjnK/VJVIFDsgtbsXK6mk7wx4mB2gbwY3EiiEHO?=
 =?us-ascii?Q?FdReFycW68DFoSOFKVtythqVHKO4oyrtaM3dwFrpDeNLuXLEZMlTRT4z1/Ug?=
 =?us-ascii?Q?hvrzCRK8lnhSPmQc4ZXNQDP3ff5h94gKnDBIVQhPAvT7qdS6zERO7GTYqpEa?=
 =?us-ascii?Q?6bXbE/c8bneXSs9FmvCnfr7PKwRpffl9QkDlWPeKe2Yxa7JsewnXFIm6CYr7?=
 =?us-ascii?Q?sWs/tQRrKFXVw03gz4+K16qVfdrRVLTjgIbhzVP3S+TVTyLn/ZoJAAgM2Qb+?=
 =?us-ascii?Q?TYf3f4oUf+cD4kuWQ/KDby0GKz4iNIEKtkBlwtZK30m7J8kiS5TWhbAjeI1Z?=
 =?us-ascii?Q?aUUbh068K07DMJ4y8GoxXjjFzzMTVzphINC/dqA6SSW+RL2AYZeOZYfLw5H/?=
 =?us-ascii?Q?B/GzRcAz11MPt4xfPku3TgEh+JDU3Kqh7Wve0nl7Dm7Rt3/W5xvbmScGL5+h?=
 =?us-ascii?Q?EurwGx8+6tvYZIlSfud/uxGES8TFEYxsULaeBfBcM1Ghc4oP4ORYSFwCv3aK?=
 =?us-ascii?Q?UYCD6/avUr7a8ObjPswOh6zO6RO2g0yb1Nx501ozySKgbnULUUGxcL5jD3hG?=
 =?us-ascii?Q?PCzXF3VG80IeSxb08kO11cYPhyS9M7wBwhBmpBuNqpO+RJaEh5RWmfvOJkBb?=
 =?us-ascii?Q?6g+OzDsvq1OvM/cxl9l44k8yMDQ2Zt+Et01x6FFhgm5noEnIeOL/dOQi6SWn?=
 =?us-ascii?Q?6mfV3zFUBTmavt0c/pauaIk27HHqz2Y0R5vTn+JBlcmGOITmYX34SvAwu224?=
 =?us-ascii?Q?UQ4tAwIgy+wXetJAt0+/CJg7yFVgf58tmX2oIh2H4x23HsPkASVlF1CwlMks?=
 =?us-ascii?Q?qSamiXQqoKPuZYzvGrxF6d0LuPwh8IM5O4dRKFrnhKJWMC8chI/0Jm+SRXJ/?=
 =?us-ascii?Q?BApmOI4SdkcGyElgwKGlzXFWzucJXDx/9rWhwCsqLSE0lfz3Vw6H4EGnVfER?=
 =?us-ascii?Q?HiNOy+4WLVAFaYYTajcWt95NXpVc93EmDnucWQMbOqOS2UFHJj6MM9HceCHk?=
 =?us-ascii?Q?0cjoSrchJxKtLCX6DW1V6Ful/kEg9XTNc5jf4q7+kiwPxldLSr2Rf6/wlgDm?=
 =?us-ascii?Q?I4elw7g7UtNreAzUCf3SjF4pDt55ufXf6X5v8VtiiP2gt+AqIb/vJ/5yqP2a?=
 =?us-ascii?Q?B0W4wltdYE7zko9sNuJ5reY=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ad269e33-7e29-4dad-0732-08ddf6356c9c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:07.4159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v15dDl2Q3ZnJv+rT2pOtJ8G6zCbEQiPREmxwIH7d/a9DQGNcp479cIGIUjo7dP4kh5LqRVckwR5oMPxsasFmd/Bi7LC/QZKVCykVhFDBlYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

Current dirmap code does not switch back to non-dma mode in the case of
error. This is wrong.

This patch fixes dirmap read/write error path.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/spi/spi-airoha-snfi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 2d86dc62dbde..a39c3ab4af5c 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -691,13 +691,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
 				  DMA_FROM_DEVICE);
 	err = dma_mapping_error(as_ctrl->dev, dma_addr);
 	if (err)
-		return err;
+		goto error_dma_mode_off;
 
 	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
@@ -797,6 +797,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_FROM_DEVICE);
+error_dma_mode_off:
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
@@ -926,6 +928,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
 
-- 
2.51.0


