Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02C13CBE13
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jul 2021 22:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbhGPU5b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Jul 2021 16:57:31 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8462 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230415AbhGPU5a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Jul 2021 16:57:30 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GKfGVM011753;
        Fri, 16 Jul 2021 16:54:31 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 39tw63kv3e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jul 2021 16:54:31 -0400
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 16GKsTNl048128
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Jul 2021 16:54:29 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.5;
 Fri, 16 Jul 2021 13:54:28 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by scsqmbx11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.2.858.5 via Frontend
 Transport; Fri, 16 Jul 2021 13:54:27 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 16GKsNDT003387;
        Fri, 16 Jul 2021 16:54:25 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <broonie@kernel.org>
CC:     <nuno.sa@analog.com>, <bootc@bootc.net>, <swarren@wwwdotorg.org>,
        <bcm-kernel-feedback-list@broadcom.com>, <rjui@broadcom.com>,
        <f.fainelli@gmail.com>, <nsaenz@kernel.org>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH 1/1] spi: spi-bcm2835: Fix deadlock
Date:   Sat, 17 Jul 2021 00:02:45 +0300
Message-ID: <20210716210245.13240-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210716210245.13240-1-alexandru.tachici@analog.com>
References: <20210716210245.13240-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: jOCQ3VaieD2Z6CMh00k2QwwuZfjBWmjl
X-Proofpoint-ORIG-GUID: jOCQ3VaieD2Z6CMh00k2QwwuZfjBWmjl
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_09:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=841 spamscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160131
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

The bcm2835_spi_transfer_one function can create a deadlock
if it is called while another thread already has the
CCF lock.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Fixes: f8043872e796 ("spi: add driver for BCM2835")
---
 drivers/spi/spi-bcm2835.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 5f8771fe1a31..775c0bf2f923 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -83,6 +83,7 @@ MODULE_PARM_DESC(polling_limit_us,
  * struct bcm2835_spi - BCM2835 SPI controller
  * @regs: base address of register map
  * @clk: core clock, divided to calculate serial clock
+ * @clk_hz: core clock cached speed
  * @irq: interrupt, signals TX FIFO empty or RX FIFO ¾ full
  * @tfr: SPI transfer currently processed
  * @ctlr: SPI controller reverse lookup
@@ -116,6 +117,7 @@ MODULE_PARM_DESC(polling_limit_us,
 struct bcm2835_spi {
 	void __iomem *regs;
 	struct clk *clk;
+	unsigned long clk_hz;
 	int irq;
 	struct spi_transfer *tfr;
 	struct spi_controller *ctlr;
@@ -1045,19 +1047,18 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 {
 	struct bcm2835_spi *bs = spi_controller_get_devdata(ctlr);
 	struct bcm2835_spidev *slv = spi_get_ctldata(spi);
-	unsigned long spi_hz, clk_hz, cdiv;
+	unsigned long spi_hz, cdiv;
 	unsigned long hz_per_byte, byte_limit;
 	u32 cs = slv->prepare_cs;
 
 	/* set clock */
 	spi_hz = tfr->speed_hz;
-	clk_hz = clk_get_rate(bs->clk);
 
-	if (spi_hz >= clk_hz / 2) {
+	if (spi_hz >= bs->clk_hz / 2) {
 		cdiv = 2; /* clk_hz/2 is the fastest we can go */
 	} else if (spi_hz) {
 		/* CDIV must be a multiple of two */
-		cdiv = DIV_ROUND_UP(clk_hz, spi_hz);
+		cdiv = DIV_ROUND_UP(bs->clk_hz, spi_hz);
 		cdiv += (cdiv % 2);
 
 		if (cdiv >= 65536)
@@ -1065,7 +1066,7 @@ static int bcm2835_spi_transfer_one(struct spi_controller *ctlr,
 	} else {
 		cdiv = 0; /* 0 is the slowest we can go */
 	}
-	tfr->effective_speed_hz = cdiv ? (clk_hz / cdiv) : (clk_hz / 65536);
+	tfr->effective_speed_hz = cdiv ? (bs->clk_hz / cdiv) : (bs->clk_hz / 65536);
 	bcm2835_wr(bs, BCM2835_SPI_CLK, cdiv);
 
 	/* handle all the 3-wire mode */
@@ -1354,6 +1355,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 		return bs->irq ? bs->irq : -ENODEV;
 
 	clk_prepare_enable(bs->clk);
+	bs->clk_hz = clk_get_rate(bs->clk);
 
 	err = bcm2835_dma_init(ctlr, &pdev->dev, bs);
 	if (err)
-- 
2.25.1

