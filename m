Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E6D30573A
	for <lists+linux-spi@lfdr.de>; Wed, 27 Jan 2021 10:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhA0JpN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Jan 2021 04:45:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11452 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbhA0Jnu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Jan 2021 04:43:50 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DQdt95476zjCtx;
        Wed, 27 Jan 2021 17:42:09 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Wed, 27 Jan 2021 17:42:59 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <tudor.ambarus@microchip.com>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
CC:     <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@openeuler.org>
Subject: [PATCH 1/2] mtd: spi-nor: check 4-byte address support when parsing 4bait
Date:   Wed, 27 Jan 2021 17:40:49 +0800
Message-ID: <1611740450-47975-2-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1611740450-47975-1-git-send-email-yangyicong@hisilicon.com>
References: <1611740450-47975-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The spi-nor core will convert the address mode to 4-btye,
without checking whether 4-byte address is supported or not.
For example, the 16M s25fs128s1 can work under both 3-byte
and 4-byte address and provides a 4bait table. The spi-nor
will drive the flash under 4-byte address mode after parsing
the 4bait and will cause it unusable on platforms doesn't
support 4-byte.

Add checking of 4-byte address support when parsing the 4bait
table, stop converting the address mode if it's not supported.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/mtd/spi-nor/sfdp.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 6ee7719..fdafc9b 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -940,6 +940,27 @@ static int spi_nor_parse_smpt(struct spi_nor *nor,
 	return ret;
 }
 
+static int spi_nor_spimem_check_4byte_addr(struct spi_nor *nor,
+					   const struct spi_nor_read_command *read)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(read->opcode, 1),
+					  SPI_MEM_OP_ADDR(4, 0, 1),
+					  SPI_MEM_OP_DUMMY(0, 1),
+					  SPI_MEM_OP_DATA_IN(0, NULL, 1));
+
+	op.cmd.buswidth = spi_nor_get_protocol_inst_nbits(read->proto);
+	op.addr.buswidth = spi_nor_get_protocol_addr_nbits(read->proto);
+	op.data.buswidth = spi_nor_get_protocol_data_nbits(read->proto);
+	op.dummy.buswidth = op.addr.buswidth;
+	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
+			  op.dummy.buswidth / 8;
+
+	if (!spi_mem_supports_op(nor->spimem, &op))
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 /**
  * spi_nor_parse_4bait() - parse the 4-Byte Address Instruction Table
  * @nor:		pointer to a 'struct spi_nor'.
@@ -1061,6 +1082,33 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 		goto out;
 
 	/*
+	 * Check whether the 4-byte address is supported before converting
+	 * the instruction set to 4-byte.
+	 */
+	if (nor->spimem) {
+		bool support = false;
+
+		for (i = 0; i < SNOR_CMD_READ_MAX; i++) {
+			struct spi_nor_read_command read_cmd;
+
+			memcpy(&read_cmd, &params->reads[i], sizeof(read_cmd));
+
+			read_cmd.opcode = spi_nor_convert_3to4_read(read_cmd.opcode);
+			if (!spi_nor_spimem_check_4byte_addr(nor, &read_cmd)) {
+				support = true;
+				break;
+			}
+		}
+
+		/*
+		 * No supported 4-byte instruction is found, stop parsing the
+		 * 4bait table.
+		 */
+		if (!support)
+			goto out;
+	}
+
+	/*
 	 * Discard all operations from the 4-byte instruction set which are
 	 * not supported by this memory.
 	 */
-- 
2.8.1

