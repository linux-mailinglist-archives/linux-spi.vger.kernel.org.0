Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5723EE17
	for <lists+linux-spi@lfdr.de>; Fri,  7 Aug 2020 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHGNXy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Aug 2020 09:23:54 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:1948 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726030AbgHGNXq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Aug 2020 09:23:46 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077DNYS6017470;
        Fri, 7 Aug 2020 15:23:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=NonnIc54xDpZGLpaLwm33yot64+Hhf3leoq0DVIpPl8=;
 b=rbSx3MU2+i6dLMYuqT9jNwavR3Rpr0eq/DflWtvG/BokTfAp7fuVEOnPojzFzYuJkhQe
 d3y3HWg/V2M5PFx0d+6tXG9G+ZqaU+yBKAfsNcKejUuOwloFqBOALHFwFxYw6m21pC7j
 oHZ3yiqEHQs+G4u2Qf5PfZx441okcUc4XGV5fiWMTNmIR5htYUm5gNoADq+7iJVP3nH7
 QJPh4cZBXairA8YnRpANz5LrZ0DO7QXZZkxC2SWTRukoIjncazQ8QZE6ICX3Mtk20xLE
 w2zLcY18IPxnHc3MXEjPxskray1OofKdITWNiEf6qqiiLRPPuHleFF2nzuuw2oYt+LNa yQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6thsxsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 15:23:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 14E18100034;
        Fri,  7 Aug 2020 15:23:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 06B7B2B8A02;
        Fri,  7 Aug 2020 15:23:30 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug 2020 15:23:29
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 1/5] spi: stm32h7: fix race condition at end of transfer
Date:   Fri, 7 Aug 2020 15:21:21 +0200
Message-ID: <1596806485-3810-2-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596806485-3810-1-git-send-email-alain.volmat@st.com>
References: <1596806485-3810-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_09:2020-08-06,2020-08-07 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Antonio Borneo <antonio.borneo@st.com>

The caller of stm32_spi_transfer_one(), spi_transfer_one_message(),
is waiting for us to call spi_finalize_current_transfer() and will
eventually schedule a new transfer, if available.
We should guarantee that the spi controller is really available
before calling spi_finalize_current_transfer().

Move the call to spi_finalize_current_transfer() _after_ the call
to stm32_spi_disable().

Signed-off-by: Antonio Borneo <antonio.borneo@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4a21feae0103..814a3ec3b8ad 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -971,8 +971,8 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	if (end) {
-		spi_finalize_current_transfer(master);
 		stm32h7_spi_disable(spi);
+		spi_finalize_current_transfer(master);
 	}
 
 	return IRQ_HANDLED;
-- 
2.7.4

