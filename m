Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537C06E1312
	for <lists+linux-spi@lfdr.de>; Thu, 13 Apr 2023 19:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjDMRCr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Apr 2023 13:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjDMRCp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Apr 2023 13:02:45 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE9EAD11
        for <linux-spi@vger.kernel.org>; Thu, 13 Apr 2023 10:02:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt6so934196ejb.0
        for <linux-spi@vger.kernel.org>; Thu, 13 Apr 2023 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681405353; x=1683997353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XoOyNFPqJ0IyHX6n7ulD4YPnMEOQxBao9Ld8quonbJ0=;
        b=JrwBIh8GEUkKj/EEowf3QZ6760qyjqgJUrSJyf2niCh3/BlzMBOVhNT3tk7HlzTFWD
         mKOw2MYzHGqeoEIHIzRVcKd3l8WSnR4Rkgw+RrbfN6KBUQlLDnEZsVtSbR3/8p8yqix8
         icmOuo3N7LZq/acKlzCJwcVf+a/SZMHk/aDcH9OcfHKgpoEH6bTsw/gWquwL6FXZjTa1
         GSmFdUhaq/GIu4FUO3uufNUElRJ9gBobwAW+HvlJbrIezUW8Kis94QEV3SlxJH8GGtl0
         X1fYHgmD2SGach4l9upERzUiq8J+1IiZZq7g1OtLDi+L/SB68L9qr7DbIS3cQFWSgnSu
         Q/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405353; x=1683997353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XoOyNFPqJ0IyHX6n7ulD4YPnMEOQxBao9Ld8quonbJ0=;
        b=fmhCCXjcwJSueDOHwOtPY02CmHsj8q+hUWVJIQsu72l+7YGV/UmCB7nf00/gD9/DHC
         uYaRS+92IAydU2IFZtwpq/Fi0c3bvlgffN5iGJWnSugEx5NCurmuImKGWb3ohGSwSF2b
         Dk/S1Zv56ezYDRi+onYaiLRAzBMtFRLTz0iMD9X2SPd8Y91oHwd+YJ6zARAsJfWpctjN
         Wi7K/U+YZEY2mYxgr8ol+Vnk6g5LlHMgNLnBexXljnvtbrPIl+5G8CFGSIdok3dYCtMM
         50NyA/LXN5qgnWpSaWeUE3+hkB7VE+HB3hK1fcCrlXSWNXwuYEJ0Pb7YQh+WngGHGU2Y
         w7MA==
X-Gm-Message-State: AAQBX9ft+93vEFfkrm1zMZmmFTb/0XDbfmI7xaTOM1qcdJmUsQVMlN/K
        KdM6TmGuABicDYagcxcOJpxipKHGOrfOGhpqigE=
X-Google-Smtp-Source: AKy350ZLt3GH7UNpajQvUMD1ybmwTF1APpaR4GhQSaxH0pMgd2y3kkQxOLVjvBq0LE802ESeop9DeQ==
X-Received: by 2002:a17:906:1447:b0:94a:6874:713d with SMTP id q7-20020a170906144700b0094a6874713dmr3300922ejc.56.1681405352314;
        Thu, 13 Apr 2023 10:02:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5032:d2d4:ece5:b035? ([2a02:810d:15c0:828:5032:d2d4:ece5:b035])
        by smtp.gmail.com with ESMTPSA id w10-20020a170906b18a00b0094a8115e148sm1230751ejy.87.2023.04.13.10.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 10:02:31 -0700 (PDT)
Message-ID: <45e20583-c905-a611-f105-309097572648@linaro.org>
Date:   Thu, 13 Apr 2023 19:02:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230412045152.4694-1-zhuyinbo@loongson.cn>
 <20230412045152.4694-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412045152.4694-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/04/2023 06:51, Yinbo Zhu wrote:
> Add the Loongson platform spi binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


This is an automated instruction, just in case, because many review tags
are being ignored. If you do not know the process, here is a short
explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for acks received on the version
they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

Best regards,
Krzysztof

