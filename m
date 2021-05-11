Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64F37A840
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 15:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhEKN5a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhEKN53 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 09:57:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0179C061574;
        Tue, 11 May 2021 06:56:21 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m124so15765408pgm.13;
        Tue, 11 May 2021 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x6xiojJvPih6Su8dJP6cTthVY6rnrZqEJ8f2jB635BA=;
        b=OjhwFSBd4ZiSWstu50HVKqtm1dzYLZykbZNRq1ki8R15rHYZJe9awA4i9xexupMPev
         HHCowKwFSWuZBmwvWvoKMcsfusNkEBQkbH3J0Ea0rPE/1vXc5PWae/t0fv0iSovfqAiS
         lgxhh/xXYni3aBYEDG3VxfETLSlJwxmvYYFHduPsURzBOeDAoLl87Ij9hTcnLudrEnwW
         VosLtKIWVLM34deB9XV0cIQY4t1RA2fvoEVbjt06DDMZjTL1meDPZ+3I3lHdEz59CTXx
         poHaXWmV6hMQF5vWhApIIqomd54x9gkr1IxFNqr09SG6Eh+hxbsBzE05dhd2oAaetjBJ
         xU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x6xiojJvPih6Su8dJP6cTthVY6rnrZqEJ8f2jB635BA=;
        b=sppEugFWLaOlOHW+wwDy7WaD/Cxpm6q/k97hF3Rr5G1l/mEm93OulfyzW8q1GpXMPC
         XTmVAE4KC2SJq5h+iUYTZf/cyUsRpdJIXpqI34LRGXKvMdLjWmKbTxiidIzOCnOqlfeo
         xERbCIkf3WsnVnn3ACTuJdXh7qkVK9cg3Hb+7WyuYRa0rd1vUD9TAPhOKAD5la80zqFh
         ApAQyHCWSdXy1oReQSbTkqsKUbMUDmJqJiKadheJmmgc7XbgT8rUvPu2Y0/hSEOoOsFp
         l3LEseWQnPSAMkVyCitG5r2DR013GSpO1f330v3TCETTpCbcJvjCHJ0iZ00QBGVITLxv
         udAg==
X-Gm-Message-State: AOAM533oP4/Lu+3/MSW/MRpJUWED7cVWVItwWXAwHBIjrRzeBeQ6mnO4
        H3po6oAK1XXjEi+j7La1v6KdFdqLG0Y9CqF03Po=
X-Google-Smtp-Source: ABdhPJxt7GLkiELgSKahdlUf+bIA8EAT61FIDSGEdXptYhdNj+vgN0O6ZekTN7Dj6Shx/cjy4lI4W/OrNanbBOr8v+8=
X-Received: by 2002:a63:cd11:: with SMTP id i17mr30507573pgg.74.1620741381507;
 Tue, 11 May 2021 06:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com>
 <20210511134706.GI4496@sirena.org.uk> <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
In-Reply-To: <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 May 2021 16:56:05 +0300
Message-ID: <CAHp75Vca2KT4kd9zw3ECqym1rRDSg2NNbwRRVVA1L7vyD3VCJQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] spi: pxa2xx: Set of cleanups
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Daniel Mack <daniel@zonque.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Haojian Zhuang <haojian.zhuang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 11, 2021 at 4:52 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 11, 2021 at 4:47 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Tue, May 11, 2021 at 03:28:18PM +0300, Andy Shevchenko wrote:
> > > On Tue, May 11, 2021 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:
> >
> > > > On Fri, 23 Apr 2021 21:24:27 +0300, Andy Shevchenko wrote:
> > > > > Set of cleanups here and there related to the SPI PXA2xx driver.
> > > > > On top of them, adding the special type for Intel Merrifield.
> >
> > > > [07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
> > > >         (no commit info)
> >
> > > The above patches are effectively missed.
> > > Anything to fix in your scripts / my patches?
> >
> > Like I said, patch 7 didn't apply so you should check and resend.
>
> I didn't get it. I have effectively rebased the entire series and resend as v2.

v2 --> v3

v3
https://lore.kernel.org/linux-spi/20210510124134.24638-1-andriy.shevchenko@linux.intel.com/T/#t


> I can speculate that your scripts have a bug since they might try v1

v1 --> v1 and / or v2

> as well (as far as I can see they usually send a confirmation of
> application for all versions of the series in question).
>
> Sorry, but I do not see an issue.




-- 
With Best Regards,
Andy Shevchenko
