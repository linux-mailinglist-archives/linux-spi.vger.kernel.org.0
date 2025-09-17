Return-Path: <linux-spi+bounces-10082-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB00DB82114
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 00:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696E57AD4BD
	for <lists+linux-spi@lfdr.de>; Wed, 17 Sep 2025 21:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549B33112B3;
	Wed, 17 Sep 2025 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="f+SpNsdX"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023127.outbound.protection.outlook.com [40.107.162.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7061231064E;
	Wed, 17 Sep 2025 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146359; cv=fail; b=StHhw0dW07VDooCn0v+6yyd6KieJvVRt4bmEntK3svI98GYp9dCiZYgwcVko05KjHAEYDZcZETeRX6guw9Q2P1eooE9BWBTtqlxpzU3ojEIqIgFjILL+JN8mmVg6YywDjce5uqQYoPSbf8d8V9qFUELBb2coodnxpff0Yq5pRzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146359; c=relaxed/simple;
	bh=xR+bYVNiNxUkG4ZchX7eM4FNMzVH1PcbxVFdHvTmeyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sPHttlYIcVzHyX8VxnHFyHlNv5GLUcVhk202Oa73qQ6+lErcQy3WgYCGUmyzvOvs9qLbuhnts8PFriywYq4a2mGkMxcD0NWu0AY2yKqri7fMultElhS+tW2ISc1eC1nS3Rheu3oiNba6Yh6OAOBa8zCBwxEhyvjD5p2fVWRLR4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=f+SpNsdX; arc=fail smtp.client-ip=40.107.162.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJOBqaCTHDT0F2To1hmHIuRLScKqp+zLX3pe/Ahe89TFrCcQ7GROTSbiB+/vX1gSu07xY/ti2cZ5lL3/BGcVM+JxQE/I94EjEeNl8O/v4tma9gpKt0C+P545UVjMKDkfKxdbQ+GAoU2CoovoGRhnX+AWbPKX/ckS2S9sWHpOGrRvActeO8H2UX+7wA/pxw0R98oM+NuD2WK1wsjroZLmHykrk5/sZncbkeTOI30UteaL/o5dn0TKMyjRAsLKYPufdR/+O+AGzxIff8RTrCeDnplzgjT+mBlK69Vv+evI4a0SYaEJL9uBrVsnjRvbeJeGM/QL6bSKTixRXXJngvOCcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNkuwADrXIUOg+tbFhpznhQg9CEhEJ9jAs6MAvJORcU=;
 b=ATYBhIaiwtL7VEO6bKuT67BynmS8KyQWI84NqX/5j3MejTNMwW19szw/z71y+s/B6UxbLwlkeV9VpFG+vZbfR67MZQPxh7xzmNjbaYH7VcqlC37B0LqWLWm9n0D+B9yJyUawAv68gq6JGVbz1Dvt7UaPEjtWAbHXByWKEQNFcyGdpI3EPQrDha5hwTEYjhwoNL8CuEY9zwai/Ml3agOSV+6uvxczpO75WuJ8qO+WRcww1uP9WkP4WhPHzbGaeVsIIRFdRILXi/XNxggWf4Y9x8qDSeat4bKFLOknZ4/AqZLkZYDMEpOWiu2/7ou9qMEEUiqPEwisT72SthgdrDuYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNkuwADrXIUOg+tbFhpznhQg9CEhEJ9jAs6MAvJORcU=;
 b=f+SpNsdXj4dsUMRK1TxHhrUph9eaD3LOxmYcMb9xNI0/8o6EypqSXzl7cAwBC4xZtT1ZRNlq/wZM5iBaxLT8cM+gHI3DJLF13tqL9OHm66zJShId2gKdrRQyZzBQ8er4kjheijBHsUX4/zLuDyslMc6pLVb1TYnRlIdISpnVWlLA5C7baeLdR2Gwl5RYNGt1KmYxbSGM8VqjneP6KOZ3KdGfF+gIprMe1kRdRrw/y8gSZNM+vQEO4SswQMWsuMOzDxt7I7i9jL+M9RI9mQGHQfXhnzJpZoX9f/8nBaEjzwJqd5yQ1h3qXAQPSOiitbgXBVUPCQhtxL1vXWd2ux8cuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PA4PR08MB6141.eurprd08.prod.outlook.com (2603:10a6:102:f2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 21:59:13 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9094.021; Wed, 17 Sep 2025
 21:59:13 +0000
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
Subject: [PATCH RESEND v5 08/13] spi: airoha: support of dualio/quadio flash reading commands
Date: Thu, 18 Sep 2025 00:58:44 +0300
Message-ID: <20250917215849.19720-9-mikhail.kshevetskiy@iopsys.eu>
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
X-MS-Office365-Filtering-Correlation-Id: de39ee71-b42e-4756-5252-08ddf6356fe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KCdNGKcohCvUrqJdtBPYS1UB+VrahoXNbjUpQZTPSl8ieLovAnT6ymFQ8SIv?=
 =?us-ascii?Q?jbYludrzWec/hgzIsfYDL8mZpVoDlPaqe5Mzl83j9+ZrGCGtEL5CK84+kiK+?=
 =?us-ascii?Q?6cnlFyjo/i+0NKzK91NMKnAdr7AqBQVCa2r1FqiOhsB2BJuqJdX4c6sLda87?=
 =?us-ascii?Q?938Vx+vk5qqV0GG+bGXrTLC6NQmykILYdghR40GMvxoNRMwxkmFa7owazuiv?=
 =?us-ascii?Q?8WKTR4z1W3jbi+0De3Cg9RRDnysjgUik4Vnwdk/B4S6cA/2K1ETFizQ+GIYv?=
 =?us-ascii?Q?j6H0GUG43ZtlK6uMEJj5BRAWJfv9pRAox5dYT1gQ8Hys3e12Ddj6XHqd9xIW?=
 =?us-ascii?Q?1218VD957/M9aZhhQQfdpoeSrYkBqcJGrDa1tIE7wm6aZfcK9MTruT5YL8LP?=
 =?us-ascii?Q?UV4NeuEh54yEmXKOoGzeXnBzXh/e0P8mTWtw4hmNv5dH6fQ+RmnL2QuMZW/w?=
 =?us-ascii?Q?6/1pMPyQz0/g3+gfrKyBFUOmOBD165IIKPqiiP3qe4MCfnYtitP9jJ9DR8iO?=
 =?us-ascii?Q?gfvpDuiZsTKfHNgjzUElX5O/GXnC59HmUP7VN7rq2BL68l/+6FFeClIQ1gxH?=
 =?us-ascii?Q?HDdfCcLK6wox/QCiT80QYUoiprp4YgN6mhDQFQ29qc9BHzAbfb+7Zar68ou0?=
 =?us-ascii?Q?5pZFTsW6iAVhTK7D2mOplQagLVGMpTTwmQIR/ST2dJsAEvSoWZekdjC2Qwd0?=
 =?us-ascii?Q?WRkZ+v7WAKjvoxKDA7xqP/Gs0zZ5xeyonrlC1tH1Am5og21RxP7hoe7FMDtI?=
 =?us-ascii?Q?ctTCp+REvOQlxkCbdB+Ja6Dz+iUpIwDPuHW7a39JITC4PuYV9in94Y6dFYUe?=
 =?us-ascii?Q?w2ayOBr7mBMKLRgedu+ErRnzg5tQF4x4y5Ug4+VYvw+2qan2Ze2lww707oRb?=
 =?us-ascii?Q?6oProzArvZLBKvN+05T6YHpaslR2eao9QYiARt5u0ItZflFt4mIkpJcs1BpW?=
 =?us-ascii?Q?i5vdPb/hXZTrvp6ArVbT36r+S4wxAp2NL5ton7pwBPfSK8/AHMJ2Bsrh2/D/?=
 =?us-ascii?Q?vxenqhPdvLMnFBaK8HnV9ozj0slL0Rva2aMouvNqR33+c3bot1S1cW5d6kdo?=
 =?us-ascii?Q?TAzcOiFrU7MZ9i7O17wSrKYg4paEHTV1bHsdRi+HmZvkIJC0WVnobd8x2PQv?=
 =?us-ascii?Q?aQT40j5hrtQTHWO5r6lP6flXhDlSMn3L6XMCw8Mbf8P9mMKlA/aTRjbS5r3W?=
 =?us-ascii?Q?ZMnhgpDNKMUa9L7HzUimq9EeriQlFtbbskbOcjcDaDcA8p9d7OossC8lF8yq?=
 =?us-ascii?Q?tKJQfN7O8yIpEpR2UWK+ZGRrNuZmPKdi/On1iwJnYIW5y9Kxyqip2pbK/rxu?=
 =?us-ascii?Q?uGko9UwKb+DghxGHZO+nIk8trfe2tH9NfVP9qxWemF5S59gBglk6lt+V00wr?=
 =?us-ascii?Q?c8Vts0hCp0vG/29ZNkbDOP8hXTXWGSB08xvVSx3v5rdyYY4qtfD15H6Eg79c?=
 =?us-ascii?Q?VqUYS1EUt2jjE2V/S9XZF6f4EJ5+be+NpGNpCVhuluCXmVV5FWWI9A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XLw9aLqprmZa3kXCTccknVGWhh9u63P/uHtds1q2qfkqJ5CHestwhhaRXP2j?=
 =?us-ascii?Q?D6BT6bjOvzIhlNRnwuPT+CiAybnr/piLayZuxfnfiN5wpg/AC3M1y21Fkfya?=
 =?us-ascii?Q?3FyClg7Xh0gV60C2iW0UOCh6FscI2g155+QdzSrd1EWHx1CUJC5ypJs+Kvy0?=
 =?us-ascii?Q?ZGiV5BowH+uMVl+5RoyinmS2cs+diDU9NrmsQDNL2JZU9alezIYJkIIlxprn?=
 =?us-ascii?Q?rrWfAi0yjthIXCctwjJjLLWCpHEoKdY5mdgiQmP5edDDvurq9WjHs2S/Dl68?=
 =?us-ascii?Q?Hda4Oc+nUhSEQ+mlY46vG3aMkVpFlwYMthhcgSl0XDdTqgRU21EuYmD3lb98?=
 =?us-ascii?Q?qgQVlMAr5huThZ6W4ZjYhofXsRFi6K7+wlUPb66PBuMHBbg3zb6JxuweGLbR?=
 =?us-ascii?Q?NankuNSulspCWzxWP6KB51JKHCONEpSqbpHgIUOt8l/sA8CwuJ5FVYByCWnO?=
 =?us-ascii?Q?hyqiJWqSsjHo9L0sxK9VdgFPvY9Hg/FYPhPrmIvoiOwtytRIHJ8o0L+EJrGD?=
 =?us-ascii?Q?+o7sfLMpTzyTzXyQ6WEQMtM0hdduTpCk88bJJgZCXSJ28EyWxVkQhtJVdxCR?=
 =?us-ascii?Q?21sa2tiS1S1kSTciyUTjo2XqbK0EDmoeeEKFXlf1MLUe8mR6ZMdYnBkrv6+D?=
 =?us-ascii?Q?Eg+th8Fz3cg4lVTEjgX8Mv+mJr3DWDX+GXuKVTJhL/7ArIk/Vl0djbN9kuWL?=
 =?us-ascii?Q?uNlnRwGGQOKYFN12nqfJOfI7FxHqfYGf/NcScfoX1pGZ99D+pntee5zhJHMc?=
 =?us-ascii?Q?AlKEUUkmWH7wk9n7/KlfkrNkRRIXLpvtsEepjeHo533X+Q8Sj6q1J1jDPMub?=
 =?us-ascii?Q?MMeT8sDAuCmVlVfpYDoV6SmR/ddisShf1GF5zL8+oze+8KwGlIKg3Pyf858u?=
 =?us-ascii?Q?cLBRYKirlPXlM6h35baFmsuTwDs8HxAMFnSCtTFi2IDZQLLYfApphyV9TeEs?=
 =?us-ascii?Q?P/oFaC+OzJkXeCqIBodVvVlTHRYThihQXyTz9E118fxBIwFXdII259Q2AXpw?=
 =?us-ascii?Q?2+/cdnafsnnYz23Hg5ZIBmWYHZk5ztmHQ/ji/0/mzrUa6LAAoBN2iCxx83iM?=
 =?us-ascii?Q?cENjwvgprjGJdDIo1skUHVjWijdQo4vAEvxgYiI7KVbtdTf1XjvN0dguos5X?=
 =?us-ascii?Q?Di5xu6urCv1DZ6c8VoWv/sAQur5jZC0LPSC/D3SGFL68QOyB8DHgGb3a7gwc?=
 =?us-ascii?Q?HNeZL06CkPM/WEyEGK/fQ1q/lwfHlpNRxUuk4eoBj0rfaOgeqz0EE0SSjTA8?=
 =?us-ascii?Q?X21EgX2siJQaiZ1oocFt65xLKyG6et7tPxpumGceslxcn2jZYjAgLnaaaBST?=
 =?us-ascii?Q?QpH7bvrgPssUoVr3hdcmQSny0MVITnF+uQrJGPv0fi2bbuoRT+PRl4Y55FZJ?=
 =?us-ascii?Q?QCLcmY0HCwgR0Ww/imokK3Bb9SYvw5rE80DAHu1n365PdH6l2JSSd4WRQeOF?=
 =?us-ascii?Q?RgYF+UNMMuPlGD994hUbuiqs2Y+xqH2Dz3UfYxZcVfu7+odP2Igen2A/H7gE?=
 =?us-ascii?Q?ND+rGM55XZr1+/a/bEwuzDypGoMIUoYhATrykCe9PISt7D8oJ+FZQhHLHffN?=
 =?us-ascii?Q?qGwYrVrAqgRRSQEFsC1kW6ohg+ZVlsmH63wA2CMan1rmt5NcjxgFMFApsOmm?=
 =?us-ascii?Q?L4uYeycdcL1+WG2QNoNoMkM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: de39ee71-b42e-4756-5252-08ddf6356fe7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 21:59:12.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VdFXUNC4KXTlHuW/zXmxniRm63C1B8WP4h3BOgymcwqGmS1g7+3ivP1EBPaeBP39wfgD1jl0qH0fRlP0WNj43GgJQSq44n3djD5wmQZewcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6141

Airoha snfi spi controller supports acceleration of DUAL/QUAD
operations, but does not supports DUAL_IO/QUAD_IO operations.
Luckily DUAL/QUAD operations do the same as DUAL_IO/QUAD_IO ones,
so we can issue corresponding DUAL/QUAD operation instead of
DUAL_IO/QUAD_IO one.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index e90fab69d81e..744eeb2b24ef 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -147,6 +147,8 @@
 #define SPI_NFI_CUS_SEC_SIZE_EN			BIT(16)
 
 #define REG_SPI_NFI_RD_CTL2			0x0510
+#define SPI_NFI_DATA_READ_CMD			GENMASK(7, 0)
+
 #define REG_SPI_NFI_RD_CTL3			0x0514
 
 #define REG_SPI_NFI_PG_CTL1			0x0524
@@ -179,7 +181,9 @@
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE	0x03
 #define SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST	0x0b
 #define SPI_NAND_OP_READ_FROM_CACHE_DUAL	0x3b
+#define SPI_NAND_OP_READ_FROM_CACHE_DUALIO	0xbb
 #define SPI_NAND_OP_READ_FROM_CACHE_QUAD	0x6b
+#define SPI_NAND_OP_READ_FROM_CACHE_QUADIO	0xeb
 #define SPI_NAND_OP_WRITE_ENABLE		0x06
 #define SPI_NAND_OP_WRITE_DISABLE		0x04
 #define SPI_NAND_OP_PROGRAM_LOAD_SINGLE		0x02
@@ -664,26 +668,38 @@ static int airoha_snand_dirmap_create(struct spi_mem_dirmap_desc *desc)
 static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 					u64 offs, size_t len, void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	struct airoha_snand_ctrl *as_ctrl;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
-	u32 val, rd_mode;
+	u32 val, rd_mode, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
-	switch (op->cmd.opcode) {
+	/*
+	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
+	 * replace them with supported opcodes.
+	 */
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE:
+	case SPI_NAND_OP_READ_FROM_CACHE_SINGLE_FAST:
+		rd_mode = 0;
+		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
+	case SPI_NAND_OP_READ_FROM_CACHE_DUALIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_DUAL;
 		rd_mode = 1;
 		break;
 	case SPI_NAND_OP_READ_FROM_CACHE_QUAD:
+	case SPI_NAND_OP_READ_FROM_CACHE_QUADIO:
+		opcode = SPI_NAND_OP_READ_FROM_CACHE_QUAD;
 		rd_mode = 2;
 		break;
 	default:
-		rd_mode = 0;
-		break;
+		/* unknown opcode */
+		return -EOPNOTSUPP;
 	}
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
@@ -717,7 +733,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 
 	/* set read command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL2,
-			   op->cmd.opcode);
+			   FIELD_PREP(SPI_NFI_DATA_READ_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.51.0


