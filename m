Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0EA2AA35A
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgKGIOf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:14:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgKGIOe (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:14:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736874; x=1636272874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aCvWQLDyaSFYntB4Womc0e0j3CRsIntIfbuSiFLr4hA=;
  b=QshweGYemJGcT+KkzovV5Pwo18pjWZTCW8g3u1CTCEdIBWJC7EJAcDdg
   DAImK8qOXPy+gVlzduQkc0P9q05LXvxzjG0oC91IP3dwDUOEfUMFo0wnv
   K+1WjPuBDcfsDLiRltK1GvqpTuFlqClk+5WjN3nWs+NuTMcwsiFAyMc8Z
   dYPIekGvygw5Rq73diPfYPDa3bJQ+XpIXgOyWRXZ1c4OpWgOeFrHudKUh
   uXmFqJDDaKlcm65v2/liCIjD6yEbhvClZe8iFGkfiBfZd08yEJJqo6r7G
   1jH5hOzqc0YmU3jX9fwgBgTufIYiIbsmYFOC5hnM2dLWrBRH0rwDnyZeK
   Q==;
IronPort-SDR: a5Xd+Se+25c2QTbWar5nszM6hEg8bzpP7QZXiBmHiIX8kiPd3tTKK8VILkOLnvRC6WH7Z9Ojdb
 /T37LvV7XUa5v2L3OD+Ubs/1cKoWX3q74tTHcmeCaGxRwFXrB2EnNPOygoTlByNO021/t2gOH5
 QWuksXJOAZ+pFHjb2Rz80Flm+ZVkAOVCiKOuILn/x5aozS+OJni/exvdYmZxo5e1V6TrBbAkbo
 2dkqE1fMksvzGrA8JcF3LVYdv8OMgjjHIof13xLct5pjoZPchIoBgJ5hOImAvKntDhkBaxbNfg
 m7A=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564364"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:14:34 +0800
IronPort-SDR: KAErByTJHniAColHyFeX8orwtASriU/MKROjO/z33lDVn5RRdECdUm4qmn1NXcgK4VTu/G7TPV
 1DrFiinJCWe3OhCewJxavf7T+KqkyjRvANgYo93eR8u2SRzOAo2UhU18k1URgE46BBGzbaPHYj
 rsqIebwLqSTBxA0UyI6xJj5Hut/Bsavxt2wCUwPACNwu+Z2VE2OXfZR8XsPbLNDes/tzizo3XR
 jCR1Hob+BX5D06OIxeN4AHF8nDyuCoFIt+Jn9yHO8Q0tcm9aLQywPN5i1N7fYzAy+zmZQOC/DX
 qcA3xjArOwwbYAhEer/54hkA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 23:59:25 -0800
IronPort-SDR: xnMAOU5B9k8aXLtf1hpdfpBLHr6sZSOKvHHBazK2i2wFWcv7QRgwZDB5yRurYFkmsx6Ckwu05/
 WIME6Tf0b8tFqPDMJp7/bOJ2eMa/MWFmwTtlEgPFNFta0wWOqkFLFw+s9KUG4tiHjNQjPzfJzZ
 /Y+aqMbroxYK3YbaE0zZbN7MU/4qG8l2hqxL0GzsGZG88bgSljIGv2IlEe2BTxWw+VOgklowg5
 t4NjYuQ2n8DxVap/Y0ZPa9osrcuQ405tsfj9NtcR3I/JsJDarohMqN/7Ix0DY0jcQmIqLh7HX+
 nZg=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:14:32 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 04/32] spi: dw: Introduce polling device tree property
Date:   Sat,  7 Nov 2020 17:13:52 +0900
Message-Id: <20201107081420.60325-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With boards that have slow interrupts context switch, and a fast device
connected to a spi master, e.g. an SD card through mmc-spi, using
dw_spi_poll_transfer() intead of the regular interrupt based
dw_spi_transfer_handler() function is more efficient and can avoid a lot
of RX FIFO overflow errors while keeping the device SPI frequency
reasonnably high (for speed). Introduce the "polling" device tree
property to allow requesting polled processing of transfer depending on
the connected device while keeping the spi master interrupts property
unschanged. E.g. device trees such as:

Generic soc.dtsi dts:

spi0: spi@53000000 {
	#address-cells = <1>;
	#size-cells = <0>;
	compatible = "snps,dw-apb-ssi";
	reg = <0x53000000 0x100>;
	interrupts = <2>;
	...
}

Board specific dts:

...
&spi0 {
	polling;
	status = "okay";

	slot@0 {
		compatible = "mmc-spi-slot";
		reg = <0>;
		voltage-ranges = <3300 3300>;
		spi-max-frequency = <4000000>;
	};
}

will result in using polled transfers for the SD card while other boards
using spi0 for different peripherals can use interrupt based transfers
without needing to change the generic base soc dts.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/spi/spi-dw-mmio.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index d0cc5bf4fa4e..3f1bc384cb45 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -20,6 +20,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
+#include <linux/interrupt.h>
 
 #include "spi-dw.h"
 
@@ -246,9 +247,13 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 
 	dws->paddr = mem->start;
 
-	dws->irq = platform_get_irq(pdev, 0);
-	if (dws->irq < 0)
-		return dws->irq; /* -ENXIO */
+	if (device_property_read_bool(&pdev->dev, "polling")) {
+		dws->irq = IRQ_NOTCONNECTED;
+	} else {
+		dws->irq = platform_get_irq(pdev, 0);
+		if (dws->irq < 0)
+			return dws->irq; /* -ENXIO */
+	}
 
 	dwsmmio->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(dwsmmio->clk))
-- 
2.28.0

