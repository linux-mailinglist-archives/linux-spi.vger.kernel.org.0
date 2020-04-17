Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FFC1ADD02
	for <lists+linux-spi@lfdr.de>; Fri, 17 Apr 2020 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgDQMNJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Apr 2020 08:13:09 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46460 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDQMNG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Apr 2020 08:13:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HCBtKT019906;
        Fri, 17 Apr 2020 14:12:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=Zi4SisZc6FbWXefWeIc3r0RkxSLPr1E5Mixl1wY/6PA=;
 b=xiQKSdOlH+AjgjhNE8ySveLSrC8OELwZvMSkj1mW7S2RXGnb1m7Yh5fFWcNDvZcKmAow
 zf55Y7nPpJGSQVhz7zbcJW3In8I0gZm+qrc1f7DZoR7CJCYbfPDt/GBj2yCdZbEcX1AT
 muse+PaOtVzAl9eJyMbzfz4kOg8Vu5VwIcxY6qvoaZrislI8j/TqDYJXvWHzeY6uHIbi
 SRDqgKYm5/ra17f4L3K8TqkvmTCthlDEy+fu6G3ofz4t7nQcnyRng45skGrVs9HOlbia
 Ijfl5DD13Rj8atERPO6TXmDmXDOOIQ2RK5MV9XMYKILVS3uvOyXk+bAFNzuaGv5B1xfo Fg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn761cja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 14:12:54 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B27BB10002A;
        Fri, 17 Apr 2020 14:12:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node3.st.com [10.75.127.18])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A45532B0FC9;
        Fri, 17 Apr 2020 14:12:53 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG6NODE3.st.com (10.75.127.18)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 Apr 2020 14:12:52
 +0200
From:   <patrice.chotard@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Christophe Kerello <christophe.kerello@st.com>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: spi: stm32-qspi: Add pm_runtime support
Date:   Fri, 17 Apr 2020 14:12:41 +0200
Message-ID: <20200417121241.6473-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_03:2020-04-17,2020-04-17 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

By default, STM32_AUTOSUSPEND_DELAY is set to -1 which has for
effect to prevent runtime suspends.
Runtime suspends can be activated by setting autosuspend_delay_ms using
sysfs entry :
echo {delay_in_ms} > /sys/devices/platform/soc/58003000.spi/power/autosusp
end_delay_ms)

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 57 +++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index d066f5144c3e..2f2ea2c42d6e 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
@@ -87,6 +88,7 @@
 #define STM32_BUSY_TIMEOUT_US 100000
 #define STM32_ABT_TIMEOUT_US 100000
 #define STM32_COMP_TIMEOUT_MS 1000
+#define STM32_AUTOSUSPEND_DELAY -1
 
 struct stm32_qspi_flash {
 	struct stm32_qspi *qspi;
@@ -431,10 +433,17 @@ static int stm32_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
 	int ret;
 
+	ret = pm_runtime_get_sync(qspi->dev);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&qspi->lock);
 	ret = stm32_qspi_send(mem, op);
 	mutex_unlock(&qspi->lock);
 
+	pm_runtime_mark_last_busy(qspi->dev);
+	pm_runtime_put_autosuspend(qspi->dev);
+
 	return ret;
 }
 
@@ -444,6 +453,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	struct stm32_qspi *qspi = spi_controller_get_devdata(ctrl);
 	struct stm32_qspi_flash *flash;
 	u32 presc;
+	int ret;
 
 	if (ctrl->busy)
 		return -EBUSY;
@@ -451,6 +461,10 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	if (!spi->max_speed_hz)
 		return -EINVAL;
 
+	ret = pm_runtime_get_sync(qspi->dev);
+	if (ret < 0)
+		return ret;
+
 	presc = DIV_ROUND_UP(qspi->clk_rate, spi->max_speed_hz) - 1;
 
 	flash = &qspi->flash[spi->chip_select];
@@ -467,6 +481,9 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);
 	mutex_unlock(&qspi->lock);
 
+	pm_runtime_mark_last_busy(qspi->dev);
+	pm_runtime_put_autosuspend(qspi->dev);
+
 	return 0;
 }
 
@@ -643,9 +660,20 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 	ctrl->num_chipselect = STM32_QSPI_MAX_NORCHIP;
 	ctrl->dev.of_node = dev->of_node;
 
+	pm_runtime_set_autosuspend_delay(dev, STM32_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_get_noresume(dev);
+
 	ret = devm_spi_register_master(dev, ctrl);
-	if (!ret)
-		return 0;
+	if (ret)
+		goto err_qspi_release;
+
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 
 err_qspi_release:
 	stm32_qspi_release(qspi);
@@ -660,14 +688,28 @@ static int stm32_qspi_remove(struct platform_device *pdev)
 	struct stm32_qspi *qspi = platform_get_drvdata(pdev);
 
 	stm32_qspi_release(qspi);
+
 	return 0;
 }
 
-static int __maybe_unused stm32_qspi_suspend(struct device *dev)
+static int __maybe_unused stm32_qspi_runtime_suspend(struct device *dev)
 {
 	struct stm32_qspi *qspi = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(qspi->clk);
+
+	return 0;
+}
+
+static int __maybe_unused stm32_qspi_runtime_resume(struct device *dev)
+{
+	struct stm32_qspi *qspi = dev_get_drvdata(dev);
+
+	return clk_prepare_enable(qspi->clk);
+}
+
+static int __maybe_unused stm32_qspi_suspend(struct device *dev)
+{
 	pinctrl_pm_select_sleep_state(dev);
 
 	return 0;
@@ -683,10 +725,17 @@ static int __maybe_unused stm32_qspi_resume(struct device *dev)
 	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
 	writel_relaxed(qspi->dcr_reg, qspi->io_base + QSPI_DCR);
 
+	pm_runtime_mark_last_busy(qspi->dev);
+	pm_runtime_put_autosuspend(qspi->dev);
+
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(stm32_qspi_pm_ops, stm32_qspi_suspend, stm32_qspi_resume);
+static const struct dev_pm_ops stm32_qspi_pm_ops = {
+	SET_RUNTIME_PM_OPS(stm32_qspi_runtime_suspend,
+			   stm32_qspi_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(stm32_qspi_suspend, stm32_qspi_resume)
+};
 
 static const struct of_device_id stm32_qspi_match[] = {
 	{.compatible = "st,stm32f469-qspi"},
-- 
2.17.1

