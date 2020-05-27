Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC391E3A6F
	for <lists+linux-spi@lfdr.de>; Wed, 27 May 2020 09:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbgE0H2D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 May 2020 03:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387523AbgE0H2C (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 May 2020 03:28:02 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA993C061A0F;
        Wed, 27 May 2020 00:28:01 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so9820219plr.0;
        Wed, 27 May 2020 00:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nVArjOONMUkkYFoFrci5k0663uSmHnt2FzTEZnX/GkE=;
        b=fNuI+idsbzoB3q+zS+ICH8mO5EylmfUuUOqZmykgFsWg7vs6FF87px9saoDbnpMB1N
         9Pt6MoaMW+ot6Kjuwk95RYR4F8rLKpcDYuvEvPOPftpgTVRx/KD0Gz1y2dCPMWKOrZcE
         aX+Nij+DtOvqgqXWrssP49bQvzkFQuV0TsLmqFgDyG3xOZayLc+E2xe88K/lunp1mlOm
         uhJiCNPxCW/g2h4L9YdqTpAqKNA6BUHtm3B2QUJe/FsjT4g7IE63UzNB5x5j2z09Iabr
         +peSmHWwb+BBTn/5IUJ1/Yb71gjsvAYsMeRC8gC/zKp6zOM0uqvUXaAbPgJf/N+51uig
         OoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nVArjOONMUkkYFoFrci5k0663uSmHnt2FzTEZnX/GkE=;
        b=Gkl01Z0K3hhWwLCd34o340qT+4rt59SztVxt/2Mofelg6JqxmK0XkgT+FNsnVT72ka
         9nqnOvDo6T4BjWymgFw8htpflBDag8+NxNFuDnTG25iFgWfFkVPd5uhTBGTxve3skprd
         2RIqUROoZ2/sptz7kYP8f+F5g4z4dSmYzkgSC9tj7xtZEOhSFs6Zl8aOvByewX2JVhne
         8CnAhDjRy1FyC+fi7qrPP0R7e36HMD1vxvLcxvUek1uAjqK2gTxYgCnAYzbE4odjP0Lu
         3i8A+LI5JsvZxbjtC2eD9d4lDvAuIVJWJjeHJ132AQe0YGbSGu1Y7dUHeLCnMjWB+X4t
         JQWw==
X-Gm-Message-State: AOAM5317wQwZDfTyHhyzUs0L8VlVXazJOHCMb++t992xwsk2tfkN3Msq
        qlVEe7Fx4PMumjJW0r0AE4o=
X-Google-Smtp-Source: ABdhPJzrL/U3t1oZby1+25XxH8pSctzfppOL3s8v/Pl5c9EFRQsy1WnMGrduSxxRz3uMkZe46M4AsQ==
X-Received: by 2002:a17:902:7b96:: with SMTP id w22mr4863111pll.232.1590564481460;
        Wed, 27 May 2020 00:28:01 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id q201sm1371842pfq.40.2020.05.27.00.27.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 00:28:01 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org,
        andy.shevchenko@gmail.com, noralf@tronnes.org,
        linus.walleij@linaro.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillonhua@gmail.com, dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v6 4/9] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Wed, 27 May 2020 15:27:28 +0800
Message-Id: <1590564453-24499-5-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
References: <1590564453-24499-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Add documentation for "ilitek,ili9341" panel.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 .../bindings/display/panel/ilitek,ili9341.yaml     | 69 ++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
new file mode 100644
index 000000000000..2172f889af3c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9341.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek-9341 Display Panel
+
+maintainers:
+  - Dillon Min <dillon.minfei@gmail.com>
+
+description: |
+  Ilitek ILI9341 TFT panel driver with SPI control bus
+  This is a driver for 320x240 TFT panels, accepting a rgb input
+  streams with 16 bits or 18 bits.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # ili9341 240*320 Color on stm32f429-disco board
+        - st,sf-tc240t-9370-t
+      - const: ilitek,ili9341
+
+  reg: true
+
+  dc-gpios:
+    maxItems: 1
+    description: Display data/command selection (D/CX)
+
+  spi-3wire: true
+
+  spi-max-frequency:
+    const: 10000000
+
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - port
+
+examples:
+  - |+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel: display@0 {
+                 compatible = "st,sf-tc240t-9370-t",
+                              "ilitek,ili9341";
+                 reg = <0>;
+                 spi-3wire;
+                 spi-max-frequency = <10000000>;
+                 dc-gpios = <&gpiod 13 0>;
+                 port {
+                         panel_in: endpoint {
+                           remote-endpoint = <&display_out>;
+                      };
+                 };
+             };
+        };
+...
+
-- 
2.7.4

