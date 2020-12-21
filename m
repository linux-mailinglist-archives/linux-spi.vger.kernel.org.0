Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3312DFD7D
	for <lists+linux-spi@lfdr.de>; Mon, 21 Dec 2020 16:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgLUP0O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 21 Dec 2020 10:26:14 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5954 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgLUP0O (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 21 Dec 2020 10:26:14 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BLFKsFe011865;
        Mon, 21 Dec 2020 10:25:32 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 35hfa9wc7f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 10:25:32 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0BLFPVas034386
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Dec 2020 10:25:31 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2; Mon, 21 Dec 2020
 10:25:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.721.2 via Frontend Transport;
 Mon, 21 Dec 2020 10:25:30 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0BLFPRHK001932;
        Mon, 21 Dec 2020 10:25:28 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <dragos.bogdan@analog.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v6 1/3] spi: uapi: unify SPI modes into a single spi.h header
Date:   Mon, 21 Dec 2020 17:29:34 +0200
Message-ID: <20201221152936.53873-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_08:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210109
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change moves all the SPI mode bits into a separate 'spi.h' header in
uAPI. This is meant to re-use these definitions inside the kernel as well
as export them to userspace (via uAPI).

The SPI mode definitions have usually been duplicated between between
'include/linux/spi/spi.h' and 'include/uapi/linux/spi/spidev.h', so
whenever adding a new entry, this would need to be put in both headers.

They've been moved from 'include/linux/spi/spi.h', since that seems a bit
more complete; the bits have descriptions and there is the SPI_MODE_X_MASK.

This change also does a conversion of these bitfields to _BITUL() macro.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v5 -> v6:
* https://patchwork.kernel.org/project/spi-devel-general/patch/20201221141906.48922-1-alexandru.ardelean@analog.com/
* no change

 include/linux/spi/spi.h         | 23 ++---------------------
 include/uapi/linux/spi/spi.h    | 31 +++++++++++++++++++++++++++++++
 include/uapi/linux/spi/spidev.h | 30 +-----------------------------
 3 files changed, 34 insertions(+), 50 deletions(-)
 create mode 100644 include/uapi/linux/spi/spi.h

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc8042d..a08c3f37e202 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -15,6 +15,8 @@
 #include <linux/gpio/consumer.h>
 #include <linux/ptp_clock_kernel.h>
 
+#include <uapi/linux/spi/spi.h>
+
 struct dma_chan;
 struct property_entry;
 struct spi_controller;
@@ -165,27 +167,6 @@ struct spi_device {
 	u8			bits_per_word;
 	bool			rt;
 	u32			mode;
-#define	SPI_CPHA	0x01			/* clock phase */
-#define	SPI_CPOL	0x02			/* clock polarity */
-#define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
-#define	SPI_MODE_1	(0|SPI_CPHA)
-#define	SPI_MODE_2	(SPI_CPOL|0)
-#define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
-#define	SPI_MODE_X_MASK	(SPI_CPOL|SPI_CPHA)
-#define	SPI_CS_HIGH	0x04			/* chipselect active high? */
-#define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
-#define	SPI_3WIRE	0x10			/* SI/SO signals shared */
-#define	SPI_LOOP	0x20			/* loopback mode */
-#define	SPI_NO_CS	0x40			/* 1 dev/bus, no chipselect */
-#define	SPI_READY	0x80			/* slave pulls low to pause */
-#define	SPI_TX_DUAL	0x100			/* transmit with 2 wires */
-#define	SPI_TX_QUAD	0x200			/* transmit with 4 wires */
-#define	SPI_RX_DUAL	0x400			/* receive with 2 wires */
-#define	SPI_RX_QUAD	0x800			/* receive with 4 wires */
-#define	SPI_CS_WORD	0x1000			/* toggle cs after each word */
-#define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
-#define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
-#define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
new file mode 100644
index 000000000000..703b586f35df
--- /dev/null
+++ b/include/uapi/linux/spi/spi.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _UAPI_SPI_H
+#define _UAPI_SPI_H
+
+#include <linux/const.h>
+
+#define	SPI_CPHA		_BITUL(0)	/* clock phase */
+#define	SPI_CPOL		_BITUL(1)	/* clock polarity */
+
+#define	SPI_MODE_0		(0|0)		/* (original MicroWire) */
+#define	SPI_MODE_1		(0|SPI_CPHA)
+#define	SPI_MODE_2		(SPI_CPOL|0)
+#define	SPI_MODE_3		(SPI_CPOL|SPI_CPHA)
+#define	SPI_MODE_X_MASK		(SPI_CPOL|SPI_CPHA)
+
+#define	SPI_CS_HIGH		_BITUL(2)	/* chipselect active high? */
+#define	SPI_LSB_FIRST		_BITUL(3)	/* per-word bits-on-wire */
+#define	SPI_3WIRE		_BITUL(4)	/* SI/SO signals shared */
+#define	SPI_LOOP		_BITUL(5)	/* loopback mode */
+#define	SPI_NO_CS		_BITUL(6)	/* 1 dev/bus, no chipselect */
+#define	SPI_READY		_BITUL(7)	/* slave pulls low to pause */
+#define	SPI_TX_DUAL		_BITUL(8)	/* transmit with 2 wires */
+#define	SPI_TX_QUAD		_BITUL(9)	/* transmit with 4 wires */
+#define	SPI_RX_DUAL		_BITUL(10)	/* receive with 2 wires */
+#define	SPI_RX_QUAD		_BITUL(11)	/* receive with 4 wires */
+#define	SPI_CS_WORD		_BITUL(12)	/* toggle cs after each word */
+#define	SPI_TX_OCTAL		_BITUL(13)	/* transmit with 8 wires */
+#define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
+#define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
+
+#endif /* _UAPI_SPI_H */
diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index d56427c0b3e0..0c3da08f2aff 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -25,35 +25,7 @@
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
-
-/* User space versions of kernel symbols for SPI clocking modes,
- * matching <linux/spi/spi.h>
- */
-
-#define SPI_CPHA		0x01
-#define SPI_CPOL		0x02
-
-#define SPI_MODE_0		(0|0)
-#define SPI_MODE_1		(0|SPI_CPHA)
-#define SPI_MODE_2		(SPI_CPOL|0)
-#define SPI_MODE_3		(SPI_CPOL|SPI_CPHA)
-
-#define SPI_CS_HIGH		0x04
-#define SPI_LSB_FIRST		0x08
-#define SPI_3WIRE		0x10
-#define SPI_LOOP		0x20
-#define SPI_NO_CS		0x40
-#define SPI_READY		0x80
-#define SPI_TX_DUAL		0x100
-#define SPI_TX_QUAD		0x200
-#define SPI_RX_DUAL		0x400
-#define SPI_RX_QUAD		0x800
-#define SPI_CS_WORD		0x1000
-#define SPI_TX_OCTAL		0x2000
-#define SPI_RX_OCTAL		0x4000
-#define SPI_3WIRE_HIZ		0x8000
-
-/*---------------------------------------------------------------------------*/
+#include <linux/spi/spi.h>
 
 /* IOCTL commands */
 
-- 
2.17.1

