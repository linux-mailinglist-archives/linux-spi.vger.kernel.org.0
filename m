Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA94362219
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 16:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhDPOWp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 10:22:45 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:56161
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229706AbhDPOWp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 10:22:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ES1ZsE6seP4EU6NVB7vfgYqc2X/nsmdaTHkB9w0SnexErZazDOqYGyV9CRkVXlQJrDnwzlNgV/3djbDxs2wkD9ZhShaJI9KnenTOFg159hXYpQmhE8HvSrOnMVkpgWdUrMIQvpKQRpIVf0/rZQLFb3uAc74R9HeuT/V3IHFr+cDu/yT8k0DuMA9MGFPogoqa4X/PwkxpZV7pSqQVd+Ni+qe/PpEhXzxAEr9bAB88LYyhHFnOLF9qD18u/ugKlXK33R1xOriHqpDD0y8G7DPOyYD7lHTvUkDHB7KlbOJ56mjci92+XfHgBm4yYb7dxwoboqhJGVH4bMMGckHP4vN1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgWIQ7KBwmWdLpKJK+SiCfcEfz57bK96ejFlWArKmBc=;
 b=SPcvLgnaKuhOrpnRFoKPdxMyoXKLUv+4CAd8wrGlKZNO+pbapb88FrQ+vo9JzBx9xH0qHkq3Bc/oZ2rrjGchR+HZCz0TtbVxZwtuNzm0op/lpMAeOihRB+tTaZ+zujxZ5DbnpLpJkglFNgk63QiijcVGDar2u60ecF6wFHvaZk/Y/wGJ+NBD/twUw0mxbG3H0XOD7txLHccXKOit4XfPFkML3DRTjf60gtZqvkh9AmAaEEd6jX6zCfbquu2CYib/jIJ8SIgyGuAIE+FXNTRwqjqtqVw8G9fDqraieZJb6PAVebv8UZ2+hUk4prz90dgB/z3cVlk0Jd17EmCgB0gjcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TgWIQ7KBwmWdLpKJK+SiCfcEfz57bK96ejFlWArKmBc=;
 b=XCK6zfCegi0YALFmKEOgFNBirR4UwD278dczCeILChG5m5FrvmetdCEHPFNSvi8XZZc04UrCXYtsvsfBCVXjJB4NJ8SqY+SvvuwnO9JrOoMZ5F0YX8J5gjzMWu/0vZVAY7UQ7eGWMVg1+hkkOEk3kwx93TkQYP54++mtQx6Sd94=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2264.namprd11.prod.outlook.com (2603:10b6:910:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 14:22:12 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 14:22:12 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH 0/5] spi: spi-zynqmp-gqspi: fix spi issues
Date:   Fri, 16 Apr 2021 22:20:42 +0800
Message-Id: <20210416142047.6349-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:22:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6fae3a9e-5017-4a7f-80da-08d900e306ba
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB226461E2858CEBE0A76809A9F04C9@CY4PR1101MB2264.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6l5rZbIPqZl25X+LdBO9u2hI6Ex4goci8glqHTH0VOhRYCrCYcG1jU/W9Z+4gJeVAvFqFCN+bl85edxc5biTxPU1pvi9DjI8+UrVQvcAnzK3ZFgrfle2a9fZRz1rm5Nt4KX+0JoX/LRgPL4+8enzIwQAG80RHqQ0rs2k9ErSQQ20CEWG1UNdaYnGPDIizREUvA+c4Q+gETTqab2UMHgOSy6O8GYMP4WIqycfAIc5SuGXK85ccEgDO6E+QDYrv7MXRQDSAZeKrk8A2Q7l6ve2SLKBAeyT//7Xi0skRl5HOrfOPq5I4mgRqhigMgjUAsWIgCiLNzGzoK2vQbit5WbnPjXUVfFzZ8lJBwdwKbXn13ykzhAk/Y2Q7RAHHba172QUNEqlGz9HVShH5zOw7H/5SoG2TWX4yPxp+Uw7CEojESREtwsPhUoGfXocgD03k+YPCU7ghcM64HxMxheokcMoaEW7L7zTfQLU1YZZNHRU1dSTi97sPSoOcZT7kf2NUork4ASefyu9pW4i8Vw4ffn6pDi5FIoBMRwaz5TEbzgp/AiOwlTOeWVWXKH4nZOsXUi6X3C2npH3NcGmXrM6qW7q1vNzgn9Mt4KpeihRweGEiKz0mH84AJossD9P1yhKUcndMFGdETEWrcTJTq4vm4uyW06C68esid67lh+vH1OAZOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(86362001)(186003)(2906002)(38350700002)(38100700002)(316002)(6506007)(9686003)(6486002)(83380400001)(66946007)(8676002)(66556008)(66476007)(478600001)(4744005)(16526019)(5660300002)(4326008)(26005)(6512007)(1076003)(52116002)(110136005)(956004)(6666004)(8936002)(107886003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ixpzydprRklrprGcKX6i1VikmZoXPcEprxdUZgmvIpScN0Fd0bdyG83GuatD?=
 =?us-ascii?Q?bHFCoJHSYCBwDJnjIIOCjPH7DHjSuhM3p2Wepy14aAUZ58sMavw220jhGxjD?=
 =?us-ascii?Q?Rb4BjpqXZi2ckWCmwe0GurwsOX8zdA1U+fL50yIhvYzt+0udyqs+3CVkrrMm?=
 =?us-ascii?Q?QrXAVYiGQ7cXCKHJaosymynqQiI7NypCu+WyWgj5oXzC7NYZyp9JaNMpPqGz?=
 =?us-ascii?Q?nJh2q9y9mDa3kC9wkx+rW0vT4JR8O2+WoYfsmeftWjRvAB9Gk4jGIRVIQvyh?=
 =?us-ascii?Q?rKuQ4b6fPRILYEsC0SjB2lfHpqlekvPFiyAx+/ku9Ebzzm2I6D9DdtXLyvmr?=
 =?us-ascii?Q?2Pc7YGGjSSdAyHxYK9ZI21wmNflmazHG4/CQBpygzXge1bU3UJuc96grGbg1?=
 =?us-ascii?Q?sv8pv5QJiiJjPmUfgeEn6Bh+QS9XrNWaYutdjoF2/CLzuymNPU8ezP6PrT8V?=
 =?us-ascii?Q?+sXkJKicfH2jvktbFRWHPOf9NPDuJcvqAkqSlTlUZKTBIpRUUS1G9neZTj4c?=
 =?us-ascii?Q?4qnrUCEKfxGe0n0dyJYEVdhaJ1n0/7qh4vTJmKMw0N+Q5hu1b+R8oLrR9A9S?=
 =?us-ascii?Q?x7YbBOSpZUQENAkJ9SI681a6OWFlIbuEBxdiyN8KQwJQWuZPaGgk3QoRoN22?=
 =?us-ascii?Q?OYJFjFbI423vNnrzoiWl4DTT4qMDPq8GxtaIhTtwSgGPHQ3SDqaupyg9Liu2?=
 =?us-ascii?Q?xUqLdoF2L3v1IR6wPb8OAN/qA/4gX9AwrpdAiMig2vvjBeQbVY5OEALq0R/7?=
 =?us-ascii?Q?z7hR6a2xD9W5kb9egLZH6xE+re1Y/0HnJcgjumoZhntWT+d3RQQYfYwfx7Rk?=
 =?us-ascii?Q?uBi/+aYE7dPjVmeYmfT+F0WkCEIYu0zi7uVllpkn+YrfFn2EfulrHvlyL0hs?=
 =?us-ascii?Q?OZJ5fWvWk6mbktqh2QAajapIBENCdLrpHWk+chgM+V2VmJ63imQ8SWvvMdRK?=
 =?us-ascii?Q?8XHwQ0w94LWpnUoBH3ntV+USt8Cc1mqo7Tty8XnCMt935KDajqzVVFrbwN54?=
 =?us-ascii?Q?EjrkrX1zRivpj8lKyDQgvF1Tp5Mtcj9HxyWSwV4MbWzSZYEMC6d96YHMLg93?=
 =?us-ascii?Q?RP2uMFq4UwlRbPhu2JSTjNnuzqZcR1No/lOEWvGVgYkmD7046/sER0AEW+pB?=
 =?us-ascii?Q?+ETVJz1wdeoIZKBy62A0Yhu3sqr1sYoHeTxGcKpxgKgEXgI0nQQYR0Nc0x+i?=
 =?us-ascii?Q?+ZRHbkxOCxsSt0IZI3w8b7zeICi63ul5jWE8jNXTTew9aPWz7pELjtlSTi7c?=
 =?us-ascii?Q?LYwmIikOssn+mUBSoGIfNS1jASYLwEKZCMY9RSekmYxjqjOz5E+YKFJRvDGt?=
 =?us-ascii?Q?fM9UQgeEImky4leUZRksS1gs?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fae3a9e-5017-4a7f-80da-08d900e306ba
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:22:12.3586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AXBoGhJzHO4lLxUP1+wXbukP6TEcPk2GKXuNHoKwG9ka09kyzfrBOGZAk6m9i+E+nC3IZMc65yUmHRvtFw2K0BSxxa5xhq4EZeFLcHEZkcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2264
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

Hi all,

V2:
Remove all "Fixes:" tags since they base on some patches are not
with "Fixes:".

V1:
This series fix some issues that occurs in spi-zynqmp-gqspi.c.

Thanks,
Quanyang

Amit Kumar Mahapatra (1):
  spi: spi-zynqmp-gqspi: Resolved slab-out-of-bounds bug

Quanyang Wang (4):
  spi: spi-zynqmp-gqspi: fix clk_enable/disable imbalance issue
  spi: spi-zynqmp-gqspi: fix hang issue when suspend/resume
  spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op
  spi: spi-zynqmp-gqspi: return -ENOMEM if dma_map_single fails

 drivers/spi/spi-zynqmp-gqspi.c | 115 +++++++++++++++------------------
 1 file changed, 51 insertions(+), 64 deletions(-)

-- 
2.25.1

