Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5100D1DB39C
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgETMet (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:34:49 -0400
Received: from mail-eopbgr50086.outbound.protection.outlook.com ([40.107.5.86]:29557
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727839AbgETMes (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:34:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XScinctFtz38+FEgbVabZU3Vb2cBsM5iyZ8vH/pMlkqMotGpjuw0eYjddgYHKfEP/LZ935KC5NYCrVZVRG1f88eZsHSsyiJtEtldOBl9XsWevoJ7UkYjHkdeTc4aGnyLRGkV1sT827XtvjB5d9VQo/EbogicBsp10WyGeEIPCNd4IemJcEv9waDYclyGL7Md44QeoMcXPWay+NLk4oiiWv3aiLuuJsQaB9Pr8gmeRltZPpezPR6NVulu900JDu8DmyzjvJZ5Z5ajemP2ir0yo7fkiJzoMpyNlfbUGUIzJYLJkNMIX/2CHgJnbIkqAY1G+A2vzd+eqG2RhWFDOjLZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=NzTE9F8jSZDd3P2jPDQ2NZnyXLudYeQXfTBNt4bDdZgpBwyK87h3gCABfSh5plXcwAkGf7TAVmqpZSR+/6Un8WeBq30Zm5McYiNp/egDcyx3IQSgzVALAaLqSsS/WfsScJ72aVU/OvT/nn/Mdq5bWfEfR572dSwDh63nRc6pfEYg/4rpTzO0P9MAPrKIpr4NkeFvd21mWfYPqaQclqYl6NrhJQXHMhZ8lIcM+wL+Hoqyq9ByCBU//AZ8x11QxpCEtF6tAbh7ohwiJpythsyWJVMmEj8ivdV/oH1vrq+0qt0YteuEUdcOvRBnYyP6P5xxkUudaZcXPYRUqpn1L77R7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jxJdGqHBF995O2koMhPVubVtg1S3gV8z8tbdE75gTs=;
 b=qorapWkzQmm/By3XfuJNhtD55WzVb7gJYI+fsLsxffHYe20dzLJvRUTaAYkmgyQjZxBdv/COIKROtmPoCcKAl45rDu+tOJ1/oWjSHS4psNRnojcEFhpxsi6A6w1FF2pOGxXvGEjv6HD5Ki/o2Ex2aa3Akiog5IrGh+Q8Q7gZzX4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB5480.eurprd04.prod.outlook.com (2603:10a6:20b:96::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Wed, 20 May
 2020 12:34:45 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:34:45 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 09/13] spi: imx: add new i.mx6ul compatible name in binding doc
Date:   Thu, 21 May 2020 04:34:21 +0800
Message-Id: <1590006865-20900-10-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:34:40 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 59e10294-6808-46ab-56c2-08d7fcba2d23
X-MS-TrafficTypeDiagnostic: AM6PR04MB5480:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5480066EE203E6947CCAEECD89B60@AM6PR04MB5480.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: To0zD2gfFwS6RNgmbrnqbjmmzwqs7hqaGrAx5vS5I1zlPqimmKygQJZIg8UU0vEbqBz0V0gjO48o4lbiZzXk0wA3g3MF6bdDSB92RvXSISSmZDpRWN6tvAVha9czAVAdfPcvqrwjdZnzo3PENA8iADzy3eNAfmrIJRpd8e14XeTjNNkGCk9GEyKH+KeIdu1jPHZvIeYTfv+Pij7cOSyBGp10MT9V1r5cT2rukyq410jwB9QCEl8HzJqzoUYXzKU8nTUaXSe2OyuILxa8Cw7djTNp3qneJXZLzpgi95ghZbMi/wF4yNbliNxpG6RW/rRRGEmCdfjQBKjHzP5jPuChbiqRv0j1Vy4JiYy5gtH528jfNwq9gp+zhGXnso09lIJH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(66946007)(7416002)(316002)(4326008)(36756003)(8936002)(5660300002)(2906002)(6666004)(52116002)(478600001)(6512007)(6486002)(2616005)(956004)(6506007)(66476007)(26005)(86362001)(186003)(16526019)(66556008)(8676002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +qptyCvjJ6WYkyWnk/mFVwnawEOvqp82uheI/z5mEHt4FKh+o2B85edJNpRaiw2gHQYQQeOfmdKEO2gS7ka8HAovai/Rc1ulJW/Zzohtvi/1MXY0XQG03dNhYOvaMs9geUg2sW7kyTSXvqYMlpY2wCQfcXBgmyXK7mJ6j5imoH3wNPx+Yn//rnomnpdInO9OH62xggo0jw4FBfQe7gtTKhQrb+tdCuOHQ69tvblAcs9RFsovgikWRPUiza5PLIeGWM+Jm9RzWbYAfOsIL4hc4Z3Y3RIP4/X3iaNOdsS21/Ih9zoDCIQftncpXDUu+XyaSbye2u/hMF4SB/2YrYeEFxbraNLh3bx3hBujcdFE1i9kz+zoFrbORGmCWKIMpn9dhcux7xo4EnHwwrCYHOmcfeR9Xb5Azzz7RepsesEsDCGSRwCtVZUD56B1JxTYYzqSAKEHxj8kVFvnyphSUctwVnGDHvo++hXeaDOrtVzw3Rg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e10294-6808-46ab-56c2-08d7fcba2d23
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:34:45.2209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cfa98hFxEx9O1oZDtIA1x0LrkLmmNW9JNt/Qawz5mBXw5KSg18/JIjh1BM3oF23gvMBRVyNuvlRtLYZaCsc1lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5480
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

ERR009165 fixed from i.mx6ul, add its compatible name in binding doc.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
index 33bc58f..0a529ba 100644
--- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
@@ -10,6 +10,7 @@ Required properties:
   - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
   - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
   - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
+  - "fsl,imx6ul-ecspi" for SPI compatible with the one integrated on i.MX6UL and later Soc
   - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
   - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
   - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
-- 
2.7.4

