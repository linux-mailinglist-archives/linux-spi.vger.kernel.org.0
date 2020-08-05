Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7E423C693
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHEHFm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:05:42 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:6266 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728137AbgHEHEb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:31 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07572Sl6030166;
        Wed, 5 Aug 2020 09:04:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=Z+Hwk1wFql5BmY3WxoJe/xt45cRduaVoj1mAtgDiK3s=;
 b=x0mfk/fNNqS4WH3ze9ZdPiUGiOs2S0YSHxcklsUNk0FBTNAcQwtN2oi0lZlJNA+H35mR
 Vb27Xdg0jWV/wflfpQl6/5MTyFgwC0hr2nK2sz0nq9blp+Wc+vElFXc35Vkx1L0OCngj
 NIVcUtRbEmwJ6ZpiueWXrKNeH+n7fBnonWRYaWL9DcBgxUbeCInMPdWOw600+jRN93GE
 knIY7rqQ04ztuHPfwhoqYgoqjnqr098nCcc26U/C7TIxyJH+4TVujvhkSKg0eyqRY79e
 FmxImipedc9T5Ayrd9Jw9FrvvMns51Am8WIYlZqaxMWYI9U/KmXNH5v05sjGloiwALi4 Zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6hyq7tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5CC9110002A;
        Wed,  5 Aug 2020 09:04:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5134F2A4D8E;
        Wed,  5 Aug 2020 09:04:17 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:16
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 09/18] spi: stm32h7: fix race condition at end of transfer
Date:   Wed, 5 Aug 2020 09:02:04 +0200
Message-ID: <1596610933-32599-10-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
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
index 6731e3ff0e50..a931c821c280 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -954,8 +954,8 @@ static irqreturn_t stm32h7_spi_irq_thread(int irq, void *dev_id)
 	spin_unlock_irqrestore(&spi->lock, flags);
 
 	if (end) {
-		spi_finalize_current_transfer(master);
 		stm32h7_spi_disable(spi);
+		spi_finalize_current_transfer(master);
 	}
 
 	return IRQ_HANDLED;
-- 
2.7.4

