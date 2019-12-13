Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDF0B11E5AF
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2019 15:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfLMOgg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 13 Dec 2019 09:36:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40462 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfLMOgg (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 13 Dec 2019 09:36:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id i15so6698860oto.7;
        Fri, 13 Dec 2019 06:36:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GGDHCjU3MM6dIoUZbPeaqvOt8azxG8D7bJ42yMYhguQ=;
        b=Fg68g20DS9J34weDnrWGHF/e32qZHaPKuqqvTc5id+1NwJ8EhouTc3Sf5tDMNjnnY6
         SqQa4qIVZqeLiYz9B5rO5FMd51FlHFwY1JMgj0K+BhdT1V9epD8WwlMWnyf56xe6qeqV
         qtDhx3Lc4/+sNcFyLjAxnsIyQrqOaGSf1+EEb/qrGvKObeP2TnFYG0q+bi2ALBnd2gZz
         04rZ79DmSzgBfSHIjkOYSPqFtxM5Br/Uz4emFiZN5CYUPReMTar0yFkYKcpjvjWgPNst
         1ENDf3Fds4LmZ6vE1oAXSNaazzPtAN8jCYtfe+47tRQYQW5cH9oTN3bOJVXsxXA+ZVMO
         2iNQ==
X-Gm-Message-State: APjAAAUnN0pkrsHwA1bpmgIGHR0UBwkkOpB9uLf6PLVkKBpOBoVCgn5V
        P58Gs8CdSrgYjbnrXx16OHRguMn9WoIYwiQZtH4=
X-Google-Smtp-Source: APXvYqwKdL1VCGK4Oe8rL01hvhyHoDgd/HFUlME0PAelLe/cixzON7bfU2Iq4k7pCixPL7UT2s6qDca45N2N5QcrkBo=
X-Received: by 2002:a9d:7984:: with SMTP id h4mr15219004otm.297.1576247795212;
 Fri, 13 Dec 2019 06:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20191212033952.5967-1-afaerber@suse.de> <7110806f-ddbd-f055-e107-7a1f7e223102@arm.com>
 <c86c6bc0-b0e5-c46e-da87-9d910b95f9f3@suse.de> <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
In-Reply-To: <04e7d7cd-a8bc-621b-9205-1a058521cabe@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Dec 2019 15:36:24 +0100
Message-ID: <CAMuHMdXddQ4v8-by_SmcS09EYykoBZ2G2vcFUpqPadHFaasy7A@mail.gmail.com>
Subject: Re: [RFC 00/25] arm64: realtek: Add Xnano X5 and implement
 TM1628/FD628/AiP1618 LED controllers
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        csd@princeton.com.tw,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, sales@fdhisi.com,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, zypeng@titanmec.com,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Robin,

On Fri, Dec 13, 2019 at 3:08 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 12/12/2019 8:55 pm, Andreas Färber wrote:
> > Am 12.12.19 um 14:14 schrieb Robin Murphy:
> >> and as far as I
> >> could tell the command set appears to derive from (or is at least common
> >> to) some old Holtek VFD controllers.
> >
> > Hmm, HT16515 looks similar and has more lines, RAM and mode bits than I
> > prepared here.
> > https://www.holtek.com/productdetail/-/vg/ht16515
> >
> > So I'd need to make more numbers model-dependent and allocate the
> > Display RAM buffer dynamically.
> >
> > Whereas HT16D35A seems incompatible command-wise, and HT16528 appears to
> > be out of scope, for dot displays and with fancy embedded character map.
> >
> > No Holtek email alias that I can quickly spot.
> >
> > But given that I'm proposing vendor-specific compatibles just in case,
> > the main decisions will be the Kconfig symbol and module name. The
> > driver code itself we could always refactor after merging, and renaming
> > the schema file (as opposed to compatible) should also be possible.
>
> Yeah, I'm not sure that it really matters, as I doubt there are many
> Linux-capable devices with a real VFD anyway; it just seemed like an
> interesting datapoint that fell out of scouring the web trying to find
> any evidence for which the "canonical" 1618 might be (and the Holtek
> connection was actually a coincidence from a misidentification of the
> ARTSCHIP part number).

My Sony Blu-Ray/Home Theatre has a nice one (14-segment!), also driven
by an HT16515.  While the specific model predates the arrival of Linux
in the next stepping of the hardware, it should be sufficiently powerful
to run Linux.

Unfortunately it's in active use, so hacking experiments would be vetoed by
the family ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
