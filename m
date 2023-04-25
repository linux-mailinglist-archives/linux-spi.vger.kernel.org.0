Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FEB6EE367
	for <lists+linux-spi@lfdr.de>; Tue, 25 Apr 2023 15:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjDYNpu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Apr 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234278AbjDYNpl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Apr 2023 09:45:41 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532413FB3
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 06:45:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-506767f97f8so10006495a12.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Apr 2023 06:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1682430336; x=1685022336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al0zqUJCRs8AI5Sc47A1KMBnQC63vKqupk6DIofDhiM=;
        b=ITM1rBhaC1OkA8L7qspcDJ8xbkZrOsaT0dCfP5BjuAZtPW6BBgMTvTknoRUzcp9oGq
         tRqmd/cXl4V2QIGzwRFD4JMcMxoOdclL3ggk62TG+Qpvg2hU/UqbKiEhRvzwvrY82/G/
         ekhBg3pKTFerlph1uFfJZDo9PptMNJ6QMRbtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430336; x=1685022336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Al0zqUJCRs8AI5Sc47A1KMBnQC63vKqupk6DIofDhiM=;
        b=YJIN/f+UDcm4lbdYJlyDDMWbEYtJQT24S5In5xh/6IyjGPxtkKaie66FEhy05qk0mj
         BHT8qqrm9rY9a304hcIFVv9eRDgnPptPgt3jBYJ6dNN4mvGL6XBpr0kvJwbi89+81iCU
         c2ykFRDmzBEHE25r1BeIPQlE0YDnoUzHYoATcknn/3on4hPmPXCUnMl7NYzs9cfc4Pwv
         Oy6Fp2pg4tXDNWcVU9nS1bwsGlocheVtsujT6bDRaFr8NBOquQOiD7qnrFEybfMyBVvp
         q5Qc2CHN1ADjPM0KGrNebyy9VuhPKdv23vOc0GnJ2UWEAe9g6wjeEcKqP3KuuzwcpJh2
         WAWA==
X-Gm-Message-State: AAQBX9cxPW07UebTGs2TUwMAC/O+yEbVT9vtILY5a6CKFsapvUhuHvLD
        XtdvzVUOnOGNBkNhJKD2jZ2IHA==
X-Google-Smtp-Source: AKy350aKN7c3TBlSHw8bGq2LBpYoNswxL+Q4j51QbggX6/tE0dIImeRVxwOgA/3I0vsBbihspOdvSg==
X-Received: by 2002:a17:906:8a44:b0:94f:553:6fd6 with SMTP id gx4-20020a1709068a4400b0094f05536fd6mr13433197ejc.24.1682430335987;
        Tue, 25 Apr 2023 06:45:35 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id f10-20020a170906048a00b0094eeea5c649sm6806822eja.114.2023.04.25.06.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 06:45:35 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: spi-imx: fix use of more than four chipselects
Date:   Tue, 25 Apr 2023 15:45:27 +0200
Message-Id: <20230425134527.483607-4-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
References: <20230425134527.483607-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently, the spi->chip_select is used unconditionally in code such as

	/* set chip select to use */
	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);

and

	if (spi->mode & SPI_CPHA)
		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
	else
		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);

with these macros being

	#define MX51_ECSPI_CTRL_CS(cs)          ((cs) << 18)
	#define MX51_ECSPI_CONFIG_SCLKPHA(cs)   (1 << ((cs) +  0))

However, the CHANNEL_SELECT field in the control register is only two
bits wide, so when spi->chip_select >= 4, we end up writing garbage
into the BURST_LENGTH field. Similarly, there are only four bits in
the SCLK_PHA field, so the code above ends up actually modifying bits
in the SCLK_POL (or higher) field.

The scrambling of the BURST_LENGTH field itself is probably benign,
since that is explicitly completely initialized later, in
->prepare_transfer.

But, since we effectively write (spi->chip_select & 3) into the
CHANNEL_SELECT field, that value is what the IP block then uses to
determine which bits of the configuration register control phase,
polarity etc., and those bits are not properly initialized, so
communication with the spi device completely fails.

Fix this by using the ->unused_native_cs value as channel number for
any spi device which uses a gpio as chip select.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/spi/spi-imx.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index e8f7afbd9847..569a5132f324 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -504,6 +504,13 @@ static void mx51_ecspi_disable(struct spi_imx_data *spi_imx)
 	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 }
 
+static int mx51_ecspi_channel(const struct spi_device *spi)
+{
+	if (!spi->cs_gpiod)
+		return spi->chip_select;
+	return spi->controller->unused_native_cs;
+}
+
 static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 				      struct spi_message *msg)
 {
@@ -514,6 +521,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	u32 testreg, delay;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 	u32 current_cfg = cfg;
+	int channel = mx51_ecspi_channel(spi);
 
 	/* set Master or Slave mode */
 	if (spi_imx->slave_mode)
@@ -528,7 +536,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 		ctrl |= MX51_ECSPI_CTRL_DRCTL(spi_imx->spi_drctl);
 
 	/* set chip select to use */
-	ctrl |= MX51_ECSPI_CTRL_CS(spi->chip_select);
+	ctrl |= MX51_ECSPI_CTRL_CS(channel);
 
 	/*
 	 * The ctrl register must be written first, with the EN bit set other
@@ -549,22 +557,22 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	 * BURST_LENGTH + 1 bits are received
 	 */
 	if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
-		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SBBCTRL(channel);
 	else
-		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SBBCTRL(channel);
 
 	if (spi->mode & SPI_CPOL) {
-		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
-		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPOL(channel);
+		cfg |= MX51_ECSPI_CONFIG_SCLKCTL(channel);
 	} else {
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(spi->chip_select);
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPOL(channel);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKCTL(channel);
 	}
 
 	if (spi->mode & SPI_CS_HIGH)
-		cfg |= MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SSBPOL(channel);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(channel);
 
 	if (cfg == current_cfg)
 		return 0;
@@ -609,14 +617,15 @@ static void mx51_configure_cpha(struct spi_imx_data *spi_imx,
 	bool cpha = (spi->mode & SPI_CPHA);
 	bool flip_cpha = (spi->mode & SPI_RX_CPHA_FLIP) && spi_imx->rx_only;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
+	int channel = mx51_ecspi_channel(spi);
 
 	/* Flip cpha logical value iff flip_cpha */
 	cpha ^= flip_cpha;
 
 	if (cpha)
-		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
+		cfg |= MX51_ECSPI_CONFIG_SCLKPHA(channel);
 	else
-		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(spi->chip_select);
+		cfg &= ~MX51_ECSPI_CONFIG_SCLKPHA(channel);
 
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 }
-- 
2.37.2

