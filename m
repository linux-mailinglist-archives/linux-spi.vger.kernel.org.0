Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF01E76C8
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 09:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgE2HhN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 03:37:13 -0400
Received: from twhmllg4.macronix.com ([211.75.127.132]:24791 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgE2HhN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 May 2020 03:37:13 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id 04T7aHpw067318;
        Fri, 29 May 2020 15:36:19 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        boris.brezillon@collabora.com, matthias.bgg@gmail.com
Cc:     p.yadav@ti.com, juliensu@mxic.com.tw, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v4 2/7] mtd: spi-nor: sfdp: parse xSPI Profile 1.0 table
Date:   Fri, 29 May 2020 15:36:10 +0800
Message-Id: <1590737775-4798-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
References: <1590737775-4798-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com 04T7aHpw067318
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

JESD251, xSPI profile 1.0 table supports octal DTR mode.
Extract information like the fast read opcode, dummy cycles for various
frequencies, the number of dummy cycles needed for a Read Status
Register command, the number of address bytes needed for a Read
Status Register command, read volatile register command and write
volatile register command.

According to BFPT 20th DWORD of octal maximum speed, driver get it's
specific dummy cycles from profile 1.0 table and then could update
it to device by their fixup hooks.

Since driver get octal DTR read opcode and then set read settings,
expose spi_nor_set_read_settings() in core.h.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 drivers/mtd/spi-nor/core.c |   2 +-
 drivers/mtd/spi-nor/core.h |  16 +++++++
 drivers/mtd/spi-nor/sfdp.c | 106 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 1ab4386..3799417 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2204,7 +2204,7 @@ static int spi_nor_check(struct spi_nor *nor)
 	return 0;
 }
 
-static void
+void
 spi_nor_set_read_settings(struct spi_nor_read_command *read,
 			  u8 num_mode_clocks,
 			  u8 num_wait_states,
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 7a36b22..a33f807 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -191,6 +191,12 @@ struct spi_nor_locking_ops {
  * @size:		the flash memory density in bytes.
  * @page_size:		the page size of the SPI NOR flash memory.
  * @octal_max_speed:	maximum operation speed of device in octal mode.
+ * @rdsr_dummy:		dummy cycles needed for Read Status Register command.
+ * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
+ *			command.
+ * @rd_reg_cmd:		read volatile register command for xSPI device.
+ * @wr_reg_cmd:		write volatile register command for xSPI device.
+ * @dummy_cycles:	dummy cycles used for various frequencies
  * @hwcaps:		describes the read and page program hardware
  *			capabilities.
  * @reads:		read capabilities ordered by priority: the higher index
@@ -214,6 +220,11 @@ struct spi_nor_flash_parameter {
 	u64				size;
 	u32				page_size;
 	u16				octal_max_speed;
+	u8				rdsr_dummy;
+	u8				rdsr_addr_nbytes;
+	u8				rd_reg_cmd;
+	u8				wr_reg_cmd;
+	u8				dummy_cycles;
 
 	struct spi_nor_hwcaps		hwcaps;
 	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
@@ -420,6 +431,11 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 
 int spi_nor_hwcaps_read2cmd(u32 hwcaps);
 u8 spi_nor_convert_3to4_read(u8 opcode);
+void spi_nor_set_read_settings(struct spi_nor_read_command *read,
+			       u8 num_mode_clocks,
+			       u8 num_wait_states,
+			       u8 opcode,
+			       enum spi_nor_protocol proto);
 void spi_nor_set_pp_settings(struct spi_nor_pp_command *pp, u8 opcode,
 			     enum spi_nor_protocol proto);
 
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 4d13f66..27a4de4 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -20,6 +20,7 @@
 #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
 #define SFDP_4BAIT_ID		0xff84  /* 4-byte Address Instruction Table */
+#define SFDP_PROFILE1_ID	0xff05	/* xSPI Profile 1.0 table. */
 
 #define SFDP_SIGNATURE		0x50444653U
 #define SFDP_JESD216_MAJOR	1
@@ -27,6 +28,27 @@
 #define SFDP_JESD216A_MINOR	5
 #define SFDP_JESD216B_MINOR	6
 
+/* xSPI Profile 1.0 table (from JESD216D.01). */
+#define XSPI_PF1_DWORD1_RD_CMD                  GENMASK(15, 8)
+#define XSPI_PF1_DWORD1_RDSR_ADDR_BYTES         BIT(29)
+#define XSPI_PF1_DWORD1_RDSR_DUMMY_CYCLES       BIT(28)
+#define XSPI_PF1_DWORD2_RD_REG_CMD              GENMASK(31, 24)
+#define XSPI_PF1_DWORD2_WR_REG_CMD              GENMASK(15, 8)
+#define XSPI_PF1_DUMMY_CYCLES_DEFAULT		20
+#define XSPI_DWORD(x)   ((x) - 1)
+#define XSPI_DWORD_MAX  5
+
+struct sfdp_xspi {
+	u32 dwords[XSPI_DWORD_MAX];
+};
+
+struct xspi_dummy_cycles {
+	u16 speed_hz;	/* Speed MHz */
+	u8 dwords;	/* Dwords index */
+	u32 mask;	/* Mask */
+	u8 shift;	/* Bit shift */
+};
+
 /* Basic Flash Parameter Table 20th DWORD, Max operation speed of device */
 struct octal_max_speed {
 	u8 idx; /* Bits value */
@@ -1117,6 +1139,86 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 }
 
 /**
+ * spi_nor_parse_profile1() - parse the xSPI Profile 1.0 table
+ * @nor:		pointer to a 'struct spi_nor'
+ * @param_header:	xspi profile 1 parameter table header
+ * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_parse_profile1(struct spi_nor *nor,
+				  const struct sfdp_parameter_header *header,
+				  struct spi_nor_flash_parameter *params)
+{
+	struct sfdp_xspi pfile1;
+	u8 opcode;
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
+	opcode = FIELD_GET(XSPI_PF1_DWORD1_RD_CMD,
+			   pfile1.dwords[XSPI_DWORD(1)]);
+
+	if (pfile1.dwords[XSPI_DWORD(1)] & XSPI_PF1_DWORD1_RDSR_ADDR_BYTES)
+		params->rdsr_addr_nbytes = 4;
+	else
+		params->rdsr_addr_nbytes = 0;
+
+	if (pfile1.dwords[XSPI_DWORD(1)] & XSPI_PF1_DWORD1_RDSR_DUMMY_CYCLES)
+		params->rdsr_dummy = 8;
+	else
+		params->rdsr_dummy = 4;
+
+	params->rd_reg_cmd = FIELD_GET(XSPI_PF1_DWORD2_RD_REG_CMD,
+				       pfile1.dwords[XSPI_DWORD(2)]);
+	params->wr_reg_cmd = FIELD_GET(XSPI_PF1_DWORD2_WR_REG_CMD,
+				       pfile1.dwords[XSPI_DWORD(2)]);
+
+	/* according to BFPT 20th DOWRD to get devices dummy cycles */
+	for (i = 0; i < ARRAY_SIZE(dummy); i++) {
+		if (params->octal_max_speed == dummy[i].speed_hz) {
+			params->dummy_cycles = (dummy[i].mask &
+				pfile1.dwords[XSPI_DWORD(dummy[i].dwords)]) >>
+				dummy[i].shift;
+			break;
+		}
+	}
+	if (i == ARRAY_SIZE(dummy))
+		params->dummy_cycles = XSPI_PF1_DUMMY_CYCLES_DEFAULT;
+
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, params->dummy_cycles,
+				  opcode, SNOR_PROTO_8_8_8_DTR);
+out:
+	return ret;
+}
+
+/**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
  * @params:		pointer to the 'struct spi_nor_flash_parameter' to be
@@ -1217,6 +1319,10 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 			err = spi_nor_parse_4bait(nor, param_header, params);
 			break;
 
+		case SFDP_PROFILE1_ID:
+			err = spi_nor_parse_profile1(nor, param_header, params);
+			break;
+
 		default:
 			break;
 		}
-- 
1.9.1

