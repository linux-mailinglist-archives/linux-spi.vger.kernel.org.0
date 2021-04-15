Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231CB360319
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 09:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhDOHSC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 03:18:02 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:17998 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231215AbhDOHSB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 03:18:01 -0400
Received: from localhost.localdomain (unknown [10.192.139.175])
        by mail-app4 (Coremail) with SMTP id cS_KCgBHmQ2C6Hdga8TPAA--.12438S4;
        Thu, 15 Apr 2021 15:17:28 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn, kjlu@umn.edu
Cc:     quanyang.wang@windriver.com, Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe
Date:   Thu, 15 Apr 2021 15:17:14 +0800
Message-Id: <20210415071714.19334-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cS_KCgBHmQ2C6Hdga8TPAA--.12438S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfKw4fAFWkAryrWFyfZwb_yoW8Kr1fpr
        WvqFW7Kr4Iq3yxtF1qyw4kXFy5uryFg347JrykK3WIva4Fq3WrtF18JFy3tFW0yF97AFWU
        WF48J3ySkF1YvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgwNBlZdtTXCvwAJs6
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is a PM usage counter decrement after zynqmp_qspi_init_hw()
without any refcount increment, which leads to refcount leak.Add
a refcount increment to balance the refcount. Also set
auto_runtime_pm to resume suspended spi controller.

Fixes: 9e3a000362aec ("spi: zynqmp: Add pm runtime support")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---

Changelog:

v2: - Add a refcount increment to fix refcout leak instead of the
      refcount decrement on error.
      Set ctlr->auto_runtime_pm = true.

v3: - Add fix tag.
      Add a return value check against pm_runtime_get_sync().
      Move pm_runtime_{mark_last_busy & put_autosuspend} to the
      end of current function.
---
 drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c8fa6ee18ae7..781ef3fc76e2 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1160,11 +1160,14 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
+
+	ret = pm_runtime_get_sync(&pdev->dev);
+	if (ret < 0)
+		goto clk_dis_all;
+
 	/* QSPI controller initializations */
 	zynqmp_qspi_init_hw(xqspi);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
 	xqspi->irq = platform_get_irq(pdev, 0);
 	if (xqspi->irq <= 0) {
 		ret = -ENXIO;
@@ -1187,6 +1190,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
 			    SPI_TX_DUAL | SPI_TX_QUAD;
 	ctlr->dev.of_node = np;
+	ctlr->auto_runtime_pm = true;
 
 	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret) {
@@ -1194,9 +1198,13 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 		goto clk_dis_all;
 	}
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 clk_dis_all:
+	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(xqspi->refclk);
-- 
2.17.1

