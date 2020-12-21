Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5782E2DFD81
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 16:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgLUP0Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 10:26:16 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9234 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgLUP0P (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 10:26:15 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLFKPZ1016398;
        Mon, 21 Dec 2020 10:25:34 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35hc8bdr4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 10:25:34 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0BLFPXcj034389
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Dec 2020 10:25:33 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 21 Dec 2020 10:25:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Mon, 21 Dec 2020 10:25:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 21 Dec 2020 10:25:32 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BLFPRHL001932;
        Mon, 21 Dec 2020 10:25:30 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dragos.bogdan@analog.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 2/3] spi: Add SPI_NO_TX/RX support
Date:   Mon, 21 Dec 2020 17:29:35 +0200
Message-ID: <20201221152936.53873-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201221152936.53873-1-alexandru.ardelean@analog.com>
References: <20201221152936.53873-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_08:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=975 spamscore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 clxscore=1015 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012210109
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

Changelog v5 -> v6:
* https://patchwork.kernel.org/project/spi-devel-general/patch/20201221141906.48922-2-alexandru.ardelean@analog.com/
* merged on single line message:
    "setup: can not select any two of dual, quad and no-rx/tx at the same time\n"
* not adding Reviewed-by: tag for Andy yet, since there was a nit

 drivers/spi/spi.c            | 25 ++++++++++++++++++++-----
 include/linux/spi/spi.h      | 17 +++++++++++++++++
 include/uapi/linux/spi/spi.h | 10 ++++++++++
 3 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 51d7c004fbab..ca75f4036eda 100644
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
@@ -3329,12 +3335,16 @@ int spi_setup(struct spi_device *spi)
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
+		"setup: can not select any two of dual, quad and no-rx/tx at the same time\n");
 		return -EINVAL;
 	}
 	/* if it is SPI_3WIRE mode, DUAL and QUAD should be forbidden
@@ -3348,7 +3358,8 @@ int spi_setup(struct spi_device *spi)
 	 * SPI_CS_WORD has a fallback software implementation,
 	 * so it is ignored here.
 	 */
-	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD);
+	bad_bits = spi->mode & ~(spi->controller->mode_bits | SPI_CS_WORD |
+				 SPI_NO_TX | SPI_NO_RX);
 	/* nothing prevents from working with active-high CS in case if it
 	 * is driven by GPIO.
 	 */
@@ -3610,6 +3621,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		 * 2. check tx/rx_nbits match the mode in spi_device
 		 */
 		if (xfer->tx_buf) {
+			if (spi->mode & SPI_NO_TX)
+				return -EINVAL;
 			if (xfer->tx_nbits != SPI_NBITS_SINGLE &&
 				xfer->tx_nbits != SPI_NBITS_DUAL &&
 				xfer->tx_nbits != SPI_NBITS_QUAD)
@@ -3623,6 +3636,8 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		}
 		/* check transfer rx_nbits */
 		if (xfer->rx_buf) {
+			if (spi->mode & SPI_NO_RX)
+				return -EINVAL;
 			if (xfer->rx_nbits != SPI_NBITS_SINGLE &&
 				xfer->rx_nbits != SPI_NBITS_DUAL &&
 				xfer->rx_nbits != SPI_NBITS_QUAD)
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a08c3f37e202..9bfdfaf286eb 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_SPI_H
 #define __LINUX_SPI_H
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/slab.h>
@@ -166,6 +167,18 @@ struct spi_device {
 	u8			chip_select;
 	u8			bits_per_word;
 	bool			rt;
+#define SPI_NO_TX	BIT(31)		/* no transmit wire */
+#define SPI_NO_RX	BIT(30)		/* no receive wire */
+	/*
+	 * All bits defined above should be covered by SPI_MODE_KERNEL_MASK.
+	 * The SPI_MODE_KERNEL_MASK has the SPI_MODE_USER_MASK counterpart,
+	 * which is defined in 'include/uapi/linux/spi/spi.h'.
+	 * The bits defined here are from bit 31 downwards, while in
+	 * SPI_MODE_USER_MASK are from 0 upwards.
+	 * These bits must not overlap. A static assert check should make sure of that.
+	 * If adding extra bits, make sure to decrease the bit index below as well.
+	 */
+#define SPI_MODE_KERNEL_MASK	(~(BIT(30) - 1))
 	u32			mode;
 	int			irq;
 	void			*controller_state;
@@ -189,6 +202,10 @@ struct spi_device {
 	 */
 };
 
+/* Make sure that SPI_MODE_KERNEL_MASK & SPI_MODE_USER_MASK don't overlap */
+static_assert((SPI_MODE_KERNEL_MASK & SPI_MODE_USER_MASK) == 0,
+	      "SPI_MODE_USER_MASK & SPI_MODE_KERNEL_MASK must not overlap");
+
 static inline struct spi_device *to_spi_device(struct device *dev)
 {
 	return dev ? container_of(dev, struct spi_device, dev) : NULL;
diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index 703b586f35df..236a85f08ded 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -28,4 +28,14 @@
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
 
+/*
+ * All the bits defined above should be covered by SPI_MODE_USER_MASK.
+ * The SPI_MODE_USER_MASK has the SPI_MODE_KERNEL_MASK counterpart in
+ * 'include/linux/spi/spi.h'. The bits defined here are from bit 0 upwards
+ * while in SPI_MODE_KERNEL_MASK they are from the other end downwards.
+ * These bits must not overlap. A static assert check should make sure of that.
+ * If adding extra bits, make sure to increase the bit index below as well.
+ */
+#define SPI_MODE_USER_MASK	(_BITUL(16) - 1)
+
 #endif /* _UAPI_SPI_H */
-- 
2.17.1

