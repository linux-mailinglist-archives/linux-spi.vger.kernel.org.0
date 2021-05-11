Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9960837A828
	for <lists+linux-spi@lfdr.de>; Tue, 11 May 2021 15:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbhEKNyE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 11 May 2021 09:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbhEKNyE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 11 May 2021 09:54:04 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A7AC061574;
        Tue, 11 May 2021 06:52:57 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id i5so11043269pgm.0;
        Tue, 11 May 2021 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CD4qa8FyAT6mL+EEYGbyY0wBygRbxbqBvXVGfdE2Evk=;
        b=rkV2ifSy2lgtlbUuIgsoXLgXbRczYROMcDPWDUkJztxrvOZBBmI1hMd1/9aFfI7jtW
         Kjr8ljJDkO86QZrT/UZ/xc1c37fBOm4FaAjy94m+mZRJ1m/lf02CHIu+5tAPqQuPoeEg
         cGcukqqcyQ/wWa0tN7rrtVS50I3UX2tK3+sLpMPdrhiLTg1UWWlf9XePKCvZCfsl1Vqq
         jiXznX0W2LWVsB1Z8u/cva4Ky8LMdejJYKNYFM21INGSj3SnSEvFz5Q3aYkeKHkeB8pU
         5VADP4sstpdIkF/dacfeYAwC4Xidv4U6n5fhLj9B4ryRrEwv/gqCKkFnEC85eMBX4VSD
         Htjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CD4qa8FyAT6mL+EEYGbyY0wBygRbxbqBvXVGfdE2Evk=;
        b=FFOx1DsNdBrNYVEt+RTiTY0UG4VO7giR+69mTlJux3rORi8dHUa/ks0xUum08S73gN
         NYn1Vj973GI9tKoYILnHhh7dhnb80PXysPsFeZ6FNiVKG0rLbJ+EAYxkqa9ZqjgDFcvU
         GPCexA6oHhJn55cnWhc+Q/HtN0QxYeb05sgMxbkiQG3s6W+qnXYq6zAhlK5C8cOVlhIC
         Ig+w8AjQVTufO4L2tWQF3tvyBowu20wBFMttToodyrIJMs1nR/ZMSWCi2MVcp7NLxLTN
         Uvkny1kpwPRN9hC/FqCASvD5jGA/cVB0LvamkOhHjMW8P/sKr1d9O83ztNvukJ/foMsi
         xT3Q==
X-Gm-Message-State: AOAM531vRaGqjWLpnLsTV9SNtkaDmvQKG3Y7SUpsXl+hprZM87/SKpdj
        VcAOLwmjgS7etefe2lOgPFnBW8Gq0hUMQXcaz7Q=
X-Google-Smtp-Source: ABdhPJwnOIQ3nc4MPpWcwjkvu2Scafr7CXpFjmL7/aVxuFKV7X1yh5DoeflKHx9vByTnLfY9SeLH8ybUmya74kme7gs=
X-Received: by 2002:a62:528e:0:b029:1f5:c5ee:a487 with SMTP id
 g136-20020a62528e0000b02901f5c5eea487mr29900674pfb.7.1620741176603; Tue, 11
 May 2021 06:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <162072071980.33404.13031284441613044277.b4-ty@kernel.org>
 <CAHp75Vck5izDB4mTRV5hTaknpx5Bm+OA4rNLVznQxVaEwigBZg@mail.gmail.com> <20210511134706.GI4496@sirena.org.uk>
In-Reply-To: <20210511134706.GI4496@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 May 2021 16:52:40 +0300
Message-ID: <CAHp75VdPHYEq+Xn5yQ+TyQn5uerc+afcVaHj22OmVzsBW2jcaQ@mail.gmail.com>
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

On Tue, May 11, 2021 at 4:47 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 11, 2021 at 03:28:18PM +0300, Andy Shevchenko wrote:
> > On Tue, May 11, 2021 at 11:27 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > On Fri, 23 Apr 2021 21:24:27 +0300, Andy Shevchenko wrote:
> > > > Set of cleanups here and there related to the SPI PXA2xx driver.
> > > > On top of them, adding the special type for Intel Merrifield.
>
> > > [07/14] spi: pxa2xx: Introduce int_stop_and_reset() helper
> > >         (no commit info)
>
> > The above patches are effectively missed.
> > Anything to fix in your scripts / my patches?
>
> Like I said, patch 7 didn't apply so you should check and resend.

I didn't get it. I have effectively rebased the entire series and resend as v2.

I can speculate that your scripts have a bug since they might try v1
as well (as far as I can see they usually send a confirmation of
application for all versions of the series in question).

Sorry, but I do not see an issue.

-- 
With Best Regards,
Andy Shevchenko
