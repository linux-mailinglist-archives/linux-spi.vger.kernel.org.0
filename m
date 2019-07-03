Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC5A5E488
	for <lists+linux-spi@lfdr.de>; Wed,  3 Jul 2019 14:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfGCMuQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 3 Jul 2019 08:50:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41948 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCMuQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 3 Jul 2019 08:50:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id 205so2279068ljj.8
        for <linux-spi@vger.kernel.org>; Wed, 03 Jul 2019 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3TWdYZe/U+Ip6BktVAmhxzsfczU0mvmCKkdz5qIP6jo=;
        b=rwo5atfBlFwMZIpW9WGSEFYC45q+v9PhP+X9pHAG8c8lpm1brr/mb3G4Lpsc9eDVgW
         UwaBPgazY0lTIAJiWjb8IIrKsrku9DRhZG7oheAN5823z5S61QLoyw+3uHiVS9PITlU8
         kBPqGrvcTddG1YZPZ3TshEo1OTQy/H8hQAodOTii/f/06LlbCY/af69ncCt1liXWO+1h
         coU0DhO1u9HkCPNfxhtETN8SL9vDDrOWGg/LlL/lqwt5mGd9q+DFH1PTJWllFheQm6Pz
         JdnKqtflDHLXZ0w8I6hsQ71RgT0g2QNuZr0cwpIcuOtnyjr08hjHXPPFSw35LlzP9WVo
         knXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3TWdYZe/U+Ip6BktVAmhxzsfczU0mvmCKkdz5qIP6jo=;
        b=hFPRfSFfLLg0D0ZdMjJwFBwUQcMg/VyvrmiRZ50KftrFa+TuP4mNdiH7ZR92a7vJhk
         KCxUrqdpxKNk3R8NJsIKXOt3EQ1yaVsEok+miaqA1eK/nDeuGLmMBOgBhkQmMdLuvH2W
         zcijiSa8t2W0cNHNsM1KuT9ECrz9QBl1xbnV44kgkZ79baoS7EfrRUcp/H2S7jIdYIjF
         djycfK5PXB8XeooA+FNYQWFQx/zlmzhXotjmrL/utSYUbpMraO+qG4FnWhuIUBd5ObCR
         vA3KFEME4xCI/z1t610GDls0zxVYaqfHUSjXosl9o2KLwpzOAtQzUPet6pIkx0UiLtQL
         oTyA==
X-Gm-Message-State: APjAAAVDwNPAESyOOFoKkPeZ9B6L9pCC1TUeeKQYFfRn6ReeZus2PdZn
        +YSIInuXSTiVkjhtDg+JgpgkLIES+/oWf7iSlAgE3A==
X-Google-Smtp-Source: APXvYqxJc88E4NJYEwmGLHIfkPIrMAgwpF7cLkmxfP6SReCiER0uSYxIFxdC+BhtKtTAv6qjqvJoKeCQXnuTDFCtyeU=
X-Received: by 2002:a2e:9211:: with SMTP id k17mr21490592ljg.157.1562158214253;
 Wed, 03 Jul 2019 05:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <201906042339.gt5sS7Hb%lkp@intel.com> <CAHp75VcqTvoSf3-vbH555iY9NNu+fd5bzL0TFxfZEVU3M=Pg2Q@mail.gmail.com>
 <CAHp75VdVKCwwijbQNTqxLaR8k=D2SHRZ=D6pJDaTSVQL=j_Oow@mail.gmail.com> <20190702175841.GR2793@sirena.org.uk>
In-Reply-To: <20190702175841.GR2793@sirena.org.uk>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Wed, 3 Jul 2019 14:50:03 +0200
Message-ID: <CADQ0-X_tKJkAud5_m=2v5Zi0Vn=LKuOX45ycp8i2HFxkMg=Ztg@mail.gmail.com>
Subject: Re: [spi:for-5.3 41/41] drivers/spi/spi-synquacer.c:153:3: error:
 implicit declaration of function 'readsb'; did you mean 'readb'?
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 2 Jul 2019 at 19:58, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jul 02, 2019 at 08:52:03PM +0300, Andy Shevchenko wrote:
> > On Tue, Jul 2, 2019 at 8:50 PM Andy Shevchenko
> > > On Tue, Jun 4, 2019 at 6:59 PM kbuild test robot <lkp@intel.com> wrote:
>
> > > It seems false positive.
> > > kbuild bot has to be fixed,
>
> > Ah, didn't noticed ALPHA!
> > Perhaps,
>
> > depends on !ALPHA (or how is it called?)
>
> > should fix this.
>
> Is that the only architecture that's missing these functions?  If
> not it's probably better to have something for the feature (or
> have Alpha stub it out like we ended up doing with the DMA stuff
> for s390).

I have submitted patch for this build error and it was already applied.
https://www.spinics.net/lists/linux-spi/msg17836.html
