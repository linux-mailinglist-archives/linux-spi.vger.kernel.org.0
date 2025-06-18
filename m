Return-Path: <linux-spi+bounces-8652-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CE0ADF064
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D098818960F7
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041312F002D;
	Wed, 18 Jun 2025 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Hueb3A1/"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19011030.outbound.protection.outlook.com [52.103.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1152EFDBD;
	Wed, 18 Jun 2025 14:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258474; cv=fail; b=f+R1u2lXQQGMyENCbBTrcUoV1nJ9b8XaIMsPNpRylKCLdlQnh2HBZvtgjDGSSJlvVe/1UqFtH/20ivllF5IRF6Gy3iCDahfpOjwV7WYeLsOAP899ZfwNqgG9vOUU/JACmVHFiaeHFwnEtxUiXAmO8iPE+VRLilvErKDN6POBLkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258474; c=relaxed/simple;
	bh=QzsObPDe0hb+WQJDHnOLY335gCUeVWErOu4PFbXiXWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hm8sJhiV0gMOl4UwZmzULdV3X4qijPjAS40fuPFbYqqPEWK6LmX46vrbq7xdU3h3mUcZltH3s2rT854C6ctPPQAeCyGoMZSDDa7hS1x4YGaVwpYR4l4qt0snEBSteD4kPFzgWxmsPvywlPPKRIvzfLYGf84oEUbz0EOhyRCZ0sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Hueb3A1/; arc=fail smtp.client-ip=52.103.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FyBMn/MmBqMAjh/X8kIUEVBlw6pEAbUBVezbSRMbAVHfDReNQksuUeZ4EJvOCLjUj9P7tccubgieh6rO3NfbMR8hmlQ/QQZpUsPvosGCD+Ah2o5zzrSNqL6+JZZlXPCsFdUNtdODgC7Njm7nFQ9gRlRonarDHb4g3JwpShmVG29v8+mjj/tKXxyCKzFPq0AnUcz1keYGmeNTgZ/ZuW8RpmSUK2e/Y9cy8jGf6JwEzwKvrs8eq4RoCplqWWevm3i2cikO4w4HPunhfpzEKawrgGmAbcQQ0zQWmcyGq+2FPpa8drAjJQqJ1aXnNTbgotYUxdfT5JaBIwDBzISrUFCCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCCA/1PyQ5iZB/k9G3ARp2efI7+rSxMr4FliqPc8Fhg=;
 b=NJxqMqmX1e0X0/3RnnecgL0SlZCXKgU0URWTjGrN/0e576IYGULHbgZDcjQWI3O6EePQIdrGflDOhDUyROdEkVcC+pG/oKgvQYcjHtq4Nj1r8qJeNJoQum15yIxKsp0cM+EWgqqlEwTIUI3saGullbgzBdxpb86Sx+6vkJscWzDjEZZE+8PqcMMTh4qQ/Q4XWt05a/EuPNx+TGuw3uszCJbMeYoGMRH1vo/lLSbibmLEn8RWJtwLAIVv3O8q+cJzMhIE2bgF4+avgujiGspqx9AXMyhSeGy7u6UE3wZS7Y1BYE743VydeyXgKW7upbDeX6voKpsQl7MM4IIH9e9Jrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCCA/1PyQ5iZB/k9G3ARp2efI7+rSxMr4FliqPc8Fhg=;
 b=Hueb3A1/KtuQYbOpDBrTR9gJXRIthD14biunAQxogQ/CqWOj+cHWCMKend/6oBf42uu0tDu4BQMTJzzZShQYG4dnKe6zN4bu1+8iLUlPC3y9DFUu/zKN0zVcgeeXrE6XaMZcpQS9tGI0KcuI6U0oydV5bD5DduBnmVzZPaZWUmaY1FyAyrF06H4XaiV3xgbhbtsyjqncqRMkmlEYHdpZTkx38oJ2YYgJOlewC3147ya+xR7EQQZOZYKJz3a0fftrJ2+8fL6VrRUBxbCmnhIdvZHC19EkQupbAemw5wRSDATKOdx4PIHaJgiONRgjlWip7y/JBw+mFZjapKKjjJ28VQ==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:29 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:29 +0000
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
Subject: [PATCH 09/16] MIPS: lantiq: falcon: sysctrl: add missing header prom.h
Date: Wed, 18 Jun 2025 22:53:22 +0800
Message-ID:
 <OSBPR01MB16708393AA147F4AE8EB0597BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-10-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: ba264bd2-f529-4578-9141-08ddae780695
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXdOCGMQvEehcwH2Oc+BmMndM3rdnp0lXOwiGdtvz1mhtlLpFSKfQMFtaUAM70Vc/R2f6JFILYa/PKmgw7XEloqj8sqv+9u6+GI4bIVIsvF1jt6QXvUnn1gBOq6CmKB5vyhL7JdUCWf0h6W3aZwWlzYLpiZ72tu5jgS82f03po2d1N1tWkQb5NEJ+/DOyVqlX2bwLR4dXJ8Wglo2H3PidEZp+lFBDogUUvMR6V2cMOFgtdGH4c+ofThRQShPpxsaqmflLL2r75uCNMKE8Pq08YHYGaYYWSK/WGbE3p027C8qqDzzVwqivo7FWXmYzo5onX4J/1Oa9rr9mBGIa51mPbHIVi4rlGfOHmSf57BBvIuoRPLZFV/r0Kj+TscouWUAtVxrtVOfe63R6+vjETdqFqp+7nNdtTOn1k2z9R24IH/DkCgz/mqCPn9rko+eo594+mR+n2WfC2eOk4GK3HAbloOelNDos7FwgJZe08jsvxXi31ziR5lEI0j6Rm64VI8XyI7gl/eA2EpVRccSpMRA6VE9IgJ62cFLrvZKwO5eyiOpDxNh+IBeAOT2fAt5K/6Ham9pdVvb9/5D4Xc0WnPNYoshusizErkwWkxyyQ70xITCe5tpLeMv1zqB6Cs4UqyggqrIbPnsWsIZY+SWRjyD/8gRTi/1d76Jc3Wyszz3sduKY9QrAY06TGHToJJDZMFyMprlmWf1dTAS+ScuEt/Xnr4w5XphoY3qiqzePweVN6ZYBQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|21061999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MC9B26V1i4TfPuX6r/Ro2JnjlZmarToPhyc1N3heVMDxGxuiU02Kn2JvER9Q?=
 =?us-ascii?Q?e+p8khYffplxeoRyyJYikL4wcVl9TC0X3EnBSnGAKLiCEKZezxDAhahLIx+y?=
 =?us-ascii?Q?VlKgSAx0Z9KmLUThX+GEUCPBtEcWd+rXnXuLO5r3ob+Q1zOnQo40yeJ29MUk?=
 =?us-ascii?Q?IySX3e0x6SEsWcKxYWIQ8MTX5Mutex/7y+HDxsHfLqiKr5UQPGw1MS4c1o2z?=
 =?us-ascii?Q?XNgVS7IPXftqgQbGR+/1RYQmxuwWjmUktZwfrhH7ZWLLqIItFSf6O6rzh580?=
 =?us-ascii?Q?KwjEdN8B4GJATdF9frfiYfJUYiEJHyARejon4/t/A+tVFkS+Z1kAzpXqKt/e?=
 =?us-ascii?Q?20uz8c9mpIosnNu/QAe8tjo7JP9mRI/+rXuNd/eH/my6v3CcQfiQ4Htaj2IJ?=
 =?us-ascii?Q?ZHBdG8gzjpYzTEQ3IdAKtje5Lj6mED5KaPofS2/9FUQmOBX8dwtHuFI77rwt?=
 =?us-ascii?Q?zqVO7MtG5K+YpFGZz2x9qVpavTatboQ3vfX7w1wAcBO53U6NvNUMP2odDVjs?=
 =?us-ascii?Q?kv8eXDFpJr+/qf2LKGJWjFzKnjv6wK92ZxC4py8vztvVlLJisk6SkpNjzCWN?=
 =?us-ascii?Q?5sB1FlryINhGcKM0VlzeN7KPdQOJBl8Hs1ZIeV/AmD5oxYXkN4m5Fx/FDSsd?=
 =?us-ascii?Q?kuGvbLDIVKxcFHcisZEIuwRIgBfyym52iBMgcrYiWZ7mz2DJunJG/i5AWtVV?=
 =?us-ascii?Q?xUJdRdTtAHSUnBlECg5bXJ39bElVWvm/U1x4jbHqRfvGo5GH5jXdYtULEDvC?=
 =?us-ascii?Q?3LZpt7zzEY+ig2Y1/9QSPDwNaAaqBLVC1zqL6l3FSBXhLBFGJ0l19mLGR5/R?=
 =?us-ascii?Q?XzumYGECFFUmuP0X6JgXrCMQx0qejG1FSB5aCK65hh4MOMupd+orOi4/1Ael?=
 =?us-ascii?Q?xrutS+awy8dcqB/xpC8h+n25yfKdCQdGAAxnwKTGaNyaCKKLkQhYD4SxSUwV?=
 =?us-ascii?Q?ux3akZ5qPp8vhl9jhvqui1PueVaw7ZgK+HpujS+N0H6FyAo72H/gYUHJc0eC?=
 =?us-ascii?Q?yYnKuqcxuGt0AYyo2Kv+oqrKPSwRfO2x87GH3/2qe3f5PNhXivGmBhVr7c6v?=
 =?us-ascii?Q?fqs3QgIudTJbOi2l+HIOHx8U/S4c+40vJzHdTi5jYQDXdiTF8nHRyPtaYi1T?=
 =?us-ascii?Q?vhzROz0ljR91nbhV4sI44AX2KypTfY3oW9Do4lG13QR8GHbEDXLjqu6+eOea?=
 =?us-ascii?Q?P3WDu4cUQxS0l1GzWnvi3H8DzEekDscScFnFAAWOEXzvu0Y3UVnl3zb94xQ?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w7nxTsMuPIokqABpoCt66oOaJhstMgDoKLaNoZvIUNycKKhRUJSQ42Ifpkkj?=
 =?us-ascii?Q?gjRONxEnxyMbmM9nXma96OPe9gqQdwbgoZh1J2eQFWoxi9G/fEnIomQWMT1z?=
 =?us-ascii?Q?UiOYIFoqAzDPinF0/J0f+GxQXEutUYN1sgFa3jfl6F0ZPE17Je+HfcK6txeq?=
 =?us-ascii?Q?/5EyGHstB9qpzqYLKnqlMu9QQ8o5c6tbXa84wdagHJUjEIr57V8ltqnraJlB?=
 =?us-ascii?Q?TzO3+dpmkB5wZOajHLZQ1+VMKd4wdORsQMZVrx3n+BlNUDWbrbANK5Tz9IPJ?=
 =?us-ascii?Q?IaQ+HdKv/5aHF3Dd6RDvYFUn3hViAK7nopISXPJsCV0ib0qcrC9WpxkaFqu5?=
 =?us-ascii?Q?sk65C4db8fOifB8p+rskVS+b7F0GkdJ0QtEnp3Eq46dEsYaPS7K4YzOBKNAA?=
 =?us-ascii?Q?7e6TOKrm3khxdnZcbeO6fXsTzC6TiHK1v9Gkd+/Vlt6BrdAkVz/MGUOoSLLF?=
 =?us-ascii?Q?8/z8PFxR3W0ZDbXB719Pg+xw4JZXhbG+N+TNQtXqojvMfjK6JE0L5XdGtmFW?=
 =?us-ascii?Q?Dr5o3Cxbpr64j1ZJMEpQ8HjOvgEmFhxF8/Zl16rRyI7We/CFp/MCVvauVcMB?=
 =?us-ascii?Q?/SQLBwMfB3ANnhCVqrspxBGCm7NUalTBSwJjp+Wq1K08f3cUZqjicZJCHmAC?=
 =?us-ascii?Q?/M9/iWi/4N7VF1CZOWG/9GbD2WZx+YkcSw3eencaojsYe4kb+Ei0rxKQlzdP?=
 =?us-ascii?Q?UutUNBj31kyjibAozSrGwv6biog4SVsJccXaHIttof4IfMtOn6suyXPVPbkO?=
 =?us-ascii?Q?b0oGQ9jtyCtPtw3CL2uVkCHYQzm1Eovl5N/VpmQoYbnkqzBbT01ejMBlGfz7?=
 =?us-ascii?Q?NNuhRX1J4Dwh/ShnvSMm6T2WJTHHj2/B7H6osoCVT5fvH/o/AprZGK6WJqSA?=
 =?us-ascii?Q?BcKMvI7lOQlRRo9OzWtBFlOuoyFC/SnKNfHFX20SlS0p0VpD1CbTv7gEhBNF?=
 =?us-ascii?Q?aFnfwY1uvwfljc7OcmCRKOLv0sscpdvm0oeRtZyiiHHPw0W+UHAhrIX2AUrd?=
 =?us-ascii?Q?wV0WI+PQc2Rp99euW8hjlW29VkYyA+XVSBZYMipfxQ1/OSxW/c9nzbdZHCpk?=
 =?us-ascii?Q?QjM8K59cN246sfHVj7AYNHjqPPu0CWntHA0PNxvrPJINpFNJnna68ECiBQqw?=
 =?us-ascii?Q?+TRKzpJmHVeOt0CFJzzSvhORhcKTiGhPKPGR4vuuo+aYapkYtWd8pdZJs8te?=
 =?us-ascii?Q?EMg2djHQOnP8mk/tmR9v0x8IuHgbJWjGuqZamdqa20X9rEdWzZsAq4+Ti9v/?=
 =?us-ascii?Q?nRWk3byRkwwx1tCC/xWI?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba264bd2-f529-4578-9141-08ddae780695
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:28.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

"prom.h" includes the prototype of ltq_soc_init(). Fix warning:

arch/mips/lantiq/falcon/sysctrl.c:185:13: error: no previous prototype for 'ltq_soc_init' [-Werror=missing-prototypes]
  185 | void __init ltq_soc_init(void)
      |             ^~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/falcon/sysctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lantiq/falcon/sysctrl.c b/arch/mips/lantiq/falcon/sysctrl.c
index c65f05115..9a8616c36 100644
--- a/arch/mips/lantiq/falcon/sysctrl.c
+++ b/arch/mips/lantiq/falcon/sysctrl.c
@@ -14,6 +14,7 @@
 #include <lantiq_soc.h>
 
 #include "../clk.h"
+#include "../prom.h"
 
 /* infrastructure control register */
 #define SYS1_INFRAC		0x00bc
-- 
2.50.0


