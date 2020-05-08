Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7175E1CB8A7
	for <lists+linux-spi@lfdr.de>; Fri,  8 May 2020 21:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEHTyP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 8 May 2020 15:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbgEHTyP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 8 May 2020 15:54:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DB1C061A0C
        for <linux-spi@vger.kernel.org>; Fri,  8 May 2020 12:54:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id z22so2388893lfd.0
        for <linux-spi@vger.kernel.org>; Fri, 08 May 2020 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ERfH2sIw/ZcBq3/Q+NCiy9N9FNeM5a3Q72ElHUyV8ec=;
        b=HS0TxsXifNESMPWmtdNRtxGUCJHJ7yvg3CB5yAT+q4GZvbUOVSCR743JzOiMO5MGHa
         YX1AxA/Ny2eBPLVIrJOAqfLsB+es0uq3sY079O5+vKKoNM/c5RbrDZwQXmT9o5VIVQMY
         IhQmkFAG0vejMgEbqSpr08L/cT1WrvDO09b21HtyB3oSTjniEkrl37vE4738PFb0InSF
         ufrDscLeZ/ay7mtgJyvoL6fzaEoVrXGuX5ssOx7D6rmjJEOMIA4nrj3F+t718H/t6GNC
         YxlhjstEJ73uMmzIQR/akb5Lzg/a18XjjQbI3D4tyoA8muR5r6260Uy5dVx6xM1R51Ke
         WR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ERfH2sIw/ZcBq3/Q+NCiy9N9FNeM5a3Q72ElHUyV8ec=;
        b=leI9NcYe4jP/HYWCzgq/82af3gndAmpTqCbrPwys8Rq/u3yZSeDzdub+1D3JKVNiEE
         HHQzt1Nq1NqOpPtoP6097rFrvS/lPSeswRoaWV4ikizyGYdQPYinSfkAm1A5O1z13k68
         m7MkV1E0qEfXcHJR9Vn25R0Ezx4M64A7ZvlxR6bTbQCD2PH8jYqIqjRXeu4BiXk7yTvw
         HKfEvex6dnQKcjzndOME8FcR/5/ocuMG/hyHv9JiCTo+ILxDt3dOdy8u08bq42gXqEv8
         K/D9j9iyHzAnkIB8Wedeit1lg3KH8Htyu9H1DOatvEQBqUci5GUWkB+OG3i7yz3hGpLd
         PA9A==
X-Gm-Message-State: AOAM530CM4VEgniMnITx7T4cc3u6hgt9DTg0zf1C1c0yb9Au8lhp4BTn
        Uf8cIQEwZRWn8N0fJQtXz3S60WSVmQ4=
X-Google-Smtp-Source: ABdhPJy8nIH+raLeFwrWRkIU1mgFy/g910B+SMwCe55TqG3UgyKY4IDSMzjp/omPW5hAQOfDpQYlDg==
X-Received: by 2002:a19:3fcb:: with SMTP id m194mr2956472lfa.181.1588967652047;
        Fri, 08 May 2020 12:54:12 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:222:bcfb:3767:1ed2:9bbb:4cab])
        by smtp.gmail.com with ESMTPSA id 186sm1988165lfo.37.2020.05.08.12.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 May 2020 12:54:11 -0700 (PDT)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v3] spi: add Renesas RPC-IF driver
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Chris Brandt <chris.brandt@renesas.com>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1ae47b2e-f51f-b3bb-bf11-aec38b157f9b@cogentembedded.com>
Date:   Fri, 8 May 2020 22:54:10 +0300
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
This patch is against the 'for-next' branch of Mark Brown's 'spi.git' repo.
It depends on the memory RPC-IF driver  in order to build/work:

https://patchwork.kernel.org/patch/11521595/
https://patchwork.kernel.org/patch/11521597/

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
@@ -602,6 +602,12 @@ config SPI_RB4XX
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
@@ -91,6 +91,7 @@ obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom
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
