Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA603510152
	for <lists+linux-spi@lfdr.de>; Tue, 26 Apr 2022 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351877AbiDZPHr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Apr 2022 11:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235936AbiDZPHq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Apr 2022 11:07:46 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638ED6D4FC
        for <linux-spi@vger.kernel.org>; Tue, 26 Apr 2022 08:04:39 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-e93bbb54f9so6953342fac.12
        for <linux-spi@vger.kernel.org>; Tue, 26 Apr 2022 08:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FcA+zd06sJN2bonpfNe0YhUHsRy4PO73SgHuzDvEBII=;
        b=sxQ6b9jTnUIw6hPq86NeDABGw7qXR0+ztf70zZ46lTS2nhS8h1MY6gRcYY68P+vjpS
         81OYuX5B4UXwZ3ZRulaaTLOVUgSTgpUc1HZx5gld1f2bko/JWv0SbAcGrowVsguoQuqO
         QUlkGQXO+h603StBUncyPw1Y+LiFWZQ2xvjQxg+7EcDn+quB6T+/eUw28K6nR6upfnS2
         O0U+WljA+o1tRn71rC2R7NJPpuoNV1kBzqJ3vfaI6d4qAleWHnOiCBwWmsH70FDtqDHh
         vSCt0zoopb9sJgirB9WQ+tDjq5seXH8I1N6xQaRUMGinDICSDTSEdYDs0NkGfBiLQs25
         1KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FcA+zd06sJN2bonpfNe0YhUHsRy4PO73SgHuzDvEBII=;
        b=s6vh9Zsp3o1dDg+0fzfmGzTBHdDaSayswtexFJWnTQgGDr+0yrOl9c63qHl6iNavRu
         ukw4p91yEWu+XaY7+D9Auj43lLvPINFKuTBN2Hjl71cdDOSNDRxp9vI3oS6Kug6N6l+B
         JDYlBacOEJFqH/nR4CPmX49M3B9O1vWK3Nr9C2ulhfzr0IkTnCT/auSmHtDbU6w6cfHh
         NDAyRAtbG6MzDKMPafdde8SHd2eu4DHAkDx5PSu97nxnP9guopP9IfiJE5NSCPJ9WJSI
         5dkyPKv6umWG1RjJYp+IMlq3NIbSVIsqAhGAGPUdeVnnqwQATnm+XHNqSNH4M6JfFOc0
         Ke4A==
X-Gm-Message-State: AOAM53392M59cyxA+LBuXPzB8/Ta0E5whAbbWLNgUQcDPM8aP5VymvNn
        yTH62xbXJsw91JTamGcBVM5fKg==
X-Google-Smtp-Source: ABdhPJyXBxaXw0+wXc5PphFm+xwMfnCwuw3A+TNWNCCLUu3r+Wy057kaTZgvzpW+cy4OJfoJGfY93w==
X-Received: by 2002:a05:6870:3388:b0:e2:7175:ec80 with SMTP id w8-20020a056870338800b000e27175ec80mr9189185oae.285.1650985478705;
        Tue, 26 Apr 2022 08:04:38 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id l18-20020a9d4c12000000b00605a0961669sm3486772otf.26.2022.04.26.08.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 08:04:37 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kuldeep Singh <singh.kuldeep87k@gmail.com>
Subject: Re: [PATCH v3 1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
Date:   Tue, 26 Apr 2022 10:04:36 -0500
Message-Id: <165098546195.3050651.1304701874531348382.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404064017.68634-1-krzysztof.kozlowski@linaro.org>
References: <20220404064017.68634-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 4 Apr 2022 08:40:16 +0200, Krzysztof Kozlowski wrote:
> Convert the GENI based Qualcomm Universal Peripheral (QUP) Serial
> Peripheral Interface (SPI) bindings to DT Schema.
> 
> The original bindings in TXT were not complete, so add during conversion
> properties already used in DTS and/or in the driver: dmas,
> interconnects, operating points and power-domains.
> 
> [...]

Applied, thanks!

[1/2] spi: dt-bindings: qcom,spi-geni-qcom: convert to dtschema
      commit: 5bdcae1fe1c567c08e8bb7ef20fc70d0b70d5fc4
[2/2] dt-bindings: qcom: qcom,geni-se: refer to dtschema for SPI
      (no commit info)

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
