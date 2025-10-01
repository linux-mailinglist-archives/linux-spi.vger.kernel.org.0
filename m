Return-Path: <linux-spi+bounces-10416-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E988BB1FA1
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3333A48DB
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4563128C3;
	Wed,  1 Oct 2025 22:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="1PJsw6di"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020102.outbound.protection.outlook.com [52.101.69.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CF3312828;
	Wed,  1 Oct 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759357453; cv=fail; b=FVemGsOBa0Tn0TvSAZCxq2W1+2bkeOvvhpWZ3kJAXen8x91en3JyGTefMS8na1I0mEBzeLCzmfGii3JWbhySRqJLc/No+GSgXoGcbnjAMqjTuauHo+8pJMKWlx1E1n2Ja8ibIswJGSbHg1PuOXbL+0/DARxXu/39PxdC7a4bhaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759357453; c=relaxed/simple;
	bh=1Z4+3ky3F5ePAz1LwMNxiUe87RYnFEz9pATQjAUyt5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bhq6hbMmaHuuf5akDqA61m3AUzpHeIEhh6psnto00U4Q7azTzxlRqs1Cme/gGwwEI13hwUMkqKwPsoqX7byDMrktUFjMf0MpeTB3uUFQIrT6+cpvnQ8/qzwUhVh3J308VfJJeDHJ1khACCFKsM70HGTBaHKm8MH2wxEN7wqpemA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=1PJsw6di; arc=fail smtp.client-ip=52.101.69.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4lKrejI7zsGRjPw02IDFRMY+kd1fqG0dQjzsC3wFDsbxRspWk5NyQoDWn6OaBNR9gDJ7xDE1zDO9h6sT+QNXtueKB9z/wPkJ9LeUiSa0vsoaOcpCeW0nB3IAzflGLwYovk2mDQV9QyISbWWJpSqrAf30QVldqvIQxR7gV6CjYmMVOi+kViaGYDcnshmC7Sh4rbTAJPJxvMo0D5apIHjAUl2B4xyRZkav9g5z7vc3nAKxzFShB2AEmY8E8SdH31AysEEMfi0ZzwMFyq/s2p8O5dGNMhDx1Cp3e2DQecibp9mr0POus3t4Do/suP7XDRO6zIu9pErVxj0qzehS04NzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=inegdTE+o+N+MCx1IQipnszE0EXX2/q3qHtsPxnsYLYHWxLcritVnKkuolQFD+ZUzy6YSGl5HJfGqfSh/c1pj3qjDlcjcOMhOtMs/yH0aHgY7tBf6l+nFpcCwKX53ilnCwjsO1M6Kf5wuMh3+P49P5YAuAbjOHySYO0Qq7cf+GRATpi0WtSVJC5QS9ppnMuNz0xtc/t8xhuQoDyx0jd9+3WqbP8v0nPYgwiSYWbyTxqADX5mEy0y8C8EtIkh5i2vk1tuDY7G+oc2pX42l7IY1HFjNHcn5T5jm+dJP/STr+PHF0GKhyy+vK/9IingVDDQ72+i0VO243v5mWLKi0swFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LqWlm7do5dhcKQcKUBo5lauX4m4f79tFnTIC1Cw+Sgs=;
 b=1PJsw6dibTiyDJhEMTFcd0Stqdj9Kc2jHy8O3FHxrqKvlvvyDnmaSQF8e7CN5dGZ0JM9HOufQMu2hAObpkGtttH9hz0cbvU1onEr//0a7nFHZt5XRgPrMPRL8tnonklnUXdAXdF9IdnsOcQuVlH1oQf9ekLr32komw0+Qz4W68eqM0p51rLXAfAvRKITZZ/u8VZuWPBbyAl80CgVMEww90W8t3OYccob+EM8SsZrBoC8X28NvbwuGKIinZkIbWyKE+fCmjm7JUIVSnQ3P/GRRF/Vy48JAo6i71RCuB+DTzC4o6lrKfBMEtTu/lLBBUxpLkBB3HK05QRvy6Gb8420/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6302.eurprd08.prod.outlook.com (2603:10a6:102:ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:24:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:24:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v6 09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Thu,  2 Oct 2025 01:23:42 +0300
Message-ID: <20251001222347.3386506-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251001222347.3386506-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0447.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::13) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PA4PR08MB6302:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9ee37e-fc15-4094-c20d-08de01393a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mxIUBaPm7GJn7P5V5eyaoF34Y8ah/Wy1tdGw5wB5PQ/xxF/aG1K/wK3Y4F/t?=
 =?us-ascii?Q?kmDdQa6qBga9HLcoeXT1K+JqYwX+UfLMKIzVOREvk+5BcRjJ6JCoANR24e+j?=
 =?us-ascii?Q?eB53lj7ZPxRuRVMDbWfCkuAHu/LiTG/vKIZOYDUUxTnVpZAzwh7ugS+Aya6N?=
 =?us-ascii?Q?9wZWf9UrAl4x2bybvHc3Cjv6h1lqlZpCktOHmfIwTLEY3TmvjLEZqnuDMp6B?=
 =?us-ascii?Q?yIi8Naz1+xARDHFweipabCTFp3n8S828kSCN9/mCjvT6n1ZSU0Irch61VwAn?=
 =?us-ascii?Q?S0+YEWQtzQXSJETouwV5AfCQD49sCzNML9ocEeBGY4AfhlaJUFihbt/K5L/O?=
 =?us-ascii?Q?fLLsEgu3ozHETcYfHCwhiY72mfgpBGOpig3tI870sfcW60wXYIF5ZNXaUiLO?=
 =?us-ascii?Q?tEvavjeF7GEKCuob1xlTRm7v/NpgQ16jLphtzFuUDDFgRVYkgzH9t1M8bDiD?=
 =?us-ascii?Q?hIFf1aACeWkrTI/jz4tWr52T/x/VhVv8yEW8TEzZs6OtjOBm9xgyaajG6wdr?=
 =?us-ascii?Q?TGhme1u9SWOZgUMcc3rYlOGzlOJkPtOP1hMvlSoeDTkvDA3yWH8uhA0DTwhH?=
 =?us-ascii?Q?ubhA9X+rkqK0Wl2B6rsI9Wm664j42uIxqaBRXLOaMuObFe1vEOkSrkCWq0Og?=
 =?us-ascii?Q?a7ao718GbMpFkPn/kYKxI2aUucEJ7JLQW8KiARTRPibAy6DWZHT4a8HiZj/i?=
 =?us-ascii?Q?QTYV2NEtw3LmKD/dPrQLT9Ktqt5nZle9EQbo/kMRQHHidwG47gSu8OANHtEu?=
 =?us-ascii?Q?yKGC7WNCj2ocSlm3O0SSuz/m/kBLqQTxBH5vz6YDP5SdzEMdb00jw3E+kwDs?=
 =?us-ascii?Q?wSnhXi7BEfo2WMqwO9pPM3NhFr5F/PfY1qdw0Y1QE0wGoIm4vswrz1mIwNDh?=
 =?us-ascii?Q?3Iqa6rn4/KiLXLpz5Y5KKKG5yfRfxWZkUZ7tE72mbUIEEsr9O17jaupGVFKq?=
 =?us-ascii?Q?llp8KuzawU8zotoPiYw/JsR7amTf2fh9nx0VWGfUXV8wmFrw26zvfki8SCtT?=
 =?us-ascii?Q?ZVyYkorXNTgj8BjR6GzrmOh8PGtirJqqRMnqlytJV282IHqAbWJ+Glp64qw0?=
 =?us-ascii?Q?/KHBCWwhW9BlSz/gOLyd3Qi2Me9HzTY1Tewl5wsgUm+1VMfF0dkfyBYcmmjN?=
 =?us-ascii?Q?dN84WpRcnxPzyDd5l0kLmzVMgRGLj8eLcoIZJ8tzw3LReL1hIYX20TngDOFe?=
 =?us-ascii?Q?5+ujCQQtZjRnBBDBZ19EQ5r3FrDkEn5FXUXSxmXSH1F3W8YRAwQpZHKHGAsT?=
 =?us-ascii?Q?wTyBzON2kwVVFMaUzXWSngsTOTGT89/G7ezh29aacNUZRVF8FOfLkDMcPTsu?=
 =?us-ascii?Q?S7eUtwQxGhA8FBKaS3/oerjyA4sfHWZnjDUjyAFtyijgMRoA9OYeqElLKEMm?=
 =?us-ascii?Q?RXUyWR/4NQuDE8MvVxCO2KWKjgF9ZEwkv1+S9qVKdBnOcxFdS/HhO3/9L99D?=
 =?us-ascii?Q?RUfOMzabym2NqTcEK+28/7IA7MJ6RCb/XetOVbEEEpov/y4IhUAp6PLTAgpW?=
 =?us-ascii?Q?BJplS1brhbJJa0R64JlXb/kMUojEN/gXySfS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h4KWd3iq1IMd1ZOSwCBkaVFGHcgNKOu7DQwbOdtibPc3vqTZRlWTDbpcXob4?=
 =?us-ascii?Q?GHTp1uGiRlORxrLk39cvHZzxo++6wBoEPok6YANiofGKRAqmt5THeetxHE7d?=
 =?us-ascii?Q?FPSN69DrgkF81mDpSD+1uvno085BmbGOWDDu+Xd1Cd4gvoOVfCsCItUiLP26?=
 =?us-ascii?Q?EK8lKuKYWoLkT9goIl354WGE0zqdfvgeGxOusIR93Gxia8+N88/t+GQIvGex?=
 =?us-ascii?Q?PhWbCKniME8HWS6p/DJDSRSNvI3Cs7Tnf/yz24RUCXR7CIpVZ7NGueaqNoLS?=
 =?us-ascii?Q?LOZFrAriEOWtf6vV9BzveC3XirseREpzkzLvuwUNraZ/gI4gltWtKcaOqQgr?=
 =?us-ascii?Q?fG/IK9GPALyxBOJIiYZfriowBEIm2ougKkuGs5YSzE0HcHwarSMVhgBQm2mh?=
 =?us-ascii?Q?SxB86zMTb1zEO3yguMFIpGc+A70VHZrIB+faQqnZ9Kc+yMBZiL4YbvAu5iay?=
 =?us-ascii?Q?oLh/qXRYkTD453ht/lxCPi37Bpu6bWSGogg5qmge3BV/99e43vfDHHQoNyW8?=
 =?us-ascii?Q?SyxQFSMPPGsk7PI5R3cJO88P2J6rA0bMIvIjB/8APu/oRRXqkUMqzeIgCviO?=
 =?us-ascii?Q?N9B1cyy49lxz3JR8m/cCRqp6vZg6sDwcaKrEgOuvUEiYWmd1WCUI9Pjckvdg?=
 =?us-ascii?Q?NTBHN1aoFofNuf6fYUlELNOsoc7/l15kcmKlgddnvIouZhUyYy2iNE0gSbu9?=
 =?us-ascii?Q?5JCWyLvZY08LAgfMV+nYjsj5oQhZIqTOJiJ1KcIVub8bCxCgIfFwyXY+umC9?=
 =?us-ascii?Q?lDua2DREF5ODJiW1UBdFfzM/HBM8bYBpeY7d9eb68+41OKlngD44PZCsCFEV?=
 =?us-ascii?Q?GhS6cPgJzcgWgc/VU+hSOf+1NfEVpj+EnROrg5D2ptD7O/5dwoPqUh0gQH0H?=
 =?us-ascii?Q?kZCd4L510PWYO6mICZJ0zIOX7j9xpanJ5hr42BPWalhPJJ3RK8IbAmKLgxNV?=
 =?us-ascii?Q?icqO5hlmbSU2Gr/MsRAuaOj29ZKPiNrcp5Rd+Hx4XEpGj+9DTDg0na3zkO+v?=
 =?us-ascii?Q?NbEvCectfhf0l/LikhuqbL7sNLNmUmVTB7v16a5XyKihV6BCHC6L1cXEObZw?=
 =?us-ascii?Q?c+DYRUfbFNzjv/6YTmwkQSxNq9bFB0RX3TiQnYjvEk4eSDho00WWdaWumy5J?=
 =?us-ascii?Q?4C3d/aQPN257X5YxJVI4e5rZro5Vu5ajhX3HURnPW/GeYn/ZTOywE0YkPS5z?=
 =?us-ascii?Q?by2iUV08gG1T6O6FqKFdRGHfeTw8iFYgpzyfyiifXq8E7Rz3Ge4zBSdFyWPy?=
 =?us-ascii?Q?sEhFI8zKTBSRv1B5yO30dxIDxSZZak2BEsqmL3IuxnFFw+0aZxtd9E9b2uDL?=
 =?us-ascii?Q?Ru02JIiWpvx7qwlQRu65dvNh0Y31xVOKiyzNTM8tWxQt3O91Z5MaMu4kfsRP?=
 =?us-ascii?Q?JRwy1VFb0stp7B/19M+PCJfR6tuHEI+y6W4lTCavDkJS0h4JfMx4erFDVa4A?=
 =?us-ascii?Q?f0iy0qM71Tn5hnSxivlEEKcBv7mBNN8TDEdMJYDhYShoY/LuyP4NwCf09z2Q?=
 =?us-ascii?Q?viTUCoP2LTd306gzOE5jS+T1wiCKs91hiaxVuCXg/aEfebVKhd/KhHv7lxiQ?=
 =?us-ascii?Q?O5y74ZCPXTGsdrDSmJFwH191UJx32chJomC8sjVKcJuDJdM0yAtchJlbc5Y2?=
 =?us-ascii?Q?JResXwj6wqjSvYp3Zzqwmyk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9ee37e-fc15-4094-c20d-08de01393a3b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:24:03.6491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYEaTS5LEEphOLJe5RcUbNINtMBU21drQvqpJDi5HxHcnB90MGHU0HyAc9wPDhPHZnj+ksp8Gfr90v22iSzfQngs764+o8MJaTNlOh0Mr7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6302

spi-airoha-snfi uses custom sector size in REG_SPI_NFI_SECCUS_SIZE
register, so setting of page/oob sizes in REG_SPI_NFI_PAGEFMT is not
required.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 38 -----------------------------------
 1 file changed, 38 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 744eeb2b24ef..719b424d4cce 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -518,44 +518,6 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 	if (err)
 		return err;
 
-	/* page format */
-	switch (as_ctrl->nfi_cfg.spare_size) {
-	case 26:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x1);
-		break;
-	case 27:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x2);
-		break;
-	case 28:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x3);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_SPARE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_SPARE_SIZE, val);
-	if (err)
-		return err;
-
-	switch (as_ctrl->nfi_cfg.page_size) {
-	case 2048:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x1);
-		break;
-	case 4096:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x2);
-		break;
-	default:
-		val = FIELD_PREP(SPI_NFI_PAGE_SIZE, 0x0);
-		break;
-	}
-
-	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_PAGEFMT,
-				 SPI_NFI_PAGE_SIZE, val);
-	if (err)
-		return err;
-
 	/* sec num */
 	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-- 
2.51.0


