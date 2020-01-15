Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2AF513CE32
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 21:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbgAOUrA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 15:47:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43144 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbgAOUq7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 15:46:59 -0500
Received: by mail-lj1-f195.google.com with SMTP id a13so20066555ljm.10
        for <linux-spi@vger.kernel.org>; Wed, 15 Jan 2020 12:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i0rsKZG+Ia9GjwY4618uVvZyjwsoQNI+Qryzm0I3wi8=;
        b=i1cII2Vj4qare5/mlE/cUDbsDZP680BBC1znFQFdcP/B2k0Loojs89ONt+1ozQG1M+
         LSvOOoZ0btFgg/a9OKdkyXwbujd6Y0yDnH1BTtqb55EVvD9Oa0+jynvhhMJC3vAyLut0
         72WiMvt8WzrE80Nl8d+IXegZKctP2ia3aqXxboSIcAJqmlQAy1F4yWNluMN2YaUNXaAS
         9TdeLmkCO4VEOe7SqGyw/oeCjiLsq6bPRlnFkezyg7+WqxQNzsY+po9pi6OndsKrl7Wu
         DBAe/zdr6LUbvmGB6VkQavvsWOAV4NDjXE+dPlBx3fxoc1RNy3LFkIj6wa6Uz5S0K0za
         ExiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=i0rsKZG+Ia9GjwY4618uVvZyjwsoQNI+Qryzm0I3wi8=;
        b=Lxh0i2HRvjC7FlPgA29kMUOfaECUUkZlosmDaAR3KkDE/ik2zMXVrXi4HDc83hbz4O
         EBUPz+nPAZNhN22AnOOomzrYZs2N+LfJU1cBZ57RrYGpDE6s5i98fRwEguM799bJyIgX
         Ps6Ge31px9XZ5gMr69dfPYYhqF0wVcddXN3CLwyR6La3IKGZl+GnFgcisMQxWiy+h9Cc
         JKYhwCiRs3oE5UF1Zv1ULPtqfIamDwGRer2Et+sqB3LkfXjUHZaBO3c18pK3BMCVcqYQ
         h6QGx0K2lXgWladIBmyp1adNV/8PoqBAW6lVDP1TpUF9IdGBvodELFgQDDe7HlydwtAA
         yikA==
X-Gm-Message-State: APjAAAXBGF6eYWE9+KfKQc9AqrjtsM5AcKjZnzc/aDGBLHpHz4b9bwWi
        0g/8nLqlbeoXK6vOei/zdMdahw==
X-Google-Smtp-Source: APXvYqyush8emI1aZ8zT1qHU4nG9wSviSLG7U9flCivEzNlEVzRTAf8Ow82oBazpBsHo82A9FqbZiQ==
X-Received: by 2002:a2e:6f19:: with SMTP id k25mr166165ljc.84.1579121215940;
        Wed, 15 Jan 2020 12:46:55 -0800 (PST)
Received: from wasted.cogentembedded.com ([2a00:1fa0:6cd:a260:4ed0:31e8:7f6c:3bc4])
        by smtp.gmail.com with ESMTPSA id j204sm9437237lfj.38.2020.01.15.12.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 12:46:55 -0800 (PST)
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v2] spi: add Renesas RPC-IF driver
To:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>,
        Chris Brandt <chris.brandt@renesas.com>
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <6515c5ec-8432-0b20-426d-0428bbdf3712@cogentembedded.com>
Date:   Wed, 15 Jan 2020 23:46:54 +0300
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
We only implement the 'spi-mem' interface -- there's no need to implemebt
the usual SPI driver methods...

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'for-next' branch of Mark Brown's 'spi.git' repo.
It depends on the memory RPC-IF driver (posted in December) in order to
build/work:

https://patchwork.kernel.org/patch/11283125/
https://patchwork.kernel.org/patch/11283127/

The known issue with writing to the JFFS2 file system (updates not surviving
unmount/remount) were inherited from the original driver by Mason Yang...

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
 drivers/spi/spi-rpc-if.c |  213 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)

Index: spi/drivers/spi/Kconfig
===================================================================
--- spi.orig/drivers/spi/Kconfig
+++ spi/drivers/spi/Kconfig
@@ -578,6 +578,12 @@ config SPI_RB4XX
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
@@ -87,6 +87,7 @@ obj-$(CONFIG_SPI_QCOM_QSPI)		+= spi-qcom
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
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// RPC-IF SPI/QSPI/Octa driver
+//
+// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+// Copyright (C) 2019 Macronix International Co., Ltd.
+// Copyright (C) 2019 Cogent Embedded, Inc.
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
+		default:
+			break;
+		}
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
+	return rpcif_io_xfer(rpc);
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
