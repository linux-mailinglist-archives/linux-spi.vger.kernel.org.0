Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD6E21561A2
	for <lists+linux-spi@lfdr.de>; Sat,  8 Feb 2020 00:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGXyx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 7 Feb 2020 18:54:53 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38222 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgBGXyx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 7 Feb 2020 18:54:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so577778pfc.5;
        Fri, 07 Feb 2020 15:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5qMbFWATYyhNriIA227P4Y2/H9QOdX8jfCqbFm5qb5k=;
        b=IR4+cctVsdvXWUYSJR4OmnDjjcOOBUkeIT9S5vKntCpzrtS8CFJXFKk0S69KQ5Th6q
         EitQXCp6+MwtTM7/aO7bJFupy5VZQqlU24P22dnMdYdJOZWsLHCapABeL/oGT0zgnVro
         xh3JTeynpoSdCWhzfMa0cUnXMiIafksNgf/8o0XwY2T60mqNOMoSBvo9VNKsQEfgUlkk
         TQDEzCKElc8Uj4m5thuwxloxEA+0OBXuNy45fNz06XE3NiA4UvJR0EZYDejuMkGo12Sy
         C+VaIKV6f13j2QZftyCLJVXxVofnmDZkEVCCWtgRuT0kNey61kieYjI+svNZWeaP69a5
         YfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=5qMbFWATYyhNriIA227P4Y2/H9QOdX8jfCqbFm5qb5k=;
        b=i/pGy27xSrb9iyJdG+ihVgGHkfZ2N8p85+R8HBDIHriu//vbMJwu7D/+pBPk4SxjAJ
         pofZlAe4jAzYsZj+K1D2K1eY89O+xZqWjcBhOUVzX5DAl6me9lch8Z/cSaJh6IM6xcpP
         PmTBpPKSelRp5rGNOtRvWhJ8xhVOLb3IRRT+mVilnh368in20nrMCpStgh/5b/Atz2Af
         rUtH42WqBLQ8+WkYq/FrAPQMIRZClznA+CRNNJ1RHBfZb8WqQk4NRZ9PGLwDg4iRyGdC
         gJniv/h06ZeFtqkX+7pfBijA9bttc1749KeH61p37m+QAEve8BSICQvD8ZNddupFMB0I
         712g==
X-Gm-Message-State: APjAAAWawMwkzQc4VP/+sAa+SwI7kDWE/yqsgJmmnPw6Wo6b6b0oE84N
        dYAU4PsXj3z7MjxuXs2ld9S61hu/
X-Google-Smtp-Source: APXvYqwdaKzitIMr9zdfpJbOs+cXOstH3wgSGoQBz9sE4GE4qRxI9aerDwcavmA8LnwoBZqjI601ug==
X-Received: by 2002:aa7:9301:: with SMTP id 1mr1351551pfj.156.1581119692237;
        Fri, 07 Feb 2020 15:54:52 -0800 (PST)
Received: from [10.67.50.115] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g24sm4272399pfk.92.2020.02.07.15.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 15:54:51 -0800 (PST)
Subject: Re: [PATCH v2 2/2] dt-binding: spi: add bindings for spi-ar934x
To:     Chuanhong Guo <gch981213@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20200206150626.708649-1-gch981213@gmail.com>
 <20200206150626.708649-3-gch981213@gmail.com> <20200206205551.GA15172@bogus>
 <CAJsYDVKXvAkQawwayX8JVrjvEKPuTyQXE8rw=BRiyVROKrdWrg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <7f53a397-0237-4c68-e284-d92adf19c368@gmail.com>
Date:   Fri, 7 Feb 2020 15:54:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAJsYDVKXvAkQawwayX8JVrjvEKPuTyQXE8rw=BRiyVROKrdWrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 2/6/20 9:55 PM, Chuanhong Guo wrote:
> On Fri, Feb 7, 2020 at 4:55 AM Rob Herring <robh@kernel.org> wrote:
>>
>> On Thu,  6 Feb 2020 23:06:26 +0800, Chuanhong Guo wrote:
>>> Add binding documentation for SPI controller in Qualcomm Atheros
>>> AR934x/QCA95xx SoCs.
>>>
>>> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
>>> ---
>>> Changes since v1: none
>>>  .../bindings/spi/qca,ar934x-spi.yaml          | 40 +++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/spi/qca,ar934x-spi.yaml
>>>
>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
>> Error: Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dts:20.28-29 syntax error
>> FATAL ERROR: Unable to parse input tree
>> scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dt.yaml' failed
>> make[1]: *** [Documentation/devicetree/bindings/spi/qca,ar934x-spi.example.dt.yaml] Error 1
>> Makefile:1263: recipe for target 'dt_binding_check' failed
>> make: *** [dt_binding_check] Error 2
>>
>> See https://patchwork.ozlabs.org/patch/1234394
>> Please check and re-submit.
> 
> It's caused by "clocks = <&pll ATH79_CLK_AHB>" where ATH79_CLK_AHB
> isn't defined without a include of dt-bindings/clock/ath79-clk.h
> I'll replace this with a bogus "clocks = <&spi_clock>" instead in v3.

You can include ath79-clk.h in your example, see for instance
Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
-- 
Florian
