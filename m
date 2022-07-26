Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BB2581073
	for <lists+linux-spi@lfdr.de>; Tue, 26 Jul 2022 11:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiGZJ5L (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Jul 2022 05:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237447AbiGZJ5J (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 26 Jul 2022 05:57:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FC32F388
        for <linux-spi@vger.kernel.org>; Tue, 26 Jul 2022 02:57:08 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d17so19797243lfa.12
        for <linux-spi@vger.kernel.org>; Tue, 26 Jul 2022 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I73BOjVPhMR1wc1m6D3pt9KtMoseeendX/4GKU5hxhU=;
        b=uEAVBlqVVpEO4CRjG+b8EQKwATuT7yiqOEkQv2ZTiLFyrJ2jiaeYPaMsuRlf6yjGgI
         ZJMG1YC33LrAUnOLH0nIZwePRnjLOcyXgb5hUEmvl/VN0qoOyXr476hzGEvNh9WAbOgg
         HOmiqK27ag6K9Va5mWQyMOG4FYVmDG9FefW5OasSubq2C8mu++pER4+2qanR+JG5faBM
         F6yTP57/+k08+9lUA2BdtAR4Baq509d11FRvQSade9qtzPtSEB/RRK9P8nD3D174hQAC
         od5Bui/cx6nCgtoU7ZnLVGaHE73DLFShMwVJLzuV1kxlf+ShM1s8kLlPRbt3OymhUCb3
         xB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I73BOjVPhMR1wc1m6D3pt9KtMoseeendX/4GKU5hxhU=;
        b=EXjyra+PAfhhakn8neIm1lS59i34cDyoD1u/QxpfC9CZO2EnkrbZtRaRjZLdAl3aBo
         xQfwrqiA48FPvFSMzP2WUFrCDM8nrvST+Q8i7JICYBoIgelTR4jyQP/Ie9R9U4ZcIQMO
         kx0ghGFEYrQQp1HLjzQJ4B6WawpfYrshDlmSnWdkKHhjx88lsv9yrjzkj0yOrTNl6KYQ
         d6+tuaXip0z5/KigMZlAMJqKfxSRPCWb1ZvNQgBUuLCoHHjw2EdLHeR0osP9Zdndo30W
         BBMc4dd0k9Qil7TsOGfg52OxGeMBvLx1XWJwW6lWjN2hQb+HoyP75fKoFTqN86HD/crN
         LMRw==
X-Gm-Message-State: AJIora897JOipGA9OY73LDat6D2K7nBPLU34Drjhmp6lJ4WIU4bFcwjJ
        v1jwoztEg0eCwRQZYgQ9xrAIng==
X-Google-Smtp-Source: AGRyM1sK7VXFeDB7oQjs/mToNuKVBnT8UhRL+0xdhS1pEpYSUMMEDkLwMhuiBIzgXwdUH2Gx8I5lRg==
X-Received: by 2002:a05:6512:1288:b0:48a:aa31:2838 with SMTP id u8-20020a056512128800b0048aaa312838mr424327lfs.683.1658829426372;
        Tue, 26 Jul 2022 02:57:06 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512325400b0048a98b7bad3sm605377lfr.197.2022.07.26.02.57.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 02:57:05 -0700 (PDT)
Message-ID: <d34ff61c-d9b9-9f34-a00f-34a0304e47ee@linaro.org>
Date:   Tue, 26 Jul 2022 11:57:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 1/2] dt-binding: spi: npcm-pspi: Add npcm845 compatible
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
References: <20220722114136.251415-1-tmaimon77@gmail.com>
 <20220722114136.251415-2-tmaimon77@gmail.com>
 <20220725225650.GA2898332-robh@kernel.org>
 <CAP6Zq1j0pKHsX20t4ep9-6B_5pTe5MzkU__245F6tW7wFJESiw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1j0pKHsX20t4ep9-6B_5pTe5MzkU__245F6tW7wFJESiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 26/07/2022 11:30, Tomer Maimon wrote:

>> To answer your question on fallback, just put:
>>
>>     "nuvoton,npcm845-pspi", "nuvoton,npcm750-pspi" for NPCM8XX BMC
> In the document?
> because I don't remember doing so in other documents that I use fallback.

If they also you fallbacks, then the other documents have now incorrect
text.

> I need to do it in ymal files as well?

Depends on what you want to add and what you actually added... Let's be
specific - point to specific commits or files in linux-next. If they
were not applied - give lore.kernel.org link.


Best regards,
Krzysztof
