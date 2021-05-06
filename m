Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F219D375B96
	for <lists+linux-spi@lfdr.de>; Thu,  6 May 2021 21:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbhEFTTy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 15:19:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54858 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhEFTTx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 15:19:53 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 146JIl7Q080697;
        Thu, 6 May 2021 14:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1620328727;
        bh=51TzeSbN2W/QrtF8UKtVaKXzI9nWsasCyemZNbc06W8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DsIYSc4ZgQFbLd6jCAtwVLWOundP5ZBYXW6hBKZugGo0/4aFPwpeaUdFy+KQ64RHM
         oIpkQE+2bmyLTPaz5qsHSMY2xvGuat/oAR10/FzlNVA/OJEqVvgTueFWk4GUeH9ON+
         WCeFYTpiEuSv08D9m6EulMfjP5K0aVfZWvbaSOCg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 146JIlPe097520
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 6 May 2021 14:18:47 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 6 May
 2021 14:18:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Thu, 6 May 2021 14:18:47 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 146JIUNG026052;
        Thu, 6 May 2021 14:18:44 -0500
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
Subject: [PATCH 4/6] spi: spi-mem: reject partial cycle transfers in 8D-8D-8D mode
Date:   Fri, 7 May 2021 00:48:27 +0530
Message-ID: <20210506191829.8271-5-p.yadav@ti.com>
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

In 8D-8D-8D mode two bytes are transferred per cycle. So an odd number
of bytes cannot be transferred because it would leave a residual half
cycle at the end. Consider such a transfer invalid and reject it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>

---
This patch should go through the SPI tree but I have included it in this
series because if it goes in before patches 1-3, Micron MT35XU and
Cypress S28HS flashes will stop working correctly.

 drivers/spi/spi-mem.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 1513553e4080..ab9eefbaa1d9 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -162,7 +162,17 @@ static bool spi_mem_check_buswidth(struct spi_mem *mem,
 bool spi_mem_dtr_supports_op(struct spi_mem *mem,
 			     const struct spi_mem_op *op)
 {
-	if (op->cmd.nbytes != 2)
+	if (op->cmd.buswidth == 8 && op->cmd.nbytes % 2)
+		return false;
+
+	if (op->addr.nbytes && op->addr.buswidth == 8 && op->addr.nbytes % 2)
+		return false;
+
+	if (op->dummy.nbytes && op->dummy.buswidth == 8 && op->dummy.nbytes % 2)
+		return false;
+
+	if (op->data.dir != SPI_MEM_NO_DATA &&
+	    op->dummy.buswidth == 8 && op->data.nbytes % 2)
 		return false;
 
 	return spi_mem_check_buswidth(mem, op);
-- 
2.30.0

