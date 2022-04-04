Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E174F0F80
	for <lists+linux-spi@lfdr.de>; Mon,  4 Apr 2022 08:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377515AbiDDGmV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Apr 2022 02:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377508AbiDDGmU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Apr 2022 02:42:20 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05942B244
        for <linux-spi@vger.kernel.org>; Sun,  3 Apr 2022 23:40:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id x20so1934565edi.12
        for <linux-spi@vger.kernel.org>; Sun, 03 Apr 2022 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aBZDFp5sBs6J3g/EbSOQZDxB8Eo5i8sxnYaCg1uwbEg=;
        b=wgg7ju3ElvWrT6cJjhmLfYxYRiDe9dwONdNcVNsWjgitTxkh+jv4A1Gy8ggvgum/jI
         v0M55S4lvjdwGAvtYDNJliPH9gPtNCTkZLODCjozOXPzv/lGEQebeK5YiZcktPWl4+gz
         /vNZhi6ZHkXxrKl+ew0pzV7Tx3hLmZTz2lckeT7GPm6FR2Ab/woZ9FT6yVo5Y4RWasUm
         OJ6ZaCd1Ku3EnYg4XH7XfJLl2TvZJbg0UPZGYEaQbAhzxUDGqlOFt3U+b5/ti+pGIlnJ
         ZaEYXZ0l30eUpv065UG/8UdHodq19smf58afb+TW7A40P5m4pAn8kRsHqQ3Wx6uJ1kwy
         wZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aBZDFp5sBs6J3g/EbSOQZDxB8Eo5i8sxnYaCg1uwbEg=;
        b=7cryfv/XxlUBI9aJ1+7gMq0i0hbzH1YiANeTFywsfZAXbT6oa/5z9mYWO+EwShABzW
         4FcTFDWcOG9PZFJhwc84shTrv7ZPOeJ7J69rlYO3FJCEnAMEDkp/NSz35h4SoxQpwaHB
         f+Pf/OkchIPRR/6fFFDCrD6LEfsvXebQHMGcFvcstwmjo53kJHFNfYef6THBtgqHzBew
         Zfb+uk0W5gAAXTJRX5bFDt7JARXKGMwOEH8cfl5F8Np3Q0qMRv2RztPTpcxlrfkrepSS
         OleIwjz1/XA0Ib7QHfIHrSd5NrjnaBM7/SgCV0RN6zwrXXsUJGf4ZscXDqorELR7Ussk
         DkRg==
X-Gm-Message-State: AOAM531DjbjMhwozq1F2vykYJ/ZVqVUCu24EuX68H/XcD0rO9jKmxox+
        FYMack9hvn9vk+PhxPcVXZ6ZKA==
X-Google-Smtp-Source: ABdhPJwLjXvgri1RM9eAm8lvCGBHie2/hsRTVk/DgPFdm/bBz5YZQF5gtz8n4QIxS0vPOxh4DYIKTw==
X-Received: by 2002:a05:6402:278f:b0:41b:79b1:39b4 with SMTP id b15-20020a056402278f00b0041b79b139b4mr19057440ede.163.1649054423382;
        Sun, 03 Apr 2022 23:40:23 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id i14-20020a50cfce000000b0041cbaba8743sm2676515edk.56.2022.04.03.23.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:40:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 2/2] dt-bindings: qcom: qcom,geni-se: refer to dtschema for SPI
Date:   Mon,  4 Apr 2022 08:40:17 +0200
Message-Id: <20220404064017.68634-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404064017.68634-1-krzysztof.kozlowski@linaro.org>
References: <20220404064017.68634-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

After adding DT schema for the SPI controller, the Qualcomm GENI Serial
Engine QUP Wrapper Controller bindings can reference it directly for
full schema validation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>

---

Changes since v2:
1. Add tag.

Changes since v1:
1. None

Patch depends on previous patch (DT schema conversion).
---
 .../bindings/soc/qcom/qcom,geni-se.yaml       | 22 +------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
index 690ce6a355de..1bc12b6a7e01 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
@@ -103,27 +103,7 @@ patternProperties:
                  supports up to 50MHz, up to four chip selects, programmable
                  data path from 4 bits to 32 bits and numerous protocol
                  variants.
-    $ref: /spi/spi-controller.yaml#
-
-    properties:
-      compatible:
-        enum:
-          - qcom,geni-spi
-
-      interrupts:
-        maxItems: 1
-
-      "#address-cells":
-        const: 1
-
-      "#size-cells":
-        const: 0
-
-    required:
-      - compatible
-      - interrupts
-      - "#address-cells"
-      - "#size-cells"
+    $ref: /schemas/spi/qcom,spi-geni-qcom.yaml#
 
   "i2c@[0-9a-f]+$":
     type: object
-- 
2.32.0

