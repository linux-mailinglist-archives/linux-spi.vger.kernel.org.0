Return-Path: <linux-spi+bounces-9331-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB468B1F01F
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 23:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86775A5B7F
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 21:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDAE2571DD;
	Fri,  8 Aug 2025 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="2KoGsURO"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023080.outbound.protection.outlook.com [52.101.72.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6325A2C3;
	Fri,  8 Aug 2025 21:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686932; cv=fail; b=j/aa1fjzYmHOrSspm4yRRZ+soaI2SElPx8HUCxGAoHMzOYYf7cDokWG5FWLLexPEtYOqRnmFH6wW+suhtOecHzA38OofG0SPMbWssS7+/d4VFdDyhyPpBkcVg9nKMq6E2RKoPiPusDfUQ731XksX6221IRfnXBlvJlyKlnZV/K8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686932; c=relaxed/simple;
	bh=AfEfCBnAM0/Kx8tkEurMUWUbJjo2jjPJSDPJRNKNJdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dh+0Ush5a/LcrN2W7Iom9pZ3vUvwhFPoXXQK8vwYhUCo3Se+DWpCpYEntkVAe0uZAcRl0EeYhnaLpoN7B9XwjMaKgToG3IxQcN6Co+uFxfiGcVKjvtsZYdM5F/bonLhEyZqSlGYjKyBcJhR/62DvnWSnpwhwJ3mPWBLyP017Zqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=2KoGsURO; arc=fail smtp.client-ip=52.101.72.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+VZL/Ao9p4dg4Z7D5mblWbI2AKC/rbl4dQfH7jWUtwaISvgK+3JVOnmenVAxJuJti84XlPRzrfzAu/KhT5y1ev5/9m9/APK29L2JzUOqqjG18nnBPGqLmqogTzHgxN6MyTbtO77eraHbBi5uEjpfHougAyL0bXV1epnl43NOVh8IrBUwZasSBJyulP8hHaVWkB4zL68sz7FdB3ZKzxT6kOWh+XrUxITJhnq/gwCWtC/l8xvI7ew6xIh/XuaOl7W+oDHdn3pl5t7cgNF+yclzSeQEjGVWRh96iJZJXkqvdPfmW4oIdO3CD2SGkVsY7pAPU6ZZ8Bo22fYXK/LkRhbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jkk+3t535n4/UAVvjzJbOsMv5YHbb19o1eB9ufbaG6U=;
 b=vBkzq3AIlguOJEsnJ5dqpjS+UepMdGiFGEgFTbPiGm1ROuUkfoBpFDKHBgNgbsyV2wEvkeSIwNzt4Gbc96E+dA2BaVBiuQSwU581glRnUMiNzYdmUfOPfWGLhdbTg1bk4ObIKKdLE1d/0sTlAvCpZ5GWx/5RjyyWargQksR4/3cCA/Dg159M+Pg+6QriCLEWJ1aL9088049dlHy4TSxJOOXvKKxFYEIimUMIuTBC5CSdU6THjjCGj2sY25PtTB4LvxJmvFuWdFBdB3xnzvwcxcBfygZDiMxGdZfTEHD6YdygJX5sV993OjzMfQ2TnIQPNYWTNquM3MlDuxPjj3fPLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jkk+3t535n4/UAVvjzJbOsMv5YHbb19o1eB9ufbaG6U=;
 b=2KoGsUROtkBMbyqPwiIjjcvTl1FGLEZbxQKqiXD9i7CayyywJndWJyasNfTsxkbCLJxHob6wERXQbPURTtlJe5+Q+pWaXwI2IyI9seWs9BTeksmhg3TdTOVkHV7e6obHdQ4TaCAcQXV+3fFfqfwUcAp+nW3icQ4OF5Xo4K4ekTF6I8inyXOnSXFyZEUOq/DfnY3P6M2M4iQ8ECEtgDykLCgh6XbLM78Og6b1IchjVn5QLsEL464Ez4qXld7UFEcKzilQdMluyaYESvlaj8V8OxAibfF2OF5nEosAPeUtENPwNjIpFSIhDL8aV1xUbIxsZ9QlpledGpZAtlWXXtpBUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9739.eurprd08.prod.outlook.com (2603:10a6:20b:605::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 21:02:03 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 8 Aug 2025
 21:02:03 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 4/4] spi: spi-airoha-snfi: return an error for continuous mode dirmap creation cases
Date: Sat,  9 Aug 2025 00:01:47 +0300
Message-ID: <20250808210147.3085391-5-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250808210147.3085391-1-mikhail.kshevetskiy@iopsys.eu>
References: <87cy98g6ts.fsf@bootlin.com>
 <20250808210147.3085391-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a234dfe-458c-4fbd-22f1-08ddd6bed354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0BJabd7NwZVygzgjTw7YDCFPeb96DdGA+ovvMSDJdtXzRup8is2RdoyNzaAh?=
 =?us-ascii?Q?6k5y9jJXZmzpaYtolWuMlUkePcxkO7drsZe4AAOhcLn4k3lqsbf5gNx31thV?=
 =?us-ascii?Q?38r0DE+fLP1YPrQJm1+hy7K/xCNBUrNsrWRGc+WwNaDfzgnVepkluza0tyRz?=
 =?us-ascii?Q?Wu8yPWww1vbZfnILenjyhXhzfaVddgDyQanDiFmzQZRHLuWHp40GWae0zioa?=
 =?us-ascii?Q?WuoASblrSwcab1kjqobPTlGYLsEqrXe6YfZy30Oiy1ipEbtmUk754ZSpz4Bn?=
 =?us-ascii?Q?5R/lCo3aRVYtXZiS1uZ6h0ifW+3XYfeXfWfkILeuIVMKbTGePOr8Z4EcT7+J?=
 =?us-ascii?Q?2aSzlactLvI3MgpHDKZ4z3nR3cb0MFnmy6XL/YiwVRVuw8MKqA+gze9EHKpo?=
 =?us-ascii?Q?vXbjmS7R+nLL8q/OtxUUgKDZnJCKyLcjVuS5sSkS4dea2AwDDIjhvJ9sRhav?=
 =?us-ascii?Q?5Y98X4MLbubKJTaeqQdF10xitMeIuPXuRSzHEUEXVekRHu7UckSGlrMsLFlB?=
 =?us-ascii?Q?mDJHeoAD0EJ/kWhMarv1Wkymc+2cRTcvU9T3kZcK5HVboxddrRNInvvJlGM0?=
 =?us-ascii?Q?rjNGYCniQHyocCiUuV17oQWuteTlpClRSNxDAL/b1NJgHRX8+nLTDg3bKuir?=
 =?us-ascii?Q?Z7rSrUmm5Fi7Cs034wFEWvsGm5ZBrXB1kUSEfDFmltqTMBiIOBGtrXd3fL/Z?=
 =?us-ascii?Q?AYnLyYfPiOMjSVOTQQbcp/zFdXR9yqObzvgN9LT+Jyo8g336wsLdla5hsllR?=
 =?us-ascii?Q?JZIJvhrIV8u50Ekty0OgsMzNU7weSqjsCdtRDtHOJH0rmscR7v02SMH/8720?=
 =?us-ascii?Q?MSAFBnrLtq9wa2BwAQm9ol51aMciDioBWclvZt0cGl9cjNqO4/Xhe68OEFcu?=
 =?us-ascii?Q?Vl66DrUKcZHMoX+czUJNC0aL+z4YXLkQQM2HdvdGTvMtHLyztJc870GJOYZp?=
 =?us-ascii?Q?PrYd7rzsHuIKCalurNxhIAp/E0upbT6OYUp3IMmqO1vE63A/3hAcEHkfBHbZ?=
 =?us-ascii?Q?m6GHPmvOspRRxpJ+40yQbpb93hn+3AZHX22XrmxrQ0WlaY+S36PWCbPN4b/+?=
 =?us-ascii?Q?JeTn85ep03Ho2FSXSbN+86zgNLVE1nV75pifh717H2iCPgm+kuExWkXWeSfU?=
 =?us-ascii?Q?tnjcAzvlPe78wWCWW189i9c7veOYpU9lgyJ13Vm+oh7tErAoA2vADqAVRl/k?=
 =?us-ascii?Q?u0w7Za3ZdHpZhGIHK1CCKowKq5GPRA6NJ00o4S+CeOLPRoX0c9ZnDYyfwA9y?=
 =?us-ascii?Q?kuVEQgxzGS/hmQOfJ6OTygSrClPTo88uJZrSHky1YympPJpmV15gjXveQ5FA?=
 =?us-ascii?Q?MZBUTa/S2ZwZRxzvRrnqTg7vlTxNtQTzcn4EvxuotZ9vtDWYn3pYjPCfmfLx?=
 =?us-ascii?Q?erc8TYFL9q2Nvw2jI2Zo3F7YC/WasSlU3sH4ITS6vBSDMVHsprgbzJINf3GD?=
 =?us-ascii?Q?b98m2MT6l0nqTA0Fs0dkt8p/Eu6Oc6FZWfNmY8UjE1Sbjdv/jkcpz3JMt3BW?=
 =?us-ascii?Q?sn4O2RadRKiOSPM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tcv1yc6EWKezAtVEysq6xWrruyeXwjAAgiVGJ+7xdBg9jfDqecfyLeL6IY9P?=
 =?us-ascii?Q?E3iO1EZtXF8kSxNQcJR54TOniH59fH5mBSxLD4Nh6L1akuyiwGHxbdKVgIYh?=
 =?us-ascii?Q?ZAuNKZGQ0bF4kcqgfilWhAd5rwP1o+7PcD7lXYkzpJQIQzEwET2mtUATNiC1?=
 =?us-ascii?Q?g+Hzkyb2dhVFhtWghe//+cx5wIqs7UlAWq0qJrkajTP6MZf0gbxNORS47ok1?=
 =?us-ascii?Q?jwK9mSkFeM/HQAEOg5oiC+Y8ongGA9CSiCA/OcSE1OhjAQMV89q1FLbi/7ml?=
 =?us-ascii?Q?nTT3Zb9S27n8HX7H2AjxT/JThYXtsIibWhDRkM5+Z9nkRBsRRrh1y7hOCZZn?=
 =?us-ascii?Q?KFmM7E0p2X8MVWElEwktNvv+vD7fHafjWJAwOvz82z809VOJAMSXb8bExRcA?=
 =?us-ascii?Q?ih7+3KfiLfBuW56Gqp06+Y7y+auTe4xl4L7d5YeEU9tI1AIB47kB37NAIZz8?=
 =?us-ascii?Q?q2ZfnVu27OBPxhFXsmxq5iShenT2ldHwDZ+OuYlxs6DjIYg4VIyV4NcZKQga?=
 =?us-ascii?Q?h8glUQ+lNsF26cm7U5XmnWdSrsDYYHWs+yKgU9dkP71blcHQ241FKCoKvoRS?=
 =?us-ascii?Q?6RbPh8yJIqKAMsvjKvjb2k0cY5t7NMbyxxlYzeWGqsWPh02hz7QxqMC3G7sn?=
 =?us-ascii?Q?wxdC+8ECa8FPALf+O44gkSxN1jRC0AzrpQrsbvW+h5ZG6Cr11h9gxaLR//kj?=
 =?us-ascii?Q?PbjusRktwbdRPO8tEQk9UmeHfQapzU+QtDa4knDQaj2QKgZiKUuegHMHpNFU?=
 =?us-ascii?Q?aT6QyAco11wv9nsHer3b0wn9WOsCctYb9StWMr/Fnc61NXJOQH/suA9TtVU+?=
 =?us-ascii?Q?MWUgOnQWdIcUu71Ml/AxhnSqmYYySFcCNVyAwaGnmh7jf4gB2Y9M+ntaqSB+?=
 =?us-ascii?Q?n0UmqigLZ7Hi9092H4vJFgmfohR0H4UL66kz4GPVbs0qiaSPvb4szbOnY1ZH?=
 =?us-ascii?Q?ZGUTiY6DFM83eFr18XtmbJwffRYrihK4QXaxKjqOa8+ChDvoHxc8vVe4rBcW?=
 =?us-ascii?Q?3MSmzWWvzHQpuQeAJUk+4RMgZ4TlZ9Eu9Ck7thhp3bGdX90mcE7PG1n6KCRX?=
 =?us-ascii?Q?lG9IQtQsQkR0iYBNIJMBKft9Au2s6dKQcIIm1KsJX+kDSjZ15rZEakJL6Vh8?=
 =?us-ascii?Q?1GetU3NBHmZ6ZFdpt52fvL35x3+Ttp1buroOrBr+7xoJ1iaCYktZ3Hziec1m?=
 =?us-ascii?Q?MakDqItoccPvxv2gn+v5Qb3OKqjB5VkeuXSwniLP2QYE5zJoNWEf47iwNOq9?=
 =?us-ascii?Q?0KfvE+beVWdUB7G3luAs1JtihJpu8X2LU/lHCgNHqhWyRgz6GjroTwhOdK1m?=
 =?us-ascii?Q?cysW/YnLcax3uvgt8YOVkgt838HFzi35M7/s1sSwDm8fpDktFmHMZgxZliM4?=
 =?us-ascii?Q?ZxoFNybb539mmgdh+JUHvMW6KOXpiYZTYKK+pKpRKyu+OWgtYWLCXIdcPW4w?=
 =?us-ascii?Q?mj+iIh8QZOuE2tj2J/DYQ0gcbVQlG3N0j23WGrSCDffn1EzWUTWc9LwyI9tL?=
 =?us-ascii?Q?lSbmR+jR9czgU8uoRfAWd3WSSwii81nHgRNXKiZzljUkWP3iftdXLENX8tHB?=
 =?us-ascii?Q?q5ExLZGIwuWkN0wP9M+yz3wepPKg+mUVbcgoOBSWdm3NIWS2Ifsy5K3YzRtz?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a234dfe-458c-4fbd-22f1-08ddd6bed354
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 21:02:03.6155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeQ9ezwvsYFdO09+GB/X5v0OGQwI/8++OVjuaBZcaNb4DFvX1FtWPsFmqjIbDDfUdm7SfMaDL7B3D9IOaylJy3HnHJJdwYbRcYG5y7wkFZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9739

This driver can accelerate single page operations only, thus
continuous reading mode should not be used.

Continuous reading will use sizes up to the size of one erase block.
This size is much larger than the size of single flash page. Use this
difference to identify continuous reading and return an error.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index dbe640986825..043a03cd90a1 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -618,6 +618,10 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	if (desc->info.offset + desc->info.length > U32_MAX)
 		return -EINVAL;
 
+	/* continuous reading is not supported */
+	if (desc->info.length > SPI_NAND_CACHE_SIZE)
+		return -E2BIG;
+
 	if (!airoha_snand_supports_op(desc->mem, &desc->info.op_tmpl))
 		return -EOPNOTSUPP;
 
-- 
2.47.2


