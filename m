Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE46D1DE3E7
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 12:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbgEVKOf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 06:14:35 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34418 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbgEVKOc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 06:14:32 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MAEK0R013908;
        Fri, 22 May 2020 05:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590142460;
        bh=vZHWXLCtyhdJG9oIb95lQ7NP/FmYNPGx8pS+OBRUJx0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ImacqQJIcU53gTKLLMzF4oq6EYuqls8Rr1AKW0IHJomq5GbTJhb01CHobGwz8jYYY
         Pho5HXG1Ouvu7aXq9BFNseI5+TgeTpBCOl+dCeF1XuRn9uOwkrKZEdboNMo1nPss7z
         VmkaZHqRiHhMKTXjQCq8xBq3VFQTUVIUUV1jEKg0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MAEK8I049952;
        Fri, 22 May 2020 05:14:20 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 05:14:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 05:14:19 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MAD1aF041179;
        Fri, 22 May 2020 05:14:15 -0500
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
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v7 14/20] mtd: spi-nor: sfdp: do not make invalid quad enable fatal
Date:   Fri, 22 May 2020 15:42:55 +0530
Message-ID: <20200522101301.26909-15-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200522101301.26909-1-p.yadav@ti.com>
References: <20200522101301.26909-1-p.yadav@ti.com>
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
BFPT parsing. Instead, continue BFPT parsing assuming there is no quad
enable bit present.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/sfdp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 052cabb52df9..9fd3d8d9a127 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -576,10 +576,6 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 
 	/* Quad Enable Requirements. */
 	switch (bfpt.dwords[BFPT_DWORD(15)] & BFPT_DWORD15_QER_MASK) {
-	case BFPT_DWORD15_QER_NONE:
-		params->quad_enable = NULL;
-		break;
-
 	case BFPT_DWORD15_QER_SR2_BIT1_BUGGY:
 		/*
 		 * Writing only one byte to the Status Register has the
@@ -616,8 +612,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		params->quad_enable = spi_nor_sr2_bit1_quad_enable;
 		break;
 
+	case BFPT_DWORD15_QER_NONE:
 	default:
-		return -EINVAL;
+		params->quad_enable = NULL;
+		break;
 	}
 
 	/* Stop here if JESD216 rev B. */
-- 
2.26.2

