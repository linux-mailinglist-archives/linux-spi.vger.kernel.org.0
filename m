Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE619579737
	for <lists+linux-spi@lfdr.de>; Tue, 19 Jul 2022 12:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbiGSKDK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 19 Jul 2022 06:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237552AbiGSKCy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 19 Jul 2022 06:02:54 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370263DBED
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 03:02:32 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a9so23873036lfk.11
        for <linux-spi@vger.kernel.org>; Tue, 19 Jul 2022 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=TE1OHpxt0Gn4KYGNSFUw9hbvpfW/q/4s1pIHU3OBfG8=;
        b=UyBAHhlJPbk2RMIIrCx151UQM43DtmaVbDr7vMjzULHRvj0hWF1WSnZCJ4X8za/VtL
         bnSGemNq9ut0fGxisRsXApj4RiO7Ch5DGgERxykkqQ6MPh3eGHYcy9toS5tN4GcczF/f
         MGyFgPs1WsO0MNw+qA9otQOmeGhYlp8tLVguisqfjapEObqaDHAEcSle6upY2MOL3WEe
         g+PMs9wbTmj2w0XQmMg9chumSvKKyJiGlD3/JGUWlmF1GAUMDRZbTprg35wxvwHuAEAQ
         YIIG8Tz1dSGe5rDTTqgoZP/zbTDMawPpke+LoHQOJkimms1+uNNl+gMeM0cDPp3BZcay
         MMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TE1OHpxt0Gn4KYGNSFUw9hbvpfW/q/4s1pIHU3OBfG8=;
        b=EWn9e3dmtrlA15wmhg1gj6axsnZErMnn+K5H8WrQT4f0xWWhRQxcedk9wjk0qW0HmU
         UB99qDb3gAV0f6Wi/ghHfDJH/dM06FafS2JYAMOPvdfFPcog2hOAd0MHCMEAq1PO9L/U
         BMosLF2aKzrFH36uToMCbZxJUQ+2nAuCRLxtL1xJYV2OXM5DVHhuuLkpfFPrwMIeGjSz
         l1snXdfJdytPAVFGNqp3CDO8EjEn87K1VHDi0ILugUzzczbcPDicdJh12OMQVZ1AWgxc
         gHpOIU5D+7kBaQALfSRsGZ+rrypmeTMERLN7+wnDn1KR5//SMc7UICPIi4dP3m0ncbjD
         iOdg==
X-Gm-Message-State: AJIora+2qPYr4QGDgo21lYYkdOsISA8LNxxW5eYO8I1V3G1FPAS9nli3
        Fk5pZkG8qxQmWu+UR132dNwNow==
X-Google-Smtp-Source: AGRyM1vIkpompoYCkzed2fD3099X42TxhN9o9QjyEhnEqursvVyWwGRXgk+JNDyOROQWQa22XRf5DA==
X-Received: by 2002:a05:6512:1394:b0:489:6a91:272a with SMTP id p20-20020a056512139400b004896a91272amr16151476lfa.424.1658224950471;
        Tue, 19 Jul 2022 03:02:30 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id a4-20020ac25e64000000b00489e5ba2e26sm3123329lfr.63.2022.07.19.03.02.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 03:02:30 -0700 (PDT)
Message-ID: <03e8e543-48bc-240e-214f-12f649c141a8@linaro.org>
Date:   Tue, 19 Jul 2022 12:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: timer: Add compatible for MediaTek
 MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220715120114.4243-1-johnson.wang@mediatek.com>
 <20220715120114.4243-2-johnson.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220715120114.4243-2-johnson.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15/07/2022 14:01, Johnson Wang wrote:
> This commit adds dt-binding documentation of timer for MediaTek MT8188 SoC
> platform.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
