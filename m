Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92738156E0A
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2020 04:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgBJDmf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 9 Feb 2020 22:42:35 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39745 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJDmf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 9 Feb 2020 22:42:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id j15so3157384pgm.6;
        Sun, 09 Feb 2020 19:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bSfNCfkhYW6qt1yYztQlhHq6EWdHz1ijcLv3ziMJucg=;
        b=mdDuN04P7r2V9ZsHspPaBCAcKsC1dsq0Llpvo/kvLhlPwYInmYovBjXUauvaua8rXO
         Mcu2tZgTmL3PW7o4rklBeGGqMizMwqif0JrcPfQDlILXlwIh4gErJtoHKOMeYn+X1ivI
         lLSzXszLJam/2VpZO7zlerpLPiZkujkjloMgp0MfOzk8gKdDEwyAnVIfoqwqYeOKyK1z
         En1N6p1hGCgRDqN7zFc3y7iwGM1LyMUrwt3VhCkvCX1d8o5tKp5DotX9rah70pLl/XDI
         rl4+JBrYLjyVmYJ7ee0lYz6EqtMmOBvFpDlOC0C4SRKFss9hzsrlSMJBZe9RtTUNpljU
         3KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bSfNCfkhYW6qt1yYztQlhHq6EWdHz1ijcLv3ziMJucg=;
        b=S0kM/utsBpZ+WbkzS+o9DPT+iEvp2zETtv8G7odxn26eojCT9uo0muztCrcZDoHY/M
         bF3EU/sK+5zWlU31GoPmIv+4mzNs+yVQouLbRyOvkTvL6zCmfhSASGAWoObPHbvDWHNP
         vdOKSx5PRyw77HmcUebE78wC0z8PFRydzJUA4kGIQXdn1P0MKFAUEhD4E578mAo/a3pk
         ZAnL2Kb2FFJlMQDeSdl9xHjHi4tFAvrpjIVeCjX1Lxx8PbHSD4FfOqaqw687fb8CAlh+
         khJh3FoWO0B207oDbPxcEb5UE90NQZw5sUhvwILaGDMWAI9p/XlG1lNI0S3+uVpsC5vk
         z8xQ==
X-Gm-Message-State: APjAAAXpvaytQuA/4DSWOsv8VH7K2Kt8oM3en/gfJmiRygOPUIHNT946
        vG2S9woTwEsvjFvE9EdXO+6Jsam5ck8=
X-Google-Smtp-Source: APXvYqz9KwvHGxel7lHd9551O8OTpuXtNPp5eYLktMQsb+B+dTzSUiKKOP+Pj6Y9NVZ4quEZhYYixw==
X-Received: by 2002:aa7:9dde:: with SMTP id g30mr10927393pfq.91.1581306154182;
        Sun, 09 Feb 2020 19:42:34 -0800 (PST)
Received: from localhost.localdomain ([240e:379:947:2855::fa3])
        by smtp.gmail.com with ESMTPSA id j14sm10179880pgs.57.2020.02.09.19.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 19:42:33 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH v4 2/2] dt-binding: spi: add bindings for spi-ar934x
Date:   Mon, 10 Feb 2020 11:41:52 +0800
Message-Id: <20200210034152.49063-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200210034152.49063-1-gch981213@gmail.com>
References: <20200210034152.49063-1-gch981213@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add binding documentation for SPI controller in Qualcomm Atheros
AR934x/QCA95xx SoCs.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change since v3:
replace clock binding with ath79 pll as this is the actual clock
binding used in all SoC supported by this driver.

Change since v2:
replace clock binding in example with a bogus spi_clock to fix dt
binding check error.

Change since v1: none

 .../bindings/spi/qca,ar934x-spi.yaml          | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml b/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
new file mode 100644
index 000000000000..2aa766759d59
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
@@ -0,0 +1,41 @@
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
+    #include <dt-bindings/clock/ath79-clk.h>
+    spi: spi@1f000000 {
+        compatible = "qca,ar934x-spi";
+        reg = <0x1f000000 0x1c>;
+        clocks = <&pll ATH79_CLK_AHB>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.24.1

