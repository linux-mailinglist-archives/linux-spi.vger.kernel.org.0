Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF18745D5A
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jul 2023 15:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjGCNbT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jul 2023 09:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjGCNbS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jul 2023 09:31:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5B7E60
        for <linux-spi@vger.kernel.org>; Mon,  3 Jul 2023 06:31:16 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so5583996e87.0
        for <linux-spi@vger.kernel.org>; Mon, 03 Jul 2023 06:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688391075; x=1690983075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/gQKrgv9jl26df4nD8+qhw8ZnBWlEQchlmkvSgMYjQ=;
        b=l73yEXFOeig5qdtuMpI+ALwg4IVM0aw9hMZjHVFwaUTnXiGtujvGJewYdsk1tleRB2
         z5tITNcyfBvWbsRHjpFGGK9a0W/F52UoOdp0EWnav7IOMCgJf0zfkzpmgKx+aFVokbco
         l3jNynIeC4wwqc+g44wcjQN5AQwMi6M5kzm90uknSp01Mkpti5/bMT90w27Ts3yD+fE7
         MvtWhkjLwinbSN/UdfRchpILrNNaHLGs0aIZKmqq2h4ECaoHOUzA/QBvxsgLMOZ3jvvV
         vnIyUzgheqLU2ZkOn+8epAM/lRzIhipLWJuEU6Q3oNUjF2vCHFMYhU1FA5ilKCKscZRZ
         DmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688391075; x=1690983075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/gQKrgv9jl26df4nD8+qhw8ZnBWlEQchlmkvSgMYjQ=;
        b=NHsrqth5zBH8kjab8DtgvLSY4P/eWp6a7WEodC9/IcslJ7g1aBE6kexA37Zyvk1bID
         uWR8A2cerPEBw5mltN+Ma0W3tUAT3SQqt6TZzhG/uExDzoIe+Y2IBaq+5w5wZxbB6V8m
         QfmjfXGWnHCDUnK2mkgk0h8CdRkUpQZ60d951N5J/hpDW/MvMYd9cqGB+rIMPBP828BD
         PeOxuqhqlNQBaMtxgEPB15ncjK2+qkoUAGHoO/72DyxgoPSn1dz49FrUOuE6ds7/B2tn
         pkfDs8LabGG45X1R2/y7muEmWAYDN+OWqqoOV88QJKzG88ebn6nLvfszBvFAI3UcaoRO
         pV4w==
X-Gm-Message-State: ABy/qLZcCbJmHIRf9HSW9J7u14knsLJOWtmR355yH95LoHDDqi1qijj3
        B2q/NPjjSrguVm3pP5JVPvD8iA==
X-Google-Smtp-Source: APBJJlHpPmW37wHbYhD2VatnWDTXUi9XhtZ9muHG5jeTKYozptLFtx9Ha1cNS8EAgJxO9jLR4qBMmA==
X-Received: by 2002:a05:6512:3c87:b0:4f4:a656:2466 with SMTP id h7-20020a0565123c8700b004f4a6562466mr3914367lfv.15.1688391074973;
        Mon, 03 Jul 2023 06:31:14 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id ep7-20020a056512484700b004fbb1f70ceesm833417lfb.227.2023.07.03.06.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 06:31:14 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 03 Jul 2023 15:31:10 +0200
Subject: [PATCH 1/5] dt-bindings: spi: spi-geni-qcom: Allow no qup-core icc
 path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230703-topic-8250_qup_icc-v1-1-fea39aa07525@linaro.org>
References: <20230703-topic-8250_qup_icc-v1-0-fea39aa07525@linaro.org>
In-Reply-To: <20230703-topic-8250_qup_icc-v1-0-fea39aa07525@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-i2c@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1688391072; l=1083;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TQNTCWE+iBjVfoMqrm2paazex7hqvKkpoTz9pkEkyKc=;
 b=cStngA5XatURTQAcTPIg9usdXNHDCeFjDqHlJO5FM/ZH4iA7azJ01kuuVe06R9jsSSgwZ4aUm
 VBUl9Y1tbCiDUoxFvB6NfWRfJ1/5XpZHtnKTkXLnTdFJOWHEcbjMsUq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some SoCs (like SM8150 and SM8250) don't seem to provide a qup-core path.
Allow such case.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/spi/qcom,spi-geni-qcom.yaml       | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index 2e20ca313ec1..2890c4968c2a 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -49,11 +49,16 @@ properties:
     maxItems: 3
 
   interconnect-names:
-    minItems: 2
-    items:
-      - const: qup-core
-      - const: qup-config
-      - const: qup-memory
+    oneOf:
+      - items:
+          - const: qup-config
+          - const: qup-memory
+
+      - minItems: 2
+        items:
+          - const: qup-core
+          - const: qup-config
+          - const: qup-memory
 
   interrupts:
     maxItems: 1

-- 
2.41.0

