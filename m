Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89D710B0B0
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfK0N4f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:56:35 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46884 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfK0N4e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 08:56:34 -0500
Received: by mail-vs1-f67.google.com with SMTP id i13so10393818vso.13
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 05:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z9fftCSYc5ofDnoqK20/VtKJgAPcKl2ujIOcF/S6914=;
        b=L1ITjBOtbYPyX4bYqNRMPejtoJ1s18qQNhwlgTGoKgBjgjJvrImkddXl2Ybz0Z0Sw7
         KKuViCH1qAH+Cy3qL1q0ifim1rQh39PhsYcPgP9AzmBVVez7nSardtC7Ob5uaFMWzycD
         0YQpdcs/xSPaETwgzspI30wNfh+Gc8l4YoT1pW84i+NCp2q2ViOft7VQ0xpyR4CiF8F0
         mUz2+iDne4e9bmtBRzOCatzcmBp2Nt7paNCW/6l+/fqBHty2RavIgkUmT6PKxeo6XqFr
         uBecFfkp+1QLhbxjTAkW0xLi8hR574Cr2dG7TLLsk1Ti7oNTY6Mn3l7gIbj+UKFHvYAy
         cpJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z9fftCSYc5ofDnoqK20/VtKJgAPcKl2ujIOcF/S6914=;
        b=oVSG7G0algh/2l3Yv2OO1l+j8/sT+mYowPSXGfB6wts8QrWkobCp2en64JuqI6yO+K
         Jbxmu4on7lrfcI2WdA+VjZJ2yejEY6/RfxOg+8/0/sAyOYMKHNzzuglarD39e8A0XII+
         7MQZn1Ma2DAxmawaaCW2sS97xJ5Vn3TjkZH2Ne6eS9whcf5FpSV6sUJnhkhDE5X3ioP7
         j9yef06mJJP9p2drYY3DwjSoi/lGRFn1Cp3HAdi64eJSw8sI8iEAeHKhMKCODeNA/MIV
         D/N+nLh6yPjSVulVsPeb2vgmOfi7JUO34nJ0EkjwkhCYZ6blITAuapAn4iuFYIBSI4vU
         /7wA==
X-Gm-Message-State: APjAAAUC18FArpHT57Rgadeg57HhoZDqsRX6Cnxwkwe5CUflqXfDHgWO
        6IhcIugGYuuK8ZcszAoZ8FnKx/GL29f4wWkFGr+dEg==
X-Google-Smtp-Source: APXvYqxGad2QoQOM5rAGChyibn9jgxf2zm1Q9YO8riiD/EDeK5oC6QjH2wftPylo8R+RrIcwmNMVuSg+0ryA8QkT+5o=
X-Received: by 2002:a67:8703:: with SMTP id j3mr4160640vsd.99.1574862993814;
 Wed, 27 Nov 2019 05:56:33 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr> <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr> <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr> <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
 <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr> <CACRpkda-wjRm7UYsFTX_xFfNPT29U1PTMyuU4AP=WShiC_vV9g@mail.gmail.com>
 <b2925217-9cbd-2f4e-c92f-9e1c92824193@c-s.fr> <CACRpkdaKg45uHMZ9mz6OGkAUqYX7GzhTrjrAc1feVhn68ZXrqg@mail.gmail.com>
 <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr> <CACRpkdb15n4DpxAGEw+Av89XZDxi7Amh1XEyJEzWBd4tet7C2Q@mail.gmail.com>
 <8b50ce56-0600-373d-178c-92aa780e5376@c-s.fr> <CACRpkdZRWojQAgHtBaNWdjKqv8aX3P-KjatgoG+DLCcYeJ7ztg@mail.gmail.com>
 <99f48a7e-e4f4-2a77-657c-452d7a656ec5@c-s.fr>
In-Reply-To: <99f48a7e-e4f4-2a77-657c-452d7a656ec5@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 14:56:22 +0100
Message-ID: <CACRpkdat-qtxCn=e1sqPMFF7urue0OoJJcixUwL1=nAT-F+H3Q@mail.gmail.com>
Subject: Re: Boot failure with 5.4-rc5, bisected to 0f0581b24bd0 ("spi: fsl:
 Convert to use CS GPIO descriptors")
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 27, 2019 at 2:54 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 27/11/2019 =C3=A0 14:52, Linus Walleij a =C3=A9crit :
> > On Wed, Nov 27, 2019 at 2:45 PM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >> Le 27/11/2019 =C3=A0 14:00, Linus Walleij a =C3=A9crit :
> >
> >>> Try to remove the "spi-cs-high" bool flag from your nodes,
> >>> because it seems like the old code was ignoring them.
> >>>
> >>> Does that solve the problem?
> >>
> >> Yes it does. Many thanks. I let you manage the packaging of fixes.
> >
> > OK I will send a final batch of 3 patches fixing this.
> >
> > Do you have these old device trees deployed so that we
> > also need to make sure that old device trees that have this
> > ambigous syntax will force precendence for the flag on the
> > GPIO line if both are specified for the "fsl,spi" instances?
> >
>
> No, we deliver device trees together with Linux kernel (embedded in an
> Uboot ITS/ITB image) so no worry on old device trees.

OK thanks!

I sent three patches, can you apply them on a clean tree
and confirm it solves the problem (fingers crossed...)

Thanks a lot for helping me fix this!

Yours,
Linus Walleij
