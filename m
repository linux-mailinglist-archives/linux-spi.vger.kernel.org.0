Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B4B6C9BE7
	for <lists+linux-spi@lfdr.de>; Mon, 27 Mar 2023 09:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjC0HWu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Mar 2023 03:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjC0HWt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Mar 2023 03:22:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA2D49F6
        for <linux-spi@vger.kernel.org>; Mon, 27 Mar 2023 00:22:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t10so31660334edd.12
        for <linux-spi@vger.kernel.org>; Mon, 27 Mar 2023 00:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679901767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CFNarKRRJksS00saRO6cxhezfG372oWTTPfol9sWbtI=;
        b=DmU9nnEK7bNf/dHFFm/RQKVsvo497gWyF+EyPJw/LoUyZkSQoD0EfLmkuDq7LvWRQ/
         SBm3OmC7v+/8mmMRlg8kxatMTs99xVsiIkndFPKNafuVgtFLmKDff3VDbKVywayGPIFL
         MEdULSg/WAmCXQxPqqeL8iao6Z16Nb5BAHIck7IjxB+F7lvfj0UkzyLR0h+ebLLtYsCP
         m+GlHsFc5CN6ZfVrbJDhVAwjbd4lzB8WdUMuSba04Qfi2ICqA9YX5oX7L1wD2I3Wcv4N
         2UJddfIsEOdsHIR9UblfBaXP6T5RjdCiEz8hW0CGpUpauGlkQdXkwUiPTZjP6it/k3Fh
         IPSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679901767;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CFNarKRRJksS00saRO6cxhezfG372oWTTPfol9sWbtI=;
        b=oseR1QBSmB/Ts8CtJZGc1/WkhI/RB9GaT21VsiPWdDTi0Zyos3EAPX7rtr9ckFUs+s
         1m4TnVwWXYQNVd+Er+5LtYDeP7wbY7cclyj3u6LXiAUzm+ekixrY9VOv4+KPWKV0TewV
         SL5c5NBCqiPFoe7NFOuUXp5b5BzMKGzqjq2wx9oJ7yKoAWZzWc9RXPk+1Q+K4zJ0XMbS
         r0GwEdt3OQa/6HkXTzWSFUrrO0zzlpkkaDcEVE1DIXZXXwn41y2keEMVeCWPXhOx2UsQ
         qib0irHTaX35O1pWZYg1qb+CTnF9W2iSelKiIEehlycKXnYBhQKYblX9jSaTs6VWW8QE
         f1Uw==
X-Gm-Message-State: AAQBX9cLKqmaGYOVMVcxZHFi52FKkAyZ4cfqaXQ3CWDmh/RMds8k/2cq
        zoCD9ThP5jgNELX+edJ5MIYsiw==
X-Google-Smtp-Source: AKy350bmGPQAtSCpEFubJRJcmrx33GQPnEKKpDAJnxWTGClLd6jkcPIc3e0gKQQNdIuvIRS213DbUg==
X-Received: by 2002:a17:906:f143:b0:933:4c93:69ee with SMTP id gw3-20020a170906f14300b009334c9369eemr11864771ejb.45.1679901767018;
        Mon, 27 Mar 2023 00:22:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:198e:c1a5:309b:d678? ([2a02:810d:15c0:828:198e:c1a5:309b:d678])
        by smtp.gmail.com with ESMTPSA id g12-20020a170906198c00b00930c7b642d0sm13732976ejd.166.2023.03.27.00.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 00:22:46 -0700 (PDT)
Message-ID: <510cf7ac-3f7f-49e2-b384-424c931b2750@linaro.org>
Date:   Mon, 27 Mar 2023 09:22:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 07/14] dt-bindings: pinctrl: qcom: Add output-enable
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230323173019.3706069-1-dianders@chromium.org>
 <20230323102605.7.I7874c00092115c45377c2a06f7f133356956686e@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230323102605.7.I7874c00092115c45377c2a06f7f133356956686e@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 23/03/2023 18:30, Douglas Anderson wrote:
> In the patch ("dt-bindings: pinctrl: qcom: tlmm should use
> output-disable, not input-enable") we allowed setting "output-disable"
> for TLMM pinctrl states. Let's also add "output-enable".
> 
> At first blush this seems a needless thing to do. Specifically:
> - In Linux (and presumably any other OSes using the same device trees)
>   the GPIO/pinctrl driver knows to automatically enable the output
>   when a GPIO is changed to an output. Thus in most cases specifying
>   "output-enable" is superfluous and should be avoided.
> - If we need to set a pin's default state we already have
>   "output-high" and "output-low" and these properties already imply
>   "output-enabled" (at least on the Linux Qualcomm TLMM driver).
> 
> However, there is one instance where "output-enable" seems like it
> could be useful: sleep states. It's not uncommon to want to configure
> pins as inputs (with appropriate pulls) when the driver controlling
> them is in a low power state. Then we want the pins back to outputs
> when the driver wants things running normally. To accomplish this we'd
> want to be able to use "output-enable". Then the "default" state could
> have "output-enable" and the "sleep" state could have
> "output-disable".
> 
> NOTE: in all instances I'm aware of, we'd only want to use
> "output-enable" on pins that are configured as "gpio". The Qualcomm
> documentation that I have access to says that "output-enable" only
> does something useful when in GPIO mode.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

