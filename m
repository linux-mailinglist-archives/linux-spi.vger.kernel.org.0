Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A4327F1B7
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 20:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgI3Szy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 14:55:54 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:41606 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgI3Szy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 14:55:54 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id EFB6F803071D;
        Wed, 30 Sep 2020 18:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KIYZrphVg8Kk; Wed, 30 Sep 2020 21:55:50 +0300 (MSK)
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
Subject: [PATCH v2 01/21] spi: dw: Use an explicit set_cs assignment
Date:   Wed, 30 Sep 2020 21:55:25 +0300
Message-ID: <20200930185545.29959-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
References: <20200930185545.29959-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Simplify the dw_spi_add_host() method a bit by replacing the currently
implemented default set_cs callback setting up and later having it
overwritten by a custom function with direct if-else-based callback
assignment.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

Changelog v2:
- Replace the ternary operator with the if-else statement.
---
 drivers/spi/spi-dw-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index d8e92f53e2bc..3a7fdca8d335 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -477,7 +477,10 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->num_chipselect = dws->num_cs;
 	master->setup = dw_spi_setup;
 	master->cleanup = dw_spi_cleanup;
-	master->set_cs = dw_spi_set_cs;
+	if (dws->set_cs)
+		master->set_cs = dws->set_cs;
+	else
+		master->set_cs = dw_spi_set_cs;
 	master->transfer_one = dw_spi_transfer_one;
 	master->handle_err = dw_spi_handle_err;
 	master->max_speed_hz = dws->max_freq;
@@ -486,9 +489,6 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
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

