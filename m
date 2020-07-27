Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8826A22EDCC
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 15:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgG0NsO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 09:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgG0NsN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 09:48:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B464C061794;
        Mon, 27 Jul 2020 06:48:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so8017272plr.8;
        Mon, 27 Jul 2020 06:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NJmzr2KQBRICuAu1pv5/YVfC3bftlzNt8R1cIWx8IbE=;
        b=HGdOixIk+LNjSWHZUK4ATkRjyLKVYX9VDXRfBVLTFUpwXDGNhSj4hugCezPW9Watsx
         DYgDZ6JCFTZY80+LajAIl6hG/xxGlUt9ZyUgDqUdpVo6rBJwHbLJeDk5vXNDNvNc5B2E
         zs0J2SZylYJf7qK0SlBtWgx5evTnK03U1hVPC5Xlyc09IDWm/VQ1utPmgy0u+xM9jmaJ
         f+rhR8xPr3nXDIjYoKPiKCn/sPnMg3KgmFHHQOyy1tIFj00YAkUPvg9klo5iDy87NOyA
         tG7CHXjSi62kGyMvl26Mtc/GCmB2hAWEpTAenN83BgOUn6hgIkZxa32MZ8DXzyZZiwMX
         lEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJmzr2KQBRICuAu1pv5/YVfC3bftlzNt8R1cIWx8IbE=;
        b=DPTRzQZjja9g0WBmK5GZPHdoAeh0OPaEci671ajPiY3viiSPo7+GYykYmZcIMVE6ET
         OBgc3/hXG4k/0w4NmO0i1QYJYBKM9BquRJImBlPbDJG619kG02zwheaPnxng0M1QaLpJ
         7BaOlWSo8aNs8ObME5MJ32s6vgyuUnHq0GSWsYmx1piDErP51kP0iqcxK6J7YNxFxraL
         jM8YOrGFNJATs8Y5mXaqlYfR6athIHn9xlDBDlADuGG/2YsaZBUNuoa3vpo1E2vmAjLg
         sM3oqLUcjcOPYq5IHkyU2luqeX+EI8GGfmIrDfoSKzBs/qSE2hhGkFcWHmm8tK7btxQi
         78Jg==
X-Gm-Message-State: AOAM531HScepw2cHUOOfR6iUpY6RLws/lQhseMQvWvPWAEuUnrjlKY+z
        zDMaEbC21YSn60nCkj1lgEfE7yNUTLIrng==
X-Google-Smtp-Source: ABdhPJymzaESRpyXHYliILrQeceM1V9MDg1bBV/LilZuHpXMR5G3RB1SERXvj8gZzKFTg+PWAatrsg==
X-Received: by 2002:a17:90a:3fc7:: with SMTP id u7mr18805322pjm.231.1595857691850;
        Mon, 27 Jul 2020 06:48:11 -0700 (PDT)
Received: from gmail.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f6sm2551521pfa.23.2020.07.27.06.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 06:48:11 -0700 (PDT)
Date:   Mon, 27 Jul 2020 19:16:46 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] spi: spi-topcliff-pch: drop call to wakeup-disable
Message-ID: <20200727134646.GA114726@gmail.com>
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
 <20200727131742.82289-1-vaibhavgupta40@gmail.com>
 <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 27, 2020 at 04:38:40PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 27, 2020 at 4:21 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> >
> > Before generic upgrade, both .suspend() and .resume() were invoking
> > pci_enable_wake(pci_dev, PCI_D3hot, 0). Hence, disabling wakeup in both
> > states. (Normal trend is .suspend() enables and .resume() disables the
> > wakeup.)
> >
> > This was ambiguous and may be buggy. Instead of replicating the legacy
> > behavior, drop the wakeup-disable call.
> >
> 
> > Fix: f185bcc77980("spi: spi-topcliff-pch: use generic power management")
> 
> Fixes: and missed space.
> 
> Note:
> 
> % grep one ~/.gitconfig
>        one = show -s --pretty='format:%h (\"%s\")'
> 
> % git one f185bcc77980
> f185bcc77980 ("spi: spi-topcliff-pch: use generic power management")
> 
> > Reported by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Missed dash.
> Does checkpatch complain?
No, I got this message:
"* .patch has no obvious style problems and is ready for submission"

I will fix the commit message.

Thanks!
Vaibhav Gupta
> 
> > Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> > ---
> >  drivers/spi/spi-topcliff-pch.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> > index 281a90f1b5d8..c73a03ddf5f3 100644
> > --- a/drivers/spi/spi-topcliff-pch.c
> > +++ b/drivers/spi/spi-topcliff-pch.c
> > @@ -1648,8 +1648,6 @@ static int __maybe_unused pch_spi_resume(struct device *dev)
> >
> >         dev_dbg(dev, "%s ENTRY\n", __func__);
> >
> > -       device_wakeup_disable(dev);
> > -
> >         /* set suspend status to false */
> >         pd_dev_save->board_dat->suspend_sts = false;
> >
> > --
> > 2.27.0
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
