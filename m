Return-Path: <linux-spi+bounces-3779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C803892A2F2
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 14:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEC41C2082D
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 12:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCB68003A;
	Mon,  8 Jul 2024 12:39:02 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76180BF0;
	Mon,  8 Jul 2024 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442342; cv=none; b=Ti6fWT9aNHeofPMPVippkJAOdVxtLikh4f4nzvH3sdDBNzkPmNQzhz9ZgUqR4dzQUETRrYiSwyTuhlUCYvAdfctFYCkkL1EhdORroHEJ+KfEVtvhgIsyzyI3odAU5BHTdXHPgnsJtkAV7txFzj9iSvzMe+qnQhVKeylBgrdIdFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442342; c=relaxed/simple;
	bh=MuMeGbVvqywpuHQFMKFvXIYXy/pDZjZjiCLStCuARzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kYc0SYh5mRm0qg80+JM1WD83rGjMu+CP7Z1mlH7NVD85Rw+yEHiW4Seg6qaGJuk/Tf0eZT4/toOY4myVfNqA+RN1F5/Kd6jOTcmfyu5LTY64fygkGw5Fb++4fP8s6Pb3zy5sXkd4oEAe3l/dBj+QLwD8dFYkWOfSXUJW4RF5334=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-426606f80ebso11420065e9.1;
        Mon, 08 Jul 2024 05:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720442338; x=1721047138;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkXCXod+8stPwSETPfAmbC6N7MzjAmSVsvPT3kdrucw=;
        b=nThIO5z/Kmu7/H/OWkFeaIQ4ZTMJBimUjw9WtzzAIG7BuGWTZeSAoCWYYoTNDMuqQV
         hRy04WN7TpyJNM+VhI7ZyW6fLrVXqkVkcXqPhrG6XO4qjPqRP3FIIb6Mz8Qj/CsVMB1i
         aWo2v/a7yhb3n22oQ6EzDEf/nZKqMpBmji7a+PxWmT9KJA2nmQfLkMa84kzGsaJLPddc
         QNIwXJWCyIPWB77hRbsuGiVnYzh9ei+PYCqGNIDszpIzydiUiPKKb6rUaQf2CX6dkSoW
         if5iz/YxzQ5k1O8aqAs1d0/fZMeFNu4hCECj5IkWLxrRA1GBJ22e4MlWIDdlzvbvLqUD
         2mIw==
X-Forwarded-Encrypted: i=1; AJvYcCVfiw1b8+S2XbJ0PuICJTjojw8k0nBQACkd6ZAy9AAbJ9auhyLWoCaVTNMRDIIgwpvIRL2j2IJ9ScTNnZ6S6As9zKXHqby4TPsU
X-Gm-Message-State: AOJu0YxPp/t/+SbzVFYIhZSPsuvZH/vOn+svLaZVMnucc8IYbGV68RYB
	UwS6BvBdcnEBedMfdTmO+RhaQkO6lis/uRSEvyWAKxWcSNPFJ/po
X-Google-Smtp-Source: AGHT+IF4ngLA/mnARP8SJ0VAJ7zFJZ+h7e6R7j+iYex31aaFyE9T7v8Vzft7F5YUXkl1Trv4bi7/aw==
X-Received: by 2002:a05:600c:894:b0:426:6edf:6597 with SMTP id 5b1f17b1804b1-4266edf6755mr2432675e9.19.1720442338209;
        Mon, 08 Jul 2024 05:38:58 -0700 (PDT)
Received: from [127.0.1.1] (p54ad9947.dip0.t-ipconnect.de. [84.173.153.71])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-367a13b61f7sm10250609f8f.13.2024.07.08.05.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 05:38:57 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 08 Jul 2024 14:38:56 +0200
Subject: [PATCH v2] spi: add ch341a usb2spi driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-spi-ch341a-v2-1-b98af4e919bc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAN/di2YC/03MTQ6DIBBA4auYWXcMIATalfdoukAdhf6AGUzTx
 Hj3kq66/Bbv7VCIIxW4NDswvWOJOVWoUwNj8GkhjFM1KKG0sMJhWSOOodPSoz0PnuQktBkM1GB
 lmuPnN7veqmfOL9wCk/9fGKmN7FxrnLIo8b6F/kGc6NlmXuA4vqowKXiTAAAA
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 Johannes Thumshirn <jth@kernel.org>
X-Mailer: b4 0.13.0

Add a driver for the QiHeng Electronics ch341a USB-to-SPI adapter.

This driver is loosely based on the ch341a module from the flashrom project.

Signed-off-by: Johannes Thumshirn <jth@kernel.org>
---
Changes to v1:
- Change C style to C++ style comments in header
- Sort Kconfig snippet alphabetically
- Don't cast away usb_bulk_msg() return value
- Call spi_unregister_device() on remove
- Don't pass constant speed to ch341_config_stream()
Link to v1:
https://lore.kernel.org/linux-spi/20240705145138.5827-1-jth@kernel.org
---
 drivers/spi/Kconfig     |   6 ++
 drivers/spi/Makefile    |   1 +
 drivers/spi/spi-ch341.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a2c99ff33e0a..ec1550c698d5 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -277,6 +277,12 @@ config SPI_CADENCE_XSPI
 	  device with a Cadence XSPI controller and want to access the
 	  Flash as an MTD device.
 
+config SPI_CH341
+	tristate "CH341 USB2SPI adapter"
+	depends on SPI_MASTER && USB
+	help
+	  Enables the SPI controller on the CH341a USB to serial chip
+
 config SPI_CLPS711X
 	tristate "CLPS711X host SPI controller"
 	depends on ARCH_CLPS711X || COMPILE_TEST
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
index 000000000000..d2351812d310
--- /dev/null
+++ b/drivers/spi/spi-ch341.c
@@ -0,0 +1,241 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// QiHeng Electronics ch341a USB-to-SPI adapter driver
+//
+// Copyright (C) 2024 Johannes Thumshirn <jth@kernel.org>
+//
+// Based on ch341a_spi.c from the flashrom project.
+
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
+	int err;
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
+	err = usb_bulk_msg(ch341->udev, ch341->write_pipe, ch341->tx_buf,
+			   (is_high ? 4 : 3), NULL, CH341_DEFAULT_TIMEOUT);
+	if (err)
+		dev_err(&spi->dev,
+			"error sending USB message for setting CS (%d)\n", err);
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
+static int ch341_config_stream(struct ch341_spi_dev *ch341)
+{
+	memset(ch341->tx_buf, 0, CH341_PACKET_LENGTH);
+	ch341->tx_buf[0] = CH341A_CMD_I2C_STREAM;
+	ch341->tx_buf[1] = CH341A_CMD_I2C_STM_SET | CH341A_STM_I2C_100K;
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
+	ret = ch341_config_stream(ch341);
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
+	spi_unregister_device(ch341->spidev);
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

---
base-commit: e9d22f7a6655941fc8b2b942ed354ec780936b3e
change-id: 20240708-spi-ch341a-79bae1d045b5

Best regards,
-- 
Johannes Thumshirn <jth@kernel.org>


