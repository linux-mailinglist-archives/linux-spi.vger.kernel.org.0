Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60734EDE3C
	for <lists+linux-spi@lfdr.de>; Thu, 31 Mar 2022 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239571AbiCaQFN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Mar 2022 12:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239657AbiCaQFA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 31 Mar 2022 12:05:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E70F1F3780
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 09:03:04 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dr20so291791ejc.6
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 09:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jcWrz5TrJyNhaxoFYmO4lgnq7eBGtoxjK7xbYha4PXo=;
        b=r8BzjMpTRoFPYlIcrhEIiiFNqY3nDeQh5cIMgCU6NFdupw6iD7IDIvNvdmnWgQ979v
         jgBn4cpKlh/unHpVACD3KTbOvzOtNja+h07cQOMJ7o3C3t6uEZpldb9TmzDJiOAq5Pab
         LI54TUm13y1yk9To0Y7D8odhUtFjPMF52K+2AnQQHdtrrvSW4Svpcfai+awC1K3LKr73
         xqEoKsws3QspmXRysN5uK4xnYICil8RaLIeKaIbk7ptiIsW22swu50OvkmdzHmETAkKD
         FDS4XzH54CB7cPSXWfGT5wdT7shxYYNKlG7xcejTlhQE80T6WTFQr21p6EY4xd9y2RJa
         2iDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jcWrz5TrJyNhaxoFYmO4lgnq7eBGtoxjK7xbYha4PXo=;
        b=7P5RJp2vAf3gpb1Yb6mzdpczjjB1HIoGCd6M7vF4hSc1Ory01eJCwWlEWkUqEQge/s
         CTvUExp5gcp4VWU3eeP3p1PBwCVrpblELXI9PQcaBsI/CzyThNVUOtB9aj98JYYjC22E
         zxBRxV6ymAqLdxlpp8IjPj0yYgk9mfY9e58g2sf8qrHqmNL5yq5pU5gLrY8GMZN8DFFx
         2E/sEynVCB/8JTGSIoRruLbBOu5RRpdObEFYAtomgODcucDmzqjFh0lKFax0kIIYj5iZ
         9m8FrdRVWRwsOgrBrWuIRECaGKPBWe3UQRvFevtue6IGmMEsFxrHxMGl6u4GnEo9Po6V
         aq3Q==
X-Gm-Message-State: AOAM533/jj2nBr7zlmhZq2mjAWQmisKnM7W2Yji3MvEqgslmm1pLuRBo
        V87dxILBV2WhEPxgJoQc+KkBTg==
X-Google-Smtp-Source: ABdhPJzHZfsaSRYFEYW1zDw0qHQ7SsFDFv29uM2aL/nyJztaVS7eVwEPTx8XC77b9ZSrfkkFO1EUlw==
X-Received: by 2002:a17:907:3f82:b0:6df:919c:97a with SMTP id hr2-20020a1709073f8200b006df919c097amr5586102ejc.19.1648742582530;
        Thu, 31 Mar 2022 09:03:02 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm11441148eds.21.2022.03.31.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 09:03:02 -0700 (PDT)
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
Subject: [PATCH v2 2/2] dt-bindings: qcom: qcom,geni-se: refer to dtschema for SPI
Date:   Thu, 31 Mar 2022 18:02:48 +0200
Message-Id: <20220331160248.716234-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331160248.716234-1-krzysztof.kozlowski@linaro.org>
References: <20220331160248.716234-1-krzysztof.kozlowski@linaro.org>
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

---

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

