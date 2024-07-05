Return-Path: <linux-spi+bounces-3761-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F934928AE4
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 16:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 057BD285D76
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 14:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96D16B389;
	Fri,  5 Jul 2024 14:52:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865741BC43;
	Fri,  5 Jul 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720191155; cv=none; b=S/i/GeuD/1+ynWsnC1IM7DdPgpT7JlBtDbFPl8lQuCllMz7cAnZe8yZOZgt5CIOlz2201dAzxFLb1sYyOaIak5MCXZfLhQdXk/TJnNE3QbspcqLvLD8EimmtEUKrRj+nL1PKdmcKFNcBGksz7wE5P0rm6ij0fpizKHQLg0kdmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720191155; c=relaxed/simple;
	bh=CC+xfyQTkr5VwmStPWHYn8weyloWAh5vghPSpzMiRhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ht6LXi3pHenoMNRKhOZakPhm5Yma0tKK5gZRkCDxyExKBUR3fBiJ6N4jBtKq+DMnNrc/wpNQLcZkqC/ojxNoao8kWGKYMnHNv+QSlTzrbJomHrxn7BR1FX1dPEheEL8jx4ZMUc4P/bdEF1xJynM9MhqVIfcojrlXyRPA5F/m5YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so2355821a12.2;
        Fri, 05 Jul 2024 07:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720191151; x=1720795951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJ1h9FjFXXSmLkTVSsxqP0tPS63GMeP0Z9eeMrX3awk=;
        b=fCdktzpBfFIXxc9HaYBYji/EntR1RKmC0/qwBvsNh0T9A3vIiAawmPyilooytOinMk
         iBXflicbAzZGGKAGm4iMa3Uq4iMUk55BN+MWwqsWMY70s2+DE3vsxf+cIiZkOxQx4J30
         Zc4+0ZP+WnU3B8uKeGJwINiNL/42LEszueNSVqxLgsmdkgOmOOXGvoy/VLM/S31UCRWX
         NJH8F5zX4IqZcK/GsAKgFhrmGVVpeN3oNKVdQxb8TIxnYf/wWlxfNmY9CGF4Id0B58dc
         nQOGqiaJEQrvALDPimELZ89Ep2wrNrkz4T2tCmyQIx7kLxq/qutR2nlmGdDnbBkxEXsX
         sQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCW48RwJBytGhJULof+cOzCvXb7WIx50N4nBlYW7Csz7Cv8TYgiXwv1X3Ni7mbVFlpSqssf/gnxGiBESB4CypJ4yDxZ2JIZPsOiF
X-Gm-Message-State: AOJu0YyAeWo1BAeQLSnImYqDmuKIQBMRxTBQm6HVJqE/Ls+zSkP6MwBU
	qnchVRDId+Kc6Uau8oOa+9LO8ch+q+2RD78azFw5dtF0H7m6T2/O
X-Google-Smtp-Source: AGHT+IFxmdp56GYi50zEkQ5SN8WtCTmNEkiErpMYzeNqQd1R8jzrv3sojB4E3Y+X4EG6/12/M07eaA==
X-Received: by 2002:a05:6402:d07:b0:58c:74ae:24ee with SMTP id 4fb4d7f45d1cf-58e5cd125d7mr3405041a12.38.1720191150452;
        Fri, 05 Jul 2024 07:52:30 -0700 (PDT)
Received: from localhost.localdomain (p54ad9947.dip0.t-ipconnect.de. [84.173.153.71])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-58fd14aad6dsm745153a12.86.2024.07.05.07.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 07:52:29 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org,
	Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH] spi: add ch341a usb2spi driver
Date: Fri,  5 Jul 2024 16:51:37 +0200
Message-ID: <20240705145138.5827-1-jth@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a driver for the QiHeng Electronics ch341a USB-to-SPI adapter.

This driver is loosly based on the ch341a module from the flashrom project.

Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
 drivers/spi/Kconfig     |   6 +
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-ch341.c | 236 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/spi/spi-ch341.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a2c99ff33e0a..79b3c20d7537 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1198,6 +1198,12 @@ config SPI_AMD
 	help
 	  Enables SPI controller driver for AMD SoC.
 
+config SPI_CH341
+	tristate "CH341 USB2SPI adapter"
+	depends on SPI_MASTER && USB
+	help
+	  Enables the SPI controller on the CH341a USB to serial chip
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index e694254dec04..9de506d1d135 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -154,6 +154,7 @@ obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
 obj-$(CONFIG_SPI_ZYNQ_QSPI)		+= spi-zynq-qspi.o
 obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
 obj-$(CONFIG_SPI_AMD)			+= spi-amd.o
+obj-$(CONFIG_SPI_CH341)			+= spi-ch341.o
 
 # SPI slave protocol handlers
 obj-$(CONFIG_SPI_SLAVE_TIME)		+= spi-slave-time.o
diff --git a/drivers/spi/spi-ch341.c b/drivers/spi/spi-ch341.c
new file mode 100644
index 000000000000..a2b53089e0e4
--- /dev/null
+++ b/drivers/spi/spi-ch341.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * QiHeng Electronics ch341a USB-to-SPI adapter driver
+ *
+ * Copyright (C) 2024 Johannes Thumshirn <jth@kernel.org>
+ *
+ * Based on ch341a_spi.c from the flashrom project.
+ */
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/spi/spi.h>
+
+#define CH341_PACKET_LENGTH 32
+#define CH341_DEFAULT_TIMEOUT 1000
+
+#define CH341A_CMD_UIO_STREAM 0xab
+
+#define CH341A_CMD_UIO_STM_END 0x20
+#define CH341A_CMD_UIO_STM_DIR 0x40
+#define CH341A_CMD_UIO_STM_OUT 0x80
+
+#define CH341A_CMD_I2C_STREAM 0xaa
+#define CH341A_CMD_I2C_STM_SET 0x60
+#define CH341A_CMD_I2C_STM_END 0x00
+
+#define CH341A_CMD_SPI_STREAM 0xa8
+
+#define CH341A_STM_I2C_100K 0x01
+
+struct ch341_spi_dev {
+	struct spi_controller *ctrl;
+	struct usb_device *udev;
+	unsigned int write_pipe;
+	unsigned int read_pipe;
+	int rx_len;
+	void *rx_buf;
+	u8 *tx_buf;
+	struct urb *rx_urb;
+	struct spi_device *spidev;
+};
+
+static void ch341_set_cs(struct spi_device *spi, bool is_high)
+{
+	struct ch341_spi_dev *ch341 =
+		spi_controller_get_devdata(spi->controller);
+
+	memset(ch341->tx_buf, 0, CH341_PACKET_LENGTH);
+	ch341->tx_buf[0] = CH341A_CMD_UIO_STREAM;
+	ch341->tx_buf[1] = CH341A_CMD_UIO_STM_OUT | (is_high ? 0x36 : 0x37);
+
+	if (is_high) {
+		ch341->tx_buf[2] = CH341A_CMD_UIO_STM_DIR | 0x3f;
+		ch341->tx_buf[3] = CH341A_CMD_UIO_STM_END;
+	} else {
+		ch341->tx_buf[2] = CH341A_CMD_UIO_STM_END;
+	}
+
+	(void)usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf,
+			   (is_high ? 4 : 3), NULL, CH341_DEFAULT_TIMEOUT);
+}
+
+static int ch341_transfer_one(struct spi_controller *host,
+			      struct spi_device *spi,
+			      struct spi_transfer *trans)
+{
+	struct ch341_spi_dev *ch341 =
+		spi_controller_get_devdata(spi->controller);
+	int len;
+	int ret;
+
+	len = min(CH341_PACKET_LENGTH, trans->len + 1);
+
+	memset(ch341->tx_buf, 0, CH341_PACKET_LENGTH);
+
+	ch341->tx_buf[0] = CH341A_CMD_SPI_STREAM;
+
+	memcpy(ch341->tx_buf + 1, trans->tx_buf, len);
+
+	ret = usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf, len,
+			   NULL, CH341_DEFAULT_TIMEOUT);
+	if (ret)
+		return ret;
+
+	return usb_bulk_msg(ch341->udev, ch341->read_pipe, trans->rx_buf,
+			    len - 1, NULL, CH341_DEFAULT_TIMEOUT);
+}
+
+static void ch341_recv(struct urb *urb)
+{
+	struct ch341_spi_dev *ch341 = urb->context;
+	struct usb_device *udev = ch341->udev;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ENOENT:
+	case -ECONNRESET:
+	case -EPIPE:
+	case -ESHUTDOWN:
+		dev_dbg(&udev->dev, "rx urb terminated with status: %d\n",
+			urb->status);
+		return;
+	default:
+		dev_dbg(&udev->dev, "rx urb error: %d\n", urb->status);
+		break;
+	}
+}
+
+static int ch341_config_stream(struct ch341_spi_dev *ch341, int speed)
+{
+	memset(ch341->tx_buf, 0, CH341_PACKET_LENGTH);
+	ch341->tx_buf[0] = CH341A_CMD_I2C_STREAM;
+	ch341->tx_buf[1] = CH341A_CMD_I2C_STM_SET | (speed & 0x7);
+	ch341->tx_buf[2] = CH341A_CMD_I2C_STM_END;
+
+	return usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf, 3,
+			    NULL, CH341_DEFAULT_TIMEOUT);
+}
+
+static int ch341_enable_pins(struct ch341_spi_dev *ch341, bool enable)
+{
+	memset(ch341->tx_buf, 0, CH341_PACKET_LENGTH);
+	ch341->tx_buf[0] = CH341A_CMD_UIO_STREAM;
+	ch341->tx_buf[1] = CH341A_CMD_UIO_STM_OUT | 0x37;
+	ch341->tx_buf[2] = CH341A_CMD_UIO_STM_DIR | (enable ? 0x3f : 0x00);
+	ch341->tx_buf[3] = CH341A_CMD_UIO_STM_END;
+
+	return usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf, 4,
+			    NULL, CH341_DEFAULT_TIMEOUT);
+}
+
+static struct spi_board_info chip = {
+	.modalias = "spi-ch341a",
+};
+
+static int ch341_probe(struct usb_interface *intf,
+		       const struct usb_device_id *id)
+{
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct usb_endpoint_descriptor *in, *out;
+	struct ch341_spi_dev *ch341;
+	struct spi_controller *ctrl;
+	int ret;
+
+	ret = usb_find_common_endpoints(intf->cur_altsetting, &in, &out, NULL,
+					NULL);
+	if (ret)
+		return ret;
+
+	ctrl = devm_spi_alloc_master(&udev->dev, sizeof(struct ch341_spi_dev));
+	if (!ctrl)
+		return -ENOMEM;
+
+	ch341 = spi_controller_get_devdata(ctrl);
+	ch341->ctrl = ctrl;
+	ch341->udev = udev;
+	ch341->write_pipe = usb_sndbulkpipe(udev, usb_endpoint_num(out));
+	ch341->read_pipe = usb_rcvbulkpipe(udev, usb_endpoint_num(in));
+
+	ch341->rx_len = usb_endpoint_maxp(in);
+	ch341->rx_buf = devm_kzalloc(&udev->dev, ch341->rx_len, GFP_KERNEL);
+	if (!ch341->rx_buf)
+		return -ENOMEM;
+
+	ch341->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!ch341->rx_urb)
+		return -ENOMEM;
+
+	ch341->tx_buf =
+		devm_kzalloc(&udev->dev, CH341_PACKET_LENGTH, GFP_KERNEL);
+	if (!ch341->tx_buf)
+		return -ENOMEM;
+
+	usb_fill_bulk_urb(ch341->rx_urb, udev, ch341->read_pipe, ch341->rx_buf,
+			  ch341->rx_len, ch341_recv, ch341);
+
+	ret = usb_submit_urb(ch341->rx_urb, GFP_KERNEL);
+	if (ret) {
+		usb_free_urb(ch341->rx_urb);
+		return -ENOMEM;
+	}
+
+	ctrl->bus_num = -1;
+	ctrl->mode_bits = SPI_CPHA;
+	ctrl->transfer_one = ch341_transfer_one;
+	ctrl->set_cs = ch341_set_cs;
+	ctrl->auto_runtime_pm = false;
+
+	usb_set_intfdata(intf, ch341);
+
+	ret = ch341_config_stream(ch341, CH341A_STM_I2C_100K);
+	if (ret)
+		return ret;
+
+	ret = ch341_enable_pins(ch341, true);
+	if (ret)
+		return ret;
+
+	ret = spi_register_controller(ctrl);
+	if (ret)
+		return ret;
+
+	ch341->spidev = spi_new_device(ctrl, &chip);
+	if (!ch341->spidev)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void ch341_disconnect(struct usb_interface *intf)
+{
+	struct ch341_spi_dev *ch341 = usb_get_intfdata(intf);
+
+	spi_unregister_controller(ch341->ctrl);
+	ch341_enable_pins(ch341, false);
+	usb_free_urb(ch341->rx_urb);
+}
+
+static const struct usb_device_id ch341_id_table[] = {
+	{ USB_DEVICE(0x1a86, 0x5512) },
+	{ }
+};
+MODULE_DEVICE_TABLE(usb, ch341_id_table);
+
+static struct usb_driver ch341a_usb_driver = {
+	.name = "spi-ch341",
+	.probe = ch341_probe,
+	.disconnect = ch341_disconnect,
+	.id_table = ch341_id_table,
+};
+module_usb_driver(ch341a_usb_driver);
+
+MODULE_AUTHOR("Johannes Thumshirn <jth@kernel.org>");
+MODULE_DESCRIPTION("QiHeng Electronics ch341 USB2SPI");
+MODULE_LICENSE("GPL v2");
-- 
2.43.0


