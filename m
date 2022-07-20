Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD857BB83
	for <lists+linux-spi@lfdr.de>; Wed, 20 Jul 2022 18:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiGTQis (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 20 Jul 2022 12:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGTQiq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 20 Jul 2022 12:38:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B675F55091
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 09:38:45 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bp17so31187731lfb.3
        for <linux-spi@vger.kernel.org>; Wed, 20 Jul 2022 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fvd9V7Juu08ReWcT53m5hNTTBYCNZrfQiEXHbGmY0aA=;
        b=vldwu7CAQB0IXObmlhxchsshm7NzfimnIbvI8ZdvaPVofdUl2acwfm029QTQqJGg98
         vji6nQhWyQZX9DS4U6fCB25ADpZaTG9PiYwINIeT1aPvm3HAKjENiEX09APWT7Fp5fOh
         0eDkgBt0gI5snho9x5X1uTcbCLIR0Eo0yhT6SUqO6gr4D5G7MhNDFPJ1FRWxamFZBKAC
         jHBruiaY0RQmOnBugbXoo9SZUwx/wDRzvgO73PrXcHKUzsQGWnkEzjSRWBYeMdvbeoaE
         MYrt7atpbvl2rw37M5UOwCpgD9IQEwGiulnFQmqj3JQqI2wVOcDwD5BhuEPO7EzsfTON
         UP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fvd9V7Juu08ReWcT53m5hNTTBYCNZrfQiEXHbGmY0aA=;
        b=Agsh6eNRiERT+FL8DBJGenMsLvkV40kk198fsrnqJ6oU8twk9+yVmyP+dVNUA3zAfd
         Gni5ZgdseqS/VQ/r55iE43uJ2ut3PFUFkTW3WNrjAQT738K+zyP/turTZqSx/LLvj+R5
         wsp1IStuKv4Nf12EbOqHhUtCUhNbV5vMTjPF1RxCeY1YluT8dZgPGd3rX30aTvqoqf4M
         MJ9zER4TVhA5PK8mCceXWP48Qs/63fKPu8sG069WiZ6YSAwvxUjDJr8SnuCigjDrojzD
         Dg1Hycv/qPxQAajQQi71Cpa0CayiATdM47S9QN7KBZgVNQFaPZV1LxULDKK5HVh829xx
         4/oA==
X-Gm-Message-State: AJIora+4VQyW6nmGJiY0gJQMFh629vnhsJm71VpHYEAdM8V3To1LISGU
        YNMuWXWYBcSKxZTz8G7YqhU2qQ==
X-Google-Smtp-Source: AGRyM1vM8rGYfRvBRtGri6rWxjgLRf3nEXPtMp8hw4yCEtmiikJXnVoJl8pWmXIgitym8KTTRSD8ew==
X-Received: by 2002:a05:6512:3e08:b0:489:d3c3:e901 with SMTP id i8-20020a0565123e0800b00489d3c3e901mr19398437lfv.125.1658335124136;
        Wed, 20 Jul 2022 09:38:44 -0700 (PDT)
Received: from krzk-bin.. (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id p5-20020ac24ec5000000b0047f9cfa914csm2705369lfr.18.2022.07.20.09.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 09:38:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH RESEND v2] spi: dt-bindings: qcom,spi-geni-qcom: allow three interconnects
Date:   Wed, 20 Jul 2022 18:38:41 +0200
Message-Id: <20220720163841.7283-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Recent Qualcomm Geni SPI nodes, e.g. on SM8450, come also with three
interconnects.  This fixes dtbs_check warnings like:

  sm8450-qrd.dtb: spi@a98000: interconnects: [[46, 1, 0, 46, 4, 0], [47, 2, 0, 48, 12, 0], [49, 1, 0, 50, 1, 0]] is too long
  sm8450-qrd.dtb: spi@a98000: interconnect-names: ['qup-core', 'qup-config', 'qup-memory'] is too long

Fixes: 5bdcae1fe1c5 ("spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml          | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index 78ceb9d67754..2e20ca313ec1 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -45,12 +45,15 @@ properties:
       - const: rx
 
   interconnects:
-    maxItems: 2
+    minItems: 2
+    maxItems: 3
 
   interconnect-names:
+    minItems: 2
     items:
       - const: qup-core
       - const: qup-config
+      - const: qup-memory
 
   interrupts:
     maxItems: 1
-- 
2.34.1

