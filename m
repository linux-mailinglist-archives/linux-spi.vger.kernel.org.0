Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A8E22E442
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 05:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgG0DOq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jul 2020 23:14:46 -0400
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:43635
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgG0DOp (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 26 Jul 2020 23:14:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eHo53T9Ik+D89SaJjN2pnZk1UgYhtGCsazOlWU6klr4v0WkZ42bptztjAWK6DYLroEvnCU+QzoE2saVsMHilR+fsLufwWOnNwv9V0ctoT/seaY6TGK/Pt+IGVgIVxtnlnr0/V0n28xI14JM9ox8ByXpAD+gl1xc9TaffYp2ajIHEMS9YcFlMQw2uU7JqA0LK+ObKKBZaoEGfcti1LEwx5tWRUVoyIO6fA/lpOAqQ+DjpxAmYKyzVpZSHavrUjJMl7etIzzlVltz6wT94L5Y4KGpGnXRiu5bpZp1f+XLfjckOH6mKOxCMhYRUZpR5+ODU0AuGsTAN+2C61ZlzuPoJ9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIe4ssTzfTwIOIXqvptDE67LkPa6FGL9/GRqd+MUxmg=;
 b=ZZt3rZ19zbVNm5dyMnGtPNZg0eDw4qJHWVCc2FuS7YLyWLBRiT28hVqGyg827zP0p4VDGs1SUOdfYj+19a1o3INjo2zNHV2aFhJNw2OzdPLaHG2P9WzjsRhObL9UAYTmSNnLDnLYt2I2H/0azwW7BQp3WxG9O2ZCFS9rxgiIB1CByNYdQ0JAQ/uacX/tDQfNEbwR8mtdn8tqm4LLXRMA8m5oUwx8Xes+Zp/O1fOOwMnKIvnpV0WN85NQk3np8irVVWU4bqGbtxti4v78SuVHuwzC2LAuQcwvk577PDrB1BE6mH/g07Hz/NtUepgOs9/pu2xFjgMXE/m032oiXBEcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIe4ssTzfTwIOIXqvptDE67LkPa6FGL9/GRqd+MUxmg=;
 b=k/jSNizIg7JY6r7VODJtwLrVT9u081nsFs5kjCOwRMVQZctt7F64J7i9PQJkTwsL8gWzoFtzetWtRzDEhVfUW/OSPowQUhlXketsc+qbUAI67eoySEsq2jAEw+j/z2KoKdaDun6CcGJ2oXisthwFqUnKrjhVNFoNk5sD5UlAQJo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR0402MB3880.eurprd04.prod.outlook.com (2603:10a6:209:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.31; Mon, 27 Jul
 2020 03:14:42 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 03:14:42 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/4] Some bug fix for lpspi
Date:   Mon, 27 Jul 2020 11:14:45 +0800
Message-Id: <20200727031448.31661-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) To
 AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2P153CA0007.APCP153.PROD.OUTLOOK.COM (2603:1096::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.1 via Frontend Transport; Mon, 27 Jul 2020 03:14:40 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c691892a-16ee-4f20-7611-08d831db341c
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3880:
X-Microsoft-Antispam-PRVS: <AM6PR0402MB38809FD6F49A7AB38E8C2DBCF3720@AM6PR0402MB3880.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7TrkXEYRnR6Gg68KcU5EmWE/BHt9tMYX2nsjcU0P2eHQIKb5Mf1PQVFDxrqnwnBkPMHA/2yp1vlJeP+6cE7r/soVkmcoXW+WNz2+6krYky1Puh18gXwL409ynu3yUEdLiw9dlJ27b6J+4u68FOWdOS+0wIulaQBHmRKGfyyYsB00DmZr99fD9r/jVadO1kXNpLlTnBIzSIby1TBix1LoaeGUnmiAx3iWRzW5tFHsmFaL0tzY1ytBddW/Ll24NyIRuH9mUXLpbppYGLhGksOUF/lc2aS+LUdtvmHnKBc+y8V6TbwMvjV3imhhpEjy86RQ9l/u+NQwPiTb1BBPDmnUaCJPJitGslxAbfoQNz8hsZeH5MKu5rkj5sDoMBxXvZL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(66556008)(66946007)(66476007)(5660300002)(956004)(2616005)(6916009)(8676002)(478600001)(6512007)(36756003)(316002)(4326008)(6486002)(4744005)(1076003)(26005)(16526019)(52116002)(6506007)(186003)(83380400001)(86362001)(69590400007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EurasmsOgwTl4xFUlVDyWRqh8uJOe9KIQmj485qDW+chgmpLHUMhsL18g5sod/jPPMS71M2GV7Pk4T7WvAc4ovRuPd79NU1YZ6z5E49jMlfOHpfFqDqjE2b/ZcWlwOn/pDlWJYL1iE9iY3Nafu0znjrLQA9PIZlLbAXDMcJ9jlWf9BmeZnKUY2F6eA7ly01tYxMPwaULdUbaOzlXgviTMU57YTyCiiWLPWxQ7jIHR/FQ+saKwETWtYZOnbMOsSoCL+xQ+b3DZpBE02yXVp0imzuAKl/lWwxDJLwX3o8zSDPLQ50cVNzU3GVl9XTwzMi175pgKd5LXGvo/s03UptLIJjm838/uc1CepJslLg4w9v8pdSjjUZJrq8mJh3Ns5E1n7ZyV0V/Gt1xVpoZ+7I2VrImfoTuyX5JW1QZJQ4t7jfekzxTiBmPhfc057RwfeY+TogeQSPjvYZUWyfXFfSV3j+l0Cwf22egy6qHVWImci0=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c691892a-16ee-4f20-7611-08d831db341c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 03:14:41.9052
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OovDPyOGd4cBuX2hAFYJna9Pu7GtiROKR+4DRomUB2DnwjHdurX2YHLXfx5FYR2MfRahxcoX6iO2oFTono1Ntg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3880
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This patchset mainly fixes some recently discovered problems about CS for
LPSPI module on i.MX8DXLEVK.

Add the dt-bindings description for the new property.

Clark Wang (4):
  spi: lpspi: Fix kernel warning dump when probe fail after calling
    spi_register
  spi: lpspi: remove unused fsl_lpspi->chipselect
  spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK
  dt-bindings: lpspi: New property in document DT bindings for LPSPI

 .../bindings/spi/spi-fsl-lpspi.yaml           |  7 ++++++
 drivers/spi/spi-fsl-lpspi.c                   | 25 +++++++++++--------
 2 files changed, 21 insertions(+), 11 deletions(-)

-- 
2.17.1

