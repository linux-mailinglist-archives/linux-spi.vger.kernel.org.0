Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4494C3A9E
	for <lists+linux-spi@lfdr.de>; Fri, 25 Feb 2022 02:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiBYBAW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Feb 2022 20:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiBYBAV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 24 Feb 2022 20:00:21 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7062804FE;
        Thu, 24 Feb 2022 16:59:50 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id y5so3358535pfe.4;
        Thu, 24 Feb 2022 16:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HarL5/zDESWzDbkIHnU59WJXVsMBep1/fNRKYTr9jAE=;
        b=FEfUlf6EJgS98MtGimS+TaZAMOGU6ogXn3khmumCxAAHVsHW6YXrKCekr2UDEgRB6G
         zF9FBHE6aWk0I9tmg60kDIWT/6LVG6tpQh2j+7D3fd5ASqfGthjCTinqmBT6+YaVvfWK
         Zdruapk3pnFmjL8jpYOA+glnNRxIdogcYrv6MVi59UzvdarSCAAt6ZKi/R9ewIrH6eRO
         01ISaoULIU5VkjmxibPWUENWZSgZfMDDDWMywZyXBDmiEeTVvJdEULq7Y+uh72zjXdl8
         z0QTiFSD4MdLVLfYDWrwnpudbYqstC6rGvfGlaS4pAsfZKzJstl5jYzK3z06FpaTkJch
         pcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HarL5/zDESWzDbkIHnU59WJXVsMBep1/fNRKYTr9jAE=;
        b=yFoesZoI5ljVpJB+vBPnXfWhmkjh1JYG01UPcqPr1eA1dbGwVI8H4/FfDkyQJ9CVeU
         WOtj5wHcL0x+SKuAiM8y2meARoTHL4i1k4IXdIhwsT0aJlTgXDx6JUFVavEjdwxMXNOP
         BxBXtQucTSzyN3LzbIFg5RyUI6X2cHezK1BQbBbO4nNIo+HUzVHOquxmNvhEYbNZTtJj
         g0xx8Pwo3owpg23hBJj6ty3TlVpXEI9NlxC0UOvhYV3VWomRgt6kY38vUXl1H+PCOISM
         ArEoFbV5Hu4JqV/7zDz7HklbqDr3a5944Y64SXfNFKlokQdtbgcYL3ZaZSfRxzkEjvUd
         andQ==
X-Gm-Message-State: AOAM530yQOqafWLV/8AnXWrP5jdi/EjClKNo2uiz/TjDBzWI0fCN+koE
        A7Tyte3lfqjXxyEKyMGJbo0=
X-Google-Smtp-Source: ABdhPJwFN51nYhY5jXI1+TkBsvmb7jPAdyQOkOIghEZDXb52VVLNKcu/nuYLzyhsOgeagqbOZlU0Ow==
X-Received: by 2002:a65:6a13:0:b0:373:14f6:5d33 with SMTP id m19-20020a656a13000000b0037314f65d33mr4216673pgu.62.1645750790165;
        Thu, 24 Feb 2022 16:59:50 -0800 (PST)
Received: from thelio.corp.microsoft.com ([2001:4898:80e8:36:37cd:6bd:2964:3d5e])
        by smtp.gmail.com with ESMTPSA id w5-20020a056a0014c500b004f3a5535431sm742070pfu.4.2022.02.24.16.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:59:49 -0800 (PST)
From:   Dmitry Antipov <daantipov@gmail.com>
X-Google-Original-From: Dmitry Antipov <dmanti@microsoft.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, Dmitry Antipov <dmanti@microsoft.com>
Subject: [PATCH v4 3/6] Documentation: DT bindings for Microsoft G6 Touch Digitizer
Date:   Thu, 24 Feb 2022 16:59:33 -0800
Message-Id: <20220225005936.3485405-4-dmanti@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225005936.3485405-1-dmanti@microsoft.com>
References: <20220225005936.3485405-1-dmanti@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Dmitry Antipov <dmanti@microsoft.com>

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 .../input/microsoft,g6-touch-digitizer.yaml   | 105 ++++++++++++++++++
 1 file changed, 105 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml

diff --git a/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
new file mode 100644
index 000000000000..e516717527e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/microsoft,g6-touch-digitizer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft G6 Touch Digitizer
+
+maintainers:
+  - Dmitry Antipov <dmanti@microsoft.com>
+
+description: |
+  Microsoft G6 touch digitizer is a HID over SPI device supporting HID Over SPI
+  Protocol Specification 1.0, available at
+  https://www.microsoft.com/en-us/download/details.aspx?id=103325.
+
+properties:
+  compatible:
+    oneOf:
+      - const: microsoft,g6-touch-digitizer
+      - items:
+        - const: microsoft,g6-touch-digitizer
+        - const: hid-over-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO specifier for the digitizer's reset pin (active low). The line must
+      be flagged with GPIO_ACTIVE_LOW.
+
+  vdd-supply:
+    description:
+      Regulator for the VDD supply voltage.
+
+  input-report-header-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This property and the rest are described in HID Over SPI Protocol Spec 1.0
+
+  input-report-body-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  output-report-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  read-opcode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  write-opcode:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  hid-over-spi-flags:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  post-power-on-delay-ms:
+    description:
+      Optional time in ms required by the device after enabling its regulators
+      or powering it on, before it is ready for communication.
+
+  minimal-reset-delay-ms:
+    description:
+      Optional minimum amount of time in ms that device needs to be in reset
+      state for the reset to take effect.
+
+required:
+  - compatible
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+  - input-report-header-address
+  - input-report-body-address
+  - output-report-address
+  - read-opcode
+  - write-opcode
+  - hid-over-spi-flags
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    spi-hid-dev0 {
+      compatible = "microsoft,g6-touch-digitizer", "hid-over-spi";
+      reg = <0>;
+      interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
+      reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+      vdd-supply = <&pm8350c_l3>;
+      pinctrl-names = "default";
+      pinctrl-0 = <&ts_d6_reset_assert &ts_d6_int_bias>;
+      input-report-header-address = <0x1000>;
+      input-report-body-address = <0x1004>;
+      output-report-address = <0x2000>;
+      read-opcode = <0x0b>;
+      write-opcode = <0x02>;
+      hid-over-spi-flags = <0x00>;
+      post-power-on-delay-ms = <5>;
+      minimal-reset-delay-ms = <5>;
+    };
-- 
2.25.1

