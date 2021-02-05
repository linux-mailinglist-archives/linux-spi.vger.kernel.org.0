Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF3C310A13
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 12:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhBELQK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 06:16:10 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:53234 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232014AbhBELKg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 06:10:36 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115AojUb021324;
        Fri, 5 Feb 2021 12:09:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=wyl8yuJ5frfOCwIh20m4pKBEyn+06N5LlzlyoyqaHZ0=;
 b=k0cS3luNGybNkRAFuiEc3XWINhv+8uQ32It41x0HLBvsLBL/xCVjXTA+ihHTLeW/gV3A
 /Or+1m8k9KDNdAQN7lTP+cRd6O1wz6JDZYdrx3D55Idq79+/ALIGFREkjttOglukWC17
 8cJGFk5GPfp+7GYn6DHmkQKhxfdu4FxKfqzvMQpeutA7gPDqoOlnNZXaPJqF+qgtgPPw
 FfUbtYxQOtPDeZpZT59qmw/gbHsphD3jub75WdOmNvfmhuh4rX4LMgb7YqBLHIDYTcc3
 0oHGRGWR6USocj1aOeVinR81wXRjaiPP5XsqZ3WZK9y/FEPL9AiVqVFYh3Aj3jxSRo8c kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36ey7hfu2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 12:09:45 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 46F56100034;
        Fri,  5 Feb 2021 12:09:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3B4D3229F3C;
        Fri,  5 Feb 2021 12:09:45 +0100 (CET)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb 2021 12:09:45
 +0100
From:   Alain Volmat <alain.volmat@foss.st.com>
To:     <broonie@kernel.org>, <amelie.delaunay@foss.st.com>
CC:     <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <fabrice.gasnier@foss.st.com>,
        <alain.volmat@foss.st.com>
Subject: [PATCH 3/8] spi: stm32h7: ensure message are smaller than max size
Date:   Fri, 5 Feb 2021 12:08:57 +0100
Message-ID: <1612523342-10466-4-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
References: <1612523342-10466-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_06:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Ensure that messages given to transfer_one handler can actually be
handled by it. For that purpose rely on the SPI framework
spi_split_transfers_maxsize function to split messages whenever necessary.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/spi/spi-stm32.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 8c6af3aa0dc3..417a2aa2b98d 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1013,6 +1013,20 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 		!!(spi_dev->mode & SPI_LSB_FIRST),
 		!!(spi_dev->mode & SPI_CS_HIGH));
 
+	/* On STM32H7, messages should not exceed a maximum size setted
+	 * afterward via the set_number_of_data function. In order to
+	 * ensure that, split large messages into several messages
+	 */
+	if (spi->cfg->set_number_of_data) {
+		int ret;
+
+		ret = spi_split_transfers_maxsize(master, msg,
+						  STM32H7_SPI_TSIZE_MAX,
+						  GFP_KERNEL | GFP_DMA);
+		if (ret)
+			return ret;
+	}
+
 	spin_lock_irqsave(&spi->lock, flags);
 
 	/* CPOL, CPHA and LSB FIRST bits have common register */
-- 
2.17.1

