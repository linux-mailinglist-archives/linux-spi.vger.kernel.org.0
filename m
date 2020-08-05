Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8823C68E
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgHEHFT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:05:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54406 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728328AbgHEHEe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:34 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07573OoU002361;
        Wed, 5 Aug 2020 09:04:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=4O6xDuO64Gg6jGP8uNW6hD+yU28rSUAsUgtFwSr6Vlo=;
 b=xRxAax2hiS5FQkK1SaOFGmlzFUWbvhl0fWuQlB5/kzZP0Wm4BWP/lDDT5A6cK44Tkwsg
 jXt01UY2GVIGGyfSYpHzTzVfko8pHhcQ0ySf37GBK2M3KNGscaHgVacekAbr3vrJH13b
 rx/RX06xZku8q+/YD0HMNhqs4+oPiLZVq928QQLYbP5yRolC6G7ub/gQ5OS3NAteT3SK
 sO29YOfJqMWEnXarADLpEqbfftlR9y4oubAHyDlBEUp3X7iYgk+SazcvqB95zjeK/086
 vwhzFnkJQWaJyedpGai5Qju4XcO31EQyuuIZWg6zl8nQF3ZHKsh/4eMqWHfCqt9Lk1WX Eg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6knf7e5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B796110002A;
        Wed,  5 Aug 2020 09:04:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC9FD2A4D8E;
        Wed,  5 Aug 2020 09:04:19 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:19
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 15/18] spi: stm32: fix stm32_spi_prepare_mbr in case of odd clk_rate
Date:   Wed, 5 Aug 2020 09:02:10 +0200
Message-ID: <1596610933-32599-16-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
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
 drivers/spi/spi-stm32.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 0aec32538093..2665d8d7f318 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -436,7 +436,8 @@ static int stm32_spi_prepare_mbr(struct stm32_spi *spi, u32 speed_hz,
 {
 	u32 div, mbrdiv;
 
-	div = DIV_ROUND_UP(spi->clk_rate, speed_hz);
+	/* Ensure spi->clk_rate is even */
+	div = DIV_ROUND_UP(spi->clk_rate & ~0x1, speed_hz);
 
 	/*
 	 * SPI framework set xfer->speed_hz to master->max_speed_hz if
-- 
2.7.4

