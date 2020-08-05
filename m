Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B2F23C687
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgHEHFS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:05:18 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54386 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728326AbgHEHEe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:34 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07573Ndg002348;
        Wed, 5 Aug 2020 09:04:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=SCbshi6mJuF+jmV4aUOh6PyOzzqyG+zjp3NYEx3TIqM=;
 b=XxSWiVsyiCI2LuJDIsGGiR3rKeMuzPg+UgK3SMlQGnTJ2yy00ucP9hLgGqxzMO1NJSDR
 FtyKL/tBJvHSi/js2AYCojJyLO9p3Pr6t+xfXxWsCBL5IX8bMlNbl9Nbz0bA3VzMPNAM
 2Y/8r9QuZB8e34Vnz1g+Mzvcg35M3DaTZ6LZfWcf8r/kV0xgHFU4h4CFNshNle1iD/wT
 YOEc21m1uVbcy8es5wQcc/WXmE3vjhy6y5Jw9t3zgef5KESic8W080cW9ZDgEU87aRNx
 XfcXXHKNyKdXnENx+ZqsxueksYCUgZtJOObam0ramdt5kyGpYEoR3CAllia+EiuVqbTN eA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6knf7ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B523F10002A;
        Wed,  5 Aug 2020 09:04:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A815E2A4D8E;
        Wed,  5 Aug 2020 09:04:15 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug 2020 09:04:15
 +0200
From:   Alain Volmat <alain.volmat@st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@st.com>,
        <alain.volmat@st.com>
Subject: [PATCH 05/18] spi: stm32h7: replace private SPI_1HZ_NS with NSEC_PER_SEC
Date:   Wed, 5 Aug 2020 09:02:00 +0200
Message-ID: <1596610933-32599-6-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@st.com>

Replace SPI_1HZ_NS private constant with NSEC_PER_SEC, which is easier
to read and understand.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index a5b926a5c4d9..b90367d522f2 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -159,8 +159,6 @@
 #define SPI_3WIRE_TX		3
 #define SPI_3WIRE_RX		4
 
-#define SPI_1HZ_NS		1000000000
-
 /*
  * use PIO for small transfers, avoiding DMA setup/teardown overhead for drivers
  * without fifo buffers.
@@ -1508,7 +1506,7 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
 
 	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
 	if ((len > 1) && (spi->cur_midi > 0)) {
-		u32 sck_period_ns = DIV_ROUND_UP(SPI_1HZ_NS, spi->cur_speed);
+		u32 sck_period_ns = DIV_ROUND_UP(NSEC_PER_SEC, spi->cur_speed);
 		u32 midi = min_t(u32,
 				 DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
 				 FIELD_GET(STM32H7_SPI_CFG2_MIDI,
-- 
2.7.4

