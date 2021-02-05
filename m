Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6F3110AE
	for <lists+linux-spi@lfdr.de>; Fri,  5 Feb 2021 20:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbhBERXP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 5 Feb 2021 12:23:15 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36870 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233430AbhBERSa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 5 Feb 2021 12:18:30 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 115IpTLq012965;
        Fri, 5 Feb 2021 19:59:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=fPn/4HATX6I2/ykXLk2PgRP2y/FYCsUgvSN0VvyUHp8=;
 b=Mj0PqsPu910WyVcSMeO0ejBccWROxlhFy7VzzGk1tp8OHH7piXeg1TUF9rWhuTcvIFoq
 Aiz/3q1yoHbb6XQ8Ihqu942j5yEiZqUojLni+odmI/bZPE+4N5YuHCcqFU9xEsjt3psv
 /exfIaUTpuj41Dk6iY0Ev4j9s8QM3A1lDwyj8yxv1NQ7q559Ir3vWTdAEI7O/6FIKiSY
 om5MLrg5a6WEjE6VDZ2TS/+RSHovdv9QX6sZ1GCN306Mucn1vGt/iDLbDJDGFqp8kSI+
 uOWGvkjL5VT0oxxJAn0bMrmG/ZLnJUdI0shmOuy2O15BfQ11m1yJRg7JGhTo6y3mCmZm BA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36ey7hj46t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Feb 2021 19:59:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 21D8310002A;
        Fri,  5 Feb 2021 19:59:46 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 185822C38D3;
        Fri,  5 Feb 2021 19:59:46 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE3.st.com (10.75.127.6)
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
Subject: [PATCH v2 2/8] spi: stm32: do not mandate cs_gpio
Date:   Fri, 5 Feb 2021 19:59:26 +0100
Message-ID: <1612551572-495-3-git-send-email-alain.volmat@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
References: <1612551572-495-1-git-send-email-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-05_10:2021-02-05,2021-02-05 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

CS gpios is not mandatory, the driver should allow working
even when CS are not given.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
v2: identical to v1

 drivers/spi/spi-stm32.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6cdecd1c5ec7..2b4ea4cba00b 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1944,12 +1944,6 @@ static int stm32_spi_probe(struct platform_device *pdev)
 		goto err_pm_disable;
 	}
 
-	if (!master->cs_gpiods) {
-		dev_err(&pdev->dev, "no CS gpios available\n");
-		ret = -EINVAL;
-		goto err_pm_disable;
-	}
-
 	dev_info(&pdev->dev, "driver initialized\n");
 
 	return 0;
-- 
2.17.1

