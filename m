Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5358F17EF1F
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 04:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCJDbD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Mar 2020 23:31:03 -0400
Received: from mail-eopbgr80049.outbound.protection.outlook.com ([40.107.8.49]:35091
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726380AbgCJDbC (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Mar 2020 23:31:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRAk2XPT0ocw8OuRmCMOP7sWH+BmPu2RGUYtdfgmpLvNFRzyGV1K9BcTRSua4js3jDfGIg8EnDQ5JoyVqXadQVJpt4QuPxoDNRhl4ZvP7cc7nCY4Av6EBj8juUEt8n6gHZIfG+69VnfhO6+LI4856qXF8A7JVrCmF+ocC/wwo8RqJzgJjLAy4m/RhrgKik4LPyrVtvJkp8562ny4xiMShdp2KKDd2suDuZ1Yy9rhJI4halhuEHKLDBy4DFs/wuw62w6d3wQFZf1sPh2agQ/2wS8X1b6TTn709DukS0gSzpnRlf96T68HTMnEO17AZqiBtJKO5W3KDWB26b09HQcO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWCHSljtftrIp+DHwbCimqckASBry4ZIAy9jLYxm5No=;
 b=Qcc6NT+VM/XVisIKpVBjGpPgRiAqonFal8F4FIch0OO4JW9x8msRZyl9J+L7JO3zpkVu7O8UK+tAv61MHbPdYvOTIrbjBpkUisjCkGsviGO0gtCQDYNDwYbac2nwrg3D5PyXFgb5HOmx+ELb/gfGdc4vvlMdoNzYIPjkdKZjPuNpODL0sbMHEWy7Rfb4kQHHSvvjmMgYQLyhozfrVR21tKjgtRuyHvUAHlBN+425s/ucoalz0Ta7791wyk3KF/MEvR84YoiSuKHYsc1Hi61y9E/H/DBQztgyyEZJ03IKR2oCYaIkh/lMBkGLG5olKjrtgJqJJiR+lvgji6RCM36Nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWCHSljtftrIp+DHwbCimqckASBry4ZIAy9jLYxm5No=;
 b=Fyf6hYf9M0hJ7/vV1FR3iZmbiMJSqDwHVQZLzuGWHjIKO2OlsdF9AiFtFHr90EPiT6EvnK7id/ZBzdfVivuDEvRyhy7ZtmG+z1xeUamFFQ92zqCjbbWrswiNGX0oFYIGCs51F0YN4kxmwNz8JHzMvEcAvq5O5pQfGzft/Ycg0Ms=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (20.179.232.15) by
 VE1PR04MB6621.eurprd04.prod.outlook.com (20.179.234.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Tue, 10 Mar 2020 03:30:58 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::490:6caa:24b:4a31%6]) with mapi id 15.20.2793.013; Tue, 10 Mar 2020
 03:30:58 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     s.hauer@pengutronix.de, vkoul@kernel.org, shawnguo@kernel.org,
        u.kleine-koenig@pengutronix.de, broonie@kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        l.stach@pengutronix.de, martin.fuzzey@flowbird.group
Cc:     kernel@pengutronix.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND v6  04/13] dmaengine: imx-sdma: remove dupilicated sdma_load_context
Date:   Tue, 10 Mar 2020 19:31:53 +0800
Message-Id: <1583839922-22699-5-git-send-email-yibin.gong@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0241.apcprd06.prod.outlook.com
 (2603:1096:4:ac::25) To VE1PR04MB6638.eurprd04.prod.outlook.com
 (2603:10a6:803:119::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from robin-OptiPlex-790.ap.freescale.net (119.31.174.66) by SG2PR06CA0241.apcprd06.prod.outlook.com (2603:1096:4:ac::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2793.15 via Frontend Transport; Tue, 10 Mar 2020 03:30:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.66]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bfceedbf-47dd-45ef-e731-08d7c4a372df
X-MS-TrafficTypeDiagnostic: VE1PR04MB6621:|VE1PR04MB6621:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6621F957AD72D7020735782B89FF0@VE1PR04MB6621.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-Forefront-PRVS: 033857D0BD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(199004)(189003)(4326008)(8936002)(8676002)(81156014)(81166006)(4744005)(2906002)(5660300002)(2616005)(7416002)(36756003)(66556008)(66946007)(6506007)(52116002)(316002)(956004)(26005)(478600001)(16526019)(186003)(66476007)(86362001)(6486002)(6512007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6621;H:VE1PR04MB6638.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qeGSVKy5kRQ7qfLf4JrBEEm628NPYWmRcL7Lbzxlqd6xtbx+nXeMSMX3+mpt/gCSi3+Q0FL7vHB0UX5y/Prian1DtRMlDCbf3exofkIsgWlUkaztK80QObRpbf0PagpQmvvf1JZiX3zcWPLhiUbKwK82Pny8NgFLtSRl7b/6YAL3jzuS+wTGRxjwxX1j9kI3LhQJs4EMRS4Y5oxl9Yx8gtZpe3XxtUOSq1Qohhc/WJ4tBing2koUgVhkZ+hvZLsu21rpUvw65piqeBncY7I7fbL3veHZnY7uBpWxTMPevq+OBh9dhqwkWXsQLkJVfmYXWCA65hOyRL6WGJ0bN6ZI2KneCJTWJV1vYz/Yj8df4EdDEPZr9lf4hSHhglEHzBy4On6spL0ulB98swMtxgTllOUe4r4qKF6lyXrxEjPYpAnUYPDpuLxXYQiihUjSM9tZlG4yjW5oqIavV3NbAyXAvgjjkP2afPYFKleneVJykLuSYubTrHPFAM1aySVLJix2
X-MS-Exchange-AntiSpam-MessageData: 9/DKZXpTY5R9OAJ0qp5o3EcNCm1Ei7aDiWrEIbqf229y3+dOkbtU/BT0pDyN/yrHruI4bS8OJHh1HT1LEuI3M0PtZpqY4qds5bIu/H93fwUE7qA31cDknXQdiC+iy3G31vttACdPevR0fcnMH55anQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfceedbf-47dd-45ef-e731-08d7c4a372df
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2020 03:30:58.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwUACiP6G+yA3giLlV2TuMyWdQIZiL7MnCuEe1KnhutF95nsAlR6QDe05pt7HLuxlaSaLE82bPquADYNS0A0NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6621
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
index 4c11c38..a7656a4 100644
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

