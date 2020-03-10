Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9BA0180038
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 15:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgCJOb3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 10:31:29 -0400
Received: from foss.arm.com ([217.140.110.172]:37838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgCJOb2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Mar 2020 10:31:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4497E30E;
        Tue, 10 Mar 2020 07:31:28 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF483F6CF;
        Tue, 10 Mar 2020 07:31:27 -0700 (PDT)
Date:   Tue, 10 Mar 2020 14:31:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     andrew@aj.id.au, andy.shevchenko@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, joel@jms.id.au,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, robh+dt@kernel.org
Subject: Applied "dt-bindings: fsi: Add FSI2SPI bindings" to the spi tree
In-Reply-To:  <20200306194118.18581-2-eajames@linux.ibm.com>
Message-Id:  <applied-20200306194118.18581-2-eajames@linux.ibm.com>
X-Patchwork-Hint: ignore
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   dt-bindings: fsi: Add FSI2SPI bindings

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 1e7479df0168339a98acb680fc56b804b96acb18 Mon Sep 17 00:00:00 2001
From: Eddie James <eajames@linux.ibm.com>
Date: Fri, 6 Mar 2020 13:41:17 -0600
Subject: [PATCH] dt-bindings: fsi: Add FSI2SPI bindings

Add documentation for the FSI2SPI CFAM engine, which provides access to
a number of SPI controllers.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Link: https://lore.kernel.org/r/20200306194118.18581-2-eajames@linux.ibm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
new file mode 100644
index 000000000000..893d81e54caa
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,fsi2spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SPI controllers
+
+maintainers:
+ - Eddie James <eajames@linux.ibm.com>
+
+description: |
+  This binding describes an FSI CFAM engine called the FSI2SPI. Therefore this
+  node will always be a child of an FSI CFAM node; see fsi.txt for details on
+  FSI slave and CFAM nodes. This FSI2SPI engine provides access to a number of
+  SPI controllers.
+
+properties:
+  compatible:
+    enum:
+      - ibm,fsi2spi
+
+  reg:
+    items:
+      - description: FSI slave address
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    fsi2spi@1c00 {
+        compatible = "ibm,fsi2spi";
+        reg = <0x1c00 0x400>;
+    };
-- 
2.20.1

