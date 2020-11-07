Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962662AA3A9
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgKGIP2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgKGIP2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736927; x=1636272927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d5rwU0EwD6rCM5AMg/4mXhiVHhmpdDtX2NbRPwnuBXI=;
  b=KKe3PtmBAqrs7kf/P85UD4mvZnYy94WvHhpIXp2uZqWKEDjNxYAX6E2M
   QiwFRRV+MIyYFgVMiF9WhCyG0Vtb+VQn3qgab++LBRFXf5p5bvFROPzD8
   RdLDspziqrGwC32RoqNOS68XA816iTTHKwszndHIxYQvV9vrFka2hXadY
   c9U9XZqXvleugpPZKkTYvAsgb6R/HVOjQBHbQdQWn76f68mWk/fa3jfta
   F92mJmc4rfAs2QY9iHKzPwrQfZ3rYHaHHBOgmJ9GbweFvJkm3h3y9GYjn
   U0JPpn0TykQydFDUQVXz2TZqYy53YgcFvoMLR13cnqR6XHhPBOBrdIWpO
   g==;
IronPort-SDR: pZsfsJZrvDeWasEurARNaJt3Io868zMlNe3vIFnaiEsrmX+wx7dWAAF+rPGnwSrFM3TN/NUxDz
 5cPZxWAmMgMtIayn4vW0ilHXU0ilc+y4AQsMpxBspVW1YzHbBTiFDv2f/DYLUKu6Wm8gSVTgMZ
 ikQw7MVpH0nbButpixPIBU2rt04dvadpuYD6LqLd4nzYbYu8QS7iDaK66kH/rudS932YqAT7j4
 H46pf0asckg2OzBQA8nD4sRCYpRTiKc/+I4SGa05cNQdeoQ4mQIzWXuKhInctgXdpoWywg19So
 JYQ=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564421"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:27 +0800
IronPort-SDR: /taIhwxHm0D6jqJ9IZCFgUhsakZu8lmZbur2WoD4n72jwr5F1InW/ntNfC47zpz8Z0TLNNNKYL
 c6iMLNmzH6wbcpdvTr/0a2uUw4X6Lb0PcTIE5kb8Qs6WFwXl9k/370uLlGmT0cZATa/5kYzyNh
 Z+MAHt1hiVh8FXanfinVsdXMxYVrprRufR44eQKxTz1A/JrPqyFexcPW0mbOgtSP7Lxp/cVOC3
 In5Vi0wDm+bjsNjaUSEH0BPlWvoFAfPMzoQJ6X7jD9R3ixofboNei0ljKUhYrc8bMcErv0ditA
 KrxP9jTbDyS3S8B+u6lfMnyy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:18 -0800
IronPort-SDR: lC38bnsFdGbEDhiXXBwS2FuK3LUBKTJG9/sIdS/BmLHzQq47Lq7wiPIe/n0+Pa4G5zKX/9obAs
 MW6ZnTIe/mef/fQtJtygQQqUkGr4ROa+MFR4745KE8fs1xWpf/l042WWaSRr31opWGu1ODAdRh
 8Kzs63FzBD1uJm7tfHGzzbcVCWWI2/iSkCf2jvAjo/2sNRYOVt73cd2/59931z+EyEZcE5lnvP
 kA5H2BV50bAfZFhNESNcs3Ymyt5ELv1KNRp1vxy6l5rgkD2jEDmbd7mDqZ2pqCS6Xjwe0K8PRv
 HcI=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:25 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 24/32] dt-bindings: Document kendryte,k210-fpioa bindings
Date:   Sat,  7 Nov 2020 17:14:12 +0900
Message-Id: <20201107081420.60325-25-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the device tree bindings for the Kendryte K210 SoC Fully
Programmable IO Array (FPIOA) pinctrl driver in
Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 .../bindings/pinctrl/kendryte,k210-fpioa.yaml | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml

diff --git a/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
new file mode 100644
index 000000000000..8730add88ee0
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/kendryte,k210-fpioa.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pinctrl/kendryte,k210-fpioa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kendryte K210 FPIOA (Fully Programmable IO Array) Device Tree Bindings
+
+maintainers:
+  - Damien Le Moal <damien.lemoal@wdc.com>
+
+description:
+  The Kendryte K210 SoC Fully Programmable IO Array controller allows assiging
+  any of 256 possible functions to any of 48 IO pins. Pin function configuration
+  is performed on a per-pin basis.
+
+properties:
+  compatible:
+    const: kendryte,k210-fpioa
+
+  reg:
+    description: FPIOA controller register space base address and size
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+    items:
+      - description: Controller reference clock source
+      - description: APB interface clock source
+
+  clock-names:
+    minItems: 2
+    maxItems: 2
+    items:
+      - const: ref
+      - const: pclk
+
+  resets:
+    maxItems: 1
+
+  kendryte,sysctl:
+    minItems: 1
+    maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      phandle to the system controller node
+
+  kendryte,power-offset:
+    minItems: 1
+    maxItems: 1
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Offset of the power domain control register of the system controller.
+      The value should be the macro K210_SYSCTL_POWER_SEL defined in
+      dt-bindings/mfd/k210-sysctl.h.
+
+patternProperties:
+  '^.*$':
+    if:
+      type: object
+    then:
+      patternProperties:
+        "^pinmux$":
+          $ref: /schemas/pinctrl/pincfg-node.yaml
+          description:
+            An array of IO pins alternate functions. The values for each
+            IO pin is a combination of an IO pin number (0 to 47) with the
+            desired function for the IO pin. Functions are defined as macros in
+            dt-bindings/pinctrl/k210-pinctrl.h. The K210_FPIOA(IO pin, function)
+            is provided to facilitate the combination of IO pin numbers and
+            functions.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - kendryte,sysctl
+  - kendryte,power-offset
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/pinctrl/k210-pinctrl.h>
+    #include <dt-bindings/mfd/k210-sysctl.h>
+    #include <dt-bindings/clock/k210-sysctl.h>
+    #include <dt-bindings/reset/k210-sysctl.h>
+
+    fpioa: pinmux@502B0000 {
+      compatible = "kendryte,k210-fpioa";
+      reg = <0x502B0000 0x100>;
+      clocks = <&sysclk K210_CLK_FPIOA>;
+      resets = <&sysrst K210_RST_FPIOA>;
+      kendryte,sysctl = <&sysctl>;
+      kendryte,power-offset = <K210_SYSCTL_POWER_SEL>;
+      pinctrl-0 = <&fpioa_jtag>;
+      pinctrl-names = "default";
+
+      fpioa_jtag: jtag {
+        pinmux = <K210_FPIOA(0, K210_PCF_JTAG_TCLK)>,
+                 <K210_FPIOA(1, K210_PCF_JTAG_TDI)>,
+                 <K210_FPIOA(2, K210_PCF_JTAG_TMS)>,
+                 <K210_FPIOA(3, K210_PCF_JTAG_TDO)>;
+      };
+    };
-- 
2.28.0

