Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A2130F4BC
	for <lists+linux-spi@lfdr.de>; Thu,  4 Feb 2021 15:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhBDOR2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 4 Feb 2021 09:17:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50082 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236674AbhBDONf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 4 Feb 2021 09:13:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 114ECOGL084754;
        Thu, 4 Feb 2021 08:12:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1612447944;
        bh=mcjR2G19gYaIPmqrIxviuqIGzP715O2RZTLlQKsRu2g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BZfd8UqOlEN51X9hFdmKfvBOIoFa9eFrthg2Ai2GqyYhzaFGCJ6+sYUCK/APuz+6k
         jQXGz47hfoAwdDPgzHrdu6kgbt/jiVB406NUcI0emYe2L5kV57P28HkXh+Kc79/qMv
         DfQc9MfO26momXHtKfXMH15qR4ki+3l+pszoMS+c=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 114ECOtm033810
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 Feb 2021 08:12:24 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 4 Feb
 2021 08:12:24 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 4 Feb 2021 08:12:24 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 114ECJIu123632;
        Thu, 4 Feb 2021 08:12:22 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, <zhengxunli@mxic.com.tw>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/2] spi: cadence-quadspi: Use spi_mem_dtr_supports_op()
Date:   Thu, 4 Feb 2021 19:42:18 +0530
Message-ID: <20210204141218.32229-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210204141218.32229-1-p.yadav@ti.com>
References: <20210204141218.32229-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use the newly introduced spi_mem_dtr_supports_op() to check DTR op
support. This means the buswidth check does not need to be replicated.
It also happens to fix a bug where STR ops with a 2-byte opcode would be
reported as supported.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

Tested on TI's J721E with MT35XU512ABA and J7200 with S28HS512T.

 drivers/spi/spi-cadence-quadspi.c | 63 ++-----------------------------
 1 file changed, 4 insertions(+), 59 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b7ecbc8c1caa..442cc7c53a47 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1219,65 +1219,11 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return ret;
 }

-static int cqspi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
-{
-	u32 mode = mem->spi->mode;
-
-	switch (buswidth) {
-	case 1:
-		return 0;
-
-	case 2:
-		if ((tx &&
-		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
-		    (!tx &&
-		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
-			return 0;
-
-		break;
-
-	case 4:
-		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
-		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
-			return 0;
-
-		break;
-
-	case 8:
-		if ((tx && (mode & SPI_TX_OCTAL)) ||
-		    (!tx && (mode & SPI_RX_OCTAL)))
-			return 0;
-
-		break;
-
-	default:
-		break;
-	}
-
-	return -EOPNOTSUPP;
-}
-
 static bool cqspi_supports_mem_op(struct spi_mem *mem,
 				  const struct spi_mem_op *op)
 {
 	bool all_true, all_false;

-	if (cqspi_check_buswidth_req(mem, op->cmd.buswidth, true))
-		return false;
-
-	if (op->addr.nbytes &&
-	    cqspi_check_buswidth_req(mem, op->addr.buswidth, true))
-		return false;
-
-	if (op->dummy.nbytes &&
-	    cqspi_check_buswidth_req(mem, op->dummy.buswidth, true))
-		return false;
-
-	if (op->data.nbytes &&
-	    cqspi_check_buswidth_req(mem, op->data.buswidth,
-				     op->data.dir == SPI_MEM_DATA_OUT))
-		return false;
-
 	all_true = op->cmd.dtr && op->addr.dtr && op->dummy.dtr &&
 		   op->data.dtr;
 	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
@@ -1287,11 +1233,10 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 	if (!(all_true || all_false))
 		return false;

-	/* DTR mode opcodes should be 2 bytes. */
-	if (all_true && op->cmd.nbytes != 2)
-		return false;
-
-	return true;
+	if (all_true)
+		return spi_mem_dtr_supports_op(mem, op);
+	else
+		return spi_mem_default_supports_op(mem, op);
 }

 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
--
2.30.0

