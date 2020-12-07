Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9268A2D1303
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 15:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgLGOBz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 09:01:55 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:4587 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgLGOBy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 09:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607349714; x=1638885714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eeY1Cu1aRr4raFHWenqciKug7r63tyMvIkoHojS1q4Y=;
  b=DR+iNgh3h6r0Jq4td2N8R+LqLZ81pJPcMtBpaAzXebgwArgqhdlH/qIs
   01Vn8412vmXGDONczxIt6Nu1SuufXXQNQv/PoITVo+CL158vV+4q0VA1/
   gH3GJHf+YwNIHytypca7vorrAoJkpfuwS7+IJkx+DG8xB648Wmn+SCYlF
   8hkmP/vbZlDwqcwBtzY2Kil3+47vnpn8YRpmNY5ppTSqKJLOyxrup8M2b
   iaMfvjPHJrgRwgAOQyBCSY3ts2FIAhDrMgu+wT0LE6pLdCzLBWeXtsYdl
   asRuZhzuvGhMRQpP2ZlbauPwYnklAsEV5/eX/Tm00s8NabwGxzc2j4PjE
   A==;
IronPort-SDR: 2farel37RSxeDW+4apm/Dd357J901m99jMAViQJ00OL9CRQXVWb2Lr5oghYV9q81a5oOW8x4Db
 pjXGhdfiJ03nM7Wu9QZ1CqQI3yCHeSL0kFzbxsOBuJIXnOKwilRN/MgIIZnC17vHi+9OoMpkMH
 uuH9oUnKZjw+oU7bruFVHkA5dRzJlEhH63gHEUEWtA4UEweUukiprqpAwkSrg9KRLDHtxNc76V
 gvra2bQ2cVYCKMaKU4AiZQT712ueMaFROCCm671piT9s504gHQdWn0LECWDzIM2wIpMnE7392U
 SBc=
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="101740189"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2020 07:00:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 07:00:47 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 7 Dec 2020 07:00:45 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 4/4] spi: atmel-quadspi: Move common code outside of if else
Date:   Mon, 7 Dec 2020 15:59:59 +0200
Message-ID: <20201207135959.154124-5-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207135959.154124-1-tudor.ambarus@microchip.com>
References: <20201207135959.154124-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

QSPI_IFR is set as the last QSPI Instruction Frame register
regardless of the sama5d2 or sam9x60 version of the IP. Move
the writing of QSPI_IFR outside of the IP specific code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 5fd0dc70bd74..f4f3d5c9ce50 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -394,15 +394,15 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 			atmel_qspi_write(icr, aq, QSPI_RICR);
 		else
 			atmel_qspi_write(icr, aq, QSPI_WICR);
-		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	} else {
 		if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT)
 			ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
 
 		atmel_qspi_write(icr, aq, QSPI_ICR);
-		atmel_qspi_write(ifr, aq, QSPI_IFR);
 	}
 
+	atmel_qspi_write(ifr, aq, QSPI_IFR);
+
 	return 0;
 }
 
-- 
2.25.1

