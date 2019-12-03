Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92774110440
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 19:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfLCS35 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Dec 2019 13:29:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38958 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfLCS35 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Dec 2019 13:29:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id 77so3824798oty.6;
        Tue, 03 Dec 2019 10:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NV4ibH2J9LhMP6KG+i01/puyEjQ95fZYQprODmWQlho=;
        b=LLO33CReIAPY+ePU9Yz4S5dEL8ws4OmZGfbI6xd5tbMCDnxQJLsyMLCeINiN8sZBX7
         ju++P3FXvVUm9FtBj16Lcl4zMpAkpjN/DwPYXs3LLsA5jtaw3ea8iHHDbt7LZWXbTSPk
         Gfqaks/rDwKsK0vF7xMasbRKyJTv1iklwvr7/UwQVUmCJTHM9kmj6zzGpiQgPM9pmHY2
         XG3QIItu5lNfAt+rpYuzyrqNXL/86WVRqSXSkep0WzhePfjSrdlq2g4f137KOVrhUfaG
         XvUUJ5KCnZBuqTwRoxJQsNC7EKYTGkpSr+9pP51x4l0pniuRu45ouNkDU9xgYmHT9EFY
         Qybg==
X-Gm-Message-State: APjAAAWs6q032sfIO7tZZFtLuD7+WEJt5CK9pRIcZe8MheOsHhXfFJwO
        qya9ebtqW5TBL9gidkDsemHFm4cL3IaylqigPiY=
X-Google-Smtp-Source: APXvYqxq9EHxQOnhUKAELah60ln2hToa78jZpsm0yFqbVpTvSXVC7dsomkUNWfLejKJKm80AvxexdSxoBjXnH3wIkh4=
X-Received: by 2002:a9d:5d10:: with SMTP id b16mr4249571oti.250.1575397796011;
 Tue, 03 Dec 2019 10:29:56 -0800 (PST)
MIME-Version: 1.0
References: <20191203034519.5640-1-chris.brandt@renesas.com>
 <20191203034519.5640-5-chris.brandt@renesas.com> <20191203141944.GI1998@sirena.org.uk>
In-Reply-To: <20191203141944.GI1998@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Dec 2019 19:29:45 +0100
Message-ID: <CAMuHMdXk5DDebriHxmtz0NWF_zDhBK=fBZugdUfmEAyU0O4zMQ@mail.gmail.com>
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

On Tue, Dec 3, 2019 at 3:19 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Dec 02, 2019 at 10:45:17PM -0500, Chris Brandt wrote:
> > +static int spibsc_remove(struct platform_device *pdev)
> > +{
> > +     struct spibsc_priv *sbsc = dev_get_drvdata(&pdev->dev);
> > +
> > +     pm_runtime_put(&pdev->dev);
> > +     pm_runtime_disable(&pdev->dev);
>
> There seems to be no purpose in the runtime PM code in this
> driver, there's no PM operations of any kind and the driver holds
> a runtime PM reference for the entire lifetime of the device.

It matters for the clock domain (assumed the module clock is not always
marked as a critical clock).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
