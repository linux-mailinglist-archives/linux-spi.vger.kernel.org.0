Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7223F310A0A
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBELPy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 06:15:54 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21956 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231837AbhBELKj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 06:10:39 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115Ar06U005693;
        Fri, 5 Feb 2021 12:09:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=oy9tt9LOcC+4G85rs/T6QnLkLfJnzRu6mgOs3GhCeH8=;
 b=ByObkEBSmzwXf1AxlrVGNCue6ILIC3/MKoMCwmHSB+17u6dDlgw8Lykc8d9Bq2ia0lvq
 RHYnxCvdkVtWw5UNrsitY6Sz4y/jRpwtcUqhye8rdXbMeHvYAnA8TdM6L/f8/542ZJKz
 PnJHTdodBMQESCUanBobiot7Z5r+dOSeVn5GeOR1CSx7C5m2bVcxVR31nduBnAD3lmFb
 2b8daPSwhKi0FDIlL6XannKLmN9hOq+bT1zmcXNI8SimIkeBCGrZB7fg3O2KbLioXLHh
 BZKlue1mX7oOZJpIVo5BWYE0M7FGrOKTRbpcxQMh6WzmDJdWjfwnUFvdllO5vtffb974 qQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36d0nsf3am-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 12:09:47 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E0556100034;
        Fri,  5 Feb 2021 12:09:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D3EAB229F3C;
        Fri,  5 Feb 2021 12:09:46 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 12:09:46
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 7/8] spi: stm32h7: replace private SPI_1HZ_NS with NSEC_PER_SEC
Date:   Fri, 5 Feb 2021 12:09:01 +0100
Message-ID: <1612523342-10466-8-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
References: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_06:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Amelie Delaunay <amelie.delaunay@foss.st.com>

Replace SPI_1HZ_NS private constant with NSEC_PER_SEC, which is easier
to read and understand.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index cacd5b4b6823..7692e2778df5 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -162,8 +162,6 @@
 #define SPI_3WIRE_TX		3
 #define SPI_3WIRE_RX		4
 
-#define SPI_1HZ_NS		1000000000
-
 /*
  * use PIO for small transfers, avoiding DMA setup/teardown overhead for drivers
  * without fifo buffers.
@@ -1525,7 +1523,7 @@ static void stm32h7_spi_data_idleness(struct stm32_spi *spi, u32 len)
 
 	cfg2_clrb |= STM32H7_SPI_CFG2_MIDI;
 	if ((len > 1) && (spi->cur_midi > 0)) {
-		u32 sck_period_ns = DIV_ROUND_UP(SPI_1HZ_NS, spi->cur_speed);
+		u32 sck_period_ns = DIV_ROUND_UP(NSEC_PER_SEC, spi->cur_speed);
 		u32 midi = min_t(u32,
 				 DIV_ROUND_UP(spi->cur_midi, sck_period_ns),
 				 FIELD_GET(STM32H7_SPI_CFG2_MIDI,
-- 
2.17.1

