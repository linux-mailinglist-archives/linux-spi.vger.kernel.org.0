Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADC2494E1
	for <lists+linux-spi@lfdr.de>; Wed, 19 Aug 2020 08:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgHSGPT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 19 Aug 2020 02:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgHSGPR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 19 Aug 2020 02:15:17 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79AC061389;
        Tue, 18 Aug 2020 23:15:16 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g8so939308wmk.3;
        Tue, 18 Aug 2020 23:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XqRsyRcI4JizYSBgfDQ1/ZtsmI6N1f3+iRKY5gBn554=;
        b=c7yU/9erjCdq+iHxp9rCjXLehhXneoO0lsw/AO5h7M65mqESgPnanyqBBJl5mBa//T
         ZgVjBkByuDCr0I7hAtydSR2Xdv0G08UUrqG5lUpjeJqXwwTJn0ZZyAPHKvE9mIxE23O7
         JcwiePYhJXP2eOyWHo/IPZb/SAOwXykGmHyCicU1A/WqvjXxJQTShGPgD2/eSBg50e6w
         1qcGjAXT5/FosXXB3nZO9PAMTztGiEBYycky4GPXhmh2DZeC2W8k24FF7/X2nIJ5StlL
         zIwO+6l5zlavXXTjKFxPVm5b8MIHthImCyOnwchhhQJGne2L8jz1AL2suSLmJsKJ7jcy
         WNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XqRsyRcI4JizYSBgfDQ1/ZtsmI6N1f3+iRKY5gBn554=;
        b=YxMaTsC1rymilduTRynKLQ7KkG/ZkaZM3CWmjQw3NImiK34qjoYycKE3+UmMwSK/Ay
         2Janwgi0oRW/vXza6UPzf5lpqMyJrlfUMrZcEY1NCHTWahMlheHnFUHp/M5pV76ckXqb
         BYSoxRkZ4AXYpmQBCV+Y6dC0jY/+EGma0r6RlHRgG41EZXqOdmNgmsHm+tz9odGDvmaH
         42Dn2xpj/doxnigTIN3tqsHK87wm7OUfOuqJaLGjMZJOqeG6/J/FqWzXPfaXahN7bDZw
         WzW9gd7XnT6F7Dxq8o2MKnJT/KPMDAPgFlNi+UhnXJS49pTOjCahAkT2C6PuZ+5ryvLg
         WsTw==
X-Gm-Message-State: AOAM533n2Xaae+Hb/xp2mb2goZo3yVr8ImajSEyUqoAJ4LoVVCZ4F4gQ
        eRdR3nno6pVpIqqG/uA4HJ74UZNsOtPk7A==
X-Google-Smtp-Source: ABdhPJyfWLFMBgE3nkRKJ4ipvtWCILiGRvHPLtREGRgPlFJ3JohUrFII0y8H54azDF5bepO2S12GwA==
X-Received: by 2002:a7b:c306:: with SMTP id k6mr3375410wmj.86.1597817713640;
        Tue, 18 Aug 2020 23:15:13 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f23:5700:855a:ccf2:be1a:9037? (p200300ea8f235700855accf2be1a9037.dip0.t-ipconnect.de. [2003:ea:8f23:5700:855a:ccf2:be1a:9037])
        by smtp.googlemail.com with ESMTPSA id b8sm38346115wrv.4.2020.08.18.23.15.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 23:15:13 -0700 (PDT)
Subject: Re: fsl_espi errors on v5.7.15
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "tiago.brusamarello@datacom.ind.br" 
        <tiago.brusamarello@datacom.ind.br>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <3f48e5fb-33c9-8046-0f80-236eed163c16@alliedtelesis.co.nz>
 <c43a23bd-33ec-4ef2-2ca5-730342248db3@gmail.com>
 <3c72eec1-41ba-7389-eceb-3de80065555a@alliedtelesis.co.nz>
 <1bbb3726-b0a4-6eb9-9076-706b06dfb90f@alliedtelesis.co.nz>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <61bb9800-9f90-9cd4-3b17-c14a7f83d792@gmail.com>
Date:   Wed, 19 Aug 2020 08:15:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1bbb3726-b0a4-6eb9-9076-706b06dfb90f@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19.08.2020 00:44, Chris Packham wrote:
> Hi Again,
> 
> On 17/08/20 9:09 am, Chris Packham wrote:
> 
>>
>> On 14/08/20 6:19 pm, Heiner Kallweit wrote:
>>> On 14.08.2020 04:48, Chris Packham wrote:
>>>> Hi,
>>>>
>>>> I'm seeing a problem with accessing spi-nor after upgrading a T2081
>>>> based system to linux v5.7.15
>>>>
>>>> For this board u-boot and the u-boot environment live on spi-nor.
>>>>
>>>> When I use fw_setenv from userspace I get the following kernel logs
>>>>
>>>> # fw_setenv foo=1
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>> fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>>>> fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>>>> ...
>>>>
>>> This error reporting doesn't exist yet in 4.4. So you may have an issue
>>> under 4.4 too, it's just not reported.
>>> Did you verify that under 4.4 fw_setenv actually has an effect?
>> Just double checked and yes under 4.4 the setting does get saved.
>>>> If I run fw_printenv (before getting it into a bad state) it is able to
>>>> display the content of the boards u-boot environment.
>>>>
>>> This might indicate an issue with spi being locked. I've seen related
>>> questions, just use the search engine of your choice and check for
>>> fw_setenv and locked.
>> I'm running a version of fw_setenv which includes 
>> https://gitlab.denx.de/u-boot/u-boot/-/commit/db820159 so it shouldn't 
>> be locking things unnecessarily.
>>>> If been unsuccessful in producing a setup for bisecting the issue. I do
>>>> know the issue doesn't occur on the old 4.4.x based kernel but that's
>>>> probably not much help.
>>>>
>>>> Any pointers on what the issue (and/or solution) might be.
> 
> I finally managed to get our board running with a vanilla kernel. With 
> corenet64_smp_defconfig I occasionally see
> 
>    fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
> 
> other than the message things seem to be working.
> 
> With a custom defconfig I see
> 
>    fsl_espi ffe110000.spi: Transfer done but SPIE_DON isn't set!
>    fsl_espi ffe110000.spi: Transfer done but rx/tx fifo's aren't empty!
>    fsl_espi ffe110000.spi: SPIE_RXCNT = 1, SPIE_TXCNT = 32
>    ...
> 
> and access to the spi-nor does not work until the board is reset.
> 
> I'll try and pick apart the differences between the two defconfigs.
> 
Also relevant may be:
- Which dts are you using?
- What's the spi-nor type, and at which frequency are you operating it?
- Does the issue still happen if you lower the frequency?
