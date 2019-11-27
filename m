Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7AE810AFDD
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2019 14:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfK0NAl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 27 Nov 2019 08:00:41 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:44694 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfK0NAl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 27 Nov 2019 08:00:41 -0500
Received: by mail-vs1-f67.google.com with SMTP id p6so9923618vsj.11
        for <linux-spi@vger.kernel.org>; Wed, 27 Nov 2019 05:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7zaFgifFVX7S1p9ptuX5oUt4RCSQmtxWAxQtUAthi/4=;
        b=GS59w7hnFk2mOzzN9HxH/GU+Ptf1GQPWGWBwugtwy+PWVVuOZyKh4UdSkLLZaWsOI1
         3bbZolcqvKJzykbYfvK8mq9r3fIrNA/eTvaGQkvK+tlckbQNY1/7nJMz1o1pozFNdOfA
         hgym6Tnw4M56vBDfsep8sKlr2/AKOYt5TXKHb+oE1O/VhX0aMdGcJywpBl+1Cjk3rAmW
         w25iJ82aMc6ioE9vfyzHT5pBxIC905GXHnXuEOfobgXQ3B1jWEZUxyiROn+0SlCSm3wd
         utHzzoFBlmrl6iy7s4NvzVjc+zvsR0KphHh6lNkO0rDxT8nVANpVVW5S2WTbo6hcqBvv
         AfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7zaFgifFVX7S1p9ptuX5oUt4RCSQmtxWAxQtUAthi/4=;
        b=qSppYLYEP2nomh3bnKutGxhY0dImCTBjfR2vJYRhJaGcolZRX4cmYsx4L0OyM7w0Cq
         y+xxxuL3gupJmHaeT3WKXBpVeHBFehhqcekpXg0f+NpIG564fEI/G2IYvV42/PXotlXQ
         zM1QUfvwvVpUg8hAk7ahk3uPlmsQpavzqtx9d6aTxq81VjeavLzNkCaA4r28F5YSSVNF
         6yb5YFzxkvZ8VxxegBFxUk5P2LZF1dJJZI9/xsTxOMjMgGkPg/CsSvxT7giDqzKC+gSJ
         8V9CvA+hryKCNrO5a+1vwpGcXP6KyqJ/G8X5FD+BmqtoJag+A615uhM9dR2FXq8W6L8Y
         56qg==
X-Gm-Message-State: APjAAAXrvMIQeIpzO7fsr1YGXX+CfPP9Stv8N58uTlcnVqeYalssbM2+
        yFyBvyzwzqYHdo1jfeQFAjR1LMpcQNFKdoEu6fNOJA==
X-Google-Smtp-Source: APXvYqw8L6In4ebYBmmplUMmBFUIjezsLzdjgYqLywsl9uuI2YR2sbcgZBVtjmPeaK6RBvKl/P0ZSltJDRbTfvykqew=
X-Received: by 2002:a67:f84d:: with SMTP id b13mr25761464vsp.57.1574859638222;
 Wed, 27 Nov 2019 05:00:38 -0800 (PST)
MIME-Version: 1.0
References: <e9981d69-2a33-fec9-7d12-15fcb948364d@c-s.fr> <CACRpkdYLEibwyK_BGO3gsJ_aQFWZNJCky-GezHVmHfRSzD2zBg@mail.gmail.com>
 <1efb797c-e3c1-25a4-0e81-78b5bbadb355@c-s.fr> <CACRpkdYUBj+45Jr94kdERKJogVoL96JH6i85o_bVUtjmkTt19g@mail.gmail.com>
 <3c79a8b9-65e4-bfc9-d718-b8530fe1e672@c-s.fr> <b06679da-0332-2322-13f8-07307f611542@c-s.fr>
 <CACRpkdbOzM3X2_BMnf5eSqCt_UsnXo4eXD2fUbTLk6=Uo3gB2g@mail.gmail.com>
 <582b5ccf-8993-6345-94d1-3c2fc94e4d4f@c-s.fr> <CACRpkdawu5DcCA5rnRbOe+meBPtxctL7HuWciqboOEkCHZKA7A@mail.gmail.com>
 <e6a39aba-a41b-d781-966a-647977216b87@c-s.fr> <CACRpkda-wjRm7UYsFTX_xFfNPT29U1PTMyuU4AP=WShiC_vV9g@mail.gmail.com>
 <b2925217-9cbd-2f4e-c92f-9e1c92824193@c-s.fr> <CACRpkdaKg45uHMZ9mz6OGkAUqYX7GzhTrjrAc1feVhn68ZXrqg@mail.gmail.com>
 <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr>
In-Reply-To: <748eb503-b692-6d30-bc5e-94539a939b06@c-s.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 27 Nov 2019 14:00:27 +0100
Message-ID: <CACRpkdb15n4DpxAGEw+Av89XZDxi7Amh1XEyJEzWBd4tet7C2Q@mail.gmail.com>
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

On Wed, Nov 27, 2019 at 1:05 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
> Le 27/11/2019 =C3=A0 11:55, Linus Walleij a =C3=A9crit :

> > That's weird, because when ->use_gpio_descriptors is set
> > (as for this driver) the core only attempts to look up
> > spi->cs_gpiods and not spi->cs_gpios, and consequently
> > can only assign spi->cd_gpiod and not spi->cs_gpio:
>
> That's it. ->use_gpio_descriptors isn't set for the FSL driver:

Oh, my coding mistake. :(

And an especially stupid one too. OK I make a separate patch
in the series to fix that too.

> I have now added it, together with the DTS cs-gpios name change (without
> your counting patch with crashes), and I get something which is almost
> working: I get temperature back into sensors, but temperature is 0=C2=B0C=
 !!!

OK we almost fixed it I think. It is probably better to test with
all three patches (will send out soon) that rely on the gpiolib
to do appropriate counting of the gpiod's and so on.

> Looking into dmesg, I see:
>
> [    3.153521] lm74@1 GPIO handle specifies active low - ignored
> [    3.178093] lm74@5 GPIO handle specifies active low - ignored
>
> Any link with the problem ?

This is because your GPIO handles look like this:

        gpios =3D <&CPM1_PIO_C 4 1        /* SICOFI 1 */
                 &CPM1_PIO_B 23 1       /* TEMP MCR */
                 &CPM1_PIO_C 8 1        /* SICOFI 2 */
                 &CPM1_PIO_C 12 1       /* EEPROM MIAE */
                 &CPM1_PIO_D 6 1        /* SICOFI 3 */
                 &CPM1_PIO_B 14 1       /* TEMP MPC885 */
                 &CPM1_PIO_B 21 1       /* EEPROM CMPC885 */
                 &FAV_CS_SPI 0 1        /* FAV SPI */
                 &FAV_CS_SPI 2 1>;      /* FAV POSTE FPGA */

That "1" at the end of each GPIO phandle means "active low"
as can be seen in <dt-bindings/gpio/gpio.h>

/* Bit 0 express polarity */
#define GPIO_ACTIVE_HIGH 0
#define GPIO_ACTIVE_LOW 1

But your child nodes look like this:

       sicofi@0 {
                compatible =3D "infineon,sicofi";
                spi-max-frequency =3D <1000000>;
                reg =3D <0>;
                spi-cs-high;
                spi-cpha;
        };

        lm74@1 {
                compatible =3D "ns,lm74";
                spi-max-frequency =3D <1000000>;
                reg =3D <1>;
                spi-cs-high;
        };

And the spi-cs-high in the child node takes precedence.

That's a bit ambigous so that is what the warning is about.

Try to remove the "spi-cs-high" bool flag from your nodes,
because it seems like the old code was ignoring them.

Does that solve the problem?

Yours,
Linus Walleij
