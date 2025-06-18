Return-Path: <linux-spi+bounces-8647-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3294ADF054
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16EA3BB882
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B868E2EF65F;
	Wed, 18 Jun 2025 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Px5azq8y"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19011025.outbound.protection.outlook.com [52.103.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC72EF651;
	Wed, 18 Jun 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258458; cv=fail; b=r/FYxdR7Dr9usT0RerfrZ6SsHRoDL4V6MplyknvKHMMnZmDd6vPAglk71MH4Cx3Q7JjczBG8x95HzyvK5lG4qaOrahCO/vm2l1S7/5kaMZO1jmbL8XzGHq6cIvt5sAhK1Gd7IeCxWGrJmR3D+O1SE//SRT11VGrLnFdTDfVVLsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258458; c=relaxed/simple;
	bh=EOTuiEsbq7TBWTJKJbRmBYmdLZUrxoVUTyLo99EQ8UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UxknGlYWeYIkyn/NR+KWNNwrA/39IwzdwCF0FIR2IjJHcCaBsFRhvfQVU42qoOLEG9O3p5M+9fbQ4UWEC35seVw9SaxIg/d0J87JAXyinDdHAx0RQG631xdQbpN139lRYnH/bjd5HfANsN3rtPDyjvLQgUJgNKh9y/nDRcIchPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Px5azq8y; arc=fail smtp.client-ip=52.103.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AYcxqWpi3VRzv9iGQ5EozQdnglEQy8WHYGBO6YXFjfLZGmxa+bm3bwztZIFbfS8l3zqeWbWlpBV5G/X28UsTMC1UWpdsBp0998LE4arTt+NXY4wkZbWQo66Q9EtoZJajn+/782ihR2INs6w46zFQfkXNf7plP5xXKHMKgWVsRrxFXLKrFnbsWV6m8j0hOJqouUbRjHBIp5j2LmXmhR6EHPiPPviHtRxEh4uw1d58qPYdNqAhH8BQIjKeVbc/1IbuJIFe13g3oj9ruPjMfJH0NufhHWYJOa+XjHSDGjEwW0FpEW6dGfy4tccn8E2E7IZRRiRXFQ2zckdZ6zqCYYtxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQXjAko8MVSI9AFMdjZl9QA+nPt7xs7dXwdpRmmVYmw=;
 b=Xpv7CnCalsDVulxd5zbP1YPVVybBR1CbiEzOvKKeiO6UxOsbUULBB0rKO2mv0BB0l1VasZS3/kchnKzrfMjKKKbr9Yqc+J6YEy/jjhn0EJ2Uzz8lRwc3OqWoUyGJQk9+Rvhc6kEjBVeZez4aYarILmuCTjATseMT/fJYRulk8ipToZDMsb/i5DI6d0xt05QZ4bW8kplFbjCg7FVJHZ1N+jOBd212vUPgYzn9PnzgAVcfqR3haDkXYyBWB68qVX3k3uPga5U8ySlXtGR19JVSqnBzobWmumN0UOb1awGYn7dgrIymKuNNIfqxvLw9bBlnepCfcRUWwuTPJ+QVfSp2QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQXjAko8MVSI9AFMdjZl9QA+nPt7xs7dXwdpRmmVYmw=;
 b=Px5azq8ycv63YuwydqZmGDoxCG4WLsERS27v37ylgPTrKG+yrXJxqy7g2ESMFxRwPaT6evqAQgCSQj75TifWwzPyds8XJMUt/JeVJcQcyD3z1efocOVT4OhRTshqUK70yX75cNE7H2g7P6gNIQ3EUbfqynWvVBnYOgqJqavk5ihLY+fcvrUaXNNppz/htXXhPhpD7A3WouA11v/bE8vN0FIWmZCzaGmPh2/mds7a4INGu67+1iWjU4rCWwHs7CISZsI9j1BSKUUjVdSak1ymxVvhd8WC8lbsAsgsgeSeDkcc49KVfzKCn2iH5L8dflCANvlp/BbrzAbwzQYJk8jy/g==
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com (2603:1096:603:2::18)
 by TYYPR01MB10545.jpnprd01.prod.outlook.com (2603:1096:400:30e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 14:54:11 +0000
Received: from OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f]) by OSBPR01MB1670.jpnprd01.prod.outlook.com
 ([fe80::c00:ec4e:ee7e:9b7f%7]) with mapi id 15.20.8857.016; Wed, 18 Jun 2025
 14:54:11 +0000
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
Subject: [PATCH 04/16] MIPS: lantiq: irq: fix misc missing-prototypes warnings
Date: Wed, 18 Jun 2025 22:53:17 +0800
Message-ID:
 <OSBPR01MB1670122F4E7373F4912AACADBC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To OSBPR01MB1670.jpnprd01.prod.outlook.com
 (2603:1096:603:2::18)
X-Microsoft-Original-Message-ID:
 <20250618145329.25517-5-yangshiji66@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSBPR01MB1670:EE_|TYYPR01MB10545:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a1afaed-9a2e-413a-d130-08ddae77fc3b
X-MS-Exchange-SLBlob-MailProps:
	Cq7lScuPrnodj9mcbuBOlkXQjsuE+OXd4SAkWpR8dw/gJPFfVEjQQGEnNZVYm6zp9BaZwgR6OEs5QbKE1OAhC6FlgifkOeoC9anavDJ/Q0iUtS39SCvQAr1fHf98bwXsjQpG+u8vsDQZKH+HDu01XgINbMp6bfIlU85th4U9cfVOwHY3LErRtK0f48qIj57l/v2kFKTICfPfrK5VrY58JXBHU8Yg5lELKkFCv62Uyy5JGyHee0MXtQpCs/WK/lKdQDPAy/BVIgeg8HRcuMoWJCX/YU9oFNYBcIFz73wiWSAakjTcRdJiUaSjUs/KRN+YlZ5b0puyQjXcHJPDIIBwqbUK59fbqtDxxfsqiOtRe+wOkA62yWv/LHXuM5M+jS2rHAs5El3Je/bjL0EdXOmtVoyuB9F0sM61YJxtkZSre2jn6QRJO3QQVf5arynzIB4B3dmS87yauQZXqg9CjEXQZr22b1o7a1dPSU9jMKfofIpSsM3uJfeHpQJ+zfdcj0wx3UBiZQkjHGR0SmxeZ7zcv2rSeCJlWw43FMJivPXPtMEBvxgrm5JYlCCxt3cDQnSQdo7+nKF7M0+TWNGWfkQ8NwRtVVv2qF2kXNEMSll1SpQjf+PUgSpNIYsaO1puv+yKzYLcCf2qoxsqtBjPLwOztEIwwqtM1jDabtIXdRdVj6+eR3HEWH92r+B15xKzFWZWYJNANRmzigvvi7T8JSI2kAD78pZXhnlHlttUfeybjxgAp7dW7lTqFbtzeTFZ5l1OMk+4Q4bL/bQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|8060799009|19110799006|15080799009|5072599009|461199028|21061999006|3412199025|440099028|40105399003|51005399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EyzL4PUo0dUJT32x8ux6843EZgQ4oof82DDQt5/swTfl/U6OpxQi5K4L3IDi?=
 =?us-ascii?Q?qxpCMy6h9OIqaQs0Z7XNfDVFQo6hNScX5u1nQjqm25zIgVCTA4bnbXlvF6ik?=
 =?us-ascii?Q?56Coaoy5PPN+T1B00l++liqIREkNbTfO+bKXeKh2KhteBeoB1odRnyXSCDBp?=
 =?us-ascii?Q?a54wd0xzqtdTl0OF5HfpbnT+VtiNsddZmyxyWFqPDuldlZko6gpKr/n69Ezs?=
 =?us-ascii?Q?9n06DwryNKw74SM6WTwLx5Elka0SzkBhvahLDY781axxu2KsHYq3UTesSxBW?=
 =?us-ascii?Q?d1hsKEk8ZJ0bp1mi8Ia3dIIFAsP0adlJJk10rn9bFv3TtnmYWkwGosQMXA3X?=
 =?us-ascii?Q?eESUucV63JsAlQSZBWaZ/aV0vZKyhCdN1crU71rrNcrERV3smxhQkEm9iwr7?=
 =?us-ascii?Q?GSB5dhVhVI/2YlUF/OP57GVWegWnE7EhURt9sciUAVRpRpnd8SXRs+n1FrzY?=
 =?us-ascii?Q?CXMhdytatOAHjl+4zI4VC2qEgCcFSLim+TYq1tu1f+Ebeiy3rHq7hiL7Qaxw?=
 =?us-ascii?Q?tYCjbfkPJxedoSNUro1Pt139ULAi8wdRuwwr6OxpDx5BO9uMCXmvPsnwBpsk?=
 =?us-ascii?Q?qe5hYeceU6UeefgbS/e38AMTEE8haaAKB5b64025ABiWOzpKGvywJ6sfxWsJ?=
 =?us-ascii?Q?fbWZ7DKtOVgEcdT+n1KQSuUHcZHeiPXZSsBkAsA3w0CvZOmFrF9qnhmD+dP8?=
 =?us-ascii?Q?qY3rnlkDoXe/lrENm/lAj3fR0P9Tqy9oU0kWrue/j5Rcrf4hwD4SUa75ey71?=
 =?us-ascii?Q?pR0KHGcUz1TVMRBq6bz6Mjlsoptd2NUwLbrDulVgypcb+r6YlFCOmU90AxiK?=
 =?us-ascii?Q?xB0KmNDb/w1lKHkLZSlofxNoJS+PzRE9U1qACrtsZiRrqWLRBbO7v7KwKd8t?=
 =?us-ascii?Q?kiuKCIIw/JJERlNXpidu2GTN4qSRj2msAmWMA970bp9IRuR8P31c2kQs89JD?=
 =?us-ascii?Q?ozAraaXZHGf9DBKVCsrBmXNvIdb6cGccoHlo8YVK8w+6YTo3tjGRGKrGiCIp?=
 =?us-ascii?Q?Y812Cq+CVYEKdujwpKjn13yrIGBOqTX8Gk/sRvbHHYH9zjC8Vmo0kofad1Ai?=
 =?us-ascii?Q?BTpAaw0oXxzTscGO+zLgMi2eufcL4WHeZH2Cn6Eek9NWheF0e9rYQJEszmvA?=
 =?us-ascii?Q?aU1GUU4L7ZWs1xevT6tA2TL8kn9/IW5QVuODwWRO/VcWOfGn0ylaRlaiqBGQ?=
 =?us-ascii?Q?SHCqhkS6kbsEw7gflDsLFlaezvb037q93s5fiwMg98xE0BuYq46WYWuZlIQ?=
 =?us-ascii?Q?=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hI4fxISIWd5jev3hNFiqy38XWt32Eqi47Le4b4vhqhfK5DzJ/E/ijdiLZiQj?=
 =?us-ascii?Q?gkHPa37JnLDr6CtzbGpuRYknPLqKFg7LxiXQ7lnrm3QzzWDTZ6wwdHk58xcV?=
 =?us-ascii?Q?ib2CkSVO3XPmuraMMKLLl8HROQ01T1n4wiQwZh4tnG9CG+XbyyJFXKrQK0cS?=
 =?us-ascii?Q?QM/VIk+92R6y1ETU0c2urw1NQKxd7vhoNw+gXEr54tGYC043kA/6I+rKILaX?=
 =?us-ascii?Q?qPYkKUGP8abdKxwpLxqqG9oLsEcsFvJVWWPvIfHR3a635YeVUZ9XcD4ueiEK?=
 =?us-ascii?Q?ebrRaDQ4iZYEjjyNPTVoB3kBCI+3FX+AgmCzVOojMDKcbRXdZYIUfR6XB301?=
 =?us-ascii?Q?h1fkyl0XmVMiMCpKcDzNyAwVbIKm8DPqxnYK8gD7ip1AibBSIxCSC9MTt8A+?=
 =?us-ascii?Q?BO9j0XHU95oRt3q4UUXGo5n7+Fy7Oh/dZvaPRrb6ydS582NZmzHyDgnepn/u?=
 =?us-ascii?Q?aMVluw4FLcGUuZrmL4zbOBifh0I6AtoM/eMSfL6CNoz+bzzh2HK/LtfL4lsD?=
 =?us-ascii?Q?qh6oVacOnsNQwtc3K23N3bYnAyZ4Bun8+swwY1gsIusgFHvP33VYIzf3dpjD?=
 =?us-ascii?Q?sjW7KQFFhvRQNmcZt926y9C0VP7uQybxsZQMdSYphZ0d8YstsgiEmIiwwOUB?=
 =?us-ascii?Q?dvJ/1ftsmsHU5gGy1ybpqTjSNej+RXGrdDuY16buIpGs3VB6APdUNIdpX2UX?=
 =?us-ascii?Q?cYkrJ9PIEoT7xh8UjUfgMgFq5k8ZPDeEYytfhTm5LHcq5ZPAqZhZyOb8kBtC?=
 =?us-ascii?Q?9+ImM5YViOfFsswue0ASuQlS+74byHUTP2rlbjSs+ZvlUCRFW66bsqHAKqlI?=
 =?us-ascii?Q?aK+qwdNubxU1ztORy+3/xSd24Xg6u4hSieGD9ZNGaGfL65/ayKz8sNq1rwD+?=
 =?us-ascii?Q?XJIn9gbiSPAnc8S9XVaQNvNApa4hH4fI0Xy0SXWb97eChy21/K1wu8CSnanh?=
 =?us-ascii?Q?F2v627jxhthitSdJk/iJrNijBdEKFvukm7rnmv3xzzhGxcAMehMVl0L1poWQ?=
 =?us-ascii?Q?8waTNvBs6v2dkMeOFC1EpZuQCvkk7kbLXoZfu8QfmV6sorm87kVvj5yZmnFy?=
 =?us-ascii?Q?5Xp0619mIu5NfD+HHT+zvkKSMkg9Tikm0AmzljrcGCeBbKMWS/cNyapildf3?=
 =?us-ascii?Q?nm7s57qFlf4SDc1caeqroLm39ZCLUkuwUsajRUP8VOh0+A6MMXDutM3MD/WZ?=
 =?us-ascii?Q?/Pe6IbNfIbazSZXPoMrSKrp0CqzT/89sECy3dlMREkbcl3QOWj1fvJ2m0sG8?=
 =?us-ascii?Q?taMecgEuB6QZQ6EWLpMt?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a1afaed-9a2e-413a-d130-08ddae77fc3b
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1670.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:54:11.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10545

Fix the following build warnings:

arch/mips/lantiq/irq.c:340:12: error: no previous prototype for 'icu_of_init' [-Werror=missing-prototypes]
  340 | int __init icu_of_init(struct device_node *node, struct device_node *parent)
      |            ^~~~~~~~~~~
arch/mips/lantiq/irq.c:418:5: error: no previous prototype for 'get_c0_perfcount_int' [-Werror=missing-prototypes]
  418 | int get_c0_perfcount_int(void)
      |     ^~~~~~~~~~~~~~~~~~~~
arch/mips/lantiq/irq.c:424:14: error: no previous prototype for 'get_c0_compare_int' [-Werror=missing-prototypes]
  424 | unsigned int get_c0_compare_int(void)
      |              ^~~~~~~~~~~~~~~~~~

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---
 arch/mips/lantiq/irq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index a112573b6..961c55933 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -16,6 +16,7 @@
 
 #include <asm/bootinfo.h>
 #include <asm/irq_cpu.h>
+#include <asm/time.h>
 
 #include <lantiq_soc.h>
 #include <irq.h>
@@ -335,7 +336,8 @@ static const struct irq_domain_ops irq_domain_ops = {
 	.map = icu_map,
 };
 
-int __init icu_of_init(struct device_node *node, struct device_node *parent)
+static int __init
+icu_of_init(struct device_node *node, struct device_node *parent)
 {
 	struct device_node *eiu_node;
 	struct resource res;
-- 
2.50.0


