Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4DD368EFE
	for <lists+linux-spi@lfdr.de>; Fri, 23 Apr 2021 10:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbhDWIm4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Apr 2021 04:42:56 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:57866 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhDWIm4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Apr 2021 04:42:56 -0400
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id 9AB6BA957C;
        Fri, 23 Apr 2021 16:42:17 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31919T139684386649856S1619167319885662_;
        Fri, 23 Apr 2021 16:42:16 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7bc9b3c8e116ea9d2c712862b486dda5>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 8
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@esmil.dk, Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v1 3/8] spi: rockchip: Support cs-gpio
Date:   Fri, 23 Apr 2021 16:41:50 +0800
Message-Id: <20210423084155.17439-3-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423084155.17439-1-jon.lin@rock-chips.com>
References: <20210423084155.17439-1-jon.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

1.Add standard cs-gpio support
2.Refer to spi-controller.yaml for details

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---
 drivers/spi/spi-rockchip.c | 61 ++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index dae0281f6ba8..bb9d137b6f7f 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -156,7 +157,8 @@
  */
 #define ROCKCHIP_SPI_MAX_TRANLEN		0xffff
 
-#define ROCKCHIP_SPI_MAX_CS_NUM			2
+/* 2 for native cs, 2 for cs-gpio */
+#define ROCKCHIP_SPI_MAX_CS_NUM			4
 #define ROCKCHIP_SPI_VER2_TYPE1			0x05EC0002
 #define ROCKCHIP_SPI_VER2_TYPE2			0x00110002
 
@@ -190,6 +192,7 @@ struct rockchip_spi {
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool slave_abort;
+	bool gpio_requested;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -238,11 +241,15 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 		/* Keep things powered as long as CS is asserted */
 		pm_runtime_get_sync(rs->dev);
 
-		ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER,
-				      BIT(spi->chip_select));
+		if (gpio_is_valid(spi->cs_gpio))
+			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
+		else
+			ROCKCHIP_SPI_SET_BITS(rs->regs + ROCKCHIP_SPI_SER, BIT(spi->chip_select));
 	} else {
-		ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER,
-				      BIT(spi->chip_select));
+		if (gpio_is_valid(spi->cs_gpio))
+			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER, 1);
+		else
+			ROCKCHIP_SPI_CLR_BITS(rs->regs + ROCKCHIP_SPI_SER, BIT(spi->chip_select));
 
 		/* Drop reference from when we first asserted CS */
 		pm_runtime_put(rs->dev);
@@ -625,6 +632,47 @@ static bool rockchip_spi_can_dma(struct spi_controller *ctlr,
 	return xfer->len / bytes_per_word >= rs->fifo_len;
 }
 
+static int rockchip_spi_setup(struct spi_device *spi)
+{
+
+	int ret = -EINVAL;
+	struct rockchip_spi *rs = spi_controller_get_devdata(spi->controller);
+
+	if (spi->cs_gpio == -ENOENT)
+		return 0;
+
+	if (!rs->gpio_requested && gpio_is_valid(spi->cs_gpio)) {
+		ret = gpio_request_one(spi->cs_gpio,
+				       (spi->mode & SPI_CS_HIGH) ?
+				       GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH,
+				       dev_name(&spi->dev));
+		if (ret)
+			dev_err(&spi->dev, "can't request chipselect gpio %d\n",
+				spi->cs_gpio);
+		else
+			rs->gpio_requested = true;
+	} else {
+		if (gpio_is_valid(spi->cs_gpio)) {
+			int mode = ((spi->mode & SPI_CS_HIGH) ? 0 : 1);
+
+			ret = gpio_direction_output(spi->cs_gpio, mode);
+			if (ret)
+				dev_err(&spi->dev, "chipselect gpio %d setup failed (%d)\n",
+					spi->cs_gpio, ret);
+		}
+	}
+
+	return ret;
+}
+
+static void rockchip_spi_cleanup(struct spi_device *spi)
+{
+	struct rockchip_spi *rs = spi_controller_get_devdata(spi->controller);
+
+	if (rs->gpio_requested)
+		gpio_free(spi->cs_gpio);
+}
+
 static int rockchip_spi_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -699,6 +747,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	rs->dev = &pdev->dev;
 	rs->freq = clk_get_rate(rs->spiclk);
+	rs->gpio_requested = false;
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
 				  &rsd_nsecs)) {
@@ -752,6 +801,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
 	ctlr->set_cs = rockchip_spi_set_cs;
+	ctlr->setup = rockchip_spi_setup;
+	ctlr->cleanup = rockchip_spi_cleanup;
 	ctlr->transfer_one = rockchip_spi_transfer_one;
 	ctlr->max_transfer_size = rockchip_spi_max_transfer_size;
 	ctlr->handle_err = rockchip_spi_handle_err;
-- 
2.17.1



