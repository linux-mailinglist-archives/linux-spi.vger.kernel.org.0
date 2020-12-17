Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181342DD5C0
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 18:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgLQRLH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 12:11:07 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50914 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728813AbgLQRLF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 12:11:05 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHH6QUB019488;
        Thu, 17 Dec 2020 09:10:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=Ik8WDD6u9JOnUG3RZkwBgUG0BY8nhaV7NDL61uv8zno=;
 b=gk6Kghd7HYnviQz9x7RTlkSa6Y+7CSv66dXR3pzd0SveOHpTv6W8muAAzQExTawbHi0A
 +N/NaZKdk89JlVVyPcJkEGSci6nbsKV2QAR7Wac4LcNiy3+Npu21WH3c414u8BWp0QX1
 EzW8MR2wr0NiXJhXsJ+mrBhhGjUadE2L/pG1vwAr7621xZROLbVmPo3NSwfRnLFi8kqG
 rqlJQIMuSbphVzdmoUJsl55EvKJl39/SJM7nni+BHR5uZKfdl6MS9XiwnvxgEBFR8MeL
 L2q40q/4sFuym7uT2kxMe+P8z/3th2idOExnaHw7FcZ4lBE+QcwXg+oEODlOK4s+es/R gw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 35g4rp17x0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 09:10:23 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 09:10:22 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 09:10:22 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id E21083F7040;
        Thu, 17 Dec 2020 09:10:19 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH v2 2/2] spi: orion: enable support for switching CS every transferred byte
Date:   Thu, 17 Dec 2020 19:09:32 +0200
Message-ID: <20201217170933.10717-3-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217170933.10717-1-kostap@marvell.com>
References: <20201217170933.10717-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_11:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

Some SPI devices, require toggling the CS every transferred byte.
Enable such possibility in the spi-orion driver.

Note that in order to use it, in the driver of a secondary device
attached to this controller, the SPI bus 'mode' field must be
updated with SPI_CS_WORD flag before calling spi_setup() routine.

In addition to that include a work-around - some devices, such as
certain models of SLIC (Subscriber Line Interface Card),
may require extra delay after CS toggling, so add a minimal
timing relaxation in relevant places.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 drivers/spi/spi-orion.c | 24 +++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 3bfda4225d45..0f92dd026bee 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -369,8 +369,15 @@ orion_spi_write_read_8bit(struct spi_device *spi,
 {
 	void __iomem *tx_reg, *rx_reg, *int_reg;
 	struct orion_spi *orion_spi;
+	bool cs_single_byte;
+
+	cs_single_byte = spi->mode & SPI_CS_WORD;
 
 	orion_spi = spi_master_get_devdata(spi->master);
+
+	if (cs_single_byte)
+		orion_spi_set_cs(spi, 0);
+
 	tx_reg = spi_reg(orion_spi, ORION_SPI_DATA_OUT_REG);
 	rx_reg = spi_reg(orion_spi, ORION_SPI_DATA_IN_REG);
 	int_reg = spi_reg(orion_spi, ORION_SPI_INT_CAUSE_REG);
@@ -384,6 +391,11 @@ orion_spi_write_read_8bit(struct spi_device *spi,
 		writel(0, tx_reg);
 
 	if (orion_spi_wait_till_ready(orion_spi) < 0) {
+		if (cs_single_byte) {
+			orion_spi_set_cs(spi, 1);
+			/* Satisfy some SLIC devices requirements */
+			udelay(4);
+		}
 		dev_err(&spi->dev, "TXS timed out\n");
 		return -1;
 	}
@@ -391,6 +403,16 @@ orion_spi_write_read_8bit(struct spi_device *spi,
 	if (rx_buf && *rx_buf)
 		*(*rx_buf)++ = readl(rx_reg);
 
+	if (cs_single_byte) {
+		orion_spi_set_cs(spi, 1);
+		/*
+		 * Some devices, such as certain models of SLIC
+		 * (Subscriber Line Interface Card)
+		 * may require extra delay after CS toggling.
+		 */
+		udelay(4);
+	}
+
 	return 1;
 }
 
@@ -626,7 +648,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	}
 
 	/* we support all 4 SPI modes and LSB first option */
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_CS_WORD;
 	master->set_cs = orion_spi_set_cs;
 	master->transfer_one = orion_spi_transfer_one;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
-- 
2.17.1

