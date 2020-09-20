Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C027139A
	for <lists+linux-spi@lfdr.de>; Sun, 20 Sep 2020 13:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgITL30 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 20 Sep 2020 07:29:26 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:53584 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgITL3Z (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 20 Sep 2020 07:29:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id AE7FD803073F;
        Sun, 20 Sep 2020 11:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Y2alu64bQ27; Sun, 20 Sep 2020 14:29:23 +0300 (MSK)
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
Subject: [PATCH 02/30] spi: dw: Use ternary op to init set_cs callback
Date:   Sun, 20 Sep 2020 14:28:46 +0300
Message-ID: <20200920112914.26501-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
References: <20200920112914.26501-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Simplify the dw_spi_add_host() method a bit by replacing the set_cs
callback overwrite procedure with direct setting the callback if a custom
version of one is specified.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/spi/spi-dw-core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 55afdcee7d2b..8b3ce5a0378a 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -482,7 +482,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
 	master->cleanup = dw_spi_cleanup;
-	master->set_cs = dw_spi_set_cs;
+	master->set_cs = dws->set_cs ?: dw_spi_set_cs;
 	master->transfer_one = dw_spi_transfer_one;
 	master->handle_err = dw_spi_handle_err;
 	master->max_speed_hz = dws->max_freq;
@@ -491,9 +491,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->flags = SPI_MASTER_GPIO_SS;
 	master->auto_runtime_pm = true;
 
-	if (dws->set_cs)
-		master->set_cs = dws->set_cs;
-
 	/* Get default rx sample delay */
 	device_property_read_u32(dev, "rx-sample-delay-ns",
 				 &dws->def_rx_sample_dly_ns);
-- 
2.27.0

