Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA277888B
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2019 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbfG2Jgg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 29 Jul 2019 05:36:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52137 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbfG2Jgg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 29 Jul 2019 05:36:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so53189605wma.1;
        Mon, 29 Jul 2019 02:36:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Yqm44GF8Gd976qOiZ4sEaYghiM/gm/7QVw23GbTBQA=;
        b=gCJoL4PSIJBavtLZ87szOx7SW1eJ3yHLxvdrt+6C+ACNambMILyZ3l9/q1XetElAHW
         zGkXZ3ox/nzWXS9p+46X9qtIpFausK2D8K/B5UWY9V5xGG3NZcmdA09KTmzdZUpzvBpY
         8AcLMjHxqQI76LoGp+Jkt7ah6+5luqmtMqZ4e21h6CuC9e/c6g/4KSnyMiNaWVJC2nCK
         32eYnU9Dk3Lw7i2iHatb+Z+FQF0u4dt3U1CiB9SFh3hq1MxCFQEGBEkbdj3c24UU10BC
         q2HZ1XjsvmZeZZYmU0NY3toJ+KEX+NWHDf7gB/V8RtUoN6Kv22oKfxk2rgCg2PpwT++H
         HiHQ==
X-Gm-Message-State: APjAAAUitAkbETXlbvR9eB6gz1lJhBvJXLPYXj1++JhRAk66jgZvjyAK
        6/ex7wC4ZsI2L9tHYLrAG2SVJ1FRYbrg2jgjOWI=
X-Google-Smtp-Source: APXvYqz4C6VNLeH50i3ts0+WYAr0tK5c+Tjdv/pB1c8U5G2UqsS8bhidRvHUQegHJt37+vXJGXJ1FfP0Rtj6qCbf1Dk=
X-Received: by 2002:a7b:c310:: with SMTP id k16mr58469520wmj.133.1564392992673;
 Mon, 29 Jul 2019 02:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <1564108975-27423-1-git-send-email-masonccyang@mxic.com.tw>
 <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw>
 <CAMuHMdWVuQa1LLXPqrdSw6wdRzwQapAkk6Est=XrjESPF9zQwg@mail.gmail.com> <OFFF9D8385.D8395BBD-ON48258446.0033FD62-48258446.00349608@mxic.com.tw>
In-Reply-To: <OFFF9D8385.D8395BBD-ON48258446.0033FD62-48258446.00349608@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 11:36:20 +0200
Message-ID: <CAMuHMdXDJFWHaXk3KHQqhOqVhEGc3PL33f+HO2Ld8nYbvSpq7Q@mail.gmail.com>
Subject: Re: [PATCH v15 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On Mon, Jul 29, 2019 at 11:34 AM <masonccyang@mxic.com.tw> wrote:
> > On Fri, Jul 26, 2019 at 4:19 AM Mason Yang <masonccyang@mxic.com.tw>
> wrote:
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > > @@ -0,0 +1,46 @@
> >
> > [...]
> >
> > > +- flash: should be represented by a subnode of the RPC-IF node,
> > > +        which "compatible" property contains "jedec,spi-nor", it
> presents
> > > +        SPI is used.
> >
> > Sorry, I failed to parse the last subsentence.
>
>
> Fix it to:
> - flash: should be represented by a subnode of the RPC-IF node,
>          its "compatible" property contains "jedec,spi-nor" presents
>          SPI is used.
>
> OK?

s/presents/if/?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
