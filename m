Return-Path: <linux-spi+bounces-9901-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6208B43EA1
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 807FC172C59
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F130ACEE;
	Thu,  4 Sep 2025 14:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="l/b1iA8/"
X-Original-To: linux-spi@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021101.outbound.protection.outlook.com [52.101.70.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B73093C7;
	Thu,  4 Sep 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995844; cv=fail; b=CSeCVHjzdDTaO/mIv075kRWKsgLmOZenjhbF+erMAnk0AzNA91PQGVbGlKqyR94ipOIxVJVorg31aW8AZgQ/SmbPQKtylmQJlCl03q69O37v0kr6Iuu3HTAyO2d0ng0MscEdvO0UX9xLr5D9nKgc/GVQjIZAxzwpWyCDstsQoDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995844; c=relaxed/simple;
	bh=3yi139oLRY1Y3EG1xIBQk5vhNt4FMhANTVe3kDQorHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LR3dFZsIYJ4mEUQeaFk54S8GaxrhwhUJRRNNKc8c0lQaNa2dtf6MvgoZqWnej6XiWDxslDQAvHN79AkhZ/n0Ebqw/grq9eiHE10LTx8ij7Lw4+IPslkyPpJwmLUjjd0K8PXrqSPIhYN7fCzZSLJ//oKCb/IyOuMK3Nc5kPJ6BZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=l/b1iA8/; arc=fail smtp.client-ip=52.101.70.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URd4/md9ByO6b0RgqkKBYJJ1Gtvp8f4PpiGLuYApWtj6qPPqmPkGN01rbgTtcgma7S72/D2DsX7ulSvl97yEFZ9JiR6es8vBvcInk9ZX2pBRK/P5e+FC1F/oGBkZfTapEfH+JlDO5bfvsGWO+Giv2Io8J7a03+kNfrjBVzfSyqax4btZj93GXOtF+9cRZLTLeMFVAUj9AIuj0mPOBqaqtr+ezhBDWrQ2pwLK/dcGz8xxsHoYirDY50b9up0EE0cSHfUnJ5AP12IYLleIjqt/qqW7IsCchmg0pX+s1a1QI3VM8Mm2NlYKzssQPoQlBpQDIFMvvLRf56FX7aICVPl6Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dZDfOfVf0uWv4J7U5NMPJtXwJGCo2z0OCtymhOeYbc=;
 b=CrC8PpYZXY6VTSo0Xi2hQsB1lWoM00P5LU/szGE8GFS2ZL/KA1DLxKYxxzC2Pgltv4iTUIKQPv1QMCzAr0IsmRS2tlgz8ZwF9xXGhffYe5KTGdLUC0NqssOCfFnxcgUjGX7Je0FS6eN2XXCJ0XtqWCYU1gHTAA6916oSiRQ/biBypDuFyoaRluMP9a84RZofk31Z8BrvyKFjjbmGG4rzdb0fkeKTygAUQT19jtpu/ajffZG1gnHk+hyilDZNSd12Z0R1x2Jj8WLqysvEEur7sLyAfnkscJkw4OZCKgEQm61CuwLT5KC+5TvoyvBIRjEsYH3tmu7uiyqNZO3hXGi22g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dZDfOfVf0uWv4J7U5NMPJtXwJGCo2z0OCtymhOeYbc=;
 b=l/b1iA8/VwUOS8E+h70afVF449PdbG20B+PEhmYa9E1TLeIMlU7f4q9P1ny3XNplXo/+ZpuENxTzJIq17YUVMFScB/MtZAP5n96AiYFnmSosk/eZTCZhYY0pUA8a1RRdQNEuKk5Fsr0Qh5G8xYtR8mvRDvxh4XUxOVQ393V83yU9ykEhcVnjd4xU57/JWqgd33s5LmfHRvV5XxAyQKyeWdjraS4LRh7CDJgiesqmXRprcaNL5fF+EVTcGBSdQLU84E7bkos6F5m4AGAdjEgszjEspvGxfuJvdiZhkwB4WuTtlTS3qttR8cjP/qEFZx+49qjngSq9qq5IFsPGsHLU2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB6436.eurprd08.prod.outlook.com (2603:10a6:20b:365::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 4 Sep
 2025 14:23:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.017; Thu, 4 Sep 2025
 14:23:59 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v5 09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
Date: Thu,  4 Sep 2025 17:23:35 +0300
Message-ID: <20250904142339.656346-10-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250904142339.656346-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 07168dbd-3feb-4ac6-b675-08ddebbeb010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BrxycU7CbLC4bTisf3ofknNxLolRbwjVRP49EKsFuwgJsb5olGb9feyX4Vap?=
 =?us-ascii?Q?qj1ZMoWWgDFqU2HB84axrTV8H0/pcTFCvugOIApw1QzwQmuvoC2tdo+sxWma?=
 =?us-ascii?Q?nQOccAQUQA2n+NEFmsLyjfAvW+VlEd5KcEUnGT11aoXtNrOpLaeiUdE/Nek+?=
 =?us-ascii?Q?O+ehDUCkhRFXEL3R1BF5kgPUlHlJQciHW1TAdag4OxLuSLnYU1Q6xE8w1Cjx?=
 =?us-ascii?Q?Ly+Um7DjeRqa8BxODLC6FnrsDWOreoXNBNps2fiMXCvdUOBByhj3Bsx0VmYS?=
 =?us-ascii?Q?wTKFVRdp0D1rwDOtl6fx4a8urJrVnDNSfDIAVbwJuu+rOPRD6iXDqN/wlidn?=
 =?us-ascii?Q?cGwXzUuFxZuJEO+E/1qAu5SNPcPFAO1SJwy12NQMm+wSnC4UiGME0BqubB3i?=
 =?us-ascii?Q?GjKEqD3+MAWOxPhMVbu3ZIXKOBPZr91phxy3bUgp5LyIR7NOdqBfROeiq4JE?=
 =?us-ascii?Q?8iDQIQgCVeuyvn0yitEMOHckOF63YDTD3MBr2IeVFxuy2unoY5KohsyE+Ffm?=
 =?us-ascii?Q?GsqV/lMXXsODnMuj+8pR2kybw1ov0URvykDt5heLFEfj1FHCQV7hUrjrHkNg?=
 =?us-ascii?Q?T7OTomRX2VAoQHRI0t6jQXChxFvV4kto1uRXf9vbojE7KXVkxHiLQQsMfZZC?=
 =?us-ascii?Q?pVssEVBZBkwsWjKcW3DfjLKvNIAYeCkW04D4Nly72j5Z5v9xstMD0nqcv8ZF?=
 =?us-ascii?Q?0t2X/hwXbhLN2mpR25yvmKo7lqSpO7+UDHOPaAbXRVsXG+jd6BrcjOjDGneY?=
 =?us-ascii?Q?bFRI5+1ED6FWGj9kigUKV+5YA3CNjDZKhaxdEeCqG0iEzvs0isG+FCTtVeBH?=
 =?us-ascii?Q?SihrppSgAlEvvqPXqVEkuHogygrfMrdQ4CuXAHZgIQm5tPhARKqiRYcFkZgk?=
 =?us-ascii?Q?t17J2Hqz3tAKdz1SC57LqEV6ZJh4JAeNEVm1ep0qJPIfdfaXUeaFKnik5Q1y?=
 =?us-ascii?Q?HnhO/G9rru+5LIJ6otK/hjTen29pv+7jBcuhhBkMuC1zYkRxAnqLlfL31UjL?=
 =?us-ascii?Q?2nF2Rt8pjXosQujPjbz3VXG4fPmsXIiKxW0diDsZQqtEZurfJPQOlE8Yq4os?=
 =?us-ascii?Q?hqi4CkdZUtfL/ZrcaZRNie0w4wUA4Pd/vBxo1xXxNVK0KBRYOnuJUcwnbnJa?=
 =?us-ascii?Q?J6IOVMdnBP4pzpoOscqiqtCx59wFAsqImSpLuP/JU2wziBfooE6AfyMZAGz0?=
 =?us-ascii?Q?Vevozw4NzGf4UfpgK7PUNaAbB7+6B2JlEa5vH4zEm+/eJZYqIMBJA2gCEO1i?=
 =?us-ascii?Q?4H5uW0JE9ehCfoZdpsU/UJpNViekjW1cnMasRjZ5CvT9UO2yfNDTQp20YgMg?=
 =?us-ascii?Q?rlpu4pbbYrTZK1ih2MsDtgMfI9oWBxZoQTIND7W+K5MRJlkG9sXqV8si2Gcp?=
 =?us-ascii?Q?x+PL25CUMRVn3KqIjj1rKTnT7ZLDDtgBIfUzGjSZ15LResuJJ1XNRY0y6i42?=
 =?us-ascii?Q?O8JnAF6KZTiv0Be1OSKIQ9TTLSigbFR3B3iouN6tthIXYHBYK7mhcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+ZRQbG5s6p30IKmkJaRsAhsXbENBvHk5KPLbIzRrsH/91vDN7mZooyClxgqW?=
 =?us-ascii?Q?kTbIWX6TkkIFYzcf2JKvG73fzX5qySDDHC3YU1R0rJpHFcSDe/xDRpIAUtXF?=
 =?us-ascii?Q?TklPDkOfI0R1ze4k1BOf/ag7PrE/SC+I4v5Mu0vhUJ736oA5mBUm7Mu1PExv?=
 =?us-ascii?Q?8O3AJKdGplI80r86y16co0R+0UeoaMP+JAYsBfvlD1NpumVukijVMrY6yxnc?=
 =?us-ascii?Q?b095buZxKG/kxZXW54SO3w/eE63CAsdI4Pik/Avg3rHMzcenmRMGDj5Sq4vH?=
 =?us-ascii?Q?uxes8FjJ/ObMqpqIPD7wVJZlwBoUe/tbmjdrv0a+JHohrR/O780vZz1Vir9f?=
 =?us-ascii?Q?jCRtIP5x6bTKkQFLa0x8b78s6RVSUT2+QJgWeQHvDNE7t8sjhJKcKCXZGmuX?=
 =?us-ascii?Q?YinGdnmrekjeSKXmNWs4BTIhjzl3lUneXa3wRz+KfPeYRgSb0pnLqYEtwkJo?=
 =?us-ascii?Q?pWleeyn3GIgd8FvziXuiLQslGQ37bGQwRHncFmosVeKwTf4lfcAflzKUl/KD?=
 =?us-ascii?Q?UeAFdSgtFess/t5EtJF8RIWGAOyT5VrUyZsNnrgo5DissHctVxpFMaP1GBpb?=
 =?us-ascii?Q?Ozynn0BA9nl+u9lGugA4sTXYlVHoze+N8yZzo0MTKasALvixErID7rUhvG/9?=
 =?us-ascii?Q?D5gdz1oFbxCzodrmd0+f8T523I7jBK/7tzDW0YsCwyZGeO+JkyQ+nJSKzSAX?=
 =?us-ascii?Q?PNS+AFbsLqwp+ZlndI6UmT3GGWtnQsgfIxO0+905vYpI/RS0BoOH/YEMDdi+?=
 =?us-ascii?Q?kROfeL9qsJIp+upV1GQlWhTlkor/jjLFDPVooRjo8V2fWE2dOpsGqJEcej+q?=
 =?us-ascii?Q?XNwLpdDKG92tWMy4z3DtHu2YkEC7hoB09aeZRbO3pS1aM8otgTOWO+hPa5aZ?=
 =?us-ascii?Q?WvhTPAn+wogGmP4wARXrSzO8WzT8R8HkpA9LtguoV8XmqOsEiMa7YOXngLNM?=
 =?us-ascii?Q?EtwX7JA9dFZiWml7MPBzKxQrJXg45X2W8PXClA5fmDQ4Ez3VKKco0mn7DVyE?=
 =?us-ascii?Q?SuYerntsiJvCx7HGG+sUTMhanHWzgD/z7B7WGNrKrmjLvXxhCZ1bGAl6Xs8f?=
 =?us-ascii?Q?qf5qUg8FEExbfXyB6M1K17b1q8S4Y5m3+nQFC587dXtWdtPPjxV51MkEeV73?=
 =?us-ascii?Q?iuwxeymXFvKVQGIKzrLFHEYR4TNV8xlfN/LAhHL6MBFP8e9k7+Y/k6A7p1fi?=
 =?us-ascii?Q?J8as1Pghe+Nvapgm6YNQgy60h7kAvatEwD0Xn4Z7xurY3jbRgyA4Oq2EhJXf?=
 =?us-ascii?Q?0tSmKcovkg45BXF9VEi4y7iOykKa0KwvehrocrWgkGiuslcPEbFUKD8TQ0ex?=
 =?us-ascii?Q?3+tJb+AYOCMhIzYJq6abjXPP3q/Zt2XUVple8xEmvPrOJNjh/0wwDVZUh77m?=
 =?us-ascii?Q?xOY/tQxPwK49gwuLnBAJu/6qQkpD9pvfo8XgNS2zmoJbHwgYaMsyLzUeyD3H?=
 =?us-ascii?Q?9sQCkazgJgQTjaoFBMv/izF9bYD4ewAkNqjT3C5+SxnAO0h1S0kfD0W8Nk2U?=
 =?us-ascii?Q?tckZB+5VUv8zCcreDGsxrYuPP03cbAYzu0UkL56btJ1eki7c9GvDNChN6qIu?=
 =?us-ascii?Q?uVYITmpqzwL0506PDjPuXX8zAdAwOhLnqGyVWVVasup2T+XxqVCdHegzy0pw?=
 =?us-ascii?Q?SQifslrcCsHQrWS9fL+sGQw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 07168dbd-3feb-4ac6-b675-08ddebbeb010
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:23:58.9048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYZ4+osXtTfGhXHPdLWiLdXs7PEcQoiilgMK2BHxPt8ewQkGxNhX/2BnOXNd3tcQwZDs8AqqRFOXMqxP14H8ua+33JhpTR9qD+/3kNxUmlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6436

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
2.50.1


