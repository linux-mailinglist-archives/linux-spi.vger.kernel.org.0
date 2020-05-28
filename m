Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B871E5A11
	for <lists+linux-spi@lfdr.de>; Thu, 28 May 2020 10:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgE1H7i (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 03:59:38 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:31401 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgE1H7i (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 03:59:38 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04S7wMHh030973;
        Thu, 28 May 2020 15:58:29 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 08/14] mtd: spi-nor: sfdp: parse command sequences to change octal DTR mode
Date:   Thu, 28 May 2020 15:58:10 +0800
Message-Id: <1590652696-8844-9-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590652696-8844-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04S7wMHh030973
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

A set of simple command sequences is provided which can be executed
directly by the host controller to enable octal DTR mode.

Each command sequence is 8 per byte for single SPI mode.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.h |  18 ++++++++
 drivers/mtd/spi-nor/sfdp.c | 103 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 837f5e9..101726c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -185,6 +185,21 @@ struct spi_nor_locking_ops {
 };
 
 /**
+ * struct cmd_seq_octal_dtr - command sequences to change to octal DTR mode
+ * Each command sequence is 8 per byte for single SPI mode.
+ * @len:	commmand length of each command sequence.
+ * @opcode:	command code.
+ * @addr:	address offset to device.
+ * @data:	data write to device.
+ */
+struct cmd_seq_octal_dtr {
+	u8 len;
+	u8 opcode;
+	u32 addr;
+	u8 data;
+};
+
+/**
  * struct spi_nor_flash_parameter - SPI NOR flash parameters and settings.
  * Includes legacy flash parameters and settings that can be overwritten
  * by the spi_nor_fixups hooks, or dynamically when parsing the JESD216
@@ -207,6 +222,7 @@ struct spi_nor_locking_ops {
  *                      higher index in the array, the higher priority.
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
+ * @cmd_seq:		command sequence to change to octal DTR mode.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
  * @convert_addr:	converts an absolute address into something the flash
@@ -234,6 +250,8 @@ struct spi_nor_flash_parameter {
 
 	struct spi_nor_erase_map        erase_map;
 
+	struct cmd_seq_octal_dtr	cmd_seq[4];
+
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
 	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 550422b..fb5f9f3 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -21,6 +21,7 @@
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
 #define SFDP_4BAIT_ID		0xff84  /* 4-byte Address Instruction Table */
 #define SFDP_PROFILE1_ID	0xff05	/* xSPI Profile 1.0 table. */
+#define SFDP_CMD_TO_8DTR_ID	0xff0a  /* Command Sequence to Octal DDR */
 
 #define SFDP_SIGNATURE		0x50444653U
 #define SFDP_JESD216_MAJOR	1
@@ -55,6 +56,19 @@ struct octal_max_speed {
 	u16 hz; /* MHz */
 };
 
+#define CMD_TO_8DTR_LEN			GENMASK(31, 24)
+#define CMD_TO_8DTR_OPCODE		GENMASK(23, 16)
+#define CMD_TO_8DTR_1_ADDR		GENMASK(15, 8)
+#define CMD_TO_8DTR_1_ADDR_DATA		GENMASK(7, 0)
+#define CMD_TO_8DTR_4_ADDR_MSB		GENMASK(15, 0)
+#define CMD_TO_8DTR_4_ADDR_LSB		GENMASK(31, 16)
+#define CMD_TO_8DTR_4_ADDR_DATA		GENMASK(15, 8)
+#define CMD_TO_8DTR_SIZE_MAX		8
+
+struct sfdp_cmd_to_8dtr {
+	u32	dwords[CMD_TO_8DTR_SIZE_MAX];
+};
+
 struct sfdp_header {
 	u32		signature; /* Ox50444653U <=> "SFDP" */
 	u8		minor;
@@ -1248,6 +1262,90 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 }
 
 /**
+ * spi_nor_parse_cmd_to_8dtr() - parse the command sequence to octal DTR
+ * @nor:		pointer to a 'struct spi_nor'
+ * @param_header:	command sequence to octal DTR parameter table header.
+ * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_parse_cmd_to_8dtr(struct spi_nor *nor,
+				     const struct sfdp_parameter_header *header,
+				     struct spi_nor_flash_parameter *params)
+{
+	struct sfdp_cmd_to_8dtr cmd_seq;
+	u32 i, j, addr;
+	size_t len;
+	int ret;
+
+	if (header->major != SFDP_JESD216_MAJOR ||
+	    header->length < CMD_TO_8DTR_SIZE_MAX)
+		return -EINVAL;
+
+	len = min_t(size_t, sizeof(cmd_seq),
+		    header->length * sizeof(u32));
+
+	memset(&cmd_seq, 0, sizeof(cmd_seq));
+
+	addr = SFDP_PARAM_HEADER_PTP(header);
+	ret = spi_nor_read_sfdp(nor, addr, len, &cmd_seq);
+	if (ret)
+		goto out;
+
+	/* Fix endianness of the Command Sequences to octal DTR. */
+	le32_to_cpu_array(cmd_seq.dwords, CMD_TO_8DTR_SIZE_MAX);
+
+	memset(params->cmd_seq, 0, sizeof(params->cmd_seq[4]));
+
+	for (i = 0, j = 0; i < 4 && j < 8; i++, j += 2) {
+		params->cmd_seq[i].len = FIELD_GET(CMD_TO_8DTR_LEN,
+						   cmd_seq.dwords[j]);
+		if (!params->cmd_seq[i].len)
+			break;
+
+		switch (params->cmd_seq[i].len) {
+		case 1:
+			params->cmd_seq[i].opcode =
+				FIELD_GET(CMD_TO_8DTR_OPCODE,
+					  cmd_seq.dwords[j]);
+			break;
+
+		case 3:
+			params->cmd_seq[i].opcode =
+				FIELD_GET(CMD_TO_8DTR_OPCODE,
+					  cmd_seq.dwords[j]);
+			params->cmd_seq[i].addr =
+				FIELD_GET(CMD_TO_8DTR_1_ADDR,
+					  cmd_seq.dwords[j]);
+			params->cmd_seq[i].data =
+				FIELD_GET(CMD_TO_8DTR_1_ADDR_DATA,
+					  cmd_seq.dwords[j]);
+			break;
+
+		case 6:
+			params->cmd_seq[i].opcode =
+				FIELD_GET(CMD_TO_8DTR_OPCODE,
+					  cmd_seq.dwords[j]);
+			params->cmd_seq[i].addr =
+				FIELD_GET(CMD_TO_8DTR_4_ADDR_MSB,
+					  cmd_seq.dwords[j]) << 16 |
+				FIELD_GET(CMD_TO_8DTR_4_ADDR_LSB,
+					  cmd_seq.dwords[j + 1]);
+			params->cmd_seq[i].data =
+				FIELD_GET(CMD_TO_8DTR_4_ADDR_DATA,
+					  cmd_seq.dwords[j + 1]);
+			break;
+
+		default:
+			break;
+		}
+	}
+
+out:
+	return ret;
+}
+
+/**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
  * @params:		pointer to the 'struct spi_nor_flash_parameter' to be
@@ -1352,6 +1450,11 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 			err = spi_nor_parse_profile1(nor, param_header, params);
 			break;
 
+		case SFDP_CMD_TO_8DTR_ID:
+			err = spi_nor_parse_cmd_to_8dtr(nor,
+							param_header, params);
+			break;
+
 		default:
 			break;
 		}
-- 
1.9.1

