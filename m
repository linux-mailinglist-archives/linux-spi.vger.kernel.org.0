Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854D659FA59
	for <lists+linux-spi@lfdr.de>; Wed, 24 Aug 2022 14:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiHXMry (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Aug 2022 08:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiHXMrq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Aug 2022 08:47:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CC594105
        for <linux-spi@vger.kernel.org>; Wed, 24 Aug 2022 05:47:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id n15so2763307lfe.3
        for <linux-spi@vger.kernel.org>; Wed, 24 Aug 2022 05:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=HCkgWRsW68okr3HXj1aoAUOQtm+hBGu9v0QWmb8CPe0=;
        b=dWZ3lQkmAteiBhKIEs/l5SZZCUZ8+DJHs4otLWuEp1SbpTaZMfllrzHhq/mFEmZKV1
         LqkkfKqSJRt3ev3DV5xT0uCY+vPYIQIp2xelATaYKsNjcC2VaqaVDOZASKrYV9GUHk+u
         NGWbqEo00loFNO8FqKz67PHSIS+7q2nFag2WMRX0FmgX/xHr8hyE8ikCqrXNsOVl7Dhm
         w+MjdLXOUozbIBTCsOsIKDn2hZzsuTGZj30Dmtu/oASHN8wU5if4RptL8yPwWkzOIKB8
         90X5WJJaEXaeOLfBz+v5NGi0g0y4OCI9xibJAF2F53ib6vbc9eF/iI5ZRtzG3uaIsdMz
         LUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=HCkgWRsW68okr3HXj1aoAUOQtm+hBGu9v0QWmb8CPe0=;
        b=QSotNKFGrZfKscX306lSRxYvY1MeE2xkMPJf2LdYAIx9z5LW36MdrcVbcI8rnaHmeV
         CvoBRuFIOPvgJpweZO1R5KfNMp23E8EVZvfQPgNmMxDK9MD/bg2jJoUuis5pl19ZugkH
         Mm00dV08EKHYF8fA2jtJioDGEWEUV6phE/dutHlFQN4xUQuBfMPDvciCtH9b5Ia/BldV
         /ykHFWj+lRmCu2ZLRGmCebezP9J2EBQMSpX2Xs0mhBVAnsZdmnXfNdAjkCJu63UhlO2H
         vWPeWi8mRhv0MsxXsFbs0ylabUG2+ownyuM4T3yvD5O9hcsmpUb+klcmXj7iuQcO1EnT
         pg4w==
X-Gm-Message-State: ACgBeo2tqhyTAJCMT1vCv1cqREo8DcHzGZH+8D6jtz9GLkl6aJJXiAmC
        vCfGyqagOVtnk/4msz2rMuuXDkscIakQq3ni5Sg=
X-Google-Smtp-Source: AA6agR4eNUBQjn5HPo5JYDP4s9gU6xJOSJTUVA4FpSM9g3v69U0V1OpMhgoWrItrdVqemUex9AHSKQ==
X-Received: by 2002:a05:6512:2284:b0:492:ca50:d857 with SMTP id f4-20020a056512228400b00492ca50d857mr8249169lfu.209.1661345264775;
        Wed, 24 Aug 2022 05:47:44 -0700 (PDT)
Received: from [10.243.4.185] ([194.157.23.230])
        by smtp.gmail.com with ESMTPSA id p3-20020a056512138300b0048b07e82b8csm2996630lfa.55.2022.08.24.05.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 05:47:44 -0700 (PDT)
Message-ID: <91c2bf5f-8bbf-22be-bd57-a535bf4b95e0@linaro.org>
Date:   Wed, 24 Aug 2022 15:47:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] ARM: dts: stm32: argon: remove spidev node
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-spi@vger.kernel.org
Cc:     Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220824082130.21934-1-wsa+renesas@sang-engineering.com>
 <20220824082130.21934-2-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220824082130.21934-2-wsa+renesas@sang-engineering.com>
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
> Fixes: 16e3e44c5b87 ("ARM: dts: stm32: Add support for the emtrion emSBC-Argon")
> Cc: Reinhold Mueller <reinhold.mueller@emtrion.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
