Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19CD1DEBA9
	for <lists+linux-spi@lfdr.de>; Fri, 22 May 2020 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbgEVPVI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 May 2020 11:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgEVPVI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 May 2020 11:21:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01442C061A0E;
        Fri, 22 May 2020 08:21:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b12so4507208plz.13;
        Fri, 22 May 2020 08:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKBewF3F7MBEJ8/HUBV80QTJT/Ts1FvO4EjowDWAM/8=;
        b=BfXBV3FDM45lgO3wynnM9a2CkNoUgn2Eklfb0WjzC9xpNzPdSzEo+oBRXI4RalRKwM
         NKYfotgFtlRiPk8Oz2NPNs9Q1327fdqIsfRLxHEYB8H5DPyUMEu33ZT1z3p/5VSXqWBd
         X8zJoLVEBTQu6+JYy0VKLXjvuvsYwfS7XxYXX7cscyVy5eDS9iYuAGvn7tlOVp+By5xU
         rI+4nblRzYcj5GC0z6afyoKicDUbw+PjrGiNQGQZIrtzhjADefsIZBlqn66ppQ5Fcmn7
         VthBUzjRuDXbBNNgwT+uOf8TscmaCkYJX5NXNVPJ+WxHHtDcwyaudlgtbmDHB+srkyNT
         UAFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKBewF3F7MBEJ8/HUBV80QTJT/Ts1FvO4EjowDWAM/8=;
        b=LqUPvOjpuhWnzafVb4CzjYcGkgLSsjDxsg9gHtd4PchEHWMiGDk0V2QJNyLbRKl6wb
         OHwCldtIkrRCCBP0n4ZtaCreHUJps7TDRP0WJD2DPI9IEN4eOncUZLx+XJ0YZgYrkWLh
         bFd9Ug0aJgM2szSlq6ZUFt/28ILz9N/OWTtc/52xV7auGOpx0oW4VvscuSf5ms2A3Llm
         Uokksx6QycY+C7RmzobwmndV+oCITqzeDnqmDxvOln+IrYluinnZi7NuImqh/Wm3D6az
         ACLO++3eyrqUtgDh05CCGYooxAaQ0q81glr0/EQCZ2Lq6i3RyEeBU1J4XBL0kq6fHudC
         yywg==
X-Gm-Message-State: AOAM533VZ1Us5DBnK+grTCgjvI5SxXSAh3mRKNAis0GfTa2ANV4cHPcs
        XAxSfGuC228BRiHgcA8h0cEKBz/diP/Kv29jh0o=
X-Google-Smtp-Source: ABdhPJyhKGvA9itVRuhkyF4uWWd0ytz++XDAbLBp9hj87LoBBGusQnr+8HiqmBoKWj4GZvMSlsF1WjkFmh5fZTEoNzc=
X-Received: by 2002:a17:902:6ac2:: with SMTP id i2mr15639807plt.18.1590160867222;
 Fri, 22 May 2020 08:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200521074946.21799-1-dinghao.liu@zju.edu.cn>
 <CAHp75VfOeUaqRW2vRwyWaz3JJw41hX5jTgE+kZ8pB8E_HtHwqw@mail.gmail.com> <5a8a6e7b.bef25.1723b588c7f.Coremail.dinghao.liu@zju.edu.cn>
In-Reply-To: <5a8a6e7b.bef25.1723b588c7f.Coremail.dinghao.liu@zju.edu.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 18:20:55 +0300
Message-ID: <CAHp75Vem1kQviLrobJ65aVOb_VCmLkAv=5U_iXAdWPNe7n0+Ng@mail.gmail.com>
Subject: Re: Re: [PATCH] spi: tegra20-slink: Fix runtime PM imbalance on error
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Kangjie Lu <kjlu@umn.edu>, Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 22, 2020 at 10:46 AM <dinghao.liu@zju.edu.cn> wrote:
>
> Hi Andy,
>
> Thank you for your advice!

You are welcome, but please, stop top-posting.

> Your suggestion is to use pm_runtime_put_noidle(), right?
> The only difference between pm_runtime_put() and this function
> is that pm_runtime_put() will run an extra pm_request_idle().
>
> I checked this patched function again and found there is a
> pm_runtime_put() in the normal branch of pm_runtime_get_sync().
> Does this mean the original program logic need to execute idle
> callback?
>
> According to runtime PM's doc, the pm_runtime_get_sync() call
> paired with a pm_runtime_put() call will be appropriate to ensure
> that the device is not put back to sleep during the probe.

Correct.

> Therefore
> I think pm_runtime_put() is more appropriate here.

How come to wrong conclusion? We are considering error path. What does
documentation say about this?

> Do you have
> more detailed suggestion for why we should use _put_noidle()?

Because in error case there is no need to go through all code patch to
be sure that the device is idling. Moreover, consider below case

CPU1: ...somewhere in the code...
pm_runtime_get() // with success!
...see below...
pm_runtime_put()

CPU2: ...on parallel thread...
ret = pm_runtime_get_sync() // failed!
if (ret)
  pm_runtime_put() // oi vei, we put device into sleep

So, there is a potential issue.

> > > pm_runtime_get_sync() increments the runtime PM usage counter even
> > > when it returns an error code. Thus a pairing decrement is needed on
> > > the error handling path to keep the counter balanced.
> >
> > ...
> >
> > >         ret = pm_runtime_get_sync(&pdev->dev);
> > >         if (ret < 0) {
> > >                 dev_err(&pdev->dev, "pm runtime get failed, e = %d\n", ret);
> >
> > > +               pm_runtime_put(&pdev->dev);
> >
> > For all your patches, please, double check what you are proposing.
> >
> > Here, I believe, the correct one will be _put_noidle().
> >
> > AFAIU you are not supposed to actually suspend the device in case of error.
> > But I might be mistaken, thus see above.
> >
> > >                 goto exit_pm_disable;
> > >         }


-- 
With Best Regards,
Andy Shevchenko
