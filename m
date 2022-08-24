Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B52159FA55
	for <lists+linux-spi@lfdr.de>; Wed, 24 Aug 2022 14:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237044AbiHXMrp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Aug 2022 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiHXMro (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Aug 2022 08:47:44 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B384D93229
        for <linux-spi@vger.kernel.org>; Wed, 24 Aug 2022 05:47:42 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d8so11457279lfq.0
        for <linux-spi@vger.kernel.org>; Wed, 24 Aug 2022 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=B0YHX1DxtYHmEtJGgAoy2E59Dxdr5pOaRwx+CNb8cXo=;
        b=ExdVABFFCg0YrICjQUHrRtJdAu9Mu2FYNhpTmNxI5Oii0WNEj5VBEnO51VbBoxw/E3
         Yp7qOO3VcJaosHeWvGY1Wu0hAIiwgBlDywDzFbUMx2CRh/E2mww94wSbXgDnlHQDPGqN
         iisSr1MMhf6gnNgkHqKjnrPsY6TxvRSPwdGcg64FOakvPZYTHGDDQUItixN3VB34s2dA
         HOZ/qbnzOUMatatsHAiuohCx+OW5MpYAsYd+wrDXAc0y/sfVSGA4+kFB+h+j0dMsVqm+
         p8rWyqRaKsrOqpf7LvOe3xzo9oiEwEYu5eR/PH9cHBBldStAdy7U+X7xrLdHR0B2FxM/
         vLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=B0YHX1DxtYHmEtJGgAoy2E59Dxdr5pOaRwx+CNb8cXo=;
        b=O/i2drzQucU8Le52s6I2haoL80kk1wsnOV0lj+Xv7DaBFXqfF65SxLYxnmNHpbTIDK
         LNdfUm2iHOrqGiqHuOYYFa6J9eYr1k759i9coi6ctUQDcnSrwOod5JxL61eb7pxSKbRo
         wlhuxqvoO91z0SxthYCar+iPB8WZ3eiG+vsQpDW9R+CHzSeatul6oy9B3oxm2p/tQKZg
         uSR7O1X7GH2EkaIa+RpBXpRyJeUCqQFQ6M6LPA9BQLREyhic32uKftCw1UVeg8ChI9bv
         R1RrKAEb52kCkZoK45+S27FuvTbgsTQazTXERqi+/jhY+yWUIGCHFJKwIpfYykZaXsyt
         KJDw==
X-Gm-Message-State: ACgBeo2Hc0Gk2dkZswXKVRvjJg6LbsXCKG6TcqMudlMLCsJ8p3ziZ6lp
        pIYUyLI5eZ99qNdRiQodH+jjBg==
X-Google-Smtp-Source: AA6agR4bRuL+NaricpxNR8LYFD1ua/hvzMiXB1+ErOc5A92wdvDFMqS/1LCh1V/LIRKZsw0D53rQxw==
X-Received: by 2002:a05:6512:692:b0:492:ece0:32e5 with SMTP id t18-20020a056512069200b00492ece032e5mr4275032lfe.636.1661345261144;
        Wed, 24 Aug 2022 05:47:41 -0700 (PDT)
Received: from [10.243.4.185] ([194.204.13.210])
        by smtp.gmail.com with ESMTPSA id u19-20020a05651220d300b0048b05882c28sm3006728lfr.271.2022.08.24.05.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:47:40 -0700 (PDT)
Message-ID: <1c2685e9-1501-8815-2cf0-b545bb91ca5d@linaro.org>
Date:   Wed, 24 Aug 2022 15:47:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/2] powerpc/82xx: remove spidev node from mgcoge
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-spi@vger.kernel.org
Cc:     Heiko Schocher <hs@denx.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Holger Brunck <holger.brunck@keymile.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
 <20220824082130.21934-3-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824082130.21934-3-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24/08/2022 11:21, Wolfram Sang wrote:
> Commit 956b200a846e ("spi: spidev: Warn loudly if instantiated from DT
> as "spidev"") states that there should not be spidev nodes in DTs.
> Remove this non-HW description. There won't be a regression because it
> won't bind since 2015 anyhow.
> 
> Fixes: 5d1d67e361ea ("powerpc/82xx: add SPI support for mgcoge")
> Cc: Heiko Schocher <hs@denx.de>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
