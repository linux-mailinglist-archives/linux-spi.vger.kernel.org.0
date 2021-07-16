Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9153A3CBFAD
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jul 2021 01:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhGPX2K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 19:28:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34298 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238132AbhGPX2K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 19:28:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16GNPEUE103039;
        Fri, 16 Jul 2021 18:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626477914;
        bh=L5vCzoRkQigkbAVqP78UtYe9i/DkB1uxeqZmIcb2u7A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dBcJP6l1Zo9dRMl7QoonHef5Nl2YRoj8lUCxOr1rhGlZyE8VRiCFZ4GBNBA8OWY2v
         60kMnbyjkW7TeeN20agR1TwkBR5qJGFWKu03GgcIR+2Fb1X32HokoW6uqnE92WPoOV
         bwPFdIs2ssokmUN5WmBafWF8/UBbPlpgSWltGzkg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16GNPDwc094025
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 18:25:13 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 18:25:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Jul 2021 18:25:12 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16GNP5S8105596;
        Fri, 16 Jul 2021 18:25:10 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 1/2] spi: cadence-quadspi: Disable Auto-HW polling
Date:   Fri, 16 Jul 2021 23:25:02 +0000
Message-ID: <20210716232504.182-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210716232504.182-1-a-nandan@ti.com>
References: <20210716232504.182-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

cadence-quadspi has a builtin Auto-HW polling funtionality using which
it keep tracks of completion of write operations. When Auto-HW polling
is enabled, it automatically initiates status register read operation,
until the flash clears its busy bit.

cadence-quadspi controller doesn't allow an address phase when
auto-polling the busy bit on the status register. Unlike SPI NOR
flashes, SPI NAND flashes do require the address of status register
when polling the busy bit using the read register operation. As
Auto-HW polling is enabled by default, cadence-quadspi returns a
timeout for every write operation after an indefinite amount of
polling on SPI NAND flashes.

Disable Auto-HW polling completely as the spi-nor core, spinand core,
etc. take care of polling the busy bit on their own.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Link: https://lore.kernel.org/r/20210713125743.1540-2-a-nandan@ti.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 This patch has already been applied to
 https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
 [1/2] spi: cadence-quadspi: Disable Auto-HW polling
       commit: 9cb2ff11171264d10be7ea9e31d9ee5d49ba84a5
 Reposting it for sake of completeness of the v2 series.

 drivers/spi/spi-cadence-quadspi.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index d62d69dd72b9..a2de23516553 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -800,19 +800,20 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
 	reg = cqspi_calc_rdreg(f_pdata);
 	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
 
-	if (f_pdata->dtr) {
-		/*
-		 * Some flashes like the cypress Semper flash expect a 4-byte
-		 * dummy address with the Read SR command in DTR mode, but this
-		 * controller does not support sending address with the Read SR
-		 * command. So, disable write completion polling on the
-		 * controller's side. spi-nor will take care of polling the
-		 * status register.
-		 */
-		reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
-		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
-		writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
-	}
+	/*
+	 * SPI NAND flashes require the address of the status register to be
+	 * passed in the Read SR command. Also, some SPI NOR flashes like the
+	 * cypress Semper flash expect a 4-byte dummy address in the Read SR
+	 * command in DTR mode.
+	 *
+	 * But this controller does not support address phase in the Read SR
+	 * command when doing auto-HW polling. So, disable write completion
+	 * polling on the controller's side. spinand and spi-nor will take
+	 * care of polling the status register.
+	 */
+	reg = readl(reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
+	reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
+	writel(reg, reg_base + CQSPI_REG_WR_COMPLETION_CTRL);
 
 	reg = readl(reg_base + CQSPI_REG_SIZE);
 	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
-- 
2.17.1

