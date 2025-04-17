Return-Path: <linux-spi+bounces-7656-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2CAA92E36
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE4544A36EA
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57EE221F27;
	Thu, 17 Apr 2025 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LhmTcB0g"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010024.outbound.protection.outlook.com [52.101.229.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1922171B;
	Thu, 17 Apr 2025 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932192; cv=fail; b=j5hIlInq0MDIC+o7amzYZH7a1T2cZav8nTCIynS74Aq4ny4SzkVTcis9+53Hup29Y1+EEI+MfmNDaoX/Hnab9qdnPhxL3zeykJhgthRTEBhX355ddVs6Sv/pa5lzbex5/LlJQQgm9yjFmZNNR/kK5zfgXL6iq9akiVvvWfaG/RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932192; c=relaxed/simple;
	bh=QFge7Fal05risX9m3VIDmJOy5Z0zpEXTvwhF9jMGnKg=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Udcr3di1ndCwMVvp+XSmB40rGs1mgI4nVYf1czVFEwdp/hHi4Zme1ZM6XdaFiPTNzSwK4721jw0tHIEnRQYiiIDvC4KXiecAVzsQmvBAJnBhnVpqFO8tnTq8yj267Es8GlMnVhaZQZ0gnoDWH8/lsTRTgnGT5YLixq50E+A8Wi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LhmTcB0g; arc=fail smtp.client-ip=52.101.229.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFL9M8h73/m7MhfyvzjOhhKZmc8DBodPa4KJ8Sxrjs3Vk4k4gzqdwXCpLHWkM5FC/qkHz24ncuYMFbL2Dxb7CTMR4oqmVDW/pyv++z+ELUlMRYIPBEVQriIfCTpg1UZNclCpNzqLOadvCFbOPaeMko3iOFIRmAxtGceGOqyPgT8y/9oqAeNKndnM+F/b43ez/mm9tSF84umltOagdTBnVbnRUHg7sm3NyRVsON1eNt2U2K2SolbAsKGBBLCDAI0fKIE/nccpFSVJrbGCWxNL22oI+v966P/MHViqU5IFfljSURIrHMRcjWI+T5uS5Auq3dUWuS/miQ8/328AA6mLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjnU3j3ZKZbsfZjcn8rYiYeqOIUfvcFk5FpE9pAMV9c=;
 b=KLcsqrdWDliL67NldmQSfhgs6+LWww7iDzHdLqe7dvgZsRO2k87t6wgXi4hY2Fbk4fYwCPpBPtVtJD5VTJpIqvbIlftpmqwxTOo4CEVPBOnnC68HW3riJqXZiyKepuJsGIlWuk73vSSA2+ahPfUGGeohoac3s6oKaxbq7av3QZ6PVSoO4w6KpfAf+auBOgwe/T4Qp2B5TngHkA6mu4W5/We+g9atYGyzeJwZqOWJkoa4M2MmdSPj1QPnViec7RbI7ugb+HWN4VuW+QhWAzCmKogENizgr1SwNbLLu7Cu/LWOqjMQtEmcrBcPW53lZWWWGu2sbTnMj6Ac6PSOF2OK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjnU3j3ZKZbsfZjcn8rYiYeqOIUfvcFk5FpE9pAMV9c=;
 b=LhmTcB0gZhTqiGQMsB84IGlnj+Y3dy1yooHGKWPBzTTq6PJffIt3RVOlRgy6/BDRzK17COpqOkDwBaLuAKbQILBgtMaeO639LOWqCNa2WZWqI1tyoIzbL/B+ejhCKQbq6OyU6KNVgKe1lR/L77lA8/CUn/navg9d5q2+ny8Oc10=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:23:04 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:23:04 +0000
Message-ID: <87y0vy2x0o.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 2/9] spi: sh-msiof: use dev in sh_msiof_spi_probe()
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:23:03 +0000
X-ClientProxiedBy: TYAPR01CA0008.jpnprd01.prod.outlook.com (2603:1096:404::20)
 To TYCPR01MB10914.jpnprd01.prod.outlook.com (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: c305f3c0-505d-485e-4d96-08dd7e06cd90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kukKFc5DEA8ORKgZDVaDA+srIlC9q6Szgdn1CcCWysyY6PkYoXCM/2ULfny6?=
 =?us-ascii?Q?hF5zE0VRG4IQ119VXgXDLDvAxapCaTWPwo35tnyODP2OTlR+chWd8WnuLuaE?=
 =?us-ascii?Q?IUGY884l1+Uoq96BjFyL6/ZH5YmvN8zBzOQ47LCcvg+fQTuJqZDf4WcGguTO?=
 =?us-ascii?Q?6xr0YkQeY95NN8YA46NCANJILE/f4wcdnVgjZWA4XwH2LftXIjo+y4P+hRp2?=
 =?us-ascii?Q?3X4aZV61utgbrTPiqwxKOHEBJRN5P1oOuLL27Y9nbHD+ADs8uG9FcEsR/ysB?=
 =?us-ascii?Q?AA0yBYsURvyf5UD0aJ9bPEl1jTbmEsohsNKo4IzL2iDLZhfm1RxXwIuHd/Ot?=
 =?us-ascii?Q?MCYa6MAlZWJzyPgMKBLO6C2h8XUkxGoqwdTucktiHx/IqUrRLkW9rRzypC5P?=
 =?us-ascii?Q?K8ogr2d2NLWsIZfFFAYbVJs3cUY+46GansZoX25OtT+mMRQRAV1hSg1CFbdi?=
 =?us-ascii?Q?gJ51WXSEfEf+hxpI0ol1Z7Z3cjMzFR+j74k1soKCvDrjrOYb0LdFE2KJLJvX?=
 =?us-ascii?Q?UhXr7Y0ZhAe3cKFp0NqxLwelMJODXwPoUHR51cPUoryPOcis6s5MeOUuVGyw?=
 =?us-ascii?Q?jq2/W9dbs7EaxUhPCSiLXj78aMJEbftoouORI5PM5Eghn6WghYjnl3OhWXu2?=
 =?us-ascii?Q?h5RJeys8Oz9GMMU42fkC3zhAeZIzuFxNv7s9btbmR80TCjFjHfP4k95Yg0Z3?=
 =?us-ascii?Q?Nz9vKskH2XIL4UIgc1T/W8xOrxa+CmP9BuFA9ryOjHI+sZKHXwaQQ2bDfCD9?=
 =?us-ascii?Q?THD8u5fqe2tATBT2i7f418lIW9iQxEAA+rkWhjE2FQS5A7h9a6yPBcHUIMwV?=
 =?us-ascii?Q?vqDx+Dyn7R5yE1m9LZ29ZSy8BtXJ54vEalxJ2hkKQJNz8cBibmN9OSPRr992?=
 =?us-ascii?Q?Y0Br+iU9/sSc0oHhgWyJ1LGtTi6VjFUei35naDSgudcrsGyNJdGv5NK9LcCV?=
 =?us-ascii?Q?yH6j+FHJwrbVn2fEYRTeoMb2P50d9+pxwwIxan1sgp24xJzom0sXa6Ybw0Hc?=
 =?us-ascii?Q?UznYCTo6lkrHGnKKeloYBxgpubYaNjAJ9V2TrB7ZgXl+hUoKwNOwcP9X3AQa?=
 =?us-ascii?Q?rmlFjeSGXlE9WOnYOObm773c/TYXNO8uJL23zTUXOX+WIatXehm8UJpK9YEW?=
 =?us-ascii?Q?dTIl1ksvYfvpfX5YnPJAdxcW2zHxAd1sz/yTRHzkVfqaUfQddkLVFhyyYWSm?=
 =?us-ascii?Q?PtXsqVo+D1bqz5zl1XxFE8ABKkW2/Fg1rUDAlBDu9BvSwne91SE15cOfqIPb?=
 =?us-ascii?Q?jOCuZ5r5uaZ5ApCZX7AhiJkTIkl57TSYSKfqs/4mXIP8Tz+mX+UcKSh6DLpE?=
 =?us-ascii?Q?2KcTRvMCsuXHWt5fm0NSLMoQY/DZlmXhz5WQYn4/TQ1xW+6imiiQYUHbLSEq?=
 =?us-ascii?Q?3e8H9tCxrq/aF0flHLjcyKtTfy9TlLHRT55ntv/l+qKfjLDr6V/hAW/EELUm?=
 =?us-ascii?Q?Nqs6p6XlPuTY+ZeCE1XaTs8Um5CUpoyfM952ZEzujXHnIsF+73chIkVWJd2I?=
 =?us-ascii?Q?Y/OPHraCxAmcbJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/6eXErmcxPigWvMc8IL0WZqxkHJio3cZrxLsChVgpKrwiW18DaTRytRXdca6?=
 =?us-ascii?Q?wZxH78JJoRUm1Ck84wDEP/kF88AXMar0Npf4kszOOoFGRFo9bw8I8NSahtt3?=
 =?us-ascii?Q?jDtIbWEk9UtMpT+79tF9hHPB1nvDGwmgMPJIS1AvRpkQMRWYtJH4D/+/BJsw?=
 =?us-ascii?Q?DF7+QO4RFzpMXvLpOkLY1eRQ+MsbXm/85t0UOqQWWLhsYQVz6/hbMcYD++w1?=
 =?us-ascii?Q?mBZ55WG4IgOrzlIdH+5tctL2SePoqB/RVf/9i510XUSzPAqKiFKIPiL7083w?=
 =?us-ascii?Q?vXBwJEjJfKnZQaWWKODjmG5uuElTOoNW/OCFGv+6x5lWVLYBQ4e2ufk/1K5b?=
 =?us-ascii?Q?4tXy9YiGrLgNQXB/xkhF4NvW45WpZBKzy9Izfg67xiVRUJazvt9SmBwU0wmd?=
 =?us-ascii?Q?hIHoabwim7zGoqi9ApuFvXY2GcN2zMKivYsvBmplai1OKLq4cNI8NpFAu7ny?=
 =?us-ascii?Q?OakcZy1rir+qX1+BOdfJ0qRiRRvcp9hrSOVKNGILc1AF/gySWsi/tBzzq2b8?=
 =?us-ascii?Q?0eRSd1sxNUpjtT//YIfnO0V7QHaLAeNlf1NpOurr4i+NRBjorVHKCS4fka0R?=
 =?us-ascii?Q?1PxdcDBKLIHP5jkS4hN/zbuABAcpIxxZHhjjgKlKWarcos1oTmyWqXyMXPdv?=
 =?us-ascii?Q?cngtBPBBZFcyiObOzPTN46p9orjrcf3QokKJnxY3mrERolMK8gE/VZ4e/PwK?=
 =?us-ascii?Q?XEUaQKmceG1EmcnWLjB+oqADneo1eCUnzaAp9uprBBpwEGEba7tdvtLujOx7?=
 =?us-ascii?Q?85sDeTGe6cbv544mIAePZaH2i+1i+xfB5VUlJ0Z3VUTQeP9Q616xbJ1cl9+H?=
 =?us-ascii?Q?nvjfTSP0VEZJGc8fhqAN+ncPd8W4LvCp+QLKI5LIubgHIIo+zuU1MMTWXtHc?=
 =?us-ascii?Q?KpYvHf42rEb73f2WgfZ4Jpdv+AkdSxakxEJr+E7WirNrH1HyaLHl4Cl7LS+6?=
 =?us-ascii?Q?Q5xY9V598e/ZvrF6vK7dWaX/p4r3tIb8W6ZV7YOMrploFIZHIbylTh7TxsDa?=
 =?us-ascii?Q?Fx+Hq+0k99N1c3sBI55ZqIkEjg03Vp//RgS9A8OTxa6ixclpxbU6juLk0P7f?=
 =?us-ascii?Q?iTP1IbyfPFns649D4r70JdRJjl8TbOEurL26Kpakln7eR+/nGwNeP4DV7rnl?=
 =?us-ascii?Q?CEPnYAwgmJWEaxomKvpVRnK5i/F42wwkwrMOI3jc2tm3nsde+tvH+pgHWuHh?=
 =?us-ascii?Q?ge/5XS8/SI9/rCBziDDPRuBo7xEnT5xBbdw9GDWFZBet1tfzl56ueQBHoxkR?=
 =?us-ascii?Q?cthbz2Q+FWP6Knte8xPTX150Z+opJq8YuMGc4Ekltcc9bM9jyaZ23i2jgsIT?=
 =?us-ascii?Q?IvsBwrXEA50psImrMaFTSim3XsuZA4oeox/3NK8K4YSKZjyUbGrlcxQGBqAG?=
 =?us-ascii?Q?aSTMKSssnvDYyG+1X3Nsnr/koxcxmKuwnxFLYzdG7pwVauC7XTD9t+oIfw0w?=
 =?us-ascii?Q?U3PDqZGnbAN7w2YSQQ2vMIF0UHntmfghvZYD13ZW6PTPbZ7RQ72oJ90kieAV?=
 =?us-ascii?Q?MyzB2+0ONG+9aRcGKZovfiPEPab/VVcKtwzsRkeB1ddA/gX4QerR623v3OpK?=
 =?us-ascii?Q?rzTXDJMyqd0q3yKmLfjMtiMUlf0KeOTwUCdFYR26b5lLNuphOatn+oFQ1RpG?=
 =?us-ascii?Q?A5K3JIO2qCiWYGD2z5wExYU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c305f3c0-505d-485e-4d96-08dd7e06cd90
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:23:04.1940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoJm/XxpSwjiVfnEJkh6z9ggrh5Q5hLtBgqG/VbLRoTgrGVLO7GKGDG2k+t6bL+pHCR7FOeOIhabS8YFNm7ig8FfoTCifh94YwZw+9kKg5ZQlABGcjCYFsFJEi9JeDMn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

sh_msiof_spi_probe() is using priv->dev everywhere,
but it makes code long. Create struct device *dev and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8a98c313548e3..581cec19cb770 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1276,20 +1276,21 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	const struct sh_msiof_chipdata *chipdata;
 	struct sh_msiof_spi_info *info;
 	struct sh_msiof_spi_priv *p;
+	struct device *dev = &pdev->dev;
 	unsigned long clksrc;
 	int i;
 	int ret;
 
-	chipdata = of_device_get_match_data(&pdev->dev);
+	chipdata = of_device_get_match_data(dev);
 	if (chipdata) {
-		info = sh_msiof_spi_parse_dt(&pdev->dev);
+		info = sh_msiof_spi_parse_dt(dev);
 	} else {
 		chipdata = (const void *)pdev->id_entry->driver_data;
-		info = dev_get_platdata(&pdev->dev);
+		info = dev_get_platdata(dev);
 	}
 
 	if (!info) {
-		dev_err(&pdev->dev, "failed to obtain device info\n");
+		dev_err(dev, "failed to obtain device info\n");
 		return -ENXIO;
 	}
 
@@ -1297,11 +1298,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		info->dtdl = 200;
 
 	if (info->mode == MSIOF_SPI_TARGET)
-		ctlr = spi_alloc_target(&pdev->dev,
-				        sizeof(struct sh_msiof_spi_priv));
+		ctlr = spi_alloc_target(dev, sizeof(struct sh_msiof_spi_priv));
 	else
-		ctlr = spi_alloc_host(&pdev->dev,
-				      sizeof(struct sh_msiof_spi_priv));
+		ctlr = spi_alloc_host(dev, sizeof(struct sh_msiof_spi_priv));
 	if (ctlr == NULL)
 		return -ENOMEM;
 
@@ -1315,9 +1314,9 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	init_completion(&p->done);
 	init_completion(&p->done_txdma);
 
-	p->clk = devm_clk_get(&pdev->dev, NULL);
+	p->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(p->clk)) {
-		dev_err(&pdev->dev, "cannot get clock\n");
+		dev_err(dev, "cannot get clock\n");
 		ret = PTR_ERR(p->clk);
 		goto err1;
 	}
@@ -1334,15 +1333,14 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	ret = devm_request_irq(&pdev->dev, i, sh_msiof_spi_irq, 0,
-			       dev_name(&pdev->dev), p);
+	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(&pdev->dev), p);
 	if (ret) {
-		dev_err(&pdev->dev, "unable to request irq\n");
+		dev_err(dev, "unable to request irq\n");
 		goto err1;
 	}
 
 	p->pdev = pdev;
-	pm_runtime_enable(&pdev->dev);
+	pm_runtime_enable(dev);
 
 	/* Platform data may override FIFO sizes */
 	p->tx_fifo_size = chipdata->tx_fifo_size;
@@ -1361,7 +1359,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	ctlr->flags = chipdata->ctlr_flags;
 	ctlr->bus_num = pdev->id;
 	ctlr->num_chipselect = p->info->num_chipselect;
-	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->dev.of_node = dev->of_node;
 	ctlr->setup = sh_msiof_spi_setup;
 	ctlr->prepare_message = sh_msiof_prepare_message;
 	ctlr->target_abort = sh_msiof_target_abort;
@@ -1373,11 +1371,11 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
 	ret = sh_msiof_request_dma(p);
 	if (ret < 0)
-		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
+		dev_warn(dev, "DMA not available, using PIO\n");
 
-	ret = devm_spi_register_controller(&pdev->dev, ctlr);
+	ret = devm_spi_register_controller(dev, ctlr);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "devm_spi_register_controller error.\n");
+		dev_err(dev, "devm_spi_register_controller error.\n");
 		goto err2;
 	}
 
@@ -1385,7 +1383,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 
  err2:
 	sh_msiof_release_dma(p);
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
  err1:
 	spi_controller_put(ctlr);
 	return ret;
-- 
2.43.0


