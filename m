Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73236310A07
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 12:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBELPX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 06:15:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21952 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232026AbhBELKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 06:10:39 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115Aqww7005647;
        Fri, 5 Feb 2021 12:09:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=lkJDCK2MB6BfDScY6U1w+Iebo1u6bpKFHNnvVxWVTrM=;
 b=xccPQqz7N753MHZx8bp6IUhqZ1QzNXR/3pYjUTWp1nDATpNSHQgXlvBBG5UTt8Q/EvTS
 /j9MmtmjGDfETXQS8IAICKezHmcEBIMnVYlYCvVCrEQ/5dpkNeSFesDe8EV7np6VuDfr
 tefaIVuvIEvUk2J+nVM/LscRGgxXMYaWf7fVMHQyWPO0zXXh8oLoUKtNIrSgNlVeySQF
 0EBno0uFILy/t7KQnae1ZTtnBOvK6RIgIrhdc/Ydx7VMWdYevw6VP0lbZd9kOn/WdqFT
 A7DvSuik8+dbQt5qNxvtJn4geKObQHZK8Cp410DKiP9voOnUjuj3d2kj9XbBkq6jqmB5 5w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0nsf3af-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 12:09:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ADDDD10002A;
        Fri,  5 Feb 2021 12:09:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9E251229F3C;
        Fri,  5 Feb 2021 12:09:45 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 12:09:45
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 4/8] spi: stm32: driver uses reset controller only at init
Date:   Fri, 5 Feb 2021 12:08:58 +0100
Message-ID: <1612523342-10466-5-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
References: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_06:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Etienne Carriere <etienne.carriere@st.com>

Remove reset controller device reference from the device private
structure since it is used only at probe time and can be discarded
once used to reset the SPI device.

Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 417a2aa2b98d..22bd3d1c8d69 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -268,7 +268,6 @@ struct stm32_spi_cfg {
  * @base: virtual memory area
  * @clk: hw kernel clock feeding the SPI clock generator
  * @clk_rate: rate of the hw kernel clock feeding the SPI clock generator
- * @rst: SPI controller reset line
  * @lock: prevent I/O concurrent access
  * @irq: SPI controller interrupt line
  * @fifo_size: size of the embedded fifo in bytes
@@ -294,7 +293,6 @@ struct stm32_spi {
 	void __iomem *base;
 	struct clk *clk;
 	u32 clk_rate;
-	struct reset_control *rst;
 	spinlock_t lock; /* prevent I/O concurrent access */
 	int irq;
 	unsigned int fifo_size;
@@ -1831,6 +1829,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct stm32_spi *spi;
 	struct resource *res;
+	struct reset_control *rst;
 	int ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
@@ -1892,11 +1891,11 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	spi->rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (!IS_ERR(spi->rst)) {
-		reset_control_assert(spi->rst);
+	rst = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (!IS_ERR(rst)) {
+		reset_control_assert(rst);
 		udelay(2);
-		reset_control_deassert(spi->rst);
+		reset_control_deassert(rst);
 	}
 
 	if (spi->cfg->has_fifo)
-- 
2.17.1

