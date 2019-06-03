Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1524E3344E
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2019 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfFCP4M (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Jun 2019 11:56:12 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37333 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729262AbfFCP4M (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Jun 2019 11:56:12 -0400
Received: by mail-it1-f195.google.com with SMTP id s16so27387156ita.2
        for <linux-spi@vger.kernel.org>; Mon, 03 Jun 2019 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cbGQBnJeaRGv6ajJJGIzuBiVBbh+VlWtI63dl/Lnkko=;
        b=Sh8raQlzVzdw4PULSC/mogzcqFkWKwBBgV6cLRMCwsJEYD850vyQys6ZgUR7Gm5J4W
         mcCxIuhNZQBOUevcvwIuV2IehFqN8+LsfxW1BF8ziMs9i1oLjg25ncDcDXgrz6eMv5ym
         LwZW9xQU/OgsCR3IPYqAY9Z55tKswE77JQshFFOJzEI5F71VrBNcbptKnbw7vcPkJ47X
         Mictj4iCCWFVFmIdsZl5qNq2pEV87wuGAVAOE7jzOHBP/AEjX+mjIsLWxu0GvuLAoSCa
         IgH2re+ZISlry2y/+p1DYlOse5xe7XARYaiXaIb+Y+Jx8GFuaSpnwFxaw002IrrcGRBQ
         GSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cbGQBnJeaRGv6ajJJGIzuBiVBbh+VlWtI63dl/Lnkko=;
        b=mUM/xBZN3rBYKzFffj4kBqCGYv0JXpDtHypjZgefwH5/yCPeryIraS7CsuNek3bvtp
         CYDX4fVBBmj1NpH9rJDsj5vHvIDAFEr4B/3+eKTGFgry8OqQg68XgCGvRZrmyE1cUlq0
         EOgXc9n0D0bWNm1LVZdviL/JO0M8OzpW4mvw0nMQTBT8LrAhXx3b9OCf1BFNysNE9wsC
         z9DbN9ps5gOFEb2JOTrmrwxtbDUR4n/vpuIsWyXzz8GE/1KZRd99aFmAn9vV0/4VTN1d
         DKjjhZhwEv21fD3J68AoNpmuRk7lXZVXjXRhv3fR7bt0Xr6d+zbJQBtGarhzvJjSXZvs
         VBIw==
X-Gm-Message-State: APjAAAUa4u3tRKAevvdn8FT3rOTfA+LzmQ8iT0xFCnrQRAGA0HIo+gZ4
        y6vXHLlmDgwbErLi0hVRmshUoxe3grP9aPwydiH1/g==
X-Google-Smtp-Source: APXvYqyNIUEIC4FJstcSw0ast50jY8Rc7M6z+5vxyipKpUnBdP9XGbW2up/SGXXWPzJQkN6LZK3sTc718Whw8rZYhVE=
X-Received: by 2002:a24:740f:: with SMTP id o15mr1823315itc.76.1559577371376;
 Mon, 03 Jun 2019 08:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190530111634.32209-1-ard.biesheuvel@linaro.org> <20190603110832.GA2781@lahna.fi.intel.com>
In-Reply-To: <20190603110832.GA2781@lahna.fi.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 3 Jun 2019 17:56:00 +0200
Message-ID: <CAKv+Gu8rTernjct93rsWo0X3FTp6bsV=0JvNGQr8C8OaqB1S7A@mail.gmail.com>
Subject: Re: [PATCH v2] spi/acpi: enumerate all SPI slaves in the namespace
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 3 Jun 2019 at 13:08, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Thu, May 30, 2019 at 01:16:34PM +0200, Ard Biesheuvel wrote:
> > @@ -1948,7 +1988,8 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
> >       if (!handle)
> >               return;
> >
> > -     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> > +     status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
>
> Would it be simpler to differentiate here between Apple and non-Apple
> systems? Then we don't need all that special code and the above becomes:
>
>         depth = x86_apple_system ? 1 : SPI_ACPI_ENUMERATE_MAX_DEPTH;
>         status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, depth,
>         ..
>
> Probably requires a comment explaining why we do it like that, though.

Yes, but note that both the root and the depth are different in this case.

I'll play around with this idea, to see if it simplifies things.
