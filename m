Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AE93B7F4A
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 10:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhF3IuP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 04:50:15 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1065 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233291AbhF3IuP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Jun 2021 04:50:15 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15U8kf05002319;
        Wed, 30 Jun 2021 10:47:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=Y4PDfWZjZODcknd7gp70dQITFPNG5A5d3KYq5Q5TMTc=;
 b=H4HqWj+B1YFfjb9d88sNn+djfutZZuewjnQkQ97jsvNFUp8HaMM+gPdHuhkdHgjN0XNa
 tBe+0OLXgz21VjVhjZG+j6vcaUNcZlNqxo5zv50USxUjzvDgwVZ5LtXA6hh8D33HaMge
 ldgPH2xBE5KggS9TLqzlL295cAeKEpazuNWGRywssHGGmbQhcgeSArkbRXnYSptGl+aV
 am1VZBqmTVUWKhH1CY5oU/9vRstMD1S7lCr+HGOPfxR0vI2ndTeZhERLM9ucIny92cEg
 otSnv7qBLZMe5Ru8ntMns3LEAK7eNehFADRFhNe/pGv1LyNWk7r/2yKLL7fVHrgPDJH0 lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 39ghqhu60y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 10:47:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 49C7910002A;
        Wed, 30 Jun 2021 10:47:35 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3CF1521BF5F;
        Wed, 30 Jun 2021 10:47:35 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 30 Jun 2021 10:47:34
 +0200
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 3/6] Revert "spi: stm32: properly handle 0 byte transfer"
Date:   Wed, 30 Jun 2021 10:45:20 +0200
Message-ID: <1625042723-661-4-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
References: <1625042723-661-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_02:2021-06-29,2021-06-30 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This reverts commit 2269f5a8b1a7b38651d62676b98182828f29d11a.
0 byte transfer handling is now done within the core in code added
by commit b306320322c9 ("spi: Skip zero-length transfers in spi_transfer_one_message()")

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4dbd5cbe0c11..d37bfead4d8c 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1647,10 +1647,6 @@ static int stm32_spi_transfer_one(struct spi_master *master,
 	struct stm32_spi *spi = spi_master_get_devdata(master);
 	int ret;
 
-	/* Don't do anything on 0 bytes transfers */
-	if (transfer->len == 0)
-		return 0;
-
 	spi->tx_buf = transfer->tx_buf;
 	spi->rx_buf = transfer->rx_buf;
 	spi->tx_len = spi->tx_buf ? transfer->len : 0;
-- 
2.25.1

