Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E5523C676
	for <lists+linux-spi@lfdr.de>; Wed,  5 Aug 2020 09:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgHEHEo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 5 Aug 2020 03:04:44 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54444 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728337AbgHEHEg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 5 Aug 2020 03:04:36 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07573Ndi002348;
        Wed, 5 Aug 2020 09:04:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=wzaNlmJcYjuEGmXk71gxcc9RooPjAaosEVx5bG46On8=;
 b=V9FM4HLJUpuBD0vM8bjj3TBWFe6juXnJOc7Lj0iNyG/BjLqPkTVWs+nCsBhFfjHRgGI6
 q5XU9Zyq7y/7jQNssLBWc4ESoWHJYnHK/mW1uRaWSPWndC4Vh39ehyW2ETtdJx5aSc9z
 RhJVHGxrPi56DryV2cI+694jUwfKYm7u2kT6qR0ZxGHiDp3kMTlWwUBL6Dv3G13d4DuV
 Xt+gXthpI2unxXlySQlM6vvWoQnom4eFbEWPaWBL7KEJbBb4Oz3n5N3SKVXc3Ek5fC7s
 zjDfiSxAdgyViUXsvEpRy/AmONHQvURmaLZWBrED0MmlZ6qiQAJ9xXYSY+HZCO4I1CHO hw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32n6knf7e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 09:04:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2EA2F100034;
        Wed,  5 Aug 2020 09:04:20 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 21A242A4D8E;
        Wed,  5 Aug 2020 09:04:20 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG3NODE2.st.com (10.75.127.8)
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
Subject: [PATCH 16/18] spi: stm32: always perform registers configuration prior to transfer
Date:   Wed, 5 Aug 2020 09:02:11 +0200
Message-ID: <1596610933-32599-17-git-send-email-alain.volmat@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
References: <1596610933-32599-1-git-send-email-alain.volmat@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG8NODE1.st.com (10.75.127.22) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI registers content may have been lost upon suspend/resume sequence.
So, always compute and apply the necessary configuration in
stm32_spi_transfer_one_setup routine.

Signed-off-by: Alain Volmat <alain.volmat@st.com>
---
 drivers/spi/spi-stm32.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 2665d8d7f318..177f82700de0 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1579,41 +1579,33 @@ static int stm32_spi_transfer_one_setup(struct stm32_spi *spi,
 	unsigned long flags;
 	unsigned int comm_type;
 	int nb_words, ret = 0;
+	int mbr;
 
 	spin_lock_irqsave(&spi->lock, flags);
 
 	spi->cur_xferlen = transfer->len;
 
-	if (spi->cur_bpw != transfer->bits_per_word) {
-		spi->cur_bpw = transfer->bits_per_word;
-		spi->cfg->set_bpw(spi);
-	}
-
-	if (spi->cur_speed != transfer->speed_hz) {
-		int mbr;
-
-		/* Update spi->cur_speed with real clock speed */
-		mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
-					    spi->cfg->baud_rate_div_min,
-					    spi->cfg->baud_rate_div_max);
-		if (mbr < 0) {
-			ret = mbr;
-			goto out;
-		}
+	spi->cur_bpw = transfer->bits_per_word;
+	spi->cfg->set_bpw(spi);
 
-		transfer->speed_hz = spi->cur_speed;
-		stm32_spi_set_mbr(spi, mbr);
+	/* Update spi->cur_speed with real clock speed */
+	mbr = stm32_spi_prepare_mbr(spi, transfer->speed_hz,
+				    spi->cfg->baud_rate_div_min,
+				    spi->cfg->baud_rate_div_max);
+	if (mbr < 0) {
+		ret = mbr;
+		goto out;
 	}
 
-	comm_type = stm32_spi_communication_type(spi_dev, transfer);
-	if (spi->cur_comm != comm_type) {
-		ret = spi->cfg->set_mode(spi, comm_type);
+	transfer->speed_hz = spi->cur_speed;
+	stm32_spi_set_mbr(spi, mbr);
 
-		if (ret < 0)
-			goto out;
+	comm_type = stm32_spi_communication_type(spi_dev, transfer);
+	ret = spi->cfg->set_mode(spi, comm_type);
+	if (ret < 0)
+		goto out;
 
-		spi->cur_comm = comm_type;
-	}
+	spi->cur_comm = comm_type;
 
 	if (spi->cfg->set_data_idleness)
 		spi->cfg->set_data_idleness(spi, transfer->len);
-- 
2.7.4

