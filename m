Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D084EDDFA
	for <lists+linux-spi@lfdr.de>; Thu, 31 Mar 2022 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbiCaP4V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 31 Mar 2022 11:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiCaP4T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 31 Mar 2022 11:56:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F37A74870
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 08:54:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id x34so28656060ede.8
        for <linux-spi@vger.kernel.org>; Thu, 31 Mar 2022 08:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKGTMgRm2/BrDh+pWLzL6um9KANlYMhjAWBOG3cfNDc=;
        b=Z90CYObqR/ron7da1LrGo68CbsFdNGFaZ045Vt+RshuDHZKFXToiERNwkhS4Dk6ad/
         r+VZWpiwu5JfE/FlB85wab9vA5w7khhSsSd9aa0ix35prt6CHFqvt+rTFzGe4fMhiiVV
         UuRzDS0ublUgDSU94nBckN1w55njFHZ1yaN8cldV//mm5sxalqFU0hocfaa6jxs5qY0v
         WyS5+pv7d3B/KOnmA4g10S4PjzsffcVI/bfEc0RG7Agi0derIiSIaOeni/u4CW0tEtVZ
         JVlaVU6jMlOHxO49JpNq+LdbyscTvYJigzDgAadWLAM/CK/kQnePy3jUflQdGHoMeXGo
         0+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKGTMgRm2/BrDh+pWLzL6um9KANlYMhjAWBOG3cfNDc=;
        b=I4OGojoCuRbe6dmj+gZbBcDSLydPSlplMUJBiyT2snwp0pIyJrhn7kDFn4kmrmTgFN
         g87yP6gR+CMw0TZrkShU+VrNpPPCwI0WPIZZoicuq11VBg8NolQIQZV02CBbKfnbSVLd
         qRID9Pl8r/YtEizs9xOv449byuAai5evQTJDmP/dHYzUc2WHUw8RWNk5Oew38DqeC4Y9
         sA+/TmiTtfjtT+uiMl6lENzwlgU4we87DRtLI686vMYU/Ww9Q+704x65GpDoxwcOhjy6
         CXD1QCWI4n1VNoCJ8kXPBGnkILXMetqsyC/eCWYI1jiey8Z+MsOkUY5gZDTxVlJN+/w+
         Np5Q==
X-Gm-Message-State: AOAM533PuNvl+tkrGn68it9SomYJgvxiOHYQ1VwMwuqh5LXNtGQmggy4
        /0Fx6BbWg/edPsWt1VM5mP5yr3Mj8RT+f8JR
X-Google-Smtp-Source: ABdhPJz3nQJEzi+6rjuA0u0ISdfLGdjcDtwWkW56c3AL5SqQPY6brlNLgc2FeNLVl9JxHDsI8XBzIw==
X-Received: by 2002:a05:6402:278d:b0:419:3794:de39 with SMTP id b13-20020a056402278d00b004193794de39mr17056857ede.137.1648742070009;
        Thu, 31 Mar 2022 08:54:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id g10-20020a056402090a00b004196250baeasm11584077edz.95.2022.03.31.08.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 08:54:29 -0700 (PDT)
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
Subject: [PATCH v2 1/4] ARM: dts: qcom: ipq4019: align dmas in SPI with DT schema
Date:   Thu, 31 Mar 2022 17:54:22 +0200
Message-Id: <20220331155425.714946-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220331155320.714754-1-krzysztof.kozlowski@linaro.org>
References: <20220331155320.714754-1-krzysztof.kozlowski@linaro.org>
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

The DT schema expects dma channels in tx-rx order.  No functional
change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index a9d0566a3190..dc8260684aee 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -253,8 +253,8 @@ blsp1_spi1: spi@78b5000 { /* BLSP1 QUP1 */
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			dmas = <&blsp_dma 5>, <&blsp_dma 4>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
@@ -267,8 +267,8 @@ blsp1_spi2: spi@78b6000 { /* BLSP1 QUP2 */
 			clock-names = "core", "iface";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			dmas = <&blsp_dma 7>, <&blsp_dma 6>;
-			dma-names = "rx", "tx";
+			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
+			dma-names = "tx", "rx";
 			status = "disabled";
 		};
 
-- 
2.32.0

