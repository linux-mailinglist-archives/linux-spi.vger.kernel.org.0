Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C6E2D12FD
	for <lists+linux-spi@lfdr.de>; Mon,  7 Dec 2020 15:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgLGOBt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 7 Dec 2020 09:01:49 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:12162 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgLGOBs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 7 Dec 2020 09:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607349708; x=1638885708;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gdsNLh0QMM1ZgYyE0TN1rD0dJrTxINGdj6nNAZ5seDs=;
  b=ss6/zTQXt1SDgrfEObB5Oxw35RmgHZDzwGkPArcGOj+/GTgPFbLgy2FT
   W/g8vLe80Q8mc5FjYvteY74rj02eoOJj6ITdwpFImm1d2t06zlQMH8GB2
   yyExavEJLlciSgNHM/g6o0JPKn3vY+9KdQHUVnidVxlZjt4OwNpOfZX9T
   tWzQMBt0YfvQb1pcJZJOzDS7iRnRLxQL1kL+eLfYE0bWZvkIaPmvhEt7f
   GN0gqwvxsLpTtWC34b+FKTas2fIv40SQ4HHZpaZuu1RfROsP6ZRDGPFnE
   eFLeLa/pCqHJ6GmLMLMBMKrt6fPaOGyqazbxbRxPqDfOlpr3OiM+fbON8
   Q==;
IronPort-SDR: T6AI5yvP6glTMvp/PxDsX+oQiD+0/tlne072VckwgZ5HAWroTHn6y7ZLZGl7tqlzpCt0Cj5OK4
 a+dPab0Y7lxQmqKsmsUknS0cnPDGFAAPUapVMlES0bFtACPHDXGN9ydQbbLbJk6vvHKCxf7+lM
 hduSdI7Ojm6eDM5hHivuWbaFg1V4UwfUqM46DwJbtHtFxynRfKD/vJ8xuekihg65V4GEChy/5k
 aPcLGjqwmpmzhhX0aFBQQSuRk2KzwFUpBBmVfUPg0Hvxhh4hOt9W/S9DSEm4UB6Aa7dmPF1J8i
 aX0=
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="106511691"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Dec 2020 07:00:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 7 Dec 2020 07:00:42 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 7 Dec 2020 07:00:39 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/4] spi: atmel-quadspi: Drop superfluous set of QSPI_IFR_APBTFRTYP_READ
Date:   Mon, 7 Dec 2020 15:59:57 +0200
Message-ID: <20201207135959.154124-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201207135959.154124-1-tudor.ambarus@microchip.com>
References: <20201207135959.154124-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

That bit describes the APB transfer type. We are writing
serial memory registers via AHB acesses, that bit does not
make sense in the current context.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ad913212426e..30533ab82c7b 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -386,9 +386,6 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	(void)atmel_qspi_read(aq, QSPI_SR);
 
 	if (aq->caps->has_ricr) {
-		if (!op->addr.nbytes && op->data.dir == SPI_MEM_DATA_IN)
-			ifr |= QSPI_IFR_APBTFRTYP_READ;
-
 		/* Set QSPI Instruction Frame registers */
 		atmel_qspi_write(iar, aq, QSPI_IAR);
 		if (op->data.dir == SPI_MEM_DATA_IN)
-- 
2.25.1

