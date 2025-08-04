Return-Path: <linux-spi+bounces-9277-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE5FB1A990
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 21:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4773A540F
	for <lists+linux-spi@lfdr.de>; Mon,  4 Aug 2025 19:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8CC28B400;
	Mon,  4 Aug 2025 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="jxILdh/W"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020122.outbound.protection.outlook.com [52.101.69.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEC223373D;
	Mon,  4 Aug 2025 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754335311; cv=fail; b=fI8FW7ZK/JsdZ/hYvwEzvgInauvQgqLB38p862+jhKcnmui3hVKJ5h64bhhoWv0Hco6Pt/YjLwHzOL5/ZUxz9YfOvkU0RAyoZhzEQQdpsMMhfQkA0fW2N3AaSenGJlaQ2IJp4igGupWnfRYqF61tf/3L9cWaVI8ynV9iL1/pM1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754335311; c=relaxed/simple;
	bh=GxzkJZqVV5f89LXuc/29VDCh/LRT1YyYzT1otNiWoLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NNseT5EwbxwrSqkGL+NGear/msJto5iGcFenh7bHnX1q67RPeKexgmVV/jyFoV6hGiXmv82mx0rb2GZWxeOUBTFrpeLgtn/6acfoG6aCINcZK0U3SEROorh/VIs4Nt3I7Oy37iyx94XR/QbJADe0gRtjNmdHWvzF/+910jsArU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=jxILdh/W; arc=fail smtp.client-ip=52.101.69.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JRo90yzXW2Ef999jaYjNJN+S/7WpRUHNxzQNF6a2ifFrz1wYjI8z0wM7p+2Hb2Ketc4bb5me9a6eMD52xD9yLxUOJRE+pqQdyjaTekHselfAvT4ezT1LgHXLk6twIYYRTDkjbWmjvAo1pXZXslOU3eHWYmy4NlM/vdPhBD8EEwlucRArzvTu46IlFcv4eHkKtueUOn9nMhquManxyPbm7N+XmhXzKqZMO46uJZtn8JdcoCXBUEJu9mfc1IVXe1pCVFj5uI64vv8MOOkhFqKlJ60uLH48+crJ43WHCm6ftalSxtT8A7HTm1M+n9LVQr58PZ4rdHmqV3lAqQeZCm/oaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkgThLF+kcjzUNTmCPXJceKxHzl2DBmQRyw5RMCTthg=;
 b=rpEDVL0eO15NQ/zxi7eo5BLzjjipb5PQn+kcqGNygFwFJTEc1ZFk/reaVyxXUZaDMIAHECKYRCGm556Kny3UzlfYDoZMxQs6MNLItFpkRVLY22PVBcbjoAgM58iNuioOrQri+uuZ0mxGvTekmCy/3S3THqLvHxaSfWJ182/V0v9Pce48SZL/qZDfAHahhffAWUx+MVI2vmlGOqzeDKM6JdnCDAcMnbmEIknCiGIrPRFE7OoOOfb9y3VSHnXQXkyk6E31Fz12Odt3v6Z9ujaCq/hvvFIsmpJbu9pT+WEQmsA73Uqymf8Doo3+yJDdpWbjnm4JENHHpMoPLA8NDMMBTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkgThLF+kcjzUNTmCPXJceKxHzl2DBmQRyw5RMCTthg=;
 b=jxILdh/Wlm05y+6IHbMxSDNi1vHf/OdK+okUeXRizo2OgFadMrxfWaEDth/Y5fhbOYS5PzdL//ylNq/yo3BhpiWU2ILa9foqRts1RWAWPpkLEXHOCc/VQ/e13xOE0EPrFVXOLcr2mOwoCH6Tsnf6VIG0hrYTlQQdXKpH/rV4BEeloifBVz5eCzjjrMSheBeozU//KwR/Fe5inCab/6r5WLO0tHoBGVs7UKkkGzcedjC42qTkr/1jjxuy+eZGRwiH8oG85o+z1JL+errxPpoSKhGjBW7a5BdnfUhg7sEkCzGkcUiMXCAsK6aZvB6REiaC65lbxQXvcSgzHfYtoo1SIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBBPR08MB10844.eurprd08.prod.outlook.com (2603:10a6:10:538::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 4 Aug
 2025 19:21:43 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 19:21:43 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH 1/4] drivers: mtd: spi-nand: fix direct mapping creation sizes.
Date: Mon,  4 Aug 2025 22:21:29 +0300
Message-ID: <20250804192132.1406387-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBBPR08MB10844:EE_
X-MS-Office365-Filtering-Correlation-Id: ee90a7fd-bee9-4b28-76bd-08ddd38c2568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QLTxEfzlwzseiTCbJrpDdEF/LgKNb5J4K1u160gh4Hiog+PKvSLxQGKBJsV8?=
 =?us-ascii?Q?goMYo45Yi1LpSdkPItL/mNCJjDoUm6/+ztiR+rUjpJgVl2NyNQxo/wOqX8PD?=
 =?us-ascii?Q?ODiZ1sotpuCcBvaczP0/W6ULjXUr3wjxDNPD7r1ibrU5WaiDPop2yPPo8l9T?=
 =?us-ascii?Q?MnWlsTr3z2IgB8qgRCcdVCL/4XvDtvQMvBVAIM50Eg46gGmhZOHydHPAKtwO?=
 =?us-ascii?Q?yqDTguqL5P0nCsY1KDGiCcWYzpnrlWtKsZA/DEi5+OWaM/2+wx1cpsQk74Zm?=
 =?us-ascii?Q?ZjKWlhmNi6jNic5U1lh85R0Yc9N4n6G6YKlpAynLy1lvO8K3sJbQ5MVf/4Iv?=
 =?us-ascii?Q?pwK+pF0qTmnNzRMrgSTqzjAkQuEV57Zx8aMUuu0O2ua/t7ZvhVN8a83dt7Xr?=
 =?us-ascii?Q?BQqbAMySbhSL6pW6aXbotc6RH7MxuQXnaIyVR3TEbpf/K+CJmPP4i0Pc1rwy?=
 =?us-ascii?Q?y5pgnFVulB9l8/xFJ6xuOQVG5S8nIc1MKqsYNYDtBx/oqmlPAKZ/P5CPNkSS?=
 =?us-ascii?Q?GcZLSMtLclbe+SninewTbQchyTXCsO+3jZj5oWHaKxbl91+sZgK1+ZdbIfOM?=
 =?us-ascii?Q?sC6lZwdHTRUp7ADMC9qXwt9Q71tyAR16EcIneEtZ3jJertUe4UGIqUQOfWzP?=
 =?us-ascii?Q?KEBBFsObIOxpd3uK06WoHtdUALyjxm4JbWwJlmezb5iONEIccQTjA/k+Ym+J?=
 =?us-ascii?Q?CwePtpypn6aJ/Nm0btdohyLrq/CeC/kBEkncpDnjWf8QAApwQ4b6iKYoOFXX?=
 =?us-ascii?Q?fUARBP1bEzLQwWbPQAk2g4FGlfX58jaX3xbDPLybUGFMuO/y6gorTDJZmPmB?=
 =?us-ascii?Q?f8AESBBpqLV5bTZDyrFHqjzGhYaX8GoomexoXPFduHMUJ/dz3yffpvQ7I9fj?=
 =?us-ascii?Q?+Xox0HSDSFAPmcoxvey89pmjeRbs64IL2uIxdhQZlJlVr8QKESJ76MBchfkK?=
 =?us-ascii?Q?V2tDVl0W6ZJ2t8Wr8jghSRTJ+eScvl0wMadRLf6CGBwbCvY6QtaKJYFSrvT5?=
 =?us-ascii?Q?HjBdPHLPSAJnCDMyqI7YjnnfV5tf2Ux/oqPiSozdqHOuwitad5wY+5VIWMyY?=
 =?us-ascii?Q?F7FaiMCtxNEKCirzH1u9YHXjL19jyBIzYcwh9AgFM6433gwd8BrII+UPhVBB?=
 =?us-ascii?Q?qIWpLEbhjcHp09cr46QRSKVbxmypTQzPFBuGzYsG8qlywUzIT2l9L8+KBgtT?=
 =?us-ascii?Q?o8hsejyUFxwPrPlLeZ9FYdsNi2oYLVzQuN8EcF5FwBlSlGDebHjKiBtsZi5C?=
 =?us-ascii?Q?RcZdBEWVRpB0MCqGPIz4MpYAxXImYp0bfKHW5zH42tcT9/F+k6UM5U11yX9x?=
 =?us-ascii?Q?NEmviDcMCycRtT+kIKZETVVyx6abfb7uTqwefZqHLVjHm+Zcyf6DdruEpQ2k?=
 =?us-ascii?Q?hN71a6InXyggpA1NE4EAu0W2yq/IqGkJIgkCHrNIviwW/BjDOXkCgz8Em+MG?=
 =?us-ascii?Q?LJ9rjHfKRkQLcsBRijd4m0keFZKxKwFdjPGCcPS6lFbOu0UG54Z1+/NFTMeD?=
 =?us-ascii?Q?UYh23HJl8iXBJXc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2p9q4d7XV4R+qxL2m9C2j4qozIaiQZgsEwLSpSnKqnhneyfFfXGPa240A26U?=
 =?us-ascii?Q?i2ZbBp3P6esE4GzbhYQSEP5rph5QcEjnwW7daZdp+5+cxmKSiwZKE0O4GrkG?=
 =?us-ascii?Q?lB2FLtuf0VxxCdmhv229ZfdDgFqslagZWPu0TtfKxLWfraPHuA2nz2q8iDCK?=
 =?us-ascii?Q?N8PnDchsfOZ7M4z//ZVw2s8mKCYPust8tXlyn1nLyCBl4s4WXteu0v6k2Kjf?=
 =?us-ascii?Q?ggjF4FS4hchGyQLDUKdLTkrDIAaDGh2VkJSJ/UnNXEFYXm79525OLGWXvfHk?=
 =?us-ascii?Q?Xfx/Taz/5NlJf7TPprwgIhfd2AgUHsyB4NHBUnS2XGrWx+12jrRQEuxcxd3t?=
 =?us-ascii?Q?gejc0zOLtOQfilpJFcg0nNQ/137CdLrF2COYrvotCBQhxbwiq3H4vStmkOV9?=
 =?us-ascii?Q?MefTLsgOVQr3Bn4f244P9WclKs8vqGvvh2V1UAjbu8C2PIl6tzAYu9I0zSrM?=
 =?us-ascii?Q?6og+qzaRhsN4iINuwxm+mY9GpCMNp91riFuUFgefyeHG22SznUzcg7SNiqF4?=
 =?us-ascii?Q?7TNitEV1VlflLwMOj70ROHaCo7cH9hjUk6PXmARYOFbFMwcaUY0kj2RfxNDq?=
 =?us-ascii?Q?uf4Wo66TCg37qHGF62zUpa4URMERExk1s1Wc5vb98dAjVmlfjYls+NQdGEbS?=
 =?us-ascii?Q?4AL6V9OMVSWu7fx+WcrQloJH8wYxILDbvsW0a3F20lF/c9fKfZCBWAK62xjv?=
 =?us-ascii?Q?eS7NqPdrOZhPnegwfcs06bh2rH5Qk3I289P7kRjl8dsCoAii8AGI8Y9czyDM?=
 =?us-ascii?Q?E/ex02EnrREPZH6QilqB+sUtFjkx1kGQMS2A8/dBdSCRTpYllO7oCPEUPE0H?=
 =?us-ascii?Q?gvm8pHWNWyp6YALryMlMZS95IlnYHayiI5xJbWXt8tyEGg6BHJOdHpeCnZ1H?=
 =?us-ascii?Q?MjjeaUMMJwdyG08hrvnraC1+ikI3H+qZVBsrEzjw50Dkf7+2/E2iiEtXIKOp?=
 =?us-ascii?Q?4zNsK78IyUbbGn/OUnpsksMabhv+i5bxr1u7XjUq0W1VpB89lkDDjyu1kPBy?=
 =?us-ascii?Q?tUc8Dx23PJdq93zZCu4FhGUccBakt/8LmJEnaWLxbiCVxpzwiA8UMq5rQFpJ?=
 =?us-ascii?Q?DgQ4rQngKjUEPxHi5a9W0QG1cz/ROLOnWPHVwqfrIB1ABrZ0HeglTfyJTJiq?=
 =?us-ascii?Q?aRedayX8HsZIQQyjgYTlm+48IQdZ1WCsaBIdR93rY4AYjsrNf+lAlmcjeY4R?=
 =?us-ascii?Q?ZQKuY1Y1Su0KETke7vBU7HxYYipxdjqMaNs7wBpdBIXGnDv0FAZqqHEXB6Ro?=
 =?us-ascii?Q?vvV1sz0Gcjrs8ColGu0bTDKATUv8bPfKX4JRKz5h1hO2XLl9KMkHqoeAIBUo?=
 =?us-ascii?Q?4SLjjx20EvdOuqrntXJo0bTuPY/Dk5qtxXR+om49KBuBl7dz0VTfAYBnzRMj?=
 =?us-ascii?Q?DSgITeutEF/f9/FCxiIBr5apppndkuh1T0xIHYW0rVpjMBI2MsMhKmlv13nW?=
 =?us-ascii?Q?QgYfEfBYj0ihji8yjeeimuQxZUtzCksA+sb8nTbLWz1XQGpeN6/Ked1eDYmm?=
 =?us-ascii?Q?eWQ0ohBXzFbQRutFP0MSxIm8wF8pAtA2xfwoOyjI6FFxpiboe1LB1c5HkgBP?=
 =?us-ascii?Q?71uDjj1YsnBMgZZXY4CJQ/juzN7sSpIrKedfvA7utjO/T4KZhZ8wMbeTSPum?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ee90a7fd-bee9-4b28-76bd-08ddd38c2568
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 19:21:43.5199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +HB91TruTGjdKvIBIrQcQBLNe0KwEz19m3b81ENSk79ZuNytarOvaj8rtGS49TR80YZxBCN42ckUwZRU7v4p/OI965MBFfYGR4AOYNVLsU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB10844

Continuous mode is only supported for non-raw data reads, thus raw I/O
or non-raw writing requires only single flash page mapping.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/mtd/nand/spi/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index b0898990b2a5..b42c42ec58a4 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1103,9 +1103,6 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 	};
 	struct spi_mem_dirmap_desc *desc;
 
-	if (spinand->cont_read_possible)
-		info.length = nanddev_eraseblock_size(nand);
-
 	/* The plane number is passed in MSB just above the column address */
 	info.offset = plane << fls(nand->memorg.pagesize);
 
@@ -1117,6 +1114,8 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 
 	spinand->dirmaps[plane].wdesc = desc;
 
+	if (spinand->cont_read_possible)
+		info.length = nanddev_eraseblock_size(nand);
 	info.op_tmpl = *spinand->op_templates.read_cache;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
 					  spinand->spimem, &info);
@@ -1132,6 +1131,9 @@ static int spinand_create_dirmap(struct spinand_device *spinand,
 		return 0;
 	}
 
+	// ECC reading/writing always happen in non-continuous mode
+	info.length = nanddev_page_size(nand) + nanddev_per_page_oobsize(nand);
+
 	info.op_tmpl = *spinand->op_templates.update_cache;
 	info.op_tmpl.data.ecc = true;
 	desc = devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
-- 
2.47.2


