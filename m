Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73FC22E5E6
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 08:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgG0Gdx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 02:33:53 -0400
Received: from mail-eopbgr00076.outbound.protection.outlook.com ([40.107.0.76]:24995
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgG0Gdx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 27 Jul 2020 02:33:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5tMgTTf/2Wx1HW5GqPU5hR1X/jXgF9mIvrDeqoGltIrU5FtW88iVuoPNn3H7V7dwaD/d4LO90uzzuqWEpSunEqZeeM9Y+bYnN96nH4MEVF6j4VID8zSaEXHldsq43t3MjG5e5PR0sqo5/Om3Hoa4DG5w8aZZtNY65EcrgTeyK8o3ZCLHh4wjfVj/PpAAWpL2z+XA5gD8tdxXUAlp1U1+G1FBkTAVMygaLoGJYLZ+5s6okX4Mdyxw+Bo7uA+JejvJUmqANk/VEmvfl0s8pDc2WRi78HDwIsRxrd3kLLgk98rdoQ6kILcylxfBTSBTgOrlCOph7oYJM3Ez01BZQ8SVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnIO0jxkCchRA224xqc8uyPvVE8Pq+WmWuVDewzZK5E=;
 b=Yj+HxqOv8q4JAhRr1huFYrebzD541gdHztlpiDiSlyauk7OABvDVmys6tVxjuQBIxjJKbLlgoCAgnkmOpSfFdqi5pax7OtY+xnjdLc1L/Acvqkd+ZmnMH7S2FqiMVpRUJJniGG/rcxslwZyaaNcjhGExP1Y7pFgIBabzDFo5O0Cfh7I1SDhrnN8lTnfaxBk9UCuvhz0kFJaikta7za0RI/t3vP+qfSthG9SzigBzyJsBcBfReX5EX3bS838MxT2fdFfcNtyZuRXh+560gIwXslcZ+VD9GeZYCWraPqH2cyP/3jfw4mWFH77ziz5ZjNGyY0xHXJKtB2p96duAT4td/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnIO0jxkCchRA224xqc8uyPvVE8Pq+WmWuVDewzZK5E=;
 b=qFFqoW6uXtpj4ju6u1or7Z5pOrz7jHVcWznVUApgpXpkEzajhR3xWJISfAZC7UTNav6/Q7WuGCuXwe30oxPh10XrkxzRXPPLIG8O4wbvatYyujSJc9kyyRy7v8CBl53HjJN3qYZvaTYlfsoiarh6oVzBD3kmF71UYSbIakFK8UI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM5PR04MB3235.eurprd04.prod.outlook.com (2603:10a6:206:c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Mon, 27 Jul
 2020 06:33:49 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 06:33:49 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: enable runtime pm support
Date:   Mon, 27 Jul 2020 14:33:54 +0800
Message-Id: <20200727063354.17031-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR02CA0112.apcprd02.prod.outlook.com (2603:1096:4:92::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend Transport; Mon, 27 Jul 2020 06:33:46 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ea6346f-6ce3-4df1-1a5d-08d831f70552
X-MS-TrafficTypeDiagnostic: AM5PR04MB3235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR04MB3235B9C12E94B5091934EE1DF3720@AM5PR04MB3235.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z1P8HUMXJq3QTsp3PPIkPDwHrYqt3TAYrJcUbd42vR1+bf7DBjlTAedL3po1WtYk7DzXAx04Z9hiDhDaUsCl/v7ARdenRicp2E9YiXKLoWsv5oDhf7TOMgHHtKlDLoUF+NO68hvwSVqsX62CNKXsXLVVe971if5HvPdMpyHMg4va+gP4UzPDRkqfqtleYlJcuhA/ZY6h2r0HnPdHdrsXnNXrluwFbQJupnJoxphMZGvn66O02YFDJhblhBr3EDI7xupzq5BttiCZOYnK/neE56AVbXJMQYkyXFV1f9rnlhmxAPzhH+vri+pYfZIAgoL5cLqhjNNkmokGQ3mr9T2Lg/h0DORztporlj0pnZoqLjPv2PMynRfK5AnFYGSSiAHv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(1076003)(6486002)(16526019)(26005)(186003)(316002)(2906002)(2616005)(4326008)(6506007)(956004)(66476007)(66556008)(66946007)(69590400007)(478600001)(6512007)(52116002)(6666004)(8936002)(83380400001)(5660300002)(8676002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: gcOz7l2SCYL1LOeijk8vY3M4SZlxjuuCk2SqZytp+xtuJ+NNK/lL4sR9IVXbaCdhAD4bBfP2ijCJrOIf5e9Ug/Dmx7FOUHmBcaE4AeRwXmSlmB+KTU80KsusgZ+Uq0Zkt7XKM763s6YGpfk0n0mefh65AwjF2l5G/SjPGgHOWtq/bromScxVesLgEV0wCPitBSW2ur5mcyaVG2+qNQWAsiQ6domweV+zb8Ni4yrcXzhsn0aO6fJC6l1eRrn+8dyVgdsGnUj5++/hOJhvDKuQ+Kk7KGRdixIEbM44vNwD1SBigMrbEnqbonq2fgkg1f8Iw72p409aCknkHWnuneqpQ4stgx5sqrWHB03v/TQZ/jZw/6uIxxI1GHeGBJ8c5LzWi+HRTLhNXXPngvC3HfvJj3eq9MhNvh98fnAYfbt+lf6apFrmwNa4TextgaY1YkM21Kz03DuYlVt8fYdwMtzMnzQmsK6/wZ2gw27jDCj/44A=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea6346f-6ce3-4df1-1a5d-08d831f70552
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 06:33:49.0813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvAdWIQEfZAThqfezvKT9wyy35xKXOOiyBf+TGHtSvzRxVJNOpKm4ZAQvu8aqemc8qllQcbWvT8O6TQKKAu7Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3235
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Enable runtime pm support for spi-imx driver.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
 drivers/spi/spi-imx.c | 121 ++++++++++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 33 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fdc25f549378..38a5f1304cec 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -13,7 +13,9 @@
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi_bitbang.h>
@@ -30,6 +32,8 @@ static bool use_dma = true;
 module_param(use_dma, bool, 0644);
 MODULE_PARM_DESC(use_dma, "Enable usage of DMA when available (default)");
 
+#define MXC_RPM_TIMEOUT		2000 /* 2000ms */
+
 #define MXC_CSPIRXDATA		0x00
 #define MXC_CSPITXDATA		0x04
 #define MXC_CSPICTRL		0x08
@@ -1530,20 +1534,16 @@ spi_imx_prepare_message(struct spi_master *master, struct spi_message *msg)
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 	int ret;
 
-	ret = clk_enable(spi_imx->clk_per);
-	if (ret)
-		return ret;
-
-	ret = clk_enable(spi_imx->clk_ipg);
-	if (ret) {
-		clk_disable(spi_imx->clk_per);
+	ret = pm_runtime_get_sync(spi_imx->dev);
+	if (ret < 0) {
+		dev_err(spi_imx->dev, "failed to enable clock\n");
 		return ret;
 	}
 
 	ret = spi_imx->devtype_data->prepare_message(spi_imx, msg);
 	if (ret) {
-		clk_disable(spi_imx->clk_ipg);
-		clk_disable(spi_imx->clk_per);
+		pm_runtime_mark_last_busy(spi_imx->dev);
+		pm_runtime_put_autosuspend(spi_imx->dev);
 	}
 
 	return ret;
@@ -1554,8 +1554,8 @@ spi_imx_unprepare_message(struct spi_master *master, struct spi_message *msg)
 {
 	struct spi_imx_data *spi_imx = spi_master_get_devdata(master);
 
-	clk_disable(spi_imx->clk_ipg);
-	clk_disable(spi_imx->clk_per);
+	pm_runtime_mark_last_busy(spi_imx->dev);
+	pm_runtime_put_autosuspend(spi_imx->dev);
 	return 0;
 }
 
@@ -1674,13 +1674,15 @@ static int spi_imx_probe(struct platform_device *pdev)
 		goto out_master_put;
 	}
 
-	ret = clk_prepare_enable(spi_imx->clk_per);
-	if (ret)
-		goto out_master_put;
+	pm_runtime_enable(spi_imx->dev);
+	pm_runtime_set_autosuspend_delay(spi_imx->dev, MXC_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(spi_imx->dev);
 
-	ret = clk_prepare_enable(spi_imx->clk_ipg);
-	if (ret)
-		goto out_put_per;
+	ret = pm_runtime_get_sync(spi_imx->dev);
+	if (ret < 0) {
+		dev_err(spi_imx->dev, "failed to enable clock\n");
+		goto out_runtime_pm_put;
+	}
 
 	spi_imx->spi_clk = clk_get_rate(spi_imx->clk_per);
 	/*
@@ -1690,7 +1692,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	if (spi_imx->devtype_data->has_dmamode) {
 		ret = spi_imx_sdma_init(&pdev->dev, spi_imx, master);
 		if (ret == -EPROBE_DEFER)
-			goto out_clk_put;
+			goto out_runtime_pm_put;
 
 		if (ret < 0)
 			dev_err(&pdev->dev, "dma setup error %d, use pio\n",
@@ -1705,19 +1707,20 @@ static int spi_imx_probe(struct platform_device *pdev)
 	ret = spi_bitbang_start(&spi_imx->bitbang);
 	if (ret) {
 		dev_err(&pdev->dev, "bitbang start failed with %d\n", ret);
-		goto out_clk_put;
+		goto out_runtime_pm_put;
 	}
 
 	dev_info(&pdev->dev, "probed\n");
 
-	clk_disable(spi_imx->clk_ipg);
-	clk_disable(spi_imx->clk_per);
+	pm_runtime_mark_last_busy(spi_imx->dev);
+	pm_runtime_put_autosuspend(spi_imx->dev);
+
 	return ret;
 
-out_clk_put:
-	clk_disable_unprepare(spi_imx->clk_ipg);
-out_put_per:
-	clk_disable_unprepare(spi_imx->clk_per);
+out_runtime_pm_put:
+	pm_runtime_dont_use_autosuspend(spi_imx->dev);
+	pm_runtime_put_sync(spi_imx->dev);
+	pm_runtime_disable(spi_imx->dev);
 out_master_put:
 	spi_master_put(master);
 
@@ -1732,30 +1735,82 @@ static int spi_imx_remove(struct platform_device *pdev)
 
 	spi_bitbang_stop(&spi_imx->bitbang);
 
-	ret = clk_enable(spi_imx->clk_per);
+	ret = pm_runtime_get_sync(spi_imx->dev);
+	if (ret < 0) {
+		dev_err(spi_imx->dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	writel(0, spi_imx->base + MXC_CSPICTRL);
+
+	pm_runtime_dont_use_autosuspend(spi_imx->dev);
+	pm_runtime_put_sync(spi_imx->dev);
+	pm_runtime_disable(spi_imx->dev);
+
+	spi_imx_sdma_exit(spi_imx);
+	spi_master_put(master);
+
+	return 0;
+}
+
+static int __maybe_unused spi_imx_runtime_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_imx_data *spi_imx;
+	int ret;
+
+	spi_imx = spi_master_get_devdata(master);
+
+	ret = clk_prepare_enable(spi_imx->clk_per);
 	if (ret)
 		return ret;
 
-	ret = clk_enable(spi_imx->clk_ipg);
+	ret = clk_prepare_enable(spi_imx->clk_ipg);
 	if (ret) {
-		clk_disable(spi_imx->clk_per);
+		clk_disable_unprepare(spi_imx->clk_per);
 		return ret;
 	}
 
-	writel(0, spi_imx->base + MXC_CSPICTRL);
-	clk_disable_unprepare(spi_imx->clk_ipg);
+	return 0;
+}
+
+static int __maybe_unused spi_imx_runtime_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct spi_imx_data *spi_imx;
+
+	spi_imx = spi_master_get_devdata(master);
+
 	clk_disable_unprepare(spi_imx->clk_per);
-	spi_imx_sdma_exit(spi_imx);
-	spi_master_put(master);
+	clk_disable_unprepare(spi_imx->clk_ipg);
+
+	return 0;
+}
 
+static int __maybe_unused spi_imx_suspend(struct device *dev)
+{
+	pinctrl_pm_select_sleep_state(dev);
 	return 0;
 }
 
+static int __maybe_unused spi_imx_resume(struct device *dev)
+{
+	pinctrl_pm_select_default_state(dev);
+	return 0;
+}
+
+static const struct dev_pm_ops imx_spi_pm = {
+	SET_RUNTIME_PM_OPS(spi_imx_runtime_suspend,
+				spi_imx_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(spi_imx_suspend, spi_imx_resume)
+};
+
 static struct platform_driver spi_imx_driver = {
 	.driver = {
 		   .name = DRIVER_NAME,
 		   .of_match_table = spi_imx_dt_ids,
-		   },
+		   .pm = &imx_spi_pm,
+	},
 	.id_table = spi_imx_devtype,
 	.probe = spi_imx_probe,
 	.remove = spi_imx_remove,
-- 
2.17.1

