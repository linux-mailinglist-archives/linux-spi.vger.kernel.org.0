Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B63F5B0C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbhHXJ3R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 05:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbhHXJ3L (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 24 Aug 2021 05:29:11 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63844C061764;
        Tue, 24 Aug 2021 02:28:27 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m17so4824189plc.6;
        Tue, 24 Aug 2021 02:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqY8P+NhBwUuSdIs/RiDzYI30iM1VuKQdS/hi0HOHZU=;
        b=FIYTyy5mBU9uTgG9uY61xllR2dl3clHB/eJznWR0V0qoMUnRXIgTdsvTC7ZnjaNZWY
         SjLKEEZjUCBcBNsZHZliGjsdLtnQ2FUFAvXqAlgldEDnrk7ZhjrOU8RbYSbvrvc4Lm3r
         sBySHJ5LRt3gwl2UJibczdXNAZf1qk/oryCKPFiTP6+sNGFzPQw/uQcSo43KV6jREDBL
         hQzW25d5XfJ4vAgo2Khshdraq59nwX73APzDyIsHAnnJF9WtvGTzdRZSuxA11SwUlskq
         AYLG47m4zPKb5GUCOXbYCRSJKcjyGb4LplGMg+kFlJ1LcPUEcRRvqHLfNJbX5c/mzMLT
         5SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqY8P+NhBwUuSdIs/RiDzYI30iM1VuKQdS/hi0HOHZU=;
        b=fsxX/lixxrQpj4sJS9TS1DlIqXWDuE4Cqd/DteCXMauJBAz4mtJ/4GuwjIp6/AA1Yr
         pIHGFemvtAg4oIqyMqFtR12IkVnehutcrieAcmDqMk5RlqRzapMHYR27cKXPmH6iCcWy
         2IU43MthmpRrdFtxVDL3S2IXGOeJP9tPvNnVDk9J9fXA40D1/Myzmw10sYrBjrpwSd0w
         Z/coFCSawAjVCoJLuko4KOb1dJ/57ZjdVhaxnFMKa0+oqyWJOMHkd2WczG9ikCBF8xY3
         /SkNBSCLBUngeXLuWRK49XdWENlDVwB1wfL7MB3rvwQdhaCcOxsPr/HrbWkeQ7+QHU7J
         zXnQ==
X-Gm-Message-State: AOAM5339YnUHHpYSAQBaIwEnJ66NIMxwdAUgS6tHeZNlt7loUY8nPB6v
        LlKOKj94DmG/8MZ4qECZer4=
X-Google-Smtp-Source: ABdhPJwAu4MudyUPQ2eW9thY2zJL2huaaYAZ3BfovQUuYeMXul9P2gnqU0quKvthy382466e3zv0qQ==
X-Received: by 2002:a17:90a:588f:: with SMTP id j15mr3528695pji.177.1629797306922;
        Tue, 24 Aug 2021 02:28:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id w5sm21270053pgp.79.2021.08.24.02.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:28:26 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] dt-bindings: spi: Convert sprd ADI bindings to yaml
Date:   Tue, 24 Aug 2021 17:27:44 +0800
Message-Id: <20210824092745.2093640-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824092745.2093640-1-zhang.lyra@gmail.com>
References: <20210824092745.2093640-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Convert spi-sprd-adi.txt to yaml.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 .../devicetree/bindings/spi/spi-sprd-adi.txt  | 63 ------------
 .../devicetree/bindings/spi/sprd,spi-adi.yaml | 99 +++++++++++++++++++
 2 files changed, 99 insertions(+), 63 deletions(-)
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
index 000000000000..f464fb6033f9
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/sprd,spi-adi.yaml
@@ -0,0 +1,99 @@
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
+    description: Reference to a phandle of a hwlock provider node.
+
+  hwlock-names:
+    description: |
+      Reference to hwlock name strings defined in the same order
+      as the hwlocks, should be "adi".
+
+  sprd,hw-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    maxItems: 1
+    description: |
+      This is an array of channel values up to 49 channels.
+      The first value specifies the hardware channel id which is used to
+      transfer data triggered by hardware automatically, and the second
+      value specifies the analog chip address where user want to access
+      by hardware components.
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

