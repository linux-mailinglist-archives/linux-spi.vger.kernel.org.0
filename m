Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08062118BC1
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 15:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfLJO5R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 09:57:17 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17822 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLJO5Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Dec 2019 09:57:16 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47XNSn2M2cz9txNp;
        Tue, 10 Dec 2019 15:57:13 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=VL/PjXt6; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lU9d_RtgVfkc; Tue, 10 Dec 2019 15:57:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47XNSn19TBz9txNX;
        Tue, 10 Dec 2019 15:57:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575989833; bh=AXtB8eoQYVTHX5wWnJrGLcAQNiPyMVpOmjROYN1LsyQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VL/PjXt6K1EY3Wyw+Ly5eUy2gwuSm+PYokK7X7EwmX+8rB9xQee4NUDhG5o89pzrP
         vgX9ZWj0knadEjmw/FLCp4Jm5WFAuAYzKyd4cQSZzO8pc7KyELFNYU9jzssxTn4o8e
         PGZZvqEg1/w0WElq/vn52jtD0c38zLAmgBihISkA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A12A68B817;
        Tue, 10 Dec 2019 15:57:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2ANm6j98MCgl; Tue, 10 Dec 2019 15:57:14 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 38A658B754;
        Tue, 10 Dec 2019 15:57:14 +0100 (CET)
Subject: Re: [spi:for-next 1/2] drivers/spi/spi-fsl-spi.c:749: undefined
 reference to `of_irq_to_resource'
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, kbuild-all@lists.01.org,
        linux-spi <linux-spi@vger.kernel.org>
References: <201912101605.WSMiIcKr%lkp@intel.com>
 <CAMuHMdVUS+=k0cK-Z9x8JAS=p3BauPXm6C2EmV-umsJDQc1qMg@mail.gmail.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <af7a7385-4980-ab18-6c91-29ba463a3cde@c-s.fr>
Date:   Tue, 10 Dec 2019 15:57:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVUS+=k0cK-Z9x8JAS=p3BauPXm6C2EmV-umsJDQc1qMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



Le 10/12/2019 à 11:46, Geert Uytterhoeven a écrit :
> On Tue, Dec 10, 2019 at 9:10 AM kbuild test robot <lkp@intel.com> wrote:
>> It's probably a bug fix that unveils the link errors.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>> head:   d661a226ebf2961631a3961f2463f5db1b132430
>> commit: 6f2e2fffd91fd9b4364fbefb78ebbe46d05b0bdd [1/2] Merge branch 'spi-5.5' into spi-linus
>> config: sparc64-randconfig-a001-20191209 (attached as .config)
>> compiler: sparc64-linux-gcc (GCC) 7.5.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          git checkout 6f2e2fffd91fd9b4364fbefb78ebbe46d05b0bdd
>>          # save the attached .config to linux build tree
>>          GCC_VERSION=7.5.0 make.cross ARCH=sparc64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     drivers/spi/spi-fsl-spi.o: In function `of_fsl_spi_probe':
>>>> drivers/spi/spi-fsl-spi.c:749: undefined reference to `of_irq_to_resource'
> 
> config OF_IRQ
>          def_bool y
>          depends on !SPARC && IRQ_DOMAIN
> 
>> vim +749 drivers/spi/spi-fsl-spi.c
> 
> The driver should depend on OF_IRQ.

Right. That's independent of the present patch though, as the fonction 
irq_of_parse_and_map() that's being replaced by of_irq_to_resource() is 
also depending on CONFIG_OF_IRQ.

I'll submit another patch to fix this.

Christophe

NB: I din't receive the robot's mail, is that normal ?
