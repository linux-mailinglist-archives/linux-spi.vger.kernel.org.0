Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0352C2299
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 11:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgKXKQ6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Nov 2020 05:16:58 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:45536 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731266AbgKXKQ6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Nov 2020 05:16:58 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AOAET4c031145;
        Tue, 24 Nov 2020 05:16:56 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34y0p884gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Nov 2020 05:16:55 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AOAGs9v022101
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 24 Nov 2020 05:16:54 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Nov 2020 05:16:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Nov 2020 05:16:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 24 Nov 2020 05:16:53 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AOAGpgw028996;
        Tue, 24 Nov 2020 05:16:51 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <andy.shevchenko@gmail.com>, <dragos.bogdan@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/3] spi: convert to BIT() all spi_device flags
Date:   Tue, 24 Nov 2020 12:21:50 +0200
Message-ID: <20201124102152.16548-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_04:2020-11-24,2020-11-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240062
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This change converts all bit flags for the 'struct spi_device' mode to the
BIT() macro. The change is mostly for readability. Since adding more bit
fields, might as well convert it now.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Changelog v1 -> v2:
* https://lore.kernel.org/linux-spi/20201111141529.98147-1-alexandru.ardelean@analog.com/
* add patch 'spi: convert to BIT() all spi_device flags'
* for patch 'spi: Add SPI_NO_TX/RX support'
  convert comment to new multi-line format
* add patch 'spi: dt-bindings: document zero value for spi-{rx,tx}-bus-width properties'

 include/linux/spi/spi.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index aa09fdc8042d..66c7d8e45563 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -165,27 +165,27 @@ struct spi_device {
 	u8			bits_per_word;
 	bool			rt;
 	u32			mode;
-#define	SPI_CPHA	0x01			/* clock phase */
-#define	SPI_CPOL	0x02			/* clock polarity */
+#define	SPI_CPHA	BIT(0)			/* clock phase */
+#define	SPI_CPOL	BIT(1)			/* clock polarity */
 #define	SPI_MODE_0	(0|0)			/* (original MicroWire) */
 #define	SPI_MODE_1	(0|SPI_CPHA)
 #define	SPI_MODE_2	(SPI_CPOL|0)
 #define	SPI_MODE_3	(SPI_CPOL|SPI_CPHA)
 #define	SPI_MODE_X_MASK	(SPI_CPOL|SPI_CPHA)
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
+#define	SPI_CS_HIGH	BIT(2)			/* chipselect active high? */
+#define	SPI_LSB_FIRST	BIT(3)			/* per-word bits-on-wire */
+#define	SPI_3WIRE	BIT(4)			/* SI/SO signals shared */
+#define	SPI_LOOP	BIT(5)			/* loopback mode */
+#define	SPI_NO_CS	BIT(6)			/* 1 dev/bus, no chipselect */
+#define	SPI_READY	BIT(7)			/* slave pulls low to pause */
+#define	SPI_TX_DUAL	BIT(8)			/* transmit with 2 wires */
+#define	SPI_TX_QUAD	BIT(9)			/* transmit with 4 wires */
+#define	SPI_RX_DUAL	BIT(10)			/* receive with 2 wires */
+#define	SPI_RX_QUAD	BIT(11)			/* receive with 4 wires */
+#define	SPI_CS_WORD	BIT(12)			/* toggle cs after each word */
+#define	SPI_TX_OCTAL	BIT(13)			/* transmit with 8 wires */
+#define	SPI_RX_OCTAL	BIT(14)			/* receive with 8 wires */
+#define	SPI_3WIRE_HIZ	BIT(15)			/* high impedance turnaround */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.17.1

