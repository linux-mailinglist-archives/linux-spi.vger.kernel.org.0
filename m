Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D86F2C665E
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 14:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgK0NIs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 08:08:48 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5378 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730145AbgK0NIr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 08:08:47 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARCVJuU018276;
        Fri, 27 Nov 2020 08:08:46 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y08vb6k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 08:08:45 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0ARD8iBS049546
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 27 Nov 2020 08:08:44 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 27 Nov 2020 08:08:43 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 27 Nov 2020 08:08:43 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 27 Nov 2020 08:08:43 -0500
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ARD8dKI026672;
        Fri, 27 Nov 2020 08:08:41 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <broonie@kernel.org>,
        <andy.shevchenko@gmail.com>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 2/3] spi: Add SPI_NO_TX/RX support
Date:   Fri, 27 Nov 2020 15:08:33 +0200
Message-ID: <20201127130834.136348-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127130834.136348-1-alexandru.ardelean@analog.com>
References: <20201127130834.136348-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_06:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 adultscore=0 mlxlogscore=784
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270078
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
 drivers/spi/spi.c            | 26 +++++++++++++++++++++-----
 include/uapi/linux/spi/spi.h |  2 ++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index cd3c395b4e90..17d4004bd2c6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1941,6 +1941,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
 		switch (value) {
+		case 0:
+			spi->mode |= SPI_NO_TX;
+			break;
 		case 1:
 			break;
 		case 2:
@@ -1962,6 +1965,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 
 	if (!of_property_read_u32(nc, "spi-rx-bus-width", &value)) {
 		switch (value) {
+		case 0:
+			spi->mode |= SPI_NO_RX;
+			break;
 		case 1:
 			break;
 		case 2:
@@ -3329,12 +3335,17 @@ int spi_setup(struct spi_device *spi)
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
@@ -3348,7 +3359,8 @@ int spi_setup(struct spi_device *spi)
 	 * SPI_CS_WORD has a fallback software implementation,
 	 * so it is ignored here.
 	 */
-	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
+	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
+				 SPI_NO_TX | SPI_NO_RX);
 	/* nothing prevents from working with active-high CS in case if it
 	 * is driven by GPIO.
 	 */
@@ -3609,6 +3621,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		 * 2. check tx/rx_nbits match the mode in spi_device
 		 */
 		if (xfer->tx_buf) {
+			if (spi->mode & SPI_NO_TX)
+				return -EINVAL;
 			if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
 				xfer->tx_nbits != SPI_NBITS_DUAL &&
 				xfer->tx_nbits != SPI_NBITS_QUAD)
@@ -3622,6 +3636,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		}
 		/* check transfer rx_nbits */
 		if (xfer->rx_buf) {
+			if (spi->mode & SPI_NO_RX)
+				return -EINVAL;
 			if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
 				xfer->rx_nbits != SPI_NBITS_DUAL &&
 				xfer->rx_nbits != SPI_NBITS_QUAD)
diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index ae028d64c779..b504e46a6f18 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -43,5 +43,7 @@
 #define	SPI_TX_OCTAL		0x2000		/* transmit with 8 wires */
 #define	SPI_RX_OCTAL		0x4000		/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		0x8000		/* high impedance turnaround */
+#define	SPI_NO_TX		0x10000		/* no transmit wire */
+#define	SPI_NO_RX		0x20000		/* no receive wire */
 
 #endif /* _UAPI_SPI_H */
-- 
2.27.0

