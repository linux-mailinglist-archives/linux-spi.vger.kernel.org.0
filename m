Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6E32154A4
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 11:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgGFJX2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbgGFJX1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 05:23:27 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB4CC08C5DF
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 02:23:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so41634152ejc.3
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2020 02:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastree3d-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czpe4szN5uZzMAsN6fQwGQj9W09acDhtTokwr/LfjQM=;
        b=TjdFiBJeWdNnwb36X3cwJQ21R9b59hWBGRRxwsYMVKBYyg8w5R3Lk49/9+bTPamvMl
         a2VUtLN8KDKeD30mYRCz0q1t8u8F4OIRlS33h3JBIacO43pwxvkCZoA5HU9m1fMRjW1a
         yzr+cRrjIIhhhoxe5a+Qn2/rdSogcKBVM3lfj313MbYn0joXmycjmPtDM2ae0y2ejsAV
         dPeXZyqMe7Q4B+h8EbpTISD8syKAWi1Vwyl/62/OqCXjERUIbTFYpNJjuW3qG6t/Ma5E
         PMtzRwIIWY7Mcj655rNWGywLc9om1AEXR3nX37PHN2uiAzNowH4EZ1WgBFDCC5XEt3Sc
         C/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czpe4szN5uZzMAsN6fQwGQj9W09acDhtTokwr/LfjQM=;
        b=RjXs2kWdQbkuJQTq2gboCG2iw3JOxdwScxHjE/YNpC8PNXG5iiph+b1o6D/am7uz/Q
         tzvEMT5MeaQfvKo3UUlv6hS96/8HjCOKttH+sAnSusVhULVr4xke8h4NJa9/FGpyAGkz
         YBQdDLk2TZOrm1F/tRckmrN3a8OZ+psKGF3dKKwTfoCe8TVE1GaxTYzl3uncpfLYFkGz
         2i6bHkEBIHuCqazCrfKElkoZVFQmrMqsL0GY2aVSoQK6EL2RtNsmJWPXGGxCJdQaGH79
         xNZVI34L3AVGqlWyQvygtw/FLIhVz1rE/Kmf7vQIh8Yj+Vwj1RVwzK5o6043rrwrZQ0Z
         faPw==
X-Gm-Message-State: AOAM532EetOGTMesPFlGNJhz7Sk4tc6nhrfZN8HX+Na62F1vU8yel7dO
        LL4j/Aen7lgLKSV3pUVZBUQKavC1uw==
X-Google-Smtp-Source: ABdhPJxSGCrVZeCOCLtEMBC2+F1/Y9B3fYQgYrFG3ZNNTHf7Bp7J3MXvz0yxPg3uH1KDEzPIEis9Jw==
X-Received: by 2002:a17:907:7245:: with SMTP id ds5mr42146882ejc.1.1594027405574;
        Mon, 06 Jul 2020 02:23:25 -0700 (PDT)
Received: from localhost.localdomain (fastree1.epfl.ch. [192.26.37.52])
        by smtp.gmail.com with ESMTPSA id bm21sm15895244ejb.13.2020.07.06.02.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 02:23:24 -0700 (PDT)
From:   Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
Cc:     geert@linux-m68k.org, lukas@wunner.de,
        Adrian Fiergolski <adrian.fiergolski@fastree3d.com>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] spi: Add the SPI daisy chain support.
Date:   Mon,  6 Jul 2020 11:22:43 +0200
Message-Id: <20200706092247.20740-1-adrian.fiergolski@fastree3d.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <202007040833.xIqR5rAw%lkp@intel.com>
References: <202007040833.xIqR5rAw%lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The implementation is transparent for the SPI devices and doesn't require
their modifications. It is based on a virtual SPI device (spi-daisy_chain)
and defines two required device tree properties ('spi-daisy-chain-len' and
'spi-daisy-chain-noop') and one optional
('spi-daisy-chain-bits_per_word'). It has been tested on hardware with a
chain of three ltc2694 devices (kernel v4.19).

Signed-off-by: Adrian Fiergolski <adrian.fiergolski@fastree3d.com>
---
Changes in v2:
- declare spi_daisy_chain_clean as static
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/spi/Kconfig                 |   8 +
 drivers/spi/Makefile                |   1 +
 drivers/spi/spi-daisy_chain.c       | 428 ++++++++++++++++++++++++++++
 drivers/spi/spi.c                   |  65 ++++-
 include/linux/spi/spi-daisy_chain.h |  32 +++
 include/linux/spi/spi.h             |  17 +-
 6 files changed, 541 insertions(+), 10 deletions(-)
 create mode 100644 drivers/spi/spi-daisy_chain.c
 create mode 100644 include/linux/spi/spi-daisy_chain.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 8f1f8fca79e3..822c4b4bdd5c 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -55,6 +55,14 @@ config SPI_MEM
 	  This extension is meant to simplify interaction with SPI memories
 	  by providing a high-level interface to send memory-like commands.
 
+config SPI_DAISY_CHAIN
+	bool "SPI daisy chain support"
+	depends on OF
+	help
+	  This enables support for the SPI daisy chains.
+	  This extension provides a virtual SPI daisy chain device which
+	  links together physical SPI devices on a common SPI daisy chain.
+
 comment "SPI Master Controller Drivers"
 
 config SPI_ALTERA
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d2e41d3d464a..dbcb98480f51 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -9,6 +9,7 @@ ccflags-$(CONFIG_SPI_DEBUG) := -DDEBUG
 # config declarations into driver model code
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 obj-$(CONFIG_SPI_MEM)			+= spi-mem.o
+obj-$(CONFIG_SPI_DAISY_CHAIN)		+= spi-daisy_chain.o
 obj-$(CONFIG_SPI_MUX)			+= spi-mux.o
 obj-$(CONFIG_SPI_SPIDEV)		+= spidev.o
 obj-$(CONFIG_SPI_LOOPBACK_TEST)		+= spi-loopback-test.o
diff --git a/drivers/spi/spi-daisy_chain.c b/drivers/spi/spi-daisy_chain.c
new file mode 100644
index 000000000000..f187502b1861
--- /dev/null
+++ b/drivers/spi/spi-daisy_chain.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * A driver handling the SPI daisy chaines.
+ *
+ * Copyright (C) 2020 Fastree3D
+ *	Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/spi/spi.h>
+
+#include <linux/spi/spi-daisy_chain.h>
+
+/**
+ * spi_daisy_chain_message_pre - generate SPI daisy chain message
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers
+ *
+ * The call checks if the SPI device is part of daisy chain. If so, it
+ * generates a message containg no-operation codes
+ * of unaddressed device of a given daisy chain.
+ **/
+
+int spi_daisy_chain_message_pre(struct spi_device *spi,
+				struct spi_message *message)
+{
+	struct spi_transfer *tr, *ntr;
+	struct spi_daisy_chain_device *spi_chain_dev;
+	int rc;
+
+	//the device is not part of a daisy-chain
+	if (spi->daisy_chain_devs == NULL)
+		return 0;
+
+	if (message->is_dma_mapped) {
+		dev_err(&spi->dev,
+			"DMA mapped transfer is not support when on daisy chain");
+		return -EINVAL;
+	}
+
+	if (!list_is_singular(&message->transfers)) {
+		dev_err(&spi->dev,
+			"Mutliple transfer segments are not support when on daisy chain");
+		return -EINVAL;
+	}
+
+	message->daisy_chain_transfers = message->transfers;
+	INIT_LIST_HEAD(&message->transfers);
+
+	list_for_each_entry(spi_chain_dev, spi->daisy_chain_devs, devices) {
+		if (spi_chain_dev->spi == spi) {
+			tr = list_first_entry(&message->daisy_chain_transfers,
+					      struct spi_transfer,
+					      transfer_list);
+
+			//check if mode is not being changed
+			if (tr->tx_nbits)
+				switch (spi->mode &
+					(SPI_TX_DUAL | SPI_TX_QUAD)) {
+				case 0:
+					if (!(tr->tx_nbits & SPI_NBITS_SINGLE))
+						goto err_tx_mode;
+					break;
+
+				case SPI_TX_DUAL:
+					if (!(tr->tx_nbits & SPI_NBITS_DUAL))
+						goto err_tx_mode;
+					break;
+
+				case SPI_TX_QUAD:
+					if (!(tr->tx_nbits & SPI_NBITS_QUAD))
+						goto err_tx_mode;
+					break;
+
+				default:
+					goto err_tx_mode;
+				}
+
+			if (tr->rx_nbits)
+				switch (spi->mode &
+					(SPI_RX_DUAL | SPI_RX_QUAD)) {
+				case 0:
+					if (!(tr->rx_nbits & SPI_NBITS_SINGLE))
+						goto err_rx_mode;
+					break;
+
+				case SPI_RX_DUAL:
+					if (tr->rx_nbits & SPI_NBITS_DUAL)
+						goto err_rx_mode;
+					break;
+				case SPI_RX_QUAD:
+					if (tr->rx_nbits & SPI_NBITS_QUAD)
+						goto err_rx_mode;
+					break;
+				default:
+					goto err_rx_mode;
+				}
+
+			//check if frequency is not being changed
+			if (tr->speed_hz && tr->speed_hz != spi->max_speed_hz) {
+				dev_err(&spi->dev,
+					"Change of SPI frequency not supported when on daisy chain");
+				return -EINVAL;
+			}
+
+			//daisy chain operations has a regular length
+			if (tr->len == spi_chain_dev->no_operation.len) {
+				tr->bits_per_word = spi_chain_dev->no_operation
+							    .bits_per_word;
+				tr->cs_change = 0;
+
+				list_add_tail(&tr->transfer_list,
+					      &message->transfers);
+			}
+			//daisy chain operation has different than regular length
+			else {
+				if (tr->len > spi_chain_dev->no_operation.len) {
+					dev_err(&spi->dev,
+						"Transmission not supported");
+					return -EINVAL;
+				}
+
+				ntr = kzalloc(sizeof(*ntr), GFP_KERNEL);
+
+				if (!ntr)
+					return -ENOMEM;
+
+				message->daisy_chain_new_transfer = ntr;
+
+				ntr->len = spi_chain_dev->no_operation.len;
+				ntr->bits_per_word = spi_chain_dev->no_operation
+							     .bits_per_word;
+
+				//copy tx buffer
+				if (tr->tx_buf) {
+					ntr->tx_buf =
+						kmalloc(ntr->len, GFP_KERNEL);
+					if (!ntr->tx_buf) {
+						rc = -ENOMEM;
+						goto err_out;
+					}
+
+					//The daisy-chain padding is assumed to be right-justified,
+					//so unused tx bits are transferred first
+					memcpy((void *)((char *)ntr->tx_buf +
+							ntr->len - tr->len),
+					       tr->tx_buf, tr->len);
+				}
+
+				//allocate rx buffer
+				if (tr->rx_buf) {
+					ntr->rx_buf =
+						kmalloc(ntr->len, GFP_KERNEL);
+					if (!ntr->rx_buf) {
+						rc = -ENOMEM;
+						goto err_out;
+					}
+				}
+
+				list_add_tail(&ntr->transfer_list,
+					      &message->transfers);
+			}
+		} else
+			list_add_tail(
+				&spi_chain_dev->no_operation.transfer_list,
+				&message->transfers);
+	}
+
+	return 0;
+
+err_out:
+	kfree(ntr->tx_buf);
+	kfree(ntr->rx_buf);
+	kfree(ntr);
+	return rc;
+
+err_tx_mode:
+	dev_err(&spi->dev, "Unsupported tx mode on daisy chain");
+	return -EINVAL;
+
+err_rx_mode:
+	dev_err(&spi->dev, "Unsupported rx mode on daisy chain");
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(spi_daisy_chain_message_pre);
+
+/**
+ * spi_daisy_chain_message_post - generate SPI daisy chain message
+ * @spi: device with which data will be exchanged
+ * @message: describes the data transfers
+ *
+ * The call checks if the SPI device is part of daisy chain. If so, it
+ * removes no-operation codes of unaddressd device of a given chain.
+ **/
+
+void spi_daisy_chain_message_post(struct spi_device *spi,
+				  struct spi_message *message)
+{
+	struct spi_transfer *tr;
+
+	//the device is not part of a daisy-chain
+	if (spi->daisy_chain_devs == NULL)
+		return;
+
+	if (message->daisy_chain_new_transfer) {
+		tr = list_first_entry(&message->daisy_chain_transfers,
+				      struct spi_transfer, transfer_list);
+		if (tr->rx_buf)
+			//The daisy-chain padding is assumed to be right-justified,
+			//so unused rx bits were received first and can be skipped
+			memcpy((void *)tr->rx_buf,
+			       (char *)message->daisy_chain_new_transfer->rx_buf +
+				       message->daisy_chain_new_transfer->len -
+				       tr->len,
+			       tr->len);
+
+		kfree(message->daisy_chain_new_transfer->tx_buf);
+		kfree(message->daisy_chain_new_transfer->rx_buf);
+		kfree(message->daisy_chain_new_transfer);
+	}
+
+	list_del(&message->transfers);
+
+	message->transfers = message->daisy_chain_transfers;
+}
+EXPORT_SYMBOL_GPL(spi_daisy_chain_message_post);
+
+static void spi_daisy_chain_clean(struct list_head *daisy_chain_devs)
+{
+	struct spi_device *spi_dev;
+	struct spi_daisy_chain_device *spi_chain_dev;
+
+	list_for_each_entry(spi_chain_dev, daisy_chain_devs, devices) {
+		spi_dev = spi_chain_dev->spi;
+		spi_dev_put(spi_dev);
+		kfree(spi_chain_dev->no_operation.tx_buf);
+		kfree(spi_chain_dev);
+	}
+	list_del(daisy_chain_devs);
+	kfree(daisy_chain_devs);
+}
+
+static int spi_daisy_chain_driver_probe(struct spi_device *spi)
+{
+	struct device_node *nc;
+	struct spi_device *spi_dev;
+	struct spi_daisy_chain_device *spi_chain_dev;
+	struct spi_transfer *no_operation;
+	int w_size;
+	int rc;
+
+	//Initialise the SPI daisy-chain queue
+	spi->daisy_chain_devs =
+		kzalloc(sizeof(*spi->daisy_chain_devs), GFP_KERNEL);
+	if (!spi->daisy_chain_devs)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(spi->daisy_chain_devs);
+
+	for_each_available_child_of_node(spi->dev.of_node, nc) {
+		if (of_node_test_and_set_flag(nc, OF_POPULATED))
+			continue;
+
+		spi_chain_dev = kzalloc(sizeof(*spi_chain_dev), GFP_KERNEL);
+		if (!spi_chain_dev) {
+			rc = -ENOMEM;
+			goto err_out;
+		}
+
+		////////////////////////////////////////////////////////////
+		//extract daisy-chain no-operation command from devicetree
+		////////////////////////////////////////////////////////////
+		no_operation = &spi_chain_dev->no_operation;
+		if (of_property_read_u8(nc, "spi-daisy-chain-bits_per_word",
+					&no_operation->bits_per_word)) {
+			no_operation->bits_per_word = 8;
+		}
+
+		if (no_operation->bits_per_word > 32) {
+			dev_err(&spi->dev,
+				"device %pOF: 'spi-daisy-chain-bits_per_word' property can't by higher than 32",
+				nc);
+			rc = -EINVAL;
+			goto err_out_spi_chain;
+		}
+
+		if (of_property_read_u32(nc, "spi-daisy-chain-len",
+					 &no_operation->len)) {
+			dev_err(&spi->dev,
+				"device %pOF doesn't define 'spi-daisy-chain-len' property",
+				nc);
+			rc = -EINVAL;
+			goto err_out_spi_chain;
+		}
+
+		// SPI transfer length should be multiple of SPI word size
+		// where SPI word size should be power-of-two multiple
+		if (no_operation->bits_per_word <= 8)
+			w_size = 1;
+		else if (no_operation->bits_per_word <= 16)
+			w_size = 2;
+		else
+			w_size = 4;
+
+		/* No partial transfers accepted */
+		if (no_operation->len % w_size) {
+			rc = -EINVAL;
+			dev_err(&spi->dev,
+				"no partial transfers accepted (propeties 'spi-daisy-chain-len' and  spi-daisy-chain-bits_per_word of device %pOF",
+				nc);
+			rc = -EINVAL;
+			goto err_out_spi_chain;
+		}
+
+		no_operation->tx_buf = kmalloc(no_operation->len, GFP_KERNEL);
+		if (!no_operation->tx_buf) {
+			rc = -ENOMEM;
+			goto err_out_spi_chain;
+		}
+
+		if (of_property_read_u8_array(nc, "spi-daisy-chain-noop",
+					      (void *)no_operation->tx_buf,
+					      no_operation->len)) {
+			dev_err(&spi->dev,
+				"device %pOF doesn't define 'spi-daisy-chain-noop' property",
+				nc);
+			rc = -EINVAL;
+			goto err_out_tx_buf;
+		}
+
+		////////////////////////////
+		//allocate a new SPI device
+		////////////////////////////
+		spi_dev = spi_alloc_device(spi->controller);
+		if (!spi_dev) {
+			dev_err(&spi->dev, "spi_device alloc error for %pOF\n",
+				nc);
+			rc = -ENOMEM;
+			goto err_out_tx_buf;
+		}
+		spi_chain_dev->spi = spi_dev;
+		spi_dev->daisy_chain_devs = spi->daisy_chain_devs;
+
+		//select device driver
+		rc = of_modalias_node(nc, spi_dev->modalias,
+				      sizeof(spi_dev->modalias));
+		if (rc < 0) {
+			dev_err(&spi->dev, "cannot find modalias for %pOF\n",
+				nc);
+			goto err_out_spi_dev;
+		}
+
+		//store a pointer to the node in the device structure
+		of_node_get(nc);
+		spi_dev->dev.of_node = nc;
+
+		//add the SPI device to the chain
+		list_add_tail(&spi_chain_dev->devices, spi->daisy_chain_devs);
+	}
+
+	//////////////////////
+	//add all SPI devices
+	//////////////////////
+	list_for_each_entry(spi_chain_dev, spi->daisy_chain_devs, devices) {
+		spi_dev = spi_chain_dev->spi;
+
+		//All devices on the chain share settings of the daisy-chain node
+		//The individual settings of the SPI nodes are ignored
+		spi_dev->mode = spi->mode;
+		spi_dev->chip_select = spi->chip_select;
+		spi_dev->max_speed_hz = spi->max_speed_hz;
+
+		//Register the new device
+		rc = spi_add_device(spi_dev);
+		if (rc) {
+			dev_err(&spi->dev,
+				"spi_device register error on daisy chain %pOF\n",
+				spi_dev->dev.of_node);
+			of_node_put(nc);
+			goto err_out;
+		}
+	}
+
+	return 0;
+
+err_out_spi_dev:
+	spi_dev_put(spi_chain_dev->spi);
+err_out_tx_buf:
+	kfree(spi_chain_dev->no_operation.tx_buf);
+err_out_spi_chain:
+	kfree(spi_chain_dev);
+err_out:
+	spi_daisy_chain_clean(spi->daisy_chain_devs);
+	return rc;
+}
+
+static int spi_daisy_chain_driver_remove(struct spi_device *spi)
+{
+	spi_daisy_chain_clean(spi->daisy_chain_devs);
+	return 0;
+}
+
+static const struct of_device_id spi_daisy_chain_of_match[] = {
+	{
+		.compatible = "spi,daisy_chain",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, spi_daisy_chain_of_match);
+
+static struct spi_driver spi_daisy_chain_driver = {
+	.probe = spi_daisy_chain_driver_probe,
+	.remove = spi_daisy_chain_driver_remove,
+	.driver = {
+			.name = "daisy_chain",
+			.of_match_table = spi_daisy_chain_of_match,
+	},
+};
+module_spi_driver(spi_daisy_chain_driver);
+
+MODULE_AUTHOR("Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>");
+MODULE_DESCRIPTION("Driver handling SPI daisy chain");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:daisy_chain");
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8158e281f354..96c8ce572e2f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -18,6 +18,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/spi/spi-daisy_chain.h>
 #include <linux/of_gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/pm_runtime.h>
@@ -522,14 +523,34 @@ EXPORT_SYMBOL_GPL(spi_alloc_device);
 static void spi_dev_set_name(struct spi_device *spi)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&spi->dev);
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	struct spi_daisy_chain_device *spi_chain_dev;
+	int spi_dev_index;
+#endif
 
 	if (adev) {
 		dev_set_name(&spi->dev, "spi-%s", acpi_dev_name(adev));
 		return;
 	}
 
-	dev_set_name(&spi->dev, "%s.%u", dev_name(&spi->controller->dev),
-		     spi->chip_select);
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	if (spi->daisy_chain_devs != NULL) {
+		spi_dev_index = 0;
+		list_for_each_entry(spi_chain_dev, spi->daisy_chain_devs,
+				    devices){
+			if (spi_chain_dev->spi == spi)
+				break;
+			spi_dev_index++;
+		}
+
+		dev_set_name(&spi->dev, "%s.%u.%u",
+			     dev_name(&spi->controller->dev), spi->chip_select,
+			     spi_dev_index);
+
+	} else
+#endif
+		dev_set_name(&spi->dev, "%s.%u",
+			     dev_name(&spi->controller->dev), spi->chip_select);
 }
 
 static int spi_dev_check(struct device *dev, void *data)
@@ -573,15 +594,27 @@ int spi_add_device(struct spi_device *spi)
 	 * chipselect **BEFORE** we call setup(), else we'll trash
 	 * its configuration.  Lock against concurrent add() calls.
 	 */
-	mutex_lock(&spi_add_lock);
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	/* Do not lock the controller when registering the daisy_chain driver
+	 * as the last one wouldn't be able to register its subnodes
+	 */
+	if (strcmp((const char *)spi->dev.of_node->name, "daisy_chain") == 0)
+#endif
+		mutex_lock(&spi_add_lock);
 
-	status = bus_for_each_dev(&spi_bus_type, NULL, spi, spi_dev_check);
-	if (status) {
-		dev_err(dev, "chipselect %d already in use\n",
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	if (spi->daisy_chain_devs == NULL) {
+#endif
+		status = bus_for_each_dev(&spi_bus_type, NULL, spi,
+					  spi_dev_check);
+		if (status) {
+			dev_err(dev, "chipselect %d already in use\n",
 				spi->chip_select);
-		goto done;
+			goto done;
+		}
+#ifdef CONFIG_SPI_DAISY_CHAIN
 	}
-
+#endif
 	/* Descriptors take precedence */
 	if (ctlr->cs_gpiods)
 		spi->cs_gpiod = ctlr->cs_gpiods[spi->chip_select];
@@ -608,7 +641,10 @@ int spi_add_device(struct spi_device *spi)
 		dev_dbg(dev, "registered child %s\n", dev_name(&spi->dev));
 
 done:
-	mutex_unlock(&spi_add_lock);
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	if (strcmp((const char *)spi->dev.of_node->name, "daisy_chain") == 0)
+#endif
+		mutex_unlock(&spi_add_lock);
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_add_device);
@@ -3694,6 +3730,12 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	SPI_STATISTICS_INCREMENT_FIELD(&ctlr->statistics, spi_sync);
 	SPI_STATISTICS_INCREMENT_FIELD(&spi->statistics, spi_sync);
 
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	status = spi_daisy_chain_message_pre(spi, message);
+	if (status < 0)
+		return status;
+#endif
+
 	/* If we're not using the legacy transfer method then we will
 	 * try to transfer in the calling context so special case.
 	 * This code would be less tricky if we could remove the
@@ -3727,6 +3769,11 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 		status = message->status;
 	}
 	message->context = NULL;
+
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	spi_daisy_chain_message_post(spi, message);
+#endif
+
 	return status;
 }
 
diff --git a/include/linux/spi/spi-daisy_chain.h b/include/linux/spi/spi-daisy_chain.h
new file mode 100644
index 000000000000..8967292863b7
--- /dev/null
+++ b/include/linux/spi/spi-daisy_chain.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * A driver handling the SPI daisy chaines.
+ *
+ * Copyright (C) 2020 Fastree3D
+ *	Adrian Fiergolski <Adrian.Fiergolski@fastree3d.com>
+ */
+
+#ifndef __LINUX_SPI_DAISY_CHAIN_H
+#define __LINUX_SPI_DAISY_CHAIN_H
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+/**
+ * struct spi_daisy_chain - interface to a SPI device on a daisy chain
+ * @spi: SPI device on the daisy chain
+ * @no_operation: no-opeartion SPI message for the given device
+ * @devices: list of SPI devices sharing the given daisy chain
+ **/
+struct spi_daisy_chain_device {
+	struct spi_device *spi;
+	struct spi_transfer no_operation;
+	struct list_head devices;
+};
+
+extern int spi_daisy_chain_message_pre(struct spi_device *spi,
+				       struct spi_message *message);
+extern void spi_daisy_chain_message_post(struct spi_device *spi,
+					 struct spi_message *message);
+
+#endif /* __LINUX_SPI_DAISY_CHAIN_H */
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aac57b5b7c21..bdc6973606dd 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -111,6 +111,9 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  * @dev: Driver model representation of the device.
  * @controller: SPI controller used with the device.
  * @master: Copy of controller, for backwards compatibility.
+ * @daisy_chain_devs: list of all SPI devices on the daisy chain
+ *      used by the given SPI device.
+ *      Handled by the SPI daisy chain driver.
  * @max_speed_hz: Maximum clock rate to be used with this chip
  *	(on this board); may be changed by the device's driver.
  *	The spi_transfer.speed_hz can override this for each transfer.
@@ -160,6 +163,9 @@ struct spi_device {
 	struct device		dev;
 	struct spi_controller	*controller;
 	struct spi_controller	*master;	/* compatibility layer */
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	struct list_head        *daisy_chain_devs;
+#endif
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
@@ -945,6 +951,11 @@ struct spi_transfer {
 /**
  * struct spi_message - one multi-segment SPI transaction
  * @transfers: list of transfer segments in this transaction
+ * @daisy_chain_transfers: head of the original transfers queue.
+ *      Handled by the SPI daisy chain driver.
+ * @daisy_chain_new_transfer: pointer to an extra SPI transfer,
+ *      in case it had to be created.
+ *      Handled by the SPI daisy chain driver.
  * @spi: SPI device to which the transaction is queued
  * @is_dma_mapped: if true, the caller provided both dma and cpu virtual
  *	addresses for each transfer buffer
@@ -975,7 +986,11 @@ struct spi_transfer {
 struct spi_message {
 	struct list_head	transfers;
 
-	struct spi_device	*spi;
+#ifdef CONFIG_SPI_DAISY_CHAIN
+	struct list_head daisy_chain_transfers;
+	struct spi_transfer *daisy_chain_new_transfer;
+#endif
+	struct spi_device *spi;
 
 	unsigned		is_dma_mapped:1;
 
-- 
2.27.0

