Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD34A28D1C0
	for <lists+linux-spi@lfdr.de>; Tue, 13 Oct 2020 18:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389171AbgJMQJQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 13 Oct 2020 12:09:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731455AbgJMQJP (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 13 Oct 2020 12:09:15 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D9044DF491D456F3C172;
        Wed, 14 Oct 2020 00:09:06 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.134) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Wed, 14 Oct 2020 00:09:00 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 3/6] spi: dt-bindings: spi-controller: explicitly require #address-cells=<0> for slave mode
Date:   Wed, 14 Oct 2020 00:08:42 +0800
Message-ID: <20201013160845.1772-4-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20201013160845.1772-1-thunder.leizhen@huawei.com>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.134]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

scripts/dtc/checks.c:
if (get_property(node, "spi-slave"))
	spi_addr_cells = 0;
if (node_addr_cells(node) != spi_addr_cells)
	FAIL(c, dti, node, "incorrect #address-cells for SPI bus");
if (node_size_cells(node) != 0)
	FAIL(c, dti, node, "incorrect #size-cells for SPI bus");

The above code in check_spi_bus_bridge() require that the number of address
cells must be 0. So we should explicitly declare "#address-cells = <0>".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 .../devicetree/bindings/spi/spi-controller.yaml      | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 2b154803b181c8b..1b56d5e40f1fcde 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -20,7 +20,7 @@ properties:
     pattern: "^spi(@.*|-[0-9a-f])*$"
 
   "#address-cells":
-    const: 1
+    enum: [0, 1]
 
   "#size-cells":
     const: 0
@@ -52,11 +52,19 @@ properties:
     description:
       The SPI controller acts as a slave, instead of a master.
 
-oneOf:
-  - required:
-      - "#address-cells"
-  - required:
-      - spi-slave
+allOf:
+  - if:
+      not:
+        required:
+          - spi-slave
+    then:
+      properties:
+        "#address-cells":
+          const: 1
+    else:
+      properties:
+        "#address-cells":
+          const: 0
 
 patternProperties:
   "^slave$":
-- 
1.8.3


