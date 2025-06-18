Return-Path: <linux-spi+bounces-8657-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7374ADF069
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D1A37AAEE3
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AF42F1984;
	Wed, 18 Jun 2025 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eaJu1+1/"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011037.outbound.protection.outlook.com [52.103.66.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344C22F0C77;
	Wed, 18 Jun 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258494; cv=fail; b=TzFEMrBu7eE4c/uXjGS9tqwlZmGGfJe9P4/0ka4XupVgLYSTt5vjCQicaXZb5UDtAfrQWYw/ZMZKMSKqNGRtYmHlOlGZUrq5yG6aLeJ3aqtb2j5XaYUgZ3/4LLW4NznA5VgsX7CqeQvLcpqpX1riIWktqbh554af6QasAooc+IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258494; c=relaxed/simple;
	bh=Wp6oicPw492E4Jl3aPipcRMsmPR8NCRERbDqqHlyHVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvv6BhuNByvIxRzdDsglFTmVE8eNpb3/oLO5okI3w6QzkeIdJ/a8kXHgNawmMOUjfa+0Y6yFF3AVQl9uqxEX76tlr2PWMzMx7reuWH8Rwd6JuueSfngHxuyMzEN2uZ07OIUmgzMEBAbZsUOaI2K3I/rMMp553NRl5XW81Qfc2wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eaJu1+1/; arc=fail smtp.client-ip=52.103.66.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tB9NTqZsof02nqG3kV95K/fxuAAKr/6lqxRP5wM09oybA8D0VgX+h3f0/YmLG8bOZKOJOMDQsWLAF4dAMXSyKWj0IO0kODTsdy5RZia7+fpBmBn5JlpTVT6A7VPhNTLRlMvdIX12TuFgKFYWKrcqL4AfKG9ILRLH6+i6iSmXYHUdpDk55Uq8vdUNiP1oxQWy0AhfZ67dL8wcrCnHI/RdgcbHIUtZbQm1nqf311VniQQQTiHxtxJd7YXUHKzlV6DyzyPk+Y+zJElQ2nErc33YlZxM79/yr9VtwhKXz6l3k4884UAqK+AlTIORscoK3OaRNkviCyu8r2tAMTucqSUkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Imq+nyaO1oOtBKNrOBaWsEG5xKNV/5VwV3nXYrdPrI=;
 b=xuEbfNlh4r+YVip5a7LrwrjCT3oNMD23EDBYYX6MhkjJH/4icQIBq+se5zuAWE0fxwLGk1r0NXiV2Tn2UPMEr5z0UwqrG9/flwgAzmk77BQVQ6+0jy+rlD0lCWaTdrDkioFHGenxIw8T0VZ1tJz14StwkFLUphCL6E8ICdtCq+zBpwT1y9Bdcw3nT3ROXVuItDEbu4za1kZuFRnfNxKNK4hMLEf0hLm4WdSBAFQwCfLUkyrHmF8TnTIAkkPawxeS4vpUg3c6uV8Lc9l1uwGiBJ1k/cPLzTwZoQrWowB1Xtnddk+u2eCwi/lqEViS/L2hB6RWbnbak2GWvIYmb0+3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Imq+nyaO1oOtBKNrOBaWsEG5xKNV/5VwV3nXYrdPrI=;
 b=eaJu1+1/w/qCddvA9xBRHgkMGud9xznJQRfx02xSQymZ6vu4Z/6NVGyzhfjOyutOO6DO260qlbzNoxnSJpJ01d0LS7aRdN4vNGZbdaCGW2+6HZbGoqf6yWCuWJXocTN1WUIG6dEDkuiU2oeCx7NqcszITnSLLccjIxTEpbEl3FiVi3tZd+WHFyAmQTxcMe0AbRnMxKodEouTFEk1QRrpSinwZLKZbYbZtI6/VJPsU9ZeY/leCYp42PseWs3OplNYNg9X1S+8l20NWN7M7a2TaEBuPAnrs2fFQu/GeqEcW+njXXUezjCE31QsmohrQeNex3NcDmlP0LWGoDZZDENbng==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:47 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:47 +0000
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
Subject: [PATCH 14/16] pinctrl: xway: mark xway_pinconf_group_set() as static
Date: Wed, 18 Jun 2025 22:53:27 +0800
Message-ID:
 <OSBPR01MB167042095375D97EA9F3CC06BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-15-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e370c9-1bba-4fb0-e4de-08ddae781152
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdqq3jTtxe4CI18dOgUs5M7BlF6H3CSM5Lz3vMavB6B1Ecv3zTMGAmjzdQ4CwEgDTt6q0BwFdHttI+8MNVCpyzDmaC/sAHtBojbBwRwTW6zmRZk5kZWAUako/QCWW84/sZybsb6VQw60sAwkrBJSwdY6VxfY1mDU4E3ILuOc5mMhK0DkzEidj8C6X42kmHq2iw3FoAGkMnmZmtuwDM+Hi6wmtXQWg1+87kg8ythgBVXQENXrnXR4ddas6VPGiu5KYpMqx4eb1b2OtqbMqGFDWaOpqJtLw+haTITC7BstlOrkcNyzlUVNhYs27dTZOObqIvRW3uY1Ulkikl9lwhckZ2yxa+KCboCn3QvwgtlYDHNfnIA88i1YQYsFXDs9QBEYuFCflTPFTf6UOdnehFdSt/AZLklD2d0TsTkx3kEsl9176qnpsDnuwsQJufcP/0UqK/uaSl9Z2yDP9GWiurm7xTGA8af2ZBspt6VKsfhu3czkB2bzNkS8uJG6kUg9uHJGQcIukIaoSm+385WckdCuPaSG8g5HpC4XeVPYx05ktxGh3KU/7oJ89D+nfkINPwaZUcZyRE5u5t8j5h+DNS7hZMCKp3iyvzbq8sO1VfpzvvK4Jcv65/RtR3M1EC9CSGUIt7tfHXnXxoIa8XQQ3Miqn/357UOOx98taPIBSEpGBC61/0WZRN0h+o09+I8R3Xq4UVlpQtGmA/vrT2QLPm0JcLHvc/mHk4WleEbbtbnz+N3z0=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|41001999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W4REBrPWq8BmoZ1gtH1KKdZCseHi9c3Pjv/SA5x7MWFbVhI1mJEwAZ0l3gXO?=
 =?us-ascii?Q?E2/jgPWyTB/PksRpZybuXco3mwmfoYh43fCM/wjPDxMcQtFiHtQgolv7SgPx?=
 =?us-ascii?Q?8DWHyZpTeCAdj7Yf7wKL3nlTjFFAd7a+A84vcAq9ieqUqRezip4XtyPyzMZ+?=
 =?us-ascii?Q?jsnUoOgSyh3XkGbb//DBEUcRk5NH3BkHqELxdriyNQU3/f6LRnNqLCJLxnek?=
 =?us-ascii?Q?BqaNQhYwshJkzsuwCIWT+qd2f7PYL2wBcmtFgJZ3MaHReqJz8eWRd+IYF+9Q?=
 =?us-ascii?Q?02hWi7AAetEA/gLi85dLGoc7lb6B5fbQ2pfix57a4orzLwOBQGxXatLcLKoa?=
 =?us-ascii?Q?nz5f+Y96NOO0Z6APF15JGPSV0vPt37AZWpkjmqmwbeDFlOD6r4AzEEBSCFwC?=
 =?us-ascii?Q?XJx2WcbMfij+2c61vOOIgJAtE81TZvX2182H3jJnM2eBWiQ6ryO9C/nFW4yS?=
 =?us-ascii?Q?ZZn7ckJ5vHBtiPM+bhJ23pu3n3SY77Xp7VeFAz9LhIGb7pswLvJt2P9W6uv5?=
 =?us-ascii?Q?ADAkd1TQIK9QtJA7qQSsdXU1vU6GBr+93FAG2OCc8tEbrFmqzVCRjxZP20Z+?=
 =?us-ascii?Q?etC/8CricJ4Zere9cKHaQMcWHcy8lp745OErxzDvANSbIPwkaSNtW1OzWUCf?=
 =?us-ascii?Q?hbxB/vh89gJJyGDZLuku8PgYqSegmRUHrgq8UnV5j/mZUOhV9+MZZan3ccg2?=
 =?us-ascii?Q?bVSZmJ2bT1l8w+7erRFMaXMlzE2Xm9EkEsMZvVr3VtUBBQccLwvBng33hhDR?=
 =?us-ascii?Q?JOmNHC0brSpUEtBkkYyqdEN/dFTwSiJEWF7f1unJ0cOs5Ii3gf/b04KgVVDC?=
 =?us-ascii?Q?/2VvCQkhvjERjVVU00/KFJb4gZEaw0GRo6jDLWLc3obWkziEv9kRsvDVg/a0?=
 =?us-ascii?Q?BigDDJfvIMhs96izEGtZnLAmimLQqojAm/3S+pAHKKGd54yI88P8VbMKFrje?=
 =?us-ascii?Q?fuO4IOAy5scOTBLSHtxGZuE9t4HXah7vNMKL99otQKXPzxkdkVpcboy7jOZ1?=
 =?us-ascii?Q?mQIAlx34qFAh5vcOAv0deRDmY4HVDZ5alGSinqzo9OzcjaJHHWFS1Trpezo6?=
 =?us-ascii?Q?bHx5WuoEAPQ3MaVYU0gwfercaWs/tfvlCSzHf4sSvZjNrSb5VFFuDdLrRGEU?=
 =?us-ascii?Q?DabsNAFEKlcF5YKX0z0sYibwfX0CFuWYkj0WPCFOV/yIF2M+/9sbn5dwto1l?=
 =?us-ascii?Q?zNt7DcmeZSLC5htgUj5BoQHblR5KvfF2jjHx2G8CRGt7c8XvUJV7uvj2UKc?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yME/wt4Ohj+CdjOHrJa+uRaep3lRBOVXc5M0MGX0Z72zz3EAx8ozHV1KO5eh?=
 =?us-ascii?Q?qNWAbd2fDPCPQlQjmORxWHrSZSBVEKbQV968F1juCr19NxjnWz3hHyvKOgXI?=
 =?us-ascii?Q?xtGcU3GUgL/i2LdcWqsL6QQ8S8NpEvl2ygwGPyIr6+cn7s+ptWRyqQuNrQkC?=
 =?us-ascii?Q?hZZueOJtifCBLFGasrHTEBAFr3xIrH/oXjZGfpHiFWjpaA5gOkddutFC0/zu?=
 =?us-ascii?Q?vkb3dOq0igSq409mzXPNqTGaSEr4pDHf2EPLnRwgtL6c8Rpgu9Ty/rMPU0vL?=
 =?us-ascii?Q?KpAHa1Zl4mKdeutJ2weZOt5k6iyUcQnirxFNSxepyoVsVSoC3Qptgpg0IiwX?=
 =?us-ascii?Q?J7Dp/2Th/jg2pgIJmnQCZBmttqmB7aXQzYIcVIIEE9shwxMgNLdgOhaX5LRp?=
 =?us-ascii?Q?PbtHbrKH1YhJFSbGD+c2YZpbNLSDpdzyML0KWwtgvbk9hAuLp8E4QjwcExyx?=
 =?us-ascii?Q?6uEUvElU7Z2plouka5A7be4CAOmuOrZ8cd28+R/RL3eBMMf9wxg1dg9gOSE0?=
 =?us-ascii?Q?D7GVNCtHOaX7WNqEdeXYzcMmS6AldIqx7ompL/5avb+CaI9PABoSbKGZzm5u?=
 =?us-ascii?Q?MzS93Nv5YE9kt+j0eLrZs9YQvyjeaOejLTeKyV6lXPnoGK8/DB0zVIvqwUe8?=
 =?us-ascii?Q?DoM8tlbF//7ty8IU5Rf2h6TPaI/qKcLBqESLfc5mqBQRLhmDDe2zyzznaDJd?=
 =?us-ascii?Q?i9NWinS/jyadIq3wSqqsTEBUeA4Tim0qI0ZG0/uUp/6ag0KJXiTdCmDGR9cC?=
 =?us-ascii?Q?gIQ/oltyu1M11yF0Fh5kYFp4qAFscx7fbAOV7M83n2a3KrKIwE75Kw6ihn51?=
 =?us-ascii?Q?Mx148Jqw0ivdo9PjDk/vzW6dmGobaWv2sW5K8ugTEGrwDh7OPOwhHGD5AP36?=
 =?us-ascii?Q?D610e1ehnFxxGnKfcz7Lw0FD0D4ebbtulk+TFdXJi1yZcrShSf+HiPJTpGQH?=
 =?us-ascii?Q?Cgtavj+XLa9HBFcFNzLgzcFUwf0xhTr/NQbj+fLKKNYCaacZ4aPXcprxIGZA?=
 =?us-ascii?Q?OleyJKESllR5G7ji87j76fQLutV6+2W2xJ/ZHxRxET5YoY5JkpFApFkMDM0M?=
 =?us-ascii?Q?s+1c6fgIvoyNANfnsLfzMKbqJmexUscQ09jCKjmEov/gGJizGDReGRQTZ67T?=
 =?us-ascii?Q?e2KyUE9kAfdFvErNR6D5w1iClNrbcYuhNQGtJbebw3Wmj5xJYj7WOEwbEE3q?=
 =?us-ascii?Q?E+t6YvW0fsQCLofBbAfsMKIb/Wz0lfZBwdjlVKjnhlgCVS1o0bEbcPkEyfc7?=
 =?us-ascii?Q?v/tRTlSr5xoBdUUf1tRs?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e370c9-1bba-4fb0-e4de-08ddae781152
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:47.0255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following missing-prototypes build warning:

drivers/pinctrl/pinctrl-xway.c:1231:5: error: no previous prototype for 'xway_pinconf_group_set' [-Werror=missing-prototypes]
 1231 | int xway_pinconf_group_set(struct pinctrl_dev *pctldev,
      |     ^~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 drivers/pinctrl/pinctrl-xway.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-xway.c b/drivers/pinctrl/pinctrl-xway.c
index 48f8aabf3..d2da944e9 100644
--- a/drivers/pinctrl/pinctrl-xway.c
+++ b/drivers/pinctrl/pinctrl-xway.c
@@ -1228,10 +1228,11 @@ static int xway_pinconf_set(struct pinctrl_dev *pctldev,
 	return 0;
 }
 
-int xway_pinconf_group_set(struct pinctrl_dev *pctldev,
-			unsigned selector,
-			unsigned long *configs,
-			unsigned num_configs)
+static int
+xway_pinconf_group_set(struct pinctrl_dev *pctldev,
+		       unsigned selector,
+		       unsigned long *configs,
+		       unsigned num_configs)
 {
 	struct ltq_pinmux_info *info = pinctrl_dev_get_drvdata(pctldev);
 	int i, ret = 0;
-- 
2.50.0


