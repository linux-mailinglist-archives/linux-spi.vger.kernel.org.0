Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 938D2B4EC4
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfIQNID (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 09:08:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43234 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfIQNID (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 09:08:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id t84so2736371oih.10;
        Tue, 17 Sep 2019 06:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g5v8FU71dAfo6AK8WTwyNN8dUr35hQbvr87IlwvE3Io=;
        b=GaQCfgDmoIJDIj/HMimAHculytQx+8TRcXB+HkljHd29Db/5qwdcLBUlyTNzd2mHic
         FFVjzssqTBaTXoKHkcsPy14+IMrAkH/4f9Q2fqqNPlp+fxGEgMsONIOe4qW9uzAhnUNT
         VEa0C7eUZUdG08andew3N7iU6rewjQ1Qd2ihRVtblKhinW8s/JDc/AbNAAjXjxIUjqXa
         +jlBgHpUpym7zeGFW47Sd1b0SqDTFrKgY7xSziGMtu4KnnUc3TKo6+qvkFo2BNyqXIAG
         Kqp3pgc0a/houA1VOuCuDTBRDO33s/TLBu0EdAhcCU64KdK+l/djRbQoltcep22hg/2t
         vcPQ==
X-Gm-Message-State: APjAAAU71hkjtwcQguruxLO3nfI/nsQhQMcazaD7pd6DjViBgOztQsnl
        eT3pQex+1X95Bei1lTxn4QsQkuIepcuBeYBrJyY=
X-Google-Smtp-Source: APXvYqwaN0kfjgdIW7t8fVP0vFGof1Lyd2AQyOoUJABwhT7LNqO2zCq1HVMxQCezu3Iin5SuAjx5mTMktLbiN4Zh36M=
X-Received: by 2002:aca:f305:: with SMTP id r5mr3356423oih.131.1568725681893;
 Tue, 17 Sep 2019 06:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190917085627.4562-1-mail@aurabindo.in> <CAMz4kuJczzjTPSohQ=kbZ0Pr7U_9-hzXk-jPgKk79PENOM1-dA@mail.gmail.com>
 <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
In-Reply-To: <alpine.DEB.2.21.9999.1909170514130.11980@viisi.sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 17 Sep 2019 15:07:50 +0200
Message-ID: <CAMuHMdW5VgFG3NrYpPmr0VY-oG4AV3itT7mk6jbpT2w3BH0vOw@mail.gmail.com>
Subject: Re: [PATCH] spi: sifive: check return value for platform_get_resource()
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Baolin Wang <baolin.wang@linaro.org>,
        Aurabindo Jayamohanan <mail@aurabindo.in>,
        Mark Brown <broonie@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Paul,

On Tue, Sep 17, 2019 at 2:16 PM Paul Walmsley <paul.walmsley@sifive.com> wrote:
> On Tue, 17 Sep 2019, Baolin Wang wrote:
> > On Tue, 17 Sep 2019 at 17:12, Aurabindo Jayamohanan <mail@aurabindo.in> wrote:
> > > platform_get_resource() may return NULL. If it is so, return -ENXIO
> > >
> > > Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
> > > ---
> > >  drivers/spi/spi-sifive.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
> > > index 93ec2c6cdbfd..67485067a694 100644
> > > --- a/drivers/spi/spi-sifive.c
> > > +++ b/drivers/spi/spi-sifive.c
> > > @@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device *pdev)
> > >         platform_set_drvdata(pdev, master);
> > >
> > >         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       if (!res) {
> > > +               dev_err(&pdev->dev, "no IOMEM resource found\n");
> > > +               ret = -ENXIO;
> > > +               goto put_master;
> > > +       }
> >
> > Seems unnecessary, the devm_ioremap_resource() already validated if
> > the resource is available.
>
> Just doublechecked lib/devres.c and I agree with you.
>
> Aurobindo, is this a patch for a real problem that you've encountered?

Probably not.

The sequence can be replaced by a single call to
devm_platform_ioremap_resource(), which BTW also doesn't check the
intermediate result, as that's unneeded.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
