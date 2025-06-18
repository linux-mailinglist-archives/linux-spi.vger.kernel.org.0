Return-Path: <linux-spi+bounces-8653-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396D8ADF068
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C95B4A1D76
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2225A2F003D;
	Wed, 18 Jun 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gj8FmdEp"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011030.outbound.protection.outlook.com [52.103.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE452F0030;
	Wed, 18 Jun 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258477; cv=fail; b=ISW07J6plOvzDEQawRKF/hqDGT7Q8hR6IGq31jyG8ahKyZAOtwLW9aKLr9qLzMUH9tnjS93yja1eWP6W0Z4X2QOSxMQ1PJonI0CC7Uul+K0Qzwnx8HBrvtKXZdJxDlwXiSZGqJNgS/gEqterfumDqQjMOrn200g7/kJeM18znzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258477; c=relaxed/simple;
	bh=R6d/HgluwGsLB6jR805UHhUiRU/gaWzgMCLEoCJ5ae0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CsbHQI0r3ZW1KGbAOL2Nx8VkEzpvkC812jr+chQTV9NGZ4/nvvE+DckQNp2ZC6f7RHWPreIJTJkXddDQUAkwvIloUoy8WlE7O9kDpxCpTujwpHAU+Ku7Tk9zeepQa1HBgOwdU2ovFSTthbYpeRyPaKFmwlSK4GJt85FzaDYB3dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gj8FmdEp; arc=fail smtp.client-ip=52.103.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2Avgby8kpTa/nJx/1GLXDPIepSIB36FH1XiWmIEfZU5Y1dsAz72I1od7vpTSJ1O1uArlS9qa+dFoN7Eg4Ey2xmm1s1sTyhxsVhzTwNUQyqauWSqt8VCzqq5wOWobi/CjIk/AOLCRh9jBpwk5LZjEcwNTR77Xs4FKqr1ABby6ixqNDVYZO6KzUxMQNyJz1wwqjzuj6ivado/nINedQmy5XTPkd4EtqZVOJoEa2crs6Rc0fzlSqklM21ZU8frGiIairUFP/Xzkie92km4dsAa4ZK/gQAFhl3+rwWLyG7jpUKywxrJjeCKE4ITvDV9KOFTjJzVlx8ityHTR+72+GHZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvqmF9QhxOkfBYjaq3+G4zBJpxREmno382VaJQBERRg=;
 b=VJTzweay42rDz5g48jO5EacNJ1jTeOiljNHSn/Tyc3INTnqoyQorZXJCgHMEV8Lzw3ZJ/od7HoGSp16p/bR5sJ2+bw+wiWMbQfLDvgK0eLEzj/EaX6125/FHOFAhf8f1py42nQwKW9i1zx3UAlvSQ+XHkaQqOuDPmtKyKcYVSE7xVTfsXJ1jVR+yNyWnS2YmPesd1+BqswHA95XztXDnBzGQxkYf+OUCJyxmCccvS1ndZdgQIqWeSTIe5XNPFHtqUxTaCVbbovsVq9b4r++js48tuFmmHTuTC9rPUUsdC5ckw5q0KLh1kQw2YCXksLIqwbSl9dg71ydwjIDnOvygvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvqmF9QhxOkfBYjaq3+G4zBJpxREmno382VaJQBERRg=;
 b=gj8FmdEpI5SGWHEA7ppYRNnafEL6DGISd7b8X1+rev1coqEC4eRGnfBmswSS9/pHo+HivJdyj7ViPNDoClbxkSKk0VaDocw4k+BQHKRU3P9VIBTgWrDHT9mx53hAQfhC97aM75Eo/pfsg5TY5r0hlOJBnrghO8TQiLMcgnb5PGOh4FvY9z17gExPKbADtRZGpCUX+I0lHAE2SUhhZ1Sq7N4qjk9Egb75JoNzWgNssNkhdOSOD5S/HT/I+GIDOHrzEWjdnsUWuQpqe1iEnRGec4dc+ckFWAkIVhO3riPIXsyzKiLZLxMhmdGktP8GGLW77n0J/+WzzXj7lLyG8HL1Vg==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:32 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:32 +0000
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
Subject: [PATCH 10/16] MIPS: lantiq: falcon: sysctrl: fix request memory check logic
Date: Wed, 18 Jun 2025 22:53:23 +0800
Message-ID:
 <OSBPR01MB167032C73DD1EBE50D0D1263BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-11-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: fcb80fd8-44a4-4cb8-8f4a-08ddae780890
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdHA2vyy/2dHnS4olwKFkARfxcHknqgApTqPEIOZnlbjKwb553xLDJxEVM6C1lKvwmeXt+OarJcWYFT2hkKuPzPy/QJ0wZJn6QfXDdyGWOgr6SWErl0KQyAWFcKHNTAu7ZzyzKbPaPCzhAOxd19lDqvu2tDsropnhRxwN9AOb6Xpj+ArvmcwzuSjnJrI5FXZssmC5G5djMXIGXVCy2GUYHw+IwsWuYsjMKZiRu6ShFmGoK1qM/x0L5Uvxc4Q8nIPH2opzkzU89OeS9k6tTrryWWowB/+siYp5QZ7NGTnW+hS+Jxo6/lOEcbmhA6Nr2NaD1CllzOeppAqtCG9GE6iYqj/HJN5jHEN3EFnOteq8mVIBkK2WK24iOtq+gxXznJCRJljLHb52Z+JwtcV9/dwlsn2owvt6Q3uhDqD77q7+yh04p+bREt+Eyq9gqDDsHBIsjZmLzSoUuweXbjHgNqGifk5jPEL2AUNVZgONU+RS1KxUgk19OXfRnSRzCBpjqT7O/7VlIogv2eEEalItxska5PdfvwqhBaoKeoHE5Csxe76gQ+kX5f/0fPWjeK/M3O5RHElpFTsN5/FOXYI6zd/G8Ry2InJyIFfR1gafNxiIW5EDjSWTxHN8AW7zNEuAoEkmWWqSMgIoPQbUwKb60NtUW3FzJWlhi9mP2awRXT1VgzDA6YFzuVmRhGFeJxjZSfAaIb2IlJXaQBn23KJZl9aqHGoKdmhfANVmb7tHg1pYfmnY=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|41001999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PB0Z9KOpNq+9I/BAhqvUaT691yd6W3D1sbRAEWdoWALhzdTvTiOQs70Kun9r?=
 =?us-ascii?Q?8vw9Lw152Cyna+OIbEhe/ONvw+1AhJr5Y0Bw1Xdo32iJE3onGtt0sKXkL2eJ?=
 =?us-ascii?Q?09lzn7vDgVAj43N8m9nSQole85ib5nwC5O0vus+8754N2ZA/xod8cLPXPpSp?=
 =?us-ascii?Q?wfjRLvV0KKMqQ66PTg1TolcNM/9UqeoLirpW8xunv6NEv3hXQD4zmjVhATUk?=
 =?us-ascii?Q?JwRoGDgR7kd83FdN6jk4rozeklWmAYzgyEYrcJBp4/3XFVeIGZ31tiBGGYwZ?=
 =?us-ascii?Q?e5aauRGPuP4kg2OddxkESz6kaZpyfujM/eVsrViOLkbdlKyvMKyksuHF9TlW?=
 =?us-ascii?Q?d1jjfeJlJbhmTHUZbNew5ypZKgrMZPNpZcb6D6dfeHaDjfpgl6jBkRHlKnpX?=
 =?us-ascii?Q?YU+s68WMtXLghCATIvzv62FmqJPqi5zymKMyNgEtFFyBWDlL9hB2hyabMz+b?=
 =?us-ascii?Q?McglaNc/BrjR6dY1bsQ3uOs74E6hbbul2YR41Pw7XuIqC0vGTLz5XaDyMu9M?=
 =?us-ascii?Q?z700XCemF8czobl1pkhlruby5SkJzBXoBpJhTzOmxaRF46XleBWlhVN/bAyg?=
 =?us-ascii?Q?gVQM5uWGE6m8MzBkwyxF7IhQWP0avtd+iNndMpLBKtAwX9ryFJzkQoyLwFzC?=
 =?us-ascii?Q?m2nXnmHp9fIYjuzxVvRgdxB1PxuyLsu8z+o8raX5cz5p12qp1MQIlv7jUUSs?=
 =?us-ascii?Q?cqN9DtC4dYD8lQ8cSBECiJTJCSjVcI1dv+Tdz54kqCCghHHmzhm6VfKJVQxZ?=
 =?us-ascii?Q?OhNZd9dDFwPLJz59fqMMHQk9QU5FxEEDjUPnSBkbU4KdF/Ao3oZjBhB4weK2?=
 =?us-ascii?Q?Yo6K2XhWBt7VvMbuQauzcFJ6BRd6Xs+tYYrXc3m+DLx1byNzuz9hGH8+eaMn?=
 =?us-ascii?Q?68EMpniUOWeCiz9mRrO+z/KdYEambn01DDtnAYt5agRfNVQWiqMB7ZXJmKz5?=
 =?us-ascii?Q?Z8VtdhcUHlOWxoJ3ehpUsxgiVz6xm6iGdrTeq6goFHdnuqER3SmIz5AZDGSx?=
 =?us-ascii?Q?v0DCjloEH7xHY/IGEbR4YwKhkhbIOeIEtSFQmrxuLNGFSmgQFcXn7pIytzYG?=
 =?us-ascii?Q?5e9c/4USLdJ8o9lstousVd5+4YS9m+aKEC2CkoE07tQV3hucLgisBaCFXZLY?=
 =?us-ascii?Q?PmvEVxcnLalsQLP6DszaR7V/c4wyU4VlAKqA4pBjfoRgnLIJf8+63HTcLH2I?=
 =?us-ascii?Q?mHCyTmZbFq5c0ryRfLrSyRZkSSUVdhGBobC9+uFZtMGVZFxvFb6sKipnoos?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K9tdYICyciYDcZZgvvSwYEl5DnKY/fE+93qgAg5bbtPrXlYKhnyc2HpKveGp?=
 =?us-ascii?Q?WGI9+KTBLL7yjQ0I4cLzn4p8O3Fvm/4YtsTAmHhuOIT4nZjWO8/l0gVhfssm?=
 =?us-ascii?Q?sNYpLj2K7Q+i8eIX0DQJh20BJ4s4GGmia6ae7OpUEqIqUvoG4AYjlsx9YKr4?=
 =?us-ascii?Q?zJAW/F2NdBmbmz/g6YYPy0whlh1SC7yflE8hdbbP2To1PlvpfEcMQ1BLqMEs?=
 =?us-ascii?Q?9dd5Yq8eB5Ess0hH3hf5j550O+HgeLbzjCURpnTSnUDP8A+A+EcDmfGfh8vV?=
 =?us-ascii?Q?OI1t5cEBLfVmVL1b0p3p7J+muzTqILRJ5KYb04ROeMobReD0uhYVFiJ44kMq?=
 =?us-ascii?Q?74Lk+KhChZ45XZaNh5CnKYmSMfgXEK2wwYNte/DUsrbXacYj8r3Hz9AktER6?=
 =?us-ascii?Q?pV2p9kpDroPIVfO10mhqT30PadqlfE/qnQ9CQ4PtzsQtaQv7QfKrbsluWfda?=
 =?us-ascii?Q?ZSbN93K0y6PyMl82/RO/ii1FBgzTEQUAbo2Wxi3Fs91mG05Xaj+/TAHDjZ9H?=
 =?us-ascii?Q?Y5NbUjd9aYxpq6kGzB27Iq8G5P2puogZ9r0f1bNjG4xX55V3PZ71T7TnODy3?=
 =?us-ascii?Q?mxpJT8W9LWbu8Qg4UmlnaQkHnqoru9t+IS/DOuFXrhRB2svxqhr5ir/o4KV2?=
 =?us-ascii?Q?qx+j5PHyfOSb8O6IArf1T1vILvmfPZno/AHfqUEI/8ffY4IkEmdrnhvUarAe?=
 =?us-ascii?Q?1Cc/r2e8Nm5eKLS+rdUbqw7h7f57Pto/X0yUjX9Z4wmfxBQh/WonRpCbhacG?=
 =?us-ascii?Q?9AUz4d7RDtTrDKa4ueocQdjtwbp38WsLdmCxGEUt/ZJI+feXJJ0dulUEmreo?=
 =?us-ascii?Q?AfYws9LQ6/vzmgjqfdpm1so4ZTfAVZ+soj7G02ppcFKrT262XePlFQkdAxj7?=
 =?us-ascii?Q?SSho43e0lRPTs9bh4mZAuShpkMjGH7yVjajuF74xnz2qSTbaSOr95ePBnMpV?=
 =?us-ascii?Q?ehsVIZ0ynDyhBaPwZSwgCY+zwF2grvuIAju6RdqxuSFJvEz+9TNeRWDol0Pz?=
 =?us-ascii?Q?fBoWl0SA+xvOqMjk8ApPBxELbSRbdpr9OyYjvE9HBlSIiJBVN35iN3jPYzWu?=
 =?us-ascii?Q?QqR5OAFCgZtm0UYVVEkk0bJW9cCRGZ5zsGu6I4QuOguEqB8DW4vIi15UiU/8?=
 =?us-ascii?Q?kqXAwiLEKhdN/6t/xbZ1iEbqm+NUJdJeVt+24NrTrlCB8/g7RruSB0vORmS3?=
 =?us-ascii?Q?0BvD4gYtDhMG1xdcMl0bQhVTH0Ndpsv9LHnLvylfDO4jNQCQa90+dU58E4e2?=
 =?us-ascii?Q?HLvSiV1UJfI4vjdyVYGd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcb80fd8-44a4-4cb8-8f4a-08ddae780890
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:32.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

request_mem_region() will return NULL instead of error code
when the memory request fails. Therefore, we should check if
the return value is non-zero instead of less than zero. In
this way, this patch also fixes the build warnings:

arch/mips/lantiq/falcon/sysctrl.c:214:50: error: ordered comparison of pointer with integer zero [-Werror=extra]
  214 |                                 res_status.name) < 0) ||
      |                                                  ^
arch/mips/lantiq/falcon/sysctrl.c:216:47: error: ordered comparison of pointer with integer zero [-Werror=extra]
  216 |                                 res_ebu.name) < 0) ||
      |                                               ^
arch/mips/lantiq/falcon/sysctrl.c:219:50: error: ordered comparison of pointer with integer zero [-Werror=extra]
  219 |                                 res_sys[0].name) < 0) ||
      |                                                  ^
arch/mips/lantiq/falcon/sysctrl.c:222:50: error: ordered comparison of pointer with integer zero [-Werror=extra]
  222 |                                 res_sys[1].name) < 0) ||
      |                                                  ^
arch/mips/lantiq/falcon/sysctrl.c:225:50: error: ordered comparison of pointer with integer zero [-Werror=extra]
  225 |                                 res_sys[2].name) < 0))
      |

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/falcon/sysctrl.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index 9a8616c36..577e6e630 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -210,19 +210,16 @@ void __init ltq_soc_init(void)
 	of_node_put(np_syseth);
 	of_node_put(np_sysgpe);
 
-	if ((request_mem_region(res_status.start, resource_size(&res_status),
-				res_status.name) < 0) ||
-		(request_mem_region(res_ebu.start, resource_size(&res_ebu),
-				res_ebu.name) < 0) ||
-		(request_mem_region(res_sys[0].start,
-				resource_size(&res_sys[0]),
-				res_sys[0].name) < 0) ||
-		(request_mem_region(res_sys[1].start,
-				resource_size(&res_sys[1]),
-				res_sys[1].name) < 0) ||
-		(request_mem_region(res_sys[2].start,
-				resource_size(&res_sys[2]),
-				res_sys[2].name) < 0))
+	if ((!request_mem_region(res_status.start, resource_size(&res_status),
+				 res_status.name)) ||
+	    (!request_mem_region(res_ebu.start, resource_size(&res_ebu),
+				 res_ebu.name)) ||
+	    (!request_mem_region(res_sys[0].start, resource_size(&res_sys[0]),
+				 res_sys[0].name)) ||
+	    (!request_mem_region(res_sys[1].start, resource_size(&res_sys[1]),
+				 res_sys[1].name)) ||
+	    (!request_mem_region(res_sys[2].start, resource_size(&res_sys[2]),
+				 res_sys[2].name)))
 		pr_err("Failed to request core resources");
 
 	status_membase = ioremap(res_status.start,
-- 
2.50.0


