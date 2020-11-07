Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92AEE2AA39F
	for <lists+linux-spi@lfdr.de>; Sat,  7 Nov 2020 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgKGIPX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 7 Nov 2020 03:15:23 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:57208 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgKGIPW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 7 Nov 2020 03:15:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604736922; x=1636272922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6hQFOpsBQqm+ohKs0w/Ib6ThhS/q66nb5zcwWEvGTPw=;
  b=GjIsz+F/gUrttBC13mbWH7m/RFU1OsFiMYynyYaswVZ2qNiMJLf0eBid
   D+dr6ztcsuuo+KQ738WjESiFvnoqtxgyDhKZS9JZ3UD8xN2BPtVN371En
   0jodtTVwDg59eVvpYbEBVHgfPor9CbK8tVy/l4Ar6vPiABx6zPs5nOYfJ
   /PRIg/Rz+9IXHFI9c8I4+NyeRanIQ1Tfn8KDnVz45E2dbM1+2nEEdFJpG
   4jTsIppPyJIb6vsju1kRhIww5cB6OrIWsIxOVpDE8gJ1HeMsPY5MHNMr7
   rpSZ+YD73QUypRHpf4muDuP6l15YztsymNawtlIqVrKDVa7WxenFBQcKt
   w==;
IronPort-SDR: GY1Itue+JUKSOnxitwRnOq3auQ7/TBB5XtlrLsW/JynLp8q+4cSDQ65iJk8D6HzdoHlKiGoRxl
 pZQQXKP1vo9ziYgrYhsoKGfmFjUZAl5B/Oa9v6azlyPly5hnmSD8H33APiJhXvY7kQfat6TzCF
 1G5C+GqMnm6amRA/iQHkZeYzczHOqm0NzXYgwbX7oGS7KO3C/o7VVz05C2wgZTPp/XlWIiHaxJ
 qZiQAmgfIUpcK2YBizdlsNk7swUmshEsK8jqOrtNpjqtVf+S2S7HQ6MgGAYHozjDd53xeJQMRT
 9EM=
X-IronPort-AV: E=Sophos;i="5.77,459,1596470400"; 
   d="scan'208";a="156564416"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2020 16:15:22 +0800
IronPort-SDR: Bw9gEIOBE3cN50/D7lsuvC6ywLh65NSFjAL1PtNAvnQouBXHENCCYoSKPgeuZzo19UVgkEqPRv
 8rx9tnet5fMQJ0MBP/0Z/rY3XhnFp4cGZL0374j2hVWGjG7P29s4J5a5rpBQexLvImBmFXFu/a
 0uklOm8onfQs91otyDkqm9wvBwZGlpKqouxYuAo5P5XrjXF5iFAS7nD/wcRf4FnWJblmq8P+9s
 Fs4XiuVsmjlxugKPuMyhjBOmX7TBhUKqmQpwF29LDQFM1fd1XrFTzXro8Aa3Wn9sWrR4rfTObV
 kEh7gXiXLo3wWjQak6bOu8O3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2020 00:00:13 -0800
IronPort-SDR: BXlHUw/HDcF1F7ONaRWXXDTETsH6nr1+NpS8wIP/O/H9VAx/bcEfmJtb+W1CFGgZIE6Q+Dpecu
 W3rToKZcr96OLjkNsggtSMp75Le/onPmWlBJoE3YlGT1vpsNb5+X3V0mZ3R7j0Ek3gARGpo0wV
 zQtKI+OpzjxC8nTt21mnSH0dzmrwNuPruMdgrkmsSEJImr+NjmyVEAjBMYsoIM98GIOkoLSUE6
 aEdVse9g1XVwgAiMF4C8EJa4mUadQH1/Elmv15IgrfAyhgUSj5DD3bw0eOhImxLZo7zAcfOFrE
 fLk=
WDCIronportException: Internal
Received: from hdrdzf2.ad.shared (HELO twashi.fujisawa.hgst.com) ([10.84.71.85])
  by uls-op-cesaip01.wdc.com with ESMTP; 07 Nov 2020 00:15:20 -0800
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
Subject: [PATCH 22/32] dt-binding: Document kendryte,k210-sysctl bindings
Date:   Sat,  7 Nov 2020 17:14:10 +0900
Message-Id: <20201107081420.60325-23-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201107081420.60325-1-damien.lemoal@wdc.com>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the device tree bindings of the Kendryte K210 SoC system
controller driver in
Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 .../bindings/mfd/kendryte,k210-sysctl.yaml    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml

diff --git a/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml b/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml
new file mode 100644
index 000000000000..8c002d2078f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/kendryte,k210-sysctl.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/kendryte,k210-sysctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Kendryte K210 System Controller Device Tree Bindings
+
+maintainers:
+  - Damien Le Moal <damien.lemoal@wdc.com>
+
+description: |
+  Kendryte K210 system controller driver which provides a register map for
+  clocks and peripherals within the SoC.
+
+  See also:
+  - dt-bindings/mfd/kendryte,k210-sysctl.h
+
+properties:
+  compatible:
+    allOf:
+      - items:
+        - const: kendryte,k210-sysctl
+        - const: syscon
+        - const: simple-mfd
+
+  clocks:
+    minItems: 1
+    maxItems: 1
+    items:
+      - description: APB interface clock source
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: pclk
+
+  reg:
+    items:
+      - description: system controller register space base address and size
+
+  reg-io-width:
+    const: 4
+
+required:
+  - compatible
+  - clocks
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/mfd/k210-sysctl.h>
+
+    sysctl: system-controller@50440000 {
+      #address-cells = <1>;
+      #size-cells = <1>;
+      compatible = "kendryte,k210-sysctl",
+                   "syscon", "simple-mfd";
+      reg = <0x50440000 0x1000>;
+      reg-io-width = <4>;
+      /* ... */
+    };
+
-- 
2.28.0

