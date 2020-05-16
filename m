Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800F31D601B
	for <lists+linux-spi@lfdr.de>; Sat, 16 May 2020 11:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgEPJpm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 May 2020 05:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgEPJpm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 May 2020 05:45:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4092EC061A0C
        for <linux-spi@vger.kernel.org>; Sat, 16 May 2020 02:45:42 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so2255926pfa.1
        for <linux-spi@vger.kernel.org>; Sat, 16 May 2020 02:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZJ62fHWlt6Z60NeL5Ek6BbRHHHGV8Gk7H2eHbY2YNE=;
        b=TMqE+yJtwiYvbQn7TkBcBxGHDnkJHWTfiz6IlOIXiHPEaS3uvCrwWZVYlcn/ZHl8FX
         OWAAB6sB53uFbLlosDgpzvI69PrcDgClPcjogwYUzfbU16gnHlUUxhuE2X1GdvMeBLaI
         LFG/HuXqLi3vEzxNuqmCbI1kRwY8jhGZMS8uR3aUBcojKOdr+nTYorR6BHgpoNJi45TH
         F+hpZNEFD9xXhHpfaa7Lb/bYAOAiJ2MmqppYyQ6CGfL1UhOhb3tJ+LLfE5l8GnjB7MwC
         j3l5m8/jRMKlDjR81vnUjeJxVxyB/SFUp3/t1RNDRP3BvLalxNo5JQTmXwWHBlaIJva5
         ZeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZJ62fHWlt6Z60NeL5Ek6BbRHHHGV8Gk7H2eHbY2YNE=;
        b=OAmftnI1ig8qtPnWa6Z9NU4A1gtumZmjkDEA4YYzmViCKbkz3OPwrbJdh1TFkEFN3f
         MxPYMO5A2wj8lxtCrOGavMKeXV1VAoxN01gMqKFfLe1p9psWFwwtXmHfq4Yoa8xgDAN0
         IDe4f/JW8Onakzn/pk02UPZ9rIzciUk6eVK9N3ev2NqZszX3C13ZWJ0amms7wsyAqzmj
         3m26mn1mRKW5mmez9ws2GbTjQdKsaEL9ceW5TKKdGaItViJHcR9wb/QnxditODcW9LkG
         7h6YeFnTBkJUgcRhZ4THunbUVCtm4Fi9mfqv4VvE4tPipJ4ABO8lj8YN/6C55zq/Lpvf
         QwUg==
X-Gm-Message-State: AOAM531lRXHxigYDrYqAIFu25eeJ733OBTKS1rRB8vyofRPue0qNSf63
        1gwYgzeFQq/QkTnXc85pZRwu2k6lrp87p9hSmsM=
X-Google-Smtp-Source: ABdhPJx2+5Dzwoxe5rj4etjhLXQgBNczFXn7uNpdmqOhM5mJ+sIaAMFL9s2R52n6meZipOln97hN6qy8uQ3/ixm7/Co=
X-Received: by 2002:a62:f908:: with SMTP id o8mr7806717pfh.170.1589622341531;
 Sat, 16 May 2020 02:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589557526.git.lukas@wunner.de> <8aaf9d44c153fe233b17bc2dec4eb679898d7e7b.1589557526.git.lukas@wunner.de>
 <20200515162725.GG5066@sirena.org.uk> <20200515163147.3u4xjqdxci2neup7@wunner.de>
 <CAHp75VduTYuVO_KhLuRNUA-zQxo8QNFMWDoLRCrGxYkZCOUovA@mail.gmail.com> <20200516064512.cwslwlkozff3mycf@wunner.de>
In-Reply-To: <20200516064512.cwslwlkozff3mycf@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 May 2020 12:45:30 +0300
Message-ID: <CAHp75VdVyOA55hiv5WFz6Zi94w3MRbivkLec029ZCszET0WDRw@mail.gmail.com>
Subject: Re: [PATCH 1/5] spi: Fix controller unregister order
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 16, 2020 at 9:45 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sat, May 16, 2020 at 12:37:17AM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 7:41 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Fri, May 15, 2020 at 05:27:25PM +0100, Mark Brown wrote:
> > > > On Fri, May 15, 2020 at 05:58:01PM +0200, Lukas Wunner wrote:
> > > > > However since commit ffbbdd21329f ("spi: create a message queueing
> > > > > infrastructure"), spi_destroy_queue() is executed before unbinding the
> > > > > slaves.  It sets ctlr->running = false, thereby preventing SPI bus
> > > > > access and causing unbinding of slave devices to fail.
> > > >
> > > > Devices should basically never fail an unbind operation - if something
> > > > went seriously wrong there's basically nothing that can be done in terms
> > > > of error handling and keeping the device around isn't going to help.
> > >
> > > I guess the word "fail" in the commit message invites misinterpretations.
> > > The driver does unbind from the slave device, but the physical device is
> > > not left in a proper state.  E.g. interrupts may still be generated by
> > > the device because writing a register to disable them failed.
> >
> > I didn't check a patch, but I see a bug on kernel bugzilla against
> > spi-pxa2xx because of this. It requires quite untrivial ->remove() in
> > order to quiescent the DMA and other activities.
>
> Yes from a quick look at spi-pxa2xx.c it's immediately obvious that
> the use of devm_spi_register_controller() is likewise completely wrong.
>
> The crucial thing to understand is that the SPI driver's ->remove()
> hook is executed *before* any device-managed resources are released.
> pxa2xx_spi_remove() disables the clock, frees the IRQ, releases DMA,
> so the SPI controller is no longer usable even though it's still
> registered!  Somehow this incorrect order got cargo-culted to dozens
> of drivers over the years.
>
> We use SPI-attached Ethernet chips and when the SPI driver's module
> is unloaded, the Ethernet driver's ->ndo_stop() hook is executed to
> bring down the interface.  For this it needs to communicate with the
> Ethernet chip, but it can't because the ->remove() hook has already been
> executed and unbinding of the SPI slave happens afterwards, when the
> SPI controller is unregistered via devres_release_all().
>
> There's another issue in spi-pxa2xx.c:  It acquires a runtime PM ref
> even though the driver core already does that.
>
> Do you have a link to the spi-pxa2xx.c bugzilla?  Are you able to
> test patches?  I can submit a patch but I can only compile-test it,

Here you are: https://bugzilla.kernel.org/show_bug.cgi?id=206403.
There also a link to my GH tree where I tried to clean up a bit. And
yes, I know about atomic handling bug there, but it's another story.

I was able to reproduce the bug once or twice, but submitter has a
test case with reproducibility close to 100%.

-- 
With Best Regards,
Andy Shevchenko
