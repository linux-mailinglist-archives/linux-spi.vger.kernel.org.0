Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACA41F84D9
	for <lists+linux-spi@lfdr.de>; Sat, 13 Jun 2020 21:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgFMTSl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 13 Jun 2020 15:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFMTSk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 13 Jun 2020 15:18:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47373C03E96F
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 12:18:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z206so7292086lfc.6
        for <linux-spi@vger.kernel.org>; Sat, 13 Jun 2020 12:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aWdyXT+IAXCqcWeeWuUcZZmSvTdGbv77goGm2SqhNUI=;
        b=z7MHaQbPmfysXN3xULbxXewOrFK1afkXME9u/h/V1El4pd7fLXJ8RwEZOur7fvr9YZ
         Ytp9BQ0XUxSFkwVlhltQTrpaXWrgKUoQtsblE/hbTc6M8DLS1/dfy9KgqiwsRRSnV4WV
         H6CU1I+9LNEsTSGy1T8uvmGs1Xfg1tOnQ6ARa+jj/OxBZfylImh1nDjRer1HYO0w34ey
         8HNPZE0yzlzcMss9LXlNYLyYO7I/mmLJCWI8ORNb+9440UlAdXmaRkXsmOsvRi6BHuUX
         oNe2FOOiqfm0MDMhJwSAZwd1adwnL6JtQhYL3RFiAzm8KxmSJKi9kScz/ib039adVHIc
         oj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=aWdyXT+IAXCqcWeeWuUcZZmSvTdGbv77goGm2SqhNUI=;
        b=JdefOPSayjKb6Maq3rgK4E+WkIkYxMZOBMqZxSbo2iqbFiHIji06V7ETAudf1tJuKj
         2YvhotVgrVUnMw/7bo1RU6CbrV3nXW3p+QYIyXK0V9wEf3CYI3+C4cJxS5BJeOC6T4QE
         xfYLq7e8TMkCouhOj10HYW1p+4RYOyIuqOMcd8iRbuyzOgIr2/s3XUZROJ7k3VaF6R9G
         eHzDSxKHzKLEGF6saPqa+kpqeB/MkysAIQk5gMoQwGuDaPpSV329uQIv7DM2CYYxN2B3
         8124iyfV3d+S2F9oX+wJ0+D6ZQUViEnEDXNSq7TytOA314Hw7uuYnyYBmUtQK/2GdlSK
         +qug==
X-Gm-Message-State: AOAM530qpXjNbCADPVclgDvNWk+GImf1Yb7nWshhH8hcbfIKsB6jHJv1
        FxZYs+hPkKuoxc57mL8i5CHp9A==
X-Google-Smtp-Source: ABdhPJyPKLB9FplkqcG8Wi4Is7b4Ucd+2lWClRA4ZbdMI7jevZ8PiJdicDjaUtN5RboUAKqeO1eXVA==
X-Received: by 2002:a19:f119:: with SMTP id p25mr9435675lfh.99.1592075916612;
        Sat, 13 Jun 2020 12:18:36 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:2e2:84d1:c335:1451:e577:e115])
        by smtp.gmail.com with ESMTPSA id 2sm2791128lji.100.2020.06.13.12.18.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2020 12:18:36 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v4] spi: add Renesas RPC-IF driver
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Chris Brandt <chris.brandt@renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1ece0e6c-71af-f0f1-709e-571f4b0b4853@cogentembedded.com>
Date:   Sat, 13 Jun 2020 22:18:34 +0300
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

Add the SPI driver for the Renesas RPC-IF.  It's the "front end" driver
using the "back end" APIs in the main driver to talk to the real hardware.
We only implement the 'spi-mem' interface -- there's no need to implement
the usual SPI driver methods...

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- refreshed the patch.

Changes in version 3:
- properly set up the direction field in rpcif_spi_mem_prepare() when there's
  no data;
- renamed rpcif_io_xfer() to rpcif_manual_xfer();
- extended Cogent Embedded's copyright to this year.

Changes in version 2:
- removed unneeded transfer_one_message() method and the related code;
- fixed up #include's as we switch from MFD to the memory core driver;
- removed unneeded #include <linux/pm_runtime.h>;
- removed 'struct rpcif_spi', replacing it with 'struct rpcif' everywhere;
- added spi_mem_default_supports_op() call to rpcif_spi_mem_supports_op();
- added rpcif_sw_init() call in rpcif_spi_probe();
- set SPI_CONTROLLER_HALF_DUPLEX flag in rpcif_spi_probe();
- added a new variable 'struct device *parent' and renamed the 'ret' variable
  to 'error' in rpcif_spi_probe();
- changed the order of calls in the error path of rpcif_spi_probe() and in
  rpcif_spi_remove();
- changed from 'select' to 'depends on' the main driver Kconfig symbol,
  removed 'depends on ARCH_RENESAS || COMPILE TEST';
- renamed rpcif_spi_mem_set_prep_op_cfg() to rpcif_spi_mem_prepare(), updated
  the rpcif_io_xfer() call there to match the RPC-IF core driver, changed
  'rpc_op' there from parameter into the local variable;
- changed the platform driver's name to "rpc-if-spi";
- fixed whitespace in rpcif_spi_mem_exec_op()'s prototype; 
- beautified the whitespace in the initializers of 'rpcif_spi_mem_ops' and
  'rpcif_spi_driver';
- changed the heading comment from /* */ to //;
- updated the patch description with more details.

 drivers/spi/Kconfig      |    6 +
 drivers/spi/Makefile     |    1 
 drivers/spi/spi-rpc-if.c |  216 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 223 insertions(+)

Index: spi/drivers/spi/Kconfig
===================================================================
--- spi.orig/drivers/spi/Kconfig
+++ spi/drivers/spi/Kconfig
@@ -605,6 +605,12 @@ config SPI_RB4XX
 	help
 	  SPI controller driver for the Mikrotik RB4xx series boards.
 
+config SPI_RPCIF
+	tristate "Renesas RPC-IF SPI driver"
+	depends on RENESAS_RPCIF
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
@@ -92,6 +92,7 @@ obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom
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
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// RPC-IF SPI/QSPI/Octa driver
+//
+// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+// Copyright (C) 2019 Macronix International Co., Ltd.
+// Copyright (C) 2019 - 2020 Cogent Embedded, Inc.
+//
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#include <memory/renesas-rpc-if.h>
+
+#include <asm/unaligned.h>
+
+static void rpcif_spi_mem_prepare(struct spi_device *spi_dev,
+				  const struct spi_mem_op *spi_op,
+				  u64 *offs, size_t *len)
+{
+	struct rpcif *rpc = spi_controller_get_devdata(spi_dev->controller);
+	struct rpcif_op rpc_op = { };
+
+	rpc_op.cmd.opcode = spi_op->cmd.opcode;
+	rpc_op.cmd.buswidth = spi_op->cmd.buswidth;
+
+	if (spi_op->addr.nbytes) {
+		rpc_op.addr.buswidth = spi_op->addr.buswidth;
+		rpc_op.addr.nbytes = spi_op->addr.nbytes;
+		rpc_op.addr.val = spi_op->addr.val;
+	}
+
+	if (spi_op->dummy.nbytes) {
+		rpc_op.dummy.buswidth = spi_op->dummy.buswidth;
+		rpc_op.dummy.ncycles  = spi_op->dummy.nbytes * 8 /
+					spi_op->dummy.buswidth;
+	}
+
+	if (spi_op->data.nbytes || (offs && len)) {
+		rpc_op.data.buswidth = spi_op->data.buswidth;
+		rpc_op.data.nbytes = spi_op->data.nbytes;
+		switch (spi_op->data.dir) {
+		case SPI_MEM_DATA_IN:
+			rpc_op.data.dir = RPCIF_DATA_IN;
+			rpc_op.data.buf.in = spi_op->data.buf.in;
+			break;
+		case SPI_MEM_DATA_OUT:
+			rpc_op.data.dir = RPCIF_DATA_OUT;
+			rpc_op.data.buf.out = spi_op->data.buf.out;
+			break;
+		case SPI_MEM_NO_DATA:
+			rpc_op.data.dir = RPCIF_NO_DATA;
+			break;
+		}
+	} else	{
+		rpc_op.data.dir = RPCIF_NO_DATA;
+	}
+
+	rpcif_prepare(rpc, &rpc_op, offs, len);
+}
+
+static bool rpcif_spi_mem_supports_op(struct spi_mem *mem,
+				      const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+
+	if (op->data.buswidth > 4 || op->addr.buswidth > 4 ||
+	    op->dummy.buswidth > 4 || op->cmd.buswidth > 4 ||
+	    op->addr.nbytes > 4)
+		return false;
+
+	return true;
+}
+
+static ssize_t rpcif_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
+					 u64 offs, size_t len, void *buf)
+{
+	struct rpcif *rpc =
+		spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (offs + desc->info.offset + len > U32_MAX)
+		return -EINVAL;
+
+	rpcif_spi_mem_prepare(desc->mem->spi, &desc->info.op_tmpl, &offs, &len);
+
+	return rpcif_dirmap_read(rpc, offs, len, buf);
+}
+
+static int rpcif_spi_mem_dirmap_create(struct spi_mem_dirmap_desc *desc)
+{
+	struct rpcif *rpc =
+		spi_controller_get_devdata(desc->mem->spi->controller);
+
+	if (desc->info.offset + desc->info.length > U32_MAX)
+		return -ENOTSUPP;
+
+	if (!rpcif_spi_mem_supports_op(desc->mem, &desc->info.op_tmpl))
+		return -ENOTSUPP;
+
+	if (!rpc->dirmap && desc->info.op_tmpl.data.dir == SPI_MEM_DATA_IN)
+		return -ENOTSUPP;
+
+	if (desc->info.op_tmpl.data.dir == SPI_MEM_DATA_OUT)
+		return -ENOTSUPP;
+
+	return 0;
+}
+
+static int rpcif_spi_mem_exec_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct rpcif *rpc =
+		spi_controller_get_devdata(mem->spi->controller);
+
+	rpcif_spi_mem_prepare(mem->spi, op, NULL, NULL);
+
+	return rpcif_manual_xfer(rpc);
+}
+
+static const struct spi_controller_mem_ops rpcif_spi_mem_ops = {
+	.supports_op	= rpcif_spi_mem_supports_op,
+	.exec_op	= rpcif_spi_mem_exec_op,
+	.dirmap_create	= rpcif_spi_mem_dirmap_create,
+	.dirmap_read	= rpcif_spi_mem_dirmap_read,
+};
+
+static int rpcif_spi_probe(struct platform_device *pdev)
+{
+	struct device *parent = pdev->dev.parent;
+	struct spi_controller *ctlr;
+	struct rpcif *rpc;
+	int error;
+
+	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
+	if (!ctlr)
+		return -ENOMEM;
+
+	rpc = spi_controller_get_devdata(ctlr);
+	rpcif_sw_init(rpc, parent);
+
+	platform_set_drvdata(pdev, ctlr);
+
+	ctlr->dev.of_node = parent->of_node;
+
+	rpcif_enable_rpm(rpc);
+
+	ctlr->num_chipselect = 1;
+	ctlr->mem_ops = &rpcif_spi_mem_ops;
+
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
+	ctlr->flags = SPI_CONTROLLER_HALF_DUPLEX;
+
+	rpcif_hw_init(rpc, false);
+
+	error = spi_register_controller(ctlr);
+	if (error) {
+		dev_err(&pdev->dev, "spi_register_controller failed\n");
+		goto err_put_ctlr;
+	}
+	return 0;
+
+err_put_ctlr:
+	rpcif_disable_rpm(rpc);
+	spi_controller_put(ctlr);
+
+	return error;
+}
+
+static int rpcif_spi_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct rpcif *rpc = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
+	rpcif_disable_rpm(rpc);
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
+	.probe	= rpcif_spi_probe,
+	.remove	= rpcif_spi_remove,
+	.driver = {
+		.name	= "rpc-if-spi",
+		.pm	= DEV_PM_OPS,
+	},
+};
+module_platform_driver(rpcif_spi_driver);
+
+MODULE_DESCRIPTION("Renesas RPC-IF SPI driver");
+MODULE_LICENSE("GPL v2");
