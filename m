Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF473CBFAF
	for <lists+linux-spi@lfdr.de>; Sat, 17 Jul 2021 01:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238385AbhGPX2O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 19:28:14 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51490 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbhGPX2N (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 19:28:13 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 16GNPGSp034143;
        Fri, 16 Jul 2021 18:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1626477916;
        bh=KMh+xYCKp3lz1lbhSc7teWZOSWSvK8XcAT3a/rlmcMQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nMMozQfClJmhB90YB5EBQsK50YFCcivMBggqJgVXgIeXpU09d6B1BZv06GvDsX67z
         fXsAAy9DmUjb6K4Gg2urDAIPpWBpYEm2HygNE04Wx1Wj6fJUQeyfF4BpUMfCUK3Tjy
         UAAEd/aIKEwtsmZwu/B7w9Y8IND0C6OKsou/DCkA=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 16GNPGYJ069159
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 18:25:16 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 18:25:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Fri, 16 Jul 2021 18:25:16 -0500
Received: from LT5CD112GSQZ.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 16GNP5S9105596;
        Fri, 16 Jul 2021 18:25:13 -0500
From:   Apurva Nandan <a-nandan@ti.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Apurva Nandan <a-nandan@ti.com>, Pratyush Yadav <p.yadav@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH v2 2/2] spi: cadence-quadspi: Fix check condition for DTR ops
Date:   Fri, 16 Jul 2021 23:25:03 +0000
Message-ID: <20210716232504.182-3-a-nandan@ti.com>
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

buswidth and dtr fields in spi_mem_op are only valid when the
corresponding spi_mem_op phase has a non-zero length. For example,
SPI NAND core doesn't set buswidth when using SPI_MEM_OP_NO_ADDR
phase.

Fix the dtr checks in set_protocol() and suppports_mem_op() to
ignore empty spi_mem_op phases, as checking for dtr field in
empty phase will result in false negatives.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index a2de23516553..1cec1c179a94 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -325,7 +325,15 @@ static int cqspi_set_protocol(struct cqspi_flash_pdata *f_pdata,
 	f_pdata->inst_width = CQSPI_INST_TYPE_SINGLE;
 	f_pdata->addr_width = CQSPI_INST_TYPE_SINGLE;
 	f_pdata->data_width = CQSPI_INST_TYPE_SINGLE;
-	f_pdata->dtr = op->data.dtr && op->cmd.dtr && op->addr.dtr;
+
+	/*
+	 * For an op to be DTR, cmd phase along with every other non-empty
+	 * phase should have dtr field set to 1. If an op phase has zero
+	 * nbytes, ignore its dtr field; otherwise, check its dtr field.
+	 */
+	f_pdata->dtr = op->cmd.dtr &&
+		       (!op->addr.nbytes || op->addr.dtr) &&
+		       (!op->data.nbytes || op->data.dtr);
 
 	switch (op->data.buswidth) {
 	case 0:
@@ -1228,8 +1236,15 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 {
 	bool all_true, all_false;
 
-	all_true = op->cmd.dtr && op->addr.dtr && op->dummy.dtr &&
-		   op->data.dtr;
+	/*
+	 * op->dummy.dtr is required for converting nbytes into ncycles.
+	 * Also, don't check the dtr field of the op phase having zero nbytes.
+	 */
+	all_true = op->cmd.dtr &&
+		   (!op->addr.nbytes || op->addr.dtr) &&
+		   (!op->dummy.nbytes || op->dummy.dtr) &&
+		   (!op->data.nbytes || op->data.dtr);
+
 	all_false = !op->cmd.dtr && !op->addr.dtr && !op->dummy.dtr &&
 		    !op->data.dtr;
 
-- 
2.17.1

