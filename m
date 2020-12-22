Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B362E0E53
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgLVSpU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 13:45:20 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54430 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLVSpU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 13:45:20 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIicTi015127;
        Tue, 22 Dec 2020 12:44:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608662678;
        bh=Du77HrhWi4pd+7wwLeZRYp75zCGbSn46ZKg0KfSr1pU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oJQOXOtfFFuDUaluUaDzSSo8WD0x0qxbQBV4CBeOWZzEBX55A4moCGw5PJC6KfzBD
         Td1KvhYiYSEbTSFTZdUDkS1mqcBCXykFHn+bSXst4L4LxIBk5C8xx9svMszZnL9nt/
         SP9vnY0q20Bsnm5SsbwMG9o1RjEX1bK+J8KNb22Y=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BMIicZK123007
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 12:44:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 12:44:38 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 12:44:38 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiQbd003761;
        Tue, 22 Dec 2020 12:44:36 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/7] spi: cadence-quadspi: Implement a simple supports_op hook
Date:   Wed, 23 Dec 2020 00:14:23 +0530
Message-ID: <20201222184425.7028-6-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201222184425.7028-1-p.yadav@ti.com>
References: <20201222184425.7028-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The default SPI MEM supports_op hook rejects DTR ops by default. Add a
simple supports_op hook that very closely imitates the SPI MEM one. It
will be extended in later commits to allow DTR ops.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 61 +++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 376abef43530..1781d4e94ebd 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1031,6 +1031,66 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return ret;
 }
 
+static int cqspi_check_buswidth_req(struct spi_mem *mem, u8 buswidth, bool tx)
+{
+	u32 mode = mem->spi->mode;
+
+	switch (buswidth) {
+	case 1:
+		return 0;
+
+	case 2:
+		if ((tx &&
+		     (mode & (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx &&
+		     (mode & (SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL))))
+			return 0;
+
+		break;
+
+	case 4:
+		if ((tx && (mode & (SPI_TX_QUAD | SPI_TX_OCTAL))) ||
+		    (!tx && (mode & (SPI_RX_QUAD | SPI_RX_OCTAL))))
+			return 0;
+
+		break;
+
+	case 8:
+		if ((tx && (mode & SPI_TX_OCTAL)) ||
+		    (!tx && (mode & SPI_RX_OCTAL)))
+			return 0;
+
+		break;
+
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
+static bool cqspi_supports_mem_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	if (cqspi_check_buswidth_req(mem, op->cmd.buswidth, true))
+		return false;
+
+	if (op->addr.nbytes &&
+	    cqspi_check_buswidth_req(mem, op->addr.buswidth, true))
+		return false;
+
+	if (op->dummy.nbytes &&
+	    cqspi_check_buswidth_req(mem, op->dummy.buswidth, true))
+		return false;
+
+	if (op->data.nbytes &&
+	    cqspi_check_buswidth_req(mem, op->data.buswidth,
+				     op->data.dir == SPI_MEM_DATA_OUT))
+		return false;
+
+	return true;
+}
+
 static int cqspi_of_get_flash_pdata(struct platform_device *pdev,
 				    struct cqspi_flash_pdata *f_pdata,
 				    struct device_node *np)
@@ -1159,6 +1219,7 @@ static const char *cqspi_get_name(struct spi_mem *mem)
 static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
 	.get_name = cqspi_get_name,
+	.supports_op = cqspi_supports_mem_op,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
-- 
2.28.0

