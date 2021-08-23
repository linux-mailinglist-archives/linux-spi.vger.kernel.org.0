Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229DD3F42E5
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 03:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234383AbhHWBSB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 21:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbhHWBR7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 21:17:59 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C052C061575
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:17:17 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a25so6768156ejv.6
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z58f0xxvO1Pfo9/llvNA4Dw8WM6p4HqmKCC8GfOFT/M=;
        b=m57Ig7lGhtDyazhBZdX4GJ4aBOQYyQruJ4RB8qUQ5CnSoFOxCsJy5mPDclspcjCyfN
         8OUXaefFyYn6gPrs19RmW4lpdGuAlvCS6LclgnKZbrfAh9fp7QY6TzBJ2j45VGjJnKy+
         kMo0HSjXf+HkqAFzG0SRozVLJK2b0+opaG8d9fR1+tE+XadcunKRD//rdOxCHBahL9Dn
         kH8KHoGJ7PdO2/VSCNyvvFQ6nGBo+ptzsPU9kO5sVR8/p8sKjlKtEsVSdV20L4Z7wBTI
         Rhm2yqsS4yV/XfFNbWPXBhKudy1azZui+cjfCocFjXhALRCuwlsSodv7S15G8r5VSrSL
         jQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z58f0xxvO1Pfo9/llvNA4Dw8WM6p4HqmKCC8GfOFT/M=;
        b=XVdgioIQEzOCzxqhGASHQuomcLNFIApWINmLaUgh4ebidCJIFy2sGiN88lRPxdB/AF
         WiO1wYrCXvY3JM1VbvASPUWmnettaWroIqNGRCwtXhn4ByZ9Uf90XmY4XdIdtqPRfA9g
         M8b2PWAQkjKr0O3nCnYO7CsxJnQVGHreWPhTzqngyI2faQEJefMN67dx5crcg/QFC7mi
         1CNmxkgHhdBMWb/L2+5lvv36N3hJDGshgupekpqhmAgbxOKgwBQU6q7eJXyFWxYbVqXS
         vTceoEzUsgdIMHlwzPZ53OYCLtRuG6ldsMEyVlnbv2tenEQT+Cj2J22VMEGs/wtO/X0B
         Dt/Q==
X-Gm-Message-State: AOAM531vmzn20G6+6CwN6mNlcSRQkMpYM+hqDHSdO485AZ3fUwkr6NQD
        KIQP/WkpCO9xX3UIzlqmYX3BWuUAcrve4aXhvm/vnA==
X-Google-Smtp-Source: ABdhPJwGXQDHCIGSv1vSbsDcO+GKBOiAyoIJAys43KI2ddwJjURCNVz7GDU5oAD5XHCyg8K863gI3BJDeu1ARrmXiOA=
X-Received: by 2002:a17:906:2305:: with SMTP id l5mr33432324eja.72.1629681435742;
 Sun, 22 Aug 2021 18:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-4-brad@pensando.io>
 <20210304064433.vqyqg3byedvc4quz@mobilestation>
In-Reply-To: <20210304064433.vqyqg3byedvc4quz@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:17:05 -0700
Message-ID: <CAK9rFnzwtxhg9DBW7=s9FaOwWNCstfRW5T_MjQiM51GxiM6ZyA@mail.gmail.com>
Subject: Re: [PATCH 3/8] spi: dw: Add support for Pensando Elba SoC SPI
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Sergey,

Thanks again for the reviews.  I've been able to work on this recently
and test the changes using 5.10.28 on a production server.  I'm going
back to the beginning to reply to each comment and work towards
closure of open issues before preparing patchset v3 which will need to
be re-done against the latest linux-next.

On Wed, Mar 3, 2021 at 10:44 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hello Brad.
> Thanks for the patch. See my comments below.
>
> On Wed, Mar 03, 2021 at 07:41:36PM -0800, Brad Larson wrote:
> > The Pensando Elba SoC uses a GPIO based chip select
> > for two DW SPI busses with each bus having two
> > chip selects.
>
> I see a contradiction here. Normally GPIO-based chip-select is a
> property of a platform, but not a SoC/CPU/MCU/etc. Most of the time
> SoC SPI interfaces still get to have native CS pins, while at some
> platform configurations (like in case of DW APB SPI, which doesn't
> provide a way to directly toggle its native CSs) it's easier or even
> safer to use GPIOs as CS signals. Of course theoretically a SoC could
> be synthesized so it doesn't have native CS output pins, but only some
> virtual internal CS flags, but I've never seen such. Anyway according
> to the custom CS method below it's not your case because you still
> provide support for SPI-devices handled by native CS (else branch in
> the if (spi->cs_gpiod) {} else {} statement).

The native DW CS is not supported, that code is removed which caused
the confusion.  The existing dw_spi_set_cs() works fine with the
updated version of this function being

/*
 * Using a GPIO-based chip-select, the DW SPI controller still needs
 * its own CS bit selected to start the serial engine.  On Elba the
 * specific CS doesn't matter, so use CS0.
 */
static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
{
        spi->chip_select = 0;
        dw_spi_set_cs(spi, enable);
}

which is much better than the original version shown below

> > +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> > +{
> > +     struct dw_spi *dws = spi_master_get_devdata(spi->master);
> > +
> > +     if (!enable) {
> > +             if (spi->cs_gpiod) {
> > +                     /*
> > +                      * Using a GPIO-based chip-select, the DW SPI
> > +                      * controller still needs its own CS bit selected
> > +                      * to start the serial engine.  On Elba the specific
> > +                      * CS doesn't matter, so use CS0.
> > +                      */
> > +                     dw_writel(dws, DW_SPI_SER, BIT(0));
> > +             } else {
> > +                     /*
> > +                      * Using the intrinsic DW chip-select; set the
> > +                      * appropriate CS.
> > +                      */
> > +                     dw_writel(dws, DW_SPI_SER, BIT(spi->chip_select));
> > +             }
> > -     } else
>   +     } else {
> > +             dw_writel(dws, DW_SPI_SER, 0);
>   +     } /* See [1] */
> > +}
>
> The custom CS-method above doesn't look much different from the
> dw_spi_set_cs() method defined in the spi-dw-core.o driver, except
> having at least two problems:
> 1) It assumes that "enable" argument means the CS-enabling flag, while
> in fact it's the CS-level which depending on the SPI_CS_HIGH flag
> set/cleared will be 1/0 respectively if CS is supposed to be enabled.
> That aspect has already been fixed in the dw_spi_set_cs() method.
> 2) The method enables CS[0] if GPIO-CS is used for a particular SPI
> device. That will cause problems for a GPIO/native CS intermixed case
> of having for instance one SPI-device connected to native CS[0] and
> another one - to a GPIO. So trying to communicate with the second SPI
> device you'll end up having the native CS[0] activated too thus
> having an SPI transfer sent to two SPI-device at the same time.
> Of course that's not what you'd want.
>
> Anyway I don't really see why you even need a custom CS method here. A
> generic method dw_spi_set_cs() shall work for your SPI interface.
> If I am wrong, please explain why. Did you try the generic CS method
> on your platform?
>
> [1] Placing Braces and Spaces. Chapter 3). Documentation/process/coding-style.rst

Yes, exactly.  The generic method dw_spi_set_cs() works ok and
correctly handles active high/low.

> > +static int dw_spi_elba_init(struct platform_device *pdev,
> > +                         struct dw_spi_mmio *dwsmmio)
> > +{
> > +     dwsmmio->dws.set_cs = dw_spi_elba_set_cs;
> > +
> > +     return 0;
> > +}
> > +
> >  static int dw_spi_mmio_probe(struct platform_device *pdev)
> >  {
> >       int (*init_func)(struct platform_device *pdev,
> > @@ -351,6 +383,7 @@ static const struct of_device_id dw_spi_mmio_of_match[] = {
> >       { .compatible = "intel,keembay-ssi", .data = dw_spi_keembay_init},
> >       { .compatible = "microchip,sparx5-spi", dw_spi_mscc_sparx5_init},
> >       { .compatible = "canaan,k210-spi", dw_spi_canaan_k210_init},
>
> > +     { .compatible = "pensando,elba-spi", .data = dw_spi_elba_init },
>
> If you agree with me and remove the custom CS-method defined above in
> this patch, then all you'll need is just to add "pensando,elba-spi" here
> with generic init-callback set - dw_spi_dw_apb_init.

The existing dw_spi_set_cs() is now being used.  Using
dw_spi_dw_apb_init results in every spi transfer failing which is why
dw_spi_elba_init() is still proposed which results in set_cs calling
dw_spi_elba_set_cs().

> Finally defining new compatible string requires the bindings update.
> In the framework of DW APB SPI interface they are defined in:
> Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> So you need to have that DT-schema accordingly altered.
>
> The bindings note concerns the rest of the updates in your patchset too.
>
> -Sergey

Patchset v2 separated out the bindings updates.  There will be more
bindings needed for v3 of the patchset.  I won't be sending v3 until
all discussions are resolved.

Regards,
Brad
