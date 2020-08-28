Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648A2255594
	for <lists+linux-spi@lfdr.de>; Fri, 28 Aug 2020 09:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgH1Hrt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Aug 2020 03:47:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59684 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgH1Hrs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Aug 2020 03:47:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07S7ldLN055379;
        Fri, 28 Aug 2020 02:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598600859;
        bh=asKcJDTQmbkVWh1oo047VzwZ6hi/mmdOx2VzMsErg/c=;
        h=From:To:CC:Subject:Date;
        b=t1OJeGrU7ULaU9AE5wjKvdKprxBqGE3tCrQYMGXhKGOn8D6BPD6aDil8cIFQsfkYD
         KLYkXLY8OwOW0yMvf8p97+jt2TfVHqzfHhobCCfGEzh9gn0kn1pRn7Fo+LoJzRqzCw
         b6JiQl41xQjIYiT3bVcPUdT7xPkTvwBXrOk5Atc0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07S7ldQY024943
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 02:47:39 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 28
 Aug 2020 02:47:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 28 Aug 2020 02:47:38 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07S7lZ8H012237;
        Fri, 28 Aug 2020 02:47:36 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads
Date:   Fri, 28 Aug 2020 13:17:26 +0530
Message-ID: <20200828074726.24546-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Buffers need to mapped to DMA channel's device pointer instead of SPI
controller's device pointer as its system DMA that actually does data
transfer.
Data inconsistencies have been reported when reading from flash
without this fix.

Fixes: 31fb632b5d43c ("spi: Move cadence-quadspi driver to drivers/spi/")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---

This issue was present in the original driver under SPI NOR framework as well.
But only got exposed as driver started handling probe deferral for DMA channel
request and thus uses DMA almost always unlike before.

 drivers/spi/spi-cadence-quadspi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 508b219eabf8..c6795c684b16 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -907,14 +907,16 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	struct dma_async_tx_descriptor *tx;
 	dma_cookie_t cookie;
 	dma_addr_t dma_dst;
+	struct device *ddev;
 
 	if (!cqspi->rx_chan || !virt_addr_valid(buf)) {
 		memcpy_fromio(buf, cqspi->ahb_base + from, len);
 		return 0;
 	}
 
-	dma_dst = dma_map_single(dev, buf, len, DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, dma_dst)) {
+	ddev = cqspi->rx_chan->device->dev;
+	dma_dst = dma_map_single(ddev, buf, len, DMA_FROM_DEVICE);
+	if (dma_mapping_error(ddev, dma_dst)) {
 		dev_err(dev, "dma mapping failed\n");
 		return -ENOMEM;
 	}
@@ -948,7 +950,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 	}
 
 err_unmap:
-	dma_unmap_single(dev, dma_dst, len, DMA_FROM_DEVICE);
+	dma_unmap_single(ddev, dma_dst, len, DMA_FROM_DEVICE);
 
 	return ret;
 }
-- 
2.28.0

