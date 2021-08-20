Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29CA73F2817
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 10:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhHTIGx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 04:06:53 -0400
Received: from inva021.nxp.com ([92.121.34.21]:55436 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhHTIGx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Aug 2021 04:06:53 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D7E51202CB5;
        Fri, 20 Aug 2021 10:06:14 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D8A1202CA9;
        Fri, 20 Aug 2021 10:06:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4757D183ACDC;
        Fri, 20 Aug 2021 16:06:13 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH 1/4] spi: spi-nxp-fspi: enable runtime pm for fspi
Date:   Fri, 20 Aug 2021 15:44:00 +0800
Message-Id: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Enable the runtime PM in fspi driver. Reading the power mode from the
debug monitor, FSPI_0 was on and with the patch it is lp.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 81 +++++++++++++++++++++++++++++++-------
 1 file changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a66fa97046ee..1eecf20f1dab 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -48,6 +48,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/pm_qos.h>
 #include <linux/regmap.h>
 #include <linux/sizes.h>
@@ -57,6 +58,8 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
 
+/* runtime pm timeout */
+#define FSPI_RPM_TIMEOUT 50	/* 50ms */
 /*
  * The driver only uses one single LUT entry, that is updated on
  * each call of exec_op(). Index 0 is preset at boot with a basic
@@ -373,6 +376,8 @@ struct nxp_fspi {
 	struct mutex lock;
 	struct pm_qos_request pm_qos_req;
 	int selected;
+#define FSPI_INITILIZED		(1 << 0)
+	int flags;
 };
 
 static inline int needs_ip_only(struct nxp_fspi *f)
@@ -864,6 +869,12 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
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
@@ -892,8 +903,14 @@ static int nxp_fspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
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
 
@@ -1153,12 +1170,17 @@ static int nxp_fspi_probe(struct platform_device *pdev)
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
@@ -1192,13 +1214,19 @@ static int nxp_fspi_probe(struct platform_device *pdev)
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
@@ -1224,20 +1252,50 @@ static int nxp_fspi_remove(struct platform_device *pdev)
 	return 0;
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
 
+static const struct dev_pm_ops nxp_fspi_pm_ops = {
+	SET_RUNTIME_PM_OPS(nxp_fspi_runtime_suspend, nxp_fspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+#endif	/* CONFIG_PM */
+
 static const struct of_device_id nxp_fspi_dt_ids[] = {
 	{ .compatible = "nxp,lx2160a-fspi", .data = (void *)&lx2160a_data, },
 	{ .compatible = "nxp,imx8mm-fspi", .data = (void *)&imx8mm_data, },
@@ -1256,11 +1314,6 @@ static const struct acpi_device_id nxp_fspi_acpi_ids[] = {
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
2.17.1

