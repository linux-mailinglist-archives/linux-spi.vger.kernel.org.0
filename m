Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AAC3C70C9
	for <lists+linux-spi@lfdr.de>; Tue, 13 Jul 2021 14:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhGMNAp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Jul 2021 09:00:45 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49672 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbhGMNAp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 13 Jul 2021 09:00:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16DCvsmG069678;
        Tue, 13 Jul 2021 07:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626181074;
        bh=Ui/KPZbAU38b0wA6rcSDGQuKj8dI11hQRsYTACt6x30=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DJtEsKQdwsMI4Ws50N2qSqcZ1WqNQTh4N4A/W7Sekse5w40EyeRRH1zE5ALSfkstc
         l/gOKpIzWnLdNxdeWgSxRLT2wy5TIWqw9zCqhp65cwVpmvyDQ5y+ixrqvU6UTkGWoP
         4GvLvljWW3T0ACNpChA6iYgQSGnjZdo7411Yn0xY=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16DCvse1074049
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jul 2021 07:57:54 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 13
 Jul 2021 07:57:54 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Tue, 13 Jul 2021 07:57:54 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16DCvh0X067892;
        Tue, 13 Jul 2021 07:57:51 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] spi: cadence-quadspi: Fix check condition for DTR ops
Date:   Tue, 13 Jul 2021 12:57:42 +0000
Message-ID: <20210713125743.1540-3-a-nandan@ti.com>
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

buswidth and dtr fields in spi_mem_op are only valid when the
corresponding spi_mem_op phase has a non-zero length. For example,
SPI NAND core doesn't set buswidth when using SPI_MEM_OP_NO_ADDR
phase.

Fix the dtr checks in set_protocol() and suppports_mem_op() to
ignore empty spi_mem_op phases, as checking for dtr field in
empty phase will result in false negatives.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index a2e1f4ce8b3e..a884678e8dff 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -322,7 +322,9 @@ static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
 	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
 	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
 	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
-	f_pdata->dtr = op->data.dtr && op->cmd.dtr && op->addr.dtr;
+	f_pdata->dtr = op->cmd.dtr &&
+		       (op->addr.dtr || !op->addr.nbytes) &&
+		       (op->data.dtr || !op->data.nbytes);
 
 	switch (op->data.buswidth) {
 	case 0:
@@ -1225,8 +1227,12 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 {
 	bool all_true, all_false;
 
-	all_true = op->cmd.dtr && op->addr.dtr && op->dummy.dtr &&
-		   op->data.dtr;
+	/* op->dummy.dtr is checked when converting nbytes into ncycles.*/
+	all_true = op->cmd.dtr &&
+		   (op->addr.dtr || !op->addr.nbytes) &&
+		   (op->dummy.dtr || !op->dummy.nbytes) &&
+		   (op->data.dtr || !op->data.nbytes);
+
 	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
 		    !op->data.dtr;
 
-- 
2.17.1

