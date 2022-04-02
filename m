Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86C44F058C
	for <lists+linux-spi@lfdr.de>; Sat,  2 Apr 2022 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355985AbiDBSmh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 2 Apr 2022 14:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345405AbiDBSmQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 2 Apr 2022 14:42:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FF5483A4
        for <linux-spi@vger.kernel.org>; Sat,  2 Apr 2022 11:40:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v30so757836wra.8
        for <linux-spi@vger.kernel.org>; Sat, 02 Apr 2022 11:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oehOK4VAqzTxqC5buHxSssXxgO+RDZMIgj7zOteyqjI=;
        b=QX+XZ2MJAuoGxznp0+bDOYTTk/lB8ghvn8FRCX/2INb7hsJ5n48AAKa45seArdlTf7
         o1qARoYK4z3NyBGCvEm9yCxy1mnAqOTqgwnPnPkzI+7AQmkAv9UVWA0hLhlkU12WkYMw
         FrrupzS5OOI1ifO0ltTZbPpqs0UmR61wH0oYpiP9Sg5FtIpCK3kNrlvexMQHaKAWo+ob
         U0yS3y8K2gLKj7Js6VfcKp0/3wv+R7Vdua0iknQbe5Xg1ImjEOrI5ZVyA+3Jkkf6EaiN
         soMxonm/AsIh1FbrifW3ASou6SmzlrwghvHu5YoU8Zt7cCGfifkNNbx5UlKKf9pc/Ceq
         0e8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oehOK4VAqzTxqC5buHxSssXxgO+RDZMIgj7zOteyqjI=;
        b=OXfZbhTQ5PwyI0d4tPaCBQM4H2Qc2ncYMalVush8cGpvHwXhf0uwVAuPsDkaxsAR/q
         oBf57dTZHw62CJ2nJ2S31e7+PqTydYKrNu/4ZnW9agKwuo8021Ze8LWcYw3RkrZOVDLk
         ysoZguOrV4rlUJEHpeWbAZscNX/IpB/Yl93tz2N0A+o5Qc0cH5bUay+gQwTabJa6+bhj
         GcBGRTpGxzWlclqzBR20nsGrB9UkP3klPoD4pWS2DxzBo+UeqYmOCD2+NpNs1j7wQ/Vm
         ZSG78Ods8CmamdL05J02lBarQCn3KurF/SD9mCllw/Z6KBRoFF7moLBPj8ZYFhQAI30N
         B/2g==
X-Gm-Message-State: AOAM531N4ZBkvn8lSxrVeQex6y5+PIOdbtsQLUbxBHbGkTrUor95/YA/
        Q2EHA2dfEID3ZTpdd4CgalhrLglOjawegQN2
X-Google-Smtp-Source: ABdhPJxrUeFwqSX+rD03NAs4YoRrPMJ6QWY4w7aYjRhLNc0vbueAXFtS7rXOX2O7syQlX9O178aItg==
X-Received: by 2002:adf:eed0:0:b0:203:f2e2:197b with SMTP id a16-20020adfeed0000000b00203f2e2197bmr12528432wrp.604.1648924821158;
        Sat, 02 Apr 2022 11:40:21 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c4f5400b0038b5162260csm6760502wmq.23.2022.04.02.11.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 11:40:20 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/9] ARM: dts: qcom: ipq4019: align clocks in I2C with DT schema
Date:   Sat,  2 Apr 2022 20:40:06 +0200
Message-Id: <20220402184011.132465-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402184011.132465-1-krzysztof.kozlowski@linaro.org>
References: <20220402184011.132465-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The DT schema expects clocks core-iface order.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 1f6c4ab7f37e..897442157f5f 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -276,9 +276,9 @@ blsp1_i2c3: i2c@78b7000 { /* BLSP1 QUP3 */
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x78b7000 0x600>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
+			clocks = <&gcc GCC_BLSP1_QUP1_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
@@ -290,9 +290,9 @@ blsp1_i2c4: i2c@78b8000 { /* BLSP1 QUP4 */
 			compatible = "qcom,i2c-qup-v2.2.1";
 			reg = <0x78b8000 0x600>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
-			clock-names = "iface", "core";
+			clocks = <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
-- 
2.32.0

