Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322EF2DD058
	for <lists+linux-spi@lfdr.de>; Thu, 17 Dec 2020 12:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgLQL2k (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 17 Dec 2020 06:28:40 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:15618 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727376AbgLQL2k (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 17 Dec 2020 06:28:40 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BHBMAn1026723;
        Thu, 17 Dec 2020 03:27:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=jLXUZM0Czn4gqhA8iJlYQMy6XDxtIyhsCGDFgrRleYQ=;
 b=DMH25FZp6leJCvcocB88z5smEuO3s3GkAesoobrrODy9+LSYtRJFcrfSW0tnwI4kuRpY
 haw7d4FSVXU7ZOlONQULAzaI7YuDdKSbYbpzzt6Dzlo0lPfpdBiQ8MhM9u4xVPDFNUUv
 17tP+d58jIlnXfLEwGu2jV29PQ7GQ9VdXezoWsOvPBlhxnB/J70BLqlGhK3Vvlql4dce
 TROQx9VJG85EjV3BbDdeaTspvR0aMIDOf98sjvxvw2GUR8/CApT2rI9tx9h4np65zQfh
 X+R8mi+WjRAv1Q63shxlYNYcp7JHzUP9K7CDDjeHEUDPPrcmwbHNLbh3foRKPRQE3/f1 vg== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 35g4rp09gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 17 Dec 2020 03:27:58 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Dec
 2020 03:27:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Dec 2020 03:27:57 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id C5A653F703F;
        Thu, 17 Dec 2020 03:27:54 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        Konstantin Porotchkin <kostap@marvell.com>
Subject: [PATCH 2/3] spi: orion: enable support for switching CS every transferred byte
Date:   Thu, 17 Dec 2020 13:27:07 +0200
Message-ID: <20201217112708.3473-3-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201217112708.3473-1-kostap@marvell.com>
References: <20201217112708.3473-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-17_07:2020-12-15,2020-12-17 signatures=0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Marcin Wojtas <mw@semihalf.com>

Some SPI devices, such as SLIC (Subscriber Line Interface Card)
require toggling the CS every transferred byte. Enable such
possibility by creating a new DT property and enabling SPI
device mode update. Add according support in the spi-orion driver.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
Signed-off-by: Konstantin Porotchkin <kostap@marvell.com>
---
 drivers/spi/spi-orion.c | 20 +++++++++++++++++++-
 drivers/spi/spi.c       |  6 ++++--
 include/linux/spi/spi.h |  1 +
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 3bfda4225d45..7db9034b0879 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -369,8 +369,15 @@ orion_spi_write_read_8bit(struct spi_device *spi,
 {
 	void __iomem *tx_reg, *rx_reg, *int_reg;
 	struct orion_spi *orion_spi;
+	bool cs_single_byte;
+
+	cs_single_byte = spi->mode & SPI_1BYTE_CS;
 
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
@@ -391,6 +403,12 @@ orion_spi_write_read_8bit(struct spi_device *spi,
 	if (rx_buf && *rx_buf)
 		*(*rx_buf)++ = readl(rx_reg);
 
+	if (cs_single_byte) {
+		orion_spi_set_cs(spi, 1);
+		/* Satisfy some SLIC devices requirements */
+		udelay(4);
+	}
+
 	return 1;
 }
 
@@ -626,7 +644,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	}
 
 	/* we support all 4 SPI modes and LSB first option */
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_1BYTE_CS;
 	master->set_cs = orion_spi_set_cs;
 	master->transfer_one = orion_spi_transfer_one;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51d7c004fbab..998579807a04 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1937,6 +1937,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_LSB_FIRST;
 	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |= SPI_CS_HIGH;
+	if (of_find_property(nc, "spi-1byte-cs", NULL))
+		spi->mode |= SPI_1BYTE_CS;
 
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
@@ -3419,15 +3421,15 @@ int spi_setup(struct spi_device *spi)
 		spi_set_thread_rt(spi->controller);
 	}
 
-	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
+	dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			(int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
 			(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
 			(spi->mode & SPI_3WIRE) ? "3wire, " : "",
 			(spi->mode & SPI_LOOP) ? "loopback, " : "",
+			(spi->mode & SPI_1BYTE_CS) ? "single_cs_byte, " : "",
 			spi->bits_per_word, spi->max_speed_hz,
 			status);
-
 	return status;
 }
 EXPORT_SYMBOL_GPL(spi_setup);
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc8042d..7f65ff6fc25d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -186,6 +186,7 @@ struct spi_device {
 #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
+#define	SPI_1BYTE_CS	0x10000			/* toggle cs after each byte */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.17.1

