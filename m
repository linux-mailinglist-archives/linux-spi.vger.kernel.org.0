Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21F3C70FD
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhGMNJX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:09:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44090 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbhGMNJX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:09:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DD6NBW010788;
        Tue, 13 Jul 2021 08:06:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181583;
        bh=Z+dB4EvIxzpNpYXg02AgomR/hSRcWS9Lo0ZQW7fNDtc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Oo0S+EXbHEbn2R/Gnz7WiTH5wedw8ONfFwwU9qXVakYoSvaMbphvjBJXxL6kR6/I1
         QT1h1ANyBOncumQIn/knRs183Ir04iaoJoJh3yCyb1YIRyYbKAlw2nc2gvjOegZ8b4
         at82K3v8yAuLpQrqpgU1pl9DrNZmBi9Rwdw8/EDQ=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DD6Nqe004963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 08:06:23 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 08:06:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 08:06:23 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DD5daI109825;
        Tue, 13 Jul 2021 08:06:19 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 08/13] mtd: spinand: Reject 8D-8D-8D op_templates if octal_dtr_enale() is missing in manufacturer_op
Date:   Tue, 13 Jul 2021 13:05:33 +0000
Message-ID: <20210713130538.646-9-a-nandan@ti.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210713130538.646-1-a-nandan@ti.com>
References: <20210713130538.646-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPI NAND core doesn't know how to switch the flash to Octal DTR
mode (i.e. which operations to perform). If the manufacturer hasn't
implemented the octal_dtr_enable() manufacturer_op, the SPI NAND core
wouldn't be able to switch to 8D-8D-8D mode and will also not be able
to run in 1S-1S-1S mode due to already selected 8D-8D-8D read/write
cache op_templates.

So, avoid choosing a Octal DTR SPI op_template for read_cache,
write_cache and update_cache operations, if the manufacturer_op
octal_dtr_enable() is missing.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/mtd/nand/spi/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 19d8affac058..8711e887b795 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1028,6 +1028,8 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
 		if (id[0] != manufacturer->id)
 			continue;
 
+		spinand->manufacturer = manufacturer;
+
 		ret = spinand_match_and_init(spinand,
 					     manufacturer->chips,
 					     manufacturer->nchips,
@@ -1035,7 +1037,6 @@ static int spinand_manufacturer_match(struct spinand_device *spinand,
 		if (ret < 0)
 			continue;
 
-		spinand->manufacturer = manufacturer;
 		return 0;
 	}
 	return -ENOTSUPP;
@@ -1097,6 +1098,10 @@ spinand_select_op_variant(struct spinand_device *spinand,
 		unsigned int nbytes;
 		int ret;
 
+		if (spinand_op_is_octal_dtr(&op) &&
+		    !spinand->manufacturer->ops->octal_dtr_enable)
+			continue;
+
 		nbytes = nanddev_per_page_oobsize(nand) +
 			 nanddev_page_size(nand);
 
-- 
2.17.1

