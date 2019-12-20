Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC601276CD
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2019 08:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLTH4B (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Dec 2019 02:56:01 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33277 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfLTH4B (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 Dec 2019 02:56:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so10822787otp.0;
        Thu, 19 Dec 2019 23:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPJ1KIA9H7OXgnE4YWq2fYmCEnqTsEmR4nOQ4sQoQq8=;
        b=jPl3AgVxcuk8K1PQsRqf9lj77LKiozKTcYOt6wZ2n1yDa5HLf/jwZDtKjeE9F+dc+e
         nVeYzWj+DLuOZOYeW53I8jpQfNnappvo7DCmn6XEs3S9zyFfsT1YvXx8GgjlU92exbyD
         OX+F56WgWOhn2InJlZuO/N4ZjD0HplwEJHJ++WN9+bFVFRts4vZ2e7m45tI0Js+z5JTK
         OfBcUu39MoCKP1CJNyXXxpGbjmMZNj43jsdjHznN3IArGMPLQgQJ/eQloM3a2s3M48Qq
         jKuE8ZoIyW5qD3hY7mdfVs6NSwBDn5YCqBEc5zIDSAakHSSSffon2qOsnXm+F7Pke1d5
         5opQ==
X-Gm-Message-State: APjAAAVhBSnMa0/jmZg2np7A+WHIBXcPIke6yVjQM21ovfDa7ugX6Kmu
        bR8vWsbIRVLulJtmHNM5fzXhIczpoy3O8xyphD11cg==
X-Google-Smtp-Source: APXvYqxuuKbcqN+HnU6d2ZXGY1ikEbezmoM4iRsqjjm9bC7yzpsuZdyz1+8RyndHnTH6dHaaDblodY5LuOgwuTGOb8k=
X-Received: by 2002:a9d:2073:: with SMTP id n106mr3808625ota.145.1576828560332;
 Thu, 19 Dec 2019 23:56:00 -0800 (PST)
MIME-Version: 1.0
References: <20191206134202.18784-1-chris.brandt@renesas.com>
 <922cfa46-efb5-9e6d-67ea-3ac505b8211c@cogentembedded.com> <TY1PR01MB156215E8668C0317FA0826B18A580@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <e6a73df5-31c4-3472-f7bc-a0984f1f5380@cogentembedded.com> <TY1PR01MB1562D343E1AB06DCA2973DAC8A550@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <590840ce-a250-2512-3d04-c2420d83f7da@cogentembedded.com> <TY1PR01MB1562B9EB96818DCA507079808A510@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <bb630141-021c-5618-f266-b98b29956fa8@cogentembedded.com> <TY1PR01MB1562E196AB1C582F186CC74B8A520@TY1PR01MB1562.jpnprd01.prod.outlook.com>
 <6f4c5d92-3ca4-2d1d-47c4-cbd52ad428b0@cogentembedded.com> <OF3F92D76C.33FFFBFC-ON482584D6.00093DAC-482584D6.0009A51D@mxic.com.tw>
In-Reply-To: <OF3F92D76C.33FFFBFC-ON482584D6.00093DAC-482584D6.0009A51D@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Dec 2019 08:55:48 +0100
Message-ID: <CAMuHMdVtDbxyrZL=F_o4xCuM96B4yw7WrUMOZ7jeWh5GHV6aAQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] spi: Add Renesas SPIBSC controller
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Mark Brown <broonie@kernel.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mason,

On Fri, Dec 20, 2019 at 2:45 AM <masonccyang@mxic.com.tw> wrote:
> > On 12/19/2019 07:57 PM, Chris Brandt wrote:
> > >>> So at the moment, there is nothing yet for me to 'try' on the RZ/A
> series,
> > >> correct?
> > >>
> > >>    Why, I can send you a working version of the SPI driver, and even
> HF one
> > >> if you're
> > >> interested.
> > >
> > > The point of this whole discussion is to determine if we should have 2
> drivers
> > > for the same Renesas HW IP.
> > >
> > > There was a RPC-IF patch series that made it to v17....and is now
> dead.
>
> It's under review by Geert Uytterhoeven
>
> https://patchwork.kernel.org/project/linux-renesas-soc/list/?submitter=181859
>
>
> https://patchwork.kernel.org/patch/11078131/
> https://patchwork.kernel.org/patch/11078133/

It's marked "Under Review" in patchwork, as there haven't been any comments
on v17 yet.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
