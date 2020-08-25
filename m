Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BA4251E36
	for <lists+linux-spi@lfdr.de>; Tue, 25 Aug 2020 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgHYRZf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Aug 2020 13:25:35 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35076 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHYRZ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 25 Aug 2020 13:25:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07PHPHYG106758;
        Tue, 25 Aug 2020 12:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598376317;
        bh=jT2eGic+v+kkUY8P0eAP0PtOx1znlwcxaRGMQeI7Es0=;
        h=From:To:CC:Subject:Date;
        b=WL0TbBQeI4X82fsxZgtfuTCG1Nlr2P2G4TT8aaINMI5dPT6ijahcI/6eOWkuBi/xn
         cYocGme5U0gXU1n6SVdzkx15LOsgaa/Qp22OhayMqtH8EpgK9+5IPummY1PsNuo82B
         c9JiwEXSz2uYjBdcAEfjruC2eiT/KRpEPS1GI7Jw=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07PHPHTr095720
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 12:25:17 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 25
 Aug 2020 12:25:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 25 Aug 2020 12:25:17 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07PHPDPe080122;
        Tue, 25 Aug 2020 12:25:14 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spi-cadence-quadspi: Populate get_name() interface
Date:   Tue, 25 Aug 2020 22:55:06 +0530
Message-ID: <20200825172506.14375-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Implement get_name() interface of spi_controller_mem_ops so as to avoid
changing of mtd->name due to driver being moved over to spi-mem
framework from SPI NOR. This avoids breaking of MTD cmdline args being
passed by bootloaders which maybe using old driver name.

Fixes: 31fb632b5d43c ("spi: Move cadence-quadspi driver to drivers/spi/")
Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1c1a9d17eec0d..508b219eabf80 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1128,8 +1128,17 @@ static int cqspi_request_mmap_dma(struct cqspi_st *cqspi)
 	return 0;
 }
 
+static const char *cqspi_get_name(struct spi_mem *mem)
+{
+	struct cqspi_st *cqspi = spi_master_get_devdata(mem->spi->master);
+	struct device *dev = &cqspi->pdev->dev;
+
+	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
+}
+
 static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
+	.get_name = cqspi_get_name,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
-- 
2.28.0

