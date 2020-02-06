Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D6E154711
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 16:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbgBFPHA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 10:07:00 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:41291 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbgBFPHA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 10:07:00 -0500
Received: by mail-pf1-f179.google.com with SMTP id j9so3253718pfa.8;
        Thu, 06 Feb 2020 07:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G8bcinAwhlUKAuE74TFdnn/03DR7H2/LoI5cBt5NR84=;
        b=sqz+EvUcpfmT6rf/EBl88O6Ils/FJVBwNArhARJV7LalyCl5HbAxm2ZsP0Qnit07l9
         /rLBxD05vpp8K3bzE0hpMYt+SyECbwEq8ELSYMkL6IQIH2fpmit36gwiO3r2ex7wZYnL
         DHxheh+mwtykjEITCAuaOqUskn9Ss+tav3dPc6R5+YITB3K7WHnPsdaLYFlZB0vJfmYe
         6NW+7Hb2ZSnH6bgHuFXHi6p/o/c7anudMMvO1tVgWL1hnDeckvBzRkV4G3ndmI5XoMu6
         DUcsn1a8AVC8N63bcvxPVKgGCpXQGcatVszjmQyftkf8JkcPgVwO9dAutXrSBV7u0PZ2
         wRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G8bcinAwhlUKAuE74TFdnn/03DR7H2/LoI5cBt5NR84=;
        b=hv5lUMc9knSYpaWKTaUsQ+b+DnX+EBxcGbqc6DYbxb6Bw1FN8gQYvkdocuQqTD/5el
         5AFi0Bp1LAP5lug8FKihxp96hAMBhOHog3zrmM1EN+L9MHnQB/mZpF8DE0/QsxZipSm+
         dynqnKbfgZdRZt1xAtY9eB5VfVGxFCV3h2cwCAvm3WmPoWwZziuLP7mjmzmnzeU5VtUa
         UacyhOsJpcY6e5zOlsiUJgG/IFNoe0id1KciMJvnA9QVwR9PHRTqcdjj3NWcJ5OqzsYE
         qvr7OULF33YkGYPgGkmS/ZFg84eYkH7SmI6eziX4G7oGjakCiLciqDTKk95e5/SxUW1i
         QPpw==
X-Gm-Message-State: APjAAAWQIkhlwG62fbjAXSo6Y5OhpRew6uS86sSmo2H9MfsUhuCFMH8Q
        LAGXf7B539rNSUItBPm3tunSLEeC3JI=
X-Google-Smtp-Source: APXvYqwamc8plCqTbprXCkhunsgWbC5c2htmzmXJcs4Y2ZztW1yziXirU+hE91UkVfIygEy4UV/NzA==
X-Received: by 2002:a63:3154:: with SMTP id x81mr4200126pgx.32.1581001619559;
        Thu, 06 Feb 2020 07:06:59 -0800 (PST)
Received: from localhost.localdomain ([2001:19f0:7001:2668:5400:1ff:fe62:2bbd])
        by smtp.gmail.com with ESMTPSA id 64sm3748157pfd.48.2020.02.06.07.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:06:59 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH v2 2/2] dt-binding: spi: add bindings for spi-ar934x
Date:   Thu,  6 Feb 2020 23:06:26 +0800
Message-Id: <20200206150626.708649-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206150626.708649-1-gch981213@gmail.com>
References: <20200206150626.708649-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add binding documentation for SPI controller in Qualcomm Atheros
AR934x/QCA95xx SoCs.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Changes since v1: none
 .../bindings/spi/qca,ar934x-spi.yaml          | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml b/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
new file mode 100644
index 000000000000..8f0c520a571c
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/qca,ar934x-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros AR934x/QCA95xx SoC SPI controller
+
+maintainers:
+  - Chuanhong Guo <gch981213@gmail.com>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    const: qca,ar934x-spi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    spi: spi@1f000000 {
+        compatible = "qca,ar934x-spi";
+        reg = <0x1f000000 0x1c>;
+        clocks = <&pll ATH79_CLK_AHB>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.24.1

