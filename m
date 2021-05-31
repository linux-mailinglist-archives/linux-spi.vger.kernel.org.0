Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C148E3967AD
	for <lists+linux-spi@lfdr.de>; Mon, 31 May 2021 20:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbhEaSUF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 May 2021 14:20:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59198 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhEaSUE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 May 2021 14:20:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14VII5v8078806;
        Mon, 31 May 2021 13:18:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622485085;
        bh=NTOU/toCq2bT4bwJWBm9sz5V4G6tb09L1YtZxu4df1w=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=M8BVz4Spe73DM6lVA8Yrj1Dvkot9+tnTBCG/vPisgOeXFryeKk668rThcJZUOXCFJ
         VCK0oW0iw+vMemW7NiNS4hjmaretM69tk06nuMrZ8N9UrG2mpCmdT3xzl0+oFS2FuA
         LVefCeJjlj/pt74KbE+B79dUkhp09bIeOZgswI+8=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14VII56g104242
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 13:18:05 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 13:18:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 13:18:05 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14VIHwdG118543;
        Mon, 31 May 2021 13:18:02 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 1/6] mtd: spi-nor: core: use 2 data bytes for template ops
Date:   Mon, 31 May 2021 23:47:52 +0530
Message-ID: <20210531181757.19458-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210531181757.19458-1-p.yadav@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The template ops used in spi_nor_spimem_check_pp() and
spi_nor_spimem_check_readop() currently set the data phase to 1 byte
long. This is problematic for 8D-8D-8D protocol where odd length data
phase is invalid since one cycle transfers 2 bytes and odd number of
bytes would mean half a cycle is left over. This could result in a
controller rejecting the op as "not supported" even though it actually
supports the protocol.

Change the data length to 2 bytes in these templates. One might argue
that this should only be done for 8D-8D-8D operations but when talking
about these templates, there is no functional difference between one and
two bytes, even in STR modes.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

(no changes since v1)

 drivers/mtd/spi-nor/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index f6a6ef2d8bd8..d521ca577884 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2143,7 +2143,7 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(read->opcode, 0),
 					  SPI_MEM_OP_ADDR(3, 0, 0),
 					  SPI_MEM_OP_DUMMY(1, 0),
-					  SPI_MEM_OP_DATA_IN(1, NULL, 0));
+					  SPI_MEM_OP_DATA_IN(2, NULL, 0));
 
 	spi_nor_spimem_setup_op(nor, &op, read->proto);
 
@@ -2169,7 +2169,7 @@ static int spi_nor_spimem_check_pp(struct spi_nor *nor,
 	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(pp->opcode, 0),
 					  SPI_MEM_OP_ADDR(3, 0, 0),
 					  SPI_MEM_OP_NO_DUMMY,
-					  SPI_MEM_OP_DATA_OUT(1, NULL, 0));
+					  SPI_MEM_OP_DATA_OUT(2, NULL, 0));
 
 	spi_nor_spimem_setup_op(nor, &op, pp->proto);
 
-- 
2.30.0

