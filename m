Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA27112B1F
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2019 13:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfLDMOW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Dec 2019 07:14:22 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42398 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbfLDMOW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 4 Dec 2019 07:14:22 -0500
Received: by mail-oi1-f195.google.com with SMTP id j22so6611565oij.9;
        Wed, 04 Dec 2019 04:14:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gyltMSwaGXAux8Z3E1Rs/8+GQsTqCMlqwz9wEprYuxI=;
        b=qLWp7sO2ECMTDQgb+3QyLoEYzIQ2A9L4W+BG7LhccZqbYaUq8B7EHV9iPcm+Tt+cl1
         HGC7M9qcFwgW67HyP6dLkgaML7LAiA/YlCq3LV9YMpsRIJ9X6FIAslWWm09oQuNek1k0
         YfB3vfB42XYC39ua8t+OsoNEsrqZbYCMra9pw2ZpQ0br/wUqL4UnfDzw28AXqovQYtuh
         y40EUjh0V6pWQnXAdlYIiNVeFJvbRbeYVNbJRtrm1qwpLUIIjqTaMnXVKGeN2MxO4gAt
         3spc5o1NBP+mLZiUipyfWdqawC55gypORoL5iSvxGfuVwVfM/RQts+D8/FMcZCoVoDMy
         FUlw==
X-Gm-Message-State: APjAAAXpEQnGDfdi5t64lRwAbmdrfCcruulzaBN/5DrngQWdKUDAetRi
        XdVb+NUPstQD1sXy32laY45l3G8e5BqdwnFNdNA=
X-Google-Smtp-Source: APXvYqw8Fs1+GeWP1j9ni3BiJ585N8x8j9pInrEEwGCzSDYGx3Bebh2yBXnZb5CHErF17b0reE6WRUv9j4VhTCJ0ntE=
X-Received: by 2002:a05:6808:8ec:: with SMTP id d12mr530181oic.131.1575461661003;
 Wed, 04 Dec 2019 04:14:21 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-5-chris.brandt@renesas.com> <20191203141944.GI1998@sirena.org.uk>
 <CAMuHMdXk5DDebriHxmtz0NWF_zDhBK=fBZugdUfmEAyU0O4zMQ@mail.gmail.com> <20191204112528.GQ1998@sirena.org.uk>
In-Reply-To: <20191204112528.GQ1998@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 4 Dec 2019 13:14:09 +0100
Message-ID: <CAMuHMdXY4Po4p0uL_6VU7ia4R7i7F5N+GA4MUaQfhGFvpgLT7g@mail.gmail.com>
Subject: Re: [PATCH 4/6] spi: Add SPIBSC driver
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Brandt <chris.brandt@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On Wed, Dec 4, 2019 at 12:25 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, Dec 03, 2019 at 07:29:45PM +0100, Geert Uytterhoeven wrote:
> > On Tue, Dec 3, 2019 at 3:19 PM Mark Brown <broonie@kernel.org> wrote:
> > > > +     pm_runtime_put(&pdev->dev);
> > > > +     pm_runtime_disable(&pdev->dev);
>
> > > There seems to be no purpose in the runtime PM code in this
> > > driver, there's no PM operations of any kind and the driver holds
> > > a runtime PM reference for the entire lifetime of the device.
>
> > It matters for the clock domain (assumed the module clock is not always
> > marked as a critical clock).
>
> That seems like a problem with what the clock domains are doing
> surely?  The default is supposed to be that if runtime PM isn't
> enabled we get the behaviour the driver is manually implementing

Unfortunately not: if the driver doesn't implement Runtime PM, the
default is to not do anything.  Later, unused clocks will be disabled,
and the device will stop functioning.

> here.  Besides, if this is actually impacting power management
> I'd expect us to be letting the IP idle rather than holding it
> powered up all the time.

That would be better, definitely.  However, that's just an optimization over
holding it powered up all the time.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
