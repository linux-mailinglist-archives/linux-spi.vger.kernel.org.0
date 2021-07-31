Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC633DC7E9
	for <lists+linux-spi@lfdr.de>; Sat, 31 Jul 2021 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhGaTPb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 31 Jul 2021 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhGaTPa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 31 Jul 2021 15:15:30 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF0EC0613CF;
        Sat, 31 Jul 2021 12:15:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r26so25348899lfp.5;
        Sat, 31 Jul 2021 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6HizKYjgpTKrJ3jzl7u6TzRt2edy1/wCW+GDPbwhfc=;
        b=fdoVfL84CyiznnmBfdYdjkMQ6j45YNWXp8MpxPFW1uE1yoyJIJGGRw7IcSycSG9Jo4
         mANN3z34Sqtzt5LYu9OVPblxviUfwwcjZIIyZxeypk62d7cmcZHVrWrE3xJMag7NDW1/
         nKpKe910717Re8y/817xnAMyYyE/oEZ1phXQcObuuf9Y6SqX/7KY+2/qMDEcOgPgoQtJ
         Bi9GlmZTd+TOcjfyU+xJ+jJyMVLAAIrul2oboyn9HnJTuBksyguCiMEIcmsCU9MGt5oj
         dqliy9XxRIKz747BmTtiOSzecblxwJPHH4+QwYfYFiIJdU/Ej8SASAgEAf+i6H3vBGB+
         I+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O6HizKYjgpTKrJ3jzl7u6TzRt2edy1/wCW+GDPbwhfc=;
        b=S7wtC+SEdFsEBcmlkp5sVXAvDt2ZozJVttKNVBmfXjKPCwLYemiNv/Jb/8O8YJ85Pc
         JR5CYHjz/axiRx8MTU1PuWIRtAEZgtMsPKxkxQI0BYFL7Mfjw6QxVQPBELC1bG4tRtLN
         KYo14h6estAWrdJWAcnTzcVGa3b/USzm8DNqsC5xf+yClp4TyxprTjUQRFmNOqLQ9pBH
         OHIvJ41Zbp8f5J2SlMbZWgTjW5w2A9Osr5t59cudwS3sQsIPwGY6cfaDC7HQoTiqnZsz
         tmINTA0fRRt5mG7nzFYtSqP4SdMkr1+pa05fiGG/Nfa5+9kzCwYyVYjHZt0iPtHl/PBr
         +IQA==
X-Gm-Message-State: AOAM533iJGeqgMeNxCAikyWxLoJb9BFvYFP/KwxuyRNBteLXqMxucOj8
        uIKn8lOUekSJJ/uao2AhUnY=
X-Google-Smtp-Source: ABdhPJzTt7Uh80Ab4qfr7a5+r5WHylnUr0O7FG0DBD8AboWV7mqfsOMHg9CciPNr1T50Ah8IZs3C/w==
X-Received: by 2002:a05:6512:3f18:: with SMTP id y24mr2052427lfa.531.1627758922581;
        Sat, 31 Jul 2021 12:15:22 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id g17sm424259ljm.28.2021.07.31.12.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 12:15:22 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v1 1/2] spi: tegra20-slink: Improve runtime PM usage
Date:   Sat, 31 Jul 2021 22:14:57 +0300
Message-Id: <20210731191458.30535-1-digetx@gmail.com>
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

