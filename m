Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD433DC7FB
	for <lists+linux-spi@lfdr.de>; Sat, 31 Jul 2021 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhGaT1w (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 31 Jul 2021 15:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhGaT1v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 31 Jul 2021 15:27:51 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9E7C0613CF;
        Sat, 31 Jul 2021 12:27:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x7so17925407ljn.10;
        Sat, 31 Jul 2021 12:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQQYBnVqJL6u9Zvw9Vuyg8hajjYnCjQC3YRr3+n0xBI=;
        b=oSsvbn4/kok6xvVkgWKMhWfVlTQg0zyRh2SYMLdMlxLQ44Ua7VjEHUNnFTZtsUfuoa
         DT/e8Sdexnqq7CCmO8dEF/4Eo7knQSietwPOJxWxw8RMA0kKlsm/Whg4Z8+YmVLAREV/
         8FF4QCCuLwJQyQxEKgZtF1eq8/r4ujsijWSUUiggK3EcQhQpDDcAKBe+EOFn6H/FUp/j
         D+gdBxrUWKJ5N5CgPfkMVoSAGYtwVrlpZuXp0gOGtJKRSG7McT5UwFx3bXpgqB8Zsnt5
         l/Y0GoZsEo/xuUeitbktUB+Id54Q+oXBxhC0SLmk5Qd7aKcizYJiu0KdkvvnrIXzm7vL
         5rKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rQQYBnVqJL6u9Zvw9Vuyg8hajjYnCjQC3YRr3+n0xBI=;
        b=pLHwoqC4UHcCN++tnY6JuyJ3xxygzf/vD2jX0B0lqxSG3gQzQuC5LxAp/zqc3zCltJ
         czojwCIKoKJW1u0YenHFvmHonEkdID+ofoWDLTra8Hn1DhlrplfNNBJCImiFTScpfC/V
         WceSy7xPW5JQtWtk4rVc/a3XGyE9bnWZgKyvUP3ujy3u0LSozL9RtYOzlmIywHyuJgOB
         IAXvutKyiTSARX5e6tPQXd5yeGlBz/tUcHaz27k7zeAmKXL6dXZgMUJBMix6OT1boGtu
         YpBqjnjKeGYUr/RiExrKH7zzdzJHIIgVKbAun2rAl5o/UaWIUC748T2ImmDnZJNKOYdH
         wYYw==
X-Gm-Message-State: AOAM530Hck1Kt+GE1BNEXI7u81gg/WYqrva+3TBhLDphFADrYFwsQMmt
        B8vS9ljrrg834/fZ5EN8YzU=
X-Google-Smtp-Source: ABdhPJyzblucfoLcWTxvguFHMNeS/fdill0CLtZbl7KgvZgMU3LFOP4UXosRW2caSJUIgSx0S+lSJA==
X-Received: by 2002:a2e:7319:: with SMTP id o25mr5886283ljc.264.1627759660788;
        Sat, 31 Jul 2021 12:27:40 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id a10sm424600ljb.138.2021.07.31.12.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 12:27:40 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 1/2] spi: tegra20-slink: Improve runtime PM usage
Date:   Sat, 31 Jul 2021 22:27:30 +0300
Message-Id: <20210731192731.5869-1-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Tegra SPI driver supports runtime PM, which controls the clock
enable state, but the clk is also enabled separately from the RPM
at the driver probe time, and thus, stays always on. Fix it.

Runtime PM now is always available on Tegra, hence there is no need to
check the RPM presence in the driver anymore. Remove these checks.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - No changes.

 drivers/spi/spi-tegra20-slink.c | 73 +++++++++++----------------------
 1 file changed, 25 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 6a726c95ac7a..501eca1d0f89 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1061,33 +1061,12 @@ static int tegra_slink_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Can not get clock %d\n", ret);
 		goto exit_free_master;
 	}
-	ret = clk_prepare(tspi->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Clock prepare failed %d\n", ret);
-		goto exit_free_master;
-	}
-	ret = clk_enable(tspi->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Clock enable failed %d\n", ret);
-		goto exit_clk_unprepare;
-	}
-
-	spi_irq = platform_get_irq(pdev, 0);
-	tspi->irq = spi_irq;
-	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
-			tegra_slink_isr_thread, IRQF_ONESHOT,
-			dev_name(&pdev->dev), tspi);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
-					tspi->irq);
-		goto exit_clk_disable;
-	}
 
 	tspi->rst = devm_reset_control_get_exclusive(&pdev->dev, "spi");
 	if (IS_ERR(tspi->rst)) {
 		dev_err(&pdev->dev, "can not get reset\n");
 		ret = PTR_ERR(tspi->rst);
-		goto exit_free_irq;
+		goto exit_free_master;
 	}
 
 	tspi->max_buf_size = SLINK_FIFO_DEPTH << 2;
@@ -1095,7 +1074,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 
 	ret = tegra_slink_init_dma_param(tspi, true);
 	if (ret < 0)
-		goto exit_free_irq;
+		goto exit_free_master;
 	ret = tegra_slink_init_dma_param(tspi, false);
 	if (ret < 0)
 		goto exit_rx_dma_free;
@@ -1106,16 +1085,9 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	init_completion(&tspi->xfer_completion);
 
 	pm_runtime_enable(&pdev->dev);
-	if (!pm_runtime_enabled(&pdev->dev)) {
-		ret = tegra_slink_runtime_resume(&pdev->dev);
-		if (ret)
-			goto exit_pm_disable;
-	}
-
-	ret = pm_runtime_get_sync(&pdev->dev);
-	if (ret < 0) {
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret) {
 		dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
-		pm_runtime_put_noidle(&pdev->dev);
 		goto exit_pm_disable;
 	}
 
@@ -1123,33 +1095,43 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	udelay(2);
 	reset_control_deassert(tspi->rst);
 
+	spi_irq = platform_get_irq(pdev, 0);
+	tspi->irq = spi_irq;
+	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,
+				   tegra_slink_isr_thread, IRQF_ONESHOT,
+				   dev_name(&pdev->dev), tspi);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to register ISR for IRQ %d\n",
+			tspi->irq);
+		goto exit_pm_put;
+	}
+
 	tspi->def_command_reg  = SLINK_M_S;
 	tspi->def_command2_reg = SLINK_CS_ACTIVE_BETWEEN;
 	tegra_slink_writel(tspi, tspi->def_command_reg, SLINK_COMMAND);
 	tegra_slink_writel(tspi, tspi->def_command2_reg, SLINK_COMMAND2);
-	pm_runtime_put(&pdev->dev);
 
 	master->dev.of_node = pdev->dev.of_node;
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
-		goto exit_pm_disable;
+		goto exit_free_irq;
 	}
+
+	pm_runtime_put(&pdev->dev);
+
 	return ret;
 
+exit_free_irq:
+	free_irq(spi_irq, tspi);
+exit_pm_put:
+	pm_runtime_put(&pdev->dev);
 exit_pm_disable:
 	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_slink_runtime_suspend(&pdev->dev);
+
 	tegra_slink_deinit_dma_param(tspi, false);
 exit_rx_dma_free:
 	tegra_slink_deinit_dma_param(tspi, true);
-exit_free_irq:
-	free_irq(spi_irq, tspi);
-exit_clk_disable:
-	clk_disable(tspi->clk);
-exit_clk_unprepare:
-	clk_unprepare(tspi->clk);
 exit_free_master:
 	spi_master_put(master);
 	return ret;
@@ -1162,8 +1144,7 @@ static int tegra_slink_remove(struct platform_device *pdev)
 
 	free_irq(tspi->irq, tspi);
 
-	clk_disable(tspi->clk);
-	clk_unprepare(tspi->clk);
+	pm_runtime_disable(&pdev->dev);
 
 	if (tspi->tx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, false);
@@ -1171,10 +1152,6 @@ static int tegra_slink_remove(struct platform_device *pdev)
 	if (tspi->rx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, true);
 
-	pm_runtime_disable(&pdev->dev);
-	if (!pm_runtime_status_suspended(&pdev->dev))
-		tegra_slink_runtime_suspend(&pdev->dev);
-
 	return 0;
 }
 
-- 
2.32.0

