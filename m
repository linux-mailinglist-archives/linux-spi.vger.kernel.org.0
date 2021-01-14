Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1822F64EA
	for <lists+linux-spi@lfdr.de>; Thu, 14 Jan 2021 16:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbhANPjq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 Jan 2021 10:39:46 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:12340 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726810AbhANPjq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 Jan 2021 10:39:46 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10EFZqg7016149;
        Thu, 14 Jan 2021 10:39:05 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 35y779gygd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 10:39:04 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 10EFd3BK009888
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 14 Jan 2021 10:39:03 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 14 Jan
 2021 10:39:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 14 Jan 2021 10:39:02 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 10EFd1oT023272;
        Thu, 14 Jan 2021 10:39:01 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <harinik@xilinx.com>,
        <michael.hennerich@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] spi: cadence: cache reference clock rate during probe
Date:   Thu, 14 Jan 2021 17:42:17 +0200
Message-ID: <20210114154217.51996-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_05:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140090
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

The issue is that using SPI from a callback under the CCF lock will
deadlock, since this code uses clk_get_rate().

Fixes: c474b38665463 ("spi: Add driver for Cadence SPI controller")
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/spi/spi-cadence.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 70467b9d61ba..a3afd1b9ac56 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -115,6 +115,7 @@ struct cdns_spi {
 	void __iomem *regs;
 	struct clk *ref_clk;
 	struct clk *pclk;
+	unsigned int clk_rate;
 	u32 speed_hz;
 	const u8 *txbuf;
 	u8 *rxbuf;
@@ -250,7 +251,7 @@ static void cdns_spi_config_clock_freq(struct spi_device *spi,
 	u32 ctrl_reg, baud_rate_val;
 	unsigned long frequency;
 
-	frequency = clk_get_rate(xspi->ref_clk);
+	frequency = xspi->clk_rate;
 
 	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 
@@ -558,8 +559,9 @@ static int cdns_spi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
 
+	xspi->clk_rate = clk_get_rate(xspi->ref_clk);
 	/* Set to default valid value */
-	master->max_speed_hz = clk_get_rate(xspi->ref_clk) / 4;
+	master->max_speed_hz = xspi->clk_rate / 4;
 	xspi->speed_hz = master->max_speed_hz;
 
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-- 
2.17.1

