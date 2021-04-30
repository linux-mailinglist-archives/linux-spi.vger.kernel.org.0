Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20E936FE82
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhD3Qay (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Apr 2021 12:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhD3Qax (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Apr 2021 12:30:53 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC82C06174A;
        Fri, 30 Apr 2021 09:30:05 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id a12so6526897pfc.7;
        Fri, 30 Apr 2021 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGnjFPqxnyb5x82q+W2CEVoaczedymBQh3usKng2HjI=;
        b=Mq8BnpcggakwdADR+l7TEADjpZCptUOLodAA2Fk2Cu/wikEtBTG1Gq4ByBdcX08JG7
         XwmRwmfAQLmGztsG2cdLOFYuZ9lBtkOEpUNTSuSf62GJdP+VVXVvPY/UnbHoY+ksYXXU
         h62l+uJsXshOLalIAk0u6ZTbogqQHJjOmIv9gdztyhc9bAORRajPXfwO/+JLUXsRbHQ4
         SXvAEn+tKgl1sKLo3GmUTyXbf0C5o1ruHqJR9YplMGhaFTwx8RFxX6G7cBjWBwEUk/6y
         QcDu+q4bF0gDWolqiGqKc9mdkfLO1qhqtpub3DzCggBF5B1YrdgN7lE7ReCL0ch5agQC
         k3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGnjFPqxnyb5x82q+W2CEVoaczedymBQh3usKng2HjI=;
        b=nQi+s7nVe7V8pfdtMFEccNQeVRmYLu4ge+S6hRYz+wzTs+cQQcujNzLyL7zk664Ex+
         V0WMGluVnQDIQEsDYPhA0rB/xV62HhhjLenTXTZRbqJHQxLpTtP+F9Tgtqst2DCPeFem
         cWrd23SvA4eaJqDoix5VYI0HcRd3lMcVyhtsVsLdOAELDdUU5rQrVtJX2CK0Ff7OBRqp
         eOz5D2p1NVSWLetctM6PhGtPHEJ152P4w3veMk8W6bUINtf0S/myATDVz6rPWzNgtpZM
         hXPnIP/hYdBiXIKUwgRKiZguz4HemLGpvE7Zy6XWdQQq3x7FIuR7vO7YHmX8vSAcOmys
         tOzA==
X-Gm-Message-State: AOAM531AorZm6XWKhoCCurlHRmJXktTbNpSxVnPJwXrvufBIrm/JZ9rp
        TOA44GYUs3GsdP3ZBQLSmqkETeLyctRFk949YsY=
X-Google-Smtp-Source: ABdhPJz4Wo0tSXk/MEkFk+6tZ5WpZD121L1ZAR3xvO6qKPh7FOaDtxTIgZhkVktO0lqILvWBdyc7vMdKL9mTOmJzcy8=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr5388538pgs.4.1619800204608;
 Fri, 30 Apr 2021 09:30:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210423182441.50272-1-andriy.shevchenko@linux.intel.com>
 <CAHp75VeiHsk15QoG3X-OV8V8jqzCNeKkif9V=cx4nvKVHaKbKA@mail.gmail.com>
 <20210427143457.GI4605@sirena.org.uk> <YIglWpz8lSidXmDd@smile.fi.intel.com>
In-Reply-To: <YIglWpz8lSidXmDd@smile.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 30 Apr 2021 19:29:48 +0300
Message-ID: <CAHp75VfBSjHP1LJZJTdwXzGuE2YjxdW6r7Zf6ofHsquJBPMyWA@mail.gmail.com>
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

On Tue, Apr 27, 2021 at 5:54 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Apr 27, 2021 at 03:34:57PM +0100, Mark Brown wrote:
> > On Tue, Apr 27, 2021 at 02:46:02PM +0300, Andy Shevchenko wrote:
> >
> > > Mark, are you accepting patches for v5.14 now, or should I resend
> > > after v5.13-rc1 is out?
> >
> > > (I have few more in my queue :-)
> >
> > Send them now if you like.
>
> Got it!
>
> I think I prefer to produce a less noise in case this series for some reason
> needs to be changed / amended. I'll wait till this series lands in your queue.
>
> P.S. basically my question was about this series.

One item is still unclear to me. I noticed that you started already
applying patches for-next release cycle (if I understood it
correctly). Hence the question should or shouldn't I resend this
series after rc1 is out?
If I shouldn't, do you have any comments on it? If no, can it be applied now?

-- 
With Best Regards,
Andy Shevchenko
