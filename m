Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57805375B94
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 21:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbhEFTTv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 15:19:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47034 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhEFTTt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 15:19:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 146JIbn9095390;
        Thu, 6 May 2021 14:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620328717;
        bh=TFnKVuKDTO2GGB/wxF7cdWs6/1Bvz3DWxZTs5bMoFIY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hOLWIynym8Jyu3M2Yf8x/UcU049qO5osg/1u9l1iAz3g9I63Mv3t7Vu0JhlmsO9yG
         QpoyNbmuIsT6OrvEjDZrF+kBlgv/HN5R4KG2xWnvL3PH58z7RvFw61ny/wyUkc+Zzx
         VK1+Rjqp7uyobsjfcfL1+jlfF2vzlY0ihR6mMk6Q=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 146JIbPm097453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 May 2021 14:18:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 6 May
 2021 14:18:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 6 May 2021 14:18:37 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 146JIUND026052;
        Thu, 6 May 2021 14:18:34 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 1/6] mtd: spi-nor: core: use 2 data bytes for template ops
Date:   Fri, 7 May 2021 00:48:24 +0530
Message-ID: <20210506191829.8271-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210506191829.8271-1-p.yadav@ti.com>
References: <20210506191829.8271-1-p.yadav@ti.com>
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

 drivers/mtd/spi-nor/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index bd2c7717eb10..5cc206b8bbf3 100644
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

