Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479131DB373
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgETMe2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:34:28 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:58020
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727066AbgETMeY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:34:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZzzO1zCFrWG/mycdShn7AGvqOKEKc+L4qkIEJr8Vc5APDqWTe25qb9gTGLnGo29/UT0FxBFTwC0C4oLqQkFxR0AJhQ3MJirm/iYRZtRQeG/yNrPEXduy5HA6LpJrNBlJCcBHQnlH5n2SwiD9xiOz8xTpXW3i7skfPYwJ9AIQ2GfhFuAuuQH7iiwPOa3lTHBmLjivf9HPpZrkfnLwFnWDt46UsDS26qIKRLwDJ4X/wL6msZw+LMNmonVQjdkyXrBBM0IBSR10YjXFO+3DhYOSqUEHc0zyzOetB7ar/doH1JPwga/2ywioD+zZdmuFwMBMck1HR7HXax8V1wO0rzgqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR1u5QVWcsTcn8Rv9kigsA1HCSXIoglRvxRKA0j3gMQ=;
 b=H12z3EtS5ip/HuZOLOXIFkRnJ0fQo/IcnHqEmYGk02XQ0Gk5XaLcKkFWGtg+Z2t4DVsizg4iRAH93d3Jokd+PLRjAcL0TGzpRfFYVJFGLKM/15LAaTL8iIlaF6uFSZaGVxHvy+dq9rEnmSdGyZnXPGWWKXaThhOgCHvdDsI6nDIW8LrNwu7B2H4mMlPE6yUl/5JgB1AoftBhgDHt2H/XkqQ3XubDRxgpKBd1waBsD3jzeEZRw1T8e6DE0uTg5cErBbeRusQJWJeZf9HYZW0k+OuKXCC4ghHh/fH8X/ZDQxvNH0DS4fdOnHTtah9mBh5Bm/gQ1J3ZrIhx5t5Gfo1ZKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR1u5QVWcsTcn8Rv9kigsA1HCSXIoglRvxRKA0j3gMQ=;
 b=q2YqBeGbaY+xqOOit0F8W8tsoHsvBXm2SSzKiRVmHvOgt0zpuhkxocis1rTN5QrHK+joeQpAt0ODH6WfuSpMX/PBoeqtrQWTy+QlcdJHcuWzVtqHqhTh+qO9QV/gszutw5+AI3ZFIkzSgPd/3KRL3P/UT5ZGtmb4naFJSAY2BU4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 12:34:18 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:34:18 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 04/13] dmaengine: imx-sdma: remove duplicated sdma_load_context
Date:   Thu, 21 May 2020 04:34:16 +0800
Message-Id: <1590006865-20900-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:34:13 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d4ee44ff-a822-4e9b-1a33-08d7fcba1d0e
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB427947F278CD48A9E207733D89B60@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/luG21fZoNddnzmNAwXM9EV1KhUyiy54SrpU+CW0Zglh5VhAzSDvOzixxvgyjBKOKvKAh7/l9hy4sL2UBaH6ZOBMoDI+lMfi4aeAtYl/du1ezTHIEm/BCVnb31rVU17wnJtJba+vbIymv7IjWa8osMkqHXndFT32lI3gP7AL4WgAD3zgYkMkSlFZUn0eWKrkJsEsYG+m5gQ9LT81NfJOMLTbfzocpIsq79Hd2Gg4MdJV9XVNFJD2kqWvaaWfE4jk+aH/onItjqXvnksZZQkzPJ9Rb+Hcut78BUGxYSR6WeRc1VbQwQk9dwKDH6v9CXZUS2nCEFVevjs6KoDmhb4JKwpNu5StMIA5sfu3p3E3xy9v89+EJcJhCVq70el9bqYnndmVdlrx1hr8o67TQPa13+MHiE7B9leiccEa61HDvElZjtqijzWIKqPE5hNRWT11hM2qCClQaovwmSlbi3eLl3HVU5S1udAwjL1PNc/dHY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6512007)(36756003)(8676002)(52116002)(66946007)(66556008)(7416002)(8936002)(66476007)(86362001)(4744005)(5660300002)(186003)(478600001)(316002)(26005)(6506007)(6486002)(956004)(2616005)(4326008)(2906002)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PzYbJR1FexsoQN89bTub/jf02EEWEDw9Y/S6M1cAIAbzkq9b2SbpBkI2l4LHi8Lc7xcBZxofWEhFwYhQ2gilJqFmRnolk8C8ONR+c4YoJThlDqtBiMFbwpKcLQcluAOnD4wegVBfFcjgHUQibwcw4EObAdURIGb/kjkj42mzSaNPDejq9MuaXaqfSTKMTvigKevjlXU9u8I9B0on+CejWCGvqQrRWf4LJbiv1yAFN+MDwk0YFpxWP9CbuOBdC/JVVPGCWZHG41Rzt7a2+uSBkUKaRLTenrI8jLlRh5MJL9K2M38+2WkRL92xgZfVQyWbXCxhci188z2B4k540u9FE9U67polhCgAZKnWLQ509pXSW8dbmlhZPwksT4yQckMyCXkAUCmG+/ab8ooiPEDZy8vgDUg8kVDebj8FkyOP+MwD41NguqZoEnXX2bQa6folZJIsevtBku4W98MZnT718rEWrr9JbZVRQTbQ8wy88J4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ee44ff-a822-4e9b-1a33-08d7fcba1d0e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:34:18.2092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BrwzB5WYk9wfa9pfaOACwbUxIWxUrzzQ9YsgMfaRrqddxBGyRH2WpyWubqB+37Kfsh4V15DStMzG8emYzpALA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Since sdma_transfer_init() will do sdma_load_context before any
sdma transfer, no need once more in sdma_config_channel().

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index b1f61eb..4440ddb 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1137,7 +1137,6 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
 static int sdma_config_channel(struct dma_chan *chan)
 {
 	struct sdma_channel *sdmac = to_sdma_chan(chan);
-	int ret;
 
 	sdma_disable_channel(chan);
 
@@ -1177,9 +1176,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 		sdmac->watermark_level = 0; /* FIXME: M3_BASE_ADDRESS */
 	}
 
-	ret = sdma_load_context(sdmac);
-
-	return ret;
+	return 0;
 }
 
 static int sdma_set_channel_priority(struct sdma_channel *sdmac,
-- 
2.7.4

