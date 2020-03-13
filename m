Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 673B2184B8D
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 16:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCMPre (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 11:47:34 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53884 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgCMPrc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Mar 2020 11:47:32 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02DFlK0w101781;
        Fri, 13 Mar 2020 10:47:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584114440;
        bh=te7HGhMBFCIPpoq3K2xajnmIVB0+E+tbIzD+D2sba9I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=qAFeJyIAKX9FIRmlpDgLMNc+SZuiYjnZx6jAGUpX4q5DVD/FnD+DdKTkBPH5+4wyz
         N2kxTL0cFJMwMWdK2wrmfq2fs8txm/PQs6kKrB14pCU5dc/hL2/JMt9/x0JqDcIJxS
         SM+p0lP0hGTj6A1LwFBQgcm3kU6tzU8vCBvN59F8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02DFlJTl013883
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 10:47:20 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 10:47:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 10:47:19 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02DFkkSL034352;
        Fri, 13 Mar 2020 10:47:16 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 07/12] mtd: spi-nor: parse xSPI Profile 1.0 table
Date:   Fri, 13 Mar 2020 21:16:40 +0530
Message-ID: <20200313154645.29293-8-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200313154645.29293-1-p.yadav@ti.com>
References: <20200313154645.29293-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This table is indication that the flash is xSPI compliant and hence
supports octal DTR mode. Extract information like the fast read opcode,
the number of dummy cycles needed for a Read Status Register command,
and the number of address bytes needed for a Read Status Register
command.

The default dummy cycles for a fast octal DTR read are set to 20. Since
there is no simple way of determining the dummy cycles needed for the
fast read command, flashes that use a different value should update it
in their flash-specific hooks.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 80 +++++++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  5 +++
 2 files changed, 85 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 91abeb280cd4..efa3b01030f5 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -16,6 +16,7 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
+#include <linux/bitfield.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/of_platform.h>
@@ -58,12 +59,14 @@ struct sfdp_parameter_header {
 #define SFDP_BFPT_ID		0xff00	/* Basic Flash Parameter Table */
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
 #define SFDP_4BAIT_ID		0xff84  /* 4-byte Address Instruction Table */
+#define SFDP_PROFILE1_ID	0xff05	/* xSPI Profile 1.0 table. */
 
 #define SFDP_SIGNATURE		0x50444653U
 #define SFDP_JESD216_MAJOR	1
 #define SFDP_JESD216_MINOR	0
 #define SFDP_JESD216A_MINOR	5
 #define SFDP_JESD216B_MINOR	6
+#define SFDP_JESD216D_MINOR	8
 
 struct sfdp_header {
 	u32		signature; /* Ox50444653U <=> "SFDP" */
@@ -158,6 +161,11 @@ struct sfdp_bfpt {
 	u32	dwords[BFPT_DWORD_MAX];
 };
 
+/* xSPI Profile 1.0 table (from JESD216D.01). */
+#define PROFILE1_DWORD1_RD_FAST_CMD		GENMASK(15, 8)
+#define PROFILE1_DWORD1_RDSR_DUMMY		BIT(28)
+#define PROFILE1_DWORD1_RDSR_ADDR_BYTES		BIT(29)
+
 /**
  * struct spi_nor_fixups - SPI NOR fixup hooks
  * @default_init: called after default flash parameters init. Used to tweak
@@ -4474,6 +4482,74 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
 	return ret;
 }
 
+/**
+ * spi_nor_parse_profile1() - parse the xSPI Profile 1.0 table
+ * @nor:		pointer to a 'struct spi_nor'
+ * @param_header:	pointer to the 'struct sfdp_parameter_header' describing
+ *			the 4-Byte Address Instruction Table length and version.
+ * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_parse_profile1(struct spi_nor *nor,
+				  const struct sfdp_parameter_header *profile1_header,
+				  struct spi_nor_flash_parameter *params)
+{
+	u32 *table, opcode, addr;
+	size_t len;
+	int ret, i;
+
+	len = profile1_header->length * sizeof(*table);
+	table = kmalloc(len, GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	addr = SFDP_PARAM_HEADER_PTP(profile1_header);
+	ret = spi_nor_read_sfdp(nor, addr, len, table);
+	if (ret)
+		goto out;
+
+	/* Fix endianness of the table DWORDs. */
+	for (i = 0; i < profile1_header->length; i++)
+		table[i] = le32_to_cpu(table[i]);
+
+	/* Get 8D-8D-8D fast read opcode and dummy cycles. */
+	opcode = FIELD_GET(PROFILE1_DWORD1_RD_FAST_CMD, table[0]);
+
+	/*
+	 * Update the fast read settings. We set the default dummy cycles to 20
+	 * here. Flashes can change this value if they need to when enabling
+	 * octal mode.
+	 */
+	params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, 20, opcode,
+				  SNOR_PROTO_8_8_8_DTR);
+
+	/*
+	 * Since the flash supports xSPI DTR reads, it should also support DTR
+	 * Page Program opcodes.
+	 */
+	params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
+
+	/*
+	 * Set the Read Status Register dummy cycles and dummy address bytes.
+	 */
+	if (table[0] & PROFILE1_DWORD1_RDSR_DUMMY)
+		params->rdsr_dummy = 8;
+	else
+		params->rdsr_dummy = 4;
+
+	if (table[0] & PROFILE1_DWORD1_RDSR_ADDR_BYTES)
+		params->rdsr_addr_nbytes = 4;
+	else
+		params->rdsr_addr_nbytes = 0;
+
+out:
+	kfree(table);
+	return ret;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -4575,6 +4651,10 @@ static int spi_nor_parse_sfdp(struct spi_nor *nor,
 			err = spi_nor_parse_4bait(nor, param_header, params);
 			break;
 
+		case SFDP_PROFILE1_ID:
+			err = spi_nor_parse_profile1(nor, param_header, params);
+			break;
+
 		default:
 			break;
 		}
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index e4dc34cd6938..f1db613e0320 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -533,6 +533,9 @@ struct spi_nor_locking_ops {
  *
  * @size:		the flash memory density in bytes.
  * @page_size:		the page size of the SPI NOR flash memory.
+ * @rdsr_dummy:		dummy cycles needed for Read Status Register command.
+ * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
+ *			command.
  * @hwcaps:		describes the read and page program hardware
  *			capabilities.
  * @reads:		read capabilities ordered by priority: the higher index
@@ -555,6 +558,8 @@ struct spi_nor_locking_ops {
 struct spi_nor_flash_parameter {
 	u64				size;
 	u32				page_size;
+	u8				rdsr_dummy;
+	u8				rdsr_addr_nbytes;
 
 	struct spi_nor_hwcaps		hwcaps;
 	struct spi_nor_read_command	reads[SNOR_CMD_READ_MAX];
-- 
2.25.0

