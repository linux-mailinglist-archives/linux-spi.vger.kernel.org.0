Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AA232A5E5
	for <lists+linux-spi@lfdr.de>; Tue,  2 Mar 2021 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445785AbhCBN2P (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Mar 2021 08:28:15 -0500
Received: from mail-eopbgr80043.outbound.protection.outlook.com ([40.107.8.43]:11020
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1447162AbhCBMvB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 2 Mar 2021 07:51:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUMRqfgJnW9ORAlGc4Dx+yIzwr/dsU/jqnbxRd+vXzJbr1IczOJ+BArV0kxvf7mG/kBqelk47OVLfUUqijD1bMzgr803DwcZTtQfL/WddkMuBnfU0e6ZJX6s46LDHtbnIMB0rFXueT4opkwIcvOoj04HPGh4lbwtN4uSW6lBepsth+UEyqG1Fy4W//o6UvBRcQO4v+6G0ksEgSF7caEbGc76au4pGg0Qa73WLGYKtG5iUg29bw3yHl92fXMct+z5szbgOU4htLfHLhTW8q28QNIYDQg6KQGzU5YKtSnngyt5ScDlDvgzn47GFOO+teXIIcP6dGeGnMCD63uke3F4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=163D2FiXPjXisRHGxoqydrhLhUsiWcQ+4ye8Vmp7TM8=;
 b=nhy1xPou7Pi4DWBUbyaAHwoyXVJTm4e2ujN66f5EPknIqbTrKM6GIYoFAueYn52mdAfSAwFfZoO+eWfgsVMpCPjl0rHSrKLItCyBOUAd8ey46otQv5SokwGyT6Ek/tO+pqpciSw6azjk+eSKHwlMou1xqmdr+bXaajFJxhBD3/EucR0GPOl18l4p9mgZ5hC3SWCYXGGEqtNQE+Ae/C1Kcjvr3xElFKUJ1gZ6VHfS0Ber8HsC5pzgrgsImSqkDx3N1wf5s4ds3+ElyYrzRBabpHMg45kD7+yOZQ6mIkTDj1CYtY/CwlnuWt2X1DbfFb/eI9QE7UsG7Zem/8vRFZAAFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=163D2FiXPjXisRHGxoqydrhLhUsiWcQ+4ye8Vmp7TM8=;
 b=e71auELQrd1CRzBm7k2iXMPyHKC57CRra4Gd/NoDmVILIoXvDNCPzeR1TdmOtA22rSa+JDx6QiQnV+1SngFsL10qu154/UWZpJwOPMIuKc69KXxpXbapXtnkJfxVMUxW8qhyXEAtOVSoynibuXZtK4QfW6K30hTS5D1RkB58/pM=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com (2603:10a6:4:96::7)
 by DB8PR04MB7180.eurprd04.prod.outlook.com (2603:10a6:10:12c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Tue, 2 Mar
 2021 12:50:12 +0000
Received: from DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8]) by DB6PR0402MB2758.eurprd04.prod.outlook.com
 ([fe80::c99c:dbc3:ed75:e6e8%5]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 12:50:12 +0000
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 2/4] dt-bindings: spi: spi-nxp-fspi: Add imx8dxl support
Date:   Tue,  2 Mar 2021 18:19:34 +0530
Message-Id: <20210302124936.1972546-3-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
References: <20210302124936.1972546-1-kuldeep.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [14.142.151.118]
X-ClientProxiedBy: MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::28) To DB6PR0402MB2758.eurprd04.prod.outlook.com
 (2603:10a6:4:96::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lsv03378.swis.in-blr01.nxp.com (14.142.151.118) by MA1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 12:50:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5907a319-adb5-47d9-423e-08d8dd79b835
X-MS-TrafficTypeDiagnostic: DB8PR04MB7180:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7180DFA3ADE8151B5F21AA5AE0999@DB8PR04MB7180.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rZ3SLPe91CX8jYFjiiIPpetyb40YtA1byLfNp5+RgRvba0dAxp/xE6pkqjcd4QFP/J95lrWSTwx01f7mgkMUtX6Xbr9vcFuKiaNZ1a15MqMZyN5DWrQFXe1rD/tbeRguV951GRGovUfwEBPq9dke/2ieO1SDIPPIFudvk1xSkA/yZWkX3wLN8HaPhDYcEJFrPKAUqNdVbfGE/IVIry52yBvlazH8j6MRYvkYEThWMiXWXRFJof4yGumfJWZOe3YjwlSDbN4McMfDMwCM22C6zZWxXsAQ7ZU8tA1pcovNXP6IZH6mxr8NkkiXy9Ji33zTv3DP51/qBdzjRxWSWo8aJHLL6MSJfOD1Wep1d/2CnE/sHTRc8i7keLnefpYf8Pl/TSbo+86qkC55QktViaHlTJWcDj4SItqnBHrL9QExYCfqzKcBZ6lxQ/nMZaLNS2ZNdOtjInGy9HTqZeIAqohB4/IUwG2HonQMGEbap5gxLaQnjUcdLrBL19ACMY57wZrUbruB4HLizwP7sfswa/9coTZI6aOXGSrDulKCGQw2+u7J5dYEDfbFP+MTC39sMxKioZk5MhU2zgbgFiOa3mOatWZByPX2/3Pnt7aQRRwCFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2758.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(366004)(39850400004)(136003)(52116002)(7696005)(8676002)(8936002)(26005)(54906003)(66946007)(66476007)(316002)(66556008)(186003)(16526019)(478600001)(6486002)(5660300002)(4326008)(6666004)(1006002)(44832011)(55236004)(2906002)(86362001)(1076003)(2616005)(956004)(4744005)(36756003)(110426009)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Jjwb4/ctXgDiyjBE7XLH0NGlM0TRiVlJF29VY9+UYHuUTA7hlhj6N1hLZmaa?=
 =?us-ascii?Q?GGSsYyOPgM6JeE1sPD2JhHguNWIgWA/bzGS7vJ+LZA5RjnWDhQLo3WvrbbWv?=
 =?us-ascii?Q?JSs/hNiqG5/XZDDeb+SOIMtx62XB05olTYgcbyqGQYycIJMboejKOTzh1s/4?=
 =?us-ascii?Q?L6bouFIQlR4RGGP9WS8kBMuacKUyumORBGgejNKT83KOAqjOMxKt4V6Vc3nU?=
 =?us-ascii?Q?7M3ziUs9a20V3vKSoC9SlhQGNzIiNxHTdzcm8EycdocCxTxERSM1Xaqaaf3z?=
 =?us-ascii?Q?KgFRkCaFWDnIsRa6rORAdTnKBQdBrakpJG5OsuZUdT/DtLXN2+pwsNGvC9Qy?=
 =?us-ascii?Q?OBVnDGXyyW3SLdUdHtEsacg7SkCn/WkciP+h8CP3mFiOpR8OwsqBK+fMsWpw?=
 =?us-ascii?Q?zI8g7iFoL8JqLGPteUdVf5FoR9X7kyRzyJPv59K3wU1lm2+ycs3sEWA67i4s?=
 =?us-ascii?Q?arFWOaiJjlLiHpHG+ARjPjzgah7gjUVKvh/KPMzeh7RqCt03iezYh2JbEI5Q?=
 =?us-ascii?Q?L3vBhctu6T0mZhQ4rXSQfVNVJGK5pb4avvN18mjLzx6x5QWtgKEEgRWOfNqx?=
 =?us-ascii?Q?eNNGdrslvvHfEytGqGXKb6NK3eqYNiBRUPENNCeQdAvEMNgaySt9fUu5IqGC?=
 =?us-ascii?Q?jhptRd5sq2P19TQJ3/iPyh6IVrouPbpZ5eQC6V7a7b6lzSjzwAJW198JeWA1?=
 =?us-ascii?Q?H2xx60UgSlLk5pKuF57Q2gWhCWSz3SY9qjfynaAeD+3M6v+qweKKG4wk4Be9?=
 =?us-ascii?Q?M8y3RZuXoNmhLJFdvXeuORIrf0bUax/QDWJt5Bi+tskgmB3NgOC8qzCZqzcn?=
 =?us-ascii?Q?j4zrluDYjWWDQQdBegGdZJ4B6SOjDu7DkcIZfOWKQEEY/27DMXY823aVyGvn?=
 =?us-ascii?Q?qK8AWXtsN36T+FGzXzcF1WQiIr9u4gf3TQ6bqin9Vrm2H7bqiLbxZRtWS88+?=
 =?us-ascii?Q?gge8600vju2KBBDtYMoy6NN+zFs1ql7618wU5iMX1t/bnmJlBDg/B/h8GEC+?=
 =?us-ascii?Q?vykJ/vZID94ktQjDJCNWlPdR0jU7gi80jZm8+Rbs838kZvcM+NK4w9bRJEzC?=
 =?us-ascii?Q?Aj5uJvet27FsjLpp1diZzRzOPXmKNqHI+hj3c770GURDgz7a3sTXALrVwkTk?=
 =?us-ascii?Q?3BjVFjTpfxYvMlYMgNNRu5r44yAEF0au+t/CVlfOs2V3zWnjWlqk8RNGie1h?=
 =?us-ascii?Q?OA4RkaV4vXcA0b+XBCij7cGryViVXWRi8470CO3yrsFI1f8txFmSeyHBUVXI?=
 =?us-ascii?Q?8g0mWIUCO8t+Lfso8xodpByLVJbJIeyd+Up+CFwhAdAhIa3o/AoHguQwqBhw?=
 =?us-ascii?Q?c3wLI50zHsBCkiSLKY4Z29Gn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5907a319-adb5-47d9-423e-08d8dd79b835
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2758.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 12:50:12.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: myQpXh8daprG+3eFyc+p1dW5Xy3xc0+SrRwM7i+ixwwaVLVK0tM+dUMGpLMOWyPFCH5gCd3rFWYDEns5FD25tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support for nxp,imx8dxl-fspi, do the bindings document.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
v2:
New patch.

 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
index 7ac60d9fe357..df178d1b62e6 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -4,6 +4,7 @@ Required properties:
   - compatible : Should be "nxp,lx2160a-fspi"
 			    "nxp,imx8qxp-fspi"
 			    "nxp,imx8mm-fspi"
+			    "nxp,imx8dxl-fspi"
 
   - reg :        First contains the register location and length,
                  Second contains the memory mapping address and length
-- 
2.25.1

