Return-Path: <linux-spi+bounces-3787-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D416B92A613
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 17:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 553B21F21655
	for <lists+linux-spi@lfdr.de>; Mon,  8 Jul 2024 15:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8879813D281;
	Mon,  8 Jul 2024 15:49:35 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A178B139568;
	Mon,  8 Jul 2024 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453775; cv=none; b=MGTlNJTnKcTObUGeUdd5eXHxzHA5FV1ARB2w/6sm94PcV+E0z2bWBI5mrJFiaTZjVRY+llmfZqrshL2w6Dpq9PejNzHcG+YO4GKwo+7bEVG+CSaMWdAU8/L6NClSvpH+FaVPA7knuVYXTJZ2kHqOoAEgAxRyW0DA6V3iZnvDW34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453775; c=relaxed/simple;
	bh=pxWBLEk2UQU8nvbFz/xYfMoy1P/qeGKpcNWlo102pF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NffMl6iy+pvOTmwh0EPj1B+eb4ckvlRX7xyz4USE4EN0nezGj8p9honkodAOpqy8/UxtgNFgoPRPM3L6Vag4ulG15Z2Z3zXWa4+IxnFLAxgQmKk/ierHVkJNilGLnpwV7zp5vwvPZYFBaXiVLcDnigbPHnDWRroHpi+Yh7+zpYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a77bf336171so631593066b.1;
        Mon, 08 Jul 2024 08:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453772; x=1721058572;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pmo+Kz3W/4CgPYAKIlEmDnFYVhpVrFLEk5bjngkNVjs=;
        b=q2f3QjHSbPVJI8qC8owi1arzo9p4hYm2+VTE9McVf/64pIIrWu7AztUkdeARPBTj1/
         GcAjYMhYASXqy7bAgXeu0vh9rxkwRtWlSdwS7OnqV6eN37nju5oL0FxBss0crkmjc8N4
         FeiHAP8KyHzejAA8rzojpu2FWpqQuxk/r2nSIx9NrTjWxYwXtKoNpzGDuHAL+yL+9hOB
         IcJ/jnU3KcNeo/+SXbwgUjWNpYnHQhE5WuNaGWa2Rcx92wyVcxGpo2A3ON5o+FCAlgCB
         qvGn/cUm+s+nBJinnMWz2bNfuMfyKB+hRPY9ic3zqy/MMo/VssYF2MQxzPsPQVxPCjM9
         4WZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrReSeEDDZZBQp9vaGLSCPPwAM9BxBydpPxRYPkBqvnMjgOyBSUV7vhJk1w1uwlXsCCe108iobckl0RxtsuqTv74+ATFWOjI8R
X-Gm-Message-State: AOJu0YzdgqvpbAz3X0lEi596Uj9gUxAXsNWLjb3bb0GRBbiptH+/VUvT
	qpB5d2on0t0ZZqSTvVim0tRrvRfeEeXW4WYnN+OrZnZHuHdJO2dUHD6ggQ==
X-Google-Smtp-Source: AGHT+IHbeceXrzmye1crDiPtFeZ7DLm7IHJa6vrog+fq9lUfSUxFony2bzmRMluaWfhD4zHcOImiCg==
X-Received: by 2002:a17:906:158c:b0:a77:e031:bb86 with SMTP id a640c23a62f3a-a77e031bd42mr541670166b.7.1720453771650;
        Mon, 08 Jul 2024 08:49:31 -0700 (PDT)
Received: from [127.0.1.1] (p54ad9947.dip0.t-ipconnect.de. [84.173.153.71])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a780a6bd010sm5403666b.18.2024.07.08.08.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:49:31 -0700 (PDT)
From: Johannes Thumshirn <jth@kernel.org>
Date: Mon, 08 Jul 2024 17:49:28 +0200
Subject: [PATCH v3] spi: add ch341a usb2spi driver
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240708-spi-ch341a-v3-1-cf7f9b2c1e31@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIcKjGYC/23OTQ6DIBCG4asY1sUAQoSueo/GBego9EfMYEwb4
 92Lrlx0+S6+Z2YlCTBAItdiJQhLSCGOOapLQVpvxwFo6HITwYRkNdM0TYG2vpLc0to4C7xjUjl
 F8mBC6MPnwO5N7h7jm84ewZ4JxaXilS6VFjXl9DH72xNwhFcZcdgZH9Ic8Xu8tIgd+3t9EXntj
 La9BMONa89Ms23bD4f7UJrcAAAA
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

Changes to v2:
- Sorted Makefile part alphabetically as well
- Link to v2: https://lore.kernel.org/r/20240708-spi-ch341a-v2-1-b98af4e919bc@kernel.org
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
index e694254dec04..e697d5fd8611 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
 obj-$(CONFIG_SPI_CADENCE)		+= spi-cadence.o
 obj-$(CONFIG_SPI_CADENCE_QUADSPI)	+= spi-cadence-quadspi.o
 obj-$(CONFIG_SPI_CADENCE_XSPI)		+= spi-cadence-xspi.o
+obj-$(CONFIG_SPI_CH341)			+= spi-ch341.o
 obj-$(CONFIG_SPI_CLPS711X)		+= spi-clps711x.o
 obj-$(CONFIG_SPI_COLDFIRE_QSPI)		+= spi-coldfire-qspi.o
 obj-$(CONFIG_SPI_CS42L43)		+= spi-cs42l43.o
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


