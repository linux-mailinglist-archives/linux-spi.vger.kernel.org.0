Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979E511F0B9
	for <lists+linux-spi@lfdr.de>; Sat, 14 Dec 2019 08:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbfLNHaO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 14 Dec 2019 02:30:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17387 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfLNHaO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sat, 14 Dec 2019 02:30:14 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47ZfM828F5z9v4kg;
        Sat, 14 Dec 2019 08:30:12 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=QKTuuexY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id rXUFt3zZMGyh; Sat, 14 Dec 2019 08:30:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47ZfM813fFz9v4kF;
        Sat, 14 Dec 2019 08:30:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1576308612; bh=jJtG71JXNYzYDF4z7ntC3bwNQLarVarmUswHWhluOuQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QKTuuexYKKEPVIL8i2FVj9ntngPsKl2SiB7u/7pALV0PsyXDg/Aea96V+3KDifu1Y
         mslw9qUfpy3D4X6gNwmrP2n8zKN6Y2GPjsXcghjD65vUZkYbppmnD0JQKozphLtqSx
         LgOdj0j4PXqcDBaUN6qFU0nqsjPcXZIVjMUMutVo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0C4908B788;
        Sat, 14 Dec 2019 08:30:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eEW_ZV8vhUP2; Sat, 14 Dec 2019 08:30:12 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 228048B755;
        Sat, 14 Dec 2019 08:30:12 +0100 (CET)
Subject: Re: [PATCH] powerpc/devicetrees: Change 'gpios' to 'cs-gpios' on
 fsl,spi nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org
References: <7556683b57d8ce100855857f03d1cd3d2903d045.1574943062.git.christophe.leroy@c-s.fr>
 <20191213213418.GA17361@bogus>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <678cdcce-9bad-519a-68a5-a43414c15f94@c-s.fr>
Date:   Sat, 14 Dec 2019 08:30:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191213213418.GA17361@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 13/12/2019 à 22:34, Rob Herring a écrit :
> On Thu, Nov 28, 2019 at 12:16:35PM +0000, Christophe Leroy wrote:
>> Since commit 0f0581b24bd0 ("spi: fsl: Convert to use CS GPIO
>> descriptors"), the prefered way to define chipselect GPIOs is using
>> 'cs-gpios' property instead of the legacy 'gpios' property.
> 
> This will break using a new dtb on a kernel without the above commit. Or
> with any OS that never made the change.

Why would anybody use a new dtb on an old kernel ? I have not tagged 
this change for stable, it will only apply to DTBs in new kernels, won't 
it ?

That's not the first time DTS have to change for new kernels. For 
instance, some time ago I had to replace all 'gpios' property by a set 
of 'rdy-gpio', 'nce-gpio', 'ale-gpio' and 'cle-gpio' properties to 
continue using 'gpio-control-nand' driver.

> 
> I'm fine with the doc change, but you should keep 'gpios' as deprecated.

Ok

Christophe
