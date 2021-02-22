Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3E1320F75
	for <lists+linux-spi@lfdr.de>; Mon, 22 Feb 2021 03:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhBVCfh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 21 Feb 2021 21:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbhBVCfh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 21 Feb 2021 21:35:37 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77593C061574;
        Sun, 21 Feb 2021 18:34:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id w4so12065257wmi.4;
        Sun, 21 Feb 2021 18:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUWfmmu8/MSSQ/CGog/7Af40QRm3i4Uz451jOqVr8Ko=;
        b=llPwk55sZ4y4UJM/0xOBAUAKjkG3CgnmdJXfkWCz27lsaXPeNHBfWdqk4TdIhkVikc
         6vnqdA6xddu/jtf8lOhT6aY7XEcIJXcGK/Q+e+RZMvkbynD5Vt/dxDYxH84cpdgb8UI0
         x5dR/HAJkH78+zcvhVabmxEZB0S6QEtBUrO1t5Z96oFKK68E/uMQG3ic+uzQCIj/whbv
         rHHAZtsae+913GZtnqE+V7FeByaPDgz54advLm3LdnAdb8wyAPFWBX0gtkfBLiCeORlH
         8t8fMh9FZ235eWIr/Udmrq2DJqLFpXGqBzzLq4Vt6X4RBdHPPES81jCoeI/KZaj0t8bw
         wXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UUWfmmu8/MSSQ/CGog/7Af40QRm3i4Uz451jOqVr8Ko=;
        b=PhKzaSZGD8wE18FWt7/Zha000fH5jiTzlwhJLyQ+EZlh4PZRqiiFOQSUJqY8LJU1K5
         d+Kf0EUvJdmwd6KHdgbByyCkajWrf9g9xtVnBYWeDJBu81Sreuz7gZnIvsl0ct6SRsYZ
         6Y4Tf66lmewPEc4YxvE7pjLiQ0yXTzMNAHk/PZ3s0vceLNORRJaJ5jC4/D/vTnFrxnNr
         dK8ZQqbt3+wyW4PtPo8c3fPEGHET5GLl4DzYy0etIBkZXzKXeXn5ZtmMBntPVnMGK30v
         ZCeLFv5odu5dn3jftANrbV2V1WVC6BtwnGJGFmUPd96R0OYQyR4uvMlhK9R/GqTd529C
         aazQ==
X-Gm-Message-State: AOAM5308K89AEA0ZqJlJyH9IbQnNxqIh1bF8O8wkD+kc9DAEO/rHe/Yv
        2rV9hvzVQX6115RgIIwZxbJACYDJZx0=
X-Google-Smtp-Source: ABdhPJxikA1Kx8VGY9k+tYHdKEvoC0iXMWun+BF8aSsaa68Pj9Cuz3l00y8RO5sep2TF+7uzma5fRw==
X-Received: by 2002:a1c:c3d5:: with SMTP id t204mr12572195wmf.114.1613961295319;
        Sun, 21 Feb 2021 18:34:55 -0800 (PST)
Received: from localhost.localdomain ([195.245.17.255])
        by smtp.gmail.com with ESMTPSA id g1sm23918827wmh.9.2021.02.21.18.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 18:34:54 -0800 (PST)
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: omap2-mcspi: Activate pinctrl idle state during runtime suspend
Date:   Mon, 22 Feb 2021 03:32:43 +0100
Message-Id: <20210222023243.491432-1-alexander.sverdlin@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Set the (optional) idle pinctrl state during runtime suspend. This is the
same schema used in PL022 driver and can help with HW designs sharing
the SPI lines for different purposes.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 drivers/spi/spi-omap2-mcspi.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index d4c9510af393..999c22736416 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1327,6 +1327,17 @@ static int omap2_mcspi_controller_setup(struct omap2_mcspi *mcspi)
 	return 0;
 }
 
+static int omap_mcspi_runtime_suspend(struct device *dev)
+{
+	int error;
+
+	error = pinctrl_pm_select_idle_state(dev);
+	if (error)
+		dev_warn(dev, "%s: failed to set pins: %i\n", __func__, error);
+
+	return 0;
+}
+
 /*
  * When SPI wake up from off-mode, CS is in activate state. If it was in
  * inactive state when driver was suspend, then force it to inactive state at
@@ -1338,6 +1349,11 @@ static int omap_mcspi_runtime_resume(struct device *dev)
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 	struct omap2_mcspi_regs *ctx = &mcspi->ctx;
 	struct omap2_mcspi_cs *cs;
+	int error;
+
+	error = pinctrl_pm_select_default_state(dev);
+	if (error)
+		dev_warn(dev, "%s: failed to set pins: %i\n", __func__, error);
 
 	/* McSPI: context restore */
 	mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, ctx->modulctrl);
@@ -1566,11 +1582,6 @@ static int __maybe_unused omap2_mcspi_resume(struct device *dev)
 	struct omap2_mcspi *mcspi = spi_master_get_devdata(master);
 	int error;
 
-	error = pinctrl_pm_select_default_state(dev);
-	if (error)
-		dev_warn(mcspi->dev, "%s: failed to set pins: %i\n",
-			 __func__, error);
-
 	error = spi_master_resume(master);
 	if (error)
 		dev_warn(mcspi->dev, "%s: master resume failed: %i\n",
@@ -1582,7 +1593,8 @@ static int __maybe_unused omap2_mcspi_resume(struct device *dev)
 static const struct dev_pm_ops omap2_mcspi_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(omap2_mcspi_suspend,
 				omap2_mcspi_resume)
-	.runtime_resume	= omap_mcspi_runtime_resume,
+	.runtime_suspend	= omap_mcspi_runtime_suspend,
+	.runtime_resume		= omap_mcspi_runtime_resume,
 };
 
 static struct platform_driver omap2_mcspi_driver = {
-- 
2.29.2

