Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA6C4812
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2019 09:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfJBHHB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 2 Oct 2019 03:07:01 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36929 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJBHHB (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 2 Oct 2019 03:07:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id i16so16761058oie.4;
        Wed, 02 Oct 2019 00:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qa8I2vSeOcSHyUQ43zH04lPYaidYYvPzAzgr70EX1vM=;
        b=aue2VvmQ4zX8qm9kZydMh3PmhASg0inELIlp1/kZKFXVuqiF5ZrkV/D0mWTfP4/Wmp
         rGHgY1yTgQfraz+CZqB5UlgSG+hJ7XjPinlakmKu0NNYjRQxzivsG+pRBIWBp4Mq16tX
         BmRADL21umoSa3JwlKg3ii++RAqWhrq+r0fu4tt7OjwGAklQrbKjDeKGDjGkcpb1l1zH
         mQsw+z3xYc+24tAWXfXuqjWJu1ePNHQfVOD8ww4nWdiPK2d68s5TmkRVhNwAywanAx/N
         FcGdvdFjggyePBssW2/1w1yFlAaTlnabM2cjemo0nTxEsDYpVjba4ltUBdf8y+MXtg0Y
         hufw==
X-Gm-Message-State: APjAAAXN44JLDLMIcc8rfaqxAy4Wc/JqmhTR8bodc0rSeRxhOTTYMc/+
        /+OApU9m7KGK91LGyehKPp4guGTMv37mC8vw82W1Ro4s
X-Google-Smtp-Source: APXvYqz4nWSfJSOe4TQLOwhjzEPpAjG/YYgHdYeOIizcYvV6doQlGAaY5cIzEAKgiSm6DQqrUeFdghQ2ticrF/Piwkk=
X-Received: by 2002:aca:f305:: with SMTP id r5mr1567000oih.131.1570000019973;
 Wed, 02 Oct 2019 00:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAHirDJ_gtrjL_nq0T2qvn_kv9-UweL+=bc7EBLrTfNfNkVn0QA@mail.gmail.com>
 <20190924175036.GA2036@sirena.org.uk> <CAMuHMdXbRQXarvV=86rssSiRnuKMSFWJLRbU3VH9tcCV_FeOGQ@mail.gmail.com>
 <89dc7df9f1544417dfadea3ead72dcbbc60d5ebd.camel@gmail.com>
In-Reply-To: <89dc7df9f1544417dfadea3ead72dcbbc60d5ebd.camel@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 2 Oct 2019 09:06:48 +0200
Message-ID: <CAMuHMdWGXUsFa_WcMsjW6J_xODdmUvjgBBBb39G-0C3e6xfp7g@mail.gmail.com>
Subject: Re: State of spidev from devicetree
To:     Claus Stovgaard <claus.stovgaard@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Claus,

On Tue, Oct 1, 2019 at 11:16 PM <claus.stovgaard@gmail.com> wrote:
> On tor, 2019-09-26 at 14:21 +0200, Geert Uytterhoeven wrote:
> > On Thu, Sep 26, 2019 at 12:50 PM Mark Brown <broonie@kernel.org>
> > wrote:
> > > On Tue, Sep 24, 2019 at 02:52:59PM +0200, Claus Stovgaard wrote:
> > >
> > > > What is yours response to the idea of creating a custom-hardware
> > > > binding
> > > > for spidev, intended to be used for programmable hardware unknown
> > > > at the
> > > > devicetree time.
> > >
> > > You should use a device tree overlay to describe whatever
> > > hardware you've instantiated on your FPGA then load the overlay
> > > along with your FPGA image.
> >
> > And after that, you can bind spidev to the device in the overlay
> > using
> > sysfs, cfr. commit 5039563e7c25eccd ("spi: Add driver_override SPI
> > device
> > attribute").
>
> I know this is a bit old, but will still thank you for the replays.
>
> Regarding overlays and binding via sysfs. I understand your answer and
> proposal for solution. Though in our situation with a very basic
> embedded system it is just extra overhead and added complexity,
> compared to just having a spidev from initial devicetree. Without
> giving anything as I see it. So would still have preferred some-kind of
> custom string in the .compatible inside spidev.

You can have a custom compatible value in DT and in spidev, cfr.
drivers/spi/spidev.c:spidev_dt_ids[].
But plain "spidev" in DT is a no-go.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
