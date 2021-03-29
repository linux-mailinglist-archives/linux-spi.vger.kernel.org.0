Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339ED34C1AD
	for <lists+linux-spi@lfdr.de>; Mon, 29 Mar 2021 04:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhC2CAP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 28 Mar 2021 22:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhC2CAC (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 28 Mar 2021 22:00:02 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0488C0613B1
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 19:00:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w10so4107396pgh.5
        for <linux-spi@vger.kernel.org>; Sun, 28 Mar 2021 19:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e7eNiGvucTSfZ9YPwtIS0pxm8LPJi6oD0Avh087H1AU=;
        b=TUKF30VWRRBveRfhTx4XCTSt/6C1xFFD2llv8DleYNKMD5oOX79pVbO1s+WVZXKbTn
         GgMxHB7vKeTb09mxLijtXhhDfLp/Z2PXl+bPxRmLLTL5fbz6tTFBTl7PtB3RZMqKkpzz
         KRN2Yb4W+cnlZMjOr6fJy/sJw/jTyI7ikJLUzlQrzAe6ll3YFxVoOPI9I7Ch2WYoHzrh
         eEM7aGNGoANmY2i8AdBK6H7CWmxMvYyuvwSyVWKDgNoQ3lh22ih8RMp0ubYUBMNMo8up
         0/IGnzXdAyAI7cpLxIm/DRBtwHj2Oid+Bl1m74Fu/nVRRGy8fQ+uDyN9zmTrf1aNL7yY
         bHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e7eNiGvucTSfZ9YPwtIS0pxm8LPJi6oD0Avh087H1AU=;
        b=jM+9lo/BRYHtSO69jgTnOBL6lhNXe21zLRPkk4HlSuwSY1xdtA0VoW2/nU43OOKf09
         7UGZELUkQRyFz2ZXHr043pUP7N9EWDIfQieertmOrI8e9YCdz28YskD1z8zSWYoPs8Et
         75QKRn3uFHMvBDpVB3h5TkmRQdmQ6bZbfbO6fav4Qi33Y6BKu5FpdKttf6P8L4aZBxm2
         xpu7NCQ9cIC/4PDksjTi6li8IRHGYr6Trwpwpf1L8awavHcFHktW+DI2DiBn17fxdGjQ
         +GKQ8V1UfUUMiO7Odb8ZDUMs+ExZA8nPCz1KCnIToMMAdHgWJ32vFuSrxjKb7EKVfriU
         3ATQ==
X-Gm-Message-State: AOAM533WwBu7axwGKCVwLHQZSHR0/5uPJMd2oaO8poYaFDEDQXncfTpt
        2M+ww8DNV0AvL353Vhr/pp50yQ==
X-Google-Smtp-Source: ABdhPJz9qDrbHCn527IB9JHPAQJvkbN/YiK5DlwRYEaTjNNr5wbaltSygdeQhh7YIiOdzSji0D1ZDg==
X-Received: by 2002:a63:30b:: with SMTP id 11mr22031174pgd.245.1616983201423;
        Sun, 28 Mar 2021 19:00:01 -0700 (PDT)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id w37sm14728027pgl.13.2021.03.28.19.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 19:00:01 -0700 (PDT)
From:   Brad Larson <brad@pensando.io>
To:     linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, fancer.lancer@gmail.com,
        adrian.hunter@intel.com, ulf.hansson@linaro.org, olof@lixom.net,
        brad@pensando.io, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] dt-bindings: gpio: Add Pensando Elba SoC support
Date:   Sun, 28 Mar 2021 18:59:36 -0700
Message-Id: <20210329015938.20316-12-brad@pensando.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329015938.20316-1-brad@pensando.io>
References: <20210329015938.20316-1-brad@pensando.io>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The Pensando Elba SoC gpio driver provides control
of four chip selects on two SPI busses.

Signed-off-by: Brad Larson <brad@pensando.io>
---
 .../bindings/gpio/pensando,elba-spics.yaml    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/pensando,elba-spics.yaml

diff --git a/Documentation/devicetree/bindings/gpio/pensando,elba-spics.yaml b/Documentation/devicetree/bindings/gpio/pensando,elba-spics.yaml
new file mode 100644
index 000000000000..c93b481d4ad3
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/pensando,elba-spics.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/pensando,elba-spics.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pensando Elba SPI Chip Select Driver
+
+description: |
+  The Pensando Elba SoC provides four SPI bus chip selects.
+
+maintainers:
+  - Brad Larson <brad@pensando.io>
+
+properties:
+  $nodename:
+    pattern: "^spics@[0-9a-f]+$"
+  
+  compatible:
+    const: pensando,elba-spics
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spics: spics@307c2468 {
+            compatible = "pensando,elba-spics";
+            reg = <0x0 0x307c2468 0x0 0x4>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
-- 
2.17.1

