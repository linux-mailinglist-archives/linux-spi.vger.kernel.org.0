Return-Path: <linux-spi+bounces-4817-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F357978FA1
	for <lists+linux-spi@lfdr.de>; Sat, 14 Sep 2024 11:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19ED31F23951
	for <lists+linux-spi@lfdr.de>; Sat, 14 Sep 2024 09:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBFF1CDFD7;
	Sat, 14 Sep 2024 09:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pSxORzd5"
X-Original-To: linux-spi@vger.kernel.org
Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11011036.outbound.protection.outlook.com [52.101.129.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD5E33999;
	Sat, 14 Sep 2024 09:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726307635; cv=fail; b=kZDSPYllYYXHbDXFArKA5ehciJ/2pIgTLfl5YfyOK2NCp0AW67in+xNRYz0XeVro2sB/IX+de1uNdeBaFdnrZ5CQlQM9bexQNbSazT94XdM1udhXxpBeoRDbQ3Srro/wcNHNZT0GsLsKIJjrBfu+l/PX3by6wt4OfRbzw8p66CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726307635; c=relaxed/simple;
	bh=u7T3EPIj4lrf1/Tts68OIDszABKrDBrHlUbDiIEsTT8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CyIx5v9Pdygt9vUE6vkalrYfyy4q6j7tOH4qdob9dsaa0hl22VrsLWH3QNG2d3E7DjCDAtFWwUNu8BK1vOwlTUuQ2GuEEkNYzb35scPbo3/eanhKaTBJ3RKFI70wno73k0YRkLUOi7SJAAPSqO+TXNBORAw2OdxPz9XFaKJrkU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pSxORzd5; arc=fail smtp.client-ip=52.101.129.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaxAwRfULSOfcB25vucedRvUeWKjZcrtrifsn7ZqZCra4vZKEK1PNqTlg6SZz/EAVM+kf9MYI+kXh3GZWwhX0PPap94nCWDk0rX+1AVYndfTqsTeoo1hhZ27WMHE7x/zztcpI4Nu4ILz0JGl9RPe0qaWTqijsa+i8QzkwidkT4xPtdpaPSuKb91L5Of4F6+vTkH53lo3I1hAb/QJ5qkjr8H3hRgSeWABSm+uLpAu269f3ddARofVipj7ZFfFCu63H2JA3Vj+YsIZu8JzDIv8aTApvm4ok5S2y0Xm9JbEtNL7Z8D/SiZmFzmyP688bcAKAU/sk5D/N40nDOS1JC3NsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+IMUWGLa6KH3BioTN+TA/DSAmJdEUIjkV/rbsWzsSQ=;
 b=vprax1vlWiDxE/SJdHDRXLaKjc3TGysHbusCxunEkBQPAkzFyv2EsyJ1N5VJFgTZkEcNYGjMFqE0B5pVpD/2WP9ly/IZko87G/myrrprChS7h8ZDySCE5YRw/yptp3KSYVyR7NIgvHleCzxLoNRP36fQqb9AFAuGRqQP3TlgBUP0FH21GsB0JpF4dGjyIl123KkzSKFOkbeWDoRojza0tlh76KngWUrVNzF7MIKPTnN6Cqzq7GRQFoMrnI2kXLfBK+OJBHa06I3x9yyy0ada0mUSOu8BA2dFYns3y416MRh3lMdlUM2yomkHQ2IlLUQxSdvq7E853uFicE3tSoUZew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+IMUWGLa6KH3BioTN+TA/DSAmJdEUIjkV/rbsWzsSQ=;
 b=pSxORzd5pZu2E1toDpqGvEnWZ57UFf0EF5BByGVjXC8oupY38I3hKZdv43p/3lVsxVZEQErWPnoly8+PdiVEsm37MsgwZIpoWW3DU6CQ6oINIdlvoQIPNHXd8tdLJbRq4RSA0ncr1GFOf5N1VogyY10v+MJJSMkiWAMFF1QLKBsejsAcgVdrQ54hYu8q6rHHgcwQI7nvGZAY5TXluDL4JzPjHxZfqVVK7GSBR3tsgfjPUJRxIhqH7zdj74cSsJYxHBSpEXnXsJdCMDn4dUpTQzMwnUDqokmpchxFdwwxS2rD3o877uZsnu1vr6RgO9wOKqA/WVnJDoPMYjFtXneWJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB5175.apcprd06.prod.outlook.com (2603:1096:101:72::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Sat, 14 Sep
 2024 09:53:45 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7962.021; Sat, 14 Sep 2024
 09:53:45 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: f.fangjian@huawei.com,
	broonie@kernel.org,
	linus.walleij@linaro.org,
	heiko@sntech.de,
	andi.shyti@kernel.org,
	krzk@kernel.org,
	orsonzhai@gmail.com,
	baolin.wang@linux.alibaba.com,
	ldewangan@nvidia.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com
Cc: alim.akhtar@samsung.com,
	zhang.lyra@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	opensourec.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] spi: fix typo in the comment
Date: Sat, 14 Sep 2024 17:52:13 +0800
Message-Id: <20240914095213.298256-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::24) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 0585855d-51c4-4317-f968-08dcd4a31f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IF0jFrjsvpDN+npO0/z5WAh7MZUNgFcSWzkT8HG138FVVAoQcyNTR9KSdOWb?=
 =?us-ascii?Q?xYNidriKfG2qejhCZIMJ0yI0/Bk9yzek3gP3mB/I+6HAl1nyl4ZgfwFzW9au?=
 =?us-ascii?Q?urKNckSmzbJ48pFYd8lHHYVCH5w3h1sE91vtFodpsKhqKlgRu8wGADQEtgmH?=
 =?us-ascii?Q?I37CK52e4UYnOi3ze557D9aHP2FFtvg63YhoCeG7W9M1+l0Ruaz5c9DweLFN?=
 =?us-ascii?Q?1liYOIwYTLULtRJamPSgp//fbG5MecEl4wnBS2INhgQR8uWtPJHpSP8HDirF?=
 =?us-ascii?Q?khVeo+kEDskriSLdhvpbHhG43ZGMrMdfsFzBoT2tG1KdMeoj29Pk+IEMgvvO?=
 =?us-ascii?Q?A5h7CL9vvpAtB1m6syFIKUuE//j/6WR4/VDtxhyiEUjOmKnSTaxQGI0oOWRA?=
 =?us-ascii?Q?OjNObgorJdIy4L/0IMHihb3ucqND4tOuD9i326xqQmTHTpp2qqktfGw+TS43?=
 =?us-ascii?Q?N8d8AplqcJI7QBF5pkxgQ/i3gXiGA3OpxFilV0oxNQ2BhMIMj+4HdVa0svdi?=
 =?us-ascii?Q?WaRVr7KpDc9xOCbju49pJpHrF/moElSV1v9UvZQxUCazZ6siYSvqdtdvQD18?=
 =?us-ascii?Q?Pjvwrt3jF6QMI9qs9JLSIvjW/eoR3KV+0hsDLNDwlM/22OYEMEb5kzszhVCl?=
 =?us-ascii?Q?wagMDEvZK/yBDvSizpSa95TeB4xd7KYgZT3KOXDXEEtmsO3NB2hq/9W2U4Mc?=
 =?us-ascii?Q?zvveoSN8DvV5qj4/5r6j9n5QgsF82M7Nif5OlcVhKg3uj9njWJZ8BASlFpSW?=
 =?us-ascii?Q?gIztJ/lYpjDsSe8jpSN3rOrkEOC8asUvx2uaordQ9buZ8ceMBkVs6LyoUSTD?=
 =?us-ascii?Q?xFx/NoivNBbtaEfcIUhVLRO8h8Dqm202NviaT2lhN/xyraiUKAPLV2Du1z8X?=
 =?us-ascii?Q?6L+eVud85kRXOIriX3gko0FrYnumyV2G5tlIXWxlL0tuzthrMNvW2j3733Vn?=
 =?us-ascii?Q?JTTb9ezggg66ISeiLvuOT05fGl78dkc+/cqYM4+IZ5EDpc6P9cwDCRs/NAx/?=
 =?us-ascii?Q?xPQtrbgBt6+JiyEq959vrFV5hCgICBwU7zqI0sfKWNGWSlwBE8rPTqPJVTYP?=
 =?us-ascii?Q?/0puIuU0i+mfDlt/Aq/VXVaeJuMZGpnU8+hnyGjaRwTuU0E7+w7QRtpqP+cU?=
 =?us-ascii?Q?kpDfBzjcR+5sDLNJWdTMVFUrk6nhbHqyDc/HhXDKOqEpfmEHn11TQRTZ4nR7?=
 =?us-ascii?Q?9BExEBBI/avh4OHzCqAisCoKpb4lyAbGYkbGpHy1sl8wnV8/ZsQtNqmJ2tWU?=
 =?us-ascii?Q?akIm/UoZh7FQ7AM7rF2KLxOVCejmzTOyJOx01mkH7OXM+4wHkVgxvgRLecvr?=
 =?us-ascii?Q?UZgLM8Mb2OGiU709mMsmPR3EOqupG3qujf2QRepvYrxosl8i7z+WvhTCV6Xr?=
 =?us-ascii?Q?O7K2sBcqBV+qHxZWMEjlapG+2kSdkgRiOcEnUURu5zTeWp3/MhIVwjNsxJCH?=
 =?us-ascii?Q?lA61zjreM/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Epi5boGacfUE5xsnke4APaUCsmrYHHVBeuWgPwy+1nKrBQFvi3Q2Sw/kfJQU?=
 =?us-ascii?Q?wHTkGGKwY/8ZMBJ5ZFNjIcBQRKX9Kfqi3CJjpMy4Kcy1WSVdo0WFxsDEuT/m?=
 =?us-ascii?Q?I2A/KEjYcADIlL2Q8njnQX8PhQaxh6uWB7vTBC2k0DGnYg93BxlRM4Gmhtix?=
 =?us-ascii?Q?9K0mOSm9uM0MgKEB0VkI8CDZFEgnAxrFM3ZKVMmrsJofx2SQWj4EWjUFGk8k?=
 =?us-ascii?Q?IbjZHAteNETBxgEnYeW8qChdW1A58w+o/slBMPYdVJMxN1zb9bSlCbTXNUub?=
 =?us-ascii?Q?K08G638pEn4InNlNp7OHFYiZiyon16xfaH37l2YCr4mV1L+eAgiZeCNk6B48?=
 =?us-ascii?Q?P+f4oQciC5sjeyN6omIC7PTAw59nOMdQj+nBWnuzZhQ+tCdVcncgtSjeX3UX?=
 =?us-ascii?Q?b9xKZfxoAyW3Vif3eLD5nl85Ge6BBO0DWTOFDP2TLrSyAldM2XmRM9NOU1Os?=
 =?us-ascii?Q?0fg5JYa1EeYfYh6oqqbxgqWXTZ87tveSBzDxEEqST5vR6xNwFoHWH8unzFy5?=
 =?us-ascii?Q?nnfH4mUfJqJfxc2CoNAnWXOO7W0387g1TTMOhfMBlMCwiotwuzZSgQj7JCFD?=
 =?us-ascii?Q?2IRhWF3O/+OSWQUkHlscPXnTyuztVFy0YdVmGNkSWO/RLa2+EI6UKikWBNnT?=
 =?us-ascii?Q?N/TVlTh9+QTcVZCe11/TiVYhsuP4vSGQ3FjWa3ER2d+0CLzVvxAU5JnjMs+4?=
 =?us-ascii?Q?LVlroEZRKFu2M+oehO4Hm24jpu4CVCtQt9PKbbFj4AYkZ6qTzahcw8LVkF68?=
 =?us-ascii?Q?VWGdd+h+ZTO+NnrLuZ8WAqaN+rmkTTj2/ysS6c0j5K0IzHPLtdzQPTqEGBbN?=
 =?us-ascii?Q?5QgUzuFbEfMveuXiQC3qDyzSd6MoWDd8dzoTtaRMn12GhkloEnkUH83nM7EE?=
 =?us-ascii?Q?kQnKSUrfE7qFX97h9pPtR3ETZP5lqIOzRcQebIsacd9slmpliEYgCdcRwDN7?=
 =?us-ascii?Q?zRjiI7x/D0oVLW5KT331gKN5F71o9oN8yFK77kepDHhKRr9fL97SsnxLVHmr?=
 =?us-ascii?Q?pWy2aTz1ZvTbnq9pk7gTPK482noL1c2Nbl4XGUnTxS/Bdu1qzhg8NcwiDcjx?=
 =?us-ascii?Q?i/YsQtpaPsjgWQLyXnxnRjwzP5CzC/63M7L2p22mbpMmYFuQgDa2GTLls0xc?=
 =?us-ascii?Q?3pWEa1CHzsdb7YVrlkv93aTsThocW8bHRVz/hNlNKg6MHNJg5D+vcBDbpQD6?=
 =?us-ascii?Q?gqCAGEJCDzg0T0YvTH+q1ETsrbCzhedqJygv2Fk1GvnTrNlPqFZHzSlH9Gfm?=
 =?us-ascii?Q?2yW1HyfeuCQPxKUDcixfhDefvC2R8fVnU/ZPWEZJN/000zS3Glccfbf2Pfl9?=
 =?us-ascii?Q?Mp1R6Xg4n1JbCGEeEaKA1Y4YZ7uYGG6VP/onFjIJFuTSkC36r2FudOrpweyd?=
 =?us-ascii?Q?KEej0plt0UAsn0lvV+pNcYQEnwJdtj4CsdPRJfDYFg0RcJHUNoLwyPniUaOP?=
 =?us-ascii?Q?6Ux4MQjMqKCwiSP9sidhhGyami3grMjpHrWu5t6AkeZX69HeN0/RYyZzYPJh?=
 =?us-ascii?Q?P3gpRMQAinzEv04VYZX79p1oBoYvgBgr2GdYeYgy1n6is21q1m6nXDEvp5EN?=
 =?us-ascii?Q?vhe6NXIezk6sNk79RKUcfIsBM9o6O39CjzoYyBZY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0585855d-51c4-4317-f968-08dcd4a31f99
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2024 09:53:45.6469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OQjuRQznrvm6tlMdC1/9JaHaU/f0yWucNqqhv0l+gXaTNaXg+6HhTKTCjLQFOBnk57tSLLt9n3XJTloiP76k8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5175

Correctly spelled comments make it easier for the reader to understand
the code.

Replace 'progrom' with 'program' in the comment &
replace 'Recevie' with 'Receive' in the comment &
replace 'receieved' with 'received' in the comment &
replace 'ajacent' with 'adjacent' in the comment &
replace 'trasaction' with 'transaction' in the comment &
replace 'pecularity' with 'peculiarity' in the comment &
replace 'resiter' with 'register' in the comment &
replace 'tansmition' with 'transmission' in the comment &
replace 'Deufult' with 'Default' in the comment &
replace 'tansfer' with 'transfer' in the comment &
replace 'settign' with 'setting' in the comment.


Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/spi/spi-hisi-sfc-v3xx.c | 2 +-
 drivers/spi/spi-lantiq-ssc.c    | 2 +-
 drivers/spi/spi-mpc52xx-psc.c   | 4 ++--
 drivers/spi/spi-pic32-sqi.c     | 2 +-
 drivers/spi/spi-pl022.c         | 2 +-
 drivers/spi/spi-rockchip-sfc.c  | 2 +-
 drivers/spi/spi-rockchip.c      | 2 +-
 drivers/spi/spi-s3c64xx.c       | 2 +-
 drivers/spi/spi-sprd.c          | 2 +-
 drivers/spi/spi-tegra20-slink.c | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-hisi-sfc-v3xx.c b/drivers/spi/spi-hisi-sfc-v3xx.c
index 1301d14483d4..b2af2eed197f 100644
--- a/drivers/spi/spi-hisi-sfc-v3xx.c
+++ b/drivers/spi/spi-hisi-sfc-v3xx.c
@@ -40,7 +40,7 @@
 /* Common definition of interrupt bit masks */
 #define HISI_SFC_V3XX_INT_MASK_ALL (0x1ff)	/* all the masks */
 #define HISI_SFC_V3XX_INT_MASK_CPLT BIT(0)	/* command execution complete */
-#define HISI_SFC_V3XX_INT_MASK_PP_ERR BIT(2)	/* page progrom error */
+#define HISI_SFC_V3XX_INT_MASK_PP_ERR BIT(2)	/* page program error */
 #define HISI_SFC_V3XX_INT_MASK_IACCES BIT(5)	/* error visiting inaccessible/
 						 * protected address
 						 */
diff --git a/drivers/spi/spi-lantiq-ssc.c b/drivers/spi/spi-lantiq-ssc.c
index 18a46569ba46..a1eb7f296f55 100644
--- a/drivers/spi/spi-lantiq-ssc.c
+++ b/drivers/spi/spi-lantiq-ssc.c
@@ -139,7 +139,7 @@
 #define LTQ_SPI_FGPO_CLROUTN_S	0
 
 #define LTQ_SPI_RXREQ_RXCNT_M	0xFFFF	/* Receive count value */
-#define LTQ_SPI_RXCNT_TODO_M	0xFFFF	/* Recevie to-do value */
+#define LTQ_SPI_RXCNT_TODO_M	0xFFFF	/* Receive to-do value */
 
 #define LTQ_SPI_IRNEN_TFI	BIT(4)	/* TX finished interrupt */
 #define LTQ_SPI_IRNEN_F		BIT(3)	/* Frame end interrupt request */
diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 28f06122edac..3bbeb8d5bfb8 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -107,7 +107,7 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 	struct mpc52xx_psc_spi *mps = spi_controller_get_devdata(spi->controller);
 	struct mpc52xx_psc __iomem *psc = mps->psc;
 	struct mpc52xx_psc_fifo __iomem *fifo = mps->fifo;
-	unsigned rb = 0;	/* number of bytes receieved */
+	unsigned rb = 0;	/* number of bytes received */
 	unsigned sb = 0;	/* number of bytes sent */
 	unsigned char *rx_buf = (unsigned char *)t->rx_buf;
 	unsigned char *tx_buf = (unsigned char *)t->tx_buf;
@@ -325,7 +325,7 @@ static int mpc52xx_psc_spi_of_probe(struct platform_device *pdev)
 	if (IS_ERR(mps->psc))
 		return dev_err_probe(dev, PTR_ERR(mps->psc), "could not ioremap I/O port range\n");
 
-	/* On the 5200, fifo regs are immediately ajacent to the psc regs */
+	/* On the 5200, fifo regs are immediately adjacent to the psc regs */
 	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
 	mps->irq = platform_get_irq(pdev, 0);
diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 0031063a7e25..762b1c5c6f75 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -226,7 +226,7 @@ static irqreturn_t pic32_sqi_isr(int irq, void *dev_id)
 	if (status & PESQI_PKTCOMP) {
 		/* mask all interrupts */
 		enable = 0;
-		/* complete trasaction */
+		/* complete transaction */
 		complete(&sqi->xfer_done);
 	}
 
diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index de63cf0557ce..dd87cf4f70dd 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -899,7 +899,7 @@ static int configure_dma(struct pl022 *pl022)
 		break;
 	}
 
-	/* SPI pecularity: we need to read and write the same width */
+	/* SPI peculiarity: we need to read and write the same width */
 	if (rx_conf.src_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
 		rx_conf.src_addr_width = tx_conf.dst_addr_width;
 	if (tx_conf.dst_addr_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
index 0d7fadcd4ed3..04b9377a2802 100644
--- a/drivers/spi/spi-rockchip-sfc.c
+++ b/drivers/spi/spi-rockchip-sfc.c
@@ -111,7 +111,7 @@
 #define  SFC_VER_4			0x4
 #define  SFC_VER_5			0x5
 
-/* Delay line controller resiter */
+/* Delay line controller register */
 #define SFC_DLL_CTRL0			0x3C
 #define SFC_DLL_CTRL0_SCLK_SMP_DLL	BIT(15)
 #define SFC_DLL_CTRL0_DLL_MAX_VER4	0xFFU
diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 0bb33c43b1b4..f1e0c16e8136 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -192,7 +192,7 @@ struct rockchip_spi {
 	u8 rsd;
 
 	bool target_abort;
-	bool cs_inactive; /* spi target tansmition stop when cs inactive */
+	bool cs_inactive; /* spi target transmission stop when cs inactive */
 	bool cs_high_supported; /* native CS supports active-high polarity */
 
 	struct spi_transfer *xfer; /* Store xfer temporarily */
diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 51a002b3f518..2771fe1397e4 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1353,7 +1353,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	/* Setup Deufult Mode */
+	/* Setup Default Mode */
 	s3c64xx_spi_hwinit(sdd);
 
 	spin_lock_init(&sdd->lock);
diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 831ebae10fe0..233ebfb8df5e 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -728,7 +728,7 @@ static int sprd_spi_setup_transfer(struct spi_device *sdev,
 	if (ret)
 		return ret;
 
-	/* Set tansfer speed and valid bits */
+	/* Set transfer speed and valid bits */
 	sprd_spi_set_speed(ss, t->speed_hz);
 	sprd_spi_set_transfer_bits(ss, bits_per_word);
 
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index ed1393d159ae..04838b036e24 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -542,7 +542,7 @@ static int tegra_slink_start_dma_based_transfer(
 	if (tspi->is_packed) {
 		val |= SLINK_PACKED;
 		tegra_slink_writel(tspi, val, SLINK_DMA_CTL);
-		/* HW need small delay after settign Packed mode */
+		/* HW need small delay after setting Packed mode */
 		udelay(1);
 	}
 	tspi->dma_control_reg = val;
-- 
2.34.1


