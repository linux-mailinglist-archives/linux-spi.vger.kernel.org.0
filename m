Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF1C4931A1
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jan 2022 01:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbiASAL0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Jan 2022 19:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239681AbiASALZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Jan 2022 19:11:25 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D479C061574
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 16:11:25 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x7so2039810lfu.8
        for <linux-spi@vger.kernel.org>; Tue, 18 Jan 2022 16:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQNLdFHHBX2gtLrQAh3GDLQFXzBzm3gqPlwcQRBR/hg=;
        b=QAh5Zb1k1TBZQPoBF8po/j3kG+rPsVnFviAb/di4iUZJ19sVS0bLDqSIjXWbzZbUb6
         zVrS4fy5pQkt6hFspGLgLKVDTXfYpgK+amK2M/mQpBCreW3eIT4WgZ9mFAY/3jtxqbAi
         fqi95GCSgll667YY+3aI6As2ExkbETz5Dd7fe5mjJosNRQN1Q9+rJIbQMS1zH08L02zk
         4gMcsrDh9rDtHciJNe1jdnDn0ShalPLEZVuffTJDfRPdfpl2Theuj+OQYhobFfK85CJ8
         mkkxuL6HWU/uflJTgv7W2wu9Nu9SnzmizqSjH2DQVxqyeNN9TSW3aEiDK9WHSOfBA2Rv
         7xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TQNLdFHHBX2gtLrQAh3GDLQFXzBzm3gqPlwcQRBR/hg=;
        b=nqErT0JzIiVAPQT/KLwbYhivcPmRDTw/+kJs+6PwPzaK/0yiB6zoOpeHwM+7b4jdqw
         dGhq91ytBxw7eXmZb9kEU7E/9xEzX2Kch+zqx5m19g2gkJyCZ4TUsDfNKQ8CmI3Mo2pZ
         Lqq1cmXsZDKun7elIQK3omHbKp28LmezW+HDYunvBFsO51FbDDBqalWlBGOGUMOayBet
         tIYmqZN+O05yCxJvRomLObQjDftyvmc0hiBCNrvkzUNIFs05FsIrP6X9Ag1fKbvF/5r2
         MZjgMF3OyYtF4bVbK8AawzIFafORevaH0p1iMvCRpwPkotblqAo3AOlaVQxEscPOc6EY
         wLpQ==
X-Gm-Message-State: AOAM530jIfk5U8PGYTtqLXySp+dNg3fQi/Rio+pwDxroPmGeC651Zimr
        lR4H72gxpLzBELY7wDn3QPePdg==
X-Google-Smtp-Source: ABdhPJwQ/tWfJvOR4+D/D2awo2qzbFMRhYpJ6kc8w6IcrxsWtanWVpYPe50o9lhDeLojm5oL3Bqwlw==
X-Received: by 2002:ac2:4c41:: with SMTP id o1mr24505700lfk.545.1642551083555;
        Tue, 18 Jan 2022 16:11:23 -0800 (PST)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id w16sm1728602ljh.122.2022.01.18.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 16:11:22 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [PATCH] spi: s3c24xx: Convert to GPIO descriptors
Date:   Wed, 19 Jan 2022 01:09:14 +0100
Message-Id: <20220119000914.192553-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver has a bunch of custom oldstyle GPIO number-passing
fields and a custom set-up callback.

The good thing is: nothing in the kernel is using it.

Convert the driver to use GPIO descriptors with a SPI_MASTER_GPIO_SS
flag so that the local CS callback also get invoked as the hardware
needs this.

New users of this driver can provide GPIO descriptor tables like
the other converted drivers.

Cc: linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/spi/spi-s3c24xx.c   | 47 +++----------------------------------
 include/linux/spi/s3c24xx.h |  5 ----
 2 files changed, 3 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/spi-s3c24xx.c b/drivers/spi/spi-s3c24xx.c
index d6f51695ca5b..660aa866af06 100644
--- a/drivers/spi/spi-s3c24xx.c
+++ b/drivers/spi/spi-s3c24xx.c
@@ -12,7 +12,6 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
@@ -62,9 +61,6 @@ struct s3c24xx_spi {
 	unsigned char		 fiq_inuse;
 	unsigned char		 fiq_claimed;
 
-	void			(*set_cs)(struct s3c2410_spi_info *spi,
-					  int cs, int pol);
-
 	/* data buffers */
 	const unsigned char	*tx;
 	unsigned char		*rx;
@@ -84,29 +80,21 @@ static inline struct s3c24xx_spi *to_hw(struct spi_device *sdev)
 	return spi_master_get_devdata(sdev->master);
 }
 
-static void s3c24xx_spi_gpiocs(struct s3c2410_spi_info *spi, int cs, int pol)
-{
-	gpio_set_value(spi->pin_cs, pol);
-}
-
 static void s3c24xx_spi_chipsel(struct spi_device *spi, int value)
 {
 	struct s3c24xx_spi_devstate *cs = spi->controller_state;
 	struct s3c24xx_spi *hw = to_hw(spi);
-	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
 
 	/* change the chipselect state and the state of the spi engine clock */
 
 	switch (value) {
 	case BITBANG_CS_INACTIVE:
-		hw->set_cs(hw->pdata, spi->chip_select, cspol^1);
 		writeb(cs->spcon, hw->regs + S3C2410_SPCON);
 		break;
 
 	case BITBANG_CS_ACTIVE:
 		writeb(cs->spcon | S3C2410_SPCON_ENSCK,
 		       hw->regs + S3C2410_SPCON);
-		hw->set_cs(hw->pdata, spi->chip_select, cspol);
 		break;
 	}
 }
@@ -452,14 +440,6 @@ static void s3c24xx_spi_initialsetup(struct s3c24xx_spi *hw)
 	writeb(0xff, hw->regs + S3C2410_SPPRE);
 	writeb(SPPIN_DEFAULT, hw->regs + S3C2410_SPPIN);
 	writeb(SPCON_DEFAULT, hw->regs + S3C2410_SPCON);
-
-	if (hw->pdata) {
-		if (hw->set_cs == s3c24xx_spi_gpiocs)
-			gpio_direction_output(hw->pdata->pin_cs, 1);
-
-		if (hw->pdata->gpio_setup)
-			hw->pdata->gpio_setup(hw->pdata, 1);
-	}
 }
 
 static int s3c24xx_spi_probe(struct platform_device *pdev)
@@ -502,6 +482,9 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 	master->num_chipselect = hw->pdata->num_cs;
 	master->bus_num = pdata->bus_num;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	/* we need to call the local chipselect callback */
+	master->flags = SPI_MASTER_GPIO_SS;
+	master->use_gpio_descriptors = true;
 
 	/* setup the state for the bitbang driver */
 
@@ -541,27 +524,6 @@ static int s3c24xx_spi_probe(struct platform_device *pdev)
 		goto err_no_pdata;
 	}
 
-	/* setup any gpio we can */
-
-	if (!pdata->set_cs) {
-		if (pdata->pin_cs < 0) {
-			dev_err(&pdev->dev, "No chipselect pin\n");
-			err = -EINVAL;
-			goto err_register;
-		}
-
-		err = devm_gpio_request(&pdev->dev, pdata->pin_cs,
-					dev_name(&pdev->dev));
-		if (err) {
-			dev_err(&pdev->dev, "Failed to get gpio for cs\n");
-			goto err_register;
-		}
-
-		hw->set_cs = s3c24xx_spi_gpiocs;
-		gpio_direction_output(pdata->pin_cs, 1);
-	} else
-		hw->set_cs = pdata->set_cs;
-
 	s3c24xx_spi_initialsetup(hw);
 
 	/* register our spi controller */
@@ -604,9 +566,6 @@ static int s3c24xx_spi_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (hw->pdata && hw->pdata->gpio_setup)
-		hw->pdata->gpio_setup(hw->pdata, 0);
-
 	clk_disable(hw->clk);
 	return 0;
 }
diff --git a/include/linux/spi/s3c24xx.h b/include/linux/spi/s3c24xx.h
index 440a71593162..9b8bb22d5b0c 100644
--- a/include/linux/spi/s3c24xx.h
+++ b/include/linux/spi/s3c24xx.h
@@ -10,14 +10,9 @@
 #define __LINUX_SPI_S3C24XX_H __FILE__
 
 struct s3c2410_spi_info {
-	int			 pin_cs;	/* simple gpio cs */
 	unsigned int		 num_cs;	/* total chipselects */
 	int			 bus_num;       /* bus number to use. */
-
 	unsigned int		 use_fiq:1;	/* use fiq */
-
-	void (*gpio_setup)(struct s3c2410_spi_info *spi, int enable);
-	void (*set_cs)(struct s3c2410_spi_info *spi, int cs, int pol);
 };
 
 extern int s3c24xx_set_fiq(unsigned int irq, u32 *ack_ptr, bool on);
-- 
2.34.1

