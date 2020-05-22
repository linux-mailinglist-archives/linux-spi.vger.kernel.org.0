Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CE91DF1FA
	for <lists+linux-spi@lfdr.de>; Sat, 23 May 2020 00:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgEVWlR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 18:41:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54190 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbgEVWlR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 18:41:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MMesV3061126;
        Fri, 22 May 2020 17:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590187254;
        bh=QVVBkRYpNpHNnM3DtoOcxGwPAsP60fEAqbUuQ94mGJM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t7wBnZXD/NoP9YrDoKX1Z7ZhaVnf8LQTHk9VCBpwA+jSx5UBM2d8TePvw9+r276UQ
         1HMtloiowl2mLNfty+hVvcdJ8zwDsEcgkh+6/HvZlZv1IFtAnb5QZvsjaVvElXGQHw
         Z90AB3vwSt/ci0TqDO+uG1492lgwEVBiOVCcAa10=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MMes2i034964;
        Fri, 22 May 2020 17:40:54 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 17:40:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 17:40:54 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MMeh5Y044559;
        Fri, 22 May 2020 17:40:49 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v8 01/19] spi: spi-mem: allow specifying whether an op is DTR or not
Date:   Sat, 23 May 2020 04:10:24 +0530
Message-ID: <20200522224042.29970-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522224042.29970-1-p.yadav@ti.com>
References: <20200522224042.29970-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Each phase is given a separate 'dtr' field so mixed protocols like
4S-4D-4D can be supported.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-mem.c       | 3 +++
 include/linux/spi/spi-mem.h | 8 ++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 9a86cc27fcc0..93e255287ab9 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -156,6 +156,9 @@ bool spi_mem_default_supports_op(struct spi_mem *mem,
 				   op->data.dir == SPI_MEM_DATA_OUT))
 		return false;
 
+	if (op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr)
+		return false;
+
 	return true;
 }
 EXPORT_SYMBOL_GPL(spi_mem_default_supports_op);
diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index af9ff2f0f1b2..e3dcb956bf61 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -71,9 +71,11 @@ enum spi_mem_data_dir {
  * struct spi_mem_op - describes a SPI memory operation
  * @cmd.buswidth: number of IO lines used to transmit the command
  * @cmd.opcode: operation opcode
+ * @cmd.dtr: whether the command opcode should be sent in DTR mode or not
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
+ * @addr.dtr: whether the address should be sent in DTR mode or not
  * @addr.val: address value. This value is always sent MSB first on the bus.
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
@@ -81,7 +83,9 @@ enum spi_mem_data_dir {
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
+ * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
  * @data.buswidth: number of IO lanes used to send/receive the data
+ * @data.dtr: whether the data should be sent in DTR mode or not
  * @data.dir: direction of the transfer
  * @data.nbytes: number of data bytes to send/receive. Can be zero if the
  *		 operation does not involve transferring data
@@ -91,22 +95,26 @@ enum spi_mem_data_dir {
 struct spi_mem_op {
 	struct {
 		u8 buswidth;
+		u8 dtr : 1;
 		u8 opcode;
 	} cmd;
 
 	struct {
 		u8 nbytes;
 		u8 buswidth;
+		u8 dtr : 1;
 		u64 val;
 	} addr;
 
 	struct {
 		u8 nbytes;
 		u8 buswidth;
+		u8 dtr : 1;
 	} dummy;
 
 	struct {
 		u8 buswidth;
+		u8 dtr : 1;
 		enum spi_mem_data_dir dir;
 		unsigned int nbytes;
 		union {
-- 
2.26.2

