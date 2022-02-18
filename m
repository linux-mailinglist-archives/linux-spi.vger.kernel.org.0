Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5764BBB9C
	for <lists+linux-spi@lfdr.de>; Fri, 18 Feb 2022 16:00:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbiBRPAi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Feb 2022 10:00:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236839AbiBRPAZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Feb 2022 10:00:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B1AE7F72;
        Fri, 18 Feb 2022 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645196354; x=1676732354;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QUgcQACmSUcPZbxZcERwrVRXLgdoRZDTppDd8exsGbs=;
  b=ekooZTvGhXETKrPLzRC5CPI2AC5RdlzhY/ya0vaNqY9H+bchRZYbM5Ok
   veZ3edjj+vyzq1zDPsIaJbnjfBTBs9cjxQhDRFDAfUvpDZloOHZqcBPJD
   EtShG8qjUTv5kxBK4bO0BY5v821I10bB7W8gvHFwlljNxnq/WSDqH6ujM
   q0fuRDHMOT246ChpfFnDCs7EK+OGom537LL9y6ZPRZEyDwyUr5/v7SEMi
   Cs2SI0qJYdyyKmbv8Rs+Y5+qh1n0+r7poDaz+IhRwbxpac+RlInBPrRfi
   wU0lnUNxt8hXyd2bJDKYr7TL8DRJxgzWbD5qpDEc9MEcuCAW7AFmOfo6c
   g==;
X-IronPort-AV: E=Sophos;i="5.88,379,1635231600"; 
   d="scan'208";a="146516134"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Feb 2022 07:59:13 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 18 Feb 2022 07:59:12 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 18 Feb 2022 07:59:08 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <p.yadav@ti.com>, <michael@walle.cc>, <broonie@kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 2/4] mtd: spi-nor: core: Allow specifying the byte order in DTR mode
Date:   Fri, 18 Feb 2022 16:58:58 +0200
Message-ID: <20220218145900.1440045-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Macronix swaps bytes on a 16-bit boundary when configured in Octal DTR.
The byte order of 16-bit words is swapped when read or write written in
8D-8D-8D mode compared to STR modes. Swapping the bytes is a bad design
decision because this may affect the boot sequence if the entire boot
sequence is not handled in either 8D-8D-8D mode or 1-1-1 mode. Allow
operations to specify the byte order in DTR mode, so that controllers can
swap the bytes back at run-time to fix the endianness, if they are capable.

The byte order in 8D-8D-8D mode can be retrieved at run-time by checking
BFPT[DWORD(18)] BIT(31). When set to one, the "Byte order of 16-bit words
is swapped when read in 8D-8D-8D mode compared to 1-1-1 mode.". It doesn't
specify if this applies to both register and data operations. Macronix is
the single user of this byte swap and it doesn't have clear rules, as it
contains register operations that require data swap (RDPASS, WRPASS,
PASSULK, RDSFDP) and register operations that don't require data swap
(WRFBR). All these are not common and can be handled in 1-1-1 mode, so we
can ignore them for now. All the other register operations are done on one
byte length. The read register operations are actually in 8D-8D-8S mode,
as they send the data value twice, on each half of the clock cycle. In case
of a register write of one byte, the memory supports receiving the register
value only on the first byte, thus it discards the value of the byte on the
second half of the clock cycle. Swapping the bytes for one byte register
writes is not required, and for one byte register reads it doesn't matter.
Thus swap the bytes only for read or page program operations.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c  | 31 +++++++++++++++++++++++++------
 drivers/mtd/spi-nor/core.h  |  1 +
 include/linux/mtd/spi-nor.h | 17 +++++++++++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 04ea180118e3..453d8c54d062 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -106,6 +106,9 @@ void spi_nor_spimem_setup_op(const struct spi_nor *nor,
 		op->dummy.dtr = true;
 		op->data.dtr = true;
 
+		if (spi_nor_protocol_is_dtr_bswap16(proto))
+			op->data.dtr_bswap16 = true;
+
 		/* 2 bytes per clock cycle in DTR mode. */
 		op->dummy.nbytes *= 2;
 
@@ -388,7 +391,7 @@ int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, sr, 0));
 
-		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
+		if (spi_nor_protocol_is_octal_dtr(nor->reg_proto)) {
 			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
 			op.dummy.nbytes = nor->params->rdsr_dummy;
 			/*
@@ -432,7 +435,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 				   SPI_MEM_OP_NO_DUMMY,
 				   SPI_MEM_OP_DATA_IN(1, fsr, 0));
 
-		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
+		if (spi_nor_protocol_is_octal_dtr(nor->reg_proto)) {
 			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
 			op.dummy.nbytes = nor->params->rdsr_dummy;
 			/*
@@ -2488,7 +2491,7 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
 {
 	if (nor->addr_width) {
 		/* already configured from SFDP */
-	} else if (nor->read_proto == SNOR_PROTO_8_8_8_DTR) {
+	} else if (spi_nor_protocol_is_octal_dtr(nor->read_proto)) {
 		/*
 		 * In 8D-8D-8D mode, one byte takes half a cycle to transfer. So
 		 * in this protocol an odd address width cannot be used because
@@ -2701,6 +2704,19 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
 		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
 }
 
+static void spi_nor_set_dtr_bswap16_ops(struct spi_nor *nor)
+{
+	struct spi_nor_flash_parameter *params = nor->params;
+	u32 mask = SNOR_HWCAPS_READ_8_8_8_DTR | SNOR_HWCAPS_PP_8_8_8_DTR;
+
+	if ((params->hwcaps.mask & mask) == mask) {
+		params->reads[SNOR_CMD_READ_8_8_8_DTR].proto |=
+			SNOR_PROTO_IS_DTR_BSWAP16;
+		params->page_programs[SNOR_CMD_PP_8_8_8_DTR].proto |=
+			SNOR_PROTO_IS_DTR_BSWAP16;
+	}
+}
+
 /**
  * spi_nor_late_init_params() - Late initialization of default flash parameters.
  * @nor:	pointer to a 'struct spi_nor'
@@ -2721,6 +2737,9 @@ static void spi_nor_late_init_params(struct spi_nor *nor)
 	spi_nor_init_flags(nor);
 	spi_nor_init_fixup_flags(nor);
 
+	if (nor->flags & SNOR_F_DTR_BSWAP16)
+		spi_nor_set_dtr_bswap16_ops(nor);
+
 	/*
 	 * NOR protection support. When locking_ops are not provided, we pick
 	 * the default ones.
@@ -2899,8 +2918,8 @@ static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
 	if (!nor->params->octal_dtr_enable)
 		return 0;
 
-	if (!(nor->read_proto == SNOR_PROTO_8_8_8_DTR &&
-	      nor->write_proto == SNOR_PROTO_8_8_8_DTR))
+	if (!(spi_nor_protocol_is_octal_dtr(nor->read_proto) &&
+	      spi_nor_protocol_is_octal_dtr(nor->write_proto)))
 		return 0;
 
 	if (!(nor->flags & SNOR_F_IO_MODE_EN_VOLATILE))
@@ -2968,7 +2987,7 @@ static int spi_nor_init(struct spi_nor *nor)
 		spi_nor_try_unlock_all(nor);
 
 	if (nor->addr_width == 4 &&
-	    nor->read_proto != SNOR_PROTO_8_8_8_DTR &&
+	    !spi_nor_protocol_is_octal_dtr(nor->read_proto) &&
 	    !(nor->flags & SNOR_F_4B_OPCODES)) {
 		/*
 		 * If the RESET# pin isn't hooked up properly, or the system
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 2afb610853a9..7c077d41c335 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -29,6 +29,7 @@ enum spi_nor_option_flags {
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(14),
 	SNOR_F_SOFT_RESET	= BIT(15),
 	SNOR_F_SWP_IS_VOLATILE	= BIT(16),
+	SNOR_F_DTR_BSWAP16	= BIT(17),
 };
 
 struct spi_nor_read_command {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index fc90fce26e33..6e9660475c5b 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -168,6 +168,11 @@
 	 SNOR_PROTO_DATA_MASK)
 
 #define SNOR_PROTO_IS_DTR	BIT(24)	/* Double Transfer Rate */
+/*
+ * Byte order of 16-bit words is swapped when read or written in DTR mode
+ * compared to STR mode.
+ */
+#define SNOR_PROTO_IS_DTR_BSWAP16	BIT(25)
 
 #define SNOR_PROTO_STR(_inst_nbits, _addr_nbits, _data_nbits)	\
 	(SNOR_PROTO_INST(_inst_nbits) |				\
@@ -201,6 +206,18 @@ static inline bool spi_nor_protocol_is_dtr(enum spi_nor_protocol proto)
 	return !!(proto & SNOR_PROTO_IS_DTR);
 }
 
+static inline bool spi_nor_protocol_is_octal_dtr(enum spi_nor_protocol proto)
+{
+	return ((proto & SNOR_PROTO_8_8_8_DTR) == SNOR_PROTO_8_8_8_DTR);
+}
+
+static inline bool spi_nor_protocol_is_dtr_bswap16(enum spi_nor_protocol proto)
+{
+	u32 mask = SNOR_PROTO_IS_DTR | SNOR_PROTO_IS_DTR_BSWAP16;
+
+	return ((proto & mask) == mask);
+}
+
 static inline u8 spi_nor_get_protocol_inst_nbits(enum spi_nor_protocol proto)
 {
 	return ((unsigned long)(proto & SNOR_PROTO_INST_MASK)) >>
-- 
2.25.1

