Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7AE5162DE
	for <lists+linux-spi@lfdr.de>; Sun,  1 May 2022 10:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiEAIl2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 1 May 2022 04:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiEAIl1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 1 May 2022 04:41:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6649047AF8
        for <linux-spi@vger.kernel.org>; Sun,  1 May 2022 01:38:02 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id p18so13528223edr.7
        for <linux-spi@vger.kernel.org>; Sun, 01 May 2022 01:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+yZt2h7tquI8MOBElSieXYW9QvRebVNtP1jshACVHMY=;
        b=IAnXJV43NRFADs4sfQ5Fhxnm+oF1P9yB9foyJB6M+7deEY4d8P5JuEYzLo3q0xZPnx
         SFhaovHue85djJGKmq9AkNnwem+sh/E/4VVdgUxDOekuc6sE8zzzcDCbqGzuniXlxJao
         scd87UuUudYnB/mCowWZ122N4BznVPPcEkCj24k1WFNnJzqlDMu9A8AykjC6v+IiTAs+
         s61Vtp/yRfQ/2vE+I1LWaGvtw8A1RLLuvYcrG0mPo315tvm/Mo3nULb7vO7u+SOchhtX
         bQ1V+CFn8BDD3PWWf2u29lX2jNdggbSpt8W1oJu282+l+hLcLQ8Z17Gdd33NA6Iibjif
         KXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+yZt2h7tquI8MOBElSieXYW9QvRebVNtP1jshACVHMY=;
        b=xpWTFX37Ei0mEifGcmgTISUbX5A0CZhLyE3kMklhvTK3RQQpKWMtE4c32ghBWBh5yq
         CG+Gd4035YQ8VU861sNNXXvDPL2GL9eJThSPTwtmMHJWuBrHwLZPVRT49qX0+aGvkLta
         xdN6i3npoh3m8jcx8F/BWoSJtSKr7x6s4BNFbQVlCpy+uHBDOkL66TgSac9LBsm82qqc
         kYXIRhcUMvBEUq7FF2n7FH8sWaWCD2//3QC9leAyxy9HxYxgGQWVZvx0h97wedoJVfDJ
         tFrvw3FTB5FnHxTDCTSmLJQW6tmDgAy/7HVnnC/BMO5jlm1TA+0CEb82aM0h84E2eKD+
         BLYw==
X-Gm-Message-State: AOAM533Dj5jAJuGZEI1yRhVWkLR6LwySBYyYsZWzANuWhsMJg5WLtIrO
        x2ykgdhRtpC7L3J1OVnIj7puypsOsemopw==
X-Google-Smtp-Source: ABdhPJz+LKO6Io1lqkoIhnpK6XOP/wNeJg9pQJhB/B2DVQ3148XxuJciQ+6Ck+AeoicJaNLMKREpFA==
X-Received: by 2002:a05:6402:26d3:b0:427:c57f:5333 with SMTP id x19-20020a05640226d300b00427c57f5333mr225317edd.61.1651394281018;
        Sun, 01 May 2022 01:38:01 -0700 (PDT)
Received: from [192.168.0.182] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id z19-20020aa7cf93000000b0042617ba63a6sm5024877edx.48.2022.05.01.01.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 01:38:00 -0700 (PDT)
Message-ID: <3f274302-dacc-5d99-2678-57870f05fd43@linaro.org>
Date:   Sun, 1 May 2022 10:37:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] spi: dt-bindings: renesas,rspi: Document RZ/G2UL SoC
Content-Language: en-US
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
References: <20220501082150.24662-1-biju.das.jz@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220501082150.24662-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 01/05/2022 10:21, Biju Das wrote:
> Add RSPI binding documentation for Renesas RZ/G2UL SoC.
> 
> RSPI block is identical to one found on RZ/A, so no driver changes are
> required. The fallback compatible string "renesas,rspi-rz" will be used
> on RZ/G2UL.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
