Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90D0C11C859
	for <lists+linux-spi@lfdr.de>; Thu, 12 Dec 2019 09:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbfLLIkn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Thu, 12 Dec 2019 03:40:43 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:32787 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLLIkm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Dec 2019 03:40:42 -0500
Received: by mail-ot1-f68.google.com with SMTP id d17so1005920otc.0;
        Thu, 12 Dec 2019 00:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AQWN2ilbL/pV9oSuedTqVkyb3PS6uRdUps6Bbw03pBk=;
        b=HUZ4/wTMw472O2T+Q/MJ7GOQqRE96HOiG64HeAVowLjh9DdoTSz8DwgAoMgbt+Hx5f
         a/oiQYcHi7sVk/1vHujEYMm8fN8aLc0ECWZqfcCsGrP30fmT1SCbH+Rsznsdh+xuKT9k
         zQWZLdcimErGaFEdfKT5w32X7kP2fTWTiAU74f3t4rEyiTgvTy8evngNi46UFRHdYwnl
         oLYch8m1mGu70x5JGfAavh2PqsFiZ4OovMx28321dvR0WW6Ep9EfYhh4Ho13Rw0ndm++
         Au+87INy5bArQc2fI4W6Ar6BuQp5KcifuycxgwtzKIv6/SP2/ucJ3rLVsnCt2/AyiNsd
         fCXg==
X-Gm-Message-State: APjAAAU0ixez0zOsUAgXpAY1TZenFIaZ429kYZuGQaS3nFIY2sLFirCk
        yGdxJy3dosdoF2qY60UmXeg0p3mok8mhHLEVRJo=
X-Google-Smtp-Source: APXvYqysUxu8Fvc2fIhN06OFqRY0qpSAEhlRgYRJ7iOByHsa4CbdkD7ZfCNq5icsxrmSiZ5dHtFTX6Xxp+lE34VAdgE=
X-Received: by 2002:a9d:dc1:: with SMTP id 59mr7036813ots.250.1576140041766;
 Thu, 12 Dec 2019 00:40:41 -0800 (PST)
MIME-Version: 1.0
References: <20191212033952.5967-1-afaerber@suse.de> <20191212033952.5967-5-afaerber@suse.de>
In-Reply-To: <20191212033952.5967-5-afaerber@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Dec 2019 09:40:20 +0100
Message-ID: <CAMuHMdWdxJ9AaWhyCW-u8fCpXSDCPd-D6Dx129SF5nRssZsK=g@mail.gmail.com>
Subject: Re: [RFC 04/25] spi: gpio: Implement LSB First bitbang support
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Andreas,

On Thu, Dec 12, 2019 at 4:41 AM Andreas Färber <afaerber@suse.de> wrote:
> Add support for slave DT property spi-lsb-first, i.e., SPI_LSB_FIRST mode.
>
> Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE versions.
> Make checkpatch.pl happy by changing "unsigned" to "unsigned int".
>
> Conditionally call them from all the spi-gpio txrx_word callbacks.
>
> Signed-off-by: Andreas Färber <afaerber@suse.de>

Thanks for your patch!

> --- a/drivers/spi/spi-gpio.c
> +++ b/drivers/spi/spi-gpio.c
> @@ -135,25 +135,37 @@ static inline int getmiso(const struct spi_device *spi)
>  static u32 spi_gpio_txrx_word_mode0(struct spi_device *spi,
>                 unsigned nsecs, u32 word, u8 bits, unsigned flags)
>  {
> -       return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
> +       if (unlikely(spi->mode & SPI_LSB_FIRST))
> +               return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
> +       else
> +               return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
>  }

Duplicating all functions sounds a bit wasteful to me.

What about reverting the word first, and calling the normal functions?

    if (unlikely(spi->mode & SPI_LSB_FIRST)) {
            if (bits <= 8)
                    word = bitrev8(word) >> (bits - 8);
            else if (bits <= 16)
                    word = bitrev16(word) >> (bits - 16);
            else
                    word = bitrev32(word) >> (bits - 32);
    }
    return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
