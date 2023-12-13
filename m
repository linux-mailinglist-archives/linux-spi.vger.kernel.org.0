Return-Path: <linux-spi+bounces-254-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5760810D04
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 10:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB65B20B83
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 09:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4301EB47;
	Wed, 13 Dec 2023 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AJHKlmjr"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2071.outbound.protection.outlook.com [40.107.21.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62A5AB
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 01:08:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFh6gDptvRGGw+Kwe7FrxTuxI+O7NsuXP0+wnfnZnAvrG+BYfyBat6X/vAvxUlCe6XiKh289mHCIXT3qURwFQNMmzD0JR36Q5oNdzgq5JVt3821wIbN2xFu9x+MhpSqBhZlTrZoYAasGNdEU8CUOVDOVgcz/BvTbe3KSE6YQakxMzY8rrF4qU7sQBYqkNbLXH2oJEzksn2tbBtoPpJA0A8ztL9FrP5ZEDxUu7jpR7Z240r+eEgv+52sJ/4AmInK6Tdo2A93WXETDYJA5IigffC7E2HNU7cq2ILnVJKM9kywfzQQAUXo1nW3MzWWYtkZXk9Ex+wwDwZeqFUsLSh/d8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdDw94mRdjuNYCoCO56sYwvdc4nIofDI+KxKsNefkLk=;
 b=NLXGFQgVWlmJF5tGDOrl4HtBSo+9pR1bG5eFZOsNC9e5dZzXjvJvTMlXZQW6u96e0J6g+410cIBeEXCGsHC7wjz880eCPEg9jo/o6+WNC36I0t5SxM0/t97WEPSmLCwB/nvyaeexGSYWKRH7wW44nCQn1MOa4WQQQrEZrYUAMEeRx235xkBQtGTpQi4SOpb16kwwpT/tePD+HrZCQBe9xnWeyCghpt5M0xxFs821aaUJI95nFmjSHWy5OFQmmlBZ0C/SgMpjZWq0Mdx9uSMo6NWHswVZjADPBVt3dQ+E8eghJj2+H+LSodfTn70YUBFI+pw32TcEPXhRMtNzi9//Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdDw94mRdjuNYCoCO56sYwvdc4nIofDI+KxKsNefkLk=;
 b=AJHKlmjrLDD3+7BVzUVljGM2IBXg2hA5Tj7wsTRHWutLDRXfJvMdPFvPIDpS2u5h8XFtAbtxJZ758vKnpEVHZhKkRc7Jragzi7yg3BGvTY9+wRoOBO9SRS6CTPJB4iCej4ze/oiqlP7RBFygf/7WBUyyYK0hwpiHldoLx8K7MTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com (2603:10a6:5:21::30) by
 AM7PR04MB6981.eurprd04.prod.outlook.com (2603:10a6:20b:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:08:34 +0000
Received: from DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79]) by DB7PR04MB4010.eurprd04.prod.outlook.com
 ([fe80::f008:81ba:6172:d79%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:08:34 +0000
From: haibo.chen@nxp.com
To: broonie@kernel.org,
	yogeshgaur.83@gmail.com
Cc: linux-spi@vger.kernel.org,
	linux-imx@nxp.com,
	haibo.chen@nxp.com,
	han.xu@nxp.com
Subject: [PATCH 1/5] spi: spi-nxp-fspi: enable runtime pm for fspi
Date: Wed, 13 Dec 2023 17:13:42 +0800
Message-Id: <20231213091346.956789-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0211.apcprd04.prod.outlook.com
 (2603:1096:4:187::19) To DB7PR04MB4010.eurprd04.prod.outlook.com
 (2603:10a6:5:21::30)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR04MB4010:EE_|AM7PR04MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: 13fd3cb1-99de-4b0e-c741-08dbfbbb1548
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	w1/giEkinX9AKv3NG9QwC4Ej9FlrA4YSXCdM7mzo1tbHh8sCGaCLJtPceyi5Ck7oRq9XYhoW5j3IuPQyzc8G+ue7QQ0zGx+Ybe59ap3RvEA/27m6cxXQJQK2E1iKOje6F21AU3MPOhzMBHAT0AON7Jrf+YY8zNI0dXF6PYiuPbSMTbgfnwBDEBwulk3EHVl4C8CTbbj0cNDsGiUfBIHhQh+d2j/l2ccekE0RTUm4R/wpv7ZwghYVv3bTysZ98QE3oAqXgs/LD8TDryWS2DkA19fpsGK+T3FORkBeHDoNtX/WG9xPHPnuOB2OY7Rp5WPK6ZxdZiqQye7VrwbnL0aDe43/9Wq34CJzXh3rMhdzOpzkA7D/6qr/I1wjRzOSAUESbT//hiwZ/7bau07rls+MjDi61NvFVOvFw3rel+nnFT/WIqjWFsKnJCXBBo1j1sQQKxq03QtwF8GEnXy+zQ7+uFx6FSykK8KUwAa+bQOLJ6Sdb5332vYqUnKrgrYRLh3A6/zysjQOQcBV3E1FJrve5Mp0upeNfwDwHj1TcmnpMgI7PPvR2TPCS1RZzEVp3KIBrtjRmVhTnRsCTcP6Cm4AthNd709FB40USHyZi5ZhahDk9jW6gOtwznr6dSn8dOjA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR04MB4010.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(346002)(366004)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(1076003)(26005)(2616005)(38350700005)(86362001)(38100700002)(36756003)(83380400001)(5660300002)(9686003)(6512007)(52116002)(6506007)(6666004)(8936002)(66946007)(8676002)(66556008)(6486002)(316002)(66476007)(41300700001)(2906002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oz7KMGbsFRQ/1x76yRF8vo7OihqxKgbWw83P2bM5QhtgNDYsGU0QpOPlIJNG?=
 =?us-ascii?Q?Tan2BIgVgtUSSKdNoKNMzcLKQRk3M8qnsSxoWRWwJd5TW4hi8FKgQSs2qz5N?=
 =?us-ascii?Q?CtMZnQQ9EcL/vxdEu0sTZCCBavT8Qb/qgQ5VySFdqm3wJ+73EaWpxLQrYIv/?=
 =?us-ascii?Q?GcZlnNNKaFZdBjafcyo11H86VWxmro96w2OrBHdO789vlbDUhGzDJRE39dff?=
 =?us-ascii?Q?n1plQ0jexgHqGDUv1hlx+HoZm8I3s98LQ3coTR7a5x/KD9imi9u1a9I6moT6?=
 =?us-ascii?Q?ENw6d81fdPkJ8/mIFUMegTYsw1ie5OLx5ZAxDXWu6yEvnCqHblCMxS1ErBL2?=
 =?us-ascii?Q?5/dkGf7u8olgcZF32d8wQVKAxYvLTGcPpjvV/qEbdsDI0H4oej6Y6ygsw2Sr?=
 =?us-ascii?Q?zswS9o5tYLywXMKeeClZOQQvQxP2tnYc/gXa5i7SEtZGkC3MDwmtnGWJWLet?=
 =?us-ascii?Q?7t8NNPd+UsfRZSNw5U+Ga9HPKKlYgOGGdxRE4nGQGUjYDiafkOewhR6E80FK?=
 =?us-ascii?Q?z5ACHv1IlA08mHv20nNcO7NEEvFdN7tmzeDyU1MndFExTzbxEnDtkXsWBa8O?=
 =?us-ascii?Q?SQJ73qfPkWtS+4za5eMmv4vbOtaobd2klH01wdc2WFrRHL9xQYiw9P67kNdI?=
 =?us-ascii?Q?NV3uE2f4LM9VEgQRmeB/xg61sXVn8GJWkfDslz1CK1yvOg3aQoP5PKwl81UH?=
 =?us-ascii?Q?F5pDA6E41yiHoXJbghmO5RbqkAq6P29CHAn7Yh7rUxeAFAC4EBoq2QD5SnNX?=
 =?us-ascii?Q?B/nVvtvQuSOBFyjvJPGtPceJ0SHVunvz0ifjBagyW29/yRyTUM8XVRNUi3MZ?=
 =?us-ascii?Q?SM9Rzx5bMfpkWZ0MT3dSBkOaFpn5/khPwMZw2m5drpa/HGEvCVf5kTOaUZCj?=
 =?us-ascii?Q?iDUI0V5Wxzjm7EkQaHitbYUFjrPj0qvyuUepewpPbqxluo1arO7sQFy1vqp3?=
 =?us-ascii?Q?ChSVLjUV/v3MEORimVmXxJkNna/h+fGNrgm0e/sBbhbcwHyIZqKtEXTIjVWs?=
 =?us-ascii?Q?IsQi92lUcWriPpX6FHCVsS7HwYjBj1I5GxeebXXSVGISeoiPqYjfxbO3xKV6?=
 =?us-ascii?Q?o85WeuGLofbe0JJ/qpdtFPRML0QX62vs1Z1QAtdVUMmNQ9aUxA8uv2TyunNO?=
 =?us-ascii?Q?ocgnWu4GRd48Q41v8YCwJnP/WxU8rXbEvtE9oA4SBsCwzFkvzhE+zJf6Afyv?=
 =?us-ascii?Q?NApQdQnAuyNQQyVqM4UGk562h0IVxzoAXU8DuLGvbVAjNTqNQtJe1gIoi3jK?=
 =?us-ascii?Q?yJGxthOC3nKWGbe4R99AWT8OjevHg3SvokDvwcBTNN7dkmcfwRo+gSOwnMgg?=
 =?us-ascii?Q?4CgckAOmsg73RjcMhzRRRe5wpx3nVmDuK2/UKWdLmoBEfn49vSGOgSd4Q6pQ?=
 =?us-ascii?Q?jMTw5Lu8JlC9ZNHDBkHRhCNtNd49mHaJ7Kh1MrOzstjf6LhNmeCr09XMaJSo?=
 =?us-ascii?Q?cooYlmv3+DvDbW4HyLwiv+DMm3JH0Z70nRTRLBhdhhtxHDx7PW1K2tCBCcwf?=
 =?us-ascii?Q?dHGYBfjFXkiVf4zAcTU286f8l+6zGsZFbhyW1rXIWfvSJb4DDiGhU/14Ea0V?=
 =?us-ascii?Q?W80r5rRrTI8L6pKzJX9eEXT0JfOEokK+S9a/eTZ+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13fd3cb1-99de-4b0e-c741-08dbfbbb1548
X-MS-Exchange-CrossTenant-AuthSource: DB7PR04MB4010.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 09:08:34.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0JMYcQEN2INCElPfEGis50Pj7bjGWxLMqJ8Gy3YNze4Z2kJot+XmDQAJz9gjJpJQdE9B6orUczb/l0sfQoOPAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6981

From: Haibo Chen <haibo.chen@nxp.com>

Enable the runtime PM in fspi driver.
Also for system PM, On some board like i.MX8ULP-EVK board,
after system suspend, IOMUX module will lost power, so all
the pinctrl setting will lost when system resume back, need
driver to save/restore the pinctrl setting.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 111 ++++++++++++++++++++++++++++++++-----
 1 file changed, 97 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index e13f678f2395..0feecf5ba010 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -48,6 +48,8 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/regmap.h>
 #include <linux/sizes.h>
@@ -57,6 +59,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+/* runtime pm timeout */
+#define FSPI_RPM_TIMEOUT 50	/* 50ms */
 /*
  * The driver only uses one single LUT entry, that is updated on
  * each call of exec_op(). Index 0 is preset at boot with a basic
@@ -390,6 +394,8 @@ struct nxp_fspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
+#define FSPI_INITILIZED		(1 << 0)
+	int flags;
 };
 
 static inline int needs_ip_only(struct nxp_fspi *f)
@@ -917,6 +923,12 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 	mutex_lock(&f->lock);
 
+	err = pm_runtime_get_sync(f->dev);
+	if (err < 0) {
+		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
+		goto err_mutex;
+	}
+
 	/* Wait for controller being ready. */
 	err = fspi_readl_poll_tout(f, f->iobase + FSPI_STS0,
 				   FSPI_STS0_ARB_IDLE, 1, POLL_TOUT, true);
@@ -945,8 +957,14 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	/* Invalidate the data in the AHB buffer. */
 	nxp_fspi_invalid(f);
 
+	pm_runtime_mark_last_busy(f->dev);
+	pm_runtime_put_autosuspend(f->dev);
+
 	mutex_unlock(&f->lock);
+	return err;
 
+err_mutex:
+	mutex_unlock(&f->lock);
 	return err;
 }
 
@@ -1201,12 +1219,17 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 			ret = PTR_ERR(f->clk);
 			goto err_put_ctrl;
 		}
+	}
 
-		ret = nxp_fspi_clk_prep_enable(f);
-		if (ret) {
-			dev_err(dev, "can not enable the clock\n");
-			goto err_put_ctrl;
-		}
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, FSPI_RPM_TIMEOUT);
+	pm_runtime_use_autosuspend(dev);
+
+	/* enable clock */
+	ret = pm_runtime_get_sync(f->dev);
+	if (ret < 0) {
+		dev_err(f->dev, "Failed to enable clock %d\n", __LINE__);
+		goto err_put_ctrl;
 	}
 
 	/* Clear potential interrupts */
@@ -1240,13 +1263,19 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_destroy_mutex;
 
+	pm_runtime_mark_last_busy(f->dev);
+	pm_runtime_put_autosuspend(f->dev);
+
+	/* indicate the controller has been initialized */
+	f->flags |= FSPI_INITILIZED;
+
 	return 0;
 
 err_destroy_mutex:
 	mutex_destroy(&f->lock);
 
 err_disable_clk:
-	nxp_fspi_clk_disable_unprep(f);
+	pm_runtime_disable(dev);
 
 err_put_ctrl:
 	spi_controller_put(ctlr);
@@ -1270,20 +1299,79 @@ static void nxp_fspi_remove(struct platform_device *pdev)
 		iounmap(f->ahb_addr);
 }
 
-static int nxp_fspi_suspend(struct device *dev)
+#ifdef CONFIG_PM
+static int nxp_fspi_initialized(struct nxp_fspi *f)
+{
+	return f->flags & FSPI_INITILIZED;
+}
+
+static int nxp_fspi_need_reinit(struct nxp_fspi *f)
+{
+	/*
+	 * we always use the controller in combination mode, so we check
+	 * this register bit to determine if the controller once lost power,
+	 * such as suspend/resume, and need to be re-init.
+	 */
+
+	return !(readl(f->iobase + FSPI_MCR0) & FSPI_MCR0_OCTCOMB_EN);
+}
+
+static int nxp_fspi_runtime_suspend(struct device *dev)
 {
+	struct nxp_fspi *f = dev_get_drvdata(dev);
+
+	nxp_fspi_clk_disable_unprep(f);
+
 	return 0;
 }
 
-static int nxp_fspi_resume(struct device *dev)
+static int nxp_fspi_runtime_resume(struct device *dev)
 {
 	struct nxp_fspi *f = dev_get_drvdata(dev);
 
-	nxp_fspi_default_setup(f);
+	nxp_fspi_clk_prep_enable(f);
+
+	if (nxp_fspi_initialized(f) && nxp_fspi_need_reinit(f))
+		nxp_fspi_default_setup(f);
 
 	return 0;
 }
 
+static int nxp_fspi_suspend(struct device *dev)
+{
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret) {
+		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
+		return ret;
+	}
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int nxp_fspi_resume(struct device *dev)
+{
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		dev_err(dev, "select flexspi default pinctrl failed!\n");
+
+	return ret;
+}
+
+
+static const struct dev_pm_ops nxp_fspi_pm_ops = {
+	SET_RUNTIME_PM_OPS(nxp_fspi_runtime_suspend, nxp_fspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(nxp_fspi_suspend, nxp_fspi_resume)
+};
+#endif	/* CONFIG_PM */
+
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
@@ -1302,11 +1390,6 @@ static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
 MODULE_DEVICE_TABLE(acpi, nxp_fspi_acpi_ids);
 #endif
 
-static const struct dev_pm_ops nxp_fspi_pm_ops = {
-	.suspend	= nxp_fspi_suspend,
-	.resume		= nxp_fspi_resume,
-};
-
 static struct platform_driver nxp_fspi_driver = {
 	.driver = {
 		.name	= "nxp-fspi",
-- 
2.34.1


