Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE4715409C
	for <lists+linux-spi@lfdr.de>; Thu,  6 Feb 2020 09:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgBFIpp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 Feb 2020 03:45:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36626 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBFIpp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 Feb 2020 03:45:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so2069865plm.3;
        Thu, 06 Feb 2020 00:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SiniMnh/RN6JalocAKlnItv6rVv3J8q3lmdsPVBexzY=;
        b=hTjfFX4wJc781CINonn04AQZ1w/lSUFluU+ZgGw25i8Y3p0AkDMd+9KclIGdLgmVJe
         UQuh/AIHacNBSG1PZ7zDoe59M1Q1/U//h/zgLmCEyX/NNPAa1VjfPKy/4lCwfMuPDxRr
         CC/SXSl8ngzJyle30kJS7bMIKB3MxgzGlw3WB/gzO+ZuLNZSo02s3cc0khE3/syM0JQl
         DhNretY+cix2Mt3zUbL3kGptMYFqxES/JL0II8p2710RvoInFNWf8SEmCdwucFdic1l8
         JQn9q9NLG8pfDo68spKNAX3DfYxYt5CT47CYnynuhxz5Ev9Xg2zO79pj8QkIYk3j7D7W
         9EXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SiniMnh/RN6JalocAKlnItv6rVv3J8q3lmdsPVBexzY=;
        b=NEkWQTyG4jTKMkUJg5MZNjHB0pyJ0Y9aGBxLsc4HvlKAppN0VtVUXW5wfkjO2dkMVR
         MMHvMJyQpsdFVqqImhZbBWtg3ddVnyxMWWh2yHK4g/qSxtAdO3Hr6DYW7THAZVAjygzU
         bmsyXy0ijSoPBUKJ0ZRhejqxer+cxKtjXOpRC62vBo0wrjl7rWEqFTVIHnPoNu+MiPYh
         zCvLONVUj7qhLhifu54QSPwwLS5P8OSaEDlW1G1HJd9CWjeCnWJq7ETioXPtvA2KhaTV
         OgJFtWC2ewmd6rbP9YDCuVu+9FewwfbCHLejxRTJJB25e9WlUkZAX74GnCH/do2DpaWo
         f7lw==
X-Gm-Message-State: APjAAAUNXP+NMj/2lfpUEQU8sBIiNKno5EzihUcQAQEDZm1+KnVpusNS
        KPIW0isFH9P0spv7AvDX4FQL5/BOPqfoxg==
X-Google-Smtp-Source: APXvYqxZF3bxh1VhPGEhNJEGf1eQQNcRMdlOX2LrkZK7zuHTNuo5O+zwlhNYMfRWLse70/QIByjk8g==
X-Received: by 2002:a17:902:aa04:: with SMTP id be4mr2701711plb.41.1580978744512;
        Thu, 06 Feb 2020 00:45:44 -0800 (PST)
Received: from localhost.localdomain ([240e:379:947:2855::fa3])
        by smtp.gmail.com with ESMTPSA id 6sm2638370pgh.0.2020.02.06.00.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:45:43 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH resend 2/2] dt-binding: spi: add bindings for spi-ar934x
Date:   Thu,  6 Feb 2020 16:44:43 +0800
Message-Id: <20200206084443.209719-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206084443.209719-1-gch981213@gmail.com>
References: <20200206084443.209719-1-gch981213@gmail.com>
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

