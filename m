Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE5281D85
	for <lists+linux-spi@lfdr.de>; Fri,  2 Oct 2020 23:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725379AbgJBVRq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 2 Oct 2020 17:17:46 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52714 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBVRq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 2 Oct 2020 17:17:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 6D85C803017F;
        Fri,  2 Oct 2020 21:17:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JR-U62x2q688; Sat,  3 Oct 2020 00:17:42 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Jean-Hugues Deschenes <jean-hugues.deschenes@octasic.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        <linux-spi@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add maintainer of DW APB SSI driver
Date:   Sat, 3 Oct 2020 00:16:47 +0300
Message-ID: <20201002211648.24320-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add myself as a maintainer of the Synopsis DesignWare APB SSI driver.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Link: https://lore.kernel.org/linux-spi/20201001222829.15977-1-Sergey.Semin@baikalelectronics.ru/
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b19ce5..308a0843ec3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16727,6 +16727,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/snps,dw-apb-gpio.yaml
 F:	drivers/gpio/gpio-dwapb.c
 
+SYNOPSYS DESIGNWARE APB SSI DRIVER
+M:	Serge Semin <fancer.lancer@gmail.com>
+L:	linux-spi@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+F:	drivers/spi/spi-dw*
+
 SYNOPSYS DESIGNWARE AXI DMAC DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
 S:	Maintained
-- 
2.27.0

