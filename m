Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E30D3C70C8
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 14:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhGMNAo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:00:44 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49664 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhGMNAn (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:00:43 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DCvpQ7069668;
        Tue, 13 Jul 2021 07:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181071;
        bh=8+U3+hf/RxO832fzd5pE5Pkprza+cUV+ZZiHMspwBxg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IqvM2GHeSqVbT72HbgkhLv6PkdsZrqxVwiH9YhgpS+eI/sgejYXuanNOdtZfLLT1G
         TqaH8hO+Aa+ScZ4Ru38BG4W687E3ecBNqzPd4Vw+OTzuM9G4CsFMGkd/yYLV1KX5jz
         woLfJ/r/h59RmjoHYymT+stJVqt9FCeIKz6/ZEA0=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DCvpOL088289
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 07:57:51 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 07:57:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 07:57:51 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DCvh0W067892;
        Tue, 13 Jul 2021 07:57:48 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 1/2] spi: cadence-quadspi: Disable Auto-HW polling
Date:   Tue, 13 Jul 2021 12:57:41 +0000
Message-ID: <20210713125743.1540-2-a-nandan@ti.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20210713125743.1540-1-a-nandan@ti.com>
References: <20210713125743.1540-1-a-nandan@ti.com>
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
---
 drivers/spi/spi-cadence-quadspi.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 7a00346ff9b9..a2e1f4ce8b3e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -797,19 +797,20 @@ static int cqspi_write_setup(struct cqspi_flash_pdata *f_pdata,
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

