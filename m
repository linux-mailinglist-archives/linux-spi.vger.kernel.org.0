Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E944D1C5224
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgEEJrY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 05:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726568AbgEEJrX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 5 May 2020 05:47:23 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE74C061A0F
        for <linux-spi@vger.kernel.org>; Tue,  5 May 2020 02:47:23 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y185so843414vsy.8
        for <linux-spi@vger.kernel.org>; Tue, 05 May 2020 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aV3wcDNbnh5h336+huNQmmlOrzJeDVhWGQdAHx4xG04=;
        b=f12o31VL+UUSsOdTGaFwszGLrYhOQjApSHWv33Kjn0F24uKFVmQ2m71N2HDqr3NN/6
         IqDacQlzc4b4RSQp0k9uzytMfYfTbMDS2wEmGMdfDG2qbJZdykjxkYPeIuPCp0ttlDI4
         rDfQnj+RwuO4E0PIJRPmUZObvnopMSGirlzl+HjaZJR/5nHV14EQ2fFj/kBOv2zbvt1V
         9x4nfvTOfo4J0L4aPicMVQISLymgPfpS31NlVRrdCDWo+UCKhFD3Imr8AIJCGI8kFrkB
         UoywBu0FAxQj4Tg0Am903sFHkvqJiWxSs4gbqk3NBNolEgoXrAyMO/La1L+LxQen57q5
         /huA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aV3wcDNbnh5h336+huNQmmlOrzJeDVhWGQdAHx4xG04=;
        b=jM9mC1t1Zv15HP6IwZmcqk8T8lPlG4IevVxveSVLFl1radM3/ARCKdjm0LP9H0+bVq
         uvNEt7NA+kMHhJ2+knj427U1LLSLIX/b+6ZUDVkqk2ubdSoPj+yk+iAEyo9j0T9rpOQL
         xRnRkAPfMFrKHKkTuobjkcvfbWh0uJpMTacYfCkeLDhMokNJ2V73ymPHjYIgAJb/XTrv
         ZKKwlEQ2upCaq0XXfTBtpWptD7orhBAuUCRBk1tA5FD1U4UDE4ShdUxRijIjrFwugjIw
         6ifPrrPl6VXCx6dKysTqFSiI2OK5FUgcEulBUWol/W2tLJjuHhXGmYYT+5EQZ3zYHgvl
         Lb3g==
X-Gm-Message-State: AGi0PuYufqPYIDGbyXQusVhN89sbSSOCvzMhgOUCTs4enzOg4HSPxSUP
        FCqYPEYefiKTn0VyqgofzuBpfl5UvLtPbc7rllg=
X-Google-Smtp-Source: APiQypLZ11aosJlu/hpPnEUFREg25O7wHDmbO9gEu9UZD8wwP2GPPmLs2HzJRhADOXJ/nvd3DrRlPnKWNuNy6SH9194=
X-Received: by 2002:a67:6cc3:: with SMTP id h186mr1921616vsc.78.1588672042041;
 Tue, 05 May 2020 02:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <CABatt_wQpbtktD=bXwJCzdm_5aLeHcQrSW2pNMRergC9jZ0sMw@mail.gmail.com>
 <CAHp75Ve9giL99P+4Q+LjcFPKPq4fzXR+8UDPDZpA+sPr0o04cg@mail.gmail.com>
In-Reply-To: <CAHp75Ve9giL99P+4Q+LjcFPKPq4fzXR+8UDPDZpA+sPr0o04cg@mail.gmail.com>
From:   Martin Townsend <mtownsend1973@gmail.com>
Date:   Tue, 5 May 2020 10:47:10 +0100
Message-ID: <CABatt_wbC9sDu04FfG6NNi6P6NzhT6tmm=PHh3VXZhR_=1K03A@mail.gmail.com>
Subject: Re: SPI driver probe problem during boot
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, May 5, 2020 at 9:43 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 5, 2020 at 11:04 AM Martin Townsend <mtownsend1973@gmail.com> wrote:
>
> > I've just finished debugging a SPI comms problem for a TPM device on a
> > TI Sitara AM4372 SoC.  The SPI bus has 3 devices
> >
> > 1) CAN FD Controller 0 (Using native CS)
> > 2) CAN FD Controller 1 (Using GPIO for CS)
> > 3) TPM Device (Using GPIO for CS)
> >
> > All CS are active low.
> >
> > During boot the TPM would fail it's probe but if I unbind and then
> > rebind the driver after boot the TPM would work fine so I got the
> > logic analyser out to probe the SPI bus and could see that the voltage
> > on the MISO line was half the expected voltage whilst the TPM was
> > being probed and this was due to CS0 being driven low for this period
> > of time.  After the TPM was probed the CS0 went high.  After debugging
> > this I found that the OMAP SPI controller defaults internal CS lines
> > to active high so when the SPI master controller is initialised this
> > is the state of CS0 so it's driven low for inactive.  During the probe
> > of the SPI master controller it calls devm_spi_register_master ->
> > spi_register_master which calls of_register_spi_devices which will add
> > the devices to the SPI master controller via spi_add_device.  This
> > function would call device_add. Due to the way the device tree is
> > parsed the SPI devices above are enumerated from the highest CS to the
> > lowest so the TPM device is setup first.  When device_add is called it
> > triggers it's probe function but the SPI bus hasn't been setup yet and
> > hence the TPM driver tries to communicate with the TPM device whilst
> > CS0 is being driven low causing the CAN FD controller to also respond
> > reducing the voltage on the MISO line.  In spi_device_add it calls
> >
> > status = spi_setup(spi);
> >
> > which would setup the CS lines so I modified the
> > of_register_spi_devices function to make it a 2 phase operation so the
> > CS lines are all setup and then it iterates of the SPI devices a
> > second time to add them to the driver model via device_add and the TPM
> > now probes fine.
>
> ...
>
> > Now this is on a oldish kernel (4.12) and moving the kernel forward
> > isn't trivial.  I was just wondering if this has been fixed already so
> > I could backport it, I couldn't see anything in the latest kernel but
> > maybe it has been solved a different way.  If not is there a better
> > way of fixing this? Or is the OMAP SPI controller driver the problem,
> > should it parse the child nodes first and set itself up accordingly?
>
> Can you confirm the issue on v5.7-rc4?
>

I will try but it's not always possible with these embedded SoC's
without a lot of work.

> --
> With Best Regards,
> Andy Shevchenko
