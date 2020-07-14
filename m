Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5BA21EA9C
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgGNHwv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 03:52:51 -0400
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:6064
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgGNHwu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 03:52:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQ3THLXr/iEfKxbxIzUSNTTUbnMnk13pwCVpuvO08nEZ6yVS5wr17pS9JrtkZkCKBbo+Vl8TywxmEVeszCnFKPzYxyNR/i8IbZV4HWN6ErYj8Y82LG9QwGgZPlGXlaM+eHl5lHOfuF/HR+IUwc2VmTI/W0lsGKDFo/BQlpVRgrlyLbGE6p+Kw2BPghwBnhcWWlVd2JprossCIZ1yhIWwNEu9duqYMYi5xT7nvrXh/3m1UDgJlSwOIZwccQmO06f324vXh/jCvDAjc2rvhUkktZLmVm6j0HDNF1FuGOxD6rjuCcS7jEaAq07NWWRQVo/xEghjYxTDwVT9/KYCapD0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PFABFUyuHGED8ObVRDpvfA9foCjM/3PTWXVZgZp5/o=;
 b=D2kMPhwXTfoh1LKku0QRk/mE+GHve7/BZbzea0qQ+BPN/U2UypS6GBZL3Sy1edxsWvfJxQ27NT/Bk393tGZQrRFlQJ9iraJfIu8xg5AU4acoMil4HtjG6QVew7n+MvBE0y/NpWfhQlmhkYF0vjyaplyge1lFQppjx301rqxhemCXwaLNwUbSwfXcls/gPW2LP5Tg5cJ7SZpBAzxXwqlnaVilPZMl2qbuUVx3SQ923j1858kYkKybM8usv+Kao4Ktk+dgQxBkZAlZ0z1S/mMYUv8QaJxVav6fAaywqLFRgbHPvsUolsKQoVq2qZRSB1+923VXlGngTWBcTC7H6F55kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PFABFUyuHGED8ObVRDpvfA9foCjM/3PTWXVZgZp5/o=;
 b=m2rzlWfZaShkIlHn5DKFIlptbmuvzmILPDiYH01U911mFagTiPpTAnpBWRhOkdG8FFLoQiSpHuRM6tJVPmtcexPiVO2UrBc4z2syWvi6EpaVJ22dwrpAH1f1wegd6p5IuoddTEAJRSsbpn+nNnvQpsNOoKuulOvueo/cARRuLMo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 14 Jul
 2020 07:52:47 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 07:52:47 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] spi: lpspi: add NULL check when probe device
Date:   Tue, 14 Jul 2020 15:52:48 +0800
Message-Id: <20200714075251.12777-3-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714075251.12777-1-xiaoning.wang@nxp.com>
References: <20200714075251.12777-1-xiaoning.wang@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:3:1::23) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:3:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 07:52:45 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7c9585c8-6d54-4d61-06d0-08d827cae5fc
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:
X-Microsoft-Antispam-PRVS: <AM5PR04MB31395BBFF10CFA75C1A83BFEF3610@AM5PR04MB3139.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J4i1ikjLABxL7DIu8lDD+2ZJvhGQBGD+U4VmWsJClH4Mp4b1Hb+MSAiIJmUjPl7d4bLvbtl9p2q7b0WfYuNsmDhe9Jv2ydq3ilLtPu9gpRCVKq4mr8DhERRuqaNSOP1QumnlJoDYPtkwLcfLtY/UsJXYuSXo1sYfLIfWtN1lrMI7iIgw/HgafA7oyTUkH2KVmSRgBouiQi3Qx2J6Wk2jrpAEzm6VoHR8PJBMZMgVWKUAtOvda0J20PEdZZJJbKNnx2zIIReNd0KBA35Ij6ISKRNPY/zak4KuXSobFT6mWyMcOpHIECdPhjDYY0+bN0eKhKJSJdi2DkOtRmXmg8I9Opg3OCA6lgfu5tP0N1B2/XO7/AupqVp5uG/DEtSUYDT4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(6506007)(6486002)(6512007)(52116002)(8936002)(2906002)(16526019)(36756003)(26005)(5660300002)(6916009)(86362001)(478600001)(186003)(316002)(66556008)(66476007)(8676002)(4744005)(2616005)(956004)(4326008)(66946007)(1076003)(69590400007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: IX0Sy0L6Cs9LJRfJqUNegi48OUEjuSTRx6KFn95sbTJ9uHtHHXJaucU8pTH9qHGUSCU/hfNzKjgyd8UXlGxC0NpqRtNX+kKVMxxn64BdmCHWnEFQ3oq9c2vHp+LuYYAUZbUglYvFBMukCPH3xZGP0ARE8UsH6Ibqe/tB9MnaiE2CAyxY36Bw4dOgeFBb9Go7Ch7SSpy1wO6g1R2QeZab68HqeZ69/7A9pd6oQ52ayX1PmTXclzSNSa93Sp091c18ZyQdYlV9QBpHppj7aZ6aL2e44R9wS9xvFBcMhA9719FXu6BLOl5hcTTvRWX+WRYYWcrId9fK8Db8unQPpkWZkLvCT2ItIyJSLjecr0stpKRT/5crTNTjwvyt02o2pFoaZELncSkn6MYnWH0x/oN8CW746CsNBqCdiitnxKf29EPidSAG98Tw4L2CX1m4UqXaVRJM7EiK2/21wT7J+3j1mLMzbHOIrJZEGUjjmM8kH3I=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c9585c8-6d54-4d61-06d0-08d827cae5fc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 07:52:47.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QrWjy6cuS0PeSRQFyQL3U+nr7NtIMZEuU9tZxaLijKPA3SWqW8w+xjcx3Hq6YOVjSQPke1sudDbN57o19lSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3139
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add a NULL check for device node and lpspi_platform_info when lpspi
device probe.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index a1555bbc5e5a..ca43d93adf30 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -841,6 +841,11 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	u32 temp;
 	bool is_slave;
 
+	if (!np && !lpspi_platform_info) {
+		dev_err(&pdev->dev, "can't get the platform data\n");
+		return -EINVAL;
+	}
+
 	is_slave = of_property_read_bool((&pdev->dev)->of_node, "spi-slave");
 	if (is_slave)
 		controller = spi_alloc_slave(&pdev->dev,
-- 
2.17.1

