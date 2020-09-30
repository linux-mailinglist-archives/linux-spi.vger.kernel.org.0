Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E70127F1CF
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgI3S4K (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:56:10 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41806 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730278AbgI3S4E (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:56:04 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 49753803017E;
        Wed, 30 Sep 2020 18:55:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qTgfpioVhnS0; Wed, 30 Sep 2020 21:55:57 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        "wuxu . wu" <wuxu.wu@huawei.com>, Feng Tang <feng.tang@intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 11/21] spi: dw: Unmask IRQs after enabling the chip
Date:   Wed, 30 Sep 2020 21:55:35 +0300
Message-ID: <20200930185545.29959-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It's theoretically erroneous to enable IRQ before the chip is turned on.
If IRQ handler gets executed before the chip is enabled, then any data
written to the Tx FIFO will be just ignored.

I say "theoretically" because we haven't noticed any problem with that,
but let's fix it anyway just in case...

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index db3fec4195f7..58a7c7465c61 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -376,8 +376,6 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 			spi_enable_chip(dws, 1);
 			return ret;
 		}
-	} else {
-		dw_spi_irq_setup(dws);
 	}
 
 	spi_enable_chip(dws, 1);
@@ -385,6 +383,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	if (dws->dma_mapped)
 		return dws->dma_ops->dma_transfer(dws, transfer);
 
+	dw_spi_irq_setup(dws);
+
 	return 1;
 }
 
-- 
2.27.0

