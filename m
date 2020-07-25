Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2384B22D6D5
	for <lists+linux-spi@lfdr.de>; Sat, 25 Jul 2020 12:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgGYKm5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 25 Jul 2020 06:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgGYKm4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 25 Jul 2020 06:42:56 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C071C0619D3;
        Sat, 25 Jul 2020 03:42:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id w17so5825202ply.11;
        Sat, 25 Jul 2020 03:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8yj6Kct27RyPEmd4B9+HfnqqiPVfXDawAuk7rCVsXmM=;
        b=nAacYRx5nwuasDLixWg6vBK+3519KCsjPn5GxOvYK3AeRNBe1K1H1WmXvFGyRUz2+w
         +cfjSPAnrwhH4r4QjkjOxNDisS0Zf1PI8TkNHgzAOpZpm4/FPZDccC8IwbKgzF4m20Hr
         gCHSYm+FsnMQ8Cykp5Dlz13tt52qURJ6PF59gYWtBG83KANBc0BmKmKa7W4fvDu+R25A
         XhCTJcexuEzuJHAVb0Gv1Ja6C8UghIsk/yZmmWQUEY3VqBugd4KZnN58bCs/BbKyKdBA
         aKF+Sofw2avxkIgshsDJl1JbX+eYxw/lOszDBfXHxFVyhO2Rl4Kdr373oBv1DwU4IE3z
         2Nyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8yj6Kct27RyPEmd4B9+HfnqqiPVfXDawAuk7rCVsXmM=;
        b=F3EcM7wKRjhVCD34SXiApuz8N/O9GtneYo1BqOcOFkBBWIWinRfUmPQv4lh3+5wfJS
         zBMdgd0U8f55OmyFkSYUHR7Grf56A97Oa1rV69WM1K0qAAiNg+LxW4chNtzbj/irl+FO
         QVsFv1AnH2DFUlOhY7vM+M2c5Ahu3RTpFjWlO68B+dJkbp0rrwR1ebeGrSxu354noOi0
         huKlEyQGAC8rooHGZy/iQZMUNDUwuzgT6GKSZOSLIBeZ4Dy1xEgVhL/PMLAZ1iB859je
         H3iJVrsvOjHB49jeBXBMko9l5VxYPy09qOcaC+s8R7mnfzonIZSu3jBDBiJUhBdp/052
         D85g==
X-Gm-Message-State: AOAM533e5VKJ2wdY7QL+bJeGSMSSos91RQ3oEpepXH9iqZm3s6iwdhT9
        z9eJoF+BpBAp7WvSigqDjax2ZTfxAZOFHUIcJ4I=
X-Google-Smtp-Source: ABdhPJx5WRgviCW8IQl6IL2G3MFUcyH4KWOWkuJScaNu4y0lij/3WSXu1ghuineZ92WNvK1h/vZVo4AFJACi9u0cqsE=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr7054931pjp.228.1595673776129;
 Sat, 25 Jul 2020 03:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
 <20200724223746.GA1538991@bjorn-Precision-5520>
In-Reply-To: <20200724223746.GA1538991@bjorn-Precision-5520>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Jul 2020 13:42:39 +0300
Message-ID: <CAHp75VdSr1rguc9HJVh_rA1nBh1uyCdr18eyPosWPzCH1K2=zg@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Jul 25, 2020 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Rafael, in case you can clear up our wakeup confusion]
> original patch:
> https://lore.kernel.org/r/20200720155714.714114-1-vaibhavgupta40@gmail.com
>
> On Fri, Jul 24, 2020 at 11:16:55PM +0300, Andy Shevchenko wrote:
> > On Fri, Jul 24, 2020 at 6:17 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> > > On Fri, Jul 24, 2020 at 01:51:49PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Jul 20, 2020 at 7:31 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> >
> > ...
> > > > > +       device_wakeup_disable(dev);
>
> > > >
> > > > Here I left a result. Care to explain (and perhaps send a follow up
> > > > fix) where is the counterpart to this call?
>
> The common pattern seems to be "enable wakeup in suspend, disable
> wakeup in resume".
>
> The confusion in spi-topcliff-pch.c is that it *disables* wakeup in
> both the .suspend() and the .resume() methods and never seems to
> enable wakeup at all.
>
> Maybe there's something subtle we're missing, because all of the
> following are the same way; they disable wakeup in suspend and also
> disable wakeup in resume:
>
>   pch_i2c_suspend    pci_enable_wake(pdev, PCI_D3hot, 0);
>   pch_phub_suspend   pci_enable_wake(pdev, PCI_D3hot, 0);
>   tifm_7xx1_suspend  pci_enable_wake(dev, pci_choose_state(dev, state), 0);
>   pch_can_suspend    pci_enable_wake(pdev, PCI_D3hot, 0);
>   atl1e_suspend      pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
>   atl2_suspend       pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
>   smsc9420_suspend   pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
>   pch_suspend        pci_enable_wake(pdev, PCI_D3hot, 0);
>   pch_spi_suspend    pci_enable_wake(pdev, PCI_D3hot, 0);
>
> And the following are curious because they seem to disable wakeup in
> suspend but don't do anything with wakeup in resume:
>
>   jmb38x_ms_suspend  pci_enable_wake(dev, pci_choose_state(dev, state), 0);
>   rtsx_pci_suspend   pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
>   toshsd_pm_suspend  pci_enable_wake(pdev, PCI_D3hot, 0);
>   via_sd_suspend     pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
>   uli526x_suspend    pci_enable_wake(pdev, power_state, 0);
>
> All of the above *look* buggy, but maybe we're missing something.

Agree!

> My *guess* is that most PCI drivers using generic PM shouldn't do
> anything at all with wakeup because these paths in the PCI core do it
> for them:

That's why in the second message I proposed to drop this ambiguous
call. I think (guess) the same way you are.

>   pci_pm_suspend_noirq             # pci_dev_pm_ops.suspend_noirq
>     if (!pdev->state_saved)
>       if (pci_power_manageable(pdev)
>         pci_prepare_to_sleep(pdev)
>           wakeup = device_may_wakeup(&pdev->dev)
>           pci_enable_wake(pdev, ..., wakeup)
>
>   pci_pm_resume                    # pci_dev_pm_ops.resume
>     pci_pm_default_resume
>       pci_enable_wake(pdev, ..., false)
>
> > > Yes, it seem I forgot to put device_wakeup_disable() in .suspend()
> > > when I removed pci_enable_wake(pdev, PCI_D3hot, 0); from there. It
> > > doesn't seem that .suspend() wants to enable-wake the device as
> > > the bool value passed to pci_enable_wake() is zero.
> >
> > > Am I missing something else?
> >
> > At least above. Either you need to drop the current call, or explain
> > how it works.
>
> > Since you have no hardware to test, I would rather ask to drop an
> > extra call or revert the change.
>
> I'm not quite sure what you mean here.  Vaibhav is converting dozens
> of drivers from legacy PCI PM to generic PM, and of course doesn't
> have any of that hardware, but it's still worth doing the conversion.

See above. Here I proposed two solutions and I'm in favour of the
former (drop the call) rather than latter (do not touch this code).

> If it's a bug that spi-topcliff-pch.c disables but never enables
> wakeup, I think this should turn into two patches:
>
>   1) Fix the bug by enabling wakeup in suspend (or whatever the right
>   fix is), and
>
>   2) Convert to generic PM, which may involve removing the
>   wakeup-related code completely.

Works for me.


-- 
With Best Regards,
Andy Shevchenko
