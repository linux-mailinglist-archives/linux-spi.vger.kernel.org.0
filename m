Return-Path: <linux-spi+bounces-8058-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 573E2AB2527
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 21:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C702C4A357C
	for <lists+linux-spi@lfdr.de>; Sat, 10 May 2025 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AAA2367B7;
	Sat, 10 May 2025 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/XQHa4q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA426D4CA;
	Sat, 10 May 2025 19:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746906189; cv=none; b=rQ4Nu+Mm8mSrY5HwLanY84PCsCP0VxXomdwD91ZBqsWPBwKmuX6q6CNUWGAELgUrN3QFouZlqPgRPVdw2y16PwVk7E1Vy20LpbcMQWmolHRMKMMfnPKaFXOcd06zt0IZaU+ma3Qu9Xp4uMwrdjmO0IVbIu5/szGbV3s2BG2jj5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746906189; c=relaxed/simple;
	bh=MVc+D8UeDXfnWqkaT4VNih6uJUURgP2ypi9Yz0FaNNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o0K3WpSoRZSPVfwfd7dm4bfXVDwmX8Ms4vKkUNcY7lw+Uu9zOZaYK1f2D0vOQN75cUG5eEVIZETmJV5cFcoFFQCJU+mUwOzQSMVwbQLnFdar4QNL2kfkxurfKOfzhnM4HRDQPpct/BiKvpwx0nmKToVx3eh9WJzqVgXgvMf1I0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/XQHa4q; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-af5085f7861so2196351a12.3;
        Sat, 10 May 2025 12:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746906186; x=1747510986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBGCGR+DudjR4q+SCafR4sOWrb5VFF5pYEvlVG+7oyY=;
        b=Z/XQHa4qbrFc036hLrQITmgLazjYCqGZ2XfkvR90Yl7OWydokCvAT3i45Nzu9JCyoM
         q9wmLaqrxN1X8IfMi1Z/H6qFBGkP/A8EdxcewCHX7qO9us+juqvT2ne/dqTCBXd4vNyP
         CdpEGPNxtSS2zeYVug9P8JFYZwlW3CjSbbeqlmi6G/YWXPtv+3MbXKm5c7E2N1KnDXaA
         B5TcVlpd3CysxKGSoHaVPbJ0DcHFRAhGQvEGnn8aQqMf5Mr3JqjoLL5xBK/acclorWG8
         4U/IWQKt92g5UC2FKhkTMp2mezJQ/GS7kY6yfEghs+kLjWCg77YCBH17H7Q/7MLUxeQB
         gwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746906186; x=1747510986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBGCGR+DudjR4q+SCafR4sOWrb5VFF5pYEvlVG+7oyY=;
        b=SvgZzVULWTZZ+xYUPbCO/wEmQ/+ihlcXpco7UDIHIjN4yf9LgVUZ7GDeZmowroRLTc
         lIzFSPp4j4Zc3FUcCqkS4m0RptgvoX4qticM+vorwzGiykuH9x9Zwun1FT3keo/4vKMS
         +MDGRiblPs9dz8xutmK0oS5NE3dWvbSoPlW0drSzqj44lqpDkTfkEi0dJ/XvZvfR2smY
         /fWudtZdVIxYim50Mk+fDub2Pf5PzMiGtSe2y8YHl/Av+6ySAu/K/EW/2xweaIM7xTUQ
         1Tva+qes/ezRYrkkZ84QKNFq2M4a1Rqjyj7dNvWllhmYLQW40bWJmrBObGJCwwT8MU75
         GjQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuLJAugOKJYd58ZmUeFyeQJXJ5Xf8hzEhrYOf6Q0UZlB4++gBEagXuvtFNvrdBcFhqwfv/HFQDxPeUYrRm@vger.kernel.org, AJvYcCX0Ce08/2Hr7lOVfIQuNjYF74kaQU4yxQ4Q8zTJDjtdZR3BI5fWA/nxpFHpGScXG/IF1OQfMorZvZNQ@vger.kernel.org
X-Gm-Message-State: AOJu0YywQJat70SzOMvNSuRHVnkdccOEvJ45608+byqtUOw+CdWG3Wx4
	XSWmcWzNBRpoLj8UXM4x2ottLT9vaQGnW5TLYf4FJ+bdN/SyaxVA
X-Gm-Gg: ASbGncvno6s/MCo8Iz9KCIULMlaS8Ysar3VQ3e65BnfZuYisFP6Gqoip34fiOvnAZvi
	Ga9ZIBDL2wRcFjZXEaiX+8cgovCXMyxoZq5RWG3sNE25DImfHsC7TJa0421Hdc7+1V9M0caZfOT
	eyMhnFI+ve85f7kYZjYTQZ2f6Cl/LNQy78aEVtXKP4txC3DT/J9STF+cr82dn2KsA4rjW/2/cwP
	kQWVuoD9xrmeiNwQP0GozJRDH6zWs7M4Yo3+MCUbzTyPC32+Ej0bzX9pbwd6DThNexM1Lb5vwIq
	h2zLebiSDA/XNwjK6GhChLv8n/yYa+VJRPLi2eusFn2RJvMeUXeTpCHVKsBtAKghT4IeHHJ6MA=
	=
X-Google-Smtp-Source: AGHT+IFzKOJYasnUn+55LfFZE9jK2KzyBx3+B3BN8g1tgWlMPEY7JLwdXCS0DbglTGKj9lXo91xUqw==
X-Received: by 2002:a17:903:2351:b0:223:2cae:4a96 with SMTP id d9443c01a7336-22fc918c11emr108862695ad.42.1746906186030;
        Sat, 10 May 2025 12:43:06 -0700 (PDT)
Received: from NB-GIGA003.letovo.school ([5.194.95.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2523e67d53sm2223670a12.19.2025.05.10.12.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 12:43:05 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Date: Sat, 10 May 2025 23:42:22 +0400
Subject: [PATCH 2/3] mtd: spi-nor: Add a driver for the VIA/WonderMedia
 serial flash controller
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-wmt-sflash-v1-2-02a1ac6adf12@gmail.com>
References: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
In-Reply-To: <20250510-wmt-sflash-v1-0-02a1ac6adf12@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746906149; l=18425;
 i=alchark@gmail.com; s=20250416; h=from:subject:message-id;
 bh=MVc+D8UeDXfnWqkaT4VNih6uJUURgP2ypi9Yz0FaNNQ=;
 b=J3oAoN7HjFgJWUp6oIwA5GRzLKqmj1Ey7aBaqQmmbiQWIHo4LGQ1j7dsDLEdLrsI1q6obcOTK
 Zo5n9cFECFgAZu8iDEseuAHiPm/dN0g0GOjr21dpE2NGHiFblNNkK4f
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=ltKbQzKLTJPiDgPtcHxdo+dzFthCCMtC3V9qf7+0rkc=

The controller is tailored to SPI NOR flash memory and abstracts away all
SPI communications behind a small set of MMIO registers and a physical
memory mapping of the actual chip contents.

It doesn't expose chip probing functions beyond reading the ID though, so
use lower level chip opcodes via the "programmable command mode" of the
controller and the kernel's SPI NOR framework to avoid hard-coding chip
parameters for each ID the way the vendor kernel does it.

Currently tested on a WonderMedia WM8950 SoC with a Macronix MX25L4005A
flash chip (APC Rock board), but should work on all VIA/WonderMedia SoCs

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 MAINTAINERS                                  |   1 +
 drivers/mtd/spi-nor/controllers/Kconfig      |  14 +
 drivers/mtd/spi-nor/controllers/Makefile     |   1 +
 drivers/mtd/spi-nor/controllers/wmt-sflash.c | 525 +++++++++++++++++++++++++++
 4 files changed, 541 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f09c457bbfc5ef71a3f8379c111bac52b767cbbc..ff849c03a3b79a0487d3ab7e704ed11ffdb58f41 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3481,6 +3481,7 @@ F:	arch/arm/mach-vt8500/
 F:	drivers/clocksource/timer-vt8500.c
 F:	drivers/i2c/busses/i2c-viai2c-wmt.c
 F:	drivers/mmc/host/wmt-sdmmc.c
+F:	drivers/mtd/spi-nor/controllers/wmt-sflash.c
 F:	drivers/pwm/pwm-vt8500.c
 F:	drivers/rtc/rtc-vt8500.c
 F:	drivers/soc/vt8500/
diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index ca45dcd3ffe81f87dbf9ddc2a1535244ea92be20..aa8400b9aeaaec3b8b3f8996d501f5ac77a488ea 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -16,3 +16,17 @@ config SPI_NXP_SPIFI
 	  SPIFI is a specialized controller for connecting serial SPI
 	  Flash. Enable this option if you have a device with a SPIFI
 	  controller and want to access the Flash as a mtd device.
+
+config SPI_WMT_SFLASH
+	tristate "VIA/WonderMedia serial flash controller"
+	depends on ARCH_VT8500 || COMPILE_TEST
+	depends on OF
+	depends on HAS_IOMEM
+	help
+	  Enable support for the VIA/WonderMedia serial flash controller.
+
+	  This is the specialized controller driving SPI NOR flash chips
+	  inside VIA/WonderMedia SoCs. Most if not all VIA/WonderMedia
+	  based devices use SPI NOR flash as their boot storage, so select
+	  this if you need to access the primary or secondary bootloader
+	  and their environment partitions.
diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor/controllers/Makefile
index 0b8e1d5309138619bbfdf3e27639b6be2935e65e..9c0365354a37986755f3c067ba2f1f5708fd20ad 100644
--- a/drivers/mtd/spi-nor/controllers/Makefile
+++ b/drivers/mtd/spi-nor/controllers/Makefile
@@ -1,3 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
 obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
+obj-$(CONFIG_SPI_WMT_SFLASH)	+= wmt-sflash.o
diff --git a/drivers/mtd/spi-nor/controllers/wmt-sflash.c b/drivers/mtd/spi-nor/controllers/wmt-sflash.c
new file mode 100644
index 0000000000000000000000000000000000000000..d63c3402345a9dac7e8a0591bb032481ad3b02f7
--- /dev/null
+++ b/drivers/mtd/spi-nor/controllers/wmt-sflash.c
@@ -0,0 +1,525 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VIA/WonderMedia SPI NOR flash controller driver
+ *
+ * Copyright (c) 2025 Alexey Charkov <alchark@gmail.com>
+ */
+#include <linux/clk.h>
+#include <linux/bitops.h>
+#include <linux/errno.h>
+#include <linux/iopoll.h>
+#include <linux/log2.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/spi-nor.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#define SF_CHIP_SEL_0_CFG	0x000		/* chip select 0 config */
+#define SF_CHIP_SEL_1_CFG	0x008		/* chip select 0 config */
+#define SF_CHIP_SEL_CFG(x)	(8 * (x))
+#define SF_CHIP_SEL_ADDR	GENMASK(31, 16) /* 64kb aligned address */
+#define SF_CHIP_SEL_SIZE	GENMASK(11, 8)	/* log2(size/32kb) */
+
+#define SF_SPI_INTF_CFG		0x040	/* SPI interface config */
+#define SF_ADDR_WIDTH_32	BIT(0)	/* 0: 24 bit, 1: 32 bit addr */
+#define SF_USR_RD_CMD_MOD	BIT(4)	/* 0: normal, 1: user cmd read */
+#define SF_USR_WR_CMD_MOD	BIT(5)	/* 0: normal, 1: user cmd write */
+#define SF_PROG_CMD_MOD		BIT(6)	/* 0: normal, 1: prog cmd */
+#define SF_CS_DELAY		GENMASK(18, 16)	/* chip select delay */
+#define SF_RES_DELAY		GENMASK(27, 24) /* reset delay */
+#define SF_PDWN_DELAY		GENMASK(31, 28) /* power down delay */
+
+#define SF_SPI_RD_WR_CTR	0x050	/* read/write control */
+#define SF_RD_FAST		BIT(0)	/* 0: normal read, 1: fast read */
+#define SF_RD_ID		BIT(4)	/* 0: read status, 1: read ID */
+
+#define SF_SPI_WR_EN_CTR	0x060	/* write enable control */
+#define SF_CS0_WR_EN		BIT(0)
+#define SF_CS1_WR_EN		BIT(1)
+#define SF_CS_WR_EN(x)		BIT(x)
+
+#define SF_SPI_ER_CTR		0x070	/* erase control */
+#define SF_CHIP_ERASE		BIT(0)	/* full chip erase */
+#define SF_SEC_ERASE		BIT(15)	/* sector erase */
+
+#define SF_SPI_ER_START_ADDR	0x074	/* erase start address */
+#define SF_CHIP_ER_CS0		BIT(0)	/* erase chip 0 */
+#define SF_CHIP_ER_CS1		BIT(1)	/* erase chip 1 */
+#define SF_CHIP_ER_CS(x)	BIT(x)
+#define SF_ER_START_ADDR	GENMASK(31, 16)
+
+#define SF_SPI_ERROR_STATUS	0x080
+#define SF_MASLOCK_ERR		BIT(0)	/* master lock */
+#define SF_PCMD_ACC_ERR		BIT(1)	/* programmable cmd access */
+#define SF_PCMD_OP_ERR		BIT(2)	/* programmable cmd opcode */
+#define SF_PWR_DWN_ACC_ERR	BIT(3)	/* power down access */
+#define SF_MEM_REGION_ERR	BIT(4)	/* memory region */
+#define SF_WR_PROT_ERR		BIT(5)	/* write protection */
+#define SF_SPI_ERROR_CLEARALL	(SF_MASLOCK_ERR | \
+				 SF_PCMD_ACC_ERR | \
+				 SF_PCMD_OP_ERR | \
+				 SF_PWR_DWN_ACC_ERR | \
+				 SF_MEM_REGION_ERR | \
+				 SF_WR_PROT_ERR)
+
+#define SF_SPI_MEM_0_SR_ACC	0x100	/* status read from chip 0 */
+#define SF_SPI_MEM_1_SR_ACC	0x110	/* status read from chip 1 */
+#define SF_SPI_MEM_SR_ACC(x)	(0x100 + 0x10 * (x))
+
+#define SF_SPI_PDWN_CTR_0	0x180	/* power down chip 0 */
+#define SF_SPI_PDWN_CTR_1	0x190	/* power down chip 1 */
+#define SF_SPI_PDWN_CTR_(x)	(0x180 + 0x10 * (x))
+#define SF_PWR_DOWN		BIT(0)
+
+#define SF_SPI_PROG_CMD_CTR	0x200	/* programmable cmd control */
+#define SF_PROG_CMD_EN		BIT(0)	/* enable programmable cmd */
+#define SF_PROG_CMD_CS		GENMASK(1, 1)	/* chip select for cmd */
+#define SF_RX_DATA_SIZE		GENMASK(22, 16)	/* receive data size */
+#define SF_TX_DATA_SIZE		GENMASK(30, 24)	/* transmit data size */
+
+#define SF_SPI_USER_CMD_VAL	0x210
+#define SF_USR_RD_CMD		GENMASK(7, 0)	/* user read command */
+#define SF_USR_WR_CMD		GENMASK(23, 16)	/* user write command */
+
+#define SF_SPI_PROG_CMD_WBF	0x300	/* 64 bytes pcmd write buffer */
+#define SF_SPI_PROG_CMD_RBF	0x380	/* 64 bytes pcmd read buffer */
+
+#define SF_WAIT_TIMEOUT		1000000
+
+struct wmt_sflash_priv {
+	size_t			cs;
+	struct wmt_sflash_host	*host;
+	void __iomem		*mmap_base;
+	resource_size_t		mmap_phys;
+};
+
+#define SF_MAX_CHIP_NUM		2
+struct wmt_sflash_host {
+	struct device		*dev;
+	struct clk		*clk;
+
+	void __iomem		*regbase;
+	struct resource		*mmap_res[SF_MAX_CHIP_NUM];
+
+	struct spi_nor		*nor[SF_MAX_CHIP_NUM];
+	size_t			num_chips;
+};
+
+static int wmt_sflash_prep(struct spi_nor *nor)
+{
+	struct wmt_sflash_priv *priv = nor->priv;
+	struct wmt_sflash_host *host = priv->host;
+
+	return clk_prepare_enable(host->clk);
+}
+
+static void wmt_sflash_unprep(struct spi_nor *nor)
+{
+	struct wmt_sflash_priv *priv = nor->priv;
+	struct wmt_sflash_host *host = priv->host;
+
+	clk_disable_unprepare(host->clk);
+}
+
+static void wmt_sflash_pcmd_mode(struct wmt_sflash_host *host, bool enable)
+{
+	u32 reg = readl(host->regbase + SF_SPI_INTF_CFG);
+
+	reg &= ~SF_PROG_CMD_MOD;
+	reg |= FIELD_PREP(SF_PROG_CMD_MOD, enable);
+	writel(reg, host->regbase + SF_SPI_INTF_CFG);
+}
+
+static inline int wmt_sflash_wait_pcmd(struct wmt_sflash_host *host)
+{
+	u32 reg;
+
+	return readl_poll_timeout(host->regbase + SF_SPI_PROG_CMD_CTR, reg,
+		!(reg & SF_PROG_CMD_EN), 1, SF_WAIT_TIMEOUT);
+}
+
+static int wmt_sflash_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
+			       size_t len)
+{
+	struct wmt_sflash_priv *priv = nor->priv;
+	struct wmt_sflash_host *host = priv->host;
+	int ret;
+	u32 reg;
+
+	if (len > 64) {
+		dev_err(host->dev,
+		"Cannot read %d bytes from registers\n", len);
+		return -EINVAL;
+	}
+
+	wmt_sflash_pcmd_mode(host, true);
+	writeb(opcode, host->regbase + SF_SPI_PROG_CMD_WBF);
+
+	reg = SF_PROG_CMD_EN |
+	      FIELD_PREP(SF_PROG_CMD_CS, priv->cs) |
+	      FIELD_PREP(SF_TX_DATA_SIZE, 1) |
+	      FIELD_PREP(SF_RX_DATA_SIZE, len);
+	writel(reg, host->regbase + SF_SPI_PROG_CMD_CTR);
+
+	ret = wmt_sflash_wait_pcmd(host);
+
+	if (len)
+		memcpy_fromio(buf, host->regbase + SF_SPI_PROG_CMD_RBF, len);
+
+	wmt_sflash_pcmd_mode(host, false);
+
+	return ret;
+}
+
+static int wmt_sflash_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
+				size_t len)
+{
+	struct wmt_sflash_priv *priv = nor->priv;
+	struct wmt_sflash_host *host = priv->host;
+	int ret;
+	u32 reg;
+
+	if (len > 63) {
+		dev_err(host->dev,
+		"Cannot write %d bytes to registers\n", len);
+		return -EINVAL;
+	}
+
+	wmt_sflash_pcmd_mode(host, true);
+	writeb(opcode, host->regbase + SF_SPI_PROG_CMD_WBF);
+
+	if (len)
+		memcpy_toio(host->regbase + SF_SPI_PROG_CMD_WBF + 1, buf, len);
+
+	reg = SF_PROG_CMD_EN |
+	      FIELD_PREP(SF_PROG_CMD_CS, priv->cs) |
+	      FIELD_PREP(SF_TX_DATA_SIZE, len + 1);
+	writel(reg, host->regbase + SF_SPI_PROG_CMD_CTR);
+
+	ret = wmt_sflash_wait_pcmd(host);
+	wmt_sflash_pcmd_mode(host, false);
+
+	return ret;
+}
+
+static int wmt_sflash_wait_spi(struct wmt_sflash_priv *priv)
+{
+	struct wmt_sflash_host *host = priv->host;
+	int timeout = SF_WAIT_TIMEOUT;
+	u32 error;
+
+	while (timeout--) {
+		if (!(readl(host->regbase +
+			    SF_SPI_MEM_SR_ACC(priv->cs)) & 1))
+			return 0;
+
+		error = readl(host->regbase + SF_SPI_ERROR_STATUS);
+		if (error & SF_MASLOCK_ERR) {
+			dev_err(host->dev,
+				"Master lock error\n");
+			goto err;
+		}
+		if (error & SF_PCMD_ACC_ERR) {
+			dev_err(host->dev,
+				"Programmable command access error\n");
+			goto err;
+		}
+		if (error & SF_PCMD_OP_ERR) {
+			dev_err(host->dev,
+				"Programmable command opcode error\n");
+			goto err;
+		}
+		if (error & SF_PWR_DWN_ACC_ERR) {
+			dev_err(host->dev,
+				"Power down access error\n");
+			goto err;
+		}
+		if (error & SF_MEM_REGION_ERR) {
+			dev_err(host->dev,
+				"Memory region error\n");
+			goto err;
+		}
+		if (error & SF_WR_PROT_ERR) {
+			dev_err(host->dev,
+				"Write protection error\n");
+			goto err;
+		}
+	}
+	return 0;
+
+err:
+	writel(SF_SPI_ERROR_CLEARALL, host->regbase + SF_SPI_ERROR_STATUS);
+	return -EBUSY;
+}
+
+static ssize_t wmt_sflash_read(struct spi_nor *nor, loff_t from, size_t len,
+			       u_char *read_buf)
+{
+	struct wmt_sflash_priv *priv = nor->priv;
+	struct wmt_sflash_host *host = priv->host;
+	u32 reg = nor->read_opcode == SPINOR_OP_READ_FAST ? SF_RD_FAST : 0;
+
+	writel(reg, host->regbase + SF_SPI_RD_WR_CTR);
+
+	if (wmt_sflash_wait_spi(priv))
+		return 0;
+
+	memcpy_fromio(read_buf, priv->mmap_base + from, len);
+	return len;
+}
+
+static ssize_t wmt_sflash_write(struct spi_nor *nor, loff_t to, size_t len,
+				const u_char *write_buf)
+{
+	struct wmt_sflash_priv *priv = nor->priv;
+	struct wmt_sflash_host *host = priv->host;
+	size_t burst, offset = 0;
+
+	writel(SF_CS_WR_EN(priv->cs),
+	       host->regbase + SF_SPI_WR_EN_CTR);
+
+	while (offset < len) {
+		/* select 8 / 4 / 2 / 1 byte write length */
+		burst = 1 << min(3, ilog2(len - offset));
+		memcpy_toio(priv->mmap_base + to + offset,
+			    write_buf + offset, burst);
+
+		if (wmt_sflash_wait_spi(priv))
+			return offset;
+
+		offset += burst;
+	}
+
+	writel(0, host->regbase + SF_SPI_WR_EN_CTR);
+
+	return offset;
+}
+
+static int wmt_sflash_erase(struct spi_nor *nor, loff_t offs)
+{
+	struct wmt_sflash_priv *priv = nor->priv;
+	struct wmt_sflash_host *host = priv->host;
+	int ret = 0;
+	u32 reg;
+
+	if (offs & (SZ_64K - 1)) {
+		dev_err(host->dev,
+			"Erase offset 0x%llx not on 64k boundary\n", offs);
+		return -EINVAL;
+	}
+
+	writel(SF_CS_WR_EN(priv->cs),
+	       host->regbase + SF_SPI_WR_EN_CTR);
+
+	reg = SF_CHIP_ER_CS(priv->cs) |
+	      FIELD_PREP(SF_ER_START_ADDR, (priv->mmap_phys + offs) >> 16);
+	writel(reg, host->regbase + SF_SPI_ER_START_ADDR);
+
+	writel(SF_SEC_ERASE, host->regbase + SF_SPI_ER_CTR);
+
+	ret = wmt_sflash_wait_spi(priv);
+	writel(0, host->regbase + SF_SPI_WR_EN_CTR);
+
+	return ret;
+}
+
+static const struct spi_nor_controller_ops wmt_sflash_controller_ops = {
+	.prepare	= wmt_sflash_prep,
+	.unprepare	= wmt_sflash_unprep,
+	.read_reg	= wmt_sflash_read_reg,
+	.write_reg	= wmt_sflash_write_reg,
+	.read		= wmt_sflash_read,
+	.write		= wmt_sflash_write,
+	.erase		= wmt_sflash_erase,
+};
+
+static int wmt_sflash_register(struct device_node *np,
+				   struct wmt_sflash_host *host)
+{
+	const struct spi_nor_hwcaps hwcaps = {
+		.mask = SNOR_HWCAPS_READ |
+			SNOR_HWCAPS_READ_FAST |
+			SNOR_HWCAPS_PP,
+	};
+	struct device *dev = host->dev;
+	struct wmt_sflash_priv *priv;
+	struct mtd_info *mtd;
+	struct spi_nor *nor;
+	int ret;
+	u32 reg;
+
+	nor = devm_kzalloc(dev, sizeof(*nor), GFP_KERNEL);
+	if (!nor)
+		return -ENOMEM;
+
+	nor->dev = dev;
+	spi_nor_set_flash_node(nor, np);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(np, "reg", &priv->cs);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "There's no reg property for %pOF\n",
+				     np);
+
+	if (priv->cs >= SF_MAX_CHIP_NUM)
+		return dev_err_probe(dev, -ENXIO,
+				     "Chip select %d is out of bounds\n",
+				     priv->cs);
+
+	priv->host = host;
+	nor->priv = priv;
+	nor->controller_ops = &wmt_sflash_controller_ops;
+
+	ret = spi_nor_scan(nor, NULL, &hwcaps);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to scan SPI NOR chip\n");
+
+	mtd = &nor->mtd;
+	mtd->name = np->name;
+
+	priv->mmap_phys = host->mmap_res[priv->cs]->end - mtd->size + 1;
+	priv->mmap_phys &= -SZ_64K;
+
+	priv->mmap_base = devm_ioremap(dev, priv->mmap_phys, mtd->size);
+	if (IS_ERR(priv->mmap_base))
+		return dev_err_probe(dev, PTR_ERR(priv->mmap_base),
+			"Failed to map chip %d at address 0x%x size 0x%llx\n",
+			priv->cs, priv->mmap_phys, mtd->size);
+
+	reg = FIELD_PREP(SF_CHIP_SEL_ADDR, priv->mmap_phys >> 16) |
+	      FIELD_PREP(SF_CHIP_SEL_SIZE, order_base_2(mtd->size) - 15);
+	writel(reg, host->regbase + SF_CHIP_SEL_CFG(priv->cs));
+
+	reg = FIELD_PREP(SF_CS_DELAY, 3);
+	writel(reg, host->regbase + SF_SPI_INTF_CFG);
+
+	/* the controller only handles 64k aligned addresses */
+	mtd->erasesize = max(mtd->erasesize, SZ_64K);
+
+	ret = mtd_device_register(mtd, NULL, 0);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register MTD device\n");
+
+	host->nor[host->num_chips] = nor;
+	host->num_chips++;
+	return 0;
+}
+
+static void wmt_sflash_unregister_all(struct wmt_sflash_host *host)
+{
+	int i;
+
+	for (i = 0; i < host->num_chips; i++)
+		mtd_device_unregister(&host->nor[i]->mtd);
+}
+
+static int wmt_sflash_register_all(struct wmt_sflash_host *host)
+{
+	struct device *dev = host->dev;
+	struct device_node *np;
+	int ret;
+
+	for_each_available_child_of_node(dev->of_node, np) {
+		ret = wmt_sflash_register(np, host);
+		if (ret) {
+			of_node_put(np);
+			goto fail;
+		}
+
+		if (host->num_chips == SF_MAX_CHIP_NUM) {
+			dev_warn(dev, "Flash count exceeds the maximum chipselect number\n");
+			of_node_put(np);
+			break;
+		}
+	}
+	return 0;
+
+fail:
+	wmt_sflash_unregister_all(host);
+	return ret;
+}
+
+static int wmt_sflash_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct wmt_sflash_host *host;
+	char mmap_str[32];
+	int ret, i;
+
+	host = devm_kzalloc(dev, sizeof(*host), GFP_KERNEL);
+	if (!host)
+		return dev_err_probe(dev, -ENOMEM,
+			"Failed to allocate controller private data\n");
+
+	platform_set_drvdata(pdev, host);
+	host->dev = dev;
+
+	host->regbase = devm_platform_ioremap_resource_byname(pdev, "io");
+	if (IS_ERR(host->regbase))
+		return dev_err_probe(dev, PTR_ERR(host->regbase),
+			"Failed to remap controller MMIO registers\n");
+
+	for (i = 0; i < SF_MAX_CHIP_NUM; i++) {
+		snprintf(mmap_str, sizeof(mmap_str), "chip%d-mmap", i);
+
+		host->mmap_res[i] = platform_get_resource_byname(pdev,
+						IORESOURCE_MEM, mmap_str);
+		if (!host->mmap_res[i])
+			return dev_err_probe(dev, -ENXIO,
+				"Memory map region not found for chip %d\n",
+				i);
+	}
+
+	host->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(host->clk))
+		return dev_err_probe(dev, PTR_ERR(host->clk),
+			"Failed to get clock\n");
+
+	ret = clk_prepare_enable(host->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clock\n");
+
+	ret = wmt_sflash_register_all(host);
+
+	clk_disable_unprepare(host->clk);
+	return ret;
+}
+
+static void wmt_sflash_remove(struct platform_device *pdev)
+{
+	struct wmt_sflash_host *host = platform_get_drvdata(pdev);
+
+	wmt_sflash_unregister_all(host);
+}
+
+static const struct of_device_id wmt_sflash_dt_ids[] = {
+	{ .compatible = "via,vt8500-sflash"},
+	{ .compatible = "wm,wm8505-sflash"},
+	{ .compatible = "wm,wm8650-sflash"},
+	{ .compatible = "wm,wm8750-sflash"},
+	{ .compatible = "wm,wm8850-sflash"},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, wmt_sflash_dt_ids);
+
+static struct platform_driver wmt_sflash_driver = {
+	.driver = {
+		.name	= "wmt-sflash",
+		.of_match_table = wmt_sflash_dt_ids,
+	},
+	.probe	= wmt_sflash_probe,
+	.remove = wmt_sflash_remove,
+};
+module_platform_driver(wmt_sflash_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("VIA/WonderMedia SPI NOR flash controller driver");

-- 
2.49.0


