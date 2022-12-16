Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3087B64EF55
	for <lists+linux-spi@lfdr.de>; Fri, 16 Dec 2022 17:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiLPQig (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Dec 2022 11:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiLPQi3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 16 Dec 2022 11:38:29 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954CB37F84
        for <linux-spi@vger.kernel.org>; Fri, 16 Dec 2022 08:38:25 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id h10so2693237ljk.11
        for <linux-spi@vger.kernel.org>; Fri, 16 Dec 2022 08:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=83sNQQmBGEirvzqJYz3RX8sTi0VRmPV5bl0Xq9X8ykw=;
        b=rRNZZxlvMnh1wEuofxTqtUL6nUtxNt3SqMBmaYMhcdc0V4kL7GHk2/cnV6A+kH62Zd
         xj0SZlOUvdSro4WdR54nbsG/GQ/ez8c3Uxi8siBWkpQIlFjOadJtpLJHwWgLTNn7HC+2
         NI81n02enH+e+8RihUJhT73N1f2rEL4WUYDv99nO8kb+hotyvQqAC1QVm+7IcAwjA0LH
         yBUxX97i1w1DTXv9chb1Yy68zYUBczJC+YqdLAfb6A950ndb618Kmp49qFgpYSCkM4dJ
         Wj1cL0drxruVxBFkz6kW1otgsyCW8uRLSq//QQVrcSRe+GwupeH4/YNo3eRqGG36TVsx
         1VZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83sNQQmBGEirvzqJYz3RX8sTi0VRmPV5bl0Xq9X8ykw=;
        b=qWQWv2/qj3Zs8ewyKQWBvI5VbqR8P7OTkCB+9lQmkwpf2xuvThsu/ZYnCO1r0hdoI0
         wvkkLNYV/ef7+cvENoXv5QfoxrIl2Pl0I/1epeKO0H/YJIZgHYJFCvbFv+VhRGbmMCCj
         4BJ+jUTD+lKtCUhGMKS+JM5mIAJILuVdqOsGbY0PPnMDd+gvbuW9Notyt/uUk5PKBcdI
         08DfoVqW0CfusUDRKS+KymSWxICNQ2MhZRUBpbGhgKMJUOzcI6rJUH1i/KuiUzbDhaJd
         Y3oODH/BEfRiP+ymBcVM82JHdOJnLcxVf6TiEdr80n7+v8AFcVIZMuu+epJKN5SijcUn
         MQbA==
X-Gm-Message-State: ANoB5pmZoBVpf7S1TlYbX+Tq2QggF3C6EVbHdBzAX7JQgDpcpQkKBzgL
        33Xx2PqmMGrQARytBpiVCbkhqA==
X-Google-Smtp-Source: AA0mqf7Rdcm9EYHRD5y29mbo2+xFYFFvLMJEqY/0w/N4zAg7IOWMV7wt/PTuPoVBKtkBnLyLj76ZUg==
X-Received: by 2002:a2e:8e6a:0:b0:27a:346:bbd9 with SMTP id t10-20020a2e8e6a000000b0027a0346bbd9mr7829817ljk.30.1671208703945;
        Fri, 16 Dec 2022 08:38:23 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eba0a000000b0026fc79fd67dsm193930lja.74.2022.12.16.08.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 08:38:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 2/9] dt-bindings: memory-controllers: ti,gpmc-child: drop redundant part of title
Date:   Fri, 16 Dec 2022 17:38:08 +0100
Message-Id: <20221216163815.522628-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
References: <20221216163815.522628-1-krzysztof.kozlowski@linaro.org>
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

The Devicetree bindings document does not have to say in the title that
it is a "Devicetree binding", but instead just describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # MMC
---
 .../devicetree/bindings/memory-controllers/ti,gpmc-child.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
index 4a257fac577e..383d19e0ba26 100644
--- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc-child.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/memory-controllers/ti,gpmc-child.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: device tree bindings for children of the Texas Instruments GPMC
+title: Texas Instruments GPMC Bus Child Nodes
 
 maintainers:
   - Tony Lindgren <tony@atomide.com>
-- 
2.34.1

