Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1604F8882
	for <lists+linux-spi@lfdr.de>; Thu,  7 Apr 2022 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiDGUcz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 16:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiDGUcq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 16:32:46 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C952921C6;
        Thu,  7 Apr 2022 13:17:28 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 49EA483936;
        Thu,  7 Apr 2022 21:49:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649360991;
        bh=Y9uLVCHFNZeAMheEdRMSrKkwnqJgsFDn460DerI5fKU=;
        h=From:To:Cc:Subject:Date:From;
        b=KJAI1xoGWF4qAAY4NUOLuu+6SfZYKW3ODOH/X/avcicETSQFJX2GgjEn0SH8+Pmc7
         HLX0HeAT9hDL8RbVC1hyH8EydDiTMmwERxb2RNZ31tEzDi6Gf6Nbhs019OvnIU6kr8
         +rpqhdPDV6TCcIzxDoKAI4g9bVPZ6yqXHuRznvEvcbAK7qDflXtk9qIJNFZTiDVYkx
         s6gfbM5KZBFMSI5Oxtb/dE6dJrOpiPuhK7++8cqoVKC3dHdymqWsB13c+z4/vJvPqq
         1aP45orYYNrPKN2I8AP6KzjbuYEqI0UK7mODdwt1FEQJMVXn33zpAaGN/zKVgoBO6c
         zb859lIlzjNBw==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: spi: Add YAML DT binding document for trivial devices
Date:   Thu,  7 Apr 2022 21:49:36 +0200
Message-Id: <20220407194936.223041-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document trivial SPI devices in single YAML DT binding document.
Currently this overlaps Linux kernel spidev.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
To: linux-spi@vger.kernel.org
---
 .../devicetree/bindings/spi/trivial.yaml      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/trivial.yaml

diff --git a/Documentation/devicetree/bindings/spi/trivial.yaml b/Documentation/devicetree/bindings/spi/trivial.yaml
new file mode 100644
index 0000000000000..6d6e682948dfc
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/trivial.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/trivial.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trivial SPI device DT bindings
+
+maintainers:
+  - Marek Vasut <marex@denx.de>
+  - Mark Brown <broonie@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - cisco,spi-petra
+      - dh,dhcom-board
+      - lineartechnology,ltc2488
+      - lwn,bk4
+      - menlo,m53cpld
+      - micron,spi-authenta
+      - rohm,dh2228fv
+      - semtech,sx1301
+
+  reg:
+    description: Chip select
+    maxItems: 1
+
+  spi-max-frequency: true
+  spi-cs-high: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      spidev@0 {
+        compatible = "rohm,dh2228fv";
+        reg = <0>;
+        spi-max-frequency = <1000000>;
+      };
+    };
-- 
2.35.1

