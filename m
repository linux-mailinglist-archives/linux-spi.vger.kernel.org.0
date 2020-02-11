Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC969159004
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2020 14:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbgBKNeT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 Feb 2020 08:34:19 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57926 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgBKNeS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 Feb 2020 08:34:18 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01BDXwIV085601;
        Tue, 11 Feb 2020 07:33:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581428038;
        bh=d/e08luL+XtxzZve//IoGlqmM05PTVNAwnE9wxk/UAI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NLLAZze5GTu05lPYQRCkydNlW+XwfxQdTYeQuex8VsT9olg+6FkDPCo6Vr1zyVuwC
         Q1ezez/d7YXbOzxtFOtJvJ8IseAFuWretTjeu9PtNuSsRLzM/KTfxxoyGGEaQqFHd6
         THNXWLB9fL5Dm5qMutH/c5hz2UPOf0Jq8kwrZfsQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01BDXwpp070030
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Feb 2020 07:33:58 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 11
 Feb 2020 07:33:58 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 11 Feb 2020 07:33:58 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01BDXm5J087522;
        Tue, 11 Feb 2020 07:33:55 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 2/9] spi: spi-mem: allow specifying a command's extension
Date:   Tue, 11 Feb 2020 19:03:41 +0530
Message-ID: <20200211133348.15558-3-p.yadav@ti.com>
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

In xSPI mode, flashes expect 2-byte opcodes. The second byte is called
the "command extension". There can be 3 types of extensions in xSPI:
repeat, invert, and hex. When the extension type is "repeat", the same
opcode is sent twice. When it is "invert", the second byte is the
inverse of the opcode. When it is "hex" an additional opcode byte based
is sent with the command whose value can be anything.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-mem.c       | 23 +++++++++++++++++++++++
 include/linux/spi/spi-mem.h | 24 ++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 8c52ecc41a0e..fdae50d80715 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -464,6 +464,29 @@ int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 }
 EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
 
+int spi_mem_get_cmd_ext(const struct spi_mem_op *op, u8 *ext)
+{
+	switch (op->cmd.ext_type) {
+	case SPI_MEM_EXT_INVERT:
+		*ext = ~op->cmd.opcode;
+		break;
+
+	case SPI_MEM_EXT_REPEAT:
+		*ext = op->cmd.opcode;
+		break;
+
+	case SPI_MEM_EXT_HEX:
+		*ext = op->cmd.ext;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(spi_mem_get_cmd_ext);
+
 static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
 				      u64 offs, size_t len, void *buf)
 {
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 4669082b4e3b..06ccab17e4d0 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -67,11 +67,31 @@ enum spi_mem_data_dir {
 	SPI_MEM_DATA_OUT,
 };
 
+/**
+ * enum spi_mem_cmd_ext - describes the command opcode extension in DTR mode
+ * @SPI_MEM_EXT_NONE: no extension. This is the default, and is used in Legacy
+ *		      SPI mode
+ * @SPI_MEM_EXT_REPEAT: the extension is same as the opcode
+ * @SPI_MEM_EXT_INVERT: the extension is the bitwise inverse of the opcode
+ * @SPI_MEM_EXT_HEX: the extension is any hex value. The command and opcode
+ *		     combine to form a 16-bit opcode.
+ */
+enum spi_mem_cmd_ext {
+	SPI_MEM_EXT_NONE = 0,
+	SPI_MEM_EXT_REPEAT,
+	SPI_MEM_EXT_INVERT,
+	SPI_MEM_EXT_HEX,
+};
+
 /**
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.buswidth: number of IO lines used to transmit the command
  * @cmd.opcode: operation opcode
  * @cmd.is_dtr: whether the command opcode should be sent in DTR mode or not
+ * @cmd.ext_type: type of the command opcode extension in DTR mode
+ * @cmd.ext: value of the command opcode extension in DTR mode. It is
+ *	     only set when 'ext_type' is 'SPI_MEM_EXT_HEX'. In all other
+ *	     cases, the extension can be directly derived from the opcode.
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
@@ -97,6 +117,8 @@ struct spi_mem_op {
 		u8 buswidth;
 		u8 opcode;
 		bool is_dtr;
+		enum spi_mem_cmd_ext ext_type;
+		u8 ext;
 	} cmd;
 
 	struct {
@@ -361,6 +383,8 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
 
 void spi_mem_driver_unregister(struct spi_mem_driver *drv);
 
+int spi_mem_get_cmd_ext(const struct spi_mem_op *op, u8 *ext);
+
 #define spi_mem_driver_register(__drv)                                  \
 	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
 
-- 
2.25.0

