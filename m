Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBB310AE3F
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 11:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfK0KzZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 05:55:25 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41060 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbfK0KzZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 05:55:25 -0500
Received: by mail-lf1-f65.google.com with SMTP id m30so14922123lfp.8
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 02:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jW/pZi/y7a7Ae7GsA2SiR3pv/ZpPmeNnnKBaKGvs4nQ=;
        b=np33cXFuYCi7Ag+hHFaFtO8V12ydTEIpVr7AwOxdpDamhr66FZEHogbPxaY2lMHkN+
         xRz1LgFIspcU1kM1iolo0TADGEVZN+2yg4XMCQ+m2Dq/AGhcb2vmvotCkdg0J10h25Wc
         H45HfRSnu/tA3baBINT5U9E8f43ROd8AbWaWecPGDprWFF5EjfzklVi2qA/md/NVlsFd
         Nvij3sCckbD6jm9STKjKPPOGwrnScXLbFqdP1OX0j2lbh8T3dfRNrB7RpctqDyn6Ri3R
         Qe22NKeKIZkXbR0WIBPDf8/o8JuGTmxTi59lwk81z9MYGp69Zpg4boqIZTQvSIImmCv8
         ReTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jW/pZi/y7a7Ae7GsA2SiR3pv/ZpPmeNnnKBaKGvs4nQ=;
        b=SuFXs7UU23yvhdb6ekB9/HU+5MBrnT1pXdrnN7MzDRorBKgpzq8KAbveRDV/zFY3x6
         DHJRz2zYpGCyeIL18fzyCTP5/3LPbxmWFHWrIvhk/d2RSHqod294aoGibiHkh/98CN5Y
         EQatJegcTxBVG7HX8cxFXJMuqPNdU5qxbHZv71XFgDO/h1mMFc/3s2E8EjnyiFinn4ww
         GazZDIVz7LM03yZfJsCPhJq7j9YQoNfxP9PMmwDfpaCfgfndMbssgkLrRT0cvV8ei3ck
         +VlYxjGfxzBt3xWcD1tOlCSizzK8vm823s+6vowSDcI8Jy68bU0FwgAT+A2zqcGx5oop
         +eCw==
X-Gm-Message-State: APjAAAXcRTWy97jlc5IfkyQ3yBx0cBO/9M3VAO9DgnQ5mwo0uRP35Kwk
        4DNr/N9w2HBqj9YxxNvpykipeGLJ9g1Uz+e/dRChB9gNcwBrWw==
X-Google-Smtp-Source: APXvYqxSDzlsMjH492pTspJWX8yOEHID6Rg4E3k5Lzb9nw7VmCsZKMc81+9VysxjWAsiWF2Zgvf+PB4pP4qhtUsZ9NQ=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr27663867lfi.93.1574852123515;
 Wed, 27 Nov 2019 02:55:23 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr> <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr> <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr> <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
 <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr> <CACRpkda-wjRm7UYsFTX_xFfNPT29U1PTMyuU4AP=WShiC_vV9g@mail.gmail.com>
 <b2925217-9cbd-2f4e-c92f-9e1c92824193@c-s.fr>
In-Reply-To: <b2925217-9cbd-2f4e-c92f-9e1c92824193@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 11:55:11 +0100
Message-ID: <CACRpkdaKg45uHMZ9mz6OGkAUqYX7GzhTrjrAc1feVhn68ZXrqg@mail.gmail.com>
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

On Wed, Nov 27, 2019 at 11:39 AM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 27/11/2019 =C3=A0 11:02, Linus Walleij a =C3=A9crit :
> > On Wed, Nov 27, 2019 at 10:34 AM Christophe Leroy
> > <christophe.leroy@c-s.fr> wrote:
> >
> >> In the meantime, I have tried changing "gpios" by "cs-gpios" in the
> >> device tree, and I get the following warning:
> > (...)
> >> [    3.156654] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-fsl-spi.c:716
> >> fsl_spi_cs_control+0x64/0x7c
> >
> > That should be this one:
> >
> > if (WARN_ON_ONCE(!pinfo->immr_spi_cs))
> >     return;
> >
> > That happens when spi->cs_gpiod is NULL so the
> > chipselect isn't found and assigned, and the code
> > goes on to check the native CS and find that this isn't
> > available either and issues the warning.
>
> That's in spi_add_device(), it is spi->cs_gpio and not spi->cs_gpiod
> which is assigned, so spi->cs_gpiod remains NULL.

That's weird, because when ->use_gpio_descriptors is set
(as for this driver) the core only attempts to look up
spi->cs_gpiods and not spi->cs_gpios, and consequently
can only assign spi->cd_gpiod and not spi->cs_gpio:

if (ctlr->use_gpio_descriptors) {
    status =3D spi_get_gpio_descs(ctlr);
(...)
} else {
(....)
    status =3D of_spi_get_gpio_numbers(ctlr);
}
(...)
/* Descriptors take precedence */
if (ctlr->cs_gpiods)
    spi->cs_gpiod =3D ctlr->cs_gpiods[spi->chip_select];
else if (ctlr->cs_gpios)
    spi->cs_gpio =3D ctlr->cs_gpios[spi->chip_select];

So I'm a bit confused...

Yours,
Linus Walleij
