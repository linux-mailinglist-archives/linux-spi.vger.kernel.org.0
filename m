Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6E5497A39
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jan 2022 09:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbiAXIYC (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Jan 2022 03:24:02 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58586
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242151AbiAXIX4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Jan 2022 03:23:56 -0500
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5EFB04000F
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 08:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643012635;
        bh=E9f604EUNMRc1K0x625ft9mXrJ60309YtLmhBOy5gsM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WmfQ6/k5biHVhPXmcpnVGNMbmiVsK2/ApbS0Ms0uu7oR+Veem+kFqfY8sDudVBP4v
         w6bizTaONN3RrP5lFxiACL3wwKQF6c1ixs0LxMgLumjsU5pX6dmWB8Zk1fqGcKJ/r9
         u4PQCMYDmhB/P+qtVuu1RnMVDbXyV+5f//E8RbSvq8+yosoTY5IATVHZZiXGeTnoO2
         wx3DO9ipqsAuNfx+KkkLLCvg5uNt1EqED+NxVUfhgLEI0XBglSQF2Tuw6RmujDMUZe
         qa0JN+JFlBH8GeW0iV4Kwv2zzZT6YG192YScfm+zvde0PzZTkOaLDxTt7633tCZyK4
         u7WTOXS7mN1bQ==
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso10349916wmb.6
        for <linux-spi@vger.kernel.org>; Mon, 24 Jan 2022 00:23:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9f604EUNMRc1K0x625ft9mXrJ60309YtLmhBOy5gsM=;
        b=r2BkXH/pjrlKc3C+5sPog5FEel988Qqtig53V/b7A1phihS07+DGXI1590oQ4oNZvO
         q+mdKNYyYdIO8Ud6lx2Bsp2VLPisDOBaH+b7GlWHs/8q1K+ldXPzOdkkoAT2ekIeQuC/
         3SEBkNJDMQ6w29ulfSvBQjccu0bRFTNL/33azD4xGVxYbCWBCw3JoSmfAcIKnLz+bizB
         XgKX4WxVptZp7gkHkfRVSYesi2qlhyAoOHUZ2jZLnn6NMxqEYp9DM+0R2bd5aa/N/dSc
         MtWKlFv2eOFjkyZAnl9CzWZGPLnx3uNbtzd1GPOJ4rrxFjk08aofztOm3SJi1IDtgGhQ
         20ZQ==
X-Gm-Message-State: AOAM531LJifcK7JNZcXPjyHqsMdVREJFkYh/RDcZxBPsRdktKCYdHA1n
        uyCuqgIfTKYlK0YWrs3sIaw63xusoIwjbv3mKZmFbyVVICtLI1hXwSzPKfxKPFZAK8TlMxn5OQn
        UcYfxLU+YNASp9mlfQMykxtIbc9rBp9igxzhEYA==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr9501285wrq.339.1643012635036;
        Mon, 24 Jan 2022 00:23:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzpvjCvKyZkS3eDZZP0ZWE7Zg9akUafDchzT87csJ7JBjny0Ukmeg3wKlAmCj1K+MrEAi1FMw==
X-Received: by 2002:a5d:4803:: with SMTP id l3mr9501274wrq.339.1643012634897;
        Mon, 24 Jan 2022 00:23:54 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m64sm7148550wmm.31.2022.01.24.00.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 00:23:54 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Pratyush Yadav <p.yadav@ti.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v6 2/4] mfd: dt-bindings: google,cros-ec: reference Samsung SPI bindings
Date:   Mon, 24 Jan 2022 09:23:45 +0100
Message-Id: <20220124082347.32747-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
References: <20220124082347.32747-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The ChromeOS Embedded Controller appears on boards with Samsung Exynos
SoC, where Exynos SPI bindings expect controller-data node.  Reference
SPI peripheral bindings which include now Samsung SPI peripheral parts.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/mfd/google,cros-ec.yaml          | 29 ++++++++++---------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
index d1f53bd449f7..525ab18005b3 100644
--- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
+++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
@@ -31,7 +31,7 @@ properties:
 
   controller-data:
     description:
-      SPI controller data, see bindings/spi/spi-samsung.txt
+      SPI controller data, see bindings/spi/samsung,spi-peripheral-props.yaml
     type: object
 
   google,cros-ec-spi-pre-delay:
@@ -148,18 +148,21 @@ patternProperties:
 required:
   - compatible
 
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - google,cros-ec-i2c
-          - google,cros-ec-rpmsg
-then:
-  properties:
-    google,cros-ec-spi-pre-delay: false
-    google,cros-ec-spi-msg-delay: false
-    spi-max-frequency: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - google,cros-ec-i2c
+              - google,cros-ec-rpmsg
+    then:
+      properties:
+        google,cros-ec-spi-pre-delay: false
+        google,cros-ec-spi-msg-delay: false
+        spi-max-frequency: false
+    else:
+      $ref: /schemas/spi/spi-peripheral-props.yaml
 
 additionalProperties: false
 
-- 
2.32.0

