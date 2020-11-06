Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EF82A9DA9
	for <lists+linux-spi@lfdr.de>; Fri,  6 Nov 2020 20:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgKFTNW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Nov 2020 14:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgKFTNW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Nov 2020 14:13:22 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CB8C0613CF
        for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2020 11:13:20 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id i193so2062730yba.1
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2020 11:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lDPmrGFyyFCuKqcXej1vTwCKboywcjbteDegF6u/TEM=;
        b=qDSXDHqVps4VOYMWow1GJ0SanYAuA1SdO6RbRbZ31Wh4pI55eM0GeW/IGBYf9468HB
         DO4nCTQMXR432ljb7SJvfNZF2qWgRKGagrJvUmOT4o82vRxaBJss0WGtrldob4GRA9Zn
         Xxs1Xl2TRU/R3J5RM9Lwu5yHGCOJDimnz2NJz7sZIhLzKW/Je9zerb3v3ratHqEhbMqG
         MQElstyGbHkQwv3qIm73AGIUyxncTZjlrIkanVoFNg5C3jThhLeE8PLaSwuoGhBC43K7
         wcaFDe3YAlBewKAQt0Nacc/VIXSdgPyfaZct8KRI3oeYn/u+CsztnWHuWfahAFWe8HNo
         usYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lDPmrGFyyFCuKqcXej1vTwCKboywcjbteDegF6u/TEM=;
        b=QBgLiEzX0OKg1n4tTUXYKzee+E148Di+6t7oFiyT3kyHJIEkLyBiQvVGg0CcTXKT/8
         QxVtgjxaFqE8nPvfzTxfgN7ms97Ld+ydfNa926zwoBqN8FPy07Txc68DpXRVeympMq84
         9avJkAq0XIcljQk1MhZWQoplvwmusGaiGtrco1l9dg3DSc2h8TiaDzp9IwSc371ShPPs
         fJNzbCINJYGfJwvdV8jKNkimDBwkHZsg7SfngM6v0NZg/cxpjSTPBtMzsLNDtRvBl0JW
         nXs/UgqNsVSoCa2Aw2JeNezKB6MAS0Pu32hlc+SwqIFHqWsnMbgsJQVRnPivcJsbSuzD
         B1UA==
X-Gm-Message-State: AOAM531/IrhIc7cQWCI8tJNiwW1O8ZTfdv6LHR3pdBFOMnHrPcYAtaTd
        J00nJz7/AgB7kH57LKkx/465+ujv10q5weWAoeEVCA==
X-Google-Smtp-Source: ABdhPJxdpwkjU6nef5hnn+qBzVQD4nTVfGkL+NAu+//5kga1xXgG9HgNv//s3EOvEsHYitfkxS3QOuETzCIFrw7hEjQ=
X-Received: by 2002:a25:c483:: with SMTP id u125mr4486728ybf.310.1604689999367;
 Fri, 06 Nov 2020 11:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20201104205431.3795207-1-saravanak@google.com>
 <20201104205431.3795207-2-saravanak@google.com> <20201105171201.GF4856@sirena.org.uk>
 <CAGETcx9_En10j0DwktXtPDrx=Aqdr2iWEuHmYB-=SnfODTmMfg@mail.gmail.com> <20201106151011.GE49612@sirena.org.uk>
In-Reply-To: <20201106151011.GE49612@sirena.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 6 Nov 2020 11:12:43 -0800
Message-ID: <CAGETcx-i--K+1go-+126bBB85BG8kksgRr3j3hnCRfkt0vqBMA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] spi: Populate fwnode in of_register_spi_device()
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Cheng-Jui.Wang@mediatek.com,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Daniel Mentz <danielmentz@google.com>,
        linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Nov 6, 2020 at 7:10 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Nov 05, 2020 at 11:26:44AM -0800, Saravana Kannan wrote:
> > On Thu, Nov 5, 2020 at 9:12 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > >       of_node_get(nc);
> > > >       spi->dev.of_node = nc;
> > > > +     spi->dev.fwnode = of_fwnode_handle(nc);
>
> > > Why is this a manual step in an individual subsystem rather than
> > > something done in the driver core
>
> > It can't be done in driver core because "fwnode" is the abstraction
> > driver core uses. It shouldn't care or know if the firmware is DT,
> > ACPI or something else -- that's the whole point of fwnode.
>
> Clearly it *can* be done in the driver core, the question is do we want
> to.  The abstraction thing feels weaker at init than use after init,
> "init from X" is a common enough pattern.  If it's done by the driver
> core there would be no possibility of anything that creates devices
> getting things wrong here, and the driver core already has a bunch of
> integration with both DT and ACPI so it seems like a weird boundary to
> have.
>
> > > and wouldn't that just be a case of
> > > checking to see if there is a fwnode already set and only initializing
> > > if not anyway?
>
> > Honestly, we should be deleting device.of_node and always use
> > device.fwnode. But that's a long way away (lots of clean up). The
> > "common" place to do this is where a struct device is created from a
> > firmware (device_node, acpi_device, etc). I don't see a "common place"
> > for when a device is created out of a device_node, so I think this
> > patch is a reasonable middle ground.
>
> That is obviously a much bigger job that's going to require going
> through subsystems (and their drivers) properly to eliminate references
> to of_node, I'm not clear how doing this little bit per subsystem rather
> than in the core helps or hinders going through and doing that.  I don't
> think you'll ever have a single place where a device is constructed, and
> I'm not sure that that is even desirable, since there are per subsystem
> things that need doing.
>
> I'd be totally happy with eliminating all references to of_node from the
> subsystem but for this it seems more sensible to do it in the driver
> core and cover everything rather than running around everything that
> creates a device from DT individually and having stuff fall through the
> cracks - it's been a year since the equivalent change was made in I2C
> for example, we've had new buses merged in that time never mind SPI not
> being covered.

Since you kicked off another thread while we were still discussing it
here, I'll just move to that thread. I don't want to discuss the same
thing in two different places.

> BTW I'm also missing patch 1 and the cover letter for this series, not
> sure what's going on there?

Sorry, scripting error. There is no series.

-Saravana
