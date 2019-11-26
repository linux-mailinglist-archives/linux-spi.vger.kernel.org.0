Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F41710A1C0
	for <lists+linux-spi@lfdr.de>; Tue, 26 Nov 2019 17:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfKZQQL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 Nov 2019 11:16:11 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:60631 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfKZQQK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 Nov 2019 11:16:10 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47MptH6fnqz9txm3;
        Tue, 26 Nov 2019 17:16:07 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=vsmptXEC; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GqwpeyPSld_C; Tue, 26 Nov 2019 17:16:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47MptH5PC9z9txm2;
        Tue, 26 Nov 2019 17:16:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1574784967; bh=h2zSzMooApj/85pt2T3/AWcSwxR0RaUdtLKrpSMYKec=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vsmptXEC6R27OQpVO+3jRxFYtrkTFoFbbUFzqTSMGCBaqCUT7g588keM9PWPalKLu
         IfSI5HBd/j28QC3qUzCy3xyRoIXN0AlRcc23o2UGRU8bShkb4JXmFMGLy4JjX5M1bm
         kjCbyiVPVbDLWeF5iuZu6p2PR9vEr9ncxsuMyDyI=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4BD5B8B820;
        Tue, 26 Nov 2019 17:16:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DPwNpc2MzlFL; Tue, 26 Nov 2019 17:16:09 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C57098B81A;
        Tue, 26 Nov 2019 17:16:08 +0100 (CET)
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr>
 <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr>
 <d144f86e-48ff-384a-2937-639c0c6dd3d8@c-s.fr>
 <CAOMZO5DJ+UGuNN-5gZE68Yt2ZTBVZ50teo9H0=c-Rgx+oFAa7A@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1fb72883-5091-69cf-b783-8ad5f60ea24d@c-s.fr>
Date:   Tue, 26 Nov 2019 17:16:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAOMZO5DJ+UGuNN-5gZE68Yt2ZTBVZ50teo9H0=c-Rgx+oFAa7A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 26/11/2019 à 16:35, Fabio Estevam a écrit :
> Hi Christophe,
> 
> On Tue, Nov 26, 2019 at 12:01 PM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
> 
>> How can we progress on that ? Problem is still present in 5.4
> 
> Linus has sent the following fix:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20191126&id=c5923243eb3208ea63b5ed7905610039c4ca5201
> 
> Does this fix the problem?

This fixes the crash in the error path.

But the error path shouldn't be taken, so there is something else to 
look at.

> 
> If it does I think this need to get into stable too.
> 

Agreed.

Christophe
