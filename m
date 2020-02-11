Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE1158FF7
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 14:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBKNeS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 08:34:18 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35006 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgBKNeR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 08:34:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01BDXtTM081155;
        Tue, 11 Feb 2020 07:33:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581428035;
        bh=J0FidGlQHAmD7w/uylDKgXCR74RkSmQmXQTVDkjB/H8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Vkh6a/dSjpVSm5yoS0GFgATq5gbCNxIc4jWzQOtTd3i1cQP3vD7OIVoYxxO6Gxrc0
         uNm5aohZkUJ0o2/Kk0QblC5IOerJE67bVJ9xraBX3KTbNN4twfwdL/xRQ302aK71gx
         /DDCCP9HB8sUSN/74SYoOEWJtbrgqa/77uXuslKU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01BDXtba127823
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 07:33:55 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 11
 Feb 2020 07:33:55 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 11 Feb 2020 07:33:55 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01BDXm5I087522;
        Tue, 11 Feb 2020 07:33:52 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 1/9] spi: spi-mem: allow specifying whether an op is DTR or not
Date:   Tue, 11 Feb 2020 19:03:40 +0530
Message-ID: <20200211133348.15558-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211133348.15558-1-p.yadav@ti.com>
References: <20200211133348.15558-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Each phase is given a separate 'is_dtr' field so mixed protocols like
4S-4D-4D can be supported.

Also add the mode bits SPI_RX_DTR and SPI_TX_DTR so controllers can
specify whether they support DTR modes or not.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-mem.c       | 25 +++++++++++++++++++++++++
 include/linux/spi/spi-mem.h |  8 ++++++++
 include/linux/spi/spi.h     |  2 ++
 3 files changed, 35 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index e5a46f0eb93b..8c52ecc41a0e 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -99,6 +99,17 @@ void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 }
 EXPORT_SYMBOL_GPL(spi_controller_dma_unmap_mem_op_data);
 
+static int spi_check_dtr_req(struct spi_mem *mem, bool is_dtr, bool tx)
+{
+	u32 mode = mem->spi->mode;
+
+	if (is_dtr &&
+	    ((tx && (mode & SPI_TX_DTR)) || (!tx && (mode & SPI_RX_DTR))))
+			return 0;
+
+	return -ENOTSUPP;
+}
+
 static int spi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
 {
 	u32 mode = mem->spi->mode;
@@ -154,6 +165,20 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 				   op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
 
+	if (op->cmd.is_dtr && spi_check_dtr_req(mem, op->cmd.is_dtr, true))
+		return false;
+
+	if (op->addr.is_dtr && spi_check_dtr_req(mem, op->addr.is_dtr, true))
+		return false;
+
+	if (op->dummy.is_dtr && spi_check_dtr_req(mem, op->dummy.is_dtr, true))
+		return false;
+
+	if (op->data.dir != SPI_MEM_NO_DATA &&
+	    spi_check_dtr_req(mem, op->data.is_dtr,
+			      op->data.dir == SPI_MEM_DATA_OUT))
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index af9ff2f0f1b2..4669082b4e3b 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -71,6 +71,7 @@ enum spi_mem_data_dir {
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.buswidth: number of IO lines used to transmit the command
  * @cmd.opcode: operation opcode
+ * @cmd.is_dtr: whether the command opcode should be sent in DTR mode or not
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
@@ -78,10 +79,13 @@ enum spi_mem_data_dir {
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
+ * @addr.is_dtr: whether the address should be sent in DTR mode or not
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
+ * @dummy.is_dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
+ * @data.is_dtr: whether the data should be sent in DTR mode or not
  * @data.dir: direction of the transfer
  * @data.nbytes: number of data bytes to send/receive. Can be zero if the
  *		 operation does not involve transferring data
@@ -92,21 +96,25 @@ struct spi_mem_op {
 	struct {
 		u8 buswidth;
 		u8 opcode;
+		bool is_dtr;
 	} cmd;
 
 	struct {
 		u8 nbytes;
 		u8 buswidth;
 		u64 val;
+		bool is_dtr;
 	} addr;
 
 	struct {
 		u8 nbytes;
 		u8 buswidth;
+		bool is_dtr;
 	} dummy;
 
 	struct {
 		u8 buswidth;
+		bool is_dtr;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		union {
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6d16ba01ff5a..bf1108318389 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -183,6 +183,8 @@ struct spi_device {
 #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
+#define SPI_RX_DTR	0x10000			/* receive in DTR mode */
+#define SPI_TX_DTR	0x20000			/* transmit in DTR mode */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.25.0

