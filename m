Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1307242990C
	for <lists+linux-spi@lfdr.de>; Mon, 11 Oct 2021 23:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhJKVmm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 Oct 2021 17:42:42 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52728 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhJKVml (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 Oct 2021 17:42:41 -0400
X-Greylist: delayed 3227 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 17:42:41 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 19BKlSFS071163;
        Mon, 11 Oct 2021 15:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1633985248;
        bh=JsMJVwDttgmG/vVRT1b55ya+HKmXPSJxJ7o0HOFrZPc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZQjRBXuHJxJb5yA6WKWJqItXM6OGAChveEydtd36qYfsgp/00/bzx4xX+r/znG7IB
         vaBghenKIP+0YWw9InzK3KdbpKnbERKTkYGAVHm1U6b4mNySXIWh3VvLemospM4fOq
         swjp5UN89acG5e6zLtxtSPg63JEc0QvGArfY8IRo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 19BKlSst106134
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Oct 2021 15:47:28 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Oct 2021 15:47:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Oct 2021 15:47:28 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 19BKkKEp069811;
        Mon, 11 Oct 2021 15:47:23 -0500
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
Subject: [PATCH v2 11/14] mtd: spinand: Perform Power-on-Reset on the flash in mtd_suspend()
Date:   Tue, 12 Oct 2021 02:16:16 +0530
Message-ID: <20211011204619.81893-12-a-nandan@ti.com>
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

A soft reset using FFh command doesn't erase the flash's configuration
and doesn't reset the SPI IO mode also. This can result in the flash
being in a different SPI IO mode, e.g. Octal DTR, when resuming from
sleep. This could put the flash in an unrecognized SPI IO mode, making
it unusable.

Perform a Power-on-Reset (PoR), if available in the flash, when
performing mtd_suspend(). This would set the flash to clean
state for reinitialization during resume and would also ensure that it
is in standard SPI IO mode (1S-1S-1S) before the resume begins.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 9b570570ee81..60408531979a 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1316,6 +1316,11 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
 	int ret;
 
 	spinand->reg_proto = SPINAND_SINGLE_STR;
+	/*
+	 * PoR Reset (if available by the manufacturer) is performed at the suspend
+	 * time. Hence, those flashes remain in power-on-state at this point, in a
+	 * standard SPI IO mode. So, now the core unanimously performs a soft reset.
+	 */
 	ret = spinand_reset_op(spinand);
 	if (ret)
 		return;
@@ -1327,6 +1332,21 @@ static void spinand_mtd_resume(struct mtd_info *mtd)
 	spinand_ecc_enable(spinand, false);
 }
 
+static int spinand_mtd_suspend(struct mtd_info *mtd)
+{
+	struct spinand_device *spinand = mtd_to_spinand(mtd);
+	int ret;
+
+	if (!(spinand->flags & SPINAND_HAS_POR_CMD_BIT))
+		return 0;
+
+	ret = spinand_power_on_rst_op(spinand);
+	if (ret)
+		dev_err(&spinand->spimem->spi->dev, "suspend() failed\n");
+
+	return ret;
+}
+
 static int spinand_init(struct spinand_device *spinand)
 {
 	struct device *dev = &spinand->spimem->spi->dev;
@@ -1399,6 +1419,7 @@ static int spinand_init(struct spinand_device *spinand)
 	mtd->_erase = spinand_mtd_erase;
 	mtd->_max_bad_blocks = nanddev_mtd_max_bad_blocks;
 	mtd->_resume = spinand_mtd_resume;
+	mtd->_suspend = spinand_mtd_suspend;
 
 	if (nand->ecc.engine) {
 		ret = mtd_ooblayout_count_freebytes(mtd);
-- 
2.25.1

