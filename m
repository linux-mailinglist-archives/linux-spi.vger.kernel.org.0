Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7720F868
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jun 2020 17:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgF3Pcx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 30 Jun 2020 11:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389385AbgF3Pcw (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 30 Jun 2020 11:32:52 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B066C061755;
        Tue, 30 Jun 2020 08:32:52 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id c16so21441371ioi.9;
        Tue, 30 Jun 2020 08:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fTZIk7o4I3v9sDO1ioQg65WFbAcbrwuzrZp6bqG2TZs=;
        b=SLNEacNnXUaOSknJvbz9ftmBYbhGROQqfmRN2jCu+oUjMlkNVC7L0DnsVQmrHBlaRI
         5t9+YaZ3fxK4ku6fb+GPJKRfCG+Gps1qplj+0digh8uJn+GB+1JCG9Wzyl02o25PGelP
         jjz8iA9Z0KkEkHWlrSiPsWZQGxioYTjb69FIRUrryO7BtD4wWSjN4SSDkRErIBuVuxNx
         0Er+SiLvwIuVSKl+6GUCUZEwRsO/ajwCcaiu8dXRPPfPul65ngxfwh8CITu5HLwJg6k5
         BnZwSlDfE/HqcS6lphCwBhiU+2Md/l2E9L4RXlcd7S2l5erQM1rZl/g1zIVhMlCkQRPN
         8Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fTZIk7o4I3v9sDO1ioQg65WFbAcbrwuzrZp6bqG2TZs=;
        b=eDWu1cO+h9sgD3JUlOYZdyKrMGzcWBm30s7QG7b3ZWu8MsIuCZDpBud5Bsl7Py+NKT
         T1YlVCYDsGB7feBUY+JFuB8RuV/UH/0OPuszkWtJl9cyFzp8x1zOVhxEVCRhnszPkJR6
         q0+ZI0gD3R4kePaHoKcHfnyJfBWjjdeUtHX/kjBikUlmBDjw5MC+PgVWD+g2jfIYuPva
         IymUwpp2ls8ZzQpNcou6SjbZ2uPN25p2CzemiJItyHh5MNbs8zZWCryFsbWaeNL3SpI8
         ePAYTNTOdT+MmVXLWZZM67EcTBeKvYoayly/tUDtamqrOdx3MQBIgrJBXiVNY9DtGAAH
         8jMg==
X-Gm-Message-State: AOAM531S2Kh13P0CAYJgSqScd2iMvEEIj/cUMmhyl3ipqxxkWCS7buY2
        5tV2Lb/WLTf9jcmjA3BAqn8qXdk8fo1DpjS/8GI=
X-Google-Smtp-Source: ABdhPJwmeqxFiF/UYomtYzSa1zyensrGB2NlVyhR0lNiVAk/rpt8vIaIoeUrWdkkS5pkKyqbHpik7IWOHz0pvwB/6Z8=
X-Received: by 2002:a02:6d27:: with SMTP id m39mr24703937jac.10.1593531171771;
 Tue, 30 Jun 2020 08:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <1590378348-8115-1-git-send-email-dillon.minfei@gmail.com>
 <1590378348-8115-7-git-send-email-dillon.minfei@gmail.com>
 <CAHp75VebSZa6mwAETnM0t42RQCp4iM6_SNjmy3TB48ixsGKV8g@mail.gmail.com>
 <CAL9mu0+jmcivC6zAXxK0-oXy3n44pAU1QGD7BDq=CT2D7twROQ@mail.gmail.com> <c085e8f5-f626-28a9-1d3f-a1c277ec5052@tronnes.org>
In-Reply-To: <c085e8f5-f626-28a9-1d3f-a1c277ec5052@tronnes.org>
From:   dillon min <dillon.minfei@gmail.com>
Date:   Tue, 30 Jun 2020 23:32:15 +0800
Message-ID: <CAL9mu0LPuqRn-tKWWzyUWnOE2h-w7F3-6HTYv15QcUYWBroXZw@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] drm/panel: Add ilitek ili9341 panel driver
To:     =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andy, Noralf,

gentle ping for this patch set,
do we have any new structure, or idea to support both dpi and dbi
interface by one drm panel driver?
from this thread
https://lists.freedesktop.org/archives/dri-devel/2020-May/267031.html
, it's seems
discussing was stopped at may 25.

if there are any new information about this topic, please feel free to
let me know. hope i can make some
progress on it.

thanks,

Dillon,

best regards

On Tue, May 26, 2020 at 6:38 PM Noralf Tr=C3=B8nnes <noralf@tronnes.org> wr=
ote:
>
>
>
> Den 26.05.2020 11.08, skrev dillon min:
> > Hi Andy,
> >
> > Thanks for input.
> >
> > On Tue, May 26, 2020 at 3:46 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >>
> >> On Mon, May 25, 2020 at 6:46 AM <dillon.minfei@gmail.com> wrote:
> >>>
> >>> From: dillon min <dillon.minfei@gmail.com>
> >>>
> >>>     This driver combine tiny/ili9341.c mipi_dbi_interface driver
> >>>     with mipi_dpi_interface driver, can support ili9341 with serial
> >>>     mode or parallel rgb interface mode by register configuration.
> >>
> >> Noralf told once that this driver should be unified with mi0283qt.c.
> >>
> >> So, what should we do here?
> >>
> >> --
> >> With Best Regards,
> >> Andy Shevchenko
> >
> > from sam's suggestion, we can't setup two drivers to support one panel
> > in the tree. so, i copy the mipi dbi part from tiny/ili9341.c. to this =
driver
> > from register settings and dts binding is keep the same to tiny/ili9341=
.c.
> >
> > so, in my opinion if tiny/ili9341.c is unified with mi0283qt.c, this
> > driver should be
> > too.
> >
>
> There's a discussion about MIPI DBI panels here:
>
> MIPI DSI, DBI, and tinydrm drivers
> https://lists.freedesktop.org/archives/dri-devel/2020-May/267031.html
>
> Noralf.
>
> > thanks.
> >
> > best regards,
> >
> > Dillon,
> >
