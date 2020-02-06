Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B107154071
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 09:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgBFIjM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 03:39:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33786 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgBFIjM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 03:39:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so2750730pfn.0;
        Thu, 06 Feb 2020 00:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UWdyHtqZK8vfIndcfQvcNNS3B5v8ddPMxqJbmaARG9A=;
        b=SQO7vAPqbBVhflnputkicBEm+DbEkUUAMNg4olOuMJQsZMvPKtojV7+maUCk1LbGMy
         Psr3iqnilYElodyQL8YqQ/XzHHfG3+QZaYmPKq48B1fFpjXSqjrtqkqnvHGLOqIURN06
         gKEsFOqMw2iBCijs7IF162+KxEzxp/d6dhiX4Xvdicyjhj+vLQOWM2c3g4KzZ171FYp4
         kaqUUtrlqeKRa2JpWsguGYGYqmcx8++fXyL6TNuiLVU6sT+BKGkC96oKkttFlVChP3ul
         ROJDuC1g5vcZ8NQJunZe86JbBOz/rAGsUFftciSEHMj4luao7pLSUh6TIL4i8/9y3KpF
         zLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UWdyHtqZK8vfIndcfQvcNNS3B5v8ddPMxqJbmaARG9A=;
        b=MFI/RUay4hiYUk0VEbQZjUH2VS9h85g2Nbu8PS1oRbPW0gBEfkxBMui1hGf12pYODD
         5lKCZT1hBfpoL7SlpfHS424jkm/e4SqykriACtmBTYazF5Fn8TBdJiV6jfcPNmTSJ8Vq
         GQx86EUpdsl+zjJClz3E+PEu8NAM2zpbCsAOYODPpnbdzRjfnW6ccLeheAR1WU/1PWy+
         TTENjjuo27k23IbN+4v7uTP4K3Ck5Ex1fHIUxTwFCK2EENdUBt8N2KVV+KrL5G3W2jXT
         LYWtR0hqe56/UQnmWs3mWnFDIqid5qQ/Q4b7uOXh2R0Q6s/T9bHJDiv6yywYLREtM+G1
         LLWg==
X-Gm-Message-State: APjAAAUbk1qufBMfm0bL5WxfIMMIdWDsS3BGI5aI7UDrgZVhOgdz97fb
        fGeuxPzw1HoitAd/J2mDCsngSghF9XnigA==
X-Google-Smtp-Source: APXvYqx8DnxsE76t6bjUF8so1VkWy7VahtQztqh56nUCZqizxc7GoTDRtd52E9xvAeIoahSKo/x8kg==
X-Received: by 2002:aa7:9567:: with SMTP id x7mr2596676pfq.133.1580978349831;
        Thu, 06 Feb 2020 00:39:09 -0800 (PST)
Received: from localhost.localdomain ([240e:379:947:2855::fa3])
        by smtp.gmail.com with ESMTPSA id y9sm2387631pjj.17.2020.02.06.00.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:39:09 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 1/2] spi: add driver for ar934x spi controller
Date:   Thu,  6 Feb 2020 16:38:21 +0800
Message-Id: <20200206083822.204534-2-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206083822.204534-1-gch981213@gmail.com>
References: <20200206083822.204534-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds driver for SPI controller found in Qualcomm Atheros
AR934x/QCA95xx SoCs.
This controller is a superset of the already supported qca,ar7100-spi.
Besides the bit-bang mode in spi-ath79.c, this new controller added
a new "shift register" mode, allowing faster spi operations.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/spi/Kconfig      |   7 ++
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-ar934x.c | 230 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 238 insertions(+)
 create mode 100644 drivers/spi/spi-ar934x.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d6ed0c355954..0434614d8201 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -62,6 +62,13 @@ config SPI_ALTERA
 	help
 	  This is the driver for the Altera SPI Controller.
 
+config SPI_AR934X
+	tristate "Qualcomm Atheros AR934X/QCA95XX SPI controller driver"
+	depends on ATH79 || COMPILE_TEST
+	help
+	  This enables support for the SPI controller present on the
+	  Qualcomm Atheros AR934X/QCA95XX SoCs.
+
 config SPI_ATH79
 	tristate "Atheros AR71XX/AR724X/AR913X SPI controller driver"
 	depends on ATH79 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 9b65ec5afc5e..9892bdfab15e 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
+obj-$(CONFIG_SPI_AR934X)		+= spi-ar934x.o
 obj-$(CONFIG_SPI_ARMADA_3700)		+= spi-armada-3700.o
 obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
 obj-$(CONFIG_SPI_ATMEL_QUADSPI)		+= atmel-quadspi.o
diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
new file mode 100644
index 000000000000..6b42382148ed
--- /dev/null
+++ b/drivers/spi/spi-ar934x.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPI controller driver for Qualcomm Atheros AR934x/QCA95xx SoCs
+ *
+ * Copyright (C) 2020 Chuanhong Guo <gch981213@gmail.com>
+ *
+ * Based on spi-mt7621.c:
+ * Copyright (C) 2011 Sergiy <piratfm@gmail.com>
+ * Copyright (C) 2011-2013 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2014-2015 Felix Fietkau <nbd@nbd.name>
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/spi/spi.h>
+
+#define DRIVER_NAME "spi-ar934x"
+
+#define AR934X_SPI_REG_FS		0x00
+#define AR934X_SPI_ENABLE		BIT(0)
+
+#define AR934X_SPI_REG_CTRL		0x04
+#define AR934X_SPI_CLK_MASK		GENMASK(5, 0)
+
+#define AR934X_SPI_DATAOUT		0x10
+
+#define AR934X_SPI_REG_SHIFT_CTRL	0x14
+#define AR934X_SPI_SHIFT_EN		BIT(31)
+#define AR934X_SPI_SHIFT_CS(n)		BIT(28 + (n))
+#define AR934X_SPI_SHIFT_TERM		26
+#define AR934X_SPI_SHIFT_VAL(cs, term, count)			\
+	(AR934X_SPI_SHIFT_EN | AR934X_SPI_SHIFT_CS(cs) |	\
+	(term) << AR934X_SPI_SHIFT_TERM | (count))
+
+#define AR934X_SPI_DATAIN 0x18
+
+struct ar934x_spi {
+	struct spi_controller *ctlr;
+	void __iomem *base;
+	struct clk *clk;
+	unsigned int clk_freq;
+};
+
+static inline int ar934x_spi_clk_div(struct ar934x_spi *sp, unsigned int freq)
+{
+	int div = DIV_ROUND_UP(sp->clk_freq, freq * 2) - 1;
+
+	if (div < 0)
+		return 0;
+	else if (div > AR934X_SPI_CLK_MASK)
+		return -EINVAL;
+	else
+		return div;
+}
+
+static int ar934x_spi_setup(struct spi_device *spi)
+{
+	struct ar934x_spi *sp = spi_controller_get_devdata(spi->master);
+
+	if ((spi->max_speed_hz == 0) ||
+	    (spi->max_speed_hz > (sp->clk_freq / 2))) {
+		spi->max_speed_hz = sp->clk_freq / 2;
+	} else if (spi->max_speed_hz < (sp->clk_freq / 128)) {
+		dev_err(&spi->dev, "spi clock is too low\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ar934x_spi_transfer_one(struct spi_controller *master,
+				   struct spi_message *m)
+{
+	struct ar934x_spi *sp = spi_controller_get_devdata(master);
+	struct spi_transfer *t = NULL;
+	struct spi_device *spi = m->spi;
+	unsigned long trx_done, trx_cur;
+	int stat = 0;
+	u8 term = 0;
+	int div, i;
+	u32 reg;
+	const u8 *tx_buf;
+	u8 *buf;
+
+	m->actual_length = 0;
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->speed_hz)
+			div = ar934x_spi_clk_div(sp, t->speed_hz);
+		else
+			div = ar934x_spi_clk_div(sp, spi->max_speed_hz);
+		if (div < 0) {
+			stat = -EIO;
+			goto msg_done;
+		}
+
+		reg = ioread32(sp->base + AR934X_SPI_REG_CTRL);
+		reg &= ~AR934X_SPI_CLK_MASK;
+		reg |= div;
+		iowrite32(reg, sp->base + AR934X_SPI_REG_CTRL);
+		iowrite32(0, sp->base + AR934X_SPI_DATAOUT);
+
+		for (trx_done = 0; trx_done < t->len; trx_done += 4) {
+			trx_cur = t->len - trx_done;
+			if (trx_cur > 4)
+				trx_cur = 4;
+			else if (list_is_last(&t->transfer_list, &m->transfers))
+				term = 1;
+
+			if (t->tx_buf) {
+				tx_buf = t->tx_buf + trx_done;
+				reg = tx_buf[0];
+				for (i = 1; i < trx_cur; i++)
+					reg = reg << 8 | tx_buf[i];
+				iowrite32(reg, sp->base + AR934X_SPI_DATAOUT);
+			}
+
+			reg = AR934X_SPI_SHIFT_VAL(spi->chip_select, term,
+						   trx_cur * 8);
+			iowrite32(reg, sp->base + AR934X_SPI_REG_SHIFT_CTRL);
+			stat = readl_poll_timeout(
+				sp->base + AR934X_SPI_REG_SHIFT_CTRL, reg,
+				!(reg & AR934X_SPI_SHIFT_EN), 0, 5);
+			if (stat < 0)
+				goto msg_done;
+
+			if (t->rx_buf) {
+				reg = ioread32(sp->base + AR934X_SPI_DATAIN);
+				buf = t->rx_buf + trx_done;
+				for (i = 0; i < trx_cur; i++) {
+					buf[trx_cur - i - 1] = reg & 0xff;
+					reg >>= 8;
+				}
+			}
+		}
+		m->actual_length += t->len;
+	}
+
+msg_done:
+	m->status = stat;
+	spi_finalize_current_message(master);
+
+	return 0;
+}
+
+static const struct of_device_id ar934x_spi_match[] = {
+	{ .compatible = "qca,ar934x-spi" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ar934x_spi_match);
+
+static int ar934x_spi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct ar934x_spi *sp;
+	void __iomem *base;
+	struct clk *clk;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(clk)) {
+		dev_err(&pdev->dev, "failed to get clock\n");
+		return PTR_ERR(clk);
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*sp));
+	if (!ctlr) {
+		dev_info(&pdev->dev, "failed to allocate spi controller\n");
+		return -ENOMEM;
+	}
+
+	iowrite32(AR934X_SPI_ENABLE, base + AR934X_SPI_REG_FS);
+
+	ctlr->mode_bits = SPI_LSB_FIRST;
+	ctlr->setup = ar934x_spi_setup;
+	ctlr->transfer_one_message = ar934x_spi_transfer_one;
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->dev.of_node = pdev->dev.of_node;
+	ctlr->num_chipselect = 3;
+
+	dev_set_drvdata(&pdev->dev, ctlr);
+
+	sp = spi_controller_get_devdata(ctlr);
+	sp->base = base;
+	sp->clk = clk;
+	sp->clk_freq = clk_get_rate(clk);
+	sp->ctlr = ctlr;
+
+	return devm_spi_register_controller(&pdev->dev, ctlr);
+}
+
+static int ar934x_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct ar934x_spi *sp;
+
+	ctlr = dev_get_drvdata(&pdev->dev);
+	sp = spi_controller_get_devdata(ctlr);
+
+	clk_disable_unprepare(sp->clk);
+
+	return 0;
+}
+
+static struct platform_driver ar934x_spi_driver = {
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = ar934x_spi_match,
+	},
+	.probe = ar934x_spi_probe,
+	.remove = ar934x_spi_remove,
+};
+
+module_platform_driver(ar934x_spi_driver);
+
+MODULE_DESCRIPTION("SPI controller driver for Qualcomm Atheros AR934x/QCA95xx");
+MODULE_AUTHOR("Chuanhong Guo <gch981213@gmail.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:" DRIVER_NAME);
-- 
2.24.1

