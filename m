Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CB81772D4
	for <lists+linux-spi@lfdr.de>; Tue,  3 Mar 2020 10:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgCCJpa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Mar 2020 04:45:30 -0500
Received: from xavier.telenet-ops.be ([195.130.132.52]:52824 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgCCJpa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Mar 2020 04:45:30 -0500
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id 9llT2200a5USYZQ01llTh5; Tue, 03 Mar 2020 10:45:28 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j947D-0006hy-RK; Tue, 03 Mar 2020 10:45:27 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j947D-00062h-P6; Tue, 03 Mar 2020 10:45:27 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] spi: dt-bindings: spi-controller: Fix #address-cells for slave mode
Date:   Tue,  3 Mar 2020 10:45:21 +0100
Message-Id: <20200303094522.23180-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200303094522.23180-1-geert+renesas@glider.be>
References: <20200303094522.23180-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently, the DT bindings for an SPI controller specify that
"#address-cells" must be fixed to one.  However, that applies to an SPI
controller in master mode only.  When running in SPI slave mode,
"#address-cells" should be zero.

Fix this making the value of "#address-cells" dependent on the presence
of "spi-slave".

Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Use "enum: [0, 1]" instead of min/max limit,
  - use "- spi-slave" instead of "[ spi-slave ]".

As of dtc commit 403cc79f06a135ae ("checks: Update SPI bus check for
'spi-slave'") and Linux commit c2e7075ca8303631 ("scripts/dtc: Update to
upstream version v1.4.7-57-gf267e674d145"), dtc knows about SPI slave.

However, when using "#address-cells = <0>" with W=1:

    Warning (avoid_unnecessary_addr_size): /soc/spi@e6e10000: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Just removing #address-cells (using /delete-property/ in the board DTS)
to fix this warning causes:

    Warning (spi_bus_bridge): /soc/spi@e6e10000: incorrect #address-cells for SPI bus

as spi_bus_bridge() uses node_addr_cells(), which defaults to 2 (due to
dtc's ppc64 heritage? But node_size_cells() defaults to 1, not 2?).

How should this be fixed?
Should "#address-cells = <0>" be left out or not?
Should node_{addr,size}_cells() in dtc default to zero?

Thanks!
---
 .../devicetree/bindings/spi/spi-controller.yaml    | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1e0ca6ccf64bbd0a..401d41a97562dc8d 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -20,7 +20,7 @@ properties:
     pattern: "^spi(@.*|-[0-9a-f])*$"
 
   "#address-cells":
-    const: 1
+    enum: [0, 1]
 
   "#size-cells":
     const: 0
@@ -52,6 +52,18 @@ properties:
     description:
       The SPI controller acts as a slave, instead of a master.
 
+if:
+  required:
+    - spi-slave
+then:
+  properties:
+    "#address-cells":
+      const: 0
+else:
+  properties:
+    "#address-cells":
+      const: 1
+
 patternProperties:
   "^slave$":
     type: object
-- 
2.17.1

