Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020F32C206B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 09:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbgKXIvv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 03:51:51 -0500
Received: from mail-eopbgr70085.outbound.protection.outlook.com ([40.107.7.85]:12782
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730519AbgKXIvu (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Nov 2020 03:51:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTQVlZ/xQ/bOVmR0cy5qUYLAwZ8HPbpl0GmFLD2A9y/kDmSK699P6vpUHEc5ighBITu8arM6WmkAB35P2r+4kPMdik6JfPFyISg3cH5RldIshNZBkvgt1SbGJ7w9lawlcPCeknlvYO7uXBA5bcmh5+EaBCoJh2aWJ92hwbsTOybb0Ll+Z36bK3Y237UtC301C5F7fV3/SbZY8zkZOiOirSpE3yaslCvCFdoRVJKrfQT0cgxz2ti2OcdzSknhjUK9+dKAdGaLkZzWmzjueN6fZKIc++GWYr0ZxW4Vt3TQvRvalmYN/EJe9/IBY5To/y2px4ACx1z9B8BJXwL9oXCvMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRoSuKKuImbStl8mlY0dTj6a/2C8lzBsCFpTlxRonFo=;
 b=Hdj8K7G0wRWCNJRQ3/qGEbf6wXQCpFJnaMijqVEIUskWYNbVjTXcG5nFIWaUNYOi6fBbb65cpKTe3Id9vQUSY5onlzPk4wBVP32EuWj5MGSXQM74ugnj/lxYvjK9Ukgq+ZMDe1oEZPFdQAiSfRUJLHP5iB8piiPLITPM9yrNyqJTUsDIV1AHrLPF7I7ODXlylthbkvlbFhjVpt+SM6wWqW27P3P1mBtYwobTgFMIkCTv0IBhb1zdhMQpPvUPof4YGlSxU8bD3QWNMed/b4sgy2wcU2pS8sOc2bq++Nr4t/BQ3+nfbjc1VSxpECnFrUdge9KWrG/Me7bBBsPDssDhZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRoSuKKuImbStl8mlY0dTj6a/2C8lzBsCFpTlxRonFo=;
 b=R6TzJJXGrapFfZI3UU3kiF5W4Z02PTtG2lfQHg9PR81acdfiMaHhIHRvw/CCRyivlGWINlWIPK8VvCOyfxqsK9PiM3C5ALRW0YPcplk7jlH7/9LwoORi0yIIrgJ8YSJ8uH9gXZJzteTKzUMgxYlwwrWrbzZDCYP83EolgLkJyKE=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 08:51:47 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::a533:3a5b:d525:d784]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::a533:3a5b:d525:d784%6]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 08:51:47 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        nikita.shubin@maquefel.me
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: fix the unbalanced spi runtime pm management
Date:   Tue, 24 Nov 2020 16:52:47 +0800
Message-Id: <20201124085247.18025-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0156.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 08:51:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9978c8d-01f1-4ed8-ed14-08d890562d09
X-MS-TrafficTypeDiagnostic: AM7PR04MB7077:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7077A00CE4B8A17DBF474515F3FB0@AM7PR04MB7077.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y05zh95MNhohjOfLLnAzYx1tbjpAXHnIRsr/yuHRB3dVT5x0OnDl50xZb8KHL/de1Jyzkbeh8KSMgQdnsZqqKPWyI6AV6jnQn23ASmDxP/4s3xwB2LPl1TwNFyo/qWZT1CjY5FFkJGQsOoGG8+UV3nJnw56UOBe1LV5gPfImxdALrqCfrP9iGAR8ZDvarWtP+qgQMQWRStZSGRxfXhMmVtGk/KDQ2TfxYfDabQA6IorbgzWs1IJ7yei4C0FIXqdYiY7jWyciz17ITlwzSphi3his2dUsoWM1TmH+DKL7F1wSCaOJejYejIKVmUvdWdTWC3k50+y+fUYRjVvLEQRV4v8iy2yVTr8jXNLSTfQH4gMAWLeRtKGxxfOZTTUq7R7P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(6512007)(8936002)(8676002)(69590400008)(52116002)(2906002)(86362001)(6506007)(1076003)(16526019)(26005)(186003)(66946007)(66556008)(956004)(2616005)(316002)(6486002)(4326008)(66476007)(83380400001)(478600001)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lCH1KhPddAy7raz/nG54xbf7xcVHmfluLHu3xrotSoZnmd08J2Qe3FMCWKxkKqVeQ7h0B3Cup+lfABPSpSSmikcN83PwYOupTrSJ4GtlURfG96Qh+PfJYYlnKymcj6h4rxGjcPIpHPeq3/C1Hg3PEcC2XASu8EPTDPpALiU3lEGbvAXe2/KBntcy8BCf3lYrXMGAgFBnxbUzVE/CIZGhJJr0/HQ+/w7r9KCPAro1z64bnscOUv4v3ZWg2HfdWd/KtEGKaiOgCOmiQ9RpdAgiCteWBEt4UZQfg70xSnEqw5hp+0nNIYKL6OJB+ZPqdVLYOpZCGkkfzjXlVRqtVE+mw4MfSt0c8EWs0JD3Uh+Yj8vWDLkXF59OxCrMSkWZY2e1VzQHMKHO8zAw3C7uibp2MzJxqddlxd403niewrMB+UrvktPTxvvYtkzAZT/n4FfM0Tjqz0dwL3YGW90NQQ07X1ebQulGOvXzcxkKM2l3bPJehxd7Iz+KYVahbkUrIAl2cN6quDQL+mp6SiItSa5v3R9XTqxv8X02hbfdVrk3iE/Dag6s5OW+I3Sl9v86ukD0SvRjJYcaAEm1gtT4lplW8F4DR9KeVUNGHUvLNaWpQMdSfe8HP58xAZf0/vbS3+f2h8voC1mMxywbAajrBqcmHmn53ao6Jg/IJCt5i12JfAQUiJCKKuwI7KIlOLCYtFIBYyfEIZtvjTen+q8zqvgzEZQ/xKBObKZPbzdZrD0T91jrA/7H/Y0nViNVpApZ21aXbSP6EBa53g+boLI2HTBXSE98h6oH8CaDk9PfOQKZDziDtkj7klkVzk8i6mgKm8sglOfsQ15bK/RHL4Jd2CMSlIy9uungUeL30jkOIlOB/JbBGb4BZwqJMOskX0Ky51N/kxENMm1R/VQ2KX3rIklIQA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9978c8d-01f1-4ed8-ed14-08d890562d09
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 08:51:47.3755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7OveCDPINtIsi7QgEnCGFU6hiWw/m2P8kHHjh+KYJQac0KrL+f0dcCQozYxM5PTEhrN8BUoHvA/lfN7AjtZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If set active without increase the usage count of pm, the dont use
autosuspend function will call the suspend callback to close the two
clocks of spi because the usage count is reduced to -1.
This will cause the warning dump below when the defer-probe occurs.

[  129.379701] ecspi2_root_clk already disabled
[  129.384005] WARNING: CPU: 1 PID: 33 at drivers/clk/clk.c:952 clk_core_disable+0xa4/0xb0

So add the get noresume function before set active.

Fixes: 43b6bf406cd0 spi: imx: fix runtime pm support for !CONFIG_PM
Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 7513ef552d79..73ca821763d6 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1659,6 +1659,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
 	pm_runtime_use_autosuspend(spi_imx->dev);
+	pm_runtime_get_noresume(spi_imx->dev);
 	pm_runtime_set_active(spi_imx->dev);
 	pm_runtime_enable(spi_imx->dev);
 
-- 
2.17.1

