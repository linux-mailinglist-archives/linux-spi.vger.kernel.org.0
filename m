Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019196E2B3B
	for <lists+linux-spi@lfdr.de>; Fri, 14 Apr 2023 22:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDNUnX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 14 Apr 2023 16:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDNUnX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 14 Apr 2023 16:43:23 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A2A1BF
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 13:43:21 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id rp27so11642867ejb.12
        for <linux-spi@vger.kernel.org>; Fri, 14 Apr 2023 13:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681505000; x=1684097000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbvsfBiUpsWwp2EZA/U+fVvXwsafXqW9kWt8dct1hI0=;
        b=PQ4Ojz/ZluqgOOIrZ+k4NRMLyGMGqqUL2NfwOMLFMp4Ttb+DjRzphOfhbQG5KIU/Ez
         wkytAJFlqHFIdEvIRn76Z80E0jF7MhgtNB8ZIY8DbIYUvnQzSdzBseL2GgrbIDSXIqSf
         PaBFIhubjtwaBwfqB7e7deyng7A1zOK8i7117UQrTMPq9tcxxpb/DRvJLNyFhIEB4n0g
         VKWcBXmg3M4P/dqTszSoAN40lVAvqm2zpFdtjRg2ftQe7aNy4vOhmsMLGSLlXLIq+nWy
         vnmaPHyvadJ3zb2B20oT58P4nnV3YV8isd5gIJwnrfTty1psA8HHUHvPAEq4OXQ7dQDa
         d4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681505000; x=1684097000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbvsfBiUpsWwp2EZA/U+fVvXwsafXqW9kWt8dct1hI0=;
        b=dB9bWpxgXzjf98wxcjjeyKS9c9NS6nFmJLKkUosFZ90D2OvSTZsAxPjL3ZOyaCvNHG
         G8ktMW0rlIju4KKmXO0zHdnDDis9JoH41zLOdygYZPqVQOXkzxo8wL6MYgZut5ovceDf
         CYOTj8wa4Ys1dLg2dCI5kmNJY5fzdw7vgRYPmA7Fv1A+RLN8wiiRxq5vJwcRvII4EPUd
         y1A6z2SqJmF4cZ0Zd4pxDLbm4utyG9bYxqu6UtW87IYM4p/G6Bhz4RMVQl/6i2O2Tdj0
         h7RKBRvhfWAZW2PDoALLBZrlrkx3KRrrxKhRZZbR2zxnQ35lV4yBHUXBDMKoqDkpknEO
         0seA==
X-Gm-Message-State: AAQBX9cDcGOVV9eAWu9Z+GygL/JM+/GAH/ZKaQCedX1r0f/FJzSZor1O
        C696OAcTAwl1nGnAGLjImAZdx6NdBPixFgfP3aE=
X-Google-Smtp-Source: AKy350YXC3UocjmjmySCyoSnl1xQWm95ob71IRHYAanvJuCeh8REit80iFOGb+mJz5knOzx+RuvhfA==
X-Received: by 2002:a17:906:828f:b0:94a:4739:bed9 with SMTP id h15-20020a170906828f00b0094a4739bed9mr315836ejx.13.1681505000565;
        Fri, 14 Apr 2023 13:43:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ffae:8aab:ae5a:4688? ([2a02:810d:15c0:828:ffae:8aab:ae5a:4688])
        by smtp.gmail.com with ESMTPSA id sg32-20020a170907a42000b008c16025b318sm2840679ejc.155.2023.04.14.13.43.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 13:43:20 -0700 (PDT)
Message-ID: <bafedfaf-9ffe-b0ad-d51d-d4b820da3a80@linaro.org>
Date:   Fri, 14 Apr 2023 22:43:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 0/2] spi: loongson: add bus driver for the loongson spi
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>
References: <20230412045152.4694-1-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412045152.4694-1-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12/04/2023 06:51, Yinbo Zhu wrote:
> Loongson platform support spi hardware controller and this series patch
> was to add spi driver and binding support.
> 
> Change in v2:
> 		1. This [PATCH v2 1/2] dt-bindings patch need depend on clk patch:
> 	 	   https://

Can you stop Ccing fake address "loongson-kernel@lists.loongnix.cn"? It
does not exist. Remove it from all submissions.

Best regards,
Krzysztof

