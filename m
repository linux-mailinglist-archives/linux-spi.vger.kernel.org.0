Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A5E69AFFA
	for <lists+linux-spi@lfdr.de>; Fri, 17 Feb 2023 16:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjBQP6S (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Feb 2023 10:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjBQP6Q (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Feb 2023 10:58:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67DF4D61D
        for <linux-spi@vger.kernel.org>; Fri, 17 Feb 2023 07:58:06 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h14so6234106edz.10
        for <linux-spi@vger.kernel.org>; Fri, 17 Feb 2023 07:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vqrvv9VlZHyrCsyoCeOFdO8NAfEt4LpoGi0UcB/DA4=;
        b=Kn/d/3llbE2Kj1AKwHL+A4Nmc6QITBB0SMmumpZuknJYCUNrIT6PqZ9zNID37PkcS3
         LS/IN3CvpDYnQc0RoA76sPtibM4MqODdh/6woS2obIGh/fUhMhF/MGHQSO8OqH7xBBhv
         FnvEDiVMxzgcQLgDf9p8Vlx3syOhEmYNIKWgx9t3IttKRg/yI/TdbMh6lkKJebL47MAH
         8jnvvJxdrfmZqUjdi9SjXWdbg0reYE4+BRZdcej9NQnfFFYzhPseqdGucOvf4vzouSjv
         T2ItHIiYP38IS/ZtM8O+XJqJgtTHAzlhNRmYLT0kmDhbeaTAYYb1MJ1daaRWRRtWxckf
         mXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vqrvv9VlZHyrCsyoCeOFdO8NAfEt4LpoGi0UcB/DA4=;
        b=COns6aYRKbVgMqGBa5xJaJoNf25wNuNwCnnqUgRwwLUjNT7GAbXbjwIiCr9F1J2i9T
         JAlVz6FWM5Z5pEma8Hy2eaWA4FBXwKzheTDoGpenILPaE69qgip2JC5qcG6EUnufoXId
         JRGuBbWUSde1R0QI9og4S2sGzRLbaI2iDoXeIjr9imVtfTn7eMWlbtecHAA9CsJoycfM
         Cu3hkebGvLX5gW1Z00UE/SzXANp2VXUFc4S4+plxE1Vm835yqWnE72kpZpOXfaV45HMb
         aVQSdysfUc6jDuKZQLGhg86vjMJsTUryVQq6QkCpG9Kk+VEVCIt7B8vfw0UyB3jPi2/5
         HubA==
X-Gm-Message-State: AO0yUKUUd1lKn3US/KHf4PZY+rhQ6EWIL22QO/VXptzOPyqp1vFQc2zO
        cu06UpqapXjAW5eAzWG9zQ0SBQ==
X-Google-Smtp-Source: AK7set9WNW70/b2x1GCtNKIB7bBWNldXcCEndeMsTwO2enq32+28T+x4QwqdR3zni0PJeOEoUboK9g==
X-Received: by 2002:a17:906:6454:b0:86f:ae1f:9234 with SMTP id l20-20020a170906645400b0086fae1f9234mr1064383ejn.7.1676649485201;
        Fri, 17 Feb 2023 07:58:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w7-20020a17090649c700b0073d796a1043sm2255907ejv.123.2023.02.17.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:58:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] spi: dt-bindings: qcom,spi-qcom-qspi: document OPP and power-domains
Date:   Fri, 17 Feb 2023 16:58:02 +0100
Message-Id: <20230217155802.848178-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

QSPI on Qualcomm SDM845, SC7180 and SC7280 SoCs uses OPP table (both in
DTS and Linux driver) and is suuplied by CX power domain.  Document
missing properties to fix:

  sc7280-idp2.dtb: spi@88dc000: Unevaluated properties are not allowed ('operating-points-v2', 'power-domains' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml          | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index e94d915e28c8..ee8f7ea907b0 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -52,6 +52,11 @@ properties:
       - const: qspi-config
       - const: qspi-memory
 
+  operating-points-v2: true
+
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.34.1

