Return-Path: <linux-spi+bounces-5239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B4A99FBBD
	for <lists+linux-spi@lfdr.de>; Wed, 16 Oct 2024 00:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75921F237D3
	for <lists+linux-spi@lfdr.de>; Tue, 15 Oct 2024 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1581D63E5;
	Tue, 15 Oct 2024 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xWI07tvl"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6F01B0F39
	for <linux-spi@vger.kernel.org>; Tue, 15 Oct 2024 22:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032885; cv=none; b=O+KSIxQSSxBRl0pkds/OiHK3t7de/gt4TTpo8MfYzvxTW/+b+GdZWYmA/QvVcejFOxEBS5bUHQFPqCClz2jWFAA4fjJeidjy1e1dIsF9l9kOy8RkNkUn9b8Pvlg1p9trPvTTLabGxZKoFfm3u8EiMz8qHx+ThM2K9Uh9fxGnHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032885; c=relaxed/simple;
	bh=Mgjuvwdo2HydUfgd42W4VV4rxA6h2xCUoef+R/nr3rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RnMh2fWj6pdGDR9jU0ZGvsxWMtlLojEimsxaJ3QlJKh68Z/A4HUTpOic0veXWQ0iDaFa1nuHtXTnrNZWAuuemyIljfoBgNDnoIrtfYQFuSBM28EQ3pzQVkNHisatFI2TA+gpdIjIMu6auUH8zq+0bCRyTqK4eOLVmHqvmkXwEoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xWI07tvl; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F04D82C06BE;
	Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1729032880;
	bh=lUZKKgNOJBW9oDYcfC2pQyQ5I7fTvR2cng42v1yR36I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xWI07tvl5s6PrYcGkt7oPEc5ezuSjXh/QHLPGCuotNCxhgCNb+s6Fd/kvj5nkRdBB
	 miq4LV8owfD+oFQuVGfin7uF3pVyNP4E1/+SAuT4y8HB4YYy1CxMxA9gtAhyKcItom
	 nkRBkpBerQTJUrZuhovxCPsF8txsEY/bFZxFfmiPsV/9YDZdtTv/V/R3uH1PfjzFIR
	 kV4oVhoK/nnIQYTrmU/XFLAQu6B+1jLKE6nsRShxohXU9PCv6oGStvmRmxG/Pf9zj8
	 BNR1z83aJ9nv0QVny9OoxlbCOTNx5fDrcSfpSddevhWBkPj65Ga5sd5fJhAYpTPXw5
	 RTuqiQ/Q99G3g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670ef2b00003>; Wed, 16 Oct 2024 11:54:40 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id A215513EE9C;
	Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id A0BC92820D4; Wed, 16 Oct 2024 11:54:40 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de,
	markus.stockhausen@gmx.de
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 3/3] spi: spi-mem: Add Realtek SPI-NAND controller
Date: Wed, 16 Oct 2024 11:54:34 +1300
Message-ID: <20241015225434.3970360-4-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
References: <20241015225434.3970360-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670ef2b0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=n9Sqmae0AAAA:8 a=VwQbUJbxAAAA:8 a=gda5hHJ6RUSo0eTSPEEA:9 a=3ZKOabzyN94A:10 a=UmAUUZEt6-oIqEbegvw9:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add a driver for the SPI-NAND controller on the RTL9300 family of
devices.

The controller supports
* Serial/Dual/Quad data with
* PIO and DMA data read/write operation
* Configurable flash access timing

There is a separate ECC controller on the RTL9300 which isn't currently
supported (instead we rely on the on-die ECC supported by most SPI-NAND
chips).

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v5:
    - None
    Changes in v4:
    - Fix up MAINTAINERS entry for renamed file
    Changes in v3:
    - drop wildcard rtl9300-snand compatible
    - Add SoC specific compatibles for the 4 known variants
    Changes in v2:
    - Spell my own name correctly
    - Remove unecessary rtl_snand_adjust_op_size()

 MAINTAINERS                         |   6 +
 drivers/spi/Kconfig                 |  11 +
 drivers/spi/Makefile                |   1 +
 drivers/spi/spi-realtek-rtl-snand.c | 405 ++++++++++++++++++++++++++++
 4 files changed, 423 insertions(+)
 create mode 100644 drivers/spi/spi-realtek-rtl-snand.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..cf020c566f4a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19272,6 +19272,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/dsa/realtek.yaml
 F:	drivers/net/dsa/realtek/*
=20
+REALTEK SPI-NAND
+M:	Chris Packham <chris.packham@alliedtelesis.co.nz>
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/realtek,rtl9301-snand.yaml
+F:	drivers/spi/spi-realtek-rtl-snand.c
+
 REALTEK WIRELESS DRIVER (rtlwifi family)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ec1550c698d5..33228a607c4b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -843,6 +843,17 @@ config SPI_PXA2XX
 config SPI_PXA2XX_PCI
 	def_tristate SPI_PXA2XX && PCI && COMMON_CLK
=20
+config SPI_REALTEK_SNAND
+	tristate "Realtek SPI-NAND Flash Controller"
+	depends on MACH_REALTEK_RTL || COMPILE_TEST
+	select REGMAP
+	help
+	  This enables support for the SPI-NAND Flash controller on
+	  Realtek SoCs.
+
+	  This driver does not support generic SPI. The implementation
+	  only supports the spi-mem interface.
+
 config SPI_ROCKCHIP
 	tristate "Rockchip SPI controller driver"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index a9b1bc259b68..9a3338236645 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -119,6 +119,7 @@ obj-$(CONFIG_SPI_ROCKCHIP)		+=3D spi-rockchip.o
 obj-$(CONFIG_SPI_ROCKCHIP_SFC)		+=3D spi-rockchip-sfc.o
 obj-$(CONFIG_SPI_RB4XX)			+=3D spi-rb4xx.o
 obj-$(CONFIG_MACH_REALTEK_RTL)		+=3D spi-realtek-rtl.o
+obj-$(CONFIG_SPI_REALTEK_SNAND)		+=3D spi-realtek-rtl-snand.o
 obj-$(CONFIG_SPI_RPCIF)			+=3D spi-rpc-if.o
 obj-$(CONFIG_SPI_RSPI)			+=3D spi-rspi.o
 obj-$(CONFIG_SPI_RZV2M_CSI)		+=3D spi-rzv2m-csi.o
diff --git a/drivers/spi/spi-realtek-rtl-snand.c b/drivers/spi/spi-realte=
k-rtl-snand.c
new file mode 100644
index 000000000000..23c42c8469e4
--- /dev/null
+++ b/drivers/spi/spi-realtek-rtl-snand.c
@@ -0,0 +1,405 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#define SNAFCFR 0x00
+#define   SNAFCFR_DMA_IE BIT(20)
+#define SNAFCCR 0x04
+#define SNAFWCMR 0x08
+#define SNAFRCMR 0x0c
+#define SNAFRDR 0x10
+#define SNAFWDR 0x14
+#define SNAFDTR 0x18
+#define SNAFDRSAR 0x1c
+#define SNAFDIR 0x20
+#define   SNAFDIR_DMA_IP BIT(0)
+#define SNAFDLR 0x24
+#define SNAFSR 0x40
+#define  SNAFSR_NFCOS BIT(3)
+#define  SNAFSR_NFDRS BIT(2)
+#define  SNAFSR_NFDWS BIT(1)
+
+#define CMR_LEN(len) ((len) - 1)
+#define CMR_WID(width) (((width) >> 1) << 28)
+
+struct rtl_snand {
+	struct device *dev;
+	struct regmap *regmap;
+	struct completion comp;
+};
+
+static irqreturn_t rtl_snand_irq(int irq, void *data)
+{
+	struct rtl_snand *snand =3D data;
+	u32 val =3D 0;
+
+	regmap_read(snand->regmap, SNAFSR, &val);
+	if (val & (SNAFSR_NFCOS | SNAFSR_NFDRS | SNAFSR_NFDWS))
+		return IRQ_NONE;
+
+	regmap_write(snand->regmap, SNAFDIR, SNAFDIR_DMA_IP);
+	complete(&snand->comp);
+
+	return IRQ_HANDLED;
+}
+
+static bool rtl_snand_supports_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	if (!spi_mem_default_supports_op(mem, op))
+		return false;
+	if (op->cmd.nbytes !=3D 1 || op->cmd.buswidth !=3D 1)
+		return false;
+	return true;
+}
+
+static void rtl_snand_set_cs(struct rtl_snand *snand, int cs, bool activ=
e)
+{
+	u32 val;
+
+	if (active)
+		val =3D ~(1 << (4 * cs));
+	else
+		val =3D ~0;
+
+	regmap_write(snand->regmap, SNAFCCR, val);
+}
+
+static int rtl_snand_wait_ready(struct rtl_snand *snand)
+{
+	u32 val;
+
+	return regmap_read_poll_timeout(snand->regmap, SNAFSR, val, !(val & SNA=
FSR_NFCOS),
+					0, 2 * USEC_PER_MSEC);
+}
+
+static int rtl_snand_xfer_head(struct rtl_snand *snand, int cs, const st=
ruct spi_mem_op *op)
+{
+	int ret;
+	u32 val, len =3D 0;
+
+	rtl_snand_set_cs(snand, cs, true);
+
+	val =3D op->cmd.opcode << 24;
+	len =3D 1;
+	if (op->addr.nbytes && op->addr.buswidth =3D=3D 1) {
+		val |=3D op->addr.val << ((3 - op->addr.nbytes) * 8);
+		len +=3D op->addr.nbytes;
+	}
+
+	ret =3D rtl_snand_wait_ready(snand);
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(snand->regmap, SNAFWCMR, CMR_LEN(len));
+	if (ret)
+		return ret;
+
+	ret =3D regmap_write(snand->regmap, SNAFWDR, val);
+	if (ret)
+		return ret;
+
+	ret =3D rtl_snand_wait_ready(snand);
+	if (ret)
+		return ret;
+
+	if (op->addr.buswidth > 1) {
+		val =3D op->addr.val << ((3 - op->addr.nbytes) * 8);
+		len =3D op->addr.nbytes;
+
+		ret =3D regmap_write(snand->regmap, SNAFWCMR,
+				   CMR_WID(op->addr.buswidth) | CMR_LEN(len));
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(snand->regmap, SNAFWDR, val);
+		if (ret)
+			return ret;
+
+		ret =3D rtl_snand_wait_ready(snand);
+		if (ret)
+			return ret;
+	}
+
+	if (op->dummy.nbytes) {
+		val =3D 0;
+
+		ret =3D regmap_write(snand->regmap, SNAFWCMR,
+				   CMR_WID(op->dummy.buswidth) | CMR_LEN(op->dummy.nbytes));
+		if (ret)
+			return ret;
+
+		ret =3D regmap_write(snand->regmap, SNAFWDR, val);
+		if (ret)
+			return ret;
+
+		ret =3D rtl_snand_wait_ready(snand);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static void rtl_snand_xfer_tail(struct rtl_snand *snand, int cs)
+{
+	rtl_snand_set_cs(snand, cs, false);
+}
+
+static int rtl_snand_xfer(struct rtl_snand *snand, int cs, const struct =
spi_mem_op *op)
+{
+	unsigned int pos, nbytes;
+	int ret;
+	u32 val, len =3D 0;
+
+	ret =3D rtl_snand_xfer_head(snand, cs, op);
+	if (ret)
+		goto out_deselect;
+
+	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
+		pos =3D 0;
+		len =3D op->data.nbytes;
+
+		while (pos < len) {
+			nbytes =3D len - pos;
+			if (nbytes > 4)
+				nbytes =3D 4;
+
+			ret =3D rtl_snand_wait_ready(snand);
+			if (ret)
+				goto out_deselect;
+
+			ret =3D regmap_write(snand->regmap, SNAFRCMR,
+					   CMR_WID(op->data.buswidth) | CMR_LEN(nbytes));
+			if (ret)
+				goto out_deselect;
+
+			ret =3D rtl_snand_wait_ready(snand);
+			if (ret)
+				goto out_deselect;
+
+			ret =3D regmap_read(snand->regmap, SNAFRDR, &val);
+			if (ret)
+				goto out_deselect;
+
+			memcpy(op->data.buf.in + pos, &val, nbytes);
+
+			pos +=3D nbytes;
+		}
+	} else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
+		pos =3D 0;
+		len =3D op->data.nbytes;
+
+		while (pos < len) {
+			nbytes =3D len - pos;
+			if (nbytes > 4)
+				nbytes =3D 4;
+
+			memcpy(&val, op->data.buf.out + pos, nbytes);
+
+			pos +=3D nbytes;
+
+			ret =3D regmap_write(snand->regmap, SNAFWCMR, CMR_LEN(nbytes));
+			if (ret)
+				goto out_deselect;
+
+			ret =3D regmap_write(snand->regmap, SNAFWDR, val);
+			if (ret)
+				goto out_deselect;
+
+			ret =3D rtl_snand_wait_ready(snand);
+			if (ret)
+				goto out_deselect;
+		}
+	}
+
+out_deselect:
+	rtl_snand_xfer_tail(snand, cs);
+
+	if (ret)
+		dev_err(snand->dev, "transfer failed %d\n", ret);
+
+	return ret;
+}
+
+static int rtl_snand_dma_xfer(struct rtl_snand *snand, int cs, const str=
uct spi_mem_op *op)
+{
+	int ret;
+	dma_addr_t buf_dma;
+	enum dma_data_direction dir;
+	u32 trig;
+
+	ret =3D rtl_snand_xfer_head(snand, cs, op);
+	if (ret)
+		goto out_deselect;
+
+	if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
+		dir =3D DMA_FROM_DEVICE;
+		trig =3D 0;
+	} else if (op->data.dir =3D=3D SPI_MEM_DATA_OUT) {
+		dir =3D DMA_TO_DEVICE;
+		trig =3D 1;
+	} else {
+		ret =3D -EOPNOTSUPP;
+		goto out_deselect;
+	}
+
+	buf_dma =3D dma_map_single(snand->dev, op->data.buf.in, op->data.nbytes=
, dir);
+	ret =3D dma_mapping_error(snand->dev, buf_dma);
+	if (ret)
+		goto out_deselect;
+
+	ret =3D regmap_write(snand->regmap, SNAFDIR, SNAFDIR_DMA_IP);
+	if (ret)
+		goto out_unmap;
+
+	ret =3D regmap_update_bits(snand->regmap, SNAFCFR, SNAFCFR_DMA_IE, SNAF=
CFR_DMA_IE);
+	if (ret)
+		goto out_unmap;
+
+	reinit_completion(&snand->comp);
+
+	ret =3D regmap_write(snand->regmap, SNAFDRSAR, buf_dma);
+	if (ret)
+		goto out_disable_int;
+
+	ret =3D regmap_write(snand->regmap, SNAFDLR,
+			   CMR_WID(op->data.buswidth) | (op->data.nbytes & 0xffff));
+	if (ret)
+		goto out_disable_int;
+
+	ret =3D regmap_write(snand->regmap, SNAFDTR, trig);
+	if (ret)
+		goto out_disable_int;
+
+	if (!wait_for_completion_timeout(&snand->comp, usecs_to_jiffies(20000))=
)
+		ret =3D -ETIMEDOUT;
+
+	if (ret)
+		goto out_disable_int;
+
+out_disable_int:
+	regmap_update_bits(snand->regmap, SNAFCFR, SNAFCFR_DMA_IE, 0);
+out_unmap:
+	dma_unmap_single(snand->dev, buf_dma, op->data.nbytes, dir);
+out_deselect:
+	rtl_snand_xfer_tail(snand, cs);
+
+	if (ret)
+		dev_err(snand->dev, "transfer failed %d\n", ret);
+
+	return ret;
+}
+
+static bool rtl_snand_dma_op(const struct spi_mem_op *op)
+{
+	switch (op->data.dir) {
+	case SPI_MEM_DATA_IN:
+	case SPI_MEM_DATA_OUT:
+		return op->data.nbytes > 32;
+	default:
+		return false;
+	}
+}
+
+static int rtl_snand_exec_op(struct spi_mem *mem, const struct spi_mem_o=
p *op)
+{
+	struct rtl_snand *snand =3D spi_controller_get_devdata(mem->spi->contro=
ller);
+	int cs =3D spi_get_chipselect(mem->spi, 0);
+
+	dev_dbg(snand->dev, "cs %d op cmd %02x %d:%d, dummy %d:%d, addr %08llx@=
%d:%d, data %d:%d\n",
+		cs, op->cmd.opcode,
+		op->cmd.buswidth, op->cmd.nbytes, op->dummy.buswidth,
+		op->dummy.nbytes, op->addr.val, op->addr.buswidth,
+		op->addr.nbytes, op->data.buswidth, op->data.nbytes);
+
+	if (rtl_snand_dma_op(op))
+		return rtl_snand_dma_xfer(snand, cs, op);
+	else
+		return rtl_snand_xfer(snand, cs, op);
+}
+
+static const struct spi_controller_mem_ops rtl_snand_mem_ops =3D {
+	.supports_op =3D rtl_snand_supports_op,
+	.exec_op =3D rtl_snand_exec_op,
+};
+
+static const struct of_device_id rtl_snand_match[] =3D {
+	{ .compatible =3D "realtek,rtl9301-snand" },
+	{ .compatible =3D "realtek,rtl9302b-snand" },
+	{ .compatible =3D "realtek,rtl9302c-snand" },
+	{ .compatible =3D "realtek,rtl9303-snand" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, rtl_snand_match);
+
+static int rtl_snand_probe(struct platform_device *pdev)
+{
+	struct rtl_snand *snand;
+	struct device *dev =3D &pdev->dev;
+	struct spi_controller *ctrl;
+	void __iomem *base;
+	const struct regmap_config rc =3D {
+		.reg_bits	=3D 32,
+		.val_bits	=3D 32,
+		.reg_stride	=3D 4,
+		.cache_type	=3D REGCACHE_NONE,
+	};
+	int irq, ret;
+
+	ctrl =3D devm_spi_alloc_host(dev, sizeof(*snand));
+	if (!ctrl)
+		return -ENOMEM;
+
+	snand =3D spi_controller_get_devdata(ctrl);
+	snand->dev =3D dev;
+
+	base =3D devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	snand->regmap =3D devm_regmap_init_mmio(dev, base, &rc);
+	if (IS_ERR(snand->regmap))
+		return PTR_ERR(snand->regmap);
+
+	init_completion(&snand->comp);
+
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret =3D dma_set_mask(snand->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set DMA mask\n");
+
+	ret =3D devm_request_irq(dev, irq, rtl_snand_irq, 0, "rtl-snand", snand=
);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq\n");
+
+	ctrl->num_chipselect =3D 2;
+	ctrl->mem_ops =3D &rtl_snand_mem_ops;
+	ctrl->bits_per_word_mask =3D SPI_BPW_MASK(8);
+	ctrl->mode_bits =3D SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QU=
AD;
+	device_set_node(&ctrl->dev, dev_fwnode(dev));
+
+	return devm_spi_register_controller(dev, ctrl);
+}
+
+static struct platform_driver rtl_snand_driver =3D {
+	.driver =3D {
+		.name =3D "realtek-rtl-snand",
+		.of_match_table =3D rtl_snand_match,
+	},
+	.probe =3D rtl_snand_probe,
+};
+module_platform_driver(rtl_snand_driver);
+
+MODULE_DESCRIPTION("Realtek SPI-NAND Flash Controller Driver");
+MODULE_LICENSE("GPL");
--=20
2.47.0


