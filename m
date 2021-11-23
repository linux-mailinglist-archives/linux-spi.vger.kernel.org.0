Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3C45A9BC
	for <lists+linux-spi@lfdr.de>; Tue, 23 Nov 2021 18:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhKWRPE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 23 Nov 2021 12:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbhKWRPE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 23 Nov 2021 12:15:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6974C061574;
        Tue, 23 Nov 2021 09:11:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id r25so58170268edq.7;
        Tue, 23 Nov 2021 09:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWSy0mKk/NHigQIkeCuN/Jyx9lrqfoIjKQgE35svo8I=;
        b=I2pzPwKQLkf4ChqTCWng5/ECX4Adh11oXAsjKJgwlgyKwRZikrBHBdKOtI8ofm4TaQ
         varsTinvv1aMmkvL+ElErm1AdjfsN4PObxItYitGrT2LGsgd57oyKnM005k8CEm/VOfs
         HhbtIkbzhNr2OaEelV1J57dlfzekygQYTRCx/b+hgtkhHElCrltbi4q48g55+0r8tNvh
         BgqAZMy692GBUdhT3FXKgiQEjkuycdEJ9D+xESdvaUqLySLa3kj6wwEjY08pB+1XVL6G
         S+uHNsRany7EjGA9OU/aj1KPn1OW8Yma1QJQQoGGR6BQie/fvsrCGR3TyMPlqvggfZTd
         DR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWSy0mKk/NHigQIkeCuN/Jyx9lrqfoIjKQgE35svo8I=;
        b=zZxuha4iT3naIOc4SVZCItqQDGBXySpz+px4DnMi0X0oMz6ebR9zUWoTJiFOWYCFUl
         McQeJEn4QtYiupH94TjEtdY8tM9huWBACPRrqKo8ekY1AwRTcRiWO/+DvnKmTVD+EdNA
         bRoOBukN3bX+q+fgbI+WjY9Vl/RQRG/9o2G4vKJ5k7Ay73FdXl4QzymDOWGq5tlpZrx5
         O3sU5j9RKd0OX0uNUjGVRoMvnjsB670msEjxTSwJ2GJDypPm+DkhlW/Tw/gc3cKBaEaK
         ZBjPh+hMWfQqoCi689YUid3XQI1QXkXV+nInACfiLgGEkXBCAM9jxT1tAME0Z06Pl5JU
         /sGg==
X-Gm-Message-State: AOAM530d+S/97HY+7nFP8LdeaQOk4/GBdU86dhIkwQspEJ2r4PUO/6aX
        +pfJmb2jBYsLoEH5v8ylbWC6B8bHJFXCmIu7PdpIolfRSV/WWQ==
X-Google-Smtp-Source: ABdhPJxVdjjvDH2b+sWvW8DkC9v6WajXnhcf/Zx4ovHgPWxWbyErVTEyKnQx7rFLDWqLFZUN4NuK37lMPGYkwlRsyAE=
X-Received: by 2002:a17:906:ecac:: with SMTP id qh12mr9358799ejb.377.1637687514297;
 Tue, 23 Nov 2021 09:11:54 -0800 (PST)
MIME-Version: 1.0
References: <1635747525-31243-1-git-send-email-lh.kuo@sunplus.com>
 <cover.1637547799.git.lh.kuo@sunplus.com> <e5f2549224cf875d81306ef5f6e98db1cfd81c2e.1637547799.git.lh.kuo@sunplus.com>
 <CAHp75Vd2=OHbrpGtsU8AMXdtNfvSPhpc7vhzkWnahaV48XbfUQ@mail.gmail.com> <YZz0n6Mpjl3tKmMe@sirena.org.uk>
In-Reply-To: <YZz0n6Mpjl3tKmMe@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Nov 2021 19:11:17 +0200
Message-ID: <CAHp75Vf6+monqu4Hq-yoFSohD9tNFqZTuKjqDDKAJE3Om2BUYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] SPI: Add SPI driver for Sunplus SP7021
To:     Mark Brown <broonie@kernel.org>
Cc:     "LH.Kuo" <lhjeff911@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dvorkin@tibbo.com, qinjian@cqplus1.com, wells.lu@sunplus.com,
        "LH.Kuo" <lh.kuo@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Nov 23, 2021 at 4:03 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Nov 23, 2021 at 12:09:54AM +0200, Andy Shevchenko wrote:
> > On Mon, Nov 22, 2021 at 4:34 AM LH.Kuo <lhjeff911@gmail.com> wrote:
>
> > > +// slave only. usually called on driver remove
>
> > Why is it so?
> > Also find use of proper English grammar (capitalization, periods, etc.
> > Ditto for all your comments.
>
> Please don't go overboard on changes you're requesting, the important
> thing with comments is that they're intelligible.  People have different
> levels of skill with English and that's totally fine, it's much better
> that people feel able to write comments than that they stop doing so
> because they are concerned about issues with their foreign language
> skills.

Shame on me! I'm also bad at English (okay, sometimes).

...

> > > +       unsigned long flags;
> > > +       struct sp7021_spi_ctlr *pspim = dev;
> > > +       u32 fd_status = 0;
> > > +       unsigned int tx_len, rx_cnt, tx_cnt, total_len;
> > > +       bool isrdone = false;
>
> > Reversed xmas tree order here and everywhere else.
>
> Again, please don't go overboard - this isn't a general requirement for
> kernel code, some parts of the kernel do want it but outside of those
> areas it's not something that we should be asking for (and TBH even when
> it is required you should explain what it is, it's not as easy to search
> for as it could be).  I certainly don't care.

Here it is. The "reversed xmas tree order" implies that longer lines
in the definition block, where one puts all variables that are being
used locally in the given function, are going first followed by
shorter ones. This makes it a bit easier to read the code. There are
also additional rules that may be applied, such as defines with
assignments _usually_ go before anything else, error code variable
separately and last. That said, the above might look better in the
following form:

       struct sp7021_spi_ctlr *pspim = dev;
       unsigned int tx_len, total_len;
       unsigned int rx_cnt, tx_cnt;
       unsigned long flags;
       bool isrdone = false;
       u32 fd_status = 0;

...

> > > +               if (of_property_read_bool(pdev->dev.of_node, "spi-slave"))
> > > +                       mode = SP7021_SLAVE_MODE;
>
> > There is no need to check of_node for this call.
>
> OTOH if we are checking it anyway it doesn't hurt to have all the
> property reads in the check for of_node.

I assumed that previous comment against SPI ID potentially will be
addressed by removing that code which in the result gives unnecessary
use of the of_node check above. So that's why I pointed this out.

>  Either way it doesn't
> fundamentally matter.

True!

-- 
With Best Regards,
Andy Shevchenko
