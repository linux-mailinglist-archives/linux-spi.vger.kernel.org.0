Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2C92D1305
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 15:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgLGOCX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 09:02:23 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:64961 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLGOCX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 09:02:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607349743; x=1638885743;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EZu7eRgTCyJ0MdARgyamRkTg/cOik+X698PnPvls7qg=;
  b=kOBcuT79cXR4dy9jkN6wx/TFP2s2G0pb8gRMWL6g42+rI+Ih3LS+AvOh
   5yNpgIo6nIDHUsYeQfZMFSSS1aCxdtqDaXO6zyhGg01QJnS1he/GNU184
   D/0g1Ej/JXtLDkDjrZnI0486Zs3QQwj81ufA6EgJ/hNGPzF/njAkHodG9
   dmBuOMnoVrKpfA02cEb+xqcxjtOL9WX2ZxEF2I4esu2jfAkdOCeHTPP6P
   HHdH6g+tANfEGfXbAAXt5tnMyvZsfE6P6IyY2koq0Xu/BRiTXiIMj7L/s
   vOONIJlKTGgS5HvO9PXA2ynTn5zfPsMGQdEc2MWQzRT7NR6RWDxs0cZ2I
   g==;
IronPort-SDR: zqbibeXiu4l+V1rijRuK1HqjUf38CHsMWsZW9xBt8VoPp5RjDUjAgZdQcrJZGvpULurKaBtSoR
 rxZ4eRIk4DJH806JFPdPTeBO32W477ncSLh/qy4x2ZgtwIgrq+A7edcdv2eJLhT32+RqtGGSA/
 eMaoqguswWzrgBvBMZqUmbyQquRWtBBJ35+SlbUximFmoT8CCh7G0qAcaV4euQ4txQRjxX++1H
 LNYtZdjUf9paymw+GZCWQ/bOZVSmjfX5cNsixdH2Ep8ADJOlaRKF1x2naTwbUOXegHTC6J4nvG
 9Vw=
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="96128975"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2020 07:00:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 07:00:45 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 7 Dec 2020 07:00:42 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 3/4] spi: atmel-quadspi: Write QSPI_IAR only when needed
Date:   Mon, 7 Dec 2020 15:59:58 +0200
Message-ID: <20201207135959.154124-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207135959.154124-1-tudor.ambarus@microchip.com>
References: <20201207135959.154124-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The address must be written in QSPI_IAR only when we have
a instruction frame with address but no data.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 30533ab82c7b..5fd0dc70bd74 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -385,9 +385,11 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	/* Clear pending interrupts */
 	(void)atmel_qspi_read(aq, QSPI_SR);
 
-	if (aq->caps->has_ricr) {
-		/* Set QSPI Instruction Frame registers */
+	/* Set QSPI Instruction Frame registers. */
+	if (op->addr.nbytes && !op->data.nbytes)
 		atmel_qspi_write(iar, aq, QSPI_IAR);
+
+	if (aq->caps->has_ricr) {
 		if (op->data.dir == SPI_MEM_DATA_IN)
 			atmel_qspi_write(icr, aq, QSPI_RICR);
 		else
@@ -397,8 +399,6 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
 			ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
 
-		/* Set QSPI Instruction Frame registers */
-		atmel_qspi_write(iar, aq, QSPI_IAR);
 		atmel_qspi_write(icr, aq, QSPI_ICR);
 		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	}
-- 
2.25.1

