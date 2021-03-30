Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0CD34EE75
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 18:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhC3Qt3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Mar 2021 12:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbhC3QtT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Mar 2021 12:49:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30832C061574
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 09:49:19 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id n138so24818610lfa.3
        for <linux-spi@vger.kernel.org>; Tue, 30 Mar 2021 09:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mH0nCRARtN5+w9TZoOp1Qm7Svfh+hhUeE/MFDUeNtKE=;
        b=bUuRgnlZm6jAkUUpJk08qnJq9UxPnc7IQPVHVqsd7d/3JOeNGWNnFYeHW12l90f6Rn
         xDiLdkuL5BejI4Ym2rBJcN833LJttSJeN0hHNsvawtSP+f1+FeB3bLiONrhWAniYFnqG
         7QL0FXdm6qizdOJNpZ72xv7N+PtNprgcLd0pQm0ucFuUJv8vZvd2tdZr/npMbd9J3kFW
         n5PgF5NDDvIuIcCryMxbbYi8SPYHesBn9Eb31LVWqPjsEwb27Hex1qgvCN1TqBWaB58S
         RMhqzzjA8hV52YlSMgbGc17VpM8YMqYSu2o9SwOMSIVaLmskOcifUvFCrSL2UOgRc9hj
         PBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mH0nCRARtN5+w9TZoOp1Qm7Svfh+hhUeE/MFDUeNtKE=;
        b=XCZBpC75p2by12dU4cI5kOMbEe7anmcYTesxTh72eSy2CEOtEZl9UNVaalo6q8OsO+
         s/+d/SAcjkl09vlwe44ReuBrmY4yBWg49ZxaqFOov3OCZSSou8eId2ZqdgAKL2Qlfq4a
         lZnHdhSSVG7QjLAKEC/sbiFlX0CHnezK3CE9d6470p/Liq1hqlSrDG/3x63c5YdJTF+b
         6wP57HG1Rx7JPLuVI2but98zs9dh/GmdHrk7g3YnyYbCdewJXJe1UQLE4jVWwn2my0Hr
         Qia5iWZCHBldl4jTRJtWFq9IhhZDXHdG4KEjhxTDzn20NzWBSL+7DmfrJORjK0Nw/984
         6cvA==
X-Gm-Message-State: AOAM531rUfFklZK6bGqSK9xgmxtQtPA+H1+LWynj6ICXvg3qdvB2gtOZ
        7H5mBI1rnbNdScyRe0aq/jiNYT/k4xxmDEd4
X-Google-Smtp-Source: ABdhPJzWbp1FlNMLgC2nwwv1yPEv2Ghm8zMc+pNsdjHoxL9151Ff3V+hWSmJoiNosOpXJ1Q2RZMnoQ==
X-Received: by 2002:ac2:4142:: with SMTP id c2mr19717206lfi.125.1617122957748;
        Tue, 30 Mar 2021 09:49:17 -0700 (PDT)
Received: from localhost.localdomain (c-14cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.20])
        by smtp.gmail.com with ESMTPSA id m19sm2839025ljb.10.2021.03.30.09.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:49:17 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] spi: pl022: Convert to use GPIO descriptors
Date:   Tue, 30 Mar 2021 18:49:07 +0200
Message-Id: <20210330164907.2346010-3-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210330164907.2346010-1-linus.walleij@linaro.org>
References: <20210330164907.2346010-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This converts the PL022 driver to use GPIO descriptors
instead of the old global GPIO numberspace. Since the
driver handles messages on its own it needs to manage
the GPIO descriptor directly.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-pl022.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 84ffed2a3554..fda025a5ec06 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -31,7 +31,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/scatterlist.h>
 #include <linux/pm_runtime.h>
-#include <linux/gpio.h>
 #include <linux/of.h>
 #include <linux/pinctrl/consumer.h>
 
@@ -363,7 +362,7 @@ struct vendor_data {
  * @dummypage: a dummy page used for driving data on the bus with DMA
  * @dma_running: indicates whether DMA is in operation
  * @cur_cs: current chip select index
- * @cur_gpio: current chip select GPIO line
+ * @cur_gpiod: current chip select GPIO descriptor
  */
 struct pl022 {
 	struct amba_device		*adev;
@@ -398,7 +397,7 @@ struct pl022 {
 	bool				dma_running;
 #endif
 	int cur_cs;
-	int cur_gpio;
+	struct gpio_desc *cur_gpiod;
 };
 
 /**
@@ -454,8 +453,16 @@ static void pl022_cs_control(struct pl022 *pl022, u32 command)
 {
 	if (pl022->vendor->internal_cs_ctrl)
 		internal_cs_control(pl022, command);
-	else if (gpio_is_valid(pl022->cur_gpio))
-		gpio_set_value(pl022->cur_gpio, command);
+	else if (pl022->cur_gpiod)
+		/*
+		 * This needs to be inverted since with GPIOLIB in
+		 * control, the inversion will be handled by
+		 * GPIOLIB's active low handling. The "command"
+		 * passed into this function will be SSP_CHIP_SELECT
+		 * which is enum:ed to 0, so we need the inverse
+		 * (1) to activate chip select.
+		 */
+		gpiod_set_value(pl022->cur_gpiod, !command);
 }
 
 /**
@@ -1582,7 +1589,7 @@ static int pl022_transfer_one_message(struct spi_master *master,
 	pl022->cur_chip = spi_get_ctldata(msg->spi);
 	pl022->cur_cs = msg->spi->chip_select;
 	/* This is always available but may be set to -ENOENT */
-	pl022->cur_gpio = msg->spi->cs_gpio;
+	pl022->cur_gpiod = msg->spi->cs_gpiod;
 
 	restore_state(pl022);
 	flush(pl022);
@@ -2135,6 +2142,7 @@ static int pl022_probe(struct amba_device *adev, const struct amba_id *id)
 	master->unprepare_transfer_hardware = pl022_unprepare_transfer_hardware;
 	master->rt = platform_info->rt;
 	master->dev.of_node = dev->of_node;
+	master->use_gpio_descriptors = true;
 
 	/*
 	 * Supports mode 0-3, loopback, and active low CS. Transfers are
-- 
2.29.2

