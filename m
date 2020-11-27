Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA32C665C
	for <lists+linux-spi@lfdr.de>; Fri, 27 Nov 2020 14:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgK0NIs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 27 Nov 2020 08:08:48 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:5422 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730148AbgK0NIr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 27 Nov 2020 08:08:47 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARCUm1E007339;
        Fri, 27 Nov 2020 08:08:46 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y0p8k45h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 08:08:45 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 0ARD8iF9061127
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 27 Nov 2020 08:08:44 -0500
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 27 Nov 2020 05:08:43 -0800
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 27 Nov 2020 05:08:42 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 27 Nov 2020 05:08:42 -0800
Received: from saturn.ad.analog.com ([10.48.65.109])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0ARD8dKH026672;
        Fri, 27 Nov 2020 08:08:39 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <broonie@kernel.org>,
        <andy.shevchenko@gmail.com>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v3 1/3] spi: uapi: unify SPI modes into a single spi.h header
Date:   Fri, 27 Nov 2020 15:08:32 +0200
Message-ID: <20201127130834.136348-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_06:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270078
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change moves all the SPI mode bits into a separate 'spi.h' header in
uapi. This is meant to re-use these definitions inside the kernel as well
as export them to userspace (via uapi).

The SPI mode definitions have usually been duplicated between between
'include/linux/spi/spi.h' and 'include/uapi/linux/spi/spidev.h', so
whenever adding a new entry, this would need to be put in both headers.

They've been moved from 'include/linux/spi/spi.h', since that seems a bit
more complete; the bits have descriptions and there is the SPI_MODE_X_MASK.

For now, this change does a simple move; no conversions to BIT() macros are
being done at this point. This can be done later, as that requires also
another header inclusion (the 'const.h' header).
The change as-is makes this 'spi.h' header more standalone.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Personally, I am not sure whether to convert the bitfield tos _BITUL()
macros or not. I feel that not-having these macros makes this uapi spi.h
header more standalone.
If there's a strong insistence to use those _BITUL() macros, I'll do it.
I'm hesitant now, because it requires that this spi.h includes the
'const.h' header.

Changelog v2 -> v3:
* https://lore.kernel.org/linux-spi/20201124102152.16548-1-alexandru.ardelean@analog.com/
* dropped 'spi: convert to BIT() all spi_device flags '
  added 'spi: uapi: unify SPI modes into a single spi.h header'

 include/linux/spi/spi.h         | 22 +--------------
 include/uapi/linux/spi/spi.h    | 47 +++++++++++++++++++++++++++++++++
 include/uapi/linux/spi/spidev.h | 30 +--------------------
 3 files changed, 49 insertions(+), 50 deletions(-)
 create mode 100644 include/uapi/linux/spi/spi.h

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc8042d..a4fedb33d34b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -14,6 +14,7 @@
 #include <linux/scatterlist.h>
 #include <linux/gpio/consumer.h>
 #include <linux/ptp_clock_kernel.h>
+#include <uapi/linux/spi/spi.h>
 
 struct dma_chan;
 struct property_entry;
@@ -165,27 +166,6 @@ struct spi_device {
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
index 000000000000..ae028d64c779
--- /dev/null
+++ b/include/uapi/linux/spi/spi.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+/*
+ * include/linux/spi/spi.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+  */
+
+#ifndef _UAPI_SPI_H
+#define _UAPI_SPI_H
+
+#define	SPI_CPHA		0x01		/* clock phase */
+#define	SPI_CPOL		0x02		/* clock polarity */
+
+#define	SPI_MODE_0		(0|0)		/* (original MicroWire) */
+#define	SPI_MODE_1		(0|SPI_CPHA)
+#define	SPI_MODE_2		(SPI_CPOL|0)
+#define	SPI_MODE_3		(SPI_CPOL|SPI_CPHA)
+#define	SPI_MODE_X_MASK		(SPI_CPOL|SPI_CPHA)
+
+#define	SPI_CS_HIGH		0x04		/* chipselect active high? */
+#define	SPI_LSB_FIRST		0x08		/* per-word bits-on-wire */
+#define	SPI_3WIRE		0x10		/* SI/SO signals shared */
+#define	SPI_LOOP		0x20		/* loopback mode */
+#define	SPI_NO_CS		0x40		/* 1 dev/bus, no chipselect */
+#define	SPI_READY		0x80		/* slave pulls low to pause */
+#define	SPI_TX_DUAL		0x100		/* transmit with 2 wires */
+#define	SPI_TX_QUAD		0x200		/* transmit with 4 wires */
+#define	SPI_RX_DUAL		0x400		/* receive with 2 wires */
+#define	SPI_RX_QUAD		0x800		/* receive with 4 wires */
+#define	SPI_CS_WORD		0x1000		/* toggle cs after each word */
+#define	SPI_TX_OCTAL		0x2000		/* transmit with 8 wires */
+#define	SPI_RX_OCTAL		0x4000		/* receive with 8 wires */
+#define	SPI_3WIRE_HIZ		0x8000		/* high impedance turnaround */
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
2.27.0

