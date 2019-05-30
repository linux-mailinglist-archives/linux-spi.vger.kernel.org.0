Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE1E3031C
	for <lists+linux-spi@lfdr.de>; Thu, 30 May 2019 22:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbfE3UDR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 May 2019 16:03:17 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:43476 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfE3UDQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 30 May 2019 16:03:16 -0400
Received: by mail-lj1-f169.google.com with SMTP id z5so7283278lji.10
        for <linux-spi@vger.kernel.org>; Thu, 30 May 2019 13:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bHSWvTa5shU3fjAz6sTgCszbw0cyn6+MSI/c1lDLRPo=;
        b=PkT0FMRNmV8EaMDDeWuXgIlKHnoIJq/gXAqavWLsVQe1GdVEUuYIu5Iltqa5JCPEIY
         xslaUeGRjjGyjhhThzHTK02Wcy7Vb+W+9LdIUoNIyDBKZiq9535yhTLcVJx9owdZxILb
         MmS7LjAWnK1XBwBpvr+BbX75u38NL1X0HfqbOv/7e8jWzyKBL/Px14BNPaC8bwzJz5St
         YHDU750uP47oyvgsw9ElSuq8/KmKmLHqU4NBLxJIQx6bgFdqsDPIfiOTDP3rc7qxb/Tt
         evpD2AhYcquwAfeIToIjYB4RsJsmH4MKlI6YBoB0rxA1uBQauDgDmT9w1tMf0dk4LNmE
         VnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=bHSWvTa5shU3fjAz6sTgCszbw0cyn6+MSI/c1lDLRPo=;
        b=jx9T6ZAz6GzzNxZ6JFi1vnmDC+Cny6eSmCNAnQE+SX0yXYiMEkAhs4LDy59HHYpOV4
         9fb+tTDWvqo1mHsoyaP1uicjrcngGCESdzrG19kYDuVFo4aFqv0FDNWcqtboCzgR4w9p
         JRA0egLd6TJ8Kz76KweGFPDmgFd37+cPklWqgFJFnbL0ymsreLSaDhNCZ6ajbP5gmcy1
         gHRvxErPs4Nhv/WTjPxP2q7YoAraxbW1/DyY1ckzy+SVbyKA0U2CRwHXZwibziRXqtxB
         WOt15oG3OXE0srDRJIgSIiq1uH4sU9vEc14qpniCygKZLfrTPNmucUwpA94efIFJWtoN
         vh/A==
X-Gm-Message-State: APjAAAUFB+rAtwSYiRthkS7tj/5H7dBwbXKY4BrYSIc9LJYo2yuCLoqT
        JnUqJHEvwCao4M7VVKdQnzc+x3VI8ao=
X-Google-Smtp-Source: APXvYqyeelmDoVrRYfn6ZEwoH1QlPgdxjkWAipaqvTEAJcfbq+ZOo8wX08PGQjt1HvptjY08vdI5og==
X-Received: by 2002:a2e:9193:: with SMTP id f19mr3289642ljg.111.1559246593341;
        Thu, 30 May 2019 13:03:13 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.85.65])
        by smtp.gmail.com with ESMTPSA id t22sm677699lje.58.2019.05.30.13.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 13:03:12 -0700 (PDT)
Subject: [PATCH RFC 2/2] mfd: add Renesas RPC-IF driver
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mason Yang <masonccyang@mxic.com.tw>, linux-spi@vger.kernel.org
References: <ad503d6e-4739-9744-64b4-fd13f44ea6fe@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <1538cadb-7c6a-2c4c-fe8c-960b25286950@cogentembedded.com>
Date:   Thu, 30 May 2019 23:03:11 +0300
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

Add the MFD driver for Renesas RPC-IF which registers either the SPI or
HyperFLash  device depending on the contents of the device tree subnode.
It also provides the absract "back end" device APIs that can be used by
the "front end" SPI/MTD drivers to talk to the real hardware.

Based on the original patch by Mason Yang <masonccyang@mxic.com.tw>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/mfd/Kconfig        |   10 
 drivers/mfd/Makefile       |    1 
 drivers/mfd/rpc-if.c       |  535 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/rpc-if.h |   85 +++++++
 4 files changed, 631 insertions(+)

Index: mfd/drivers/mfd/Kconfig
===================================================================
--- mfd.orig/drivers/mfd/Kconfig
+++ mfd/drivers/mfd/Kconfig
@@ -1002,6 +1002,16 @@ config MFD_RDC321X
 	  southbridge which provides access to GPIOs and Watchdog using the
 	  southbridge PCI device configuration space.
 
+config MFD_RPCIF
+	tristate "Renesas RPC-IF driver"
+	select MFD_CORE
+	select REGMAP_MMIO
+	depends on ARCH_RENESAS
+	help
+	  This supports Renesas R-Car Gen3 RPC-IF which provides either SPI
+	  host or HyperFlash. You'll have to select individual components
+	  under the corresponding menu.
+
 config MFD_RT5033
 	tristate "Richtek RT5033 Power Management IC"
 	depends on I2C
Index: mfd/drivers/mfd/Makefile
===================================================================
--- mfd.orig/drivers/mfd/Makefile
+++ mfd/drivers/mfd/Makefile
@@ -184,6 +184,7 @@ obj-$(CONFIG_MFD_INTEL_QUARK_I2C_GPIO)	+
 obj-$(CONFIG_LPC_SCH)		+= lpc_sch.o
 obj-$(CONFIG_LPC_ICH)		+= lpc_ich.o
 obj-$(CONFIG_MFD_RDC321X)	+= rdc321x-southbridge.o
+obj-$(CONFIG_MFD_RPCIF)		+= rpc-if.o
 obj-$(CONFIG_MFD_JANZ_CMODIO)	+= janz-cmodio.o
 obj-$(CONFIG_MFD_JZ4740_ADC)	+= jz4740-adc.o
 obj-$(CONFIG_MFD_TPS6586X)	+= tps6586x.o
Index: mfd/drivers/mfd/rpc-if.c
===================================================================
--- /dev/null
+++ mfd/drivers/mfd/rpc-if.c
@@ -0,0 +1,535 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RPC-IF MFD driver
+ *
+ * Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+ * Copyright (C) 2019 Macronix International Co., Ltd.
+ * Copyright (C) 2019 Cogent Embedded, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/rpc-if.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <asm/unaligned.h>
+
+#define RPCIF_CMNCR		0x0000	// R/W
+#define RPCIF_CMNCR_MD		BIT(31)
+#define RPCIF_CMNCR_SFDE	BIT(24) // undocumented bit but must be set
+#define RPCIF_CMNCR_MOIIO3(val)	(((val) & 0x3) << 22)
+#define RPCIF_CMNCR_MOIIO2(val)	(((val) & 0x3) << 20)
+#define RPCIF_CMNCR_MOIIO1(val)	(((val) & 0x3) << 18)
+#define RPCIF_CMNCR_MOIIO0(val)	(((val) & 0x3) << 16)
+#define RPCIF_CMNCR_MOIIO_HIZ	(RPCIF_CMNCR_MOIIO0(3) | \
+				 RPCIF_CMNCR_MOIIO1(3) | \
+				 RPCIF_CMNCR_MOIIO2(3) | RPCIF_CMNCR_MOIIO3(3))
+#define RPCIF_CMNCR_IO3FV(val)	(((val) & 0x3) << 14) // undocumented
+#define RPCIF_CMNCR_IO2FV(val)	(((val) & 0x3) << 12) // undocumented
+#define RPCIF_CMNCR_IO0FV(val)	(((val) & 0x3) << 8)
+#define RPCIF_CMNCR_IOFV_HIZ	(RPCIF_CMNCR_IO0FV(3) | RPCIF_CMNCR_IO2FV(3) | \
+				 RPCIF_CMNCR_IO3FV(3))
+#define RPCIF_CMNCR_BSZ(val)	(((val) & 0x3) << 0)
+
+#define RPCIF_SSLDR		0x0004	// R/W
+#define RPCIF_SSLDR_SPNDL(d)	(((d) & 0x7) << 16)
+#define RPCIF_SSLDR_SLNDL(d)	(((d) & 0x7) << 8)
+#define RPCIF_SSLDR_SCKDL(d)	(((d) & 0x7) << 0)
+
+#define RPCIF_DRCR		0x000C	// R/W
+#define RPCIF_DRCR_SSLN		BIT(24)
+#define RPCIF_DRCR_RBURST(v)	((((v) - 1) & 0x1F) << 16)
+#define RPCIF_DRCR_RCF		BIT(9)
+#define RPCIF_DRCR_RBE		BIT(8)
+#define RPCIF_DRCR_SSLE		BIT(0)
+
+#define RPCIF_DRCMR		0x0010	// R/W
+#define RPCIF_DRCMR_CMD(c)	(((c) & 0xFF) << 16)
+#define RPCIF_DRCMR_OCMD(c)	(((c) & 0xFF) << 0)
+
+#define RPCIF_DREAR		0x0014	// R/W
+#define RPCIF_DREAR_EAV(c)	(((c) & 0xf) << 16)
+#define RPCIF_DREAR_EAC(c)	(((c) & 0x7) << 0)
+
+#define RPCIF_DROPR		0x0018	// R/W
+
+#define RPCIF_DRENR		0x001C	// R/W
+#define RPCIF_DRENR_CDB(o)	(u32)((((o) & 0x3) << 30))
+#define RPCIF_DRENR_OCDB(o)	(((o) & 0x3) << 28)
+#define RPCIF_DRENR_ADB(o)	(((o) & 0x3) << 24)
+#define RPCIF_DRENR_OPDB(o)	(((o) & 0x3) << 20)
+#define RPCIF_DRENR_DRDB(o)	(((o) & 0x3) << 16)
+#define RPCIF_DRENR_DME		BIT(15)
+#define RPCIF_DRENR_CDE		BIT(14)
+#define RPCIF_DRENR_OCDE	BIT(12)
+#define RPCIF_DRENR_ADE(v)	(((v) & 0xF) << 8)
+#define RPCIF_DRENR_OPDE(v)	(((v) & 0xF) << 4)
+
+#define RPCIF_SMCR		0x0020	// R/W
+#define RPCIF_SMCR_SSLKP	BIT(8)
+#define RPCIF_SMCR_SPIRE	BIT(2)
+#define RPCIF_SMCR_SPIWE	BIT(1)
+#define RPCIF_SMCR_SPIE		BIT(0)
+
+#define RPCIF_SMCMR		0x0024	// R/W
+#define RPCIF_SMCMR_CMD(c)	(((c) & 0xFF) << 16)
+#define RPCIF_SMCMR_OCMD(c)	(((c) & 0xFF) << 0)
+
+#define RPCIF_SMADR		0x0028	// R/W
+#define RPCIF_SMOPR		0x002C	// R/W
+#define RPCIF_SMOPR_OPD3(o)	(((o) & 0xFF) << 24)
+#define RPCIF_SMOPR_OPD2(o)	(((o) & 0xFF) << 16)
+#define RPCIF_SMOPR_OPD1(o)	(((o) & 0xFF) << 8)
+#define RPCIF_SMOPR_OPD0(o)	(((o) & 0xFF) << 0)
+
+#define RPCIF_SMENR		0x0030	// R/W
+#define RPCIF_SMENR_CDB(o)	(((o) & 0x3) << 30)
+#define RPCIF_SMENR_OCDB(o)	(((o) & 0x3) << 28)
+#define RPCIF_SMENR_ADB(o)	(((o) & 0x3) << 24)
+#define RPCIF_SMENR_OPDB(o)	(((o) & 0x3) << 20)
+#define RPCIF_SMENR_SPIDB(o)	(((o) & 0x3) << 16)
+#define RPCIF_SMENR_DME		BIT(15)
+#define RPCIF_SMENR_CDE		BIT(14)
+#define RPCIF_SMENR_OCDE	BIT(12)
+#define RPCIF_SMENR_ADE(v)	(((v) & 0xF) << 8)
+#define RPCIF_SMENR_OPDE(v)	(((v) & 0xF) << 4)
+#define RPCIF_SMENR_SPIDE(v)	(((v) & 0xF) << 0)
+
+#define RPCIF_SMRDR0		0x0038	// R
+#define RPCIF_SMRDR1		0x003C	// R
+#define RPCIF_SMWDR0		0x0040	// W
+#define RPCIF_SMWDR1		0x0044	// W
+
+#define RPCIF_CMNSR		0x0048	// R
+#define RPCIF_CMNSR_SSLF	BIT(1)
+#define RPCIF_CMNSR_TEND	BIT(0)
+
+#define RPCIF_DRDMCR		0x0058	// R/W
+#define RPCIF_DMDMCR_DMCYC(v)	((((v) - 1) & 0x1F) << 0)
+
+#define RPCIF_DRDRENR		0x005C	// R/W
+#define RPCIF_DRDRENR_HYPE(v)	(((v) & 0x7) << 12)
+#define RPCIF_DRDRENR_ADDRE	BIT(8)
+#define RPCIF_DRDRENR_OPDRE	BIT(4)
+#define RPCIF_DRDRENR_DRDRE	BIT(0)
+
+#define RPCIF_SMDMCR		0x0060	// R/W
+#define RPCIF_SMDMCR_DMCYC(v)	((((v) - 1) & 0x1F) << 0)
+
+#define RPCIF_SMDRENR		0x0064	// R/W
+#define RPCIF_SMDRENR_HYPE(v)	(((v) & 0x7) << 12)
+#define RPCIF_SMDRENR_ADDRE	BIT(8)
+#define RPCIF_SMDRENR_OPDRE	BIT(4)
+#define RPCIF_SMDRENR_SPIDRE	BIT(0)
+
+#define RPCIF_PHYCNT		0x007C	// R/W
+#define RPCIF_PHYCNT_CAL	BIT(31)
+#define RPCIF_PHYCNT_OCTA_AA	BIT(22)
+#define RPCIF_PHYCNT_OCTA_SA	BIT(23)
+#define RPCIF_PHYCNT_EXDS	BIT(21)
+#define RPCIF_PHYCNT_OCT	BIT(20)
+#define RPCIF_PHYCNT_STRTIM(v)	(((v) & 0x7) << 15)
+#define RPCIF_PHYCNT_WBUF2	BIT(4)
+#define RPCIF_PHYCNT_WBUF	BIT(2)
+#define RPCIF_PHYCNT_PHYMEM(v)	(((v) & 0x3) << 0)
+
+#define RPCIF_PHYOFFSET1	0x0080	// R/W
+#define RPCIF_PHYOFFSET1_DDRTMG(v) (((v) & 0x3) << 28)
+#define RPCIF_PHYOFFSET2	0x0084	// R/W
+#define RPCIF_PHYOFFSET2_OCTTMG(v) (((v) & 0x7) << 8)
+
+#define RPCIF_DIRMAP_SIZE	0x4000000
+
+void rpcif_enable_rpm(struct rpcif *rpc)
+{
+	pm_runtime_enable(rpc->dev);
+}
+EXPORT_SYMBOL(rpcif_enable_rpm);
+
+void rpcif_disable_rpm(struct rpcif *rpc)
+{
+	pm_runtime_disable(rpc->dev);
+}
+EXPORT_SYMBOL(rpcif_disable_rpm);
+
+void rpcif_hw_init(struct rpcif *rpc, bool hyperflash)
+{
+	pm_runtime_get_sync(rpc->dev);
+
+	/*
+	 * NOTE: The 0x260 are undocumented bits, but they must be set.
+	 *	 RPCIF_PHYCNT_STRTIM is strobe timing adjustment bit,
+	 *	 0x0 : the delay is biggest,
+	 *	 0x1 : the delay is 2nd biggest,
+	 *	 On H3 ES1.x, the value should be 0, while on others,
+	 *	 the value should be 6.
+	 */
+	regmap_write(rpc->regmap, RPCIF_PHYCNT,
+		     RPCIF_PHYCNT_CAL | RPCIF_PHYCNT_STRTIM(6) |
+		     RPCIF_PHYCNT_PHYMEM(hyperflash ? 3 : 0) | 0x260);
+
+	/*
+	 * NOTE: The 0x1511144 are undocumented bits, but they must be set
+	 *       for RPCIF_PHYOFFSET1.
+	 *	 The 0x31 are undocumented bits, but they must be set
+	 *	 for RPCIF_PHYOFFSET2.
+	 */
+	regmap_write(rpc->regmap, RPCIF_PHYOFFSET1,
+		     RPCIF_PHYOFFSET1_DDRTMG(3) | 0x1511144);
+	regmap_write(rpc->regmap, RPCIF_PHYOFFSET2, 0x31 |
+		     RPCIF_PHYOFFSET2_OCTTMG(4));
+
+	regmap_write(rpc->regmap, RPCIF_SSLDR, RPCIF_SSLDR_SPNDL(7) |
+		     RPCIF_SSLDR_SLNDL(7) | RPCIF_SSLDR_SCKDL(7));
+	regmap_write(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD |
+		     RPCIF_CMNCR_SFDE | RPCIF_CMNCR_MOIIO_HIZ |
+		     RPCIF_CMNCR_IOFV_HIZ |
+		     RPCIF_CMNCR_BSZ(hyperflash ? 1 : 0));
+
+	pm_runtime_put(rpc->dev);
+}
+EXPORT_SYMBOL(rpcif_hw_init);
+
+static int wait_msg_xfer_end(struct rpcif *rpc)
+{
+	u32 sts;
+
+	return regmap_read_poll_timeout(rpc->regmap, RPCIF_CMNSR, sts,
+					sts & RPCIF_CMNSR_TEND, 0,
+					USEC_PER_SEC);
+}
+
+static u8 rpcif_bits_set(u32 nbytes)
+{
+	nbytes = clamp(nbytes, 1U, 4U);
+
+	return GENMASK(3, 4 - nbytes);
+}
+
+void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
+		   size_t *len)
+{
+	rpc->enable = 0;
+	rpc->command = 0;
+	rpc->xferlen = 0;
+	rpc->address = 0;
+	rpc->ddr = 0;
+
+	if (op->cmd.buswidth) {
+		rpc->enable  |= RPCIF_SMENR_CDE |
+				RPCIF_SMENR_CDB(ilog2(op->cmd.buswidth));
+		rpc->command |= RPCIF_SMCMR_CMD(op->cmd.opcode);
+		if (op->cmd.ddr)
+			rpc->ddr |= RPCIF_SMDRENR_HYPE(0x5);
+	}
+	if (op->ocmd.buswidth) {
+		rpc->enable  |= RPCIF_SMENR_OCDE |
+				RPCIF_SMENR_OCDB(ilog2(op->ocmd.buswidth));
+		rpc->command |= RPCIF_SMCMR_OCMD(op->ocmd.opcode);
+	}
+
+	if (op->addr.buswidth) {
+		rpc->enable |= RPCIF_SMENR_ADB(ilog2(op->addr.buswidth));
+		if (op->addr.nbytes == 4)
+			rpc->enable |= RPCIF_SMENR_ADE(0xf);
+		else
+			rpc->enable |= RPCIF_SMENR_ADE(0x7);
+		if (op->addr.ddr)
+			rpc->ddr |= RPCIF_SMDRENR_ADDRE;
+
+		if (offs && len)
+			rpc->address = *offs;
+		else
+			rpc->address = op->addr.val;
+	}
+
+	if (op->dummy.buswidth) {
+		rpc->enable |= RPCIF_SMENR_DME;
+		rpc->dummy   = RPCIF_SMDMCR_DMCYC(op->dummy.nbytes * 8 /
+						  op->dummy.buswidth);
+	}
+
+	if (op->option.buswidth) {
+		rpc->enable |= RPCIF_SMENR_OPDE(
+					rpcif_bits_set(op->option.nbytes)) |
+			       RPCIF_SMENR_OPDB(ilog2(op->option.buswidth));
+		if (op->option.ddr)
+			rpc->ddr |= RPCIF_SMDRENR_OPDRE;
+		rpc->option = op->option.val;
+	}
+
+	if (op->data.buswidth || (offs && len)) {
+		switch (op->data.dir) {
+		case RPCIF_DATA_IN:
+			rpc->smcr = RPCIF_SMCR_SPIRE;
+			break;
+		case RPCIF_DATA_OUT:
+			rpc->smcr = RPCIF_SMCR_SPIWE;
+			break;
+		default:
+			break;
+		}
+		if (op->data.ddr)
+			rpc->ddr |= RPCIF_SMDRENR_SPIDRE;
+
+		if (offs && len) {
+			rpc->enable |= RPCIF_SMENR_SPIDE(rpcif_bits_set(*len)) |
+				       RPCIF_SMENR_SPIDB(
+						ilog2(op->data.buswidth));
+			rpc->xferlen = *len;
+		} else {
+			rpc->enable |=
+				RPCIF_SMENR_SPIDE(
+					rpcif_bits_set(op->data.nbytes)) |
+				RPCIF_SMENR_SPIDB(ilog2(op->data.buswidth));
+			rpc->xferlen = op->data.nbytes;
+		}
+	}
+}
+EXPORT_SYMBOL(rpcif_prepare);
+
+int rpcif_io_xfer(struct rpcif *rpc, const void *tx_buf, void *rx_buf)
+{
+	u32 smenr, smcr, data, pos = 0;
+	int ret = 0;
+
+	pm_runtime_get_sync(rpc->dev);
+
+	regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD,
+			   RPCIF_CMNCR_MD);
+	regmap_write(rpc->regmap, RPCIF_SMCMR, rpc->command);
+	regmap_write(rpc->regmap, RPCIF_SMDMCR, rpc->dummy);
+	regmap_write(rpc->regmap, RPCIF_SMADR, rpc->address);
+	regmap_write(rpc->regmap, RPCIF_SMDRENR, rpc->ddr);
+	smenr = rpc->enable;
+
+	if (tx_buf) {
+		while (pos < rpc->xferlen) {
+			u32 nbytes = rpc->xferlen - pos;
+
+			regmap_write(rpc->regmap, RPCIF_SMWDR0,
+				     get_unaligned((u32 *)(tx_buf + pos)));
+
+			smcr = rpc->smcr | RPCIF_SMCR_SPIE;
+
+			if (nbytes > 4) {
+				nbytes = 4;
+				smcr |= RPCIF_SMCR_SSLKP;
+			}
+
+			regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
+			regmap_write(rpc->regmap, RPCIF_SMCR, smcr);
+			ret = wait_msg_xfer_end(rpc);
+			if (ret)
+				goto err_out;
+
+			pos += nbytes;
+			smenr = rpc->enable &
+				~RPCIF_SMENR_CDE & ~RPCIF_SMENR_ADE(0xf);
+		}
+	} else if (rx_buf) {
+		/*
+		 * RPC-IF spoils the data for the commands without an address
+		 * phase (like RDID) in the manual mode, so we'll have to work
+		 * around this issue by using the external address space read
+		 * mode instead.
+		 */
+		if (!(smenr & RPCIF_SMENR_ADE(0xf)) && rpc->dirmap) {
+			regmap_update_bits(rpc->regmap, RPCIF_CMNCR,
+					   RPCIF_CMNCR_MD, 0);
+			regmap_write(rpc->regmap, RPCIF_DRCR,
+				     RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
+			regmap_write(rpc->regmap, RPCIF_DREAR,
+				     RPCIF_DREAR_EAC(1));
+			regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
+			regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
+			regmap_write(rpc->regmap, RPCIF_DROPR, 0);
+			regmap_write(rpc->regmap, RPCIF_DRENR,
+				     smenr & ~RPCIF_SMENR_SPIDE(0xf));
+			memcpy_fromio(rx_buf, rpc->dirmap, rpc->xferlen);
+			regmap_write(rpc->regmap, RPCIF_DRCR, RPCIF_DRCR_RCF);
+		} else {
+			while (pos < rpc->xferlen) {
+				u32 nbytes = rpc->xferlen - pos;
+
+				if (nbytes > 4)
+					nbytes = 4;
+
+				regmap_write(rpc->regmap, RPCIF_SMENR, smenr);
+				regmap_write(rpc->regmap, RPCIF_SMCR,
+					     rpc->smcr	| RPCIF_SMCR_SPIE);
+				ret = wait_msg_xfer_end(rpc);
+				if (ret)
+					goto err_out;
+
+				regmap_read(rpc->regmap, RPCIF_SMRDR0, &data);
+				memcpy(rx_buf + pos, &data, nbytes);
+				pos += nbytes;
+
+				regmap_write(rpc->regmap, RPCIF_SMADR,
+					     rpc->address + pos);
+			}
+		}
+	} else {
+		regmap_write(rpc->regmap, RPCIF_SMENR, rpc->enable);
+		regmap_write(rpc->regmap, RPCIF_SMCR,
+			     rpc->smcr | RPCIF_SMCR_SPIE);
+		ret = wait_msg_xfer_end(rpc);
+		if (ret)
+			goto err_out;
+	}
+
+exit:
+	pm_runtime_put(rpc->dev);
+	return ret;
+
+err_out:
+	ret = reset_control_reset(rpc->rstc);
+	goto exit;
+}
+EXPORT_SYMBOL(rpcif_io_xfer);
+
+ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
+{
+	loff_t from = offs & (RPCIF_DIRMAP_SIZE - 1);
+	size_t size = RPCIF_DIRMAP_SIZE - from;
+	int rc;
+
+	if (len > size)
+		len = size;
+
+	rc = pm_runtime_get_sync(rpc->dev);
+
+	regmap_update_bits(rpc->regmap, RPCIF_CMNCR, RPCIF_CMNCR_MD, 0);
+	regmap_write(rpc->regmap, RPCIF_DRCR,
+		     RPCIF_DRCR_RBURST(32) | RPCIF_DRCR_RBE);
+
+	regmap_write(rpc->regmap, RPCIF_DRCMR, rpc->command);
+	regmap_write(rpc->regmap, RPCIF_DREAR,
+		     RPCIF_DREAR_EAV(offs >> 25) | RPCIF_DREAR_EAC(1));
+	regmap_write(rpc->regmap, RPCIF_DROPR, rpc->option);
+	regmap_write(rpc->regmap, RPCIF_DRENR,
+		     rpc->enable & ~RPCIF_SMENR_SPIDE(0xF));
+	regmap_write(rpc->regmap, RPCIF_DRDMCR, rpc->dummy);
+	regmap_write(rpc->regmap, RPCIF_DRDRENR, rpc->ddr);
+
+	memcpy_fromio(buf, rpc->dirmap + from, len);
+
+	pm_runtime_put(rpc->dev);
+
+	return len;
+}
+EXPORT_SYMBOL(rpcif_dirmap_read);
+
+static const struct mfd_cell rpcif_hf_ctlr = {
+	.name = "rpcif-hyperflash",
+};
+
+static const struct mfd_cell rpcif_spi_ctlr = {
+	.name = "rpcif-spi",
+};
+
+static const struct regmap_range rpcif_volatile_ranges[] = {
+	regmap_reg_range(RPCIF_SMRDR0, RPCIF_SMRDR1),
+	regmap_reg_range(RPCIF_SMWDR0, RPCIF_SMWDR1),
+	regmap_reg_range(RPCIF_CMNSR, RPCIF_CMNSR),
+};
+
+static const struct regmap_access_table rpcif_volatile_table = {
+	.yes_ranges	= rpcif_volatile_ranges,
+	.n_yes_ranges	= ARRAY_SIZE(rpcif_volatile_ranges),
+};
+
+static const struct regmap_config rpcif_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.fast_io = true,
+	.max_register = RPCIF_PHYOFFSET2,
+	.volatile_table = &rpcif_volatile_table,
+};
+
+static int rpcif_probe(struct platform_device *pdev)
+{
+	struct device_node *flash;
+	const struct mfd_cell *cell;
+	struct resource *res;
+	void __iomem *base;
+	struct rpcif *rpc;
+
+	flash = of_get_next_child(pdev->dev.of_node, NULL);
+	if (!flash) {
+		dev_warn(&pdev->dev, "no flash node found\n");
+		return -ENODEV;
+	}
+
+	if (of_device_is_compatible(flash, "jedec,spi-nor")) {
+		cell = &rpcif_spi_ctlr;
+	} else if (of_device_is_compatible(flash, "cfi-flash")) {
+		cell = &rpcif_hf_ctlr;
+	} else {
+		dev_warn(&pdev->dev, "unknown flash type\n");
+		return -ENODEV;
+	}
+
+	rpc = devm_kzalloc(&pdev->dev, sizeof(*rpc), GFP_KERNEL);
+	if (!rpc)
+		return -ENOMEM;
+
+	rpc->dev = &pdev->dev;
+
+	rpc->clk_rpcif = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(rpc->clk_rpcif))
+		return PTR_ERR(rpc->clk_rpcif);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	rpc->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					    &rpcif_regmap_config);
+	if (IS_ERR(rpc->regmap)) {
+		dev_err(&pdev->dev,
+			"failed to init regmap for rpcif, error %ld\n",
+			PTR_ERR(rpc->regmap));
+		return	PTR_ERR(rpc->regmap);
+	}
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
+	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rpc->dirmap))
+		rpc->dirmap = NULL;
+
+	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rpc->rstc))
+		return PTR_ERR(rpc->rstc);
+
+	platform_set_drvdata(pdev, rpc);
+
+	return devm_mfd_add_devices(&pdev->dev, -1, cell, 1, NULL, 0, NULL);
+}
+
+static const struct of_device_id rpcif_of_match[] = {
+	{ .compatible = "renesas,rcar-gen3-rpcif", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rpcif_of_match);
+
+static struct platform_driver rpcif_driver = {
+	.probe = rpcif_probe,
+	.driver = {
+		.name =	"rpcif",
+		.of_match_table = rpcif_of_match,
+	},
+};
+module_platform_driver(rpcif_driver);
+
+MODULE_DESCRIPTION("Renesas RPC-IF MFD driver");
+MODULE_LICENSE("GPL v2");
Index: mfd/include/linux/mfd/rpc-if.h
===================================================================
--- /dev/null
+++ mfd/include/linux/mfd/rpc-if.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
+ * Copyright (C) 2019 Macronix International Co., Ltd.
+ *
+ * R-Car Gen3 RPC-IF MFD driver
+ *
+ * Author:
+ *	Mason Yang <masonccyang@mxic.com.tw>
+ */
+
+#ifndef __MFD_RPC_IF_H
+#define __MFD_RPC_IF_H
+
+#include <linux/types.h>
+
+enum rpcif_data_dir {
+	RPCIF_NO_DATA,
+	RPCIF_DATA_IN,
+	RPCIF_DATA_OUT,
+};
+
+struct	rpcif_op {
+	struct {
+		u8 buswidth;
+		u8 opcode;
+		bool ddr;
+	} cmd, ocmd;
+
+	struct {
+		u8 nbytes;
+		u8 buswidth;
+		bool ddr;
+		u64 val;
+	} addr;
+
+	struct {
+		u8 nbytes;
+		u8 buswidth;
+	} dummy;
+
+	struct {
+		u8 nbytes;
+		u8 buswidth;
+		bool ddr;
+		u32 val;
+	} option;
+
+	struct {
+		u8 buswidth;
+		enum rpcif_data_dir dir;
+		unsigned int nbytes;
+		bool ddr;
+		union {
+			void *in;
+			const void *out;
+		} buf;
+	} data;
+};
+
+struct	rpcif {
+	struct device *dev;
+	struct clk *clk_rpcif;
+	void __iomem *dirmap;
+	struct regmap *regmap;
+	struct reset_control *rstc;
+	u32 enable;
+	u32 command;
+	u32 address;
+	u32 dummy;
+	u32 option;
+	u32 ddr;
+	u32 smcr;
+	u32 xferlen;
+};
+
+void rpcif_enable_rpm(struct rpcif *rpc);
+void rpcif_disable_rpm(struct rpcif *rpc);
+void rpcif_hw_init(struct rpcif *rpc, bool hyperflash);
+void rpcif_prepare(struct rpcif *rpc, const struct rpcif_op *op, u64 *offs,
+		   size_t *len);
+int rpcif_io_xfer(struct rpcif *rpc, const void *tx_buf, void *rx_buf);
+ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf);
+
+#endif // __MFD_RPC_IF_H
