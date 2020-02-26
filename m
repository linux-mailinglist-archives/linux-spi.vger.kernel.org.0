Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D316FAFC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBZJiD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 04:38:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45698 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727457AbgBZJiC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Feb 2020 04:38:02 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01Q9bpYG048469;
        Wed, 26 Feb 2020 03:37:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582709872;
        bh=f73KydanqCBfpggGnWafdMQaZ6wiesDHl1RvZlVeYSw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=No0k3OIxU014MkfBvJ/fgCEQgTU7Z/CIgPHeLbBZuNxg97HCQabtuGeyb9bWOr/+H
         NBRwuOutUGuYTPlp9TIJ63sj5HHaz5l+8TMVBu76ri4gs1VS+EqUgVtcuc4F55DO+J
         1sLHBaf1ZOvmd1rXzk0+7N8QkkBuz9qMjSA0Imuc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01Q9bpPI119216
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 03:37:51 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 03:37:51 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 03:37:51 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01Q9b4AF110613;
        Wed, 26 Feb 2020 03:37:47 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 10/11] mtd: spi-nor: enable octal DTR mode when possible
Date:   Wed, 26 Feb 2020 15:07:02 +0530
Message-ID: <20200226093703.19765-11-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226093703.19765-1-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Allow flashes to specify a hook to enable octal DTR mode. Use this hook
whenever possible to get optimal transfer speeds.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 31 +++++++++++++++++++++++++++++++
 include/linux/mtd/spi-nor.h   |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 06cfc525260c..fdcc1b4abc3f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -5184,6 +5184,31 @@ static void spi_nor_init_params(struct spi_nor *nor)
 	spi_nor_late_init_params(nor);
 }
 
+/** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
+ * @nor:                 pointer to a 'struct spi_nor'
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_octal_dtr_enable(struct spi_nor *nor)
+{
+	int ret;
+
+	if (!nor->params.octal_dtr_enable)
+		return 0;
+
+	if (!(spi_nor_get_protocol_width(nor->read_proto) == 8 ||
+	      spi_nor_get_protocol_width(nor->write_proto) == 8))
+		return 0;
+
+	ret = nor->params.octal_dtr_enable(nor);
+	if (ret)
+		return ret;
+
+	nor->reg_proto = SNOR_PROTO_8_8_8_DTR;
+
+	return 0;
+}
+
 /**
  * spi_nor_quad_enable() - enable Quad I/O if needed.
  * @nor:                pointer to a 'struct spi_nor'
@@ -5223,6 +5248,12 @@ static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
 
+	err = spi_nor_octal_dtr_enable(nor);
+	if (err) {
+		dev_dbg(nor->dev, "octal mode not supported\n");
+		return err;
+	}
+
 	err = spi_nor_quad_enable(nor);
 	if (err) {
 		dev_dbg(nor->dev, "quad mode not supported\n");
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index f54dbd0f86ab..c653f6713cfc 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -526,6 +526,7 @@ struct spi_nor_locking_ops {
  *                      higher index in the array, the higher priority.
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
+ * @octal_dtr_enable:	enables SPI NOR octal DTR mode.
  * @quad_enable:	enables SPI NOR quad mode.
  * @set_4byte:		puts the SPI NOR in 4 byte addressing mode.
  * @convert_addr:	converts an absolute address into something the flash
@@ -549,6 +550,7 @@ struct spi_nor_flash_parameter {
 
 	struct spi_nor_erase_map        erase_map;
 
+	int (*octal_dtr_enable)(struct spi_nor *nor);
 	int (*quad_enable)(struct spi_nor *nor);
 	int (*set_4byte)(struct spi_nor *nor, bool enable);
 	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
-- 
2.25.0

