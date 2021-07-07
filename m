Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8768D3BE464
	for <lists+linux-spi@lfdr.de>; Wed,  7 Jul 2021 10:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhGGIai (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 7 Jul 2021 04:30:38 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:29816 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230481AbhGGIaf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 7 Jul 2021 04:30:35 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1678Mgtt003106;
        Wed, 7 Jul 2021 10:27:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=wvHutvszO60NpsmtRJ9LbKZBrctdcsmxFVI5e4fzTWs=;
 b=siKblJSe/iF+FDi/TZlzIh8t1bTeU+iK/MyG6kQjC1LslhyBd1Eoe8WTVn7UtbDW8onl
 rLdcXeFOlv8wbyuPCzm9RO92wnsJM41Yz4KjxiYW+gTYC4Bu475ggKnXjfcZrsBMWokJ
 lmeOdzIs7cYuJF0bSAnxIa8EmLnwOr0LPoSy31Ry2g0TUPH7sA4GnhnIcymnjQuGHTlN
 K0K647sJgPTVMNeLISXIDkMK9ghwrCMbOOT2U5lKo1d1O1JDAlrtP+4Sii9C51Xqld0Y
 2BrBu8NgLay4X7piQd6eN3/CnXuWEUNZx0VzSIyGB0RexyVMqM6xWIpQo3DkiO0hN1jz OA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39mxgxjrb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jul 2021 10:27:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0140A10002A;
        Wed,  7 Jul 2021 10:27:42 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E98E0215125;
        Wed,  7 Jul 2021 10:27:41 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Jul 2021 10:27:41
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH v2 3/7] spi: stm32h7: fix full duplex irq handler handling
Date:   Wed, 7 Jul 2021 10:27:02 +0200
Message-ID: <1625646426-5826-4-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
References: <1625646426-5826-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-07_05:2021-07-06,2021-07-07 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

In case of Full-Duplex mode, DXP flag is set when RXP and TXP flags are
set. But to avoid 2 different handlings, just add TXP and RXP flag in
the mask instead of DXP, and then keep the initial handling of TXP and
RXP events.
Also rephrase comment about EOTIE which is one of the interrupt enable
bits. It is not triggered by any event.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index fe35c5cfb820..4dbd5cbe0c11 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -886,15 +886,18 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	ier = readl_relaxed(spi->base + STM32H7_SPI_IER);
 
 	mask = ier;
-	/* EOTIE is triggered on EOT, SUSP and TXC events. */
+	/*
+	 * EOTIE enables irq from EOT, SUSP and TXC events. We need to set
+	 * SUSP to acknowledge it later. TXC is automatically cleared
+	 */
+
 	mask |= STM32H7_SPI_SR_SUSP;
 	/*
-	 * When TXTF is set, DXPIE and TXPIE are cleared. So in case of
-	 * Full-Duplex, need to poll RXP event to know if there are remaining
-	 * data, before disabling SPI.
+	 * DXPIE is set in Full-Duplex, one IT will be raised if TXP and RXP
+	 * are set. So in case of Full-Duplex, need to poll TXP and RXP event.
 	 */
-	if (spi->rx_buf && !spi->cur_usedma)
-		mask |= STM32H7_SPI_SR_RXP;
+	if ((spi->cur_comm == SPI_FULL_DUPLEX) && !spi->cur_usedma)
+		mask |= STM32H7_SPI_SR_TXP | STM32H7_SPI_SR_RXP;
 
 	if (!(sr & mask)) {
 		dev_warn(spi->dev, "spurious IT (sr=0x%08x, ier=0x%08x)\n",
-- 
2.25.1

