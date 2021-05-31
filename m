Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455993967B3
	for <lists+linux-spi@lfdr.de>; Mon, 31 May 2021 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhEaSUR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 May 2021 14:20:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57546 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbhEaSUP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 May 2021 14:20:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 14VIIESF129967;
        Mon, 31 May 2021 13:18:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1622485095;
        bh=Fu8WvY6/rtLls9Y273CPvcnnzDx3DcNBfQsHz4ua8x8=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=xl/YcaysWm93KAdXX+ysTbABNSvUBkYAUTx9M1XhQyklygP9QPlvN8GrhKSC0LLpM
         8mOHzG+ZuLtKLFmGZDMjBtc+K0X4+qwOkvLZOn1Mha4+5cZg65DfQL9tXcBUbQifer
         29xftLSfXHsCZtvm6x5nEeamsTEQTabBzZSRHlJU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 14VIIEJT027570
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 May 2021 13:18:14 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 13:18:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 31 May 2021 13:18:14 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 14VIHwdJ118543;
        Mon, 31 May 2021 13:18:12 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: [PATCH v2 4/6] spi: spi-mem: reject partial cycle transfers in 8D-8D-8D mode
Date:   Mon, 31 May 2021 23:47:55 +0530
Message-ID: <20210531181757.19458-5-p.yadav@ti.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210531181757.19458-1-p.yadav@ti.com>
References: <20210531181757.19458-1-p.yadav@ti.com>
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
Reviewed-by: Mark Brown <broonie@kernel.org>

---

Changes in v2:
- Add Mark's R-by (spell corrected).

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

