Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011C1171884
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2020 14:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgB0NTV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 08:19:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37653 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgB0NTV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 08:19:21 -0500
Received: by mail-ot1-f66.google.com with SMTP id b3so2862357otp.4;
        Thu, 27 Feb 2020 05:19:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YePo/5+OupClG7tl254SG+Sd9H1J2DdTDdubCfX50zk=;
        b=VuZL9kH9wdUUdI8gqTk+vhVqcaiI+Kr2PkyHBEBZrX+QfflTZ+8nppViqrKZpQLJ5E
         Rp29VzppGgao4jh1pvPhJVvlY5RI3LZiPcaVC2hMwLqCJ0VXqQRatqalUf6H+BZbJIeh
         wIIcegYUkD0tG/p5v6uBXkqjJ5gRLUD0TfQHTNSIcuFxYZ9xA8j9Z0Q4/9VWWAHLnHql
         AhZyn2VY+j4cnOR1ZS6VbwBrakwAwi/GG63qKxqCPjH/khm8XXhdSY55hNat9mn5rN4q
         L0u4eHg6UPEUZtJhkA0lOHkRohzvV7edivVJlmYhtx3ysQi9F8MneHl45TAulgIC7GEw
         uuxw==
X-Gm-Message-State: APjAAAVPu1i/yyVonQ0RHj0qAb6+may94MyEf9G8gCO7S1wHyv5GCsvn
        GwG7/bXqh2zW7YfbGc2qrpO8PSa21lWBVe00Wtc=
X-Google-Smtp-Source: APXvYqxlakM84HpX6mtOTLlzf/aUmaxXKcQuhByOC31CfixFsFpUGvgh2GKp9b1xNPCPOiFZ3JDf1Fi9ELJIb2+KkRw=
X-Received: by 2002:a05:6830:10e:: with SMTP id i14mr3275826otp.39.1582809559240;
 Thu, 27 Feb 2020 05:19:19 -0800 (PST)
MIME-Version: 1.0
References: <20200227130323.15327-1-geert+renesas@glider.be> <20200227130937.qvrjyxcwim7rfum7@gilmour.lan>
In-Reply-To: <20200227130937.qvrjyxcwim7rfum7@gilmour.lan>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Feb 2020 14:19:08 +0100
Message-ID: <CAMuHMdUVW_51dqMK=ziz_JVT3LuXX7vOF3-Ei-aHiiBuSepGpg@mail.gmail.com>
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

On Thu, Feb 27, 2020 at 2:09 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Thu, Feb 27, 2020 at 02:03:23PM +0100, Geert Uytterhoeven wrote:
> > Currently, the DT bindings for an SPI controller specify that
> > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > controller in master mode only.  When running in SPI slave mode,
> > "#address-cells" should be zero.
> >
> > Fix this making the value of "#address-cells" dependent on the presence
> > of "spi-slave".
> >
> > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml

> > @@ -52,6 +53,18 @@ properties:
> >      description:
> >        The SPI controller acts as a slave, instead of a master.
> >
> > +if:
> > +  required:
> > +    [ spi-slave ]
>
> Nit: Usually, that notation is when you would do it on the same line,
> if you want to go to a new line, it would make more sense to use -

Sorry, being a poor yaml-by-example programmer, I don't understand what
you mean.  Which part do you refer to by "that notation"?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
