Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5382A29E69F
	for <lists+linux-spi@lfdr.de>; Thu, 29 Oct 2020 09:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgJ2Ity (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Oct 2020 04:49:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35214 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgJ2Ity (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Oct 2020 04:49:54 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1F53D1A04B3;
        Thu, 29 Oct 2020 09:49:52 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C72631A05E4;
        Thu, 29 Oct 2020 09:49:49 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8FBA140291;
        Thu, 29 Oct 2020 09:49:46 +0100 (CET)
From:   Qiang Zhao <qiang.zhao@nxp.com>
To:     olteanv@gmail.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhao Qiang <qiang.zhao@nxp.com>
Subject: [PATCH] spi: fsl-dspi: fix NULL pointer dereference
Date:   Thu, 29 Oct 2020 16:40:35 +0800
Message-Id: <20201029084035.19604-1-qiang.zhao@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Zhao Qiang <qiang.zhao@nxp.com>

Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in
remove path"), this driver causes a kernel oops:

[   64.587431] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000020
[..]
[   64.756080] Call trace:
[   64.758526]  dspi_suspend+0x30/0x78
[   64.762012]  platform_pm_suspend+0x28/0x70
[   64.766107]  dpm_run_callback.isra.19+0x24/0x70
[   64.770635]  __device_suspend+0xf4/0x2f0
[   64.774553]  dpm_suspend+0xec/0x1e0
[   64.778036]  dpm_suspend_start+0x80/0xa0
[   64.781957]  suspend_devices_and_enter+0x118/0x4f0
[   64.786743]  pm_suspend+0x1e0/0x260
[   64.790227]  state_store+0x8c/0x118
[   64.793712]  kobj_attr_store+0x18/0x30
[   64.797459]  sysfs_kf_write+0x40/0x58
[   64.801118]  kernfs_fop_write+0x148/0x240
[   64.805126]  vfs_write+0xc0/0x230
[   64.808436]  ksys_write+0x6c/0x100
[   64.811833]  __arm64_sys_write+0x1c/0x28
[   64.815753]  el0_svc_common.constprop.3+0x68/0x170
[   64.820541]  do_el0_svc+0x24/0x90
[   64.823853]  el0_sync_handler+0x118/0x168
[   64.827858]  el0_sync+0x158/0x180

This is because since this commit, the drivers private data point to
"dspi" instead of "ctlr", the codes in suspend and resume func were
not modified correspondly.

Fixes: 530b5affc675 ("spi: fsl-dspi: fix use-after-free in remove path")
Signed-off-by: Zhao Qiang <qiang.zhao@nxp.com>
---
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

