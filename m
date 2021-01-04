Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A52E9745
	for <lists+linux-spi@lfdr.de>; Mon,  4 Jan 2021 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbhADO2S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Jan 2021 09:28:18 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:64444 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbhADO2R (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Jan 2021 09:28:17 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 104EPjGi030793;
        Mon, 4 Jan 2021 09:27:29 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35tpm8kmuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jan 2021 09:27:29 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 104ERS2A010839
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 4 Jan 2021 09:27:28 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 4 Jan 2021
 09:27:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 4 Jan 2021 09:27:27 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 104ERLca030130;
        Mon, 4 Jan 2021 09:27:22 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <andy.shevchenko@gmail.com>, <alexandru.ardelean@analog.com>,
        <broonie@kernel.org>, <sfr@canb.auug.org.au>
Subject: [PATCH v2] spi: stm32: update dev_dbg() print format for SPI params
Date:   Mon, 4 Jan 2021 16:31:03 +0200
Message-ID: <20210104143103.56510-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210104085923.53705-1-alexandru.ardelean@analog.com>
References: <20210104085923.53705-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-04_08:2021-01-04,2021-01-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=983
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101040094
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With the introduction of the 'include/uapi/linux/spi/spi.h' header, the
type of the macros are enforced to 'unsigned long int' via the _BITUL()
macro.

This causes some -Wformat warnings in the spi-stm32 driver.
This patch adds a double-negation operator to the bit-masks. Essentially,
the important values for debugging are 0 or 1, while masking them directly
would show 0 or BIT(x) values.
This way, the type of the arguments are automatically re-cast.

Fixes: f7005142dace ("spi: uapi: unify SPI modes into a single spi.h header")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* revert to using '%d' specifiers
* add !! operatior to bit-masking; this way the types are automatically
  re-cast
* add 'Reported-by: kernel test robot <lkp@intel.com>'

 drivers/spi/spi-stm32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 6017209c6d2f..be0fb169d7a7 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1028,10 +1028,10 @@ static int stm32_spi_prepare_msg(struct spi_master *master,
 		clrb |= spi->cfg->regs->lsb_first.mask;
 
 	dev_dbg(spi->dev, "cpol=%d cpha=%d lsb_first=%d cs_high=%d\n",
-		spi_dev->mode & SPI_CPOL,
-		spi_dev->mode & SPI_CPHA,
-		spi_dev->mode & SPI_LSB_FIRST,
-		spi_dev->mode & SPI_CS_HIGH);
+		!!(spi_dev->mode & SPI_CPOL),
+		!!(spi_dev->mode & SPI_CPHA),
+		!!(spi_dev->mode & SPI_LSB_FIRST),
+		!!(spi_dev->mode & SPI_CS_HIGH));
 
 	spin_lock_irqsave(&spi->lock, flags);
 
-- 
2.17.1

