Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A5B3A79B8
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 11:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFOJDk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Jun 2021 05:03:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21572 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230490AbhFOJDk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Jun 2021 05:03:40 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15F8wAKp026433;
        Tue, 15 Jun 2021 11:01:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=gRyTEMsNce+t9PzYkspWEzqkwLAdHR7X8GDuQzd9e78=;
 b=ZrdAg3V8aKWvXfBxHpiKTuqqFdUfCBSTW/+ytzv+pRLlOzW6osgRxzGdJEU8EEiD5bUZ
 3+NEfP7eK2q+310FJz3H77hM6RAMXnTel2BlekFDTubE0L8JOZkBUoBRDdTjHRi7Qekd
 WXpm0ZYo5NDqogqBBoyR3l2WGM8uD2HxZjhKwE08TugLXtybD4Fd1RypCEkOEuNZ2B3Q
 YOTzp/WbL6Tp8s/+KBistXOXuBpbwb7ixMGDmlWQOqQSBYY2FVk1Ljciny2TN2eS7Yqm
 /3dGIYLUJTNU6yMbUqWWviQzP8PmYGvGrrdbGTtJvUlO6l99rh6WhdwoEi9OhdeykVxy /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 396rb70djx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Jun 2021 11:01:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C2D3C10002A;
        Tue, 15 Jun 2021 11:01:21 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AE4A221B300;
        Tue, 15 Jun 2021 11:01:21 +0200 (CEST)
Received: from localhost (10.75.127.49) by SFHDAG2NODE3.st.com (10.75.127.6)
 with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Jun 2021 11:01:21
 +0200
From:   <patrice.chotard@foss.st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>,
        <patrice.chotard@foss.st.com>
Subject: [PATCH] spi: stm32-qspi: Remove unused qspi field of struct stm32_qspi_flash
Date:   Tue, 15 Jun 2021 11:01:15 +0200
Message-ID: <20210615090115.30702-1-patrice.chotard@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-15_04:2021-06-14,2021-06-15 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@foss.st.com>

Remove struct stm32_qspi_flash's field qspi which is not used.

Fixes: c530cd1d9d5e ("spi: spi-mem: add stm32 qspi controller")
Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 drivers/spi/spi-stm32-qspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index a3ff0edf3eb7..27f35aa2d746 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -93,7 +93,6 @@
 #define STM32_AUTOSUSPEND_DELAY -1
 
 struct stm32_qspi_flash {
-	struct stm32_qspi *qspi;
 	u32 cs;
 	u32 presc;
 };
@@ -593,7 +592,6 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	presc = DIV_ROUND_UP(qspi->clk_rate, spi->max_speed_hz) - 1;
 
 	flash = &qspi->flash[spi->chip_select];
-	flash->qspi = qspi;
 	flash->cs = spi->chip_select;
 	flash->presc = presc;
 
-- 
2.17.1

