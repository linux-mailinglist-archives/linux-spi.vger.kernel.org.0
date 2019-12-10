Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F936119963
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 22:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbfLJVp7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 16:45:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35930 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbfLJVp6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Dec 2019 16:45:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so21641096ljg.3
        for <linux-spi@vger.kernel.org>; Tue, 10 Dec 2019 13:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=newoldbits-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kk+XYtgo/ITYK/azoZ61jVzAwkt0Rw6Rpf0U+vk60q8=;
        b=mhCalU/9LkhmiXHw0/P0jxxAktprs4kqeJ9P2G6P6ctPgqCJn7Ei1YWrjEErURyj4n
         kWmSe5kf6hEcrAGxGyfFLJZQGN8oggW++J9TnbpmClHFHPBA75d2oCOLV5HpcQzjZ78B
         /R+Fcvh49neoPoUvWiEyLOl50q3y8c/1FUyB1vo5NVK6dTrAr5qyNB/o1+xZR9qaya8+
         L9AP6beMtozh8BLDx7/aj8UYo8uy/MIlS9gU+3R3zCkrVE5cdh05kcIwTeOf+8Znplgx
         G8zsuhvC3PTsFKTC/vPZu7XW6naC9ZZz0WQPzUV3u1fh5+LJyEpw5AmfyoTTfyaqvu7m
         XpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kk+XYtgo/ITYK/azoZ61jVzAwkt0Rw6Rpf0U+vk60q8=;
        b=NG/OWHxX8nFWEn5DUaaR8aMgFckgRTiTiL+Ybxi+ogk+35jlZjjEyMq0qGTch018pW
         cNEjXyV0TnEZT56iGDCiuLacuMr9TrlfvvetZRzjBMdU9EOsaCd6K6XhWny2lE6vzwxy
         vqWNThq8Qy9ItBgSCVm0KElJvzEqFQr9GOwtsmHrAJty6FpahAXDtp50lvugVPVt9rEn
         7Ci9aMibHPHqipeoBVFvQh/OuMzhq1Dooss0c64eRZcygCBO02lZ9J9rLoJAqgZhRqDS
         16P3fNemJfhfhLZCwc6sp3cdH3LRRivdPXKiAaA1ccz4URobyZxrVhA/zskO1xRcH/Pu
         kOpg==
X-Gm-Message-State: APjAAAVadaEHiZjSmevL9K+7jhHY8xHBRu5GrJQ9q1dy33RzyNNRFl3e
        s536H9AVTA3ma0GymlXMvCs7iiGF/JLO6wbjFPFGAg==
X-Google-Smtp-Source: APXvYqyUfvgkmmPzZ2BMoRr26JcOwxqFOarcLyGeImtq3p+yvedqGfJ4rQGUdqHf7RBuo/fUOrKTRma6zMofWkKXmDI=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr22058986ljc.161.1576014356276;
 Tue, 10 Dec 2019 13:45:56 -0800 (PST)
MIME-Version: 1.0
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com> <20191206162431.GF35479@atomide.com>
 <CAORVsuUBseM3vnZsSajMmUS1O6rEC4U_aa951HwMsGxyEm+t+g@mail.gmail.com>
 <20191206175731.GG35479@atomide.com> <CAORVsuXe7SyAmzLv4VoKMsf4jcYV1bKoCixhsgZ3U0rBHFJA4Q@mail.gmail.com>
 <20191210170329.GM35479@atomide.com> <CAORVsuX_bzzsjh+qg_i_sfc=GR6F=S2wgObZiQTdM=w=ghZ9BA@mail.gmail.com>
 <20191210210200.GN35479@atomide.com>
In-Reply-To: <20191210210200.GN35479@atomide.com>
From:   Jean Pihet <jean.pihet@newoldbits.com>
Date:   Tue, 10 Dec 2019 22:45:45 +0100
Message-ID: <CAORVsuV9R-1Yg3YYRUGZ8mQR=ZST+jSLEuSmv0hgSNrLHur-rw@mail.gmail.com>
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
To:     Tony Lindgren <tony@atomide.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Vignesh R <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Tony,

On Tue, Dec 10, 2019 at 10:02 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Jean Pihet <jean.pihet@newoldbits.com> [191210 19:22]:
> > On Tue, Dec 10, 2019 at 6:03 PM Tony Lindgren <tony@atomide.com> wrote:
> > > Well can test again with the patch below to see if that is
> > > enough to make it work :)
> >
> > This patch works OK! The correct clock is in use by the driver. The
> > hwmod warning shows up at boot:
> > [    0.103567] omap_hwmod: qspi: no dt node
> > [    0.103599] ------------[ cut here ]------------
> > [    0.103639] WARNING: CPU: 0 PID: 1 at
> > arch/arm/mach-omap2/omap_hwmod.c:2414 _init.constprop.29+0x198/0x4a0
> > [    0.103654] omap_hwmod: qspi: doesn't have mpu register target base
>
> OK good to hear. That warning will go away when the legacy platform
> data is removed. So the patch needs to initially still keep the
> "ti,hwmods" property until we remove the legacy platform data.
Can the patch be submitted like it is now? If so I am preparing a v2 series.

>
> > Glad to help to get to the final solution, please let me know how I
> > can help on that.
>
> Well is this needed as a fix or can it wait for the v5.6 merge window?
It can wait since this is an improvement, not a bugfix. Does that sound good?

>
> If it's needed as a fix, some kind of description for the issue
> fixed is needed. Any ideas there?
>
> We know the right clock is not found by the driver, but I'm now
> wondering if this ever worked or has there been some bootloader
> dependency?
The motivation is to optimize the SPI transfer speed, especially for
the SPI flash devices.
With the current code if a 48MHz SPI clock is required, the effective
clock will be at a 16MHz frequency.
There is no bootloader dependency afaik, U-Boot uses a macro that
defines the fixed 48MHz of the PER clock.

This description comes in the patch desciption.

Thanks!

Regards,
Jean

>
> Regards,
>
> Tony
