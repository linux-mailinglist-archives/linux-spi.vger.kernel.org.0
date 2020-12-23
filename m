Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3352E1B10
	for <lists+linux-spi@lfdr.de>; Wed, 23 Dec 2020 11:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgLWKjU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Dec 2020 05:39:20 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36874 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728435AbgLWKjU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 23 Dec 2020 05:39:20 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BNAaosh012360;
        Wed, 23 Dec 2020 02:38:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=ecB1b82UHxFJabhxjEwHrrJU3DyvqdCBvyEqX+SRark=;
 b=ZVWhW2S8iD5fAI6/TQljtamfDwcTUyyLM8oWGJyVwvZmOugrWjDXrGBUfzTyieebuaPA
 yL5c9z7UjYO3YwDaBSSqIrDyYSbKYRuHZHkorOma+D/Jl3sq5SXu61xPNePHtfaXgmUv
 XFiHKvn85eXg4wpNKbsCgk/i9lAVw+anyvEE3tyo8Os93ad+Cz1FXjV76A6jYwG5szYE
 nBhHqj9uYzXtfpAtr6fBdENEFQ2xeH7EaSa30q+xQz4PYTWHsezaHUEjgWBqSgqRQCuD
 hNQ3py0GsSxDt1+7Dm8H0yb/qf2VQjmMFPbwqe6hn7dpZ+te7HQgEyutDhZY+ClrQXdW bw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 35k0ebdw4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 02:38:38 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 23 Dec
 2020 02:38:37 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Dec 2020 02:38:38 -0800
Received: from vb-cavnet.porotchkin.lan (PT-LT0319.marvell.com [10.6.202.166])
        by maili.marvell.com (Postfix) with ESMTP id C7CF93F7040;
        Wed, 23 Dec 2020 02:38:35 -0800 (PST)
From:   <kostap@marvell.com>
To:     <linux-spi@vger.kernel.org>
CC:     <broonie@kernel.org>, <mw@semihalf.com>, <jaz@semihalf.com>,
        <nadavh@marvell.com>, <bpeled@marvell.com>, <stefanc@marvell.com>,
        "Konstantin Porotchkin" <kostap@marvell.com>
Subject: [PATCH v3 2/2] spi: orion: enable support for switching CS every transferred byte
Date:   Wed, 23 Dec 2020 12:38:27 +0200
Message-ID: <20201223103827.29721-3-kostap@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201223103827.29721-1-kostap@marvell.com>
References: <20201223103827.29721-1-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-23_04:2020-12-22,2020-12-23 signatures=0
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
 drivers/spi/spi-orion.c | 32 +++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 133727552e99..68ed7fd64256 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -375,8 +375,15 @@ orion_spi_write_read_8bit(struct spi_device *spi,
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
@@ -390,6 +397,11 @@ orion_spi_write_read_8bit(struct spi_device *spi,
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
@@ -397,6 +409,12 @@ orion_spi_write_read_8bit(struct spi_device *spi,
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
 
@@ -407,6 +425,11 @@ orion_spi_write_read_16bit(struct spi_device *spi,
 	void __iomem *tx_reg, *rx_reg, *int_reg;
 	struct orion_spi *orion_spi;
 
+	if (spi->mode & SPI_CS_WORD) {
+		dev_err(&spi->dev, "SPI_CS_WORD is only supported for 8 bit words\n");
+		return -1;
+	}
+
 	orion_spi = spi_master_get_devdata(spi->master);
 	tx_reg = spi_reg(orion_spi, ORION_SPI_DATA_OUT_REG);
 	rx_reg = spi_reg(orion_spi, ORION_SPI_DATA_IN_REG);
@@ -446,12 +469,13 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	orion_spi = spi_master_get_devdata(spi->master);
 
 	/*
-	 * Use SPI direct write mode if base address is available. Otherwise
-	 * fall back to PIO mode for this transfer.
+	 * Use SPI direct write mode if base address is available
+	 * and SPI_CS_WORD flag is not set.
+	 * Otherwise fall back to PIO mode for this transfer.
 	 */
 	vaddr = orion_spi->child[cs].direct_access.vaddr;
 
-	if (vaddr && xfer->tx_buf && word_len == 8) {
+	if (vaddr && xfer->tx_buf && word_len == 8 && (spi->mode & SPI_CS_WORD) == 0) {
 		unsigned int cnt = count / 4;
 		unsigned int rem = count % 4;
 
@@ -636,7 +660,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	}
 
 	/* we support all 4 SPI modes and LSB first option */
-	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST;
+	master->mode_bits = SPI_CPHA | SPI_CPOL | SPI_LSB_FIRST | SPI_CS_WORD;
 	master->set_cs = orion_spi_set_cs;
 	master->transfer_one = orion_spi_transfer_one;
 	master->num_chipselect = ORION_NUM_CHIPSELECTS;
-- 
2.17.1

