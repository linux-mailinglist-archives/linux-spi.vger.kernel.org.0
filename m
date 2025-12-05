Return-Path: <linux-spi+bounces-11801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B31CA91D7
	for <lists+linux-spi@lfdr.de>; Fri, 05 Dec 2025 20:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BE4C3181B22
	for <lists+linux-spi@lfdr.de>; Fri,  5 Dec 2025 19:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAD6322B66;
	Fri,  5 Dec 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ivBdp0CX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C8832E125
	for <linux-spi@vger.kernel.org>; Fri,  5 Dec 2025 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764963601; cv=none; b=ggahuGV4NlkCEor+ffLdcfR9HcuSTCYAikWwawhJZaYvjkkA8WKFAB/45fViBaTySefLnLErn0j7WcYuH29mBJ6M1Vo+i6+bLs76JMZgDpYae6Am5MUU5w0ez9FAuuOeH9wknSribENjnMUqLAEi6uDtNGUXfyyPJauNHvdzX54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764963601; c=relaxed/simple;
	bh=2GbAvy1Qw5k+Ex13ZF8rGtLEOuqfGDAb75VkLT269oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGyoHxUY0Vf9z+My/bUGV4r31P0AqVh4xd4QDCmR4kmgz29HY9x3At4Ly7QvcSVoJDF+l+2je4sRz52CmkWbXG6Yv2HbZHuV+Z+8+wNFE8Sf77LYFbPHJf7gw+QTBXkAtm33x6C2gGD8OXLXXitsMfq6UifLNTCnvGxTibIoJrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ivBdp0CX; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 6E47F1A1F9D;
	Fri,  5 Dec 2025 19:39:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 456F3606AC;
	Fri,  5 Dec 2025 19:39:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D5CB0102F1912;
	Fri,  5 Dec 2025 20:39:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764963596; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sVPNQ7cUFtk5zE8KkLKIlIZlmxcg1JpVSLwuIhQXnKA=;
	b=ivBdp0CXmxla8MF/ehBTkt1OxYIDldUWu8bIKlsLWF3/yBe/vA/ff9jP1J8B6Co3qNC0CO
	vc7O9p0skdr012rMhgRzml+WZ9ocxjJYcbFsZjPg91Wy+W3cevNH7kogR2tnoBA+andzqF
	eUalJ5t/lMOcrvdtcq9BfMn8dpPrbvRFi/sqtXwFE2Lm0cgLa/I/aw/SClSuUNsB0CdxIp
	JSu38S6oCv4P4iIC4Uzelx/iaodrh1oTQIIJEY8y8AODHmNxo16iDZFgO8R7q33bbdME7g
	U4ZMybsbFJ1gCasD/dsRtYZwQGdbTgr4wLqWfKrXgscg2jNYA+ORTGf8o6KM2A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 05 Dec 2025 20:38:58 +0100
Subject: [PATCH RFC 7/8] mtd: spinand: winbond: Add support for continuous
 reads on W35NxxJW
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251205-winbond-v6-18-rc1-cont-read-v1-7-01bc48631c73@bootlin.com>
References: <20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com>
In-Reply-To: <20251205-winbond-v6-18-rc1-cont-read-v1-0-01bc48631c73@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

W35N{01,02,04}JW support being read continuously under certain
circumstances. A bit must be set in their configuration register, and
a specific read from cache operation, a bit shorter than usual because
it no longer requires the address cycles, must be used for the occasion.

Setting the "enable" bit is already supported by the core, aside from
the subtlety of making sure the HFREQ bit is also set in octal DTR mode
above 90MHz. However, handling two different read from cache templates
involves creating a list of read from cache variants adapted the
continuous reads, ie. without address cycles.

Unfortunately, these operations, despite being very close to their
original read from cache cousins, are often unsupported by smart SPI
controller drivers because reading from cache historically allowed
changing the offset at which the host would start by providing a 2-byte
column address. In order to prevent issues with this, it has been
decided to implement these variants with a single "ignored" address byte
(respectively two in the octal DTR case), further reducing the amount of
dummy cycles needed before the first bit of data.

Enabling continuous reads has a side effect: the ECC status register now
may also return the value b11, which means that more than 1
uncorrectable error happened during the read. This non standard
behaviour requires to re-implement, almost identically the "get ECC"
helper from the core, with just an extra case for this value (it is
prefixed "w25w35nxxjw" because all these chips have the same behaviour).

Speed gain is substantial, see below. The flash_speed -C benchmark has
been run on a TI AM62A7 LP SK with CPU power management disabled,
mounted with a W35N01JW chip.

1S-8S-8S:

     1 page read speed is 15058 KiB/s
     2 page read speed is 15058 KiB/s
     3 page read speed is 16800 KiB/s
     4 page read speed is 17066 KiB/s
     5 page read speed is 18461 KiB/s
     6 page read speed is 18461 KiB/s
     7 page read speed is 19384 KiB/s
     8 page read speed is 19692 KiB/s
     9 page read speed is 19384 KiB/s
     10 page read speed is 20000 KiB/s
     11 page read speed is 20000 KiB/s
     12 page read speed is 20000 KiB/s
     13 page read speed is 20800 KiB/s
     14 page read speed is 20363 KiB/s
     15 page read speed is 20000 KiB/s
     16 page read speed is 19692 KiB/s
     32 page read speed is 19692 KiB/s
     64 page read speed is 19692 KiB/s

8D-8D-8D:

     1 page read speed is 23272 KiB/s
     2 page read speed is 23272 KiB/s
     3 page read speed is 28000 KiB/s
     4 page read speed is 32000 KiB/s
     5 page read speed is 34285 KiB/s
     6 page read speed is 34285 KiB/s
     7 page read speed is 36000 KiB/s
     8 page read speed is 36571 KiB/s
     9 page read speed is 36000 KiB/s
     10 page read speed is 34285 KiB/s
     11 page read speed is 36666 KiB/s
     12 page read speed is 40000 KiB/s
     13 page read speed is 41600 KiB/s
     14 page read speed is 37333 KiB/s
     15 page read speed is 40000 KiB/s
     16 page read speed is 36571 KiB/s
     32 page read speed is 42666 KiB/s
     64 page read speed is 42666 KiB/s

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Not all configurations have been tested/validated yet.
---
 drivers/mtd/nand/spi/winbond.c | 126 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 111 insertions(+), 15 deletions(-)

diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index d0c50eb93827..716ec0031dcc 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -15,9 +15,11 @@
 
 #define SPINAND_MFR_WINBOND		0xEF
 
+#define WINBOND_CFG_HFREQ		BIT(0)
 #define WINBOND_CFG_BUF_READ		BIT(3)
 
 #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
+#define W25W35NXXJW_STATUS_ECC_MULT_UNCOR	(3 << 4)
 
 #define W25N0XJW_SR4			0xD0
 #define W25N0XJW_SR4_HS			BIT(2)
@@ -29,6 +31,49 @@
 #define W35N01JW_VCR_IO_MODE_OCTAL_DDR		0xC7
 #define W35N01JW_VCR_DUMMY_CLOCK_REG	0x01
 
+/*
+ * Winbond chips ignore the address bytes during continuous reads, and
+ * because the dummy cycles are enough they indicate dropping the
+ * address cycles from the continuous read from cache variants. This is
+ * very poorly supported by SPI controller drivers which are "wired" to
+ * always at least provide the column. Keep using address cycles, but
+ * reduce the number of dummy cycles accordingly.
+ */
+#define WINBOND_CONT_READ_FROM_CACHE_FAST_1S_1S_1S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x8b, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 1),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0x9d, 1),				\
+		   SPI_MEM_DTR_OP_ADDR(1, 0, 1),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 1, 1),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_OP_CMD(0xcb, 1),				\
+		   SPI_MEM_OP_ADDR(1, 0, 8),				\
+		   SPI_MEM_OP_DUMMY(ndummy - 1, 8),			\
+		   SPI_MEM_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
+#define WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(ndummy, buf, len, freq) \
+	SPI_MEM_OP(SPI_MEM_DTR_OP_RPT_CMD(0x9d, 8),			\
+		   SPI_MEM_DTR_OP_ADDR(2, 0, 8),			\
+		   SPI_MEM_DTR_OP_DUMMY(ndummy - 2, 8),			\
+		   SPI_MEM_DTR_OP_DATA_IN(len, buf, 8),			\
+		   SPI_MEM_OP_MAX_FREQ(freq))
+
 /*
  * "X2" in the core is equivalent to "dual output" in the datasheets,
  * "X4" in the core is equivalent to "quad output" in the datasheets.
@@ -49,6 +94,19 @@ static SPINAND_OP_VARIANTS(read_cache_octal_variants,
 		SPINAND_PAGE_READ_FROM_CACHE_FAST_1S_1S_1S_OP(0, 1, NULL, 0, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_1S_1S_1S_OP(0, 1, NULL, 0, 0));
 
+static SPINAND_OP_VARIANTS(cont_read_cache_octal_variants,
+		WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(24, NULL, 0, 120 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_8D_8D_8D_OP(16, NULL, 0, 86 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(3, NULL, 0, 120 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1D_8D_OP(2, NULL, 0, 105 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(20, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(16, NULL, 0, 162 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(12, NULL, 0, 124 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_8S_8S_OP(8, NULL, 0, 86 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(2, NULL, 0, 0),
+		WINBOND_CONT_READ_FROM_CACHE_1S_1S_8S_OP(1, NULL, 0, 133 * HZ_PER_MHZ),
+		WINBOND_CONT_READ_FROM_CACHE_FAST_1S_1S_1S_OP(1, NULL, 0, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_octal_variants,
 		SPINAND_PROG_LOAD_8D_8D_8D_OP(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD_1S_8S_8S_OP(true, 0, NULL, 0),
@@ -326,6 +384,26 @@ static int w25n02kv_ecc_get_status(struct spinand_device *spinand,
 	return -EINVAL;
 }
 
+static int w25w35nxxjw_ecc_get_status(struct spinand_device *spinand, u8 status)
+{
+	switch (status & STATUS_ECC_MASK) {
+	case STATUS_ECC_NO_BITFLIPS:
+		return 0;
+
+	case STATUS_ECC_HAS_BITFLIPS:
+		return 1;
+
+	case STATUS_ECC_UNCOR_ERROR:
+	case W25W35NXXJW_STATUS_ECC_MULT_UNCOR:
+		return -EBADMSG;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 static int w25n0xjw_hs_cfg(struct spinand_device *spinand,
 			   enum spinand_bus_interface iface)
 {
@@ -448,6 +526,18 @@ static int w35n0xjw_vcr_cfg(struct spinand_device *spinand,
 	return 0;
 }
 
+static int w35n0xjw_set_cont_read(struct spinand_device *spinand, bool enable)
+{
+	const struct spi_mem_op *cont_op = spinand->op_templates->cont_read_cache;
+	u8 mask = enable ? 0 : WINBOND_CFG_BUF_READ;
+
+	if (cont_op && enable && spinand_op_is_odtr(cont_op) &&
+	    cont_op->max_freq >= 90 * HZ_PER_MHZ)
+		mask |= WINBOND_CFG_HFREQ;
+
+	return spinand_upd_cfg(spinand, WINBOND_CFG_BUF_READ | WINBOND_CFG_HFREQ, mask);
+}
+
 static const struct spinand_info winbond_spinand_table[] = {
 	/* 512M-bit densities */
 	SPINAND_INFO("W25N512GW", /* 1.8V */
@@ -501,35 +591,41 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc, 0x21),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 1, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
 		     0,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 	SPINAND_INFO("W35N02JW", /* 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x22),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 2, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
 		     0,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 	SPINAND_INFO("W35N04JW", /* 1.8V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdf, 0x23),
 		     NAND_MEMORG(1, 4096, 128, 64, 512, 10, 1, 4, 1),
 		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_octal_variants,
-					      &write_cache_octal_variants,
-					      &update_cache_octal_variants),
+		     SPINAND_INFO_OP_VARIANTS_WITH_CONT(&read_cache_octal_variants,
+							&write_cache_octal_variants,
+							&update_cache_octal_variants,
+							&cont_read_cache_octal_variants),
 		     0,
 		     SPINAND_INFO_VENDOR_OPS(&winbond_w35_ops),
-		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
-		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg)),
+		     SPINAND_ECCINFO(&w35n01jw_ooblayout, w25w35nxxjw_ecc_get_status),
+		     SPINAND_CONFIGURE_CHIP(w35n0xjw_vcr_cfg),
+		     SPINAND_CONT_READ(w35n0xjw_set_cont_read)),
 	/* 2G-bit densities */
 	SPINAND_INFO("W25M02GV", /* 2x1G-bit 3.3V */
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xab, 0x21),

-- 
2.51.1


