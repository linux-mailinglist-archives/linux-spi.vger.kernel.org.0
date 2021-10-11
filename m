Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42C429911
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 23:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbhJKVmp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 17:42:45 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbhJKVmp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 17:42:45 -0400
X-Greylist: delayed 3227 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 17:42:41 EDT
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKl5tQ071016;
        Mon, 11 Oct 2021 15:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985225;
        bh=DFZQnhqlxo23Wmwjp8fS/CEqoUGjmQJfz+RoEPGUJNY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kfL7inrw9Uy0mByZ9k/uXRYknUVv3fhl/s9YeXBtqys0S7OprKf9vkjBfqQSsXzmx
         xfrjSXaIFUbX4EXf3U4QCCxFoGm0uP3jk8+Dj9jlVoSMjCev7OsTvbsgslxRC2mE5c
         B8MxSOcUzPobiRs8HCBIPhIZbPVqaQK/PlKN33ZQ=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKl5uM096784
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:47:05 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:47:04 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:47:04 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEl069811;
        Mon, 11 Oct 2021 15:47:00 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Apurva Nandan <a-nandan@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     <p.yadav@ti.com>
Subject: [PATCH v2 07/14] mtd: spinand: Allow enabling Octal DTR mode in the core
Date:   Tue, 12 Oct 2021 02:16:12 +0530
Message-ID: <20211011204619.81893-8-a-nandan@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211011204619.81893-1-a-nandan@ti.com>
References: <20211011204619.81893-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Enable Octal DTR SPI mode, i.e. 8D-8D-8D mode, if the SPI NAND flash
device supports it. Mixed OSPI (1S-1S-8S & 1S-8S-8S), mixed DTR modes
(1S-1D-8D), etc. aren't supported yet.

The method to switch to Octal DTR SPI mode may vary across
manufacturers. For example, for Winbond, it is enabled by writing
values to the volatile configuration register. So, let the
manufacturer's code have their own implementation for switching to
Octal DTR SPI mode.

Check for the SPI NAND device's support for Octal DTR mode using
spinand flags, and if the op_templates allows 8D-8D-8D, call
octal_dtr_enable() manufacturer op. If the SPI controller doesn't
supports these modes, the selected op_templates will prevent switching
to the Octal DTR mode. And finally update the spinand reg_proto
on success.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 46 +++++++++++++++++++++++++++++++++++++
 include/linux/mtd/spinand.h |  3 +++
 2 files changed, 49 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8e6cf7941a0f..1210946f8447 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -257,6 +257,48 @@ static int spinand_init_quad_enable(struct spinand_device *spinand)
 			       enable ? CFG_QUAD_ENABLE : 0);
 }
 
+static bool spinand_op_is_octal_dtr(const struct spi_mem_op *op)
+{
+	return  op->cmd.buswidth == 8 && op->cmd.dtr &&
+		op->addr.buswidth == 8 && op->addr.dtr &&
+		op->data.buswidth == 8 && op->data.dtr;
+}
+
+static int spinand_init_octal_dtr_enable(struct spinand_device *spinand)
+{
+	struct device *dev = &spinand->spimem->spi->dev;
+	int ret;
+
+	if (!(spinand->flags & SPINAND_HAS_OCTAL_DTR_BIT))
+		return 0;
+
+	if (!(spinand_op_is_octal_dtr(spinand->op_templates.read_cache) &&
+	      spinand_op_is_octal_dtr(spinand->op_templates.write_cache) &&
+	      spinand_op_is_octal_dtr(spinand->op_templates.update_cache)))
+		return 0;
+
+	if (!spinand->manufacturer->ops->octal_dtr_enable) {
+		dev_dbg(dev,
+			"Missing ->octal_dtr_enable(), unable to switch mode\n");
+		return -EINVAL;
+	}
+
+	ret = spinand->manufacturer->ops->octal_dtr_enable(spinand);
+	if (ret) {
+		dev_err(dev,
+			"Failed to enable Octal DTR SPI mode (err = %d)\n",
+			ret);
+		return ret;
+	}
+
+	spinand->reg_proto = SPINAND_OCTAL_DTR;
+
+	dev_dbg(dev,
+		"%s SPI NAND switched to Octal DTR SPI (8D-8D-8D) mode\n",
+		spinand->manufacturer->name);
+	return 0;
+}
+
 static int spinand_ecc_enable(struct spinand_device *spinand,
 			      bool enable)
 {
@@ -1192,6 +1234,10 @@ static int spinand_init_flash(struct spinand_device *spinand)
 	if (ret)
 		return ret;
 
+	ret = spinand_init_octal_dtr_enable(spinand);
+	if (ret)
+		return ret;
+
 	ret = spinand_upd_cfg(spinand, CFG_OTP_ENABLE, 0);
 	if (ret)
 		return ret;
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 35816b8cfe81..daa2ac5c3110 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -271,6 +271,7 @@ struct spinand_devid {
  * @init: initialize a SPI NAND device
  * @adjust_op: modify the ops for any variation in their cmd, address, dummy or
  *	       data phase by the manufacturer
+ * @octal_dtr_enable: switch the SPI NAND flash into Octal DTR SPI mode
  * @cleanup: cleanup a SPI NAND device
  *
  * Each SPI NAND manufacturer driver should implement this interface so that
@@ -280,6 +281,7 @@ struct spinand_manufacturer_ops {
 	int (*init)(struct spinand_device *spinand);
 	void (*adjust_op)(struct spi_mem_op *op,
 			  const enum spinand_proto reg_proto);
+	int (*octal_dtr_enable)(struct spinand_device *spinand);
 	void (*cleanup)(struct spinand_device *spinand);
 };
 
@@ -348,6 +350,7 @@ struct spinand_ecc_info {
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
 #define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
+#define SPINAND_HAS_OCTAL_DTR_BIT	BIT(2)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure
-- 
2.25.1

