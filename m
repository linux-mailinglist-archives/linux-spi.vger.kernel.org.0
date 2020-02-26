Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 671C216FAED
	for <lists+linux-spi@lfdr.de>; Wed, 26 Feb 2020 10:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBZJhh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 26 Feb 2020 04:37:37 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40056 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgBZJhh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 26 Feb 2020 04:37:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01Q9bHK2087084;
        Wed, 26 Feb 2020 03:37:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582709837;
        bh=/RvMu+KBpcqEDFVBnIWtjiFPQ2qCDkAs2AiQIuWdFws=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K6EPpPzRPSk4gsirOoI1fBp5truy0/o8R/d1P37k3XGPD9cbcVIhzmmEkU8XA4UO8
         XCt4AtdJCY4rouVI64SzqfNU6w30qSYbkkVpf11Yo8Xoyi855W2yZMYDaIwCCOGMQc
         wJ/3zOV6EfUHDvbLVapgTz2frUoo/TmTXEqezsNI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01Q9bHVR118717
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Feb 2020 03:37:17 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 26
 Feb 2020 03:37:17 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 26 Feb 2020 03:37:17 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01Q9b4A7110613;
        Wed, 26 Feb 2020 03:37:13 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 02/11] spi: set mode bits for "spi-rx-dtr" and "spi-tx-dtr"
Date:   Wed, 26 Feb 2020 15:06:54 +0530
Message-ID: <20200226093703.19765-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226093703.19765-1-p.yadav@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

These two DT properties express DTR receive and transmit capabilities of
a SPI flash and controller. Introduce two new mode bits: SPI_RX_DTR and
SPI_TX_DTR which correspond to the new DT properties. Set these bits
when the two corresponding properties are present in the device tree.
Also update the detection of unsupported mode bits to include the new
bits.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi.c       | 10 +++++++++-
 include/linux/spi/spi.h |  2 ++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 38b4c78df506..25c8ed9343f9 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1927,6 +1927,13 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
+	/* Device DTR mode. */
+	if (of_property_read_bool(nc, "spi-tx-dtr"))
+		spi->mode |= SPI_TX_DTR;
+
+	if (of_property_read_bool(nc, "spi-rx-dtr"))
+		spi->mode |= SPI_RX_DTR;
+
 	if (spi_controller_is_slave(ctlr)) {
 		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
@@ -3252,7 +3259,8 @@ int spi_setup(struct spi_device *spi)
 		bad_bits &= ~SPI_CS_HIGH;
 	ugly_bits = bad_bits &
 		    (SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL |
-		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL);
+		     SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+		     SPI_TX_DTR  | SPI_RX_DTR);
 	if (ugly_bits) {
 		dev_warn(&spi->dev,
 			 "setup: ignoring unsupported mode bits %x\n",
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 6d16ba01ff5a..bf1108318389 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -183,6 +183,8 @@ struct spi_device {
 #define	SPI_TX_OCTAL	0x2000			/* transmit with 8 wires */
 #define	SPI_RX_OCTAL	0x4000			/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ	0x8000			/* high impedance turnaround */
+#define SPI_RX_DTR	0x10000			/* receive in DTR mode */
+#define SPI_TX_DTR	0x20000			/* transmit in DTR mode */
 	int			irq;
 	void			*controller_state;
 	void			*controller_data;
-- 
2.25.0

