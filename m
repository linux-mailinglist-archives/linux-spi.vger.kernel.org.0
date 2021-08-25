Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0C03F6FF0
	for <lists+linux-spi@lfdr.de>; Wed, 25 Aug 2021 09:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhHYHAp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Aug 2021 03:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbhHYHAf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Aug 2021 03:00:35 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A9AC0617A8;
        Tue, 24 Aug 2021 23:59:49 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q68so5050798pga.9;
        Tue, 24 Aug 2021 23:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wx0yGr9IjZZHkEynSx/gWkIpnCWkf8kx83N5GfWTTY0=;
        b=KHdnGb81B/eJT9AZ/cAk6tzbFkQfo9l6/ivx1IPpak2o0vkQkAYD6ivn/PmdZ5fsGW
         peelf6Hz+LWag9LKEdjHudQwErvWA7WDa5P7NTfVMzAwu95V5sGR3KZ9gS2kHjO/3CsX
         Og/2l3pYlybki1imXLGE3SC0j24hs0ZTEF2r+b5n7weMLed0CRkb578PtT9BcP8XEeS2
         b4++PTQb/kvAJE05MxNzzBgdJihFnSnCWvmpHW6Z5NbM9cHq0XEY8wuXe9I4VJY1Xn+X
         8LzjDhPMb3Xssk7Mbx9ka8/iFuYwuU0PvFPaiBUE6BMrZNizT3iD9jBqyH7OzrpqzgzN
         aAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wx0yGr9IjZZHkEynSx/gWkIpnCWkf8kx83N5GfWTTY0=;
        b=b3l5mBXqLSLxfRTUJmW8NMLVgb8Av09q9pGpgv/6ObSeGj1z/lDTT6/mi9xpvh8mvl
         96wvwQwVJ7s9JBfo7lcGeiuHgcqbZmwx+Q7/iOPpslZkoXnu45fkIOPfbSvm72zsCzmq
         lELiWtFgAKIMShIHrjGnfR3TrwCnaWF4iifUZRat7WVSz6fQl0eyFkNWk82VZRblJ3cr
         2alv4RgZLTyz/ZkPo1BH6C0wFSMov4/gV1U7p1zJcViRWZmjGqZO00aCjDw6c2t9jIIa
         ZVPiHOThdmrJs7W70C8jQbdmWopIewotubGbFDu1cNy6orUKPOKvY7/gZnWVpGQQh2sg
         uBzw==
X-Gm-Message-State: AOAM533iTDGNAdsizBnGSHL//ppjwFxvbmExFqHQ0nr4hsKA9oojIrVo
        CViMH9nReoYqCEkGBCML0/I=
X-Google-Smtp-Source: ABdhPJwjq4Ry2+jpc3F1YchXxAJ7/vm4JMrIeWVapo2It0VFSr7WQckvN7FOi1tze1ayG6mx0u7OwA==
X-Received: by 2002:a62:cf01:0:b029:3cd:ee82:2ee with SMTP id b1-20020a62cf010000b02903cdee8202eemr42722745pfg.78.1629874789417;
        Tue, 24 Aug 2021 23:59:49 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id q102sm4443109pjq.54.2021.08.24.23.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 23:59:48 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 2/3] dt-bindings: spi: Convert sprd ADI bindings to yaml
Date:   Wed, 25 Aug 2021 14:59:30 +0800
Message-Id: <20210825065931.2111159-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210825065931.2111159-1-zhang.lyra@gmail.com>
References: <20210825065931.2111159-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Convert spi-sprd-adi.txt to yaml.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/spi/spi-sprd-adi.txt  |  63 -----------
 .../devicetree/bindings/spi/sprd,spi-adi.yaml | 102 ++++++++++++++++++
 2 files changed, 102 insertions(+), 63 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml

diff --git a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt b/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
deleted file mode 100644
index 2567c829e2dc..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-sprd-adi.txt
+++ /dev/null
@@ -1,63 +0,0 @@
-Spreadtrum ADI controller
-
-ADI is the abbreviation of Anolog-Digital interface, which is used to access
-analog chip (such as PMIC) from digital chip. ADI controller follows the SPI
-framework for its hardware implementation is alike to SPI bus and its timing
-is compatile to SPI timing.
-
-ADI controller has 50 channels including 2 software read/write channels and
-48 hardware channels to access analog chip. For 2 software read/write channels,
-users should set ADI registers to access analog chip. For hardware channels,
-we can configure them to allow other hardware components to use it independently,
-which means we can just link one analog chip address to one hardware channel,
-then users can access the mapped analog chip address by this hardware channel
-triggered by hardware components instead of ADI software channels.
-
-Thus we introduce one property named "sprd,hw-channels" to configure hardware
-channels, the first value specifies the hardware channel id which is used to
-transfer data triggered by hardware automatically, and the second value specifies
-the analog chip address where user want to access by hardware components.
-
-Since we have multi-subsystems will use unique ADI to access analog chip, when
-one system is reading/writing data by ADI software channels, that should be under
-one hardware spinlock protection to prevent other systems from reading/writing
-data by ADI software channels at the same time, or two parallel routine of setting
-ADI registers will make ADI controller registers chaos to lead incorrect results.
-Then we need one hardware spinlock to synchronize between the multiple subsystems.
-
-The new version ADI controller supplies multiple master channels for different
-subsystem accessing, that means no need to add hardware spinlock to synchronize,
-thus change the hardware spinlock support to be optional to keep backward
-compatibility.
-
-Required properties:
-- compatible: Should be "sprd,sc9860-adi".
-- reg: Offset and length of ADI-SPI controller register space.
-- #address-cells: Number of cells required to define a chip select address
-	on the ADI-SPI bus. Should be set to 1.
-- #size-cells: Size of cells required to define a chip select address size
-	on the ADI-SPI bus. Should be set to 0.
-
-Optional properties:
-- hwlocks: Reference to a phandle of a hwlock provider node.
-- hwlock-names: Reference to hwlock name strings defined in the same order
-	as the hwlocks, should be "adi".
-- sprd,hw-channels: This is an array of channel values up to 49 channels.
-	The first value specifies the hardware channel id which is used to
-	transfer data triggered by hardware automatically, and the second
-	value specifies the analog chip address where user want to access
-	by hardware components.
-
-SPI slave nodes must be children of the SPI controller node and can contain
-properties described in Documentation/devicetree/bindings/spi/spi-bus.txt.
-
-Example:
-	adi_bus: spi@40030000 {
-		compatible = "sprd,sc9860-adi";
-		reg = <0 0x40030000 0 0x10000>;
-		hwlocks = <&hwlock1 0>;
-		hwlock-names = "adi";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		sprd,hw-channels = <30 0x8c20>;
-	};
diff --git a/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
new file mode 100644
index 000000000000..3e399d31168b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
@@ -0,0 +1,102 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/sprd,spi-adi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Spreadtrum ADI controller
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+description: |
+  ADI is the abbreviation of Anolog-Digital interface, which is used to access
+  analog chip (such as PMIC) from digital chip. ADI controller follows the SPI
+  framework for its hardware implementation is alike to SPI bus and its timing
+  is compatile to SPI timing.
+
+  ADI controller has 50 channels including 2 software read/write channels and
+  48 hardware channels to access analog chip. For 2 software read/write channels,
+  users should set ADI registers to access analog chip. For hardware channels,
+  we can configure them to allow other hardware components to use it independently,
+  which means we can just link one analog chip address to one hardware channel,
+  then users can access the mapped analog chip address by this hardware channel
+  triggered by hardware components instead of ADI software channels.
+
+  Thus we introduce one property named "sprd,hw-channels" to configure hardware
+  channels, the first value specifies the hardware channel id which is used to
+  transfer data triggered by hardware automatically, and the second value specifies
+  the analog chip address where user want to access by hardware components.
+
+  Since we have multi-subsystems will use unique ADI to access analog chip, when
+  one system is reading/writing data by ADI software channels, that should be under
+  one hardware spinlock protection to prevent other systems from reading/writing
+  data by ADI software channels at the same time, or two parallel routine of setting
+  ADI registers will make ADI controller registers chaos to lead incorrect results.
+  Then we need one hardware spinlock to synchronize between the multiple subsystems.
+
+  The new version ADI controller supplies multiple master channels for different
+  subsystem accessing, that means no need to add hardware spinlock to synchronize,
+  thus change the hardware spinlock support to be optional to keep backward
+  compatibility.
+
+allOf:
+  - $ref: /spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-adi
+
+  reg:
+    maxItems: 1
+
+  hwlocks:
+    maxItems: 1
+
+  hwlock-names:
+    const: adi
+
+  sprd,hw-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    description: A list of hardware channels
+    minItems: 1
+    maxItems: 48
+    items:
+      items:
+        - description: The hardware channel id which is used to transfer data
+            triggered by hardware automatically, channel id 0-1 are for software
+            use, 2-49 are hardware channels.
+          minimum: 2
+          maximum: 49
+        - description: The analog chip address where user want to access by
+            hardware components.
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    aon {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        adi_bus: spi@40030000 {
+            compatible = "sprd,sc9860-adi";
+            reg = <0 0x40030000 0 0x10000>;
+            hwlocks = <&hwlock1 0>;
+            hwlock-names = "adi";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            sprd,hw-channels = <30 0x8c20>;
+        };
+    };
+...
-- 
2.25.1

