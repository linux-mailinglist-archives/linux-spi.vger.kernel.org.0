Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAB458876D
	for <lists+linux-spi@lfdr.de>; Wed,  3 Aug 2022 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbiHCGfi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Aug 2022 02:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiHCGfh (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Aug 2022 02:35:37 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF99E29C8B
        for <linux-spi@vger.kernel.org>; Tue,  2 Aug 2022 23:35:35 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y11so24989542lfs.6
        for <linux-spi@vger.kernel.org>; Tue, 02 Aug 2022 23:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zUs5OXdpIPcafuAcFTFXwdyEVO+2P2l8GKfKDHDBCoA=;
        b=Mkp6xLac58wQ7lQ4zUh3RlRb+2mWJONoA8PFlQ+DypHWWtrVV+j/kfMwlAMktqNKZG
         qG+JJZD3STPt0VrmZil0kVMgCzMopo95fshSkGMAxcyaLQAJhVll1QhO7EzThEOAAmxs
         Xd8vySHTzQ2fq5LaSUOZqoR2zWmZ2PBe1bv5DMIYl4fkyvuFZnmvB9+3wM7lNyaFxMQL
         Tm4vWB6zzRf1ZPhy0VYLb1wCSV60GzxjY0Eg2SbEn2nJkN+VlM5am7ZbcMY/CrvRSo95
         NBf7L7rov4OryFaLK4uv4KdB0rQKaU+XTCJ6xS/XfACfaJ2LWQ10T1ccy9kSNW15B6/x
         ZZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zUs5OXdpIPcafuAcFTFXwdyEVO+2P2l8GKfKDHDBCoA=;
        b=E2yhlCqHhscQHos7L2YChqCakQX85lMwnzOc9IQdoCzgjacF/d9A6XuGEMnZIh8PDG
         1fZ7Vl5U83HoLZhetoR57wj1+CkqoSKtzkIHhxRxPuN1uIrG8Ou6mfZXHue4vDhYrCfT
         pMs3XDDKbE92/GvxxyD72+VayXImJPpPoaziamsOhyz4fJT3aCSfENiQ6/wSo0EJCrva
         Zucfm1p/HNtBzKd8lzatFtW2p4xpFg3BT5D/l4mlBqM9FuX7s7iXzh1mh2NCjCqUM935
         ZSSJiqu+okVSWKsc999nV71GGZKXYdADb/ccHc8l/UzEuNzHaOQe3xQevR93A+Vk5YO4
         Vs1g==
X-Gm-Message-State: AJIora+WmmaCB3JJadkOZyAup3nJ5/XS92n6z/BIiUlj5k4Gn/sjd4lV
        p6AeXdyDY5Wjo5qF//+OdZbHRA==
X-Google-Smtp-Source: AGRyM1tOaCC0k3+KQSkAYDDw+fTk83oEbj8r3JVPMATVI9e6ZaKGatU/FZAj/Lp2/EVFK42jIbBvbw==
X-Received: by 2002:a05:6512:16a1:b0:48a:87a2:103c with SMTP id bu33-20020a05651216a100b0048a87a2103cmr9541403lfb.554.1659508534020;
        Tue, 02 Aug 2022 23:35:34 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id u10-20020ac258ca000000b0048af6a0c159sm1158579lfo.112.2022.08.02.23.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 23:35:33 -0700 (PDT)
Message-ID: <b322090e-278e-7dad-a37b-f6f2953c6a08@linaro.org>
Date:   Wed, 3 Aug 2022 08:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 10/11] spi: dw-apb-ssi: add generic 1.03a version
Content-Language: en-US
To:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
 <20220802175755.6530-11-sudip.mukherjee@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802175755.6530-11-sudip.mukherjee@sifive.com>
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

On 02/08/2022 19:57, Sudip Mukherjee wrote:
> From: Ben Dooks <ben.dooks@sifive.com>
> 
> Add new snps,dw-ssi-1.03a version to the bindings.

Use subject prefix properly identifying files. I do not have enough of
time to check 200 patches everyday if they touch or do not touch bindings.

> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 37c3c272407d..35aa04a85813 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -45,6 +45,7 @@ properties:
>          enum:
>            - snps,dw-apb-ssi
>            - snps,dwc-ssi-1.01a
> +          - snps,dwc-ssi-1.03a

With subject fixes:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
