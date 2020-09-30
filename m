Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B3C27F1F0
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgI3S5A (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:57:00 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41714 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730296AbgI3S4F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:56:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 9756B803016F;
        Wed, 30 Sep 2020 18:55:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o4aZ5pctNe7c; Wed, 30 Sep 2020 21:55:59 +0300 (MSK)
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
Subject: [PATCH v2 13/21] spi: dw: De-assert chip-select on reset
Date:   Wed, 30 Sep 2020 21:55:37 +0300
Message-ID: <20200930185545.29959-14-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

SPI memory operations implementation will require to have the CS register
cleared before executing the operation in order not to have the
transmission automatically started prior the Tx FIFO is pre-initialized.
Let's clear the register then on explicit controller reset to fulfil the
requirements in case of an error or having the CS left set by a bootloader
or another software.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index cfc9f63acde4..eb1d46983319 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -237,15 +237,16 @@ static inline void spi_umask_intr(struct dw_spi *dws, u32 mask)
 }
 
 /*
- * This disables the SPI controller, interrupts, clears the interrupts status,
- * and re-enable the controller back. Transmit and receive FIFO buffers are
- * cleared when the device is disabled.
+ * This disables the SPI controller, interrupts, clears the interrupts status
+ * and CS, then re-enables the controller back. Transmit and receive FIFO
+ * buffers are cleared when the device is disabled.
  */
 static inline void spi_reset_chip(struct dw_spi *dws)
 {
 	spi_enable_chip(dws, 0);
 	spi_mask_intr(dws, 0xff);
 	dw_readl(dws, DW_SPI_ICR);
+	dw_writel(dws, DW_SPI_SER, 0);
 	spi_enable_chip(dws, 1);
 }
 
-- 
2.27.0

