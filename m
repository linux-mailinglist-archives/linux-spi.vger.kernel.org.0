Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E91EC1D6013
	for <lists+linux-spi@lfdr.de>; Sat, 16 May 2020 11:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgEPJke (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 16 May 2020 05:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbgEPJke (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 16 May 2020 05:40:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5114BC061A0C
        for <linux-spi@vger.kernel.org>; Sat, 16 May 2020 02:40:34 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so2219574pgl.9
        for <linux-spi@vger.kernel.org>; Sat, 16 May 2020 02:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLsgv6F4roMs2HoOiDJ0bdjUqpuGdCIr2pH0qBBD6v8=;
        b=CLXsXI12hgbqtmM4I06XstIutMsY1BfcLmyE1iDdWRSLiGwkbgON+7qsPIdFylEuH2
         DMpJEU/zMXw56YhID9WsJka0LhKOPuxLq14IEbeSFGdy/Pl1+bzEDtu4Chtfus+uIpqI
         Ch3GA9S8AiLE00x00BbCaprFKaEhjxzGUamT773KH+LGLo/5AXhWpDYQPDk150cDz6Lq
         RxOJgNZHP6T3IsKysVfjd3uqUHk8d1Rw6LynK8z/T7tnQn7dUz85Ccp3IRFGkG5R5mmP
         MkesVoBAXb74Dz4TvPsyKlG1uGw7AvBt+5CZcFgkbu4OrHO/lFPEhR1r9yOBsD7lOS2U
         2bNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLsgv6F4roMs2HoOiDJ0bdjUqpuGdCIr2pH0qBBD6v8=;
        b=fUJgKFWU3jg9Xk8yUe6vaXrXtc62qShHpVa75fSupDHhVi/jBoWmojvRmBtdIBT57j
         OagvISyc4s+bIByG/wZKJQrZHI+99kkt/EyIioz3YZm56eAnDpDuE5AOx/Cup9xa0QO9
         HjiuRqWI3nFpZfggQnKNCNV9Ekl4T+xTe3nqrlZ2Cb5HuTXmEYJ5aKyzaMAMc/zCxzLE
         4xUDiuvp2k1aTIs5OjkkYjD/JSr6sMh8FfZM21H8m8iiYPA0zuiuxvY07XsJXVHd7TD+
         ifq0KideduidqztRNo85Zihhej3WEUvbDKK8eMvofSxv3TH6KoNi58ZpYqYFl8AGTsTI
         zZlA==
X-Gm-Message-State: AOAM533MQRy4dqjW+2vxjzk2jDZO67A6INRhDq2gXf7dsmQpdHPJ6+zQ
        Q6rW2N43Hv8ieD9ORY9UBMIc7bywos1GgHHrNjw=
X-Google-Smtp-Source: ABdhPJwtKMjj3Aduptyvb8s/5CoMnd6ucIVYfKeePgFKByB85cZ0UHpX40pGJaSL180Nkq1s/9VB8u6IDoFDYe5CvNY=
X-Received: by 2002:a65:6251:: with SMTP id q17mr6801546pgv.4.1589622033811;
 Sat, 16 May 2020 02:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589557526.git.lukas@wunner.de> <2397dd70cdbe95e0bc4da2b9fca0f31cb94e5aed.1589557526.git.lukas@wunner.de>
 <20200515162903.GH5066@sirena.org.uk> <20200515164404.bev4zjzcmx4nwzhi@wunner.de>
 <CAHp75Vfs=gc9c2h2amhu0eb3ux8jJAuC7CRY8fLrFiBsTwtSYQ@mail.gmail.com> <20200516065607.zrqwlh5ayoth37y4@wunner.de>
In-Reply-To: <20200516065607.zrqwlh5ayoth37y4@wunner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 May 2020 12:40:22 +0300
Message-ID: <CAHp75VeOSgiprNoqs2Jn=ibNRspSWyGwpqFmJphHd3K7999mrw@mail.gmail.com>
Subject: Re: [PATCH 2/5] spi: bcm2835: Fix controller unregister order
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, May 16, 2020 at 9:56 AM Lukas Wunner <lukas@wunner.de> wrote:
>
> On Sat, May 16, 2020 at 12:33:00AM +0300, Andy Shevchenko wrote:
> > On Fri, May 15, 2020 at 7:45 PM Lukas Wunner <lukas@wunner.de> wrote:
> > > On Fri, May 15, 2020 at 05:29:03PM +0100, Mark Brown wrote:
> > > > On Fri, May 15, 2020 at 05:58:02PM +0200, Lukas Wunner wrote:
> > > > > Fix by using the non-devm variant spi_register_controller().  Note that
> > > > > the struct spi_controller as well as the driver-private data are not
> > > > > freed until after bcm2835_spi_remove() has finished, so accessing them
> > > > > is safe.
> > > >
> > > > Why not use managed allocations of clocks and DMA channels?  This is a
> > > > standard issue with the devm APIs, if you're using them you basically
> > > > need to use them for *everything* up to the point where you start using
> > > > them.
> > >
> > > There is no devm version of clk_prepare_enable(), dma_request_chan()
> > > and various other functions invoked on ->probe() by spi-bcm2835.c.
> > > So tearing down DMA channels, disabling clocks etc needs to happen
> > > in the ->remove() hook and consequently devm_spi_register_controller()
> > > cannot be used.
> >
> > There is devm_add_action_or_reset (IIRC the name). It does a trick.
>
> Interesting, thanks.
>
> However there are currently four actions performed by bcm2835_spi_remove():
>

>         bcm2835_debugfs_remove(bs);

This one shouldn't be counted. You can init it as the last op in
->probe() and that mustn't fail the probe.

>         /* Clear FIFOs, and disable the HW block */
>         bcm2835_wr(bs, BCM2835_SPI_CS,
>                    BCM2835_SPI_CS_CLEAR_RX | BCM2835_SPI_CS_CLEAR_TX)

This one I don't know.

>         clk_disable_unprepare(bs->clk);

This one traditionally done via devm_add_action_or_reset.

>         bcm2835_dma_release(ctlr, bs);

This one probably the one which needs to be addressed ideally in DMA
engine for all.

>
> So I think I'd have to add four functions to perform these devm actions,
> which would add a lot more code than just the single line added by my
> patch.  It also seems doubtful that the teardown code will still be easy
> to follow.  And small patches like the ones I've submitted lend themselves
> better to backporting to stable.
>
> Mark, please provide guidance as to which variant you'd prefer:
> Switching to the non-devm variant of spi_register_controller() as I've
> done here or adding devm calls for all the existing teardown steps.

All generic devm_* APIs have a release counterparts, you can
explicitly call them in order you want during ->remove(). So, I still
see a benefit of devm_*() even in such cases (makes ->probe() much
easier).

-- 
With Best Regards,
Andy Shevchenko
