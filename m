Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A82AF429
	for <lists+linux-spi@lfdr.de>; Wed, 11 Nov 2020 15:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgKKOyX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Nov 2020 09:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbgKKOyU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Nov 2020 09:54:20 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCFFC0613D1;
        Wed, 11 Nov 2020 06:54:20 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id 30so2354166otx.9;
        Wed, 11 Nov 2020 06:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s26bSvuqGwtlpmnW3ixIL61JgOIY8AH9b81Xo/VdBLE=;
        b=AIirCFf6VcRbiUqAeiEp7cJjZZh0oS2CVANPvn31qwaSkpP3vMouje7Jjk00DAl7Gx
         BxRcFBPe8ZcuFwF80aQO51g6vxOViLbnSxqccBMJvGjyp01wv/zuMOqMUcWI0Bq7Imdo
         x/p+XIn+pQpIACVojazCi1xXCVN0NNXlyPSn0soWQMQquywtfRJSwinH6CD3S2rSTQPV
         5vIcamJTn9/bESmrZqwoxl12eQPbig6ZL6PC+0QdrPg5aZdaJVnb90BFEMEC7FiVHsSl
         WPwYLgNSZi53YI7zJdMSYu0G7/pLDTXzaBlf8j1sb/0TuV8y7UgNGv5yp4SPDpY7b+g/
         9rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s26bSvuqGwtlpmnW3ixIL61JgOIY8AH9b81Xo/VdBLE=;
        b=IwytsLwJDXs0TQZixqjOgZ2AJw7H2TgvCpsLb1flExTKaLUSHYoJVQPWgJ6yPgpxeF
         Zsii9I0M3jzu35heBTmdUWIqBesCnNYoeM3LmEBNri747XmtkoQejedhe6/SaIFCRChq
         87KKn8XN0uYzKXRK9hMk8oWi9Qf4yWIxoOdp9MY2si9U+MWNy/iIxwrn/vWYYigrXVer
         ajgLC9+wFzi0PfrU4dz2bDOD05VhDJTvVGDHd8pGFRbLznvor79AysrPB4WEfmNMQOF1
         hfG7Icz+YkpJorjprkHDeJTVr9ctTblWWheCzDFMYAh0BAv3tKzy9ciloBZCe9EX2v7t
         dEsA==
X-Gm-Message-State: AOAM531ZDv6ZEZa811K418j9HYiZ7qrNO67HatPFa2wZv2K7zEG0pnss
        F/zeIj3HyVEXh9/tq6CgvYenxultYCl3ejTEL7M=
X-Google-Smtp-Source: ABdhPJzKUtpV+ovbTBFcdsFufUkf+Vj3JoBmKzpdfDsurM1/47xOcoCmDKG5UZM5GI7XShYRhktP+FIPWagRiJoz/ps=
X-Received: by 2002:a9d:6f91:: with SMTP id h17mr2669643otq.224.1605106459501;
 Wed, 11 Nov 2020 06:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20201111141529.98147-1-alexandru.ardelean@analog.com> <CAHp75VcKmiBM1WQTtmJ7L3kpB1xdXX=xOtM2zCAtaszXBcHokg@mail.gmail.com>
In-Reply-To: <CAHp75VcKmiBM1WQTtmJ7L3kpB1xdXX=xOtM2zCAtaszXBcHokg@mail.gmail.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 11 Nov 2020 16:54:08 +0200
Message-ID: <CA+U=DsrNLR=5LyoCjdtyD9Y=KddZVyE8c+cLr2Xzef68iyeSyA@mail.gmail.com>
Subject: Re: [PATCH] spi: Add SPI_NO_TX/RX support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 11, 2020 at 4:45 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Nov 11, 2020 at 4:13 PM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
> > From: Dragos Bogdan <dragos.bogdan@analog.com>
> >
> > Transmit/receive only is a valid SPI mode. For example, the MOSI/TX lin=
e
> > might be missing from an ADC while for a DAC the MISO/RX line may be
> > optional. This patch adds these two new modes: SPI_NO_TX and
> > SPI_NO_RX. This way, the drivers will be able to identify if any of
> > these two lines is missing and to adjust the transfers accordingly.
>
> Shouldn't this update a binding documentation?

oh,
good catch

>
> ...
>
> > -       /* check mode to prevent that DUAL and QUAD set at the same tim=
e
> > +       /* check mode to prevent that any two of DUAL, QUAD and NO_MOSI=
/MISO
> > +        * are set at the same time
> >          */
>
> /*
>  * Perhaps switch to proper multi-line comment style
>  * at the same time?
>  */

=C2=AF\_(=E3=83=84)_/=C2=AF

Not sure what SPI prefers as multi-line comment style,
But ok.

>
> ...
>
> >  #define        SPI_TX_OCTAL    0x2000                  /* transmit wit=
h 8 wires */
> >  #define        SPI_RX_OCTAL    0x4000                  /* receive with=
 8 wires */
> >  #define        SPI_3WIRE_HIZ   0x8000                  /* high impedan=
ce turnaround */
> > +#define        SPI_NO_TX       0x10000                 /* no transmit =
wire */
> > +#define        SPI_NO_RX       0x20000                 /* no receive w=
ire */
>
> Perhaps switch to use BIT() instead at some point (as a prerequisite
> patch, for example)

I'll leave this up to the maintainer preference.
Maybe I'll do it as a second patch here, so that I can be dropped.

>
> --
> With Best Regards,
> Andy Shevchenko
