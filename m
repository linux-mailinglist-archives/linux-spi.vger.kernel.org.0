Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359741DB396
	for <lists+linux-spi@lfdr.de>; Wed, 20 May 2020 14:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgETMfJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 May 2020 08:35:09 -0400
Received: from mail-eopbgr50083.outbound.protection.outlook.com ([40.107.5.83]:10702
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727927AbgETMfH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 20 May 2020 08:35:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMjI2QjNQH55gRgZtVzUp8kUjrw6NQN9Nx5a8led0/6U0aDxWsHNda+o9lZY1zvA/y8t/S/hvvL4WjTndtGLRzipSNZy09KfjeuYjxH4kA+3t1lpPa7wyxIKc8F96J0uiPbP4r3OXMMnflhD3Gr51c5+OxE8KJDR1rcoCBt6jQQjrQhT8tmZIpl2v7RtwP7Vula1GuMAygcdjMl0FDeS8mWRb+sKS/tu5uKnVpYbvtkL4+5Gjzxu2YItw1vWfMzL6AxfK262TVS/8Slf+bMdTuLZxjfxjsQyJYj0KdzFbYHoFUzUWNyWEzZW3xumlf9NCvyBrKmjZhp9huE789d7gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFbDanBWSu2S5nbk4C4ogbtxHYjU/2zcsNJWbhy/sHo=;
 b=aiWUiJzihDvXQ5wHUCRb0ydDpRyI2Kvq8nxEjfAuKcO9ZzcgZqUFtFQNl76pEw0FrHe6m91eUtJHjPvQM23Z+MHxAMMonWvBO5k/47jertLtaZil5GiYSsFSoxm8LOkU8pjYLNu1SHIxg0jSHCrLAKR0r2hOGVi/gulPD92qa0hUTqdjnQUQ/OS1xLGX7SEbR1OrIjFcPQEZSF8COIZNaiMEGj9jhHUF+GFiZ+h+sGx5DfCaK3DCZSRtvwYNLr2iN43aVZeMyWX/nef+/JDasaSFEAbb+GyHp31wfCX5+maKuQbm0m4FbIdckXXauAWEZ7IJi1fKbYbN/C2xHblChg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFbDanBWSu2S5nbk4C4ogbtxHYjU/2zcsNJWbhy/sHo=;
 b=pXluGFxV6wEkV+FM9W7qSdbHEk6BlI34La6ERAVeH6OO7tt4O9YlNKw0sh8psbfNKSJKVqetrDnPrLBdHGI8eSF7/d07tLbD+RnmLxJsMcPbTKpCcpBlVOwFglGXbP32ZNe+wMmDXbWmuOHoaqzTiyN15QWfofzY/CCrv2MBKK4=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com (2603:10a6:20b:f4::33)
 by AM6PR04MB4279.eurprd04.prod.outlook.com (2603:10a6:209:4a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 12:35:01 +0000
Received: from AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa]) by AM6PR04MB6630.eurprd04.prod.outlook.com
 ([fe80::bdbc:dab3:70f7:d5fa%6]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 12:35:01 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, vkoul@kernel.org, will.deacon@arm.com,
        shawnguo@kernel.org, festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: [PATCH v8 12/13] dmaengine: imx-sdma: fix ecspi1 rx dma not work on i.mx8mm
Date:   Thu, 21 May 2020 04:34:24 +0800
Message-Id: <1590006865-20900-13-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
References: <1590006865-20900-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0103.apcprd03.prod.outlook.com
 (2603:1096:4:7c::31) To AM6PR04MB6630.eurprd04.prod.outlook.com
 (2603:10a6:20b:f4::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR03CA0103.apcprd03.prod.outlook.com (2603:1096:4:7c::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3021.12 via Frontend Transport; Wed, 20 May 2020 12:34:56 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc5ae868-46c5-4990-4e96-08d7fcba3700
X-MS-TrafficTypeDiagnostic: AM6PR04MB4279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB42799A3EEE0A259DB88F5C8589B60@AM6PR04MB4279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 04097B7F7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /UTVG5D4P9odFXcR15kdfbC1QJJmpb8NPewKryEOxMjdYNBqCQSW5WkrwkfpTymTlM6EcNfElsTnHX2luz7Mar9RRa1/F6540qNNAw+oBmnw9z/8dQ+FzciWyzclxBiK11EBKcLWgBTtbw9qvL7zDMIllnipz5SjfSne0ywDTuTm1hpbOH+Pqm83Cwdyo2hf/8lrthzyXkSRnjeiQz2Haf0wDRvLuAGdKsu/WlzTb7nHXNS2GPCCm/e58m32zIbhtUZADD6iY3ASCKyc7yLpy/xdsHZJLlRkSMh6nTbDi53LwbOBQadj1+ikh8NX8Z4qQrLOO36aSRV1fVpk57Ne5jjXV/BeyAJ2zvfymRtFPfuNufXm8nw+oqWdKj9eiN98fIa8V0SAftCXQDhVUnGf2dT8cAw621wWCkM7RAqehwYyuW+9A1GWLnnoLrdD5/87Sm2/FGPpcSXIKsOHXdpJTpH9IAiHwWe+dK7KVFcgnwQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6512007)(36756003)(8676002)(6666004)(52116002)(66946007)(66556008)(7416002)(8936002)(66476007)(86362001)(5660300002)(186003)(478600001)(316002)(26005)(6506007)(6486002)(956004)(2616005)(4326008)(2906002)(16526019)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uB9ZsZdrMNO9NFDMyrxCLf7ra1C7B+wn4B4KVkt6hK2lb19l9t7oGEOxP3Jtx3YxIl/ZkhqjCJRlERNtym98G1IepVinrz/uivdrW6JHmLiMzM6EZTCa02t0ItBS3/9e/5LNmASxSFv7JVfuQEVfaYzkyzxqxcVmuwU5vEnC0T9RfEBOAJnti6dR8j6ICY9+UOrKEM5RtIVznLNLePiv9TUpRHeXgNbuK6Ob4ek6zB/ya0FlQoe93Gz/2k1Bsjs1BMgYY4N2oq5RHB3ii5NcpTfKvUb3EGBdV34fvNLahIBMYrsE0hWPBZQ2oQukMleBUwooggiQujwu20CYkItdd5No+HFPqUqBStkOeSgM42zye6LnOUAUKvCBtuapC46esD0b5uQs9JGudVLCBwf61xqtRi96SpRhpOJxjibeH/gmFROYrQ1QmrONaMXQ5rC85i1SBm5LsHebIukxGs726MpsU7vuMP8HaXebu4PxyZg=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc5ae868-46c5-4990-4e96-08d7fcba3700
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2020 12:35:01.5266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FVgGz7vdF/1LR7an+vgt3HP8lTvy7X8T304IYB0LKf6revEb3qjryGAnEi1XtCPaH1E8c7XY/arZQJXYbIE/xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4279
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Because the number of ecspi1 rx event on i.mx8mm is 0, the condition
check ignore such special case without dma channel enabled, which caused
ecspi1 rx works failed. Actually, no need to check event_id0/event_id1
and replace checking 'event_id1' with 'DMA_DEV_TO_DEV', so that configure
event_id1 only in case DEV_TO_DEV.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/imx-sdma.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index be86ae8..320104f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1183,7 +1183,7 @@ static int sdma_config_channel(struct dma_chan *chan)
 	if ((sdmac->peripheral_type != IMX_DMATYPE_MEMORY) &&
 			(sdmac->peripheral_type != IMX_DMATYPE_DSP)) {
 		/* Handle multiple event channels differently */
-		if (sdmac->event_id1) {
+		if (sdmac->direction == DMA_DEV_TO_DEV) {
 			if (sdmac->peripheral_type == IMX_DMATYPE_ASRC_SP ||
 			    sdmac->peripheral_type == IMX_DMATYPE_ASRC)
 				sdma_set_watermarklevel_for_p2p(sdmac);
@@ -1351,9 +1351,9 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
 
 	sdma_channel_synchronize(chan);
 
-	if (sdmac->event_id0 >= 0)
-		sdma_event_disable(sdmac, sdmac->event_id0);
-	if (sdmac->event_id1)
+	sdma_event_disable(sdmac, sdmac->event_id0);
+
+	if (sdmac->direction == DMA_DEV_TO_DEV)
 		sdma_event_disable(sdmac, sdmac->event_id1);
 
 	sdmac->event_id0 = 0;
@@ -1651,13 +1651,11 @@ static int sdma_config(struct dma_chan *chan,
 	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
 
 	/* Set ENBLn earlier to make sure dma request triggered after that */
-	if (sdmac->event_id0 >= 0) {
-		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
-			return -EINVAL;
-		sdma_event_enable(sdmac, sdmac->event_id0);
-	}
+	if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
+		return -EINVAL;
+	sdma_event_enable(sdmac, sdmac->event_id0);
 
-	if (sdmac->event_id1) {
+	if (sdmac->direction == DMA_DEV_TO_DEV) {
 		if (sdmac->event_id1 >= sdmac->sdma->drvdata->num_events)
 			return -EINVAL;
 		sdma_event_enable(sdmac, sdmac->event_id1);
-- 
2.7.4

