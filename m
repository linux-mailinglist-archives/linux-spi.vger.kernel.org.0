Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCAF3A751D
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 05:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhFODav (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Jun 2021 23:30:51 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:47754 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhFODav (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Jun 2021 23:30:51 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 918F6CD7E3;
        Tue, 15 Jun 2021 11:28:45 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P4790T140158307387136S1623727723794355_;
        Tue, 15 Jun 2021 11:28:45 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c787dad81d98a5edeae1faa79fa65680>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-RCPT-COUNT: 9
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     jon.lin@rock-chips.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 5/6] spi: rockchip: Support cs-gpio
Date:   Tue, 15 Jun 2021 11:28:41 +0800
Message-Id: <20210615032842.25529-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

1.Add standard cs-gpio support
2.Refer to spi-controller.yaml for details

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None

 drivers/spi/spi-rockchip.c | 61 ++++++++++++++++++++++++++++++++++----
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 950d3bce443b..48b666d42d8a 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -6,6 +6,7 @@
 
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
+#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -157,7 +158,8 @@
  */
 #define ROCKCHIP_SPI_MAX_TRANLEN		0xffff
 
-#define ROCKCHIP_SPI_MAX_CS_NUM			2
+/* 2 for native cs, 2 for cs-gpio */
+#define ROCKCHIP_SPI_MAX_CS_NUM			4
 #define ROCKCHIP_SPI_VER2_TYPE1			0x05EC0002
 #define ROCKCHIP_SPI_VER2_TYPE2			0x00110002
 
@@ -191,6 +193,7 @@ struct rockchip_spi {
 	bool cs_asserted[ROCKCHIP_SPI_MAX_CS_NUM];
 
 	bool slave_abort;
+	bool gpio_requested;
 };
 
 static inline void spi_enable_chip(struct rockchip_spi *rs, bool enable)
@@ -245,11 +248,15 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
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
@@ -632,6 +639,47 @@ static bool rockchip_spi_can_dma(struct spi_controller *ctlr,
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
@@ -706,6 +754,7 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 
 	rs->dev = &pdev->dev;
 	rs->freq = clk_get_rate(rs->spiclk);
+	rs->gpio_requested = false;
 
 	if (!of_property_read_u32(pdev->dev.of_node, "rx-sample-delay-ns",
 				  &rsd_nsecs)) {
@@ -759,6 +808,8 @@ static int rockchip_spi_probe(struct platform_device *pdev)
 	ctlr->max_speed_hz = min(rs->freq / BAUDR_SCKDV_MIN, MAX_SCLK_OUT);
 
 	ctlr->set_cs = rockchip_spi_set_cs;
+	ctlr->setup = rockchip_spi_setup;
+	ctlr->cleanup = rockchip_spi_cleanup;
 	ctlr->transfer_one = rockchip_spi_transfer_one;
 	ctlr->max_transfer_size = rockchip_spi_max_transfer_size;
 	ctlr->handle_err = rockchip_spi_handle_err;
-- 
2.17.1



