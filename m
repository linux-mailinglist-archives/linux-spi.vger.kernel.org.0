Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3A113D9D
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2019 10:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfLEJNp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Dec 2019 04:13:45 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45775 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfLEJNp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 5 Dec 2019 04:13:45 -0500
Received: by mail-lj1-f194.google.com with SMTP id d20so2618905ljc.12
        for <linux-spi@vger.kernel.org>; Thu, 05 Dec 2019 01:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RR1kjg9Kjz7rF3zhZSvGyA6Bp/21tr6u4LK78prBW84=;
        b=a8MWHdts9ofTS15DWm7UPuPce9kKC1/Mv17/S/JkjS6hfR8te7LFOYM5TuYq7Y0fy1
         WaWTrLhPa97EHI05XJOSOREeeKkeoWJgvGVrWPu5TezrdmeKHsR6nwRcyOYco2URyVMo
         2yaL1CT+fEk4sThYvzUi8AejGoG0AZk8/XO9zQSu7CrlantfY0g48SL/HZzPWkL9bvpM
         BAbYN0wsDUpuLv7ZeYZuUWdl8i4DpckRdKH74SKIdjCpmopM0WxEAsPe+Z3LeUEk48D7
         UBAg9WdY2ZVlqcN1jH55YX/X8JgHGX5nAtI6mc5EZg+5RoAg5s6kgM73teBwHa6dt4dl
         1Ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RR1kjg9Kjz7rF3zhZSvGyA6Bp/21tr6u4LK78prBW84=;
        b=mzs3EWvLa79SV9qHxVgzfNxbkC/ClnS1UTriJUvOrvRSoJEfYbPeN9Sj4kCxR6tbWU
         jBhFWtPUfUz73NDaTNyjRzt5m8QVjXlC2raBa7aB7UNSbVVxU8WNpuXRC8mRrdrXZxc0
         91nb/M0qYHXf5h6W/ePUPtrCnvfnrByKdEcf5BTChNnp+pJFaMlmOOWHOh9I86uP2WSP
         2hCkbEbcp/ISumeI5yy2msdsY/AqMTM2GXGTQ/g6zgtXqZANKzIQgQfC39RFUp7tyNbw
         8DFb57uclQ6kwh8AcAioB8Rqweflb9rE6h2feDAWmS2EmIq3od/EgqHT6L5hl0HvNB0u
         nJLw==
X-Gm-Message-State: APjAAAUnvKmtVT0Nw2YsOasxPhcVbULl0XWM3u6QnjP8EzsR5j3ayG0k
        k6VMvUXCtZ5JfeQjCPBqrg8pfg==
X-Google-Smtp-Source: APXvYqyvv/GiKCJNEOsfPxqk++hPpuH0wmenShujCJp64+kvPO7pcLCKH5McksT0gtcsYWVAHYChSA==
X-Received: by 2002:a2e:8016:: with SMTP id j22mr4875779ljg.24.1575537223428;
        Thu, 05 Dec 2019 01:13:43 -0800 (PST)
Received: from genomnajs.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id t9sm4521708ljj.19.2019.12.05.01.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 01:13:42 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] spi: bitbang: Make chipselect callback optional
Date:   Thu,  5 Dec 2019 10:13:40 +0100
Message-Id: <20191205091340.59850-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ->chipselect() callback on the bit-banged SPI library
master is optional if using GPIO descriptors: when using
descriptors exclusively without any native chipselects,
the core does not even call out the the native ->set_cs()
and therefore ->chipselect() on a bit-banged SPI master
will not even be called in this case.

Make sure to respect the SPI_MASTER_GPIO_SS as used by
e.g. spi-gpio.c though: this setting will make the core
handle the chip select using GPIO descriptors *AND* call
the local chipselect handler.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-bitbang.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bitbang.c b/drivers/spi/spi-bitbang.c
index d84e22dd6f9f..68491a8bf7b5 100644
--- a/drivers/spi/spi-bitbang.c
+++ b/drivers/spi/spi-bitbang.c
@@ -329,8 +329,20 @@ static void spi_bitbang_set_cs(struct spi_device *spi, bool enable)
 int spi_bitbang_init(struct spi_bitbang *bitbang)
 {
 	struct spi_master *master = bitbang->master;
+	bool custom_cs;
 
-	if (!master || !bitbang->chipselect)
+	if (!master)
+		return -EINVAL;
+	/*
+	 * We only need the chipselect callback if we are actually using it.
+	 * If we just use GPIO descriptors, it is surplus. If the
+	 * SPI_MASTER_GPIO_SS flag is set, we always need to call the
+	 * driver-specific chipselect routine.
+	 */
+	custom_cs = (!master->use_gpio_descriptors ||
+		     (master->flags & SPI_MASTER_GPIO_SS));
+
+	if (custom_cs && !bitbang->chipselect)
 		return -EINVAL;
 
 	mutex_init(&bitbang->lock);
@@ -344,7 +356,12 @@ int spi_bitbang_init(struct spi_bitbang *bitbang)
 	master->prepare_transfer_hardware = spi_bitbang_prepare_hardware;
 	master->unprepare_transfer_hardware = spi_bitbang_unprepare_hardware;
 	master->transfer_one = spi_bitbang_transfer_one;
-	master->set_cs = spi_bitbang_set_cs;
+	/*
+	 * When using GPIO descriptors, the ->set_cs() callback doesn't even
+	 * get called unless SPI_MASTER_GPIO_SS is set.
+	 */
+	if (custom_cs)
+		master->set_cs = spi_bitbang_set_cs;
 
 	if (!bitbang->txrx_bufs) {
 		bitbang->use_dma = 0;
-- 
2.23.0

