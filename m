Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5C27EB7C
	for <lists+linux-spi@lfdr.de>; Wed, 30 Sep 2020 16:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgI3Oye (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Sep 2020 10:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgI3Oye (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Sep 2020 10:54:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25676C061755;
        Wed, 30 Sep 2020 07:54:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z19so1329220pfn.8;
        Wed, 30 Sep 2020 07:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJhQCXpRGm8FUXhAr6Vz5RV86puvSsNWUXZgL3Fcg6c=;
        b=qnx92e+4s87JHVjeODuZAZnpNByMGegdR3BZJPP/2tjTwUP9tdkIdTJ2rj8AbZJX5v
         rF2VzdUB0t4+R/P8xtpTcd2/QSze82LGge21WffNgJiGrvYLohyKBxqKJk2f9i7V8ZuQ
         F3VFVVyhEyoWTM7bBVIKuc2E4Gp8j/GwS3SY8prma+cwvbQqDGi/qKu8n75fu32FNEqi
         bkwkDcy66NAqLguDS7/u8Y2mVTkZzYGPJRFEArZHy9R/rxcrjy+xu/a+7jdyNRYitZ7m
         E3Z9OaO4vH/GjCxKq7/k+GieZTtYAZFjCTOiPSN/NDO0W6mGhhSAoXzA5r8+MqUJUDNp
         ht4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJhQCXpRGm8FUXhAr6Vz5RV86puvSsNWUXZgL3Fcg6c=;
        b=H95RkpV5kQIbJu7VWG8ghgA8WeWt+V6H5bb/NZBAeqNnCBOLNYD8ACmmmCoSvVqSWb
         XwxlB2GpbvsEMTBfXaYgseuLTIiAGnCVAk/35UUtFW3xdvx9SFe9NzLi3L46BoYcZwZA
         hCxpTlQRBsjKGBr4pxwAfjj91Hq7e+9CkWfQDNB9X42Kud+M7CQyFLIFd4/nOBHqTX+/
         0JWyHOQ4aYSk9K554WAyHy85gMENYccuHbZ64JyeSGDj7Ga/TQ/06jGMUDieMcrT50vh
         GnhrhZdWPdQswptM3ki2DLg00JYfqoUjHKhVwsX4JMKTrUR8ZD9B397X6dR4vCBNKfQ/
         SIIA==
X-Gm-Message-State: AOAM531KEwnbSxe8tVNy01LHb8iJsoVGtZIcW9jrNYX3L+mv6y/Os3KF
        ld1BNLx6ZCZN4yT+fm0zGgqcpSiL8SnCG5lHZWhMjLJT1HuT4w==
X-Google-Smtp-Source: ABdhPJxeiYdpgCVWc+MyfKz6IVFT4WqgzXa0GFi2cV+3Rcac7xuXAF/3KBSTG3EM/qmimAH89lu6Lxui+kyPnLR6k5c=
X-Received: by 2002:aa7:81d5:0:b029:142:2501:39fa with SMTP id
 c21-20020aa781d50000b0290142250139famr2859629pfn.73.1601477673714; Wed, 30
 Sep 2020 07:54:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200930135137.197592-1-thomas.petazzoni@bootlin.com>
 <CAHp75VccK7hu51qCdRC4GaTO3XaSaYLD6TeuuqHLY9Tf1Tb67A@mail.gmail.com> <20200930165037.77813365@windsurf.home>
In-Reply-To: <20200930165037.77813365@windsurf.home>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Sep 2020 17:54:15 +0300
Message-ID: <CAHp75VdU5N6dBKgDudod+0cHumAreHCHgi1+xGqXtvpkiLNz0Q@mail.gmail.com>
Subject: Re: [PATCH] serial: max310x: rework RX interrupt handling
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat@cesnet.cz>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Sep 30, 2020 at 5:50 PM Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
> On Wed, 30 Sep 2020 17:24:48 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> > > On a Microchip SAMA5D3 platform that is receiving 20 bytes every 16ms
> > > over one MAX310X UART, this patch has allowed to reduce the CPU
> > > consumption of the interrupt handler thread from ~25% to 6-7%.
> >
> > Was it always like this?
>
> As far as I can see, yes. I guess you were thinking about a Fixes: tag
> perhaps? I don't think a Fixes: tag really applies here, as we're not
> fixing a performance regression.

Thanks for elaboration.

...

> > > +       /* Reset FIFOs*/
> >
> > Add a space before the asterisk.
>
> Indeed. Let me know if a v2 is needed, or if this small typo can be
> fixed when applying.

Greg usually doesn't touch commits, so v2 would be better.

-- 
With Best Regards,
Andy Shevchenko
