Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD4B6E5A0D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Apr 2023 09:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjDRHGM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 18 Apr 2023 03:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjDRHGL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 Apr 2023 03:06:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B427B1713
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 00:06:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id vc20so15639293ejc.10
        for <linux-spi@vger.kernel.org>; Tue, 18 Apr 2023 00:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681801568; x=1684393568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+D0q7Iw7kC4pQirExIbqNpaV2BkoBjtS/zbYfLGPKpQ=;
        b=YdWTY+b0JbdcvJIGLULiw+E7eFmc1jo0Nn70OT6NSrKdMTAHyYfCf/wFe0Fwp/rmm/
         VAfdeo6R6DIwH304NoKi7fhwMa811yqvgMrsaGRTs4CiFtNWD3p4M4cyDDbagS53VOIw
         seZjWqJgoYmk7wg5DwBf5UaA3TJI5+JU4pJKp2UvXjm/oiprq5xnh4SOe9B66cuEy+dX
         wKVRUqPBSZzF0pvRHBnNpXGjXB4uKh9TS6UWlaiQkiGZrxjDRDTqo4LOMwyV75NJsnAR
         ny+b2ORESe8ZLq7shOVBar5aYRmQo1cCPdLIE22deKstm4pgHnWKWrgvFOMrbt0/t3DB
         NgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801568; x=1684393568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+D0q7Iw7kC4pQirExIbqNpaV2BkoBjtS/zbYfLGPKpQ=;
        b=ho1pO6wzBjYiAm0FbOI/OWrdWm65VQ0Sr1yrP39DRqjjYEvCaWk3mrOxaFXt8DkL9q
         KR2IsbcXWTsI31Veq2dYC4ouD+KxqvBRKfL6vlxJ2CqM7Cbh2/R4s0QSg487Qsia61dJ
         FdKK0rYoo9/k09v4w124cubZiuVRYV0EJ6T39D6I0nxS95xM/tC/46JEs0nLjlzqMDvX
         FaMCUSiXQP8FNHLBqdrjTZKG8RSEj8AS8Mmgoe8qIo7YQbjOmnR4QyTkpzgHZk8zyPMY
         suMnJbtb7PuR4zSiCf9LBHlWLgDllTmIoUrG96/bsa9JwsErX500nupqz0jS7J+f/z0v
         pdKA==
X-Gm-Message-State: AAQBX9fzMhvL1ync1c8Psrw4Y57si6hW58TR0cDLHG7B1maVAFgcODoR
        tu2939rZVNrbiNnGiy/ckIdY0nBFt/OMCsNZ09AB9A==
X-Google-Smtp-Source: AKy350ZykbtrClI90pXvKbaBsf8ftpAs9c5AJprtnAIpnsiTE6BzqUvNDXdiBJgcCsMS1ypazOHKMw==
X-Received: by 2002:a17:906:3e5b:b0:94f:31ee:ba36 with SMTP id t27-20020a1709063e5b00b0094f31eeba36mr7743948eji.37.1681801568168;
        Tue, 18 Apr 2023 00:06:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id zy24-20020a17090734d800b0094f44bdf7acsm3644832ejb.57.2023.04.18.00.06.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 00:06:07 -0700 (PDT)
Message-ID: <87e1294f-405f-9be2-9b47-52cd29f7fd1a@linaro.org>
Date:   Tue, 18 Apr 2023 09:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v7 0/2] spi: loongson: add bus driver for the loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>
References: <20230412045152.4694-1-zhuyinbo@loongson.cn>
 <bafedfaf-9ffe-b0ad-d51d-d4b820da3a80@linaro.org>
 <81229100-a546-74b3-d626-09d042688746@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <81229100-a546-74b3-d626-09d042688746@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 18/04/2023 04:53, zhuyinbo wrote:
> 
> 
> 在 2023/4/15 上午4:43, Krzysztof Kozlowski 写道:
>> On 12/04/2023 06:51, Yinbo Zhu wrote:
>>> Loongson platform support spi hardware controller and this series patch
>>> was to add spi driver and binding support.
>>>
>>> Change in v2:
>>> 		1. This [PATCH v2 1/2] dt-bindings patch need depend on clk patch:
>>> 	 	   https://
>>
>> Can you stop Ccing fake address "loongson-kernel@lists.loongnix.cn"? It
>> does not exist. Remove it from all submissions.Recently, There was some issue with the company's email server, causing
> this mail list "loongson-kernel@lists.loongnix.cn" to only accept
> internal emails and not accpet external emails. The company's IT is
> working to fix this issue. and Ccing this mail list is an internal
> requirement.  I will not send emails to this mail list until this email
> sever issue is resolved.

You can always Bcc it, if you have such requirement. However your
internal requirements should not cause my removing all the time multiple
bounces...

Best regards,
Krzysztof

