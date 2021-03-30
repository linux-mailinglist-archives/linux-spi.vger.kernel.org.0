Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59F34DE30
	for <lists+linux-spi@lfdr.de>; Tue, 30 Mar 2021 04:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhC3CUk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Mar 2021 22:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhC3CUV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Mar 2021 22:20:21 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876C9C061762
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 19:20:21 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id dm8so16372571edb.2
        for <linux-spi@vger.kernel.org>; Mon, 29 Mar 2021 19:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNHTcB7T4m2UhGaP6tF0hE5xsssyn7CBJeCl2o2y96c=;
        b=3Jk70Zk4F5jowxsYWm3lTWYYlFYvVtweN2HMGEERNCWJJoFJScnelnvTOGhHoGtEHF
         bjWgFDtn1L6n3yORUefyad+0vjG24U9GJNwJRGuyz6k8ScIp9qXoNqdkiEeHH/JFHPVC
         KUG8Fa7VA/iCSp2eXPHM42dNLXgO1ZCzVk7aZcKwKUE0V4e43WySAFGTmyQ4OibO7zZQ
         np1ngO5SCpzrNuQhxfTy1UE16zRzBoLG+LrAieW8c4tE9+JhJuQqW8tTRGa6jOt9aM0M
         raa/SHExfWUvx5PesBNPEjW1Li7Y/pw2lpWu5Xs5UckyIttjnuxifL61PIMKgNj0c1x0
         qccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNHTcB7T4m2UhGaP6tF0hE5xsssyn7CBJeCl2o2y96c=;
        b=pXKxnbbOAtXeTHgqYb7O4O3JWsl/1GOhTfx24MWHBntEigZeVi+NufFDMlx5aW98pa
         gx2cvwhJV8aM/mZV1X9k4WrrK8NyPzUvpd3+dtwdWYR5T5/b6pKZlLVhoQ/qItI1me3K
         UfOkpe6SLTfuNdlfGn9DFEm/Y7gpOvQ1iYjqb9k6eD0x8gxiZwpYQbDfmWuXnW27vzK0
         XSyUhcfTzNZBTgxl5IuYyK66B6tAGfBfihTqBel0Vx2o6qJzTfGna3z99vo5J7rnYsSb
         k9pA0gr8UOfLX5R4JfBWiUdAgeAceLtT+9ungexDfu0HHf9DNyHmS/Uov4VE3wR6q/yN
         XntQ==
X-Gm-Message-State: AOAM533xTdRprdagkAXnDqgcGR4QOjijhommmMcXZQBTjJ9KzDQxWbzO
        lrrYiqmYZQgUN7+5Z0hUTSkyZMgMchQgipjp+M7eEg==
X-Google-Smtp-Source: ABdhPJxH6gMBXO9lUMvfVnMPvFOCVPVBGxmo2plP7nneNga21Eq/glfl39TCieWaga31tJtldBkoruBR43eR0xdv6v4=
X-Received: by 2002:a05:6402:b48:: with SMTP id bx8mr32418567edb.162.1617070820221;
 Mon, 29 Mar 2021 19:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-14-brad@pensando.io>
 <YGF4Ns8+S9I9Za33@kroah.com>
In-Reply-To: <YGF4Ns8+S9I9Za33@kroah.com>
From:   Brad Larson <brad@pensando.io>
Date:   Mon, 29 Mar 2021 19:20:09 -0700
Message-ID: <CAK9rFnxOVShmWFJYKyKgGX9FzqXFbNrPgNwZWqn4bspCpa5=KQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] gpio: Use linux/gpio/driver.h
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Mar 28, 2021 at 11:48 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, Mar 28, 2021 at 06:59:38PM -0700, Brad Larson wrote:
> > New drivers should include <linux/gpio/driver.h> instead
> > of legacy <linux/gpio.h>.
> >
> > Signed-off-by: Brad Larson <brad@pensando.io>
> > ---
> >  drivers/gpio/gpio-elba-spics.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-elba-spics.c b/drivers/gpio/gpio-elba-spics.c
> > index 351bbaeea033..c0dce5333f35 100644
> > --- a/drivers/gpio/gpio-elba-spics.c
> > +++ b/drivers/gpio/gpio-elba-spics.c
> > @@ -6,11 +6,10 @@
> >   */
> >
> >  #include <linux/err.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/driver.h>
> >  #include <linux/module.h>
> >  #include <linux/io.h>
> >  #include <linux/init.h>
> > -//#include <linux/of.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/types.h>
> > --
> > 2.17.1
> >
>
> This should be part of patch 1/13, do not add a problem and then fix it
> up in the same patch series.
>
> thanks,
>
> greg k-h

Yes, thanks.  I'm laughing at myself today looking at that patch
tagged at the end.
