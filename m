Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE767806B
	for <lists+linux-spi@lfdr.de>; Sun, 28 Jul 2019 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbfG1QUT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Jul 2019 12:20:19 -0400
Received: from condef-08.nifty.com ([202.248.20.73]:49451 "EHLO
        condef-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfG1QUT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Jul 2019 12:20:19 -0400
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-08.nifty.com with ESMTP id x6SGFF5G030769
        for <linux-spi@vger.kernel.org>; Mon, 29 Jul 2019 01:15:15 +0900
Received: from grover.flets-west.jp (softbank126026094249.bbtec.net [126.26.94.249]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id x6SGDuWi006387;
        Mon, 29 Jul 2019 01:13:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com x6SGDuWi006387
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1564330437;
        bh=F8yipN2J8Ahe/nIfNMzrQnTUVqFtg1wcPdej60225qQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QRPYISr2P9pKG1ndbW7W0s2X16E12JCkXVBuWkK3EAVZtcBv++MAHkYdqSkzy4ovo
         Mj5nWlSqT2dMyTC4+m415xZj2S83fNaE5tJLwKHsO9xGaTF/KKwNdOwtsaXOr07rPq
         y7VKabq3uc8qHBUtL27AUjMjbkcokM7fYSo9sNMMHGwmqP8BUtKjoX+IzAWGOa/ocX
         cvJ+OleVm1uuTdtVf9UVP1ytVeGZRHFSzYJIJfIspG7uopZ0HQNahxjUBAmGGvAU++
         93N3ViRgARD7Dsur3GhNDGy+gQ0ku6tatFIgY5NJCLQrAQI0PGEUNIiWlvF+ahaR8p
         0g7RzffJioAyQ==
X-Nifty-SrcIP: [126.26.94.249]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] spi: tle620x: remove stale driver
Date:   Mon, 29 Jul 2019 01:13:04 +0900
Message-Id: <20190728161304.32022-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This driver seems obsolte because this driver needs platform data
but no one in upstream passes it.

Link: https://lkml.org/lkml/2019/7/21/19
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/configs/s3c2410_defconfig |   1 -
 drivers/spi/Kconfig                |   9 -
 drivers/spi/Makefile               |   1 -
 drivers/spi/spi-tle62x0.c          | 317 -----------------------------
 include/linux/spi/tle62x0.h        |  12 --
 5 files changed, 340 deletions(-)
 delete mode 100644 drivers/spi/spi-tle62x0.c
 delete mode 100644 include/linux/spi/tle62x0.h

diff --git a/arch/arm/configs/s3c2410_defconfig b/arch/arm/configs/s3c2410_defconfig
index 95b5a4ffddea..45ee51f690be 100644
--- a/arch/arm/configs/s3c2410_defconfig
+++ b/arch/arm/configs/s3c2410_defconfig
@@ -270,7 +270,6 @@ CONFIG_SPI=y
 CONFIG_SPI_GPIO=m
 CONFIG_SPI_S3C24XX=m
 CONFIG_SPI_SPIDEV=m
-CONFIG_SPI_TLE62X0=m
 CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM78=m
 CONFIG_SENSORS_LM85=m
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3a1d8f1170de..38e0651946c1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -900,15 +900,6 @@ config SPI_LOOPBACK_TEST
 	  primarily used for development of spi_master drivers
 	  and to detect regressions
 
-config SPI_TLE62X0
-	tristate "Infineon TLE62X0 (for power switching)"
-	depends on SYSFS
-	help
-	  SPI driver for Infineon TLE62X0 series line driver chips,
-	  such as the TLE6220, TLE6230 and TLE6240.  This provides a
-	  sysfs interface, with each line presented as a kind of GPIO
-	  exposing both switch control and diagnostic feedback.
-
 #
 # Add new SPI protocol masters in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 63dcab552bcb..9566d896a4c8 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -110,7 +110,6 @@ obj-$(CONFIG_SPI_SYNQUACER)		+= spi-synquacer.o
 obj-$(CONFIG_SPI_TEGRA114)		+= spi-tegra114.o
 obj-$(CONFIG_SPI_TEGRA20_SFLASH)	+= spi-tegra20-sflash.o
 obj-$(CONFIG_SPI_TEGRA20_SLINK)		+= spi-tegra20-slink.o
-obj-$(CONFIG_SPI_TLE62X0)		+= spi-tle62x0.o
 spi-thunderx-objs			:= spi-cavium.o spi-cavium-thunderx.o
 obj-$(CONFIG_SPI_THUNDERX)		+= spi-thunderx.o
 obj-$(CONFIG_SPI_TOPCLIFF_PCH)		+= spi-topcliff-pch.o
diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
deleted file mode 100644
index 60dc69a39ace..000000000000
--- a/drivers/spi/spi-tle62x0.c
+++ /dev/null
@@ -1,317 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Support Infineon TLE62x0 driver chips
- *
- * Copyright (c) 2007 Simtec Electronics
- *	Ben Dooks, <ben@simtec.co.uk>
- */
-
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-
-#include <linux/spi/spi.h>
-#include <linux/spi/tle62x0.h>
-
-
-#define CMD_READ	0x00
-#define CMD_SET		0xff
-
-#define DIAG_NORMAL	0x03
-#define DIAG_OVERLOAD	0x02
-#define DIAG_OPEN	0x01
-#define DIAG_SHORTGND	0x00
-
-struct tle62x0_state {
-	struct spi_device	*us;
-	struct mutex		lock;
-	unsigned int		nr_gpio;
-	unsigned int		gpio_state;
-
-	unsigned char		tx_buff[4];
-	unsigned char		rx_buff[4];
-};
-
-static int to_gpio_num(struct device_attribute *attr);
-
-static inline int tle62x0_write(struct tle62x0_state *st)
-{
-	unsigned char *buff = st->tx_buff;
-	unsigned int gpio_state = st->gpio_state;
-
-	buff[0] = CMD_SET;
-
-	if (st->nr_gpio == 16) {
-		buff[1] = gpio_state >> 8;
-		buff[2] = gpio_state;
-	} else {
-		buff[1] = gpio_state;
-	}
-
-	dev_dbg(&st->us->dev, "buff %3ph\n", buff);
-
-	return spi_write(st->us, buff, (st->nr_gpio == 16) ? 3 : 2);
-}
-
-static inline int tle62x0_read(struct tle62x0_state *st)
-{
-	unsigned char *txbuff = st->tx_buff;
-	struct spi_transfer xfer = {
-		.tx_buf		= txbuff,
-		.rx_buf		= st->rx_buff,
-		.len		= (st->nr_gpio * 2) / 8,
-	};
-	struct spi_message msg;
-
-	txbuff[0] = CMD_READ;
-	txbuff[1] = 0x00;
-	txbuff[2] = 0x00;
-	txbuff[3] = 0x00;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-
-	return spi_sync(st->us, &msg);
-}
-
-static unsigned char *decode_fault(unsigned int fault_code)
-{
-	fault_code &= 3;
-
-	switch (fault_code) {
-	case DIAG_NORMAL:
-		return "N";
-	case DIAG_OVERLOAD:
-		return "V";
-	case DIAG_OPEN:
-		return "O";
-	case DIAG_SHORTGND:
-		return "G";
-	}
-
-	return "?";
-}
-
-static ssize_t tle62x0_status_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct tle62x0_state *st = dev_get_drvdata(dev);
-	char *bp = buf;
-	unsigned char *buff = st->rx_buff;
-	unsigned long fault = 0;
-	int ptr;
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = tle62x0_read(st);
-	dev_dbg(dev, "tle62x0_read() returned %d\n", ret);
-	if (ret < 0) {
-		mutex_unlock(&st->lock);
-		return ret;
-	}
-
-	for (ptr = 0; ptr < (st->nr_gpio * 2)/8; ptr += 1) {
-		fault <<= 8;
-		fault  |= ((unsigned long)buff[ptr]);
-
-		dev_dbg(dev, "byte %d is %02x\n", ptr, buff[ptr]);
-	}
-
-	for (ptr = 0; ptr < st->nr_gpio; ptr++) {
-		bp += sprintf(bp, "%s ", decode_fault(fault >> (ptr * 2)));
-	}
-
-	*bp++ = '\n';
-
-	mutex_unlock(&st->lock);
-	return bp - buf;
-}
-
-static DEVICE_ATTR(status_show, S_IRUGO, tle62x0_status_show, NULL);
-
-static ssize_t tle62x0_gpio_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct tle62x0_state *st = dev_get_drvdata(dev);
-	int gpio_num = to_gpio_num(attr);
-	int value;
-
-	mutex_lock(&st->lock);
-	value = (st->gpio_state >> gpio_num) & 1;
-	mutex_unlock(&st->lock);
-
-	return snprintf(buf, PAGE_SIZE, "%d", value);
-}
-
-static ssize_t tle62x0_gpio_store(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t len)
-{
-	struct tle62x0_state *st = dev_get_drvdata(dev);
-	int gpio_num = to_gpio_num(attr);
-	unsigned long val;
-	char *endp;
-
-	val = simple_strtoul(buf, &endp, 0);
-	if (buf == endp)
-		return -EINVAL;
-
-	dev_dbg(dev, "setting gpio %d to %ld\n", gpio_num, val);
-
-	mutex_lock(&st->lock);
-
-	if (val)
-		st->gpio_state |= 1 << gpio_num;
-	else
-		st->gpio_state &= ~(1 << gpio_num);
-
-	tle62x0_write(st);
-	mutex_unlock(&st->lock);
-
-	return len;
-}
-
-static DEVICE_ATTR(gpio1, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio2, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio3, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio4, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio5, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio6, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio7, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio8, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio9, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio10, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio11, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio12, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio13, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio14, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio15, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-static DEVICE_ATTR(gpio16, S_IWUSR|S_IRUGO,
-		tle62x0_gpio_show, tle62x0_gpio_store);
-
-static struct device_attribute *gpio_attrs[] = {
-	[0]		= &dev_attr_gpio1,
-	[1]		= &dev_attr_gpio2,
-	[2]		= &dev_attr_gpio3,
-	[3]		= &dev_attr_gpio4,
-	[4]		= &dev_attr_gpio5,
-	[5]		= &dev_attr_gpio6,
-	[6]		= &dev_attr_gpio7,
-	[7]		= &dev_attr_gpio8,
-	[8]		= &dev_attr_gpio9,
-	[9]		= &dev_attr_gpio10,
-	[10]		= &dev_attr_gpio11,
-	[11]		= &dev_attr_gpio12,
-	[12]		= &dev_attr_gpio13,
-	[13]		= &dev_attr_gpio14,
-	[14]		= &dev_attr_gpio15,
-	[15]		= &dev_attr_gpio16
-};
-
-static int to_gpio_num(struct device_attribute *attr)
-{
-	int ptr;
-
-	for (ptr = 0; ptr < ARRAY_SIZE(gpio_attrs); ptr++) {
-		if (gpio_attrs[ptr] == attr)
-			return ptr;
-	}
-
-	return -1;
-}
-
-static int tle62x0_probe(struct spi_device *spi)
-{
-	struct tle62x0_state *st;
-	struct tle62x0_pdata *pdata;
-	int ptr;
-	int ret;
-
-	pdata = dev_get_platdata(&spi->dev);
-	if (pdata == NULL) {
-		dev_err(&spi->dev, "no device data specified\n");
-		return -EINVAL;
-	}
-
-	st = kzalloc(sizeof(struct tle62x0_state), GFP_KERNEL);
-	if (st == NULL)
-		return -ENOMEM;
-
-	st->us = spi;
-	st->nr_gpio = pdata->gpio_count;
-	st->gpio_state = pdata->init_state;
-
-	mutex_init(&st->lock);
-
-	ret = device_create_file(&spi->dev, &dev_attr_status_show);
-	if (ret) {
-		dev_err(&spi->dev, "cannot create status attribute\n");
-		goto err_status;
-	}
-
-	for (ptr = 0; ptr < pdata->gpio_count; ptr++) {
-		ret = device_create_file(&spi->dev, gpio_attrs[ptr]);
-		if (ret) {
-			dev_err(&spi->dev, "cannot create gpio attribute\n");
-			goto err_gpios;
-		}
-	}
-
-	/* tle62x0_write(st); */
-	spi_set_drvdata(spi, st);
-	return 0;
-
- err_gpios:
-	while (--ptr >= 0)
-		device_remove_file(&spi->dev, gpio_attrs[ptr]);
-
-	device_remove_file(&spi->dev, &dev_attr_status_show);
-
- err_status:
-	kfree(st);
-	return ret;
-}
-
-static int tle62x0_remove(struct spi_device *spi)
-{
-	struct tle62x0_state *st = spi_get_drvdata(spi);
-	int ptr;
-
-	for (ptr = 0; ptr < st->nr_gpio; ptr++)
-		device_remove_file(&spi->dev, gpio_attrs[ptr]);
-
-	device_remove_file(&spi->dev, &dev_attr_status_show);
-	kfree(st);
-	return 0;
-}
-
-static struct spi_driver tle62x0_driver = {
-	.driver = {
-		.name	= "tle62x0",
-	},
-	.probe		= tle62x0_probe,
-	.remove		= tle62x0_remove,
-};
-
-module_spi_driver(tle62x0_driver);
-
-MODULE_AUTHOR("Ben Dooks <ben@simtec.co.uk>");
-MODULE_DESCRIPTION("TLE62x0 SPI driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:tle62x0");
diff --git a/include/linux/spi/tle62x0.h b/include/linux/spi/tle62x0.h
deleted file mode 100644
index 5d74b9fffca2..000000000000
--- a/include/linux/spi/tle62x0.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * tle62x0.h - platform glue to Infineon TLE62x0 driver chips
- *
- * Copyright 2007 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
-*/
-
-struct tle62x0_pdata {
-	unsigned int		init_state;
-	unsigned int		gpio_count;
-};
-- 
2.17.1

