Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C872E0E5F
	for <lists+linux-spi@lfdr.de>; Tue, 22 Dec 2020 19:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgLVSqR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Dec 2020 13:46:17 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59260 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgLVSqR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Dec 2020 13:46:17 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIie8V115152;
        Tue, 22 Dec 2020 12:44:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608662680;
        bh=4+hNG0HZ3CKHOOg7bbnIvHC3AH4Hy4lXYfvtHYthEak=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IbH8vb51Wr5IMLW9wAWeXp4Wb8Qhk2fCPF/L0Cshixa1ulFzJ2z0Mj0MFSOe64yKC
         79qNnOxW+Fc25le717MAA9lmv7g+f74g8BOR/wLQdkCHww9XpTA5k7vovZy9yHYD0h
         87E+u8bHAYgd2/XzR7IhmDQqH8qp9PYxj5RXvclk=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BMIieDQ017222
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Dec 2020 12:44:40 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Dec 2020 12:44:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Dec 2020 12:44:40 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BMIiQbe003761;
        Tue, 22 Dec 2020 12:44:38 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/7] spi: cadence-quadspi: Wait at least 500 ms for direct reads
Date:   Wed, 23 Dec 2020 00:14:24 +0530
Message-ID: <20201222184425.7028-7-p.yadav@ti.com>
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

When performing a direct read via DMA the timeout for completion is set
equal to the read length. This is fine for larger reads. For a small
read like the Read Status Register command, the timeout would be 1 or 2
milliseconds. This is not enough to cover the overhead needed in setting
up DMA.

Make sure the timeout is at least 500 ms to allow DMA ample time to
finish. For reads larger than 500 bytes, the timeout will continue to be
equal to the read length.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 1781d4e94ebd..90040664e1b9 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -963,7 +963,7 @@ static int cqspi_direct_read_execute(struct cqspi_flash_pdata *f_pdata,
 
 	dma_async_issue_pending(cqspi->rx_chan);
 	if (!wait_for_completion_timeout(&cqspi->rx_dma_complete,
-					 msecs_to_jiffies(len))) {
+					 msecs_to_jiffies(max(len, 500UL)))) {
 		dmaengine_terminate_sync(cqspi->rx_chan);
 		dev_err(dev, "DMA wait_for_completion_timeout\n");
 		ret = -ETIMEDOUT;
-- 
2.28.0

