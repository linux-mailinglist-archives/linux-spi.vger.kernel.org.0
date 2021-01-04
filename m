Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E0C2E9235
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbhADI4m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 03:56:42 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:25064 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbhADI4m (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 03:56:42 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1048ocXM030920;
        Mon, 4 Jan 2021 03:55:45 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35tkj9u552-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jan 2021 03:55:45 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 1048thrJ004178
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 4 Jan 2021 03:55:44 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 4 Jan 2021 00:55:42 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.721.2;
 Mon, 4 Jan 2021 00:55:42 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 4 Jan 2021 00:55:42 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1048tdZL013983;
        Mon, 4 Jan 2021 03:55:39 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <andy.shevchenko@gmail.com>, <alexandru.ardelean@analog.com>,
        <broonie@kernel.org>, <sfr@canb.auug.org.au>
Subject: [PATCH] spi: stm32: update dev_dbg() print format for SPI params
Date:   Mon, 4 Jan 2021 10:59:23 +0200
Message-ID: <20210104085923.53705-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-04_07:2020-12-31,2021-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040059
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With the introduction of the 'include/uapi/linux/spi/spi.h' header, the
type of the macros are enforced to 'unsigned long int' via the _BITUL()
macro.

This causes some -Wformat warnings in the spi-stm32 driver.
This patch changes the printf() specifiers from '%d' to '%lu' to
accommodate for this change.

Fixes: f7005142dace ("spi: uapi: unify SPI modes into a single spi.h header")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6017209c6d2f..47fd35acb651 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1027,7 +1027,7 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 	else
 		clrb |= spi->cfg->regs->lsb_first.mask;
 
-	dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
+	dev_dbg(spi->dev, "cpol=%lu cpha=%lu lsb_first=%lu cs_high=%lu\n",
 		spi_dev->mode & SPI_CPOL,
 		spi_dev->mode & SPI_CPHA,
 		spi_dev->mode & SPI_LSB_FIRST,
-- 
2.17.1

