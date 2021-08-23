Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 048DE3F430A
	for <lists+linux-spi@lfdr.de>; Mon, 23 Aug 2021 03:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbhHWB1u (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 22 Aug 2021 21:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbhHWB1u (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 22 Aug 2021 21:27:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4FBC061756
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:27:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ia27so11276661ejc.10
        for <linux-spi@vger.kernel.org>; Sun, 22 Aug 2021 18:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2begKrsVruCVFeZ8bmp5S3srbzJHX+xkiz5yVBPaB0=;
        b=v6M3jOOYiHr6DwA8pLmIRMx2zdb4b60QpDLrttOohnvH8xqixtUDMEAiRRcDRbEOLJ
         DSy/eoDgDPvJ0IAPQ77KG0SRgAaksBdhg7+oi/eJmct/W43EUqFgcaRWDVTobkERdWIu
         j7KkrbJ8vEx7pOsp4EgnXCGRILKI8kgxwr+2CvuOMIlzcuu9dKiXd83NcRKGvgEV+5EH
         miHjxyXzpTl1lIrj+KB5xnLB9CHcboCgFtS2Nj3lZYbJiHUk5k6RX40SqxmcoTzRO8Yc
         3TS7sSjj+LehqA0J4SgRNPXoVQ9z5Vxo1nNXhPK4jTm62OGz+ccXqY1L79ogsTBVha39
         H88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2begKrsVruCVFeZ8bmp5S3srbzJHX+xkiz5yVBPaB0=;
        b=iKQCekI88w9HnZpVMOhMnoJbK3uJVe8r5SfXrYkvf4Uy1pnlGcXPZGd72PrLa4zy0W
         uDf2crPBsi3qycVcpLahTk1vY1BUSnE20oSnX784EzAa6hN2Dl0vwRYD/P1QRUAvTlI5
         ftoLygCV7vLUhHrZKVcNe9YrM9iGFS83jZ9x37Mdeb2fbmPa0Nex3aJda9yQ5TVprUMF
         Ma7UXneKBKBlQh/4dA+CxDPLWVwY3T6tdnAoyWR0zsKfLbrYX1Wduap1jBP0Lm1HmJO8
         2gtLTCUZJG85nsf4fH62LbeIwOScJGc3ENxGRrBBPLvaebNzO/oDcP+33bnxvUsjgIgL
         RDCg==
X-Gm-Message-State: AOAM531K0dOq4eKadzwPyA5gdTtjhYSYALy3FjDL1OUARYUttuU/NY/X
        +TPzlPjSxhgXD9cyULDRJ0APdj9i8ZMSW0S/0QZPcg==
X-Google-Smtp-Source: ABdhPJz+zD9molsnaSU1Wf+bRjrriq0R1N70JnNmz/Xlv5Du293t/g7zCjRmL+ggHKWoD6xuspCkxkwdiW53ALI1dAU=
X-Received: by 2002:a17:906:cb11:: with SMTP id lk17mr32487256ejb.271.1629682026850;
 Sun, 22 Aug 2021 18:27:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210329015938.20316-1-brad@pensando.io> <20210329015938.20316-4-brad@pensando.io>
 <20210331180018.jir2vusuf3sbare5@mobilestation>
In-Reply-To: <20210331180018.jir2vusuf3sbare5@mobilestation>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:26:56 -0700
Message-ID: <CAK9rFnxs_8fFnQPCDuW-=w36zq8+TStRVSBijjkGsEaMF-R6MA@mail.gmail.com>
Subject: Re: [PATCH v2 03/13] spi: dw: Add support for Pensando Elba SoC SPI
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

On Wed, Mar 31, 2021 at 11:00 AM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> On Sun, Mar 28, 2021 at 06:59:28PM -0700, Brad Larson wrote:
> > The Pensando Elba SoC uses a GPIO based chip select
> > for two DW SPI busses with each bus having two
> > chip selects.
(...)
> > +static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
> > +{
> > +     struct dw_spi *dws = spi_master_get_devdata(spi->master);
> > +
>
> > +     if (!enable) {
>
> Please, be more attentive to the review-comments given to you before
> resending a new patchset. One more time. This version of set_cs won't
> work for Active-high CS. Each SPI controller working with GPIO-based
> chip-select is marked as supporting that feature. So your DW
> SPI controller won't be able to work correctly with SPI-devices
> activated by active-high chip-select signal. Note default
> dw_spi_set_cs() callback supports that.

Thanks for your patience.  It took me a while to understand what you
were asking about regarding dw_spi_set_cs() due to the unnecessarily
complicated function that was being used.  The current implementation
I propose for v3 patchset is this which as you identified handles cs
active high/low properly.

static void dw_spi_elba_set_cs(struct spi_device *spi, bool enable)
{
        spi->chip_select = 0;
        dw_spi_set_cs(spi, enable);
}

Regards,
Brad
