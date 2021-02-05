Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560483110A5
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 20:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhBERUZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 12:20:25 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36876 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233725AbhBERS3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 12:18:29 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115Ior36012827;
        Fri, 5 Feb 2021 19:59:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=LjFrx5maoRvFpfTyBMerZ3asifVa9A9Yul9IroNU2aQ=;
 b=HJs9LqBdv9dd3pTqKh6Vmp/F+GKuIPKWR1CXU2NmDEFqMnWU72GEbtSv2CJk2j/b+1Wv
 SHRUUO+bF/9TkyEmrqCGFm2QNkn0KvCnkjs6LjqlaLiYQj6pgJTCu6EJ0ToUjd9orAkS
 CQPxbPjBY+GDJ76NA3L/ommC27aU4odGz9SBiA3ZTK1J8ZhSy1ELD7nTnN0OUmEQlXMb
 feu0JFrzexrZEdNkRbDGSM0zrKuNE3S459n1fXafVahEs6chCiXDYUB60WLjlMxLwqcM
 iE/oILeTXfNo1HxMUAgrNzrk17mxyjpHaMPenpU8VYP+zf+Pcz0QTonsBd8E7eRKPrwb AQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36ey7hj46s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 19:59:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B54B6100034;
        Fri,  5 Feb 2021 19:59:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A88612C38D3;
        Fri,  5 Feb 2021 19:59:45 +0100 (CET)
Received: from localhost (10.75.127.46) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 19:59:45
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH v2 1/8] spi: stm32: properly handle 0 byte transfer
Date:   Fri, 5 Feb 2021 19:59:25 +0100
Message-ID: <1612551572-495-2-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
References: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 0 byte transfer request, return straight from the
xfer function after finalizing the transfer.

Fixes: dcbe0d84dfa5 ("spi: add driver for STM32 SPI controller")
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
v2: remove useless spi_finalize_current_transfer

 drivers/spi/spi-stm32.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index db3e305d9ec4..6cdecd1c5ec7 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1657,6 +1657,10 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 	int ret;
 
+	/* Don't do anything on 0 bytes transfers */
+	if (transfer->len == 0)
+		return 0;
+
 	spi->tx_buf = transfer->tx_buf;
 	spi->rx_buf = transfer->rx_buf;
 	spi->tx_len = spi->tx_buf ? transfer->len : 0;
-- 
2.17.1

