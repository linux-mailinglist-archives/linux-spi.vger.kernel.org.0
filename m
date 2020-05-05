Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04581C50AF
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 10:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgEEInu (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 04:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEInt (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 04:43:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D24FC061A0F
        for <linux-spi@vger.kernel.org>; Tue,  5 May 2020 01:43:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so528981plk.10
        for <linux-spi@vger.kernel.org>; Tue, 05 May 2020 01:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWYglMUiZAoIqIw/NoIbJ1FV3n1qujNsw2j5uw5dyMc=;
        b=XJe5XR4VztyayuoI4FQfSQUoOeRVeofxUuEbRffuB+m+IYrzSkP1HMQX9je+XFVubr
         P4jE3qIWd+Ua59w+T888LVQ3lHaRZwLJURBsUAPwJNOHlyx8JCRbVAceZc1WawAxadw3
         5r+ppAqjJu8IQZyay817mSADHm04pLsGt2xuLhaG4/iUBfS9jrGUxIjV1fEX7N020ems
         5TTVyXZuN5C6ezQ/Lj/bIxhuO5PgObpBADsH6bAKMX0HslsCQeezAxs4ck2OiYoH6Wgp
         1GyWE76TayelOqFEpLBWIl/eHfKzHtQoEtG9hM7GWa3dOm0DDtnnPB/tReivTmmkX+ee
         38Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWYglMUiZAoIqIw/NoIbJ1FV3n1qujNsw2j5uw5dyMc=;
        b=KkuOIP9XKa2UFNwrlEqH2hbZ6MF/7a25nvEaElfXrREaosG+sVPrG/9OVp5wsnLk06
         9e+B1WkGwp4ZrCD8QXbd/QlNG9+TpFJ2y+awg2gH9snoDuWnHrDP1y83HgmncjNzpNEv
         ElAr6HKV7c/ZOa6iTkoSqjnYjtUhs78M4tqiu6cYe/OIVXdacWgTInPDlCUVePrWDdcO
         8jHar1FMUSunMbJJmTLX9aBB0VeOCAgh1fkPXnCtEVSnzFyu+GRfK76wS7fkCreQMrl6
         rG133HCuLnpdYSsFV6aZJ6LJuTgXJblZGgDRYK9nrE9z1z26r1T6XJBB/h3PTkYtNfvC
         uu+A==
X-Gm-Message-State: AGi0PubNjjBWj8gSIgHhSYgf1zxtJ3/IOeDLuxD7J9CSZwbNQz42081y
        ioAg57lEFiMO7VqFSeb1hhfP1i5Bu7vqXDH1/In49UZt
X-Google-Smtp-Source: APiQypIbsWo8okneBV3VJe/pQKdihSrSAqCgcnMCo1Xc8Z8O6atnc8yAhpszPhfi+ffU1sNurJN7Lcs8nxhPBDZnYA4=
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr1656969pje.1.1588668226825;
 Tue, 05 May 2020 01:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_wQpbtktD=bXwJCzdm_5aLeHcQrSW2pNMRergC9jZ0sMw@mail.gmail.com>
In-Reply-To: <CABatt_wQpbtktD=bXwJCzdm_5aLeHcQrSW2pNMRergC9jZ0sMw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 May 2020 11:43:35 +0300
Message-ID: <CAHp75Ve9giL99P+4Q+LjcFPKPq4fzXR+8UDPDZpA+sPr0o04cg@mail.gmail.com>
Subject: Re: SPI driver probe problem during boot
To:     Martin Townsend <mtownsend1973@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 5, 2020 at 11:04 AM Martin Townsend <mtownsend1973@gmail.com> wrote:

> I've just finished debugging a SPI comms problem for a TPM device on a
> TI Sitara AM4372 SoC.  The SPI bus has 3 devices
>
> 1) CAN FD Controller 0 (Using native CS)
> 2) CAN FD Controller 1 (Using GPIO for CS)
> 3) TPM Device (Using GPIO for CS)
>
> All CS are active low.
>
> During boot the TPM would fail it's probe but if I unbind and then
> rebind the driver after boot the TPM would work fine so I got the
> logic analyser out to probe the SPI bus and could see that the voltage
> on the MISO line was half the expected voltage whilst the TPM was
> being probed and this was due to CS0 being driven low for this period
> of time.  After the TPM was probed the CS0 went high.  After debugging
> this I found that the OMAP SPI controller defaults internal CS lines
> to active high so when the SPI master controller is initialised this
> is the state of CS0 so it's driven low for inactive.  During the probe
> of the SPI master controller it calls devm_spi_register_master ->
> spi_register_master which calls of_register_spi_devices which will add
> the devices to the SPI master controller via spi_add_device.  This
> function would call device_add. Due to the way the device tree is
> parsed the SPI devices above are enumerated from the highest CS to the
> lowest so the TPM device is setup first.  When device_add is called it
> triggers it's probe function but the SPI bus hasn't been setup yet and
> hence the TPM driver tries to communicate with the TPM device whilst
> CS0 is being driven low causing the CAN FD controller to also respond
> reducing the voltage on the MISO line.  In spi_device_add it calls
>
> status = spi_setup(spi);
>
> which would setup the CS lines so I modified the
> of_register_spi_devices function to make it a 2 phase operation so the
> CS lines are all setup and then it iterates of the SPI devices a
> second time to add them to the driver model via device_add and the TPM
> now probes fine.

...

> Now this is on a oldish kernel (4.12) and moving the kernel forward
> isn't trivial.  I was just wondering if this has been fixed already so
> I could backport it, I couldn't see anything in the latest kernel but
> maybe it has been solved a different way.  If not is there a better
> way of fixing this? Or is the OMAP SPI controller driver the problem,
> should it parse the child nodes first and set itself up accordingly?

Can you confirm the issue on v5.7-rc4?

-- 
With Best Regards,
Andy Shevchenko
