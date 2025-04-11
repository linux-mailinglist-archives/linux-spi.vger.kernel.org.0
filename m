Return-Path: <linux-spi+bounces-7540-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210AAA850D7
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 03:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB7D04C3C6B
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 01:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B03F26FA46;
	Fri, 11 Apr 2025 01:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="iD2lB21T"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011015.outbound.protection.outlook.com [52.101.125.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28105B652;
	Fri, 11 Apr 2025 01:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744333422; cv=fail; b=Az0SvLuO7QODkEqct5RYblJg5FLxd5oKGqgW0oFJOkKLpjrretMs6BIA5CHpJPSxb1hWPR/ea66nkd3UjQ38gHYQcTpy8VLXfNz0edBNUqQB6V0UT18RAsaMj084a3HtZXI+1Ap0s8A67PGph15JnZuQqE/fWjO3i/jx+eC+B8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744333422; c=relaxed/simple;
	bh=6EKmRPQy3PTX/HFOgPZcfBDkoy6UM5AozdJlLUKIsPU=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=KtvF9BSFqZCj/kDmxtpVIQGs5jh32LDeltt3Xw2oXR4Kx/QkhZu+OpgEQJplPrlPoxbBwSGNA4/P/ddhO/2t0VJRtIUT3TUmBNJpyxGTAN7ofgrD+4edf01JvqFXvxWSlFkIvCtF8CS328LsQJh8PUOS1tTCqzlguSHBUTb0EC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=iD2lB21T; arc=fail smtp.client-ip=52.101.125.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFKbNVM53s1gIR/695bll5UtyDF8oFR0y6BnPb+bPZh375BBDwllePBwXQnE2c+EVHalJlLj6fRWPxHxgc7xH6fxrkpJUq4Cwc525b2Go0ZRPsv1a3pwn6gdb5dNnUR+QlEeLzm6N29LMlcPqjkUEzzZhe/tT35CqBjtfGuwBQtm3Rlx1kuJ5d2eGJPFuWTf40e7cXfb1X2u5+ny8QElUhPlzdSCmpXajUjhVpUTnNx2rb6yak4ev8ip/0RSyYspCnFjhQyjqD2qcUs2wasCZVs3rYf6MxiEKvrcR6CtY0ExK6beIdv8tRxzfJE+stcjluVg4OTl7xoR0Q4xToBJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeblINjA3gDd+rLDnU4XjYX/aHvbGiM2WhuEg0FVkBQ=;
 b=eyGVH1KsaD3ih+NeK+iClmNMoyieCFpxNSTfizkYLqCk/lNE8Ed3xfSUyLMzAMfNBYaX/ss5yjf5VWhr6pOLuB0Zk0Nyg0p5rJMnErEuwx13V2r9I3lGdQkzTgl6ycmf1hndt1FHHQ2Z6iI+TQfjMAbTmHpDuZdzUcs3L8IFtYE77lFUG82NJm61AK9qFnlGv7e1s/azJdcClgkcesimY8XWs/7/hZbfo7b7l5CiJPCNIE2T5DeaLY0aDMHkwIlSN6bZ+d6fbnL2SBszzKweMOmSkkbzTzQIvJpAJmYavXMXD2hYLRdff8a1C19Cz82pdJZMquTDAmAi+Jplv86Axw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeblINjA3gDd+rLDnU4XjYX/aHvbGiM2WhuEg0FVkBQ=;
 b=iD2lB21T8ZPsLrQ3qHL+f/1OQe36kf6HbQ7YjhfianAeb2RI/KlUtReAobY+sup1ecxIGVZ7dEtGTZB/pID+3Sir+SQw1iPhm+CC1AvZuhGu8Goby5mICSEvxD4TZ00m87K1kfDYK6aVLW9+vw44dFnTkJc7ix5Wbi/9E7nNwXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY7PR01MB13579.jpnprd01.prod.outlook.com
 (2603:1096:405:1ec::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Fri, 11 Apr
 2025 01:03:34 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 01:03:34 +0000
Message-ID: <87ecxzh5lm.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2 2/9] spi: sh-msiof: use dev in sh_msiof_spi_probe()
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 11 Apr 2025 01:03:33 +0000
X-ClientProxiedBy: TYCP286CA0018.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::9) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY7PR01MB13579:EE_
X-MS-Office365-Filtering-Correlation-Id: fb8420fe-d245-4917-fb7a-08dd7894aedc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PINDkt/S3rGJ0dIWaAy0jXk2q1WskD0JbVVi/UQKX1s7jiU9ZrfLbhvCGaUB?=
 =?us-ascii?Q?ftAK7lRU+8qVPE+xzDjKo316kdlxdA4z6c9KfsbYtMIBOOK+aSDnkah7TlRl?=
 =?us-ascii?Q?7QWaQwtt3BH7TARmArYz6AB+js8I3qthaQSg86m0te++W2ttHeDwhxlMKCf8?=
 =?us-ascii?Q?+5A5gExEyTYEbGbrZyHQuriCpcWy8IXXj+bxg53MHDwbmCVmpWxXQN+O/hfb?=
 =?us-ascii?Q?/5BVvapLu18OZmT+R70M7k2giocwKXHZaoxzXd3jjhhlVXkEsmqgNoAZufjQ?=
 =?us-ascii?Q?tY6khKPx05NrCI/gFZpNxn7WHls1JEfckDcoNAlVFEklhl+oAcFlfvwRkRRB?=
 =?us-ascii?Q?Nrif5ZhmScWvKOP6yhp1ke8bCYJzqc12ZsxmUwqzI33rY6hD1bZWKuh6+LOb?=
 =?us-ascii?Q?cV0C4ibmNpjtGPvhEfkYTcfbCmkHeY/4fUhxO7KYWoAb6/3DwR6OuYHGYCVe?=
 =?us-ascii?Q?cG+nlGH7XpczC63fMozEhTOxNYliOJG/5zW4wbeOey5Zed5WUbc3OOz+ZanK?=
 =?us-ascii?Q?4hsYShuN4Yft5AdK4Cq37KXyb/x8orsIwWbHTd04Do6MMW7GyrI6e3eS9nEj?=
 =?us-ascii?Q?fNt+TkESp5jVjqUzs6moyzqsO3JWUFmKXTt1rX2BC6BWzy6npknnhoz+Ohyo?=
 =?us-ascii?Q?1R+YTslRlqUignKSjbVg/DZn+L5chIKo+nlC7CV4GCSM/HzenEuXXXMLwBrS?=
 =?us-ascii?Q?YeH6puRk2xpwFLuzNpVp/6P0R2qL8OisQN4VHs4xC+wETh5dl+5q45fuAUx7?=
 =?us-ascii?Q?z7jrsPfgeYMqOM+4wTMijlTQ5ZrlxdqeJ84RSeMLhcfht4jxMc77CQQuwQPQ?=
 =?us-ascii?Q?R68Egwzo0klvC2KDCDJzucez6uPQcX4HRyAIEX2AbkwywxCyvSC2HOcXIBvU?=
 =?us-ascii?Q?WZDLRVe+/rxHtIgRDiengpqU2pGmpup8WxZKMP1SrMe5BqphDmUmtLLMK3k4?=
 =?us-ascii?Q?D/m+TBG8HJz46cCUcKOJ+iZ+4MvcFdns4EBYDkgAYkof8TavdKSwHLqmZhdP?=
 =?us-ascii?Q?sTrcKv4EECy4lupAdaqwSzgQeCJ3/GsX9OF8dHWvmwXkpEMVHL9UrSvbpbJY?=
 =?us-ascii?Q?sfryDSGzoUQOtcSIl4V76xm0CSzaSs+IIwggrzC2JDzGJPEFn73wETviOcUv?=
 =?us-ascii?Q?OmibH607ulDMEV48WZkffo7khQxSfaOGSDQqbVWV/d54+grE+MvChY/0Rnc+?=
 =?us-ascii?Q?K98A4Z2WLxlUay3pWMrlsSzWbSzLjiq55boFm5m1GJOB+UBESEXbsq9H0znR?=
 =?us-ascii?Q?8X07edeZraiQZ5ZS6/+PhVLgLVClQDWRP93TZEjHnjp7ZWjq79GBxDRCqwR8?=
 =?us-ascii?Q?efttkAk/gbZqhL9YGhcrh0L0gjodbBxf59S7Tu6KmcDT1yfst1sUnt30TLqP?=
 =?us-ascii?Q?lQJ49eusAP6k+gYXPUyVqDarqvT9Me7yhP0C7TOkSFYSZ/tLXvTR07nSAvv5?=
 =?us-ascii?Q?yGLLr32MWe7vc/hzORHNKg5IlHNd5b4M9sIK7qXvswIx+nw13iYyaml68WmF?=
 =?us-ascii?Q?Kqa6V/zeyn0w0hI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XM3IofsrV/wI16PCrMDNtJF42/Yvk1pIrDdJuLbomB30bli/RcoHx6xkZYxl?=
 =?us-ascii?Q?vWmPucx9v+Fzdq81FdKu0q9tPxJrqpzCniLpqNvEGxHpOmFO6Tw4ggIcCxVo?=
 =?us-ascii?Q?amCuUFC0RcLhVLrY3jQ4ym2PWHa+x0FawfnPyKc0NghbyU8QKvT63hOR/mf7?=
 =?us-ascii?Q?vyXY4wlBnTCp3D/5uX1Q8sNuJ1kGsoZjELe+c+dUeieDTnyfXNeMVa0JONbw?=
 =?us-ascii?Q?cImO4iP9EYkmLgijSXYvtcJ9+tfM6hhDnxppB8MUO75wNOfOK+6+r/XV9fVQ?=
 =?us-ascii?Q?UXKn7lM08Ii4WmY0rM+AyWm5g39ugvN5LCv6VemHY4Gplc8vCWyR9RnrBC35?=
 =?us-ascii?Q?k8tNsZYmJxIKSq1qFHLDCoxgLBodOtmBFy5kUP7GtgexV1Vgm5Es2VN2+tzz?=
 =?us-ascii?Q?wgvC3A6r8RFqR6VyS1ba1SJszH1BBA3pBXVLuCt6NVoqWlcfAG4y5LQf9WHn?=
 =?us-ascii?Q?q33lb8VyP/gukUWODWCj/7XnLmmvUGdPyeN8R/hmWPlM4jgkQVd3jX9kFLV5?=
 =?us-ascii?Q?V9t1bAvDdHCJ5nltF6gS3uLUbfIs6vT0el6hA07mokmOVZZps7up6lXqPts2?=
 =?us-ascii?Q?Ytf8iYhUHOcENPK+NJzXfxMSvo17skzq8+K9iftfd1c+8v80XkvQnyjW0Ff0?=
 =?us-ascii?Q?TSUcHy4H/tQpv7St9twKuM1abEgTyThkI18QTX418W7GkbMdumeLkx7vqn9e?=
 =?us-ascii?Q?mYZR65yhDkAORaKI3xr8tLXt3P9c+a4JA7cvbB2FA6qN4/chMv2etBAfcAg7?=
 =?us-ascii?Q?vsRpx2oaTzplyI4yFpCResbPnqlQrAzA+HBuhhAAUap19LWNsC7iL8iea7/C?=
 =?us-ascii?Q?WjAzDmAqC4swkEoS+cj9W1piCpL3MvPp1YMQfl0XhnVm6bgrd258afSSJ6Dw?=
 =?us-ascii?Q?x0amZuY4zZdZUZkTQNccdSDpjnSGNKujEcdnKDwRAcV9HZlIx9zUXfXzG1+W?=
 =?us-ascii?Q?UlsE7WbAIdNVdSJ6nZPFpXeVIdPtL7Up1xDDphLIiYp2Vij3ylyIsrj9cZll?=
 =?us-ascii?Q?jVojMAPTQcIryZgjvpFE/Qi1BOBQtg07wSmeE2tiz23EahcGMG9ABeh/b+IG?=
 =?us-ascii?Q?GcUqPSbcpXd8QktleMaHXlHNg8irJTG5nvj6w6v86/LkCZ/NiXw4UYQUCUZn?=
 =?us-ascii?Q?FcuKAVKwCV1s2F+O/mRX6N1++MAi+neR6ZmLFTgJiql/5jHp+YijJ4aQ5KQU?=
 =?us-ascii?Q?/QPRL61KcEBLwkHjxEJTFbjFNSrRWaqkjtzkkGSe44yuaaGvbJb39SOP18sX?=
 =?us-ascii?Q?Ggsa1YLsFUl36rw9dtfoQUBMAxf/92eFkBjYDuqr6aEi7E1PLksV5R3ZwO23?=
 =?us-ascii?Q?PFAl0SWvFjP1gA8XIvyFcAxxqN8/r+F9xOUT+7RRHA1hgvN+VQBpuCLgK4fM?=
 =?us-ascii?Q?rzGXWBI5HhttoJQKUiu1h2jTrH2uj50Gi5UXzK16aQ3ulppiuJy1QtFgjMyV?=
 =?us-ascii?Q?2ILXAfKDOhQFgN3GcKe1aTuTJoatSu8uyD6pkligad9fgxR1XXnQ8ZxVdN+4?=
 =?us-ascii?Q?syUeFJpY/Gje+iqTDJgWm0zKpo3fh/74neBFHE4wRWxM1KMF3l2iGoHYeVhe?=
 =?us-ascii?Q?sGG6gMPX5/h8C61xoDXs7ZD5Sb3O7KDdsZRBka6LMf6Zkn+UfbWqJXVJMT9R?=
 =?us-ascii?Q?LtdbrybNx9eq8jWcOJa3bfQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8420fe-d245-4917-fb7a-08dd7894aedc
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 01:03:34.1949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BW3pAUU9PZ7rK3idj3F1rMmTmclcKDMpVroxs77YWx72r/Fs0h0DybKTaHpzx5lIR0TXp5MuwSW8d3S5kbHjCEekDgk6i1sb1iwgbTsA1s4wpfOGOyqoVgroGFuiTvXm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13579

sh_msiof_spi_probe() is using priv->dev everywhare,
but makes code long. Create struct device *dev and use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/spi/spi-sh-msiof.c | 36 +++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 8a98c313548e..581cec19cb77 100644
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


