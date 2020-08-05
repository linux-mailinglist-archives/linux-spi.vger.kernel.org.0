Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B60723C6CB
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbgHEHOT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:14:19 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:28436 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725809AbgHEHOT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:14:19 -0400
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 03:14:17 EDT
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07573JwB012777;
        Wed, 5 Aug 2020 09:04:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=jqECQj44WsYLYEzqi6QoOeyI+LAhjmK9fRhP1wA1ILU=;
 b=mkeC+VtORiROhMUOKeGVfpExcYaqMo+6KObfxARlK6zLnEH/F2XyUY5KLi/iVT3DPjL1
 y2nKk80f4L1yeqEaJsb9H7Je7HKN5BsmO8D2/sMJ1WX069vQWoiRjUnttvW4HwR5JR1B
 OfhYLAZv5f9AUTcOmj2QIyoNeElPqEj6m0cU7gQR1CAYzqNDnaKGHqBXDHxW6yiAysSu
 3JndZlylCmuJxXrlGFWv6UTRfjhNK9NCa0mth2PWFby6tNcwYbthY9Ah/NQVWNq+UrhG
 9+3CtxH2AogLMZkQ3DisM8rdGxsy5CyVdf7RHQko1E8ieEM617UBTxIRBIl2w7AexTwB Pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6theqj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 91046100038;
        Wed,  5 Aug 2020 09:04:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 85ACF2A4D8E;
        Wed,  5 Aug 2020 09:04:20 +0200 (CEST)
Received: from localhost (10.75.127.51) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:20
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 17/18] spi: stm32: properly handle 0 byte transfer
Date:   Wed, 5 Aug 2020 09:02:12 +0200
Message-ID: <1596610933-32599-18-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 0 byte transfer request, return straight from the
xfer function after finalizing the transfer.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 177f82700de0..b909afd9e99b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1658,6 +1658,12 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	unsigned long timeout;
 	int ret;
 
+	/* Don't do anything on 0 bytes transfers */
+	if (transfer->len == 0) {
+		spi->xfer_status = 0;
+		goto finalize;
+	}
+
 	spi->tx_buf = transfer->tx_buf;
 	spi->rx_buf = transfer->rx_buf;
 	spi->tx_len = spi->tx_buf ? transfer->len : 0;
@@ -1702,6 +1708,7 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 
 	spi->cfg->disable(spi);
 
+finalize:
 	spi_finalize_current_transfer(master);
 
 	return spi->xfer_status;
-- 
2.7.4

