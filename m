Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E5F1E9D82
	for <lists+linux-spi@lfdr.de>; Mon,  1 Jun 2020 07:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgFAFs2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 1 Jun 2020 01:48:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40912 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgFAFsX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 1 Jun 2020 01:48:23 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0515lth2020332;
        Mon, 1 Jun 2020 00:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590990475;
        bh=Q9mpt5L2+tz9UJjcTocJbBwQDj4+9uQU3fRytRCiokA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ix8IY9ZR+b9ycV8x5BFSbc6S/2e0D3rGebdu1A7ORLcpi1vOiHzvE+QhPHomshRbb
         rIi7t7svg2KHccDUUvYi4N+JR9RCeKAxA8o1WdsPP879wpukIUN5aByIFRjUSJDNlK
         c75VShP1a1DNxi0rDj17vosBbPeVEEo49o23/Fdk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0515lto7031993
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 1 Jun 2020 00:47:55 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 1 Jun
 2020 00:47:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 1 Jun 2020 00:47:55 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0515lRPm038289;
        Mon, 1 Jun 2020 00:47:52 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: [PATCH v3 6/8] mtd: spi-nor: cadence-quadspi: Drop redundant WREN in erase path
Date:   Mon, 1 Jun 2020 11:17:23 +0530
Message-ID: <20200601054725.2060-7-vigneshr@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601054725.2060-1-vigneshr@ti.com>
References: <20200601054725.2060-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Drop redundant WREN command in cqspi_erase() as SPI NOR core takes care
of sending WREN command before sending erase command.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/controllers/cadence-quadspi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
index 0570ebca135a..6b1cbad25e3f 100644
--- a/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
+++ b/drivers/mtd/spi-nor/controllers/cadence-quadspi.c
@@ -1016,11 +1016,6 @@ static int cqspi_erase(struct spi_nor *nor, loff_t offs)
 	if (ret)
 		return ret;
 
-	/* Send write enable, then erase commands. */
-	ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN, NULL, 0);
-	if (ret)
-		return ret;
-
 	/* Set up command buffer. */
 	ret = cqspi_command_write_addr(nor, nor->erase_opcode, offs);
 	if (ret)
-- 
2.26.2

