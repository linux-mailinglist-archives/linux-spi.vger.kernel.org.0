Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A554364153
	for <lists+linux-spi@lfdr.de>; Mon, 19 Apr 2021 14:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbhDSMQ3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Apr 2021 08:16:29 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:43412 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239042AbhDSMQ3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 19 Apr 2021 08:16:29 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13JCBRtk028055;
        Mon, 19 Apr 2021 14:15:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=ZS2ZVOREo+uRHNWm9z7V2nITC4fpPcgEhu0hrX/2oic=;
 b=8S1VWDhFh5Z919plLq5uxnScZteSlf6ItEs0++OIeW4Hfed7z8fcJKJwcVIrVZBQZLQM
 YRgRSjV1WyFmfEH7s5PRXqiY1ad1+aUUusJ3gVA/qyaCXLBFgYDZpxNAJ718Hs+umyhs
 VW6zcgbH0lj8goUS8AA/Fmxj2Gj+UKjyq6PHp/aANk/OosXV5fnqrVmlQ0EHbKQIxpT3
 OyXohKiLI6gD5Q77BGGghPNkKxOIiB/Ita+7Fon6sozI8Wp25Vb5KRv6Wt8UVeLGy0oJ
 jI0hxeGBAAkW/8LNeEz7CX+uZOUy6fc4zb8BfMTb4wYpDijJOeg4AuEnwGJfF9xKyYJ7 aA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 380wj63h0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Apr 2021 14:15:45 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 86A6A10002A;
        Mon, 19 Apr 2021 14:15:44 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7CC642139BC;
        Mon, 19 Apr 2021 14:15:44 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 19 Apr 2021 14:15:44
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH 2/3] spi: stm32-qspi: Trigger DMA only if more than 4 bytes to transfer
Date:   Mon, 19 Apr 2021 14:15:40 +0200
Message-ID: <20210419121541.11617-3-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210419121541.11617-1-patrice.chotard@foss.st.com>
References: <20210419121541.11617-1-patrice.chotard@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-19_07:2021-04-16,2021-04-19 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

In order to optimize accesses to spi flashes, trigger a DMA only
if more than 4 bytes has to be transferred.

DMA transfer preparation's cost becomes negligible above 4 bytes to
transfer. Below this threshold, indirect transfer give more throughput.

mtd_speedtest shows that page write throughtput increases :
  - from 779 to 853 KiB/s (~9.5%) with s25fl512s SPI-NOR.
  - from 5283 to 5666 KiB/s (~7.25%) with Micron SPI-NAND.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 2786470a5201..6e74d6bed54c 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -269,8 +269,9 @@ static int stm32_qspi_tx(struct stm32_qspi *qspi, const struct spi_mem_op *op)
 
 	if (qspi->fmode == CCR_FMODE_MM)
 		return stm32_qspi_tx_mm(qspi, op);
-	else if ((op->data.dir == SPI_MEM_DATA_IN && qspi->dma_chrx) ||
-		 (op->data.dir == SPI_MEM_DATA_OUT && qspi->dma_chtx))
+	else if (((op->data.dir == SPI_MEM_DATA_IN && qspi->dma_chrx) ||
+		 (op->data.dir == SPI_MEM_DATA_OUT && qspi->dma_chtx)) &&
+		  op->data.nbytes > 4)
 		if (!stm32_qspi_tx_dma(qspi, op))
 			return 0;
 
-- 
2.17.1

