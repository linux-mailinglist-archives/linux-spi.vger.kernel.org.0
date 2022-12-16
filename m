Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F7E64EF57
	for <lists+linux-spi@lfdr.de>; Fri, 16 Dec 2022 17:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiLPQih (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Dec 2022 11:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiLPQi3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Dec 2022 11:38:29 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8615E2EF5F
        for <linux-spi@vger.kernel.org>; Fri, 16 Dec 2022 08:38:26 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s25so2737268lji.2
        for <linux-spi@vger.kernel.org>; Fri, 16 Dec 2022 08:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB2IYQh6x04DNB10zL/CmKCXzeUTmaj+65fl29Cqpg8=;
        b=uVg3ZPHy2EpCn1WaZLJw7whZ1p9Hg8kuJ8Hu0byIVGS5dicapwpfsq5nmGGeVfFJef
         Hu/MxseBMTu3Z0NQNszjc9HyGfHZjdcSGEKsNBGiNgr8pHYiTcpBozktaglA26U3Q2o9
         XjGMWsBVlPaeTE2dpnCK8hsYPepqiPjjVxajaKqYEurNug7reKp1ZlrXGJikr5tFKUTP
         +kan/R2tOMEoHZh6L79CKSIiMhbsvAPHDdS9dkIu7jSPxbUlJ6v8bn+snEDCXCAzWYdb
         oU/PY5GCsNY006OE6yqA/QMCiVy/tNNdlFsx8BJi8r3Fv92h+oipAU9Hdsh4QpeV3eqA
         tJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB2IYQh6x04DNB10zL/CmKCXzeUTmaj+65fl29Cqpg8=;
        b=y854o6rCGm4QNwsVApKDQCTRV9D4+tZ3uL4vz/fdcwDP1/n07hvTCYytt07jD9+kS8
         Vxh5hi2nJWznXKJTh4HPBPNIwKvh2pYMVLkJyJBfsJbz/LTolfRn4ZwO/V8DGaJe++tO
         DEOZ/uEuYjaeAXhW4ee369mzH8QibcbsrZFj6ES26dA+WH2liXAnGphEKGgbdPefqGYf
         DRBrgafa+PF835G6u7LrfWGgGzwUoCXGh/hgypcvtNgFQj2r+IRJaqd7HsNK0uTWC1L8
         0Lri2ynnuiUD6Eb6KBGpvdGYOjub4KkTi7Bah0neecuWeebgwPePwO9d64pT8bvB7gil
         f52w==
X-Gm-Message-State: AFqh2krCFw/+cxNEDhaMmDBNqaOYGbwjgAHqA0Ck4SIUJd+g7Ld5H2GQ
        PxUa5BDo028fPdaqK7UM0CH5cQ==
X-Google-Smtp-Source: AMrXdXubTe0D+EfslMGdUtSrdWGMhnMozYFHYH02/3eOQQGq911tTzgLYzuhquCnebuvp0CaLBRuhw==
X-Received: by 2002:a2e:7c0b:0:b0:27e:cfe6:228c with SMTP id x11-20020a2e7c0b000000b0027ecfe6228cmr2060671ljc.21.1671208704979;
        Fri, 16 Dec 2022 08:38:24 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eba0a000000b0026fc79fd67dsm193930lja.74.2022.12.16.08.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:38:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v3 3/9] dt-bindings: clock: st,stm32mp1-rcc: add proper title
Date:   Fri, 16 Dec 2022 17:38:09 +0100
Message-Id: <20221216163815.522628-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
References: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
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

Add device name in the title, because "Reset Clock Controller" sounds
too generic.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # MMC
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
index 242fe922b035..5194be0b410e 100644
--- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
+++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/clock/st,stm32mp1-rcc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Reset Clock Controller Binding
+title: STMicroelectronics STM32MP1 Reset Clock Controller
 
 maintainers:
   - Gabriel Fernandez <gabriel.fernandez@foss.st.com>
-- 
2.34.1

