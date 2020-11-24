Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1532C229C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 11:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgKXKRA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 05:17:00 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47452 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731266AbgKXKRA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 05:17:00 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AOAEINL031000;
        Tue, 24 Nov 2020 05:16:58 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y0p884gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 05:16:58 -0500
Received: from SCSQMBX11.ad.analog.com (SCSQMBX11.ad.analog.com [10.77.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0AOAGuJN021644
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 24 Nov 2020 05:16:56 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Nov 2020 02:16:55 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 24 Nov 2020 02:16:55 -0800
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AOAGpgx028996;
        Tue, 24 Nov 2020 05:16:53 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 2/3] spi: Add SPI_NO_TX/RX support
Date:   Tue, 24 Nov 2020 12:21:51 +0200
Message-ID: <20201124102152.16548-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124102152.16548-1-alexandru.ardelean@analog.com>
References: <20201124102152.16548-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=901 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240062
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

Transmit/receive only is a valid SPI mode. For example, the MOSI/TX line
might be missing from an ADC while for a DAC the MISO/RX line may be
optional. This patch adds these two new modes: SPI_NO_TX and
SPI_NO_RX. This way, the drivers will be able to identify if any of
these two lines is missing and to adjust the transfers accordingly.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* https://lore.kernel.org/linux-spi/20201111141529.98147-1-alexandru.ardelean@analog.com/
* convert comment to new multi-line format

 drivers/spi/spi.c       | 26 +++++++++++++++++++++-----
 include/linux/spi/spi.h |  2 ++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0c3f3a962448..5784fa8d9d74 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1939,6 +1939,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
 		switch (value) {
+		case 0:
+			spi->mode |= SPI_NO_TX;
+			break;
 		case 1:
 			break;
 		case 2:
@@ -1960,6 +1963,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 
 	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
 		switch (value) {
+		case 0:
+			spi->mode |= SPI_NO_RX;
+			break;
 		case 1:
 			break;
 		case 2:
@@ -3327,12 +3333,17 @@ int spi_setup(struct spi_device *spi)
 	unsigned	bad_bits, ugly_bits;
 	int		status;
 
-	/* check mode to prevent that DUAL and QUAD set at the same time
+	/*
+	 * check mode to prevent that any two of DUAL, QUAD and NO_MOSI/MISO
+	 * are set at the same time
 	 */
-	if (((spi->mode & SPI_TX_DUAL) && (spi->mode & SPI_TX_QUAD)) ||
-		((spi->mode & SPI_RX_DUAL) && (spi->mode & SPI_RX_QUAD))) {
+	if ((hweight_long(spi->mode &
+		(SPI_TX_DUAL | SPI_TX_QUAD | SPI_NO_TX)) > 1) ||
+	    (hweight_long(spi->mode &
+		(SPI_RX_DUAL | SPI_RX_QUAD | SPI_NO_RX)) > 1)) {
 		dev_err(&spi->dev,
-		"setup: can not select dual and quad at the same time\n");
+		"setup: can not select any two of dual, quad and no-rx/tx "
+		"at the same time\n");
 		return -EINVAL;
 	}
 	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
@@ -3346,7 +3357,8 @@ int spi_setup(struct spi_device *spi)
 	 * SPI_CS_WORD has a fallback software implementation,
 	 * so it is ignored here.
 	 */
-	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
+	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
+				 SPI_NO_TX | SPI_NO_RX);
 	/* nothing prevents from working with active-high CS in case if it
 	 * is driven by GPIO.
 	 */
@@ -3607,6 +3619,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		 * 2. check tx/rx_nbits match the mode in spi_device
 		 */
 		if (xfer->tx_buf) {
+			if (spi->mode & SPI_NO_TX)
+				return -EINVAL;
 			if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
 				xfer->tx_nbits != SPI_NBITS_DUAL &&
 				xfer->tx_nbits != SPI_NBITS_QUAD)
@@ -3620,6 +3634,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		}
 		/* check transfer rx_nbits */
 		if (xfer->rx_buf) {
+			if (spi->mode & SPI_NO_RX)
+				return -EINVAL;
 			if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
 				xfer->rx_nbits != SPI_NBITS_DUAL &&
 				xfer->rx_nbits != SPI_NBITS_QUAD)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 66c7d8e45563..8f3343d3ac27 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -186,6 +186,8 @@ struct spi_device {
 #define	SPI_TX_OCTAL	BIT(13)			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	BIT(14)			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	BIT(15)			/* high impedance turnaround */
+#define	SPI_NO_TX	BIT(16)			/* no transmit wire */
+#define	SPI_NO_RX	BIT(17)			/* no receive wire */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.17.1

