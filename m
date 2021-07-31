Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773203DC7F8
	for <lists+linux-spi@lfdr.de>; Sat, 31 Jul 2021 21:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhGaT1v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 31 Jul 2021 15:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhGaT1v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 31 Jul 2021 15:27:51 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004ECC06175F;
        Sat, 31 Jul 2021 12:27:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q2so17957094ljq.5;
        Sat, 31 Jul 2021 12:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mF5jJMkIOO0rt01tM4tFQY5v7fhGHvxfoo1nsE5/rC8=;
        b=GzSB5I7b/ZV7Xoc+57r8ZsNtp4hbBhMhSYW0LrV59xaHRW9bqrM+AJgP1vKa6xJQmg
         1izgywnFwmSQYTXAx/NCu6gmHXEi+j+io43QllGypGuKF9kTalZ7LBQ8ndP/um1dgWfS
         ExCtVC2R9zrppuxsBk+Y4YkQYjhf/0rMiRbBIPobc0CD6yUHEo9FkOijlkXRYlAOfYET
         frOXH5tF9GYRmPUhVWHfnyQ7aIH5WHIFcEPVZhAnVmRcTfnh23YGiwzw/vGAmrUByDOt
         0Cjt6W9mkXSYTBaoz/cJYMSo06ftD8J4QLJiSfp7QmxEAhxy/roHkk1nz9dLiljNRq0Q
         AT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mF5jJMkIOO0rt01tM4tFQY5v7fhGHvxfoo1nsE5/rC8=;
        b=CdSApUAgiSIM0d+JSJf/nmWBMTCpFXLgrWdHuuRw993+xNGJpcx/LOaHhxsyi32PN7
         +QnzfBFkHu9LAvu/rPxZ2QFHeEce/irMZ7XPneeh/7095JrS+8eAVK0dNa2UW4FwTgqP
         fq4vsFy9L8LBtAzkuIwDKYB2R/4+QYAV+/vZyv+JFvJSPFcnfMXgiaOvaRC1WBWID5e2
         XHTdvijDdRIlX5ACF+EOXJP4qXu8ucyUwZEqkCvGwnfOKJ3fhS76CkVL4HxA8TjoQqzS
         Z1tnS/L6IF78J4ldqpzOku2QvnbnomV+aK0QQCVIxaJRr9pKPdT7Vz3ZS3nSRS8MRFXz
         X0yA==
X-Gm-Message-State: AOAM531npBxvby57nR84lJcDUw33usLv9f4syB8kxELaQhj2YUy0jcgn
        oAj6CDnygBiC7Stf0+VifOc=
X-Google-Smtp-Source: ABdhPJwmi6L6WcG71DgleNBpgp5MZ3Bd1Nd3Z9Vq9eVCn8P1mlIYLFGweH/PB7mLVR7IEIXRPEGuZA==
X-Received: by 2002:a2e:98c8:: with SMTP id s8mr6041951ljj.495.1627759661422;
        Sat, 31 Jul 2021 12:27:41 -0700 (PDT)
Received: from localhost.localdomain (94-29-22-96.dynamic.spd-mgts.ru. [94.29.22.96])
        by smtp.gmail.com with ESMTPSA id a10sm424600ljb.138.2021.07.31.12.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 12:27:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Laxman Dewangan <ldewangan@nvidia.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v2 2/2] spi: tegra20-slink: Don't use resource-managed spi_register helper
Date:   Sat, 31 Jul 2021 22:27:31 +0300
Message-Id: <20210731192731.5869-2-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210731192731.5869-1-digetx@gmail.com>
References: <20210731192731.5869-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Don't use resource-managed spi_register helper to correct the driver
removal order and make it to match the error unwinding order of the
probe function.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---

Changelog:

v2: - Corrected commit message, which said that a memory leak is also
      fixed here, but it's not.

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

