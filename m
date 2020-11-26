Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03632C4D08
	for <lists+linux-spi@lfdr.de>; Thu, 26 Nov 2020 03:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732332AbgKZCAz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Nov 2020 21:00:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17443 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732204AbgKZCAz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Nov 2020 21:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606356054; x=1637892054;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FUFns0ZQm6ox08bIyStAPeZebNJokqWZzdgTWJBkH6w=;
  b=MNTjtYrQMv6CoTSRAdldsDrcxPUKD0NSXUCRTC3bI3iGCUZODfVFjAHq
   DtCf7ko5DA5AHScYIV54J/AsDw1Ser4NnfdtE4nV1NBP8gGmZczvU1eIi
   vruFKKyCt7U1+liccrmwWoqiCNCV562HqSizyqBevYQCJmIW1Y4XlfZzQ
   K8XGP6U5wYw7g1c1akTNT/a3N1HuZQSIewOp1rjdzyu46MWmRdeQdMER8
   /sKYagqpRH0fylpHn2DXrUEuzPDI06Auv2cTqxAG8JQTP7VI77dgtAs93
   754cF/yLuRIvQ6hJAxPBFGn3zuegViqE7DgHH2sUcKTFQvwIR2C82VljX
   g==;
IronPort-SDR: 8FXI9w4CFsGrQIj5n5kCUpXp3IfVW+gQT4ntieL3LNEMBnoHm5EhIUEIs5u8mM8P7goTpEVNKb
 UMHHNc5ggOFqe+MqnvCidxc6ULMRwOBaJAQaFelGohLhMHzAQlfcbets1/9PNZYNpH5iskn194
 NYHL20n8kWsH9ibAM3u0jf30Rm9bBqcbfgnrV1bf/GngmV9sdO+KmfnhiFFVExLHF8VttqUdVC
 BOwKxB6VOqNsy6EiQBL0JEjAhVdcGbZlLuMDdXggIUbb/PTeFTjYMuEu1aRXusdlYkBBJ3MIxh
 Kd8=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; 
   d="scan'208";a="157980297"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 10:00:54 +0800
IronPort-SDR: 5fC1pKNJ8aDkN7dSNqj3YOuMhd9TTqhcx74Lq655xjfeIT0n60wJ8UqzLwFBjpUhovouDT+I3z
 l9gjEP6Ym7RhJpIInd7W2fSklJSW8eDHU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2020 17:46:37 -0800
IronPort-SDR: ODSIuWrDP3/zSNT8TTLI8jX6JpHpYCuofm/0eEltZoDJNQeBhFGiRl3DA+4pVaSV/L6BJE4D2m
 1ByJpF1LEPrg==
WDCIronportException: Internal
Received: from 57m2vf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.135])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Nov 2020 18:00:53 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 2/3] spi: dw: Add support for the Canaan K210 SoC SPI
Date:   Thu, 26 Nov 2020 11:00:48 +0900
Message-Id: <20201126020049.35712-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201126020049.35712-1-damien.lemoal@wdc.com>
References: <20201126020049.35712-1-damien.lemoal@wdc.com>
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

