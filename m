Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 430A5184B84
	for <lists+linux-spi@lfdr.de>; Fri, 13 Mar 2020 16:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCMPrZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 13 Mar 2020 11:47:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43916 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgCMPrZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Mar 2020 11:47:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02DFlBG7111230;
        Fri, 13 Mar 2020 10:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584114431;
        bh=GnZ7KDQS7cPZq4ozExi+Vuo0RhZW3XYPSnf979ZlcBE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LIDwwXgdA04PxCL15uKNfXakpK/V+mu4/4Fdui2akqAnecnbUrrPBl2bQ6Wlvp/KP
         npgEWX7f48uhh5HE/JDCiPN7zeloB35DlpXpphQVBe2Mi7tpHWyASqbR+mGexIMdw8
         ierWbv7r1twf+ZZFTVydQLaLoV7EYGE0xpwMqhwc=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02DFlBjB127158;
        Fri, 13 Mar 2020 10:47:11 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 10:47:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 10:47:11 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02DFkkSJ034352;
        Fri, 13 Mar 2020 10:47:07 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 05/12] mtd: spi-nor: default to address width of 3 for configurable widths
Date:   Fri, 13 Mar 2020 21:16:38 +0530
Message-ID: <20200313154645.29293-6-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200313154645.29293-1-p.yadav@ti.com>
References: <20200313154645.29293-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

JESD216D.01 says that when the address width can be 3 or 4, it defaults
to 3 and enters 4-byte mode when given the appropriate command. So, when
we see a configurable width, default to 3 and let flash that default to
4 change it in a post-bfpt fixup.

This fixes SMPT parsing for flashes with configurable address width. If
the SMPT descriptor advertises variable address width, we use
nor->addr_width as the address width. But since it was not set to any
value from the SFDP table, the read command uses an address width of 0,
resulting in an incorrect read being issued.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/spi-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 9e0724f2a825..9335692e9bcb 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -3772,6 +3772,7 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	/* Number of address bytes. */
 	switch (bfpt.dwords[BFPT_DWORD(1)] & BFPT_DWORD1_ADDRESS_BYTES_MASK) {
 	case BFPT_DWORD1_ADDRESS_BYTES_3_ONLY:
+	case BFPT_DWORD1_ADDRESS_BYTES_3_OR_4:
 		nor->addr_width = 3;
 		break;
 
-- 
2.25.0

