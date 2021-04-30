Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44F393700AE
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 20:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhD3SoY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 14:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbhD3SoY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Apr 2021 14:44:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C14C06174A;
        Fri, 30 Apr 2021 11:43:35 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id p12so49994603pgj.10;
        Fri, 30 Apr 2021 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KI/MnFrdCFvAVp9lLRYtA+YcapFgP0IRl08eerf2/To=;
        b=EEwXinkxNWph9iZIOreBSC7zDYIf1fW4nFLZ9aGiN3bwvDwrYmn92TWTRXOYPE/gU5
         IEIGfcPhyvzGDxWsCp6G85OV3aytU4vjAqd6ZTQlvDIpFe7NuH5J/hWS+Gho6z/LU2mC
         vLl7SnRb7g+jiDYNBc9VzyhHHyWENZN9vBOdNQvR+Bm3R0KQzdwO+3JCqXbeQWPUefDK
         OI40DFmZm+IlTquzUee+j/GdeGb7NBy16gQ2LMtwHEBwww+Jvho3lJTcxObBnafL4DOo
         vqFmzW5QtmyZEvQf5WvFN+wTpzJumIog+bKAvHkZYzRRkI9GMNMFPZgxf4h1YR8FHi2T
         4wsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KI/MnFrdCFvAVp9lLRYtA+YcapFgP0IRl08eerf2/To=;
        b=Ik692O+tvevhkBl9v2zdBdMQxXo7t77ZwHH+wjfnfvko1K403vfPgxtkhRl4ukqbCU
         0jYovSDhVLwNgSj317fnM+ooD494gQ5OqaY2zCbd+I42kDnQGOx4LjazKZVesNF8SKb1
         DU5xT1ekuIrgd9JKOdZTTWVhPcJAW2i2//mFPYmA99baOOdeeRmSk7JzRv3mJtVaciLr
         i1VK+0VANlG468gJrRyx7uZBvaSoUHFP131P2CubhQh0e5s5wqORdKXFR4dhO7+IylTH
         NOG8RcGVb5aNhe32255mGFIYs1X6I9p3StDWpAb27y0rWuBNYkVH4UV1ytEu3nwpOzt3
         09Sw==
X-Gm-Message-State: AOAM533dI+N9SHhctHMCPI8d2yQ7CMVPMN8Dxrg2JNVG9LzddvOnHhGY
        7yS5+4zWyFxE1mnEyhNtAFS7+HXcJ1bD4NqnBhs=
X-Google-Smtp-Source: ABdhPJxMPZpMkCGdC2AwEeUnojgwpbAa0yguUCDEQBxKd491/rtQyhV87+w7xmA2fqjNDpVJfvEvyYjKTUQmucHSixM=
X-Received: by 2002:a63:a847:: with SMTP id i7mr5759407pgp.203.1619808215145;
 Fri, 30 Apr 2021 11:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
 <20210427143457.GI4605@sirena.org.uk> <YIglWpz8lSidXmDd@smile.fi.intel.com>
 <CAHp75VfBSjHP1LJZJTdwXzGuE2YjxdW6r7Zf6ofHsquJBPMyWA@mail.gmail.com> <20210430180114.GF5981@sirena.org.uk>
In-Reply-To: <20210430180114.GF5981@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Apr 2021 21:43:19 +0300
Message-ID: <CAHp75Vd0MKSZJpw0=qKtORmHRijw0HZLGz+W=sG_cyhLr1JPoQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 30, 2021 at 9:01 PM Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 30, 2021 at 07:29:48PM +0300, Andy Shevchenko wrote:
>
> > One item is still unclear to me. I noticed that you started already
> > applying patches for-next release cycle (if I understood it
> > correctly). Hence the question should or shouldn't I resend this
>
> No I haven't, I'm only applying things to for-5.13.  I've not even
> created for-5.14 yet, that will only get created once -rc1 is out and
> nothing for it is fixed yet.  If I look at it and find an issue I will
> tell you, if I've not said anything and I've got through my first batch
> of v5.14 stuff it's gone AWOL and you should resend.

Ah, okay, it means I misread the idea of applied patches.
Thanks for clarifying this for me!

-- 
With Best Regards,
Andy Shevchenko
