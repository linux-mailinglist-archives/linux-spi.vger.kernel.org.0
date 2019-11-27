Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 822AA10B0A9
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfK0Ny2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:54:28 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:34292 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbfK0Ny1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 27 Nov 2019 08:54:27 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47NMhH5Hcrz9v0wq;
        Wed, 27 Nov 2019 14:54:23 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=csl7JqCb; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HVNVr5CuLPNg; Wed, 27 Nov 2019 14:54:23 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47NMhH4F6Bz9v0wn;
        Wed, 27 Nov 2019 14:54:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574862863; bh=tVR/V+sh8X9KmQdUzabOE4w7v+/RGnr0SHO7oitXSFw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=csl7JqCb3NSJDWKKmeRnClekJbsnYPyRFf/Yk+BXdO6KvEa/rk/76xLnAq6AtXz6m
         auu+GRqYiw3AQuiqf0sytTqpzcuRNtwxWnlMHE259NuiQ1FwX2Pv5Mqy1J/XJn+yXq
         a7Tfi+bgh5pDIRB0YTy/iTdhOR+knSfPJcn1IE6o=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E4D178B85A;
        Wed, 27 Nov 2019 14:54:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FSNyW-O2V1Tm; Wed, 27 Nov 2019 14:54:24 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8D3258B862;
        Wed, 27 Nov 2019 14:54:24 +0100 (CET)
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
 <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr>
 <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr>
 <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr>
 <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
 <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr>
 <CACRpkda-wjRm7UYsFTX_xFfNPT29U1PTMyuU4AP=WShiC_vV9g@mail.gmail.com>
 <b2925217-9cbd-2f4e-c92f-9e1c92824193@c-s.fr>
 <CACRpkdaKg45uHMZ9mz6OGkAUqYX7GzhTrjrAc1feVhn68ZXrqg@mail.gmail.com>
 <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr>
 <CACRpkdb15n4DpxAGEw+Av89XZDxi7Amh1XEyJEzWBd4tet7C2Q@mail.gmail.com>
 <8b50ce56-0600-373d-178c-92aa780e5376@c-s.fr>
 <CACRpkdZRWojQAgHtBaNWdjKqv8aX3P-KjatgoG+DLCcYeJ7ztg@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <99f48a7e-e4f4-2a77-657c-452d7a656ec5@c-s.fr>
Date:   Wed, 27 Nov 2019 14:54:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdZRWojQAgHtBaNWdjKqv8aX3P-KjatgoG+DLCcYeJ7ztg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 27/11/2019 à 14:52, Linus Walleij a écrit :
> On Wed, Nov 27, 2019 at 2:45 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>> Le 27/11/2019 à 14:00, Linus Walleij a écrit :
> 
>>> Try to remove the "spi-cs-high" bool flag from your nodes,
>>> because it seems like the old code was ignoring them.
>>>
>>> Does that solve the problem?
>>
>> Yes it does. Many thanks. I let you manage the packaging of fixes.
> 
> OK I will send a final batch of 3 patches fixing this.
> 
> Do you have these old device trees deployed so that we
> also need to make sure that old device trees that have this
> ambigous syntax will force precendence for the flag on the
> GPIO line if both are specified for the "fsl,spi" instances?
> 

No, we deliver device trees together with Linux kernel (embedded in an 
Uboot ITS/ITB image) so no worry on old device trees.

Christophe
