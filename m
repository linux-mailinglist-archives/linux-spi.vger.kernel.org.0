Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF14B205ACB
	for <lists+linux-spi@lfdr.de>; Tue, 23 Jun 2020 20:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387641AbgFWSbr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Jun 2020 14:31:47 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48102 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbgFWSbl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Jun 2020 14:31:41 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05NIVWB0046970;
        Tue, 23 Jun 2020 13:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592937092;
        bh=x4V4nT4Ljn5fI8ihOcptD057X9PN9/0Dd01/bQzGCUY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yjdzEo+aGGLkAqn02F4cGEldCr2YRPDEGpCSRirOGC6+jPHoMJn+p2EaBFHd+Ygv4
         X011W3kBQaPU64Ni0yxOQ0ZpxIBOQjfkBXarAMVJJnTLd8bGb/hIc/HDB8y8QmMTtn
         1iBwBzQ1X8TK34FE3uWdmLhYndTNbE8B0T5nkaxE=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05NIVWcm050230
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Jun 2020 13:31:32 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 23
 Jun 2020 13:31:32 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 23 Jun 2020 13:31:32 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05NIUVJP000942;
        Tue, 23 Jun 2020 13:31:27 -0500
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
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v10 11/17] mtd: spi-nor: sfdp: do not make invalid quad enable fatal
Date:   Wed, 24 Jun 2020 00:00:24 +0530
Message-ID: <20200623183030.26591-12-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200623183030.26591-1-p.yadav@ti.com>
References: <20200623183030.26591-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Micron MT35XU512ABA flash does not support the quad enable bit. But
instead of programming the Quad Enable Require field to 000b ("Device
does not have a QE bit"), it is programmed to 111b ("Reserved").

While this is technically incorrect, it is not reason enough to abort
BFPT parsing. Instead, continue BFPT parsing and let flashes set it in
their fixup hooks.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/sfdp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index d5a24e61813c..7983ff431346 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -612,7 +612,8 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
 
 	default:
-		return -EINVAL;
+		dev_dbg(nor->dev, "BFPT QER reserved value used\n");
+		break;
 	}
 
 	/* Stop here if not JESD216 rev C or later. */
-- 
2.27.0

