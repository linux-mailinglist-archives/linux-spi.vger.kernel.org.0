Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4CD22C3C9
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jul 2020 12:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGXKwH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Jul 2020 06:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgGXKwH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 24 Jul 2020 06:52:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDA9C0619D3;
        Fri, 24 Jul 2020 03:52:06 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so4239484plr.8;
        Fri, 24 Jul 2020 03:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7f5a4rInq/BtPtGpwaCTr+PuPIYpCg1fDihs8uppVIo=;
        b=II5Iwnr42FE3kJ4/53jooEX/7C2SypD7NhJwWPQOTQ94teQ3uJfjfo4A0wijzqrwGJ
         f6KIgaAIMJLTuyibmpxUlz+SOKINfzcWLugzuXQWSkbVPVIcHp7oz1f2Hao0jen547kj
         w6XStvT2KWFSwmhMVSh2Ks1Agkb4QF0WyMFNsORoHiPgRUVEBGIceqHjCpYYadjnWN0/
         vgSd15vOxAJusmRG9oLBONO6GHIvU5Yc2dsHPdaIWOgSsfrJO4lUNbUqPTbuZbzj9b1b
         NWEMHerEOhn2AJtRUvLg3HI60Citf4bahsPQgfaXhHsm/7BqZSrNyD0pS0td4o9L0Y2A
         T2QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7f5a4rInq/BtPtGpwaCTr+PuPIYpCg1fDihs8uppVIo=;
        b=k+UwWzy3hNKJCoOIHKwjB7drk1qHMPnvt4oapGDHWW2L2GAVNQv50XtX7nebdNGCzO
         57Q+LFUIq4QgTf6hCndQPiushrlc6MFBOxvKysJICEsaieFYX9fHf983a47qAOH1ppTb
         TphloIFy/SrUrEbQRnYF0W64+0YptJc9+4ai2PGzsbvIIG5kClFL8FaLM1VDgkVkFvVc
         VuMRUiLMvwKnqQaS6kW6bybV+ARw9vFG5iWrTW08f2K/3GR776cidL0J5huJkHw5JtAq
         DH93xVUsuWkS+bRedN/m1Rud851ymMFWX2A/ZqLAlASL63FhN6gP+OeuHgetNuQWIlIE
         J9yw==
X-Gm-Message-State: AOAM531skX8oV42ZFufwz1Bq9vtJZOzcXRuna7nOo4pBWpv0tUtc6OL3
        ppgAhkxNbxpHMsRA5kOHB3W67Cj2N4A5uV0dwIY=
X-Google-Smtp-Source: ABdhPJz8LrBxYW2OqSs/hx2X9HhDzRwSse6TRUnaNtTwquxh6eX4lrWDsN0j3dbu6m2pOgOcdMEJ/ghZRx3+aNuXMeM=
X-Received: by 2002:a17:902:b098:: with SMTP id p24mr7899509plr.18.1595587925982;
 Fri, 24 Jul 2020 03:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200720155714.714114-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200720155714.714114-1-vaibhavgupta40@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 24 Jul 2020 13:51:49 +0300
Message-ID: <CAHp75Vdh-ssrmGgTc=gE9dWLhWDAw7_QHJKFeWKHpO-JqBdsEA@mail.gmail.com>
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Jul 20, 2020 at 7:31 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
>
> Drivers using legacy PM have to manage PCI states and device's PM states
> themselves. They also need to take care of configuration registers.
>
> With improved and powerful support of generic PM, PCI Core takes care of
> above mentioned, device-independent, jobs.
>
> This driver makes use of PCI helper functions like
> pci_save/restore_state(), pci_enable/disable_device(), pci_enable_wake()
> and pci_set_power_state() to do required operations. In generic mode, they
> are no longer needed.
>
> Change function parameter in both .suspend() and .resume() to
> "struct device*" type. Use dev_get_drvdata() to get drv data.

> Compile-tested only.

Yeah...

...

> +static int __maybe_unused pch_spi_suspend(struct device *dev)
>  {
> +       struct pch_pd_dev_save *pd_dev_save = dev_get_drvdata(dev);
>
> +       dev_dbg(dev, "%s ENTRY\n", __func__);
>
>         pd_dev_save->board_dat->suspend_sts = true;
>
> +       return 0;
>  }
>
> +static int __maybe_unused pch_spi_resume(struct device *dev)
>  {
> +       struct pch_pd_dev_save *pd_dev_save = dev_get_drvdata(dev);
>
> +       dev_dbg(dev, "%s ENTRY\n", __func__);
>

> +       device_wakeup_disable(dev);

Here I left a result. Care to explain (and perhaps send a follow up
fix) where is the counterpart to this call?

> +       /* set suspend status to false */
> +       pd_dev_save->board_dat->suspend_sts = false;

> +       return 0;
>  }


-- 
With Best Regards,
Andy Shevchenko
