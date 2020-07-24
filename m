Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D174922D1DA
	for <lists+linux-spi@lfdr.de>; Sat, 25 Jul 2020 00:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgGXWht (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 18:37:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726154AbgGXWht (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Jul 2020 18:37:49 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF439206EB;
        Fri, 24 Jul 2020 22:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595630268;
        bh=zxwr+36uT8ubeqQoSb23nE4JB8UimJF+iQqfxvEF9FY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=knGAAh2upW0BFnDQwYIiXAZ3Ff7raBKnQ4IlptMZBVuCFXlSHptY+MTfJ35tkaIFH
         Jq88j1WDBy1Z4RgGvaLeGRmLMLk584oX7SdMB/0yCmfMDNaImOjmsl0l05PVzNHSx9
         w5lvfgVYFUL9qj4V1/sbAkxlvZseRM5fmTudm+tI=
Date:   Fri, 24 Jul 2020 17:37:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
Message-ID: <20200724223746.GA1538991@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

[+cc Rafael, in case you can clear up our wakeup confusion]
original patch:
https://lore.kernel.org/r/20200720155714.714114-1-vaibhavgupta40@gmail.com

On Fri, Jul 24, 2020 at 11:16:55PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 24, 2020 at 6:17 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> > On Fri, Jul 24, 2020 at 01:51:49PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jul 20, 2020 at 7:31 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
> 
> ...
> > > > +       device_wakeup_disable(dev);

> > >
> > > Here I left a result. Care to explain (and perhaps send a follow up
> > > fix) where is the counterpart to this call?

The common pattern seems to be "enable wakeup in suspend, disable
wakeup in resume".

The confusion in spi-topcliff-pch.c is that it *disables* wakeup in
both the .suspend() and the .resume() methods and never seems to
enable wakeup at all.

Maybe there's something subtle we're missing, because all of the
following are the same way; they disable wakeup in suspend and also
disable wakeup in resume:

  pch_i2c_suspend    pci_enable_wake(pdev, PCI_D3hot, 0);
  pch_phub_suspend   pci_enable_wake(pdev, PCI_D3hot, 0);
  tifm_7xx1_suspend  pci_enable_wake(dev, pci_choose_state(dev, state), 0);
  pch_can_suspend    pci_enable_wake(pdev, PCI_D3hot, 0);
  atl1e_suspend      pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
  atl2_suspend       pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
  smsc9420_suspend   pci_enable_wake(pdev, pci_choose_state(pdev, state), 0);
  pch_suspend        pci_enable_wake(pdev, PCI_D3hot, 0);
  pch_spi_suspend    pci_enable_wake(pdev, PCI_D3hot, 0);

And the following are curious because they seem to disable wakeup in
suspend but don't do anything with wakeup in resume:

  jmb38x_ms_suspend  pci_enable_wake(dev, pci_choose_state(dev, state), 0);
  rtsx_pci_suspend   pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
  toshsd_pm_suspend  pci_enable_wake(pdev, PCI_D3hot, 0);
  via_sd_suspend     pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
  uli526x_suspend    pci_enable_wake(pdev, power_state, 0);

All of the above *look* buggy, but maybe we're missing something.

My *guess* is that most PCI drivers using generic PM shouldn't do
anything at all with wakeup because these paths in the PCI core do it
for them:

  pci_pm_suspend_noirq             # pci_dev_pm_ops.suspend_noirq
    if (!pdev->state_saved)
      if (pci_power_manageable(pdev)
        pci_prepare_to_sleep(pdev)
	  wakeup = device_may_wakeup(&pdev->dev)
	  pci_enable_wake(pdev, ..., wakeup)

  pci_pm_resume                    # pci_dev_pm_ops.resume
    pci_pm_default_resume
      pci_enable_wake(pdev, ..., false)

> > Yes, it seem I forgot to put device_wakeup_disable() in .suspend()
> > when I removed pci_enable_wake(pdev, PCI_D3hot, 0); from there. It
> > doesn't seem that .suspend() wants to enable-wake the device as
> > the bool value passed to pci_enable_wake() is zero.
> 
> > Am I missing something else?
> 
> At least above. Either you need to drop the current call, or explain
> how it works.

> Since you have no hardware to test, I would rather ask to drop an
> extra call or revert the change.

I'm not quite sure what you mean here.  Vaibhav is converting dozens
of drivers from legacy PCI PM to generic PM, and of course doesn't
have any of that hardware, but it's still worth doing the conversion.

If it's a bug that spi-topcliff-pch.c disables but never enables
wakeup, I think this should turn into two patches:

  1) Fix the bug by enabling wakeup in suspend (or whatever the right
  fix is), and

  2) Convert to generic PM, which may involve removing the
  wakeup-related code completely.

Bjorn
