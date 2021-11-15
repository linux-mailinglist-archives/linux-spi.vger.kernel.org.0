Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B4452506
	for <lists+linux-spi@lfdr.de>; Tue, 16 Nov 2021 02:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357842AbhKPBq1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Nov 2021 20:46:27 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:45074 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbhKOSYY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Nov 2021 13:24:24 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
Authentication-Results: mail.baikalelectronics.ru; dkim=permerror (bad message/signature format)
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nandhini Srikandan <nandhini.srikandan@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/7] spi: dw: Discard redundant DW SSI Frame Formats enumeration
Date:   Mon, 15 Nov 2021 21:19:12 +0300
Message-ID: <20211115181917.7521-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
References: <20211115181917.7521-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The dw_ssi_type enumeration describes the SPI frame formats the controller
supports, like Motorola SPI, Texas Instruments SSP and National
Semiconductors Microwire, that is the serial protocol utilized for the
SPI-transfers. Depending on the DW SSI IP-core configuration the protocol
could be either fixed or selectable. If it is changebale the protocol can
be selected by means of the CTRL0.FRF field, which possible values encoded
by the dw_ssi_type enumeration.  Aside with the denoted enum the field
values are also described by a set of SPI_FRF_{SPI,SSP,MICROWIRE} macros.
Thus currently the DW SPI driver has got two entities describing the same
data. Let's get rid of the enumeration one then, since first it hasn't
been used as enumeration-type but merely as a parametrized values set and
second that would unify the macro-based CSR read/write interface of the
driver. While at it convert the macro names to be more descriptive about
the protocols they represent.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/spi/spi-dw-core.c |  4 ++--
 drivers/spi/spi-dw.h      | 12 +++---------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index a14940403ab4..da6100fd185f 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -273,7 +273,7 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 
 	if (!(dws->caps & DW_SPI_CAP_DWC_SSI)) {
 		/* CTRLR0[ 5: 4] Frame Format */
-		cr0 |= SSI_MOTO_SPI << SPI_FRF_OFFSET;
+		cr0 |= SPI_FRF_MOTO_SPI << SPI_FRF_OFFSET;
 
 		/*
 		 * SPI mode (SCPOL|SCPH)
@@ -287,7 +287,7 @@ static u32 dw_spi_prepare_cr0(struct dw_spi *dws, struct spi_device *spi)
 		cr0 |= ((spi->mode & SPI_LOOP) ? 1 : 0) << SPI_SRL_OFFSET;
 	} else {
 		/* CTRLR0[ 7: 6] Frame Format */
-		cr0 |= SSI_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
+		cr0 |= SPI_FRF_MOTO_SPI << DWC_SSI_CTRLR0_FRF_OFFSET;
 
 		/*
 		 * SPI mode (SCPOL|SCPH)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index b665e040862c..467c342bfe56 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -46,9 +46,9 @@
 #define SPI_DFS32_OFFSET		16
 
 #define SPI_FRF_OFFSET			4
-#define SPI_FRF_SPI			0x0
-#define SPI_FRF_SSP			0x1
-#define SPI_FRF_MICROWIRE		0x2
+#define SPI_FRF_MOTO_SPI		0x0
+#define SPI_FRF_TI_SSP			0x1
+#define SPI_FRF_NS_MICROWIRE		0x2
 #define SPI_FRF_RESV			0x3
 
 #define SPI_MODE_OFFSET			6
@@ -114,12 +114,6 @@
 #define SPI_GET_BYTE(_val, _idx) \
 	((_val) >> (BITS_PER_BYTE * (_idx)) & 0xff)
 
-enum dw_ssi_type {
-	SSI_MOTO_SPI = 0,
-	SSI_TI_SSP,
-	SSI_NS_MICROWIRE,
-};
-
 /* DW SPI capabilities */
 #define DW_SPI_CAP_CS_OVERRIDE		BIT(0)
 #define DW_SPI_CAP_KEEMBAY_MST		BIT(1)
-- 
2.33.0

