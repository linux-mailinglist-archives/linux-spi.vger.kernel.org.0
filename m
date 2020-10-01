Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6225D280A33
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 00:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387476AbgJAW3q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Oct 2020 18:29:46 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:48242 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733258AbgJAW3D (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Oct 2020 18:29:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 43D92803086A;
        Thu,  1 Oct 2020 22:28:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mf0Lyd3Bxl2C; Fri,  2 Oct 2020 01:28:58 +0300 (MSK)
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
Subject: [PATCH v3 14/21] spi: dw: Explicitly de-assert CS on SPI transfer completion
Date:   Fri, 2 Oct 2020 01:28:22 +0300
Message-ID: <20201001222829.15977-15-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
References: <20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

By design of the currently available native set_cs callback, the CS
de-assertion will be done only if it's required by the corresponding
controller capability. But in order to pre-fill the Tx FIFO buffer with
data during the SPI memory ops execution the SER register needs to be left
cleared before that. We'll also need a way to explicitly set and clear the
corresponding CS bit at a certain moment of the operation. Let's alter
the set_cs function then to also de-activate the CS, when it's required.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index fca929280aab..a6f86314567f 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -100,7 +100,7 @@ void dw_spi_set_cs(struct spi_device *spi, bool enable)
 	 */
 	if (cs_high == enable)
 		dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
-	else if (dws->caps & DW_SPI_CAP_CS_OVERRIDE)
+	else
 		dw_writel(dws, DW_SPI_SER, 0);
 }
 EXPORT_SYMBOL_GPL(dw_spi_set_cs);
-- 
2.27.0

