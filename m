Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6ABD221B6B
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 06:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgGPEbs (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 00:31:48 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:32371 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgGPEbr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Jul 2020 00:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594873907; x=1626409907;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u+UB9c28my/DDQhUKy4DZyEP/giRSm6BeHWpq5Nj6ds=;
  b=X6LXV0/+oIEh1VWHjHjEuCZVzm8fu5VXgmGga1ralGeQzWw43ih8aEqS
   5gioX74PTla68Ufv/9ZApe1U60WyjKpazcZIULaHlzKhwMaHfwyZQZTFa
   bx2vgkeradvjL5AjEWEZqERbcKIxhqkgrKc+xAgc7kw+bj0LYCy/+KZuG
   z/YdTshjkw5UK8iOeQxdnn+cwZGvyrdrmO5+/o+fsZ/tvAbWEt4ooamZY
   lLbLBtFJE0aQbraU72QIhz84/cPLvmxgq/8UxuMxW0Rx+O7nGlLoKKezY
   yylVWVxZzxrDJ+Sl0L45wfiRSBXVXMyh/tAXGRolipaOF1mjWrS0teiob
   g==;
IronPort-SDR: O/HUM1gCYSMxNiQL1Ba8SPvBO0P+mvVTHRMzYP2Yj8KNZidyLgwy6FmadsSOSrBqBfsvN30C3G
 NsJpOCB8bS0zksVXHwjkaLncvkxKZRwI/Gwq8g12yyJAbxQncoVWiibYl/T6HiF/N74+SJkL4u
 iONmueXp6vuJQZXeYsp0E7XRV/UfPbeA1quObVVqJ2ykm0MDHmnsCpXExT/KnizVF3TwCPGMjz
 8ukBOpAcXF202CrPdb/n72hF3sk9T3bfBd5346xfFrXnDHHnJLLTkVtiHivVP63n8Fb7x06lmx
 GZw=
X-IronPort-AV: E=Sophos;i="5.75,358,1589266800"; 
   d="scan'208";a="19379601"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 21:31:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 21:31:46 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 15 Jul 2020 21:31:11 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH] spi: atmel-quadspi: Use optimezed memcpy_fromio()/memcpy_toio()
Date:   Thu, 16 Jul 2020 07:31:39 +0300
Message-ID: <20200716043139.565734-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Optimezed mem*io operations are defined for LE platforms, use them.

The ARM and !ARCH_EBSA110 dependencies for COMPILE_TEST were added
only for the _memcpy_fromio()/_memcpy_toio() functions. Drop these
dependencies.

Tested unaligned accesses on both sama5d2 and sam9x60 QSPI controllers
using SPI NOR flashes, everything works ok. The following performance
improvement can be seen when running mtd_speedtest:

sama5d2_xplained (mx25l25635e)
- before:
	mtd_speedtest: eraseblock write speed is 983 KiB/s
	mtd_speedtest: eraseblock read speed is 6150 KiB/s
- after:
	mtd_speedtest: eraseblock write speed is 1055 KiB/s
	mtd_speedtest: eraseblock read speed is 20144 KiB/s

sam9x60ek (sst26vf064b)
- before:
	mtd_speedtest: eraseblock write speed is 4770 KiB/s
	mtd_speedtest: eraseblock read speed is 8062 KiB/s
- after:
	mtd_speedtest: eraseblock write speed is 4524 KiB/s
	mtd_speedtest: eraseblock read speed is 21186 KiB/s

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/spi/Kconfig         | 2 +-
 drivers/spi/atmel-quadspi.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fd64c865f6ef..b89d03a36cbd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -103,7 +103,7 @@ config SPI_AT91_USART
 
 config SPI_ATMEL_QUADSPI
 	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || (ARM && COMPILE_TEST && !ARCH_EBSA110)
+	depends on ARCH_AT91 || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index a898755fb41e..8c009c175f2c 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -430,11 +430,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 
 		/* Send/Receive data */
 		if (op->data.dir == SPI_MEM_DATA_IN)
-			_memcpy_fromio(op->data.buf.in, aq->mem + offset,
-				       op->data.nbytes);
+			memcpy_fromio(op->data.buf.in, aq->mem + offset,
+				      op->data.nbytes);
 		else
-			_memcpy_toio(aq->mem + offset, op->data.buf.out,
-				     op->data.nbytes);
+			memcpy_toio(aq->mem + offset, op->data.buf.out,
+				    op->data.nbytes);
 
 		/* Release the chip-select */
 		atmel_qspi_write(QSPI_CR_LASTXFER, aq, QSPI_CR);
-- 
2.25.1

