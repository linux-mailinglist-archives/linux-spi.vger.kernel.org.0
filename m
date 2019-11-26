Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBDC10A258
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 17:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfKZQlv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 11:41:51 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:18294 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727754AbfKZQlv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Nov 2019 11:41:51 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAQGZi3p023107;
        Tue, 26 Nov 2019 10:41:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=O0ngmniTlhH5g6ai5X/BariiUS7WJ1J63ag8Mvb+HgM=;
 b=cEj17cxO6l4o9lX498QqrilWCk8/+JFIzWDwo6xbSMyUOcaqrHo5OusLzsPfKE94Opb0
 ws7gzTYBLVvVXFZxvXIcGyFjqV56rhP/nEIzxecFVRialbVjuOHHBpNlEZwhzVD8woJi
 08Oyy3vY66vPegH1eLqCqlX7CpmmLHpNjZnH9b2tWuPph7ccfD4bwJxRFWXA0BFndfDJ
 H7eqTCFP3s+2sW5M76YW52DMf0y2KWZCar2TbwIzNSGVSa/pIO2av3RElNMYbT0qK6wy
 5B1F/FT5T8apEnSw9rk6/MZwv2/bWkl7/pIX8bY+0gHt+MYpJTbnEbiidrzaG5kkARx4 eg== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([5.172.152.52])
        by mx0b-001ae601.pphosted.com with ESMTP id 2wf22tcgsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Nov 2019 10:41:42 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 26 Nov
 2019 16:42:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via Frontend
 Transport; Tue, 26 Nov 2019 16:42:35 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 62B292C6;
        Tue, 26 Nov 2019 16:41:40 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <gregory.clement@bootlin.com>, <linus.walleij@linaro.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: cadence: Correct handling of native chipselect
Date:   Tue, 26 Nov 2019 16:41:40 +0000
Message-ID: <20191126164140.6240-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1011 mlxlogscore=999
 adultscore=0 suspectscore=1 lowpriorityscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911260139
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

To fix a regression on the Cadence SPI driver, this patch reverts
commit 6046f5407ff0 ("spi: cadence: Fix default polarity of native
chipselect").

This patch was not the correct fix for the issue. The SPI framework
calls the set_cs line with the logic level it desires on the chip select
line, as such the old is_high handling was correct. However, this was
broken by the fact that before commit 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH
setting when using native and GPIO CS") all controllers that offered
the use of a GPIO chip select had SPI_CS_HIGH applied, even for hardware
chip selects. This caused the value passed into the driver to be inverted.
Which unfortunately makes it look like a logical enable the chip select
value.

Since the core was corrected to not unconditionally apply SPI_CS_HIGH,
the Cadence driver, whilst using the hardware chip select, will deselect
the chip select every time we attempt to communicate with the device,
which results in failed communications.

Fixes: 3e5ec1db8bfe ("spi: Fix SPI_CS_HIGH setting when using native and GPIO CS")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/spi/spi-cadence.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index c36587b42e951..82a0ee09cbe14 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -168,16 +168,16 @@ static void cdns_spi_init_hw(struct cdns_spi *xspi)
 /**
  * cdns_spi_chipselect - Select or deselect the chip select line
  * @spi:	Pointer to the spi_device structure
- * @enable:	Select (1) or deselect (0) the chip select line
+ * @is_high:	Select(0) or deselect (1) the chip select line
  */
-static void cdns_spi_chipselect(struct spi_device *spi, bool enable)
+static void cdns_spi_chipselect(struct spi_device *spi, bool is_high)
 {
 	struct cdns_spi *xspi = spi_master_get_devdata(spi->master);
 	u32 ctrl_reg;
 
 	ctrl_reg = cdns_spi_read(xspi, CDNS_SPI_CR);
 
-	if (!enable) {
+	if (is_high) {
 		/* Deselect the slave */
 		ctrl_reg |= CDNS_SPI_CR_SSCTRL;
 	} else {
-- 
2.11.0

