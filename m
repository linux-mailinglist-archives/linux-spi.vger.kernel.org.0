Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC33110BA
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 20:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbhBERZV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 12:25:21 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:29894 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233726AbhBERS3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 12:18:29 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115Iq5xm022849;
        Fri, 5 Feb 2021 19:59:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=l4mRyO192tK5wz+06edKoCMrS6nJXWsrYPSp+UIM/7o=;
 b=SJONXusMQrcm2wJ82A7R37W/7X0DALzp1OtE/td8hd6dem3Qcdr+3tOneyhcFcnZLNWv
 +Gl520HIX14HrOiKfa+881UGMEqKtl4DawkWXItJnnkjrMFcUJHdBmeaQtdfmXidTF4R
 S/lt04Q7NngEaCdgYOE/Idl4IxfseZV1Zq4HrpBJmrst2ZH++dzzj99qUspYWthNcxe9
 rJwbhS66AHWNYiZ8KbvGODXA/HXQzWg4zSDxwj7Je5z56yFneqcAlA1BQrtgZwaDwfSF
 Ad8IKpNCC3TyDuI7XQDjbr8/bzk2be5oq0/bXdY6wB29YuPffwFMOQyTZwYIq7qAwGx7 uQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0fsgjqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 19:59:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 557E0100038;
        Fri,  5 Feb 2021 19:59:47 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4B8582C38D3;
        Fri,  5 Feb 2021 19:59:47 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 19:59:47
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH v2 5/8] spi: stm32: driver uses reset controller only at init
Date:   Fri, 5 Feb 2021 19:59:29 +0100
Message-ID: <1612551572-495-6-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
References: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
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
v2: reordered within the serie

 drivers/spi/spi-stm32.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8e4db219b95d..561234829110 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -263,7 +263,6 @@ struct stm32_spi_cfg {
  * @base: virtual memory area
  * @clk: hw kernel clock feeding the SPI clock generator
  * @clk_rate: rate of the hw kernel clock feeding the SPI clock generator
- * @rst: SPI controller reset line
  * @lock: prevent I/O concurrent access
  * @irq: SPI controller interrupt line
  * @fifo_size: size of the embedded fifo in bytes
@@ -289,7 +288,6 @@ struct stm32_spi {
 	void __iomem *base;
 	struct clk *clk;
 	u32 clk_rate;
-	struct reset_control *rst;
 	spinlock_t lock; /* prevent I/O concurrent access */
 	int irq;
 	unsigned int fifo_size;
@@ -1811,6 +1809,7 @@ static int stm32_spi_probe(struct platform_device *pdev)
 	struct spi_master *master;
 	struct stm32_spi *spi;
 	struct resource *res;
+	struct reset_control *rst;
 	int ret;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct stm32_spi));
@@ -1872,11 +1871,11 @@ static int stm32_spi_probe(struct platform_device *pdev)
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

