Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0546C257A0C
	for <lists+linux-spi@lfdr.de>; Mon, 31 Aug 2020 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgHaNIB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 31 Aug 2020 09:08:01 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:41322 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgHaNH5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 31 Aug 2020 09:07:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07VD7kAQ093615;
        Mon, 31 Aug 2020 08:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598879266;
        bh=nPXWbXB5ptLwVXCnfHta8Iu5YbXqThKPhXxvtW0ph6A=;
        h=From:To:CC:Subject:Date;
        b=oyEI9xOXJwdLyT8H8XKhcBK6ppOcXoLwJFWsN1VHdXS0eCB+kZYiLMrWKj4cXjSsp
         V30+TUvA5ejeys34gKHNVrLP7eMp5p3fFRLnC99bUGcMJfTzWPcXr/ogRBdW+TBIZm
         UlLDApj27ilR+zZv0jKovD9n2dtSg87CTky9608U=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07VD7kp0054215
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 08:07:46 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 31
 Aug 2020 08:07:46 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 31 Aug 2020 08:07:46 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07VD7hcG094698;
        Mon, 31 Aug 2020 08:07:43 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] spi: spi-cadence-quadspi: Fix mapping of buffers for DMA reads
Date:   Mon, 31 Aug 2020 18:37:20 +0530
Message-ID: <20200831130720.4524-1-vigneshr@ti.com>
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

Fixes: ffa639e069fb ("mtd: spi-nor: cadence-quadspi: Add DMA support for direct mode reads")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>
---

v2:
Update the Fixes tag and add collect tested-by

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

