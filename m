Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4854B17B899
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 09:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgCFIun (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 03:50:43 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:51384 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgCFIun (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Mar 2020 03:50:43 -0500
Received: from ramsan ([84.195.182.253])
        by baptiste.telenet-ops.be with bizsmtp
        id Awqg220095USYZQ01wqgQq; Fri, 06 Mar 2020 09:50:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jA8gq-0002XJ-9M; Fri, 06 Mar 2020 09:50:40 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jA8gq-00027c-5I; Fri, 06 Mar 2020 09:50:40 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 1/2] spi: dt-bindings: spi-controller: Fix #address-cells for slave mode
Date:   Fri,  6 Mar 2020 09:50:37 +0100
Message-Id: <20200306085038.8111-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200306085038.8111-1-geert+renesas@glider.be>
References: <20200306085038.8111-1-geert+renesas@glider.be>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Currently, the DT bindings for an SPI controller specify that
"#address-cells" must be fixed to one.  However, that applies to an SPI
controller in master mode only.  When running in SPI slave mode,
"#address-cells" should not be specified.

Fix this making "#address-cells" mutually-exclusive with "spi-slave".

Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - Make #address-cells mutually-exclusive with spi-slave,

v2:
  - Use "enum: [0, 1]" instead of min/max limit,
  - use "- spi-slave" instead of "[ spi-slave ]".
---
 Documentation/devicetree/bindings/spi/spi-controller.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1e0ca6ccf64bbd0a..0ebaf6677ac4f68d 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -52,6 +52,12 @@ properties:
     description:
       The SPI controller acts as a slave, instead of a master.
 
+oneOf:
+  - required:
+      - "#address-cells"
+  - required:
+      - spi-slave
+
 patternProperties:
   "^slave$":
     type: object
-- 
2.17.1

