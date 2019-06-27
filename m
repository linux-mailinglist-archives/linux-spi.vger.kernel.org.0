Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9657D61
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2019 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfF0HoV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jun 2019 03:44:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13206 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726408AbfF0HoV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jun 2019 03:44:21 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5R7gN3E025943;
        Thu, 27 Jun 2019 09:44:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=GHcv4g6tr7JE6E7+aaabKzOIotaPQfNSAvXVtLgorgc=;
 b=WeLP0sfOhW5LidRnIOOUbwYUkRRVFFtqf7wvD0l13yXu7zKPLROx+PfklvQJksHQGRbB
 uUBAFNk6FjWRdovwpEkZSs19tmDBnSjTzooLXZ8FwITj6XUzzBAL6dmeP3WkLH9zBcvj
 A7HJAsA8pC3QL9ZV/kzlepGrV/Vd6ypMLwEbmRHHF59A3a0RqeV13h1xnFFKlJ2ABdcD
 TjAE1c5J88+KN/XvwUx3zJf/iY3BHpA3gSKSc7FSCfRPP9UBiXFu76C7q1q6PMVHytWf
 ul4ZNUojW7kDQJnhquxqjv4rvTLDfzTYZhhERa4ROz0wCkiy6tcWChWS7CtmKSFhsFaL VQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2t9d2gn3nf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 27 Jun 2019 09:44:09 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7D2B83F;
        Thu, 27 Jun 2019 07:44:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas23.st.com [10.75.90.46])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 47D1D157C;
        Thu, 27 Jun 2019 07:44:07 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS23.st.com
 (10.75.90.46) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Jun
 2019 09:44:07 +0200
Received: from lmecxl0923.lme.st.com (10.48.0.237) by Webmail-ga.st.com
 (10.75.90.48) with Microsoft SMTP Server (TLS) id 14.3.439.0; Thu, 27 Jun
 2019 09:44:06 +0200
From:   Ludovic Barre <ludovic.Barre@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, Ludovic Barre <ludovic.barre@st.com>
Subject: [PATCH] spi: stm32-qspi: remove signal sensitive on completion
Date:   Thu, 27 Jun 2019 09:43:59 +0200
Message-ID: <1561621439-7305-2-git-send-email-ludovic.Barre@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561621439-7305-1-git-send-email-ludovic.Barre@st.com>
References: <1561621439-7305-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.48.0.237]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-27_03:,,
 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

On umount step a sigkill signal is set (without user specific
action), due to sigkill signal the completion will be interrupted and
the data transfer can't be finished if a sync is needed.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 5dbb6a8..655e4af 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -245,12 +245,8 @@ static int stm32_qspi_tx_dma(struct stm32_qspi *qspi,
 	writel_relaxed(cr | CR_DMAEN, qspi->io_base + QSPI_CR);
 
 	t_out = sgt.nents * STM32_COMP_TIMEOUT_MS;
-	if (!wait_for_completion_interruptible_timeout(&qspi->dma_completion,
-						       msecs_to_jiffies(t_out)))
-		err = -ETIMEDOUT;
-
-	if (dma_async_is_tx_complete(dma_ch, cookie,
-				     NULL, NULL) != DMA_COMPLETE)
+	if (!wait_for_completion_timeout(&qspi->dma_completion,
+					 msecs_to_jiffies(t_out)))
 		err = -ETIMEDOUT;
 
 	if (err)
@@ -304,7 +300,7 @@ static int stm32_qspi_wait_cmd(struct stm32_qspi *qspi,
 	cr = readl_relaxed(qspi->io_base + QSPI_CR);
 	writel_relaxed(cr | CR_TCIE | CR_TEIE, qspi->io_base + QSPI_CR);
 
-	if (!wait_for_completion_interruptible_timeout(&qspi->data_completion,
+	if (!wait_for_completion_timeout(&qspi->data_completion,
 				msecs_to_jiffies(STM32_COMP_TIMEOUT_MS))) {
 		err = -ETIMEDOUT;
 	} else {
-- 
2.7.4

