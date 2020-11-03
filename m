Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBE2A3A4B
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 03:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgKCCPX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Nov 2020 21:15:23 -0500
Received: from inva021.nxp.com ([92.121.34.21]:41376 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgKCCPX (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 2 Nov 2020 21:15:23 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FE49200293;
        Tue,  3 Nov 2020 03:15:21 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E70EB200145;
        Tue,  3 Nov 2020 03:15:18 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A75FF402BC;
        Tue,  3 Nov 2020 03:15:15 +0100 (CET)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     olteanv@gmail.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhao Qiang <qiang.zhao@nxp.com>
Subject: [Patch v2] spi: fsl-dspi: fix wrong pointer in suspend/resume
Date:   Tue,  3 Nov 2020 10:05:46 +0800
Message-Id: <20201103020546.1822-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in
remove path"), this driver causes a "NULL pointer dereference"
in dspi_suspend/resume.
This is because since this commit, the drivers private data point to
"dspi" instead of "ctlr", the codes in suspend and resume func were
not modified correspondly.

Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
Changes for v2:
	- modify commit msg

 drivers/spi/spi-fsl-dspi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3967afa..1a08c1d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1080,12 +1080,11 @@ MODULE_DEVICE_TABLE(of, fsl_dspi_dt_ids);
 #ifdef CONFIG_PM_SLEEP
 static int dspi_suspend(struct device *dev)
 {
-	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
+	struct fsl_dspi *dspi = dev_get_drvdata(dev);
 
 	if (dspi->irq)
 		disable_irq(dspi->irq);
-	spi_controller_suspend(ctlr);
+	spi_controller_suspend(dspi->ctlr);
 	clk_disable_unprepare(dspi->clk);
 
 	pinctrl_pm_select_sleep_state(dev);
@@ -1095,8 +1094,7 @@ static int dspi_suspend(struct device *dev)
 
 static int dspi_resume(struct device *dev)
 {
-	struct spi_controller *ctlr = dev_get_drvdata(dev);
-	struct fsl_dspi *dspi = spi_controller_get_devdata(ctlr);
+	struct fsl_dspi *dspi = dev_get_drvdata(dev);
 	int ret;
 
 	pinctrl_pm_select_default_state(dev);
@@ -1104,7 +1102,7 @@ static int dspi_resume(struct device *dev)
 	ret = clk_prepare_enable(dspi->clk);
 	if (ret)
 		return ret;
-	spi_controller_resume(ctlr);
+	spi_controller_resume(dspi->ctlr);
 	if (dspi->irq)
 		enable_irq(dspi->irq);
 
-- 
2.7.4

