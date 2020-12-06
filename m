Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC082D0014
	for <lists+linux-spi@lfdr.de>; Sun,  6 Dec 2020 02:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgLFBUt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 5 Dec 2020 20:20:49 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:35643 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLFBUt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 5 Dec 2020 20:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607218820; x=1638754820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUFns0ZQm6ox08bIyStAPeZebNJokqWZzdgTWJBkH6w=;
  b=T1GrqXZ0ttokYT5b0iLgGAzY1dLYVaYNvwlK3LR8mGh5jIk6mebQpmG2
   REkKpk+RQWR3Zaar9J575tYj7oCW6LYADXs+++cbTEupoi4aroyktnWrG
   xB2aNNQJvWMb7tSoBJIpOJEOPAL3cC2nEH5Rr2ri7Jlg00jh1+yLEp8Jc
   hLko4vjqFbWVGkby/CsJFp6thL8twd/uD3ns0Ue1SJ/jISg1kQoyqozOw
   bSZuzgd5LjQIpqvB14Suaf5UiSu1RRI7gxCkUeTF9aQBAVFNgrd0u2e+5
   PgRfduJDOqNgvWXdmhaVHKp7rtH26JOuf1cak/h+3UzLmBhnyGOv+pPtB
   g==;
IronPort-SDR: Xvl+jzFNmQ1BhSDjoBxWZdYhWOrIO0Y5leckQskfZYiA4+7LIGLOihX6Y86Xrljbs2X7q4ytPo
 R+qudSrtd0lrrCg+ff2BOODx+D8zQVA5RfszzXkIcweXh5j8G4wS1Xn6EGM2/Ecq8VUScIa73O
 YAIMfdTCByNzp5BNt+AkiUSfnZHw8Y4dT52tsVuusbu2+rd61m/dVQngU5CxLjx1dlrPmXLljE
 E/V2smkT9EJExcX/Vdh6MGpZwcevu1SAThCkpAYZBck3zYOUCQ1pGFfTE883hlFgPIb4ru5WlG
 QME=
X-IronPort-AV: E=Sophos;i="5.78,396,1599494400"; 
   d="scan'208";a="258231905"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2020 09:36:44 +0800
IronPort-SDR: VHqc6V4J5mKOzVaT0nfeV62jmeRMy/S6E8Rw2cjh48KsVili7ATpBALB5tfKRZq7QuPgkfZzHa
 2y728DYB5KwstQ8+TZNJDQ5d2sizwvfOc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2020 17:02:29 -0800
IronPort-SDR: iuWzoU0omr+w0WQH3pDr3M7C60JKNycOEC1/dNQb4ANbT3xn8NsPY451TXb5NdMjeCwodITQkg
 3VMgVaMMzETw==
WDCIronportException: Internal
Received: from cnf005296.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.167])
  by uls-op-cesaip02.wdc.com with ESMTP; 05 Dec 2020 17:18:24 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v3 3/3] spi: dw: Add support for the Canaan K210 SoC SPI
Date:   Sun,  6 Dec 2020 10:18:17 +0900
Message-Id: <20201206011817.11700-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201206011817.11700-1-damien.lemoal@wdc.com>
References: <20201206011817.11700-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Canaan Kendryte K210 RISC-V SoC includes a DW apb_ssi v4 controller
which is documented to have a 32 words deep TX and RX FIFO. The FIFO
length detection in spi_hw_init() correctly detects this value.
However, when the controller RX FIFO is filled up to 32 entries
(RXFLR = 32), an RX FIFO overrun error occurs. This likely due to a
hardware bug which can be avoided by force setting the fifo_len field of
struct dw_spi to 31.

Define the dw_spi_canaan_k210_init() function to force set fifo_len to
31 when the device node compatible string is "canaan,k210-spi".

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Acked-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/spi/spi-dw-mmio.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index d0cc5bf4fa4e..17c06039a74d 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -222,6 +222,21 @@ static int dw_spi_keembay_init(struct platform_device *pdev,
 	return 0;
 }
 
+static int dw_spi_canaan_k210_init(struct platform_device *pdev,
+				   struct dw_spi_mmio *dwsmmio)
+{
+	/*
+	 * The Canaan Kendryte K210 SoC DW apb_ssi v4 spi controller is
+	 * documented to have a 32 word deep TX and RX FIFO, which
+	 * spi_hw_init() detects. However, when the RX FIFO is filled up to
+	 * 32 entries (RXFLR = 32), an RX FIFO overrun error occurs. Avoid this
+	 * problem by force setting fifo_len to 31.
+	 */
+	dwsmmio->dws.fifo_len = 31;
+
+	return 0;
+}
+
 static int dw_spi_mmio_probe(struct platform_device *pdev)
 {
 	int (*init_func)(struct platform_device *pdev,
@@ -335,6 +350,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
 	{ .compatible = "snps,dwc-ssi-1.01a", .data = dw_spi_dwc_ssi_init},
 	{ .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
 	{ .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
+	{ .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
 	{ /* end of table */}
 };
 MODULE_DEVICE_TABLE(of, dw_spi_mmio_of_match);
-- 
2.28.0

