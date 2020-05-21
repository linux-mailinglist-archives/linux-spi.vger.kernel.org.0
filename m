Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3E1DD617
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 20:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgEUShS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUShS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 14:37:18 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8EC061A0E;
        Thu, 21 May 2020 11:37:17 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n11so2771532qkn.8;
        Thu, 21 May 2020 11:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZ2fUcvibZ/nGJTIbOnckpa0koPQZbzLKN92BTEKO0Q=;
        b=qLCAaBEx5gVgjJ63m3yXYff152CX2zNP8wxOxKXx4AH1g/0zIKhvrEnSdscfXtu59v
         UEizF050C+him4l4uvV0g8YPF7wZJ7m5sq6A9yvHwpdcaSiZ4mpMDK7yODyRn4Lbal6P
         p4kqBFkQh+eMN6mNnFt9ak66am7NkprBgsladavG+IozJ6+xOCegSZQUnaIqTUMhH5UR
         QnRt4zeGNtCjt8r+XANoktGOtfSrwKtYzxcpLrlVFzJzjcSu15z+G1ZE1FNdm6hGQNDd
         tQPU2A+OYlSFsUTnIJpbg+YY3b9CPuR9JTmiwSxlfoXUHv89LZNt1p2hL0W7DwW1DGyo
         v8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZ2fUcvibZ/nGJTIbOnckpa0koPQZbzLKN92BTEKO0Q=;
        b=aaAjwuX8whU/udEz4rnIufurWtOMJucROYMQJzawnilFfxobxOEoCaRSQWOXWPPdb5
         o+LTpKH9gaiXGZMXU2SO5TRIusAjQWBzHVDS50TF39DArD7JZHkRe7fWpGiNTTh+/wuc
         6IXsHGvzn/hdIuWI3FFlKYgke0LD6IG5fNKva63sHm+wqfT75F1BB+/pk7WGPezAxjXC
         W/TBkMWXiR81lAXgTWnkgdt1xVH4cr9qt0gDXZEYu1HCy+hsAS99UxjsjcGrDjNDAiiX
         OjBGHEpNdc30m0da/Lu2mlKOWpp1GUjfszmeSm7TUzd6o9SfMHqoi90vjyteyuISHvjw
         0RRA==
X-Gm-Message-State: AOAM533L/OlCNTu2sac4gKMhQyu9ggEyBkLYI4Ciz7aY8+dJpUtRmo0l
        YE0uroN5Xy7itxJwzYmuWF3CxSZ6g3c=
X-Google-Smtp-Source: ABdhPJyu9ouFk4Xg/E/8vfc52crxbFOA6f8T3LhXTwqTJ33ykwz/WapVEtJE5a5QpkHxM5fxrC0sfA==
X-Received: by 2002:a37:7dc4:: with SMTP id y187mr11103129qkc.412.1590086236988;
        Thu, 21 May 2020 11:37:16 -0700 (PDT)
Received: from lord-gnome.lan (pool-100-8-210-135.nwrknj.fios.verizon.net. [100.8.210.135])
        by smtp.gmail.com with ESMTPSA id z25sm5999723qtj.75.2020.05.21.11.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:37:16 -0700 (PDT)
From:   Christopher Hill <ch6574@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christopher Hill <ch6574@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] spi: rb4xx: add corresponding device tree documentation
Date:   Thu, 21 May 2020 14:36:31 -0400
Message-Id: <20200521183631.37806-3-ch6574@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521183631.37806-1-ch6574@gmail.com>
References: <20200521183631.37806-1-ch6574@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds the correcsponding MikroTik vendor and device tree
documentation

Signed-off-by: Christopher Hill <ch6574@gmail.com>
---
 .../bindings/spi/mikrotik,rb4xx-spi.yaml      | 36 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 2 files changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/mikrotik,rb4xx-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/mikrotik,rb4xx-spi.yaml b/Documentation/devicetree/bindings/spi/mikrotik,rb4xx-spi.yaml
new file mode 100644
index 000000000000..4ddb42a4ae05
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/mikrotik,rb4xx-spi.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/mikrotik,rb4xx-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MikroTik RB4xx series SPI master
+
+maintainers:
+  - Gabor Juhos <juhosg@openwrt.org>
+  - Bert Vermeulen <bert@biot.com>
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: mikrotik,rb4xx-spi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    spi: spi@1f000000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "mikrotik,rb4xx-spi";
+        reg = <0x1f000000 0x10>;
+    };
+
+...
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index d3891386d671..d3277fe6640b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -633,6 +633,8 @@ patternProperties:
     description: Microsoft Corporation
   "^mikroe,.*":
     description: MikroElektronika d.o.o.
+  "^mikrotik,.*":
+    description: MikroTik
   "^miniand,.*":
     description: Miniand Tech
   "^minix,.*":
-- 
2.25.1

