Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46E71B1F8C
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 09:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgDUHJP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 03:09:15 -0400
Received: from twhmllg3.macronix.com ([122.147.135.201]:39894 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgDUHJO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 03:09:14 -0400
Received: from TWHMLLG3.macronix.com (localhost [127.0.0.2] (may be forged))
        by TWHMLLG3.macronix.com with ESMTP id 03L6egwa046660
        for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2020 14:40:42 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id 03L6dnMY045498;
        Tue, 21 Apr 2020 14:39:51 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com
Cc:     juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v2 2/5] mtd: spi-nor: sfdp: Add support for xSPI profile 1.0 table
Date:   Tue, 21 Apr 2020 14:39:44 +0800
Message-Id: <1587451187-6889-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
References: <1587451187-6889-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com 03L6dnMY045498
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

xSPI(eXpanded Serial Peripheral Interface) is for Non Volatile Memory
 Devices supports Octal DTR mode.

Extract information like:
Read Fast command, the number of dummy cycles and address bytes
for Read Status Register command.

Read/Write volatile Register command for Configuration(CFG) Register 2.

The dummy cycless used for various frequencies.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.h |  14 ++++++
 drivers/mtd/spi-nor/sfdp.c | 106 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 6f2f6b2..2ea11fa 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -208,6 +208,12 @@ struct spi_nor_locking_ops {
  *                      e.g. different opcodes, specific address calculation,
  *                      page size, etc.
  * @locking_ops:	SPI NOR locking methods.
+ * @dtr_read_cmd:	xSPI Octal DTR Read Fast command.
+ * @rdsr_addr_nbytes:	xSPI Octal address bytes for read status register.
+ * @rdsr_dummy_cycles:	xSPI Octal dummy cycles for read status register.
+ * @rd_reg_cmd:		xSPI Octal read volatile register command.
+ * @wr_reg_cmd:		xSPI Octal write volatile register command.
+ * @dummy_cycles:	xSPI Octal dummy cycles used for various frequencies.
  */
 struct spi_nor_flash_parameter {
 	u64				size;
@@ -225,6 +231,14 @@ struct spi_nor_flash_parameter {
 	int (*setup)(struct spi_nor *nor, const struct spi_nor_hwcaps *hwcaps);
 
 	const struct spi_nor_locking_ops *locking_ops;
+
+	/* xSPI profile 1.0 parameter for Octal 8S-8S-8S/8D-8D-8D */
+	u8 dtr_read_cmd;
+	u8 rdsr_addr_nbytes;
+	u8 rdsr_dummy_cycles;
+	u8 rd_reg_cmd;
+	u8 wr_reg_cmd;
+	u8 dummy_cycles;
 };
 
 /**
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index f6038d3..26814a1 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/sort.h>
 #include <linux/mtd/spi-nor.h>
+#include <linux/bitfield.h>
 
 #include "core.h"
 
@@ -19,6 +20,7 @@
 #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
 #define SFDP_4BAIT_ID		0xff84  /* 4-byte Address Instruction Table */
+#define SFDP_XSPI_PF1_ID	0xff05	/* xSPI Profile 1.0 table. */
 
 #define SFDP_SIGNATURE		0x50444653U
 #define SFDP_JESD216_MAJOR	1
@@ -26,6 +28,28 @@
 #define SFDP_JESD216A_MINOR	5
 #define SFDP_JESD216B_MINOR	6
 
+/* xSPI Profile 1.0 table (from JESD216D.01). */
+#define XSPI_PF1_DWORD1_RD_CMD			GENMASK(15, 8)
+#define XSPI_PF1_DWORD1_RDSR_ADDR_BYTES		BIT(29)
+#define XSPI_PF1_DWORD1_RDSR_DUMMY_CYCLES	BIT(28)
+
+#define XSPI_PF1_DWORD2_RD_REG_CMD		GENMASK(31, 24)
+#define XSPI_PF1_DWORD2_WR_REG_CMD		GENMASK(15, 8)
+
+#define XSPI_DWORD(x)	((x) - 1)
+#define XSPI_DWORD_MAX	5
+
+struct sfdp_xspi {
+	u32	dwords[XSPI_DWORD_MAX];
+};
+
+struct xspi_dummy_cycles {
+	u16 speed_hz;	/* Speed MHz */
+	u8 dwords;	/* Dwords index */
+	u32 mask;	/* Mask */
+	u8 shift;	/* Bit shift */
+};
+
 struct sfdp_header {
 	u32		signature; /* Ox50444653U <=> "SFDP" */
 	u8		minor;
@@ -1081,6 +1105,83 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 }
 
 /**
+ * spi_nor_parse_xspi_pf1() - parse the xSPI Profile 1.0 table
+ * @nor:		pointer to a 'struct spi_nor'
+ * @param_header:	pointer to the 'struct sfdp_parameter_header' describing
+ *			the 4-Byte Address Instruction Table length and version.
+ * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_parse_xspi_pf1(struct spi_nor *nor,
+				  const struct sfdp_parameter_header *header,
+				  struct spi_nor_flash_parameter *params)
+{
+	struct sfdp_xspi pfile1;
+	u32 i, addr;
+	size_t len;
+	int ret;
+	static const struct xspi_dummy_cycles dummy[] = {
+		/* {MHz, Dwords index, Mask, Bit shift} */
+		{ 200, 4, GENMASK(11, 7),   7},
+		{ 166, 5, GENMASK(31, 27), 27},
+		{ 133, 5, GENMASK(21, 17), 17},
+		{ 100, 5, GENMASK(11, 7),   7},
+	};
+
+	if (header->major != SFDP_JESD216_MAJOR ||
+	    header->length < XSPI_DWORD_MAX)
+		return -EINVAL;
+
+	len = min_t(size_t, sizeof(pfile1),
+		    header->length * sizeof(u32));
+
+	memset(&pfile1, 0, sizeof(pfile1));
+
+	addr = SFDP_PARAM_HEADER_PTP(header);
+	ret = spi_nor_read_sfdp(nor, addr, len, &pfile1);
+	if (ret)
+		goto out;
+
+	/* Fix endianness of the xSPI 1.0 DWORDs. */
+	le32_to_cpu_array(pfile1.dwords, XSPI_DWORD_MAX);
+
+	/* Get 8D-8D-8D fast read opcode and dummy cycles. */
+	params->dtr_read_cmd = FIELD_GET(XSPI_PF1_DWORD1_RD_CMD,
+					 pfile1.dwords[XSPI_DWORD(1)]);
+
+	if (pfile1.dwords[XSPI_DWORD(1)] & XSPI_PF1_DWORD1_RDSR_ADDR_BYTES)
+		params->rdsr_addr_nbytes = 4;
+	else
+		params->rdsr_addr_nbytes = 0;
+
+	if (pfile1.dwords[XSPI_DWORD(1)] & XSPI_PF1_DWORD1_RDSR_DUMMY_CYCLES)
+		params->rdsr_dummy_cycles = 8;
+	else
+		params->rdsr_dummy_cycles = 4;
+
+	params->rd_reg_cmd = FIELD_GET(XSPI_PF1_DWORD2_RD_REG_CMD,
+				       pfile1.dwords[XSPI_DWORD(2)]);
+	params->wr_reg_cmd = FIELD_GET(XSPI_PF1_DWORD2_WR_REG_CMD,
+				       pfile1.dwords[XSPI_DWORD(2)]);
+
+	for (i = 0; i < ARRAY_SIZE(dummy); i++) {
+		if (params->octal_max_speed == dummy[i].speed_hz) {
+			params->dummy_cycles =
+				(dummy[i].mask &
+				 pfile1.dwords[XSPI_DWORD(dummy[i].dwords)]) >>
+				 dummy[i].shift;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(dummy))
+		params->dummy_cycles = 20;
+
+out:
+	return ret;
+}
+
+/**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
  * @params:		pointer to the 'struct spi_nor_flash_parameter' to be
@@ -1171,7 +1272,6 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 	/* Parse optional parameter tables. */
 	for (i = 0; i < header.nph; i++) {
 		param_header = &param_headers[i];
-
 		switch (SFDP_PARAM_HEADER_ID(param_header)) {
 		case SFDP_SECTOR_MAP_ID:
 			err = spi_nor_parse_smpt(nor, param_header, params);
@@ -1181,6 +1281,10 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 			err = spi_nor_parse_4bait(nor, param_header, params);
 			break;
 
+		case SFDP_XSPI_PF1_ID:
+			err = spi_nor_parse_xspi_pf1(nor, param_header, params);
+			break;
+
 		default:
 			break;
 		}
-- 
1.9.1

