Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9307A3B7886
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jun 2021 21:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhF2TYx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Jun 2021 15:24:53 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:18093 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbhF2TYx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Jun 2021 15:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1624994545; x=1656530545;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=011jMQzbysLea9YNOltRP7IGOoLMvt8FHdPjNFU4fE0=;
  b=necM85yp3rmGOTd8H9XWSZQlhlnhZ4ipQMmb3LckBqBxBoFIr1wY3sIg
   ETAYIKb4HoNGOkDbd8W8QamfVPysr8+4+pa1/gkVsjudDg46Xg4YOWBwS
   OX57VBe8SigqL0F5Og0YIFUxTtUdywFG3+4fgH0mbKZK0Nd612m0d8ic9
   x6LBCBYiKpY+X1EQN6MMPHwAac6kJqt7mJ+cJzxHWdhA8IFYCMf7yD0UT
   gvrPjXEkXWFxcWgzSL8qRJwFznfAw9WGT+/RH2B6Y5xf/OtKh3MMmAxMO
   DHe7K0vWkXINjTcDsDgS+ZMOjNth3V70HjvCJREi/UhKjIdIX/+UaMIAl
   g==;
IronPort-SDR: DBOpz7FXL6edMGxWnX9XPIlSA9yx5+/DHh0kcAZIAHgUW2vl9Z4Uh/gArsTQn3sV/iiFIhCvEF
 fIWiElgi/o9WDLusI+OJI6IHr6nYtj8C4zXfHh8iLunuSc8Jhzq5+HPjnyuT4MElGdpJVKllz/
 tXZKmcVDfo6Ea/21d3bP9zSIXfYo9G1HyMo5TuhztsGmGeHWTDaZmTCJGByyIyoOWh80QkQOqa
 A8TNgjsfzCT0P+sx8H/lmI6dT4JdJiEMPm2GQSoQQX8z1B4kWuD2d1w8Ur1xbVQyr81BjzrQR3
 Ors=
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="133971297"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2021 12:22:24 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 29 Jun 2021 12:22:24 -0700
Received: from dan-linux.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 29 Jun 2021 12:22:24 -0700
From:   Dan Sneddon <dan.sneddon@microchip.com>
To:     Dan Sneddon <dan.sneddon@microchip.com>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v2] spi: atmel: Fix CS and initialization bug
Date:   Tue, 29 Jun 2021 12:22:18 -0700
Message-ID: <20210629192218.32125-1-dan.sneddon@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Commit 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer
method") switched to using transfer_one and set_cs.  The
core doesn't call set_cs when the chip select lines are gpios.  Add the
SPI_MASTER_GPIO_SS flag to the driver to ensure the calls to set_cs
happen since the driver programs configuration registers there.

Fixes: 5fa5e6dec762 ("spi: atmel: Switch to transfer_one transfer method")

Signed-off-by: Dan Sneddon <dan.sneddon@microchip.com>
---

Changes in v2:
- Updated commit message
- Dropped unnecessary change to enable variable in set_cs

 drivers/spi/spi-atmel.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 2ef74885ffa2..788dcdf25f00 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -352,8 +352,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 		}
 
 		mr = spi_readl(as, MR);
-		if (spi->cs_gpiod)
-			gpiod_set_value(spi->cs_gpiod, 1);
 	} else {
 		u32 cpol = (spi->mode & SPI_CPOL) ? SPI_BIT(CPOL) : 0;
 		int i;
@@ -369,8 +367,6 @@ static void cs_activate(struct atmel_spi *as, struct spi_device *spi)
 
 		mr = spi_readl(as, MR);
 		mr = SPI_BFINS(PCS, ~(1 << chip_select), mr);
-		if (spi->cs_gpiod)
-			gpiod_set_value(spi->cs_gpiod, 1);
 		spi_writel(as, MR, mr);
 	}
 
@@ -400,8 +396,6 @@ static void cs_deactivate(struct atmel_spi *as, struct spi_device *spi)
 
 	if (!spi->cs_gpiod)
 		spi_writel(as, CR, SPI_BIT(LASTXFER));
-	else
-		gpiod_set_value(spi->cs_gpiod, 0);
 }
 
 static void atmel_spi_lock(struct atmel_spi *as) __acquires(&as->lock)
@@ -1483,7 +1477,8 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	master->bus_num = pdev->id;
 	master->num_chipselect = 4;
 	master->setup = atmel_spi_setup;
-	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX);
+	master->flags = (SPI_MASTER_MUST_RX | SPI_MASTER_MUST_TX |
+			SPI_MASTER_GPIO_SS);
 	master->transfer_one = atmel_spi_one_transfer;
 	master->set_cs = atmel_spi_set_cs;
 	master->cleanup = atmel_spi_cleanup;
-- 
2.17.1

