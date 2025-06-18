Return-Path: <linux-spi+bounces-8654-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA88ADF06A
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9A451BC1880
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222EA2F005B;
	Wed, 18 Jun 2025 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dzbsS5ZT"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19010015.outbound.protection.outlook.com [52.103.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680B62F005C;
	Wed, 18 Jun 2025 14:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258483; cv=fail; b=KtEf9FD5hLCY9JNsPAktCbEpYocs9k43BCQwjbAyDftrvrpjQCCCcw8Qt40+hOYHVbzjOobWoKGR1S7HlXQghKNS7e0gr2Mm1UHzB1B/Wsld8OQBPMcCKAz2J4s60/9mre2nx7TomDvEYuLbydwqp4SYMA7XMQ62vbLVrKOIwAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258483; c=relaxed/simple;
	bh=0b28Y3+OBwGVNyy2pSAAx2FkSTOAQkrcaApmitGYYU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lb/S6sfOrZDJ+Yo94HNlUnky0jiymmnZBiDizCr24VGaU2p87nTPATU7jLzPspBBo6gopCmwV0EXORZlhOe1xmG7jnqv2oGZgmiOBGQqCJ4AnBmL7Iu9z4BAjWZu86HWDFY1VjF3zmrxh8uR3PCwPzNeI/xq4gVGq7Nal7AhgcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dzbsS5ZT; arc=fail smtp.client-ip=52.103.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACCt9FbudSZTuqP1urcMnwGGf+q+eu5PwOAeXEPtlV/eT2esWXNWyFABBwJ3vMGgLX2qsCWjZ/O+FS37VugTFFGA7k25gGLRujMXEMTc7Jln0cUDx1S8eRvL/UHvt2A3tjq1ey9T3dGcC8F1qmHTUcF+R+BittPWkbkDnQTcre+6iYGdiI95WCbzZ0cOh4Ppn/wKiDZ+G024UMvfnO1mqR4T5Ke3cfX6QixRWISp+6CpY5NsL6YeQFMcs4zZRlMrqtXCLSGyoAKtW+AXaXtn9QGIx64RmpDjQBqX6zaBImVnSxxPyEddX6yBIGqv++3qPj+6rTH8I3SgMTtqumbYLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SZ5xRqSxHCxszMEwANsz3q4kxToUXcZGn0V+2GZEhM=;
 b=i1dp/er9wVHdE/gTOf1lvGG6F9mB8bgMlrEl1AdlDZFBPXA9UE3/teptebpT2OgKJlOEHHNLFFCHeAmtjd/uBXOO7AY3lpnxu7MpGdO6+BL6NmTeehLAptx39OFtBRxzJ9+j9xo63EaYce/JTh2UFZ0YdsvP1ck3lgxITc35Q5JY4deI1s+7IH90Ln0yjvHXMSN+G8xHv0AxMxbvOhrZ17lvuG8g1VLG5zAzO8q4Elmc0Nz30S2vryphzysfidCxDkSJBnrPG82HN7DQ6lqdYbAjl+NxymQB7W+Vdhe34KzLEd2kGtGkJt1351Y3widVJuza0YfSN+6RwWPCef+0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SZ5xRqSxHCxszMEwANsz3q4kxToUXcZGn0V+2GZEhM=;
 b=dzbsS5ZTMZbv52MtknQ4dyzHQrofEyt9EjZJkmxhpakBypO/KoAGerPrYGzBAoISrOXSB7ZP6ziixQSA966a7koEZ9qJOY1f1t/hBHesK0AUure4gBmlwmRxNgrCqcvGUjOPnQZudLAtVZxep6B2chlyfICSSLbKNFkVQCUmXucNqA/MyIGVYbeoDDIBu/ZKQelW6hXkuyTElsAX6aQS3bazeW2yxYo8b4xuM7TjWog6SUOw9t0JVqS5n8Mc05oEpgOTiZkBWGoEtVmVbldUr7mWKuCQmccpb/gY8u6pTxoxOI4CM2D8itK/4BWZweom8CrT9SUL2y21iAp+dFJZKg==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:36 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:36 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: linux-mips@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH 11/16] MIPS: lantiq: xway: gptu: mark gptu_init() as static
Date: Wed, 18 Jun 2025 22:53:24 +0800
Message-ID:
 <OSBPR01MB1670B413FDF211B2211FA9C4BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-12-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 742103a7-5bcf-4ec8-6823-08ddae780acd
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdNBrsar0DuFahqvcaEVhzWn8BFHjYxPYm/eIo0ZcNMmEAj0C3a4lQLh5NohA3f1fhpipBIRZRnRA3t6eYi+XAz5W2Zwr02tXtTAjMqMEax4+LsXKsWz8bSO8MWiMvmBJ8AHeOP9XlQGmNffuFuYftoDkJrDWfGTx7LmawVPPQisJ1VZAyR3S9hk7BHDsekuZdkRwkD/2I1Hn9Sy3YdIfmzlKGroxo6is81T8XHpKkCjKpxEPgR+vzYswxqdRB0JL8eHab7isTBmHIU2kNMHy968+1VZLZloJwy9gBdgYx20mqwYRC0rOPIXyF4v3uGMA05fVpRqZirXZtvSnr/BaCMgJw845afXXVWMprX0MUeFLZuOyEIPzgFrhtnQaqep1qjSk7ksUbKFTn5qeWD5czidG6yO1VUsor+0bXCcKq4RhHXbeJSHuh77CUq4DjwLcXaRikoXt/jiLK+NoLlOzjKiOcZPruvrJ26pTrs3xspmRgX0y5pC8xH1iNlW/iXNkfkImZ6TqP7UnySLJmPa3ZcA9zqpuGltpOmGfilGUVmHsJaurmobwl2dyjEJ3AVppCUmd88buzb+4Gfq/i9B7vsMSmvYs3EwksnP/kQJIeh8P0hkoXtHr+mgMJRCB21yOW8ArYqpaK6HgdY5xmFuvgxDeOeggxP4TpIWC6zaMAv9zZcw6MbiHc4MjiZBrCgOG4EP31abkUJee8W3QuNabW6jB3IM+geOKv0yFvQotzQSk=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DXObNy/x8vlnM8pnkkWcGnmopaM//BsnwgT0hw9Dy63xP0OjvHttVYyFQFMv?=
 =?us-ascii?Q?EjDN/HjT416Vowd4z+dWZ67ckYOkKn9d9xB9dYnNEVeiF5jjMnE5OOBQgsm2?=
 =?us-ascii?Q?hMS6oP4QZaHabYemCxk0Sya/LbVLdyOffXrhxTD8b8FWDVNISFvhmTfc1tcE?=
 =?us-ascii?Q?eY/MDfLLZNBYkfP3u8wczV8JoHxFD37UUcKnGAWaOwOis5x4G+GyT5R4UeVZ?=
 =?us-ascii?Q?tZ+G3bKrqa9lTyo+OZ4A4Def5dq9fa0Nktq2c8hJFlIMkyAPQaDpmPdw2HrG?=
 =?us-ascii?Q?zJ4eWaMhaUEOmqMdy/FLJcO9aI3DkdhEZWxZetud1uVppTJSQIyYiCB1MJCb?=
 =?us-ascii?Q?Ah3plz0fP2OFi5nzwyrFVTO55ehxbgHFI5BG20K7NhhXK5QoNCxk7ahSxmVL?=
 =?us-ascii?Q?ZREW3wSYgt7/Bh5jJToKgy7o4ypDUB7dcs7AjfZyr+4RhvOXmAHSV+gZSLsS?=
 =?us-ascii?Q?tYWfyzx8u1mSWgGdxQRSzU4+kR8RN+FzW40K7MsA/mxw5wMnZ2hbMkqETv+H?=
 =?us-ascii?Q?ODoDI8npxzJLS+TM6fmpbQXgLIoANE8gD5MY8PoKcqG8fg+iSzGi85oujYBF?=
 =?us-ascii?Q?DALZwlj0WOs170xDjIs2FN2zINQQwcaP9kUJx+zWusaD6mMFpo8hEO6zOcKJ?=
 =?us-ascii?Q?d52qgi+zpZEHvs9JZraqiqb4PIvE+pt+5Hm4OLCkVvSzJsFmtLehsZeUQDSx?=
 =?us-ascii?Q?/NRL/teHymKgSmFg3WHckublxrAhDvQQ4rzz2RRh/F6zU20/a5dI507nIvCN?=
 =?us-ascii?Q?qJF2JWZFwHTaRsd1wvJ5fzMslkHzcn9XvkoRihrqnSFpHr9VA/k8wW69vvqo?=
 =?us-ascii?Q?IIRwxRKVyQuFZnTOZg+NeAStzWgxIupSmOYwDo/9zEWpgvHK2LvaqPVNKqCW?=
 =?us-ascii?Q?z0ehkoJ6JWQjThoaloQ1oCkMcFu8mzY+24BVJSY73/e8amzQ5tpKJob8con+?=
 =?us-ascii?Q?VYZlQAqko5rjIqCjSfvW09bxYG+j64Ul2ruKvgV+KqsnAqe396FENPtunPS8?=
 =?us-ascii?Q?l5qed+Ob/jVqVJ73s5PvlnK38WLM1uL/obuMFlz4j/g3QCxBaoaaII8iv9XC?=
 =?us-ascii?Q?nISeDUjsgIDHgLkIO/puJmd/SnKL6Q6RM1QywAeC+/c3+SH15zWeegSy8bXW?=
 =?us-ascii?Q?HS9RhMvst5l97K1pkE/ARwjq8MXfa75kqa9omhSE4XayyYyJhX4BrjmUN+8K?=
 =?us-ascii?Q?HEytRU+MmBO1eat0gjY6OBbk+3Pd1qpqNjJk+Q=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JWu7s9p4eZQZ0EhDVnsdpEBhlJ8ZVIYmbMcqKXLbK1khbwlw/VF9uOLU4N5c?=
 =?us-ascii?Q?XKLZ9M3IO+btTiS78krDWw4C1Kem0yBwCXfTDPzU/oBp23lNvRfCI7tuKJed?=
 =?us-ascii?Q?mxMp+xQ2qT7lpJTHwWIKBmz4aKYAHyMC59/GcAf9tUuyfefa8OU90n/Dop8E?=
 =?us-ascii?Q?iS5JF6vaAcJRwgHZZKIL1rxHLAZAL5i4iRD5WfYnv0/uxLzs+6Wutx1C0jbn?=
 =?us-ascii?Q?7QJyjg+6i9YNkrRggiQEkhO6dHmIEs9F0NUlyt21frY8X7SOg1PtDSjrFyi1?=
 =?us-ascii?Q?m6qISPU/1yMLU659wgnfYC4oU/xX44rTy93yOEmnT7qVzKZV13FPG2TGXeEP?=
 =?us-ascii?Q?uHsGraXg8+s6JXoOTpUupcJFbkYVgDcwbHXmZZ7jCZOtgMmmi6j6diS+YZiU?=
 =?us-ascii?Q?Btq4Mt9nHuCwQDPgkMp463PRN77lN1xEF63GUqn8cJoUxFg/n8NI5aa+q8wo?=
 =?us-ascii?Q?m+4NEOkNXstAktreiRH7n+yg+h2SXBRV14FvtK42i3ZSVpml0stebIcvTAur?=
 =?us-ascii?Q?4Vh2DQwVeRXMUBdZ5u/kkEaYFaUuFdvxnh9CAEU4FXZVGiAbe6sid8ie0qUU?=
 =?us-ascii?Q?6mfc0reKdzc9g8ozu0/wso85H9Hva/34SXh2lKis4dC3VH862iQctYaPSjIL?=
 =?us-ascii?Q?gTxsB5ypL+jztnZTVlu6cnYHIDhCiLhi0Dg9yPK09g3d+7SqjTmRH7mCgwEF?=
 =?us-ascii?Q?tYseWjOl4aDmBcT2MB5V8IOM7568vjXHNEfYR0SSl4or+WlWaDDfz5Pt1FWl?=
 =?us-ascii?Q?BtS8NYNsmQYRLgrtEjA6W9GHgQUDNeVksBrubbnX5iBvBN/KA/KKFaiDmvoH?=
 =?us-ascii?Q?iZSjvE5126SJA2m0iDZRyelyV5zCEzXriL4EKANMbU3iXzhDY7AOULTn26U+?=
 =?us-ascii?Q?Z13PUkQOeRnbK2SD/4Lnz2MB7Zk6XeF5VK5tVip6wQF9duSSaJE7sIk1Zf76?=
 =?us-ascii?Q?EyqYf0yoMIoLnceTEY+30nMS90Q9PfE4hNJx4WtVMguU1X4uk8NtGTBxITu4?=
 =?us-ascii?Q?5zRXqvkMT7F4g8+LqBVmriHrXeU3iXWwSbNXEQTGMNe/LRIIp4DzH22ThWQw?=
 =?us-ascii?Q?enV84RWA3DJRvA4wrUplWR56ZxNxvAz3GnT780150MSNzta0M8dHwIvos+H1?=
 =?us-ascii?Q?8BMAeIXx23XIEQ3w1KVG1jbbCc2+ChC2FKztVGsBXSvB56VenofHqUty1TOA?=
 =?us-ascii?Q?687RUNkEWku4J2nor+s3HMpx/Q3qhAtHFZfzVQlBKh0yGlqn2pTRSlRNynG+?=
 =?us-ascii?Q?9vf48qOx8detH5A9oPQw?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 742103a7-5bcf-4ec8-6823-08ddae780acd
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:36.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following missing-prototypes warning:

arch/mips/lantiq/xway/gptu.c:197:12: error: no previous prototype for 'gptu_init' [-Werror=missing-prototypes]
  197 | int __init gptu_init(void)
      |            ^~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/xway/gptu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/xway/gptu.c b/arch/mips/lantiq/xway/gptu.c
index 8d5200130..484c9e300 100644
--- a/arch/mips/lantiq/xway/gptu.c
+++ b/arch/mips/lantiq/xway/gptu.c
@@ -194,7 +194,7 @@ static struct platform_driver dma_driver = {
 	},
 };
 
-int __init gptu_init(void)
+static int __init gptu_init(void)
 {
 	int ret = platform_driver_register(&dma_driver);
 
-- 
2.50.0


