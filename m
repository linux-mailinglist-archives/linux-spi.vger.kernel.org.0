Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89E560DCA8
	for <lists+linux-spi@lfdr.de>; Wed, 26 Oct 2022 09:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJZH6g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Oct 2022 03:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiJZH6f (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Oct 2022 03:58:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917CDA98FD
        for <linux-spi@vger.kernel.org>; Wed, 26 Oct 2022 00:58:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so943623wmb.3
        for <linux-spi@vger.kernel.org>; Wed, 26 Oct 2022 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+jyjrbZo+ELkTQHp1UO8qB1tgFnSatDzGs6yA5dAalk=;
        b=D+lIzuFmmhNmptsvaY8BGQUNGKXCtzv9MHCJaBqvK9nBESL8oazEgpAqhXJVAJywpB
         i0qxXytK2Dwz3lYx3b2byIBa7MjTi4+3R/V3Jt+8aDopFCPUPRQVDBddysrWAA0Phax+
         GsYYY4ORqfBeJ0gh58fwYn4mOe9jZKXpaONekw+G4azlTm6jgFc3k+AqCucxptEumHuc
         liQt7PiNML/sEXGIyXfUbanAFC9/tbEOA3DkJTRlKddeRB5fVya50nxVvbfV6LinPlC1
         h3/iWju6Wi1Po0962nuxTwR6MKDELIciU2qzNQA7vRW34v/ASomx6+uoD/vRzRiOITSX
         RO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jyjrbZo+ELkTQHp1UO8qB1tgFnSatDzGs6yA5dAalk=;
        b=alWwPx5u2X2U12iHjrE2l2dVVyE/K4FO0h/i0xPN/byxnSl01Mf7HQtqXOCVqxXB4S
         i4D33+8eX1/0GaJS/6BW+RJxBqkue38j+TAHn1NM7fGYEnZi01LddWnmg0QKPwJpHwVM
         AJd5Fd6a4gBfz1oSuR65GVuiUhGBpSBlR1IDsy3UrbvbkLw02IFkIzYEa5WQyzjZxQR8
         Vl/y0oWJzfLfdxUXvmE7TLXz0n0N5HuvpumIWzaEXggflAYiBtw81Az64clPd4h5UX9R
         eOZj6ZvjwafjtwN0/KYA9jcHtLdKd8+rDXEkDNPNh522zga73S/Ci4Zrna8a6X2Q0XHa
         WgRQ==
X-Gm-Message-State: ACrzQf3EUzGi9CjbIFcLU1oqJo/RIKIiCHLxQohwXVtLFcASK45AR1qk
        YC/Ca7iNKPNYDwtLyswyrBgZf/oMF2LY2/Fb
X-Google-Smtp-Source: AMsMyM6biL997EUrBv+5AmVPUHlDggoRWcpPcDDG67spwOF+g8th63MEzdahrujErNWbC8OUcQgQOw==
X-Received: by 2002:a05:600c:1e28:b0:3c6:e046:9da7 with SMTP id ay40-20020a05600c1e2800b003c6e0469da7mr1497424wmb.43.1666771113122;
        Wed, 26 Oct 2022 00:58:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6e81000000b0022cc3e67fc5sm4562593wrz.65.2022.10.26.00.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 00:58:32 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 26 Oct 2022 09:58:28 +0200
Subject: [PATCH] spi: meson-spicc: move wait completion in driver to take
 bursts delay in account
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221026-spicc-burst-delay-v1-0-1be5ffb7051a@linaro.org>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mark Brown <broonie@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org, Da Xue <da@libre.computer>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-spi@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some delay occurs between each bursts, thus the default delay is wrong
and a timeout will occur with big enough transfers.

The solution is to handle the timeout management in the driver and
add some delay for each bursts in the timeout calculation.

Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
To: Mark Brown <broonie@kernel.org>
To: Kevin Hilman <khilman@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-meson-spicc.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index bad201510a99..52bffab18329 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -160,6 +160,7 @@ struct meson_spicc_device {
 	struct clk			*clk;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
+	struct completion		done;
 	const struct meson_spicc_data	*data;
 	u8				*tx_buf;
 	u8				*rx_buf;
@@ -282,7 +283,7 @@ static irqreturn_t meson_spicc_irq(int irq, void *data)
 		/* Disable all IRQs */
 		writel(0, spicc->base + SPICC_INTREG);
 
-		spi_finalize_current_transfer(spicc->master);
+		complete(&spicc->done);
 
 		return IRQ_HANDLED;
 	}
@@ -386,6 +387,7 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 				    struct spi_transfer *xfer)
 {
 	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
+	unsigned long timeout;
 
 	/* Store current transfer */
 	spicc->xfer = xfer;
@@ -410,13 +412,29 @@ static int meson_spicc_transfer_one(struct spi_master *master,
 	/* Setup burst */
 	meson_spicc_setup_burst(spicc);
 
+	/* Setup wait for completion */
+	reinit_completion(&spicc->done);
+
+	/* For each byte we wait for 8 cycles of the SPI clock */
+	timeout = 8LL * MSEC_PER_SEC * xfer->len;
+	do_div(timeout, xfer->speed_hz);
+
+	/* Add 10us delay between each fifo bursts */
+	timeout += ((xfer->len >> 4) * 10) / MSEC_PER_SEC;
+
+	/* Increase it twice and add 200 ms tolerance */
+	timeout += timeout + 200;
+
 	/* Start burst */
 	writel_bits_relaxed(SPICC_XCH, SPICC_XCH, spicc->base + SPICC_CONREG);
 
 	/* Enable interrupts */
 	writel_relaxed(SPICC_TC_EN, spicc->base + SPICC_INTREG);
 
-	return 1;
+	if (!wait_for_completion_timeout(&spicc->done, msecs_to_jiffies(timeout)))
+		return -ETIMEDOUT;
+
+	return 0;
 }
 
 static int meson_spicc_prepare_message(struct spi_master *master,
@@ -743,6 +761,8 @@ static int meson_spicc_probe(struct platform_device *pdev)
 	spicc->pdev = pdev;
 	platform_set_drvdata(pdev, spicc);
 
+	init_completion(&spicc->done);
+
 	spicc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spicc->base)) {
 		dev_err(&pdev->dev, "io resource mapping failed\n");

---
base-commit: 247f34f7b80357943234f93f247a1ae6b6c3a740
change-id: 20221026-spicc-burst-delay-ea0526602760

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
