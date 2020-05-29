Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB78D1E73F3
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 05:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbgE2D7f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 May 2020 23:59:35 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:45288 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388507AbgE2D7e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 May 2020 23:59:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 8576B80307CB;
        Fri, 29 May 2020 03:59:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8ioC51rXFyd1; Fri, 29 May 2020 06:59:30 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 01/16] spi: dw: Set xfer effective_speed_hz
Date:   Fri, 29 May 2020 06:58:59 +0300
Message-ID: <20200529035915.20790-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Seeing DW APB SSI controller doesn't support setting the exactly
requested SPI bus frequency, but only a rounded frequency determined
by means of the odd-numbered half-worded reference clock divider,
it would be good tune the SPI core up and initialize the current
transfer effective_speed_hz. By doing so the core will be able to
execute the xfer-related delays with better accuracy.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: devicetree@vger.kernel.org
---
 drivers/spi/spi-dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 9d6904d30104..050cb2ea0812 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -352,6 +352,7 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 		spi_set_clk(dws, chip->clk_div);
 	}
 
+	transfer->effective_speed_hz = dws->max_freq / chip->clk_div;
 	dws->n_bytes = DIV_ROUND_UP(transfer->bits_per_word, BITS_PER_BYTE);
 
 	cr0 = dws->update_cr0(master, spi, transfer);
-- 
2.26.2

