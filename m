Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846263DC7EA
	for <lists+linux-spi@lfdr.de>; Sat, 31 Jul 2021 21:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhGaTPc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 31 Jul 2021 15:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhGaTPb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 31 Jul 2021 15:15:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD737C06175F;
        Sat, 31 Jul 2021 12:15:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r26so25348938lfp.5;
        Sat, 31 Jul 2021 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6RHlFVIPwschZyiy2o4/m4eOut9h9ogqnj+c4ljJ80=;
        b=f0WZEultHTpR23gI+ODq7vUmGqoi4oqTaCTpSwCTQmIaMtikaYta7syVgOELeYXid6
         Flg4CX4xrO0q9zE+exJKnV0rwd1BBnfOo/PmSrtHWDWULi6HCR/JYjBYx7qb8rtLqU1V
         6iMlGQ+sS1GOaiUDMqKJxl6HO1PtCfQ+Ra2h7/ZN7p6c3L1v2qe8V7BaH5VsixafkK+P
         6pQGGpMRo8wXEmd50n0NmvR4UHzyqwb1TEwwC0Zm667zKcVB3eLJ/Rdaro6+iogbwZny
         ldz+yt1qVB2iyuxL7kFU9aDno4vfar/DvKAUXNBsiW0IMW7q5cyzlvQC+LEFKREbUrIc
         2SEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6RHlFVIPwschZyiy2o4/m4eOut9h9ogqnj+c4ljJ80=;
        b=OJXNsxqjN9Y46Fc/mkM36oDj/K3B7SBYsenx6knycPdj7UyyBALh+Mj3sF0V9Q97UI
         lJ64D3LTIavXbXpWaQ39z7R+1YW2bOL+VpzRBpcfiw+kIYb0cqVhG+NsmqIMFGi3LmeD
         ilhaB4QQ/OnxzTwQJUUcjGRi1JgKzHq2THDd3vmMjhSuFVCAuyX8aicAtj5JMDVNZRhv
         NL4WeduJ1sHNrfnNezNIWQENFUfvNIyQtiu7bVLpPUXeukrjsIuGqvRFt70PF7mqDF7C
         fXx525OS6v13ymydGOnBPLYWkAooLR5APEPjWJX4YsC/tAde54MMCeLqodLSbJC//NLQ
         ZKkA==
X-Gm-Message-State: AOAM530EO9mZddwN3PhQwFkNoqRkkuzMG49ztfVjuyfBy/gU1m6mBWPq
        YQ3clYk7qjfT9FO9Im9uV0U=
X-Google-Smtp-Source: ABdhPJyCb6FoAGaCIy27//id4QlbypzqGHXAwu6+z79NK48DMSa8k59/KsmJhYfi563svgoPC+XApw==
X-Received: by 2002:ac2:4310:: with SMTP id l16mr6471813lfh.481.1627758923247;
        Sat, 31 Jul 2021 12:15:23 -0700 (PDT)
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
Subject: [PATCH v1 2/2] spi: tegra20-slink: Don't use resource-managed spi_register helper
Date:   Sat, 31 Jul 2021 22:14:58 +0300
Message-Id: <20210731191458.30535-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731191458.30535-1-digetx@gmail.com>
References: <20210731191458.30535-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Don't use resource-managed spi_register helper to correct the driver
removal order and fix memory leak of spi_master that is never released.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/spi/spi-tegra20-slink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 501eca1d0f89..deff16ba6d58 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1112,7 +1112,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	tegra_slink_writel(tspi, tspi->def_command2_reg, SLINK_COMMAND2);
 
 	master->dev.of_node = pdev->dev.of_node;
-	ret = devm_spi_register_master(&pdev->dev, master);
+	ret = spi_register_master(master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not register to master err %d\n", ret);
 		goto exit_free_irq;
@@ -1142,6 +1142,8 @@ static int tegra_slink_remove(struct platform_device *pdev)
 	struct spi_master *master = platform_get_drvdata(pdev);
 	struct tegra_slink_data	*tspi = spi_master_get_devdata(master);
 
+	spi_unregister_master(master);
+
 	free_irq(tspi->irq, tspi);
 
 	pm_runtime_disable(&pdev->dev);
@@ -1152,6 +1154,8 @@ static int tegra_slink_remove(struct platform_device *pdev)
 	if (tspi->rx_dma_chan)
 		tegra_slink_deinit_dma_param(tspi, true);
 
+	spi_master_put(master);
+
 	return 0;
 }
 
-- 
2.32.0

