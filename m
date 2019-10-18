Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B675ADC2ED
	for <lists+linux-spi@lfdr.de>; Fri, 18 Oct 2019 12:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439392AbfJRKjW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Oct 2019 06:39:22 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38284 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439353AbfJRKjU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Oct 2019 06:39:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id l21so4186437edr.5;
        Fri, 18 Oct 2019 03:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdGZ/O1UBefa0/Aw3vNnx5zYKetp+so1lp2xpas4umw=;
        b=mEHKyOoTqwmR0aTE5OFLDghsTCB1Biaiy9UW26U9qCuaq2iKlynp+5R60NwG2zQoA+
         eQ1yHJYUuhWt6BYmxywdlbb3UKjpI6eNc2EskkhrTvpzSzq8QgmVafMzyay88Cuzewkt
         xWg6HLQqtUDtm1UD+ZxdHdTEJbrL8HuAbvCaT+9u4eiWMq7DDyYHt/CQzpUF6JeHDhru
         oNFOoPhIKHkPPOokpuk8cTKvKlEvCzb7PvbFFKcgK0qZUpBWyB8LIoK2fKEzI5z2ptoN
         8xRZ0AvKeQKyNA86QSGbipvZjS/4BwpaqwF0fZEUYo8/eVoaC5Uk6aomkkaquXT44XS7
         wU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdGZ/O1UBefa0/Aw3vNnx5zYKetp+so1lp2xpas4umw=;
        b=E5XtPnS5E1JSFNfHmT1QdFgsHiz708/8WcPprOYDUTFi0XvJn0mh7BITQXqkKw/VEH
         JCk8eabTo7jktWdg8sOo+yjxuhV57YQzOlXX6wDlMoCdDzp/YjLowr7VXd59Sad+vfZp
         UCLfHr4liBMcjPnrEX6pC9cZQjzZcRLfaAINNu60n+LkSwrYP+4x33WWhfILgNiuhYvt
         fJPqExbLfM46vLdbW4+QP+BYQ6KvRGC70w3h2krpo9IcGay5WdX1STSp074G/H3x2GZW
         J/elBVAsqCKC8ccQwnBYsE7/zlocNxe7vFBSB/odFTLZHVEd3RM0xm4OkZw3DG5/JadK
         o0rg==
X-Gm-Message-State: APjAAAWOojnQJWofqPaXOxGeplNW+QAzD1EOTymCqnroIHYvLyID8AzV
        XNLP5a3SEKlViP0i0GghIv4O2657E3uqjaua7x4=
X-Google-Smtp-Source: APXvYqxnhNJ1p2Qw24cDRg7N1pWEV2tiucdyj8NEuD+nENTq7YS/DvNr7sw2b18boMqr51gNammWqfUI3G6dIFr7HYc=
X-Received: by 2002:a17:906:8313:: with SMTP id j19mr8131952ejx.196.1571395159085;
 Fri, 18 Oct 2019 03:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20191017025058.31528-1-hslester96@gmail.com> <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
In-Reply-To: <CAHp75Vd2SMERjtvNumxAF1HSp8GSThmcyx96zkFzUXKwnD5d2Q@mail.gmail.com>
From:   Chuhong Yuan <hslester96@gmail.com>
Date:   Fri, 18 Oct 2019 18:39:08 +0800
Message-ID: <CANhBUQ2yxGbjk_DgXbip=TPT=evzA5naoJSY9t1_Ep47e9oupw@mail.gmail.com>
Subject: Re: [PATCH] spi: pxa2xx: Add missed security checks
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Oct 18, 2019 at 5:35 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 18, 2019 at 8:59 AM Chuhong Yuan <hslester96@gmail.com> wrote:
> >
> > pxa2xx_spi_init_pdata misses checks for devm_clk_get and
> > platform_get_irq.
> > Add checks for them to fix the bugs.
> >
> > Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> > ---
> >  drivers/spi/spi-pxa2xx.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> > index bb6a14d1ab0f..2e73d75a6ac5 100644
> > --- a/drivers/spi/spi-pxa2xx.c
> > +++ b/drivers/spi/spi-pxa2xx.c
> > @@ -1565,7 +1565,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
> >  #endif
> >
> >         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> > +       if (IS_ERR(ssp->clk))
> > +               return NULL;
> > +
> >         ssp->irq = platform_get_irq(pdev, 0);
> > +       if (ssp->irq < 0)
> > +               return NULL;
>
> I'm not sure they are mandatory for all platforms.
> To be on the safe side, you simple need to add _optional() to the both
> call along with above change.
>

As I know, this is the only one in spi which does not have a check for
devm_clk_get.
Even if add _optional(), they still may return errors and need security checks.

> --
> With Best Regards,
> Andy Shevchenko
