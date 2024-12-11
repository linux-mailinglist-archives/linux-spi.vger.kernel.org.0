Return-Path: <linux-spi+bounces-6036-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB599ED7E0
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 21:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 831D0168AF2
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 20:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996C923E6F0;
	Wed, 11 Dec 2024 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bMSwM9xH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7940B23E6C7
	for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950534; cv=none; b=BaZ0HVR9uZBluBcKbtveFvjkgJIti/DBjkljGvsxtLe3gJfN3/KMar2ilruaIW3MbeSD4bUQt+3gfKqwAbRm9tHU7rhJR4IsgZjjTboXnad2e1tThH1UMHoU2PG3tYXcpAdutsIyKCW+WazbId0ODP7tD9Us1aJeZmS9CfA9CA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950534; c=relaxed/simple;
	bh=OzAu1y/H3v98Oh+obJXz2LVpGi8e3bYBOTQLvfGilLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uunKFzww1k3BRxC/xoo4aDP8w7K3xaUBnxRLe+YgQA+d1fyq7+CJtF2S71Dnax7fyL71ASC6fnjaOM/NWs0IQJXk3PnPbKlEyjEMxeRk4E9oz+VX0Wo1gOHmp6sE35epTBYmOt+uxcdKeVa/V8kU5+PL8vHsFv7R3BJsoTOD3PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bMSwM9xH; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71decc7de4eso1082229a34.2
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 12:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950530; x=1734555330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UIG6sINpyGyOIxw92FCk6jPcVNBP3Duj2CqVoFPTTHM=;
        b=bMSwM9xHzsq1QkBxECtKTZYr3usMseHCs9OeG4rs3pLB5gUTPv6CuFBuijIvI48Twd
         bhbblW5ui+wmAHA5TWSOz1iBQ//Yk4fOO9VBrKWJdS6lpCZ8tCxGc70CvU1MAjSuGDJv
         nywyZbydRprQbq560XJW+/6YHA22Swn8+FzVsLOE4JhE7kWlNafbOCTDvcCdMCluw+nF
         AjsLdJugpDHohNlv07Xs4XIrz2lLoOqxO+iPPIqchcKSpHifi4ZwhjUeZIRE4Ibs2OkK
         v/f41Bxdn17PoeFsZqNEe9uFbsorCT9GZ4oswLaLsecHqPNwr4eAYLYOCwAY7C10DFoL
         f/4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950530; x=1734555330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UIG6sINpyGyOIxw92FCk6jPcVNBP3Duj2CqVoFPTTHM=;
        b=NDW0DdoViRzUgxpNiUo33UddA0e9sx/RI2e2jRjRcZA5GFYGsLw98qy9mlY/v2AAUd
         LPvPzLqWA/fH4RhY0zdOS3kDcA0Yf0AhkKMCLDXrtnjeOeHNKIRTwr2SHBXZOuGcuxlD
         efpnD+pEsXWATQ4xmiPFI5yCuhOGIf+PTSNNn2AaL071fHBj8RZ9cpHJavhXXI52Jl1v
         w9EToZljhx7cf+o+sX7LwarY8BXDFC7Bm0oCQFabPE95lSYoHjn9JV9aLgrFaJh3QWWr
         bYN+VKx7e4vl1JTVoQ5EI/WFVPVSXjp5PDDQxb19GaaMILXnmGl80uglryVJZJh++93+
         NnUw==
X-Forwarded-Encrypted: i=1; AJvYcCWyUY1/KgBGw967B0gFcRW7yb8fMEDglLWxuy4r+QH9t0aLniTAOWcOawzJKlHltr1UHlSpmVGlkUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylK/3gVOqhqqOlPYp4YpsJM7uN6UMJNaqtG0JcVoklh6G6dc9o
	sUaq8Iocs/D+Hovw2obvU/9Y92ox+C7emEnWazDAvUgIu+eRXAd3dgXdwq78dVw=
X-Gm-Gg: ASbGncsJwYIX6vvEa4df+4QLIRDbB2y82Trx9NN3R7utxOlu9jA0J5Pt9Uwl8mqbkdc
	nmjaBPlIzjshsSlZVOpwU2ONykHZSqY6NI1U6UcPUtRvT4tZPJtDvXU1/mTTlmO5uPg1Kqwxee3
	+HXgzgXOpAX4kN6ulopjDudeINENKU7apUOI9MzCuFR6Z2RQzIirHYuJjfhmzuWjscnqRKkR8DP
	hmCTKCkFdn9TLR0/aYYVxoYDcgYzcStB4KAwistX2vggxXw0avgn49Rki44rxJkyoR0g4eDmtJM
	8WbhpuT/qA==
X-Google-Smtp-Source: AGHT+IEFT/scxcmkfgIOkKvLV+l02WCW6R4Q/Nhv22dR9dP0pLo0cFMOt9o0Fzd4itbazmNHYYYouQ==
X-Received: by 2002:a05:6830:438d:b0:718:6da0:72b with SMTP id 46e09a7af769-71e29baca4emr609402a34.7.1733950530105;
        Wed, 11 Dec 2024 12:55:30 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:29 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:54 -0600
Subject: [PATCH v6 17/17] iio: dac: ad5791: Add offload support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-17-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 Axel Haslam <ahaslam@baylibre.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

From: Axel Haslam <ahaslam@baylibre.com>

Add SPI offload support to stream TX buffers using DMA.
This allows loading samples to the DAC with a rate of 1 MSPS.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: new patch in v6
---
 drivers/iio/dac/Kconfig  |   3 +
 drivers/iio/dac/ad5791.c | 150 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 4cde34e8c8e3356aa41bcd2cba38d67d5c6f8049..f6c5cb632acbdc2432f60b163452bb0c5f89fa72 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -296,6 +296,9 @@ config AD5770R
 config AD5791
 	tristate "Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC SPI driver"
 	depends on SPI
+	select SPI_OFFLOAD
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
 	help
 	  Say yes here to build support for Analog Devices AD5760, AD5780,
 	  AD5781, AD5790, AD5791 High Resolution Voltage Output Digital to
diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
index 24462cb020e19e8e2c6faa13109ac047cf423c37..a2953a9a4e5d5bc17c9c4a8281be4b41b1af5de8 100644
--- a/drivers/iio/dac/ad5791.c
+++ b/drivers/iio/dac/ad5791.c
@@ -15,9 +15,12 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/units.h>
 
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/dac/ad5791.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -64,11 +67,13 @@
  * struct ad5791_chip_info - chip specific information
  * @name:		name of the dac chip
  * @channel:		channel specification
+ * @channel_offload:	channel specification for offload
  * @get_lin_comp:	function pointer to the device specific function
  */
 struct ad5791_chip_info {
 	const char *name;
 	const struct iio_chan_spec channel;
+	const struct iio_chan_spec channel_offload;
 	int (*get_lin_comp)(unsigned int span);
 };
 
@@ -81,6 +86,11 @@ struct ad5791_chip_info {
  * @gpio_clear:		clear gpio
  * @gpio_ldac:		load dac gpio
  * @chip_info:		chip model specific constants
+ * @offload_msg:	spi message used for offload
+ * @offload_xfer:	spi transfer used for offload
+ * @offload:		offload device
+ * @offload_trigger:	offload trigger
+ * @offload_trigger_hz:	offload sample rate
  * @vref_mv:		actual reference voltage used
  * @vref_neg_mv:	voltage of the negative supply
  * @ctrl:		control register cache
@@ -96,6 +106,11 @@ struct ad5791_state {
 	struct gpio_desc		*gpio_clear;
 	struct gpio_desc		*gpio_ldac;
 	const struct ad5791_chip_info	*chip_info;
+	struct spi_message		offload_msg;
+	struct spi_transfer		offload_xfer;
+	struct spi_offload		*offload;
+	struct spi_offload_trigger	*offload_trigger;
+	unsigned int			offload_trigger_hz;
 	unsigned short			vref_mv;
 	unsigned int			vref_neg_mv;
 	unsigned			ctrl;
@@ -232,6 +247,25 @@ static int ad5780_get_lin_comp(unsigned int span)
 		return AD5780_LINCOMP_10_20;
 }
 
+static int ad5791_set_sample_freq(struct ad5791_state *st, int val)
+{
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = val,
+		},
+	};
+	int ret;
+
+	ret = spi_offload_trigger_validate(st->offload_trigger, &config);
+	if (ret)
+		return ret;
+
+	st->offload_trigger_hz = config.periodic.frequency_hz;
+
+	return 0;
+}
+
 static int ad5791_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan,
 			   int *val,
@@ -259,6 +293,9 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
 		do_div(val64, st->vref_mv);
 		*val = -val64;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->offload_trigger_hz;
+		return IIO_VAL_INT;
 	default:
 		return -EINVAL;
 	}
@@ -299,6 +336,24 @@ static const struct ad5791_chip_info _name##_chip_info = {		\
 			},						\
 			.ext_info = ad5791_ext_info,			\
 	},								\
+	.channel_offload = {						\
+			.type = IIO_VOLTAGE,				\
+			.output = 1,					\
+			.indexed = 1,					\
+			.address = AD5791_ADDR_DAC0,			\
+			.channel = 0,					\
+			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
+			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |	\
+				BIT(IIO_CHAN_INFO_OFFSET),		\
+			.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+			.scan_type = {					\
+				.sign = 'u',				\
+				.realbits = (bits),			\
+				.storagebits = 32,			\
+				.shift = (_shift),			\
+			},						\
+			.ext_info = ad5791_ext_info,			\
+	},								\
 }
 
 AD5791_DEFINE_CHIP_INFO(ad5760, 16, 4, ad5780_get_lin_comp);
@@ -322,16 +377,95 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
 
 		return ad5791_spi_write(st, chan->address, val);
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val < 0 || val2 < 0)
+			return -EINVAL;
+		return ad5791_set_sample_freq(st, val);
 	default:
 		return -EINVAL;
 	}
 }
 
+static int ad5791_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_PERIODIC,
+		.periodic = {
+			.frequency_hz = st->offload_trigger_hz,
+		},
+	};
+
+	if (st->pwr_down)
+		return -EINVAL;
+
+	return spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
+}
+
+static int ad5791_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ad5791_buffer_setup_ops = {
+	.preenable = &ad5791_buffer_preenable,
+	.postdisable = &ad5791_buffer_postdisable,
+};
+
+static int ad5791_offload_setup(struct iio_dev *indio_dev)
+{
+	struct ad5791_state *st = iio_priv(indio_dev);
+	struct spi_device *spi = st->spi;
+	struct dma_chan *tx_dma;
+	int ret;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(&spi->dev,
+		st->offload, SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	ret = ad5791_set_sample_freq(st, 1 * MEGA);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to init sample rate\n");
+
+	tx_dma = devm_spi_offload_tx_stream_request_dma_chan(&spi->dev,
+							     st->offload);
+	if (IS_ERR(tx_dma))
+		return dev_err_probe(&spi->dev, PTR_ERR(tx_dma),
+				     "failed to get offload TX DMA\n");
+
+	ret = devm_iio_dmaengine_buffer_setup_with_handle(&spi->dev,
+		indio_dev, tx_dma, IIO_BUFFER_DIRECTION_OUT);
+	if (ret)
+		return ret;
+
+	st->offload_xfer.len = 4;
+	st->offload_xfer.bits_per_word = 24;
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_TX_STREAM;
+
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(&spi->dev, st->spi, &st->offload_msg);
+}
+
 static const struct iio_info ad5791_info = {
 	.read_raw = &ad5791_read_raw,
 	.write_raw = &ad5791_write_raw,
 };
 
+static const struct spi_offload_config ad5791_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_TX_STREAM_DMA,
+};
+
 static int ad5791_probe(struct spi_device *spi)
 {
 	const struct ad5791_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -416,6 +550,21 @@ static int ad5791_probe(struct spi_device *spi)
 	indio_dev->channels = &st->chip_info->channel;
 	indio_dev->num_channels = 1;
 	indio_dev->name = st->chip_info->name;
+
+	st->offload = devm_spi_offload_get(&spi->dev, spi, &ad5791_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "failed to get offload\n");
+
+	if (ret != -ENODEV) {
+		indio_dev->channels = &st->chip_info->channel_offload;
+		indio_dev->setup_ops = &ad5791_buffer_setup_ops;
+		ret =  ad5791_offload_setup(indio_dev);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "fail to setup offload\n");
+	}
+
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
@@ -452,3 +601,4 @@ module_spi_driver(ad5791_driver);
 MODULE_AUTHOR("Michael Hennerich <michael.hennerich@analog.com>");
 MODULE_DESCRIPTION("Analog Devices AD5760/AD5780/AD5781/AD5790/AD5791 DAC");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.43.0


