Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DF4154073
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 09:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgBFIjR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 03:39:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40673 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgBFIjQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 03:39:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id q8so2731429pfh.7;
        Thu, 06 Feb 2020 00:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiniMnh/RN6JalocAKlnItv6rVv3J8q3lmdsPVBexzY=;
        b=oJQxMPbVfgSl5Sl68g/vbr6NzLcxWn/hc/hfI9v2ZGsNJTUJwP79jZBS3C1LTWDxZl
         wYyootdu4wU9SnSIsjMdAO62ZIC5nmrAnjZBblZ1FE8EFSFib53wr/e3zgfoxAuKcYMy
         kX3i6W91QQrx3GbVa8gEk71YEQ0/2dDWsaJi4xtcIIWTJSgsVp3joRf2kgWiAhnj5Ihf
         QJS0P02DgHjYhjRoJU4VHZHEatwHgM8tsrgISc9/Me3uo/G+zuv1njZ6xXG+ELN0HFtK
         E1GnqmEnXCnksDzC1wQCOefRv6l26wVGLd9eMM/lYKP/Ecq/O4KwkMirbHgd4MiPruJU
         /s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiniMnh/RN6JalocAKlnItv6rVv3J8q3lmdsPVBexzY=;
        b=MmwZ9O2QGJUugIvbTYVwq8lU338QrD+JhRQeolLJqFFs6qIs7raSH5me8dBu7krJZx
         T5K7DlvFTi5yseGwuRK5eVbNaO9/FJrYOC71tDi+Gna67qr2ltsidzSGHVerodPDLVCf
         07o+KLh8zhVmKU0rUh6FV60xpIeQG1l0FHsW6h5CHhvSVrPKlxMSuXP6Mz/BR3lMY7AI
         IdIHS0Ze9Lx8OVEaGUm6rjiznsjGKAKln/kQTFj75d53sgVVunRpTQmBfRAdVAP4iwCu
         rMJofs2nsATjXOhZEGO6mM+fRfezvO14BwpcKkrG8IWX73lfa91b3CMQDlaROZOb+edE
         xFIw==
X-Gm-Message-State: APjAAAUD3BX54w2yWEEB+VR6DP1xccC/KFinng1ZUXBFL5QdEPzMuv3i
        Em9iLWD/ZSZnNngYGzwBtUD78Z3fJzeLIg==
X-Google-Smtp-Source: APXvYqzN9pgf9JcM8hNHm1qgYTqQTBy9MWcPO0T3FepaIj4zxV6ty9yEuLwjv3B5E5HFH3/VhTte7g==
X-Received: by 2002:a63:f312:: with SMTP id l18mr2427297pgh.178.1580978356103;
        Thu, 06 Feb 2020 00:39:16 -0800 (PST)
Received: from localhost.localdomain ([240e:379:947:2855::fa3])
        by smtp.gmail.com with ESMTPSA id y9sm2387631pjj.17.2020.02.06.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:39:15 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH 2/2] dt-binding: spi: add bindings for spi-ar934x
Date:   Thu,  6 Feb 2020 16:38:22 +0800
Message-Id: <20200206083822.204534-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206083822.204534-1-gch981213@gmail.com>
References: <20200206083822.204534-1-gch981213@gmail.com>
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

