Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9540C3F8454
	for <lists+linux-spi@lfdr.de>; Thu, 26 Aug 2021 11:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbhHZJRT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 26 Aug 2021 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbhHZJRO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 26 Aug 2021 05:17:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54123C0617A8;
        Thu, 26 Aug 2021 02:16:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so1949568pjt.0;
        Thu, 26 Aug 2021 02:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L3k81M1U8IPFSz98hjzAzxK/MacZrQJoEq89TXnAhpU=;
        b=nL3j1OKocvOFpouDzx/sgrajh3gvc+583g/kg/hV4LF4OxNxXHwef59efhudULAfUp
         3b+0ZlveJNZtcG6GXaddd+5quMbS84RCyk9KBIkrc7dRxonld+WRPpqfQ3Mu4DkN3TeA
         c3litQMHg3e+30zuLv3rFZ+nEHNLjO90n0NFwen7lDSjr3CgxS9YKb95Hj/dvsjak/9V
         Ky3TsjBCXR/WzBF+IgJO3AC6SvfYoXALsDtTnJ6RJU/E/zOO/rW601jmPQpiejCu9YgR
         0/AhSW+iEvuXC2zdh0GbsymB45wuzviv5/faFBuodV5yiU8q6JUlwKMWjD9ctU8Nrsyw
         HBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L3k81M1U8IPFSz98hjzAzxK/MacZrQJoEq89TXnAhpU=;
        b=WiVibrUxCDJjcBlk4Ufm/oPcb4GbW9v2i9dBqe27U9DItURZildf5bgdJ68N8BEb9h
         ouar6yOCNzs6kYTBJsaAg65RpK7VPMZltd+hVZQuNprPsWOQ43zqjV6WVuaEVsrnaQF4
         p5NLGblcLz7RwDW8+Mb5a8JdFO8qyx7yMUL76vK7yxFHLqIVpGN8YuQnV/8hxqmanHHp
         J7U427b3IRC1mLxYoehFU5YIpGoVtyvpXav6+9NvqKvYaa63hs4G9xBkfe+Kae05vX0o
         tKH3yMRwP43cfrN4fe3BxDJZM/FWK1O1tTkje72bBA046P8qd7dxgMOZeVPyEaCdJ7yS
         xcmw==
X-Gm-Message-State: AOAM531oPW1Oz06Vvu1PFG3SGmmMPOzx2fPkdlUWpG1SVb45sH2+hZg9
        aTRhihIHVf/Pi49jlLiDwofx+jhL/Yw=
X-Google-Smtp-Source: ABdhPJzEc1OjEcm3ev5ych4oDsTQNWyOv6H1KlqiBq+Yf7weQoDYQ6nOSvh6Vqgz+KfCXvdo77/jzQ==
X-Received: by 2002:a17:902:7d90:b0:134:d977:22de with SMTP id a16-20020a1709027d9000b00134d97722demr2834377plm.30.1629969386840;
        Thu, 26 Aug 2021 02:16:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j20sm2777569pgb.2.2021.08.26.02.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 02:16:26 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Luting Guo <luting.guo@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH V3 3/4] dt-bindings: spi: Convert sprd ADI bindings to yaml
Date:   Thu, 26 Aug 2021 17:15:48 +0800
Message-Id: <20210826091549.2138125-4-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210826091549.2138125-1-zhang.lyra@gmail.com>
References: <20210826091549.2138125-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

Convert spi-sprd-adi.txt to yaml.

Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

