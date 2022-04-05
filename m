Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237174F233B
	for <lists+linux-spi@lfdr.de>; Tue,  5 Apr 2022 08:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiDEGhQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 Apr 2022 02:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiDEGhP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 Apr 2022 02:37:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C19186F3
        for <linux-spi@vger.kernel.org>; Mon,  4 Apr 2022 23:35:15 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p15so24518379ejc.7
        for <linux-spi@vger.kernel.org>; Mon, 04 Apr 2022 23:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0FPva/xF5QWD9GuBZmkDF4zJMJFtPU9JUPVfss7wEgA=;
        b=sgs8fnLUD89sfYTrE+ztbdtKCYlSgQ+3jxn5yhXrqMc5/ygGoNFT9KdojhBNjhW5sQ
         3FZFGS7u9p4kre51GpHTdZxhjcsDBDal75fVqCM+V2KJ0MInK+oHGpzcCogOau2/4suk
         Zzk35Zfvr4MM/M+bTbcE+hFMvsKhrNrHoXvylaUb9lewRt2e3cZIfg3307dIFH8TcjqB
         xCXVXe14n48fLpEZiRTKH1DHmsnnQVXbWf9BjxlcFZ9wjbbLurOCm+E4/aUniwvNUFTX
         9NHxIInARpWhVFOC7I3QJoIN204dgvT6gf+i5PYIZUcmulal5wLFADust1lEx+J/Mdp/
         INjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0FPva/xF5QWD9GuBZmkDF4zJMJFtPU9JUPVfss7wEgA=;
        b=Py4z/I0b5F3xESmhpEuWuSeXv9iHv9Y1ZO4dqgZ4gYxdEQLsiHDv2WbbV6to3Z0cdr
         yucUSv8U6D6+8Ep7kRrzw7I9BhTNV7wSQsqoIU6aUP6T6F0+ZIXHvkZdN82AUfoePd1z
         +kkFqNk6uQ1QRn8RSYJ7DaoJIhyZSXKJ4vgeMjDPjlYAR6HGzhbmB9mnivdC37Caswke
         AVVDU66tjPTQ6t2QZuAVVL+yNBScppwjGjLVm9Vs7SoyyFiH53X/lugmeY7oprSYwuJ+
         bn/Bge5NhkaEUw1sM8MIAsXoDpfIOMACDo8V3oaSOo8CWQaLlwz6pBkCYM2h7sOKgNbk
         DBFQ==
X-Gm-Message-State: AOAM532e0rYpH5kL9YU84jWR8cXQaLuQTBeKOU3QANf8BsDQT8vfZZTk
        4giVs21Mne+0IPrL64u/HJTOBg==
X-Google-Smtp-Source: ABdhPJzRmLtL4M11x2CZ4rufphPdePuc0MVn8NdfZVbdMzqOXEYcT4hpNY+as9aYXAgrEeEOH0BLQg==
X-Received: by 2002:a17:907:168b:b0:6e7:f2a5:bb0f with SMTP id hc11-20020a170907168b00b006e7f2a5bb0fmr1991664ejc.162.1649140514379;
        Mon, 04 Apr 2022 23:35:14 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bs7-20020a056402304700b004197e5d2350sm6086543edb.54.2022.04.04.23.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 23:35:13 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 5/9] ARM: dts: qcom: msm8660: disable GSBI8
Date:   Tue,  5 Apr 2022 08:34:47 +0200
Message-Id: <20220405063451.12011-6-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
References: <20220405063451.12011-1-krzysztof.kozlowski@linaro.org>
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

The GSBI8 child node (I2C controller) is disabled, so as parent GSBI
node should be the same.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-msm8660.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom-msm8660.dtsi
index a258abb23a64..47b97daecef1 100644
--- a/arch/arm/boot/dts/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8660.dtsi
@@ -212,6 +212,7 @@ gsbi8: gsbi@19800000 {
 			ranges;
 
 			syscon-tcsr = <&tcsr>;
+			status = "disabled";
 
 			gsbi8_i2c: i2c@19880000 {
 				compatible = "qcom,i2c-qup-v1.1.1";
-- 
2.32.0

