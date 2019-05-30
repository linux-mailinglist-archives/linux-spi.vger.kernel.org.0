Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8024730344
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2019 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3UYJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 May 2019 16:24:09 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42134 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfE3UYI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 May 2019 16:24:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id y13so6038017lfh.9
        for <linux-spi@vger.kernel.org>; Thu, 30 May 2019 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lzqaA2oXTs80JrOOEGUnDfXlW9LpN4dYlBoEtlpaYbE=;
        b=Um/HLNHZUI/i9/PaUQOE7woCAq3nMjSZf4nhMjxzMYByxyMWBppyDfIYz+TyaANJDA
         AFGjLBbbJl9CpUb3BaNrmLkm+f7RZ7xZ9mEYIOYvkzJ9J/ZSvblq2UnrsizFz2dWykDp
         1qkzmWaFNajoR8VeK9XS+MmaIWf2KJGouh5SdI3Ae2aRz0K58cdsC2bcgVNwNsCFGLu2
         qCfMTQO4PYIvbxkYt+HBRVdVlIUA6/NJfIttJa2I7cFnVShyk90ZnpCHsPZVsK6zx4tu
         KDsQbBJqHl334T7poialsedp2HAeWCF2Oo6ydK6ENdvOuFKPcDv1zrr3Ttqh70zmDoqX
         jTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lzqaA2oXTs80JrOOEGUnDfXlW9LpN4dYlBoEtlpaYbE=;
        b=GjcethQcncGYgec4DhkSV33VesnWroZGq37iRaH7Q2dlUaA+tgmLWTyztyXkNg8qdk
         OGmILIr22/tOakk5X9JxQrL78uWHq7cUHc1ztYcdmUhTtG4xNZjuB7zHn6cbhq+nmGVH
         VWVHCuO8P3XBDL0JxsfxyCGqQ/SGFurlUlkyDK9D9ca9Aau/pVNgLOfadYXxZe4MGnda
         LPXZfasES0/kYZZXNXyapCXCWW24eWQGNNusZEQbthhVL0xCkPwfti+ihmKjKW2GshO1
         BFLcnhA74QGeBzRycDMlyqbQOF55ZfV0NXGjNzOuFzwHZ4MqVIPYEBmzKpIywDWlCJdN
         exxw==
X-Gm-Message-State: APjAAAVARPIR7+SNBB5FZJyJZ37h/dejPMMMtX8BYGA5UddczKqoWNsi
        I4QY1I8A5jpJRYu3pfKGB9xWyw==
X-Google-Smtp-Source: APXvYqyjAWee04qQaEUS9NT49oBYNLa9C/K9RwtUdy+dVe+IxnpmOoHoJt69F8BEwlrrW3Hac8ryEw==
X-Received: by 2002:ac2:5383:: with SMTP id g3mr3255117lfh.107.1559247845899;
        Thu, 30 May 2019 13:24:05 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.65])
        by smtp.gmail.com with ESMTPSA id q124sm679391ljq.75.2019.05.30.13.24.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 13:24:05 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH RFC] spi: add Renesas RPC-IF driver
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Mason Yang <masonccyang@mxic.com.tw>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <beb35895-f531-977b-4766-d1e17f9b1d13@cogentembedded.com>
Date:   Thu, 30 May 2019 23:24:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add the SPI driver for the Renesas RPC-IF. It's the "front end" driver
using the "back end" APIs in the main (MFD) driver to talk to the real
hardware.

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'for-next' branch of Mark Brown's 'spi.git' repo.
It depends on the (just posted) RPC-IF MFD driver in order to build/work.
The known issue with writing to the JFFS2 filesystem (updates not surviving
unmount/remount) were inherited from the original driver by Mason Yang...

 drivers/spi/Kconfig      |    7 
 drivers/spi/Makefile     |    1 
 drivers/spi/spi-rpc-if.c |  339 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 347 insertions(+)

Index: spi/drivers/spi/Kconfig
===================================================================
--- spi.orig/drivers/spi/Kconfig
+++ spi/drivers/spi/Kconfig
@@ -564,6 +564,13 @@ config SPI_RB4XX
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
 
+config SPI_RPCIF
+	tristate "Renesas RPC-IF SPI driver"
+	select MFD_RPCIF
+	depends on ARCH_RENESAS || COMPILE_TEST
+	help
+	  SPI driver for Renesas R-Car Gen3 RPC-IF.
+
 config SPI_RSPI
 	tristate "Renesas RSPI/QSPI controller"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
Index: spi/drivers/spi/Makefile
===================================================================
--- spi.orig/drivers/spi/Makefile
+++ spi/drivers/spi/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom
 obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
 obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
 obj-$(CONFIG_SPI_RB4XX)			+= spi-rb4xx.o
+obj-$(CONFIG_SPI_RPCIF)			+= spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+= spi-rspi.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi-s3c24xx-hw.o
 spi-s3c24xx-hw-y			:= spi-s3c24xx.o
Index: spi/drivers/spi/spi-rpc-if.c
===================================================================
--- /dev/null
+++ spi/drivers/spi/spi-rpc-if.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RPC-IF SPI/QSPI/Octa driver
+ *
+ * Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+ * Copyright (C) 2019 Macronix International Co., Ltd.
+ * Copyright (C) 2019 Cogent Embedded, Inc.
+ */
+
+#include <linux/mfd/rpc-if.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#include <asm/unaligned.h>
+
+struct rpcif_spi {
+	struct rpcif *rpc;
+	u32 totalxferlen;
+	enum spi_mem_data_dir xfer_dir;
+};
+
+static void rpcif_spi_mem_set_prep_op_cfg(struct spi_device *spi_dev,
+					const struct spi_mem_op *spi_op,
+					struct rpcif_op *rpc_op,
+					u64 *offs, size_t *len)
+{
+	struct rpcif_spi *spi = spi_controller_get_devdata(spi_dev->controller);
+
+	rpc_op->cmd.opcode = spi_op->cmd.opcode;
+	rpc_op->cmd.buswidth = spi_op->cmd.buswidth;
+
+	spi->totalxferlen = 1;
+	spi->xfer_dir = SPI_MEM_NO_DATA;
+
+	if (spi_op->addr.nbytes) {
+		rpc_op->addr.buswidth = spi_op->addr.buswidth;
+		rpc_op->addr.nbytes = spi_op->addr.nbytes;
+		rpc_op->addr.val = spi_op->addr.val;
+		spi->totalxferlen += spi_op->addr.nbytes;
+	}
+
+	if (spi_op->dummy.nbytes) {
+		rpc_op->dummy.buswidth = spi_op->dummy.buswidth;
+		rpc_op->dummy.nbytes = spi_op->dummy.nbytes;
+		spi->totalxferlen += spi_op->dummy.nbytes;
+	}
+
+	if (spi_op->data.nbytes || (offs && len)) {
+		rpc_op->data.buswidth = spi_op->data.buswidth;
+		rpc_op->data.nbytes = spi_op->data.nbytes;
+		switch (spi_op->data.dir) {
+		case SPI_MEM_DATA_IN:
+			rpc_op->data.dir = RPCIF_DATA_IN;
+			rpc_op->data.buf.in = spi_op->data.buf.in;
+			break;
+		case SPI_MEM_DATA_OUT:
+			rpc_op->data.dir = RPCIF_DATA_OUT;
+			rpc_op->data.buf.out = spi_op->data.buf.out;
+			break;
+		default:
+			break;
+		}
+
+		if (offs && len)
+			spi->totalxferlen += *len;
+		else
+			spi->totalxferlen += spi_op->data.nbytes;
+	}
+
+	rpcif_prepare(spi->rpc, rpc_op, offs, len);
+}
+
+static bool rpcif_spi_mem_supports_op(struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
+	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4 ||
+	    op->addr.nbytes > 4)
+		return false;
+
+	return true;
+}
+
+static ssize_t rpcif_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+				       u64 offs, size_t len, void *buf)
+{
+	struct rpcif_spi *spi =
+		spi_controller_get_devdata(desc->mem->spi->controller);
+	struct rpcif_op rpc_op = {};
+
+	if (offs + desc->info.offset + len > U32_MAX)
+		return -EINVAL;
+
+	rpcif_spi_mem_set_prep_op_cfg(desc->mem->spi,
+				      &desc->info.op_tmpl, &rpc_op,
+				      &offs, &len);
+
+	return rpcif_dirmap_read(spi->rpc, offs, len, buf);
+}
+
+static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct rpcif_spi *spi =
+		spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -ENOTSUPP;
+
+	if (!rpcif_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+		return -ENOTSUPP;
+
+	if (!spi->rpc->dirmap &&
+	    desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+		return -ENOTSUPP;
+
+	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static int rpcif_spi_mem_exec_op(struct spi_mem *mem,
+			       const struct spi_mem_op *op)
+{
+	struct rpcif_spi *spi =
+		spi_controller_get_devdata(mem->spi->controller);
+	struct rpcif_op rpc_op = { };
+
+	rpcif_spi_mem_set_prep_op_cfg(mem->spi, op, &rpc_op, NULL, NULL);
+
+	return rpcif_io_xfer(spi->rpc,
+			   op->data.dir == SPI_MEM_DATA_OUT ?
+			   op->data.buf.out : NULL,
+			   op->data.dir == SPI_MEM_DATA_IN ?
+			   op->data.buf.in : NULL);
+}
+
+static const struct spi_controller_mem_ops rpcif_spi_mem_ops = {
+	.supports_op = rpcif_spi_mem_supports_op,
+	.exec_op = rpcif_spi_mem_exec_op,
+	.dirmap_create = rpcif_spi_mem_dirmap_create,
+	.dirmap_read = rpcif_spi_mem_dirmap_read,
+};
+
+static void rpcif_spi_transfer_setup(struct rpcif_spi *spi,
+				     struct spi_message *msg)
+{
+	struct spi_transfer *t, xfer[4] = { };
+	u32 i, xfercnt, xferpos = 0;
+	struct rpcif_op op = { };
+
+	spi->totalxferlen = 0;
+	spi->xfer_dir = SPI_MEM_NO_DATA;
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->tx_buf) {
+			xfer[xferpos].tx_buf = t->tx_buf;
+			xfer[xferpos].tx_nbits = t->tx_nbits;
+		}
+
+		if (t->rx_buf) {
+			xfer[xferpos].rx_buf = t->rx_buf;
+			xfer[xferpos].rx_nbits = t->rx_nbits;
+		}
+
+		if (t->len) {
+			xfer[xferpos++].len = t->len;
+			spi->totalxferlen  += t->len;
+		}
+
+		if (list_is_last(&t->transfer_list, &msg->transfers)) {
+			if (xferpos > 1) {
+				if (t->rx_buf)
+					spi->xfer_dir = SPI_MEM_DATA_IN;
+				else if (t->tx_buf)
+					spi->xfer_dir = SPI_MEM_DATA_OUT;
+			}
+		}
+	}
+
+	xfercnt = xferpos;
+	op.cmd.opcode = ((u8 *)xfer[0].tx_buf)[0];
+	op.cmd.buswidth = (unsigned int)xfer[0].tx_nbits;
+	op.addr.val = 0;
+
+	if (xfercnt > 2 && xfer[1].len && xfer[1].tx_buf) {
+		op.addr.buswidth = (unsigned int)xfer[1].tx_nbits;
+		op.addr.nbytes = xfer[1].len;
+
+		for (i = 0; i < xfer[1].len; i++)
+			op.addr.val |= ((u8 *)xfer[1].tx_buf)[i] <<
+				       (8 * (xfer[1].len - i - 1));
+	}
+
+	if (xfercnt > 3 && xfer[2].len && xfer[2].tx_buf) {
+		op.dummy.buswidth = (unsigned int)xfer[2].tx_nbits;
+		op.dummy.nbytes = xfer[2].len;
+	}
+
+	for (i = xfercnt - 1; i < xfercnt && xfercnt > 1; i++) {
+		if (xfer[i].len > op.data.nbytes)
+			op.data.nbytes = xfer[i].len;
+		if (xfer[i].rx_buf) {
+			if ((unsigned int)xfer[i].rx_nbits > op.data.buswidth)
+				op.data.buswidth =
+					(unsigned int)xfer[i].rx_nbits;
+		} else if (xfer[i].tx_buf) {
+			if ((unsigned int)xfer[i].tx_nbits > op.data.buswidth)
+				op.data.buswidth =
+					(unsigned int)xfer[i].tx_nbits;
+		}
+	}
+
+	rpcif_prepare(spi->rpc, &op, NULL, NULL);
+}
+
+static inline int rpcif_spi_xfer_message(struct rpcif_spi *spi,
+				       struct spi_transfer *data_xfer)
+{
+	return rpcif_io_xfer(spi->rpc,
+			   spi->xfer_dir == SPI_MEM_DATA_OUT ?
+			   data_xfer->tx_buf : NULL,
+			   spi->xfer_dir == SPI_MEM_DATA_IN ?
+			   data_xfer->rx_buf : NULL);
+}
+
+static int rpcif_spi_transfer_one_message(struct spi_controller *ctlr,
+					struct spi_message *msg)
+{
+	struct rpcif_spi *spi = spi_controller_get_devdata(ctlr);
+	struct spi_transfer *data_xfer;
+	int ret;
+
+	rpcif_spi_transfer_setup(spi, msg);
+
+	data_xfer = list_last_entry(&msg->transfers, struct spi_transfer,
+				    transfer_list);
+
+	ret = rpcif_spi_xfer_message(spi, data_xfer);
+	if (ret)
+		goto out;
+
+	msg->status = 0;
+	msg->actual_length = spi->totalxferlen;
+out:
+	spi_finalize_current_message(ctlr);
+	return 0;
+}
+
+static int rpcif_spi_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr;
+	struct rpcif *rpc = dev_get_drvdata(pdev->dev.parent);
+	struct rpcif_spi *spi;
+	int ret;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*spi));
+	if (!ctlr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctlr);
+
+	spi = spi_controller_get_devdata(ctlr);
+
+	spi->rpc = rpc;
+	ctlr->dev.of_node = pdev->dev.parent->of_node;
+
+	rpcif_enable_rpm(rpc);
+
+	ctlr->num_chipselect = 1;
+	ctlr->mem_ops = &rpcif_spi_mem_ops;
+	ctlr->transfer_one_message = rpcif_spi_transfer_one_message;
+
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
+
+	rpcif_hw_init(rpc, false);
+
+	ret = spi_register_controller(ctlr);
+	if (ret) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		goto err_put_ctlr;
+	}
+	return 0;
+
+err_put_ctlr:
+	spi_controller_put(ctlr);
+	rpcif_disable_rpm(rpc);
+
+	return ret;
+}
+
+static int rpcif_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct rpcif *rpc = dev_get_drvdata(pdev->dev.parent);
+
+	rpcif_disable_rpm(rpc);
+	spi_unregister_controller(ctlr);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int rpcif_spi_suspend(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_suspend(ctlr);
+}
+
+static int rpcif_spi_resume(struct device *dev)
+{
+	struct spi_controller *ctlr = dev_get_drvdata(dev);
+
+	return spi_controller_resume(ctlr);
+}
+
+static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
+#define DEV_PM_OPS	(&rpcif_spi_pm_ops)
+#else
+#define DEV_PM_OPS	NULL
+#endif
+
+static struct platform_driver rpcif_spi_driver = {
+	.probe = rpcif_spi_probe,
+	.remove = rpcif_spi_remove,
+	.driver = {
+		.name = "rpcif-spi",
+		.pm = DEV_PM_OPS,
+	},
+};
+module_platform_driver(rpcif_spi_driver);
+
+MODULE_DESCRIPTION("Renesas RPC-IF SPI driver");
+MODULE_LICENSE("GPL v2");
