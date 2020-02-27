Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8D1C171BD5
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 15:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgB0OGL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 09:06:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39587 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387893AbgB0OGI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 09:06:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id r16so1724712oie.6;
        Thu, 27 Feb 2020 06:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cx/vMLxUXCQqiHIlhyWc7p+UDnALXohVmSNQTIY/iJY=;
        b=Mm3RYCLDz6GgUhEWVQU9dxP17ZmFORQGCbF3jRifl9RAt8SgNrf+Bp83gGpkdIh4zD
         Rp5OPh8xo8f7PdY3PEkFUwhNRVJqcHCS6v8O2+ccFuPJwJdnUpkd4VuIt1g1PInGoGCz
         VA5hx+uDbfLflBf08nMNDm9B6wdGkrUPTNGQD31kxYpuZ9jt0W0HVbGAILjcqabxOZMm
         ywCmfESl8Kcfr8EKRITfcbNF/2SOMlK2m8ztaxMEd5n9ylYpZl7qKtdgJA9LGrNg7cRg
         DGKgeYVeSmqD0K4w9aXu2FXJ+dyQBHDND6xPoO5qqKYX4Pj/AaxrF9qinlirOyiqAzJj
         3BRw==
X-Gm-Message-State: APjAAAVu1cYQ2VUo6DkGRl2UpcuZJ5krRHj6rPP0tPR8oYdmScfXEEXf
        bdrsanI8SHCtQsrdUzo6UDidTnwNGCfKze17XSk0vagM
X-Google-Smtp-Source: APXvYqz8JJDA84sFbKo0lDkg66n2CqBUepi1tliPUtWWxkdoHJj+Fp4CCwtrOh8AANmK7Kf7LUrU5+OXJZ7SQjxnbgI=
X-Received: by 2002:aca:ed04:: with SMTP id l4mr1210535oih.54.1582812367561;
 Thu, 27 Feb 2020 06:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20200227130323.15327-1-geert+renesas@glider.be>
 <20200227130937.qvrjyxcwim7rfum7@gilmour.lan> <CAMuHMdUVW_51dqMK=ziz_JVT3LuXX7vOF3-Ei-aHiiBuSepGpg@mail.gmail.com>
 <20200227135109.l2oal55nwhm5un2c@gilmour.lan>
In-Reply-To: <20200227135109.l2oal55nwhm5un2c@gilmour.lan>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 15:05:56 +0100
Message-ID: <CAMuHMdWYF9RrLdkuK_PxfVqocUMHVKPpjnyc4FR+N69A_htdyQ@mail.gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: spi-controller: Fix #address-cells for
 slave mode
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Maxime,

On Thu, Feb 27, 2020 at 2:51 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Thu, Feb 27, 2020 at 02:19:08PM +0100, Geert Uytterhoeven wrote:
> > On Thu, Feb 27, 2020 at 2:09 PM Maxime Ripard <maxime@cerno.tech> wrote:
> > > On Thu, Feb 27, 2020 at 02:03:23PM +0100, Geert Uytterhoeven wrote:
> > > > Currently, the DT bindings for an SPI controller specify that
> > > > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > > > controller in master mode only.  When running in SPI slave mode,
> > > > "#address-cells" should be zero.
> > > >
> > > > Fix this making the value of "#address-cells" dependent on the presence
> > > > of "spi-slave".
> > > >
> > > > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > > > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > > > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> >
> > > > @@ -52,6 +53,18 @@ properties:
> > > >      description:
> > > >        The SPI controller acts as a slave, instead of a master.
> > > >
> > > > +if:
> > > > +  required:
> > > > +    [ spi-slave ]
> > >
> > > Nit: Usually, that notation is when you would do it on the same line,
> > > if you want to go to a new line, it would make more sense to use -
> >
> > Sorry, being a poor yaml-by-example programmer, I don't understand what
> > you mean.  Which part do you refer to by "that notation"?
>
> I meant that usually the [] notation is used over a single line.
>
> If you want to have a list over multiple lines, usually you would have
>
> required:
>   - spi-slave

IC. So I can also write:

    if:
      required: [ spi-slave ]
    else:
      ...

which is even shorter ;-)

Both seem to work fine.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
