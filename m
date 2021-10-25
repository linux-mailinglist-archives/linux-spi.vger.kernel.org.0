Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDC4438D4B
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 03:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhJYBzH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 24 Oct 2021 21:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbhJYByw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 24 Oct 2021 21:54:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0C2C061228
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t5-20020a17090a4e4500b001a0a284fcc2so10183267pjl.2
        for <linux-spi@vger.kernel.org>; Sun, 24 Oct 2021 18:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vsR/M9bOl6aFtC618kIrvoIuoSpbyCAFbP6PAJah3XI=;
        b=pwYextADWeXL9URjAkMESH00j+LgXSgEd++y1ajHLT5tnwFvcFuIDrKsyAuPLcHgda
         GcLNofPt+oYBbKe0P3pZETURkIZSEjeL7J/BX284tAN5X6Q8mZruiRQQvhJJE3oYlEr/
         NWx54hk0Bb7e/X7LVISwxn/4CilI23VENrNukc5nx9yrb2Jpw5XLhsAlWNZSN6Rop53W
         4nH2eFUTNiBueDNTLAAfSTDKn9uBIXtsmGlsgiu04mm3MdBO1EJnYI+2XzItYtFngYa0
         ypeQnGKshZkhMz6TCDMUMfTylO8b4RNH0VfRFhuaVIkhFQDkWnJVRJRVbAT19T569/Pe
         BByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vsR/M9bOl6aFtC618kIrvoIuoSpbyCAFbP6PAJah3XI=;
        b=tsH94HwsZa7LybWZe6JQ40Xoa8Isc55Rw+RPyZCqzPxFzGQ7+BOpCW+a5urvW0KMhQ
         vKJHT+cbPZ2lzy+5p5bl5hRZi1Gk7fXDgTShJgMQeae7q8J5q6btD6WCARBGpRt7G9IT
         soh68ZSk0gY8iUB4UcCRG8wX8LrfmwEXcYNuiku/1sJmBrgNdf0cQYc/bgB7z5TDQF/n
         mJA8sUIJ5J4U+WW9Qzja/hw2KjVLbdL4qjTCBmBbXOA3chBtV90MzGID4s3ILhSLSrZ5
         xY6PB6Xt0kcT/m7zGkkGqrlP+xsIYfZhEOmeZRDUoJp+BhjUNVgZTzWggfDu9SszcCOv
         P9hg==
X-Gm-Message-State: AOAM530YXYYQhag3LvILcCpOhFYGiNOiocDiSavLI7yiiig9xJWWEhsY
        tSZzzx0fm+D1njCUSibaUZchiQ==
X-Google-Smtp-Source: ABdhPJxzvx/6bddBkDWc5mWCp54BWux4olcKgy+pw/B52+qaLqETrpKtiMSRxc3XqIzgWYnnHqB6Ow==
X-Received: by 2002:a17:90b:1b0b:: with SMTP id nu11mr16473857pjb.103.1635126747504;
        Sun, 24 Oct 2021 18:52:27 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id q10sm14855225pgn.31.2021.10.24.18.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 18:52:27 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/11] spi: dw: Add support for Pensando Elba SoC
Date:   Sun, 24 Oct 2021 18:51:55 -0700
Message-Id: <20211025015156.33133-11-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025015156.33133-1-brad@pensando.io>
References: <20211025015156.33133-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Pensando Elba SoC includes a DW apb_ssi v4 controller
with device specific chip-select control.  The Elba SoC
provides four chip-selects where the native DW IP supports
two chip-selects.

Signed-off-by: Brad Larson <brad@pensando.io>
---
Changelog:
- Changed the implementation to use existing dw_spi_set_cs() and
  integrated Elba specific CS control into spi-dw-mmio.c.  The
  native designware support is for two chip-selects while Elba
  provides 4 chip-selects.  Instead of adding a new file for
  this support in gpio-elba-spics.c the support is in one
  file (spi-dw-mmio.c).

 drivers/spi/spi-dw-mmio.c | 85 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 3379720cfcb8..fe7b595fe33d 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -53,6 +53,24 @@ struct dw_spi_mscc {
 	void __iomem        *spi_mst; /* Not sparx5 */
 };
 
+struct dw_spi_elba {
+	struct regmap *regmap;
+	unsigned int reg;
+};
+
+/*
+ * Elba SoC does not use ssi, pin override is used for cs 0,1 and
+ * gpios for cs 2,3 as defined in the device tree.
+ *
+ * cs:  |       1               0
+ * bit: |---3-------2-------1-------0
+ *      |  cs1   cs1_ovr   cs0   cs0_ovr
+ */
+#define ELBA_SPICS_SHIFT(cs)		(2 * (cs))
+#define ELBA_SPICS_MASK(cs)		(0x3 << ELBA_SPICS_SHIFT(cs))
+#define ELBA_SPICS_SET(cs, val)	\
+			((((val) << 1) | 0x1) << ELBA_SPICS_SHIFT(cs))
+
 /*
  * The Designware SPI controller (referred to as master in the documentation)
  * automatically deasserts chip select when the tx fifo is empty. The chip
@@ -237,6 +255,72 @@ static int dw_spi_canaan_k210_init(struct platform_device *pdev,
 	return 0;
 }
 
+static void elba_spics_set_cs(struct dw_spi_elba *dwselba, int cs, int enable)
+{
+	regmap_update_bits(dwselba->regmap, dwselba->reg, ELBA_SPICS_MASK(cs),
+			   ELBA_SPICS_SET(cs, enable));
+}
+
+static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
+{
+	struct dw_spi *dws = spi_master_get_devdata(spi->master);
+	struct dw_spi_mmio *dwsmmio = container_of(dws, struct dw_spi_mmio, dws);
+	struct dw_spi_elba *dwselba = dwsmmio->priv;
+	u8 cs = spi->chip_select;
+
+	if (cs < 2) {
+		/* overridden native chip-select */
+		elba_spics_set_cs(dwselba, spi->chip_select, enable);
+	}
+
+	/*
+	 * The DW SPI controller needs a native CS bit selected to start
+	 * the serial engine, and we have fewer native CSs than we need, so
+	 * use CS0 always.
+	 */
+	spi->chip_select = 0;
+	dw_spi_set_cs(spi, enable);
+	spi->chip_select = cs;
+}
+
+static int dw_spi_elba_init(struct platform_device *pdev,
+			    struct dw_spi_mmio *dwsmmio)
+{
+	struct of_phandle_args args;
+	struct dw_spi_elba *dwselba;
+	struct regmap *regmap;
+	int rc;
+
+	rc = of_parse_phandle_with_fixed_args(pdev->dev.of_node,
+			"pensando,spics", 1, 0, &args);
+	if (rc) {
+		dev_err(&pdev->dev, "could not find pensando,spics\n");
+		return rc;
+	}
+
+	regmap = syscon_node_to_regmap(args.np);
+	if (IS_ERR(regmap)) {
+		dev_err(&pdev->dev, "could not map pensando,spics\n");
+		return PTR_ERR(regmap);
+	}
+
+	dwselba = devm_kzalloc(&pdev->dev, sizeof(*dwselba), GFP_KERNEL);
+	if (!dwselba)
+		return -ENOMEM;
+
+	dwselba->regmap = regmap;
+	dwselba->reg = args.args[0];
+
+	/* deassert cs */
+	elba_spics_set_cs(dwselba, 0, 1);
+	elba_spics_set_cs(dwselba, 1, 1);
+
+	dwsmmio->priv = dwselba;
+	dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -351,6 +435,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
 	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
+	{ .compatible = "pensando,elba-spi", .data = dw_spi_elba_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.17.1

