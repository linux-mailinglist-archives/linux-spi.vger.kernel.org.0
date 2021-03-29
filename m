Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3CF34C1A2
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 04:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhC2CAL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Mar 2021 22:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhC2B7u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Mar 2021 21:59:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A95EC0613B3
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 18:59:50 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f17so3658017plr.0
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 18:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b/jZDT68x0JaSsnv/hQubN3XpQ9Z0D2o2MVObC/l6Fo=;
        b=sS489wwLelB1CB5dqgyh7wsTUSVBUtBg0ud34L7zg1rSE4zuKq9rsTChXF0WjHfgYx
         xnSOv2X282S8mYn7IZJg/6eYIGVZ9dubYVudpHyA+ZaL7YwJxZK2Ny03oqS5OBawLxpS
         PiQeu1Dok3KDzEklhvtEC24G39YDFa+JPFHUfbXOwn7nK0CHREyzEbRdb+HQtLSyhl2J
         rgeF2/ez0smsld+3IwHP7eNDeR2DspbavesDBIuSo/oNVx9zRy2MmwYIHoXGUMShcL7X
         6U5NzbaKiStC3MqBZsTDf7Di3QMpfI5dEZ7w5tCF2sBPHqNF+L7A4HUUtMpqIbJBpv1g
         t/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b/jZDT68x0JaSsnv/hQubN3XpQ9Z0D2o2MVObC/l6Fo=;
        b=bwY4HkhNGlgabsX5Qq+4AhHQmq67lJx9O/U+qtqpXXUYzDGBBcRxK8J/ERd9+OoVdq
         rnoT2ttHzuHQ16AU/JhUgkTYo28ZvanPBJyffclqrXpXQuNh4r4CmT8878v5TbPwGHWW
         f5SHje/cJbBmNKJKon8HCrr06Yn1n3O+32siBV/w7F57AfvNgeIdZ/yKPr42lz121rEA
         MQzix6OjFAd4RzQ91wfejmGSoPQYggTjeuoyvR4hoNfgjbUan1LBVDvjUxAMuVn1KqDl
         GAsnWHC87LFHbfhyMffMwbqd8z36xxZrpXGSI+oFrJ0iawIGSTvXAB7Op4bsr7nPx3Z+
         IGCQ==
X-Gm-Message-State: AOAM530teTkr2rNgq6VAsQ70+4qCH06ECv3+bD6hifvmKbZtvqaeSygh
        bPMdcVVTVNtlcYnuRv4hsuIwLw==
X-Google-Smtp-Source: ABdhPJwubq6Oxfs4yJpfSu8/guxn7Yx4XZkdvtnthlj4J2ZbKpHjTyY4E6/naVDgid3eo73k2k/ZTw==
X-Received: by 2002:a17:90b:514:: with SMTP id r20mr24421108pjz.145.1616983189818;
        Sun, 28 Mar 2021 18:59:49 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.18.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 18:59:49 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/13] spi: dw: Add support for Pensando Elba SoC SPI
Date:   Sun, 28 Mar 2021 18:59:28 -0700
Message-Id: <20210329015938.20316-4-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Pensando Elba SoC uses a GPIO based chip select
for two DW SPI busses with each bus having two
chip selects.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 drivers/spi/spi-dw-mmio.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 17c06039a74d..c323a5ceecb8 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -56,7 +56,7 @@ struct dw_spi_mscc {
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
- * selects then needs to be either driven as GPIOs or, for the first 4 using the
+ * selects then needs to be either driven as GPIOs or, for the first 4 using
  * the SPI boot controller registers. the final chip select is an OR gate
  * between the Designware SPI controller and the SPI boot controller.
  */
@@ -237,6 +237,31 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 	return 0;
 }
 
+static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+
+	if (!enable) {
+		/*
+		 * Using a GPIO-based chip-select, the DW SPI
+		 * controller still needs its own CS bit selected
+		 * to start the serial engine.  On Elba the specific
+		 * CS doesn't matter to start the serial engine,
+		 * so using CS0.
+		 */
+		dw_writel(dws, DW_SPI_SER, BIT(0));
+	} else {
+		dw_writel(dws, DW_SPI_SER, 0);
+	}
+}
+
+static int dw_spi_elba_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -351,6 +376,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "pensando,elba-spi", .data = dw_spi_elba_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

