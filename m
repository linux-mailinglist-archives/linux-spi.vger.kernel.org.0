Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2478240240
	for <lists+linux-spi@lfdr.de>; Mon, 10 Aug 2020 09:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgHJHNF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 10 Aug 2020 03:13:05 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:11950 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725984AbgHJHNE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 10 Aug 2020 03:13:04 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07A77SK1013394;
        Mon, 10 Aug 2020 09:12:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=cifgomN05QxiscKyTe4tmhqBKFm7XD+dPybDFIfuoiQ=;
 b=u9F/vn/hGG2cT1Ob8Sn9fLzouRKaLMf8hnkALgom47jYsd1I6H043arSPt30Pf2NdaP7
 E0fx+rJCLMJnlNFXxklLvzzEPNxzTrj2ifxwfU7Et06wUZjqeg4k5E0YxbbVZ1IGQNq+
 wfEALTmfYM0X1/oDrIFRyprlHSXrpU64WAZ0kW5Yah49T12VxtzG1Me/jYKxVesbRiVp
 RFP1p4ldBAV15M4ZESFaOcDGVCP56/TGqkhHwk0TXLgJF3QCBwQkXU7wujzRHBanhlsg
 XJuyXbORy0wKzBwn3fO0Yir7UvQLf+LsNg1Ui3o63lumxrYKVhOdU49+Jwb20K2LQyW1 YA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32sm9r6n5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 09:12:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9849A100039;
        Mon, 10 Aug 2020 09:12:51 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 88A312AD9ED;
        Mon, 10 Aug 2020 09:12:51 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Aug 2020 09:12:51
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH v2 3/5] spi: stm32: fix stm32_spi_prepare_mbr in case of odd clk_rate
Date:   Mon, 10 Aug 2020 09:12:36 +0200
Message-ID: <1597043558-29668-4-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597043558-29668-1-git-send-email-alain.volmat@st.com>
References: <1597043558-29668-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_02:2020-08-06,2020-08-10 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

Fix spi->clk_rate when it is odd to the nearest lowest even value because
minimum SPI divider is 2.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
v2: identical to v1

 drivers/spi/spi-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index e5450233f3f8..571dea72bf7e 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -441,7 +441,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 {
 	u32 div, mbrdiv;
 
-	div = DIV_ROUND_UP(spi->clk_rate, speed_hz);
+	/* Ensure spi->clk_rate is even */
+	div = DIV_ROUND_UP(spi->clk_rate & ~0x1, speed_hz);
 
 	/*
 	 * SPI framework set xfer->speed_hz to master->max_speed_hz if
-- 
2.7.4

