Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32F22ED95
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbgG0Ni5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 09:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729069AbgG0Niz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 09:38:55 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B792DC0619D2;
        Mon, 27 Jul 2020 06:38:55 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t6so8012917plo.3;
        Mon, 27 Jul 2020 06:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ocZOH/qAxVzRpNDtMIHAj3P48sK/ccO+2zMNnR18J60=;
        b=sRkfP9q3WiUQNGxVKytVTA1DxMULQ/VpKMX43DZfHIchAb8n8WZeFwIcz7WFSx0GFt
         I5pi6jULLnS1k1rcTUtnuCjfKn8GD6VSztgUjZn9iTnNr7DF8cjShczCSXPemWLuhBnD
         VhJSQPrl6F00RB7O1eum8MXUk4H/LrqTYmyFSz/nF9V50sABvZvWSLb2UQVS6g0itTzs
         AY2rx0Dt51Q8dTGMOt3kjZ55kmGjxOCkBJo+67SJbdRoWXvmWiAkpXqBYirPmMq+6pGy
         H/b0GRm473V71yIkzP5jGOgWdLFNP2gAtrlyNVxmhTwKs7lQKXF+ULCG3jdkDviFE2Kr
         UPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocZOH/qAxVzRpNDtMIHAj3P48sK/ccO+2zMNnR18J60=;
        b=PZCHAFukM3ocBNzung60vQSSkDWhwCLuscQWJIafyJLitRJsC9Bg6b+/irzkVcEuvO
         no8jNCrv353Q+s535tCO36fuVpJO6gA88JQwNe/0dTj3QPZqpL8bBZCBxYg14lovVI7d
         sl+XMuyDlSETOIQQfpxYK9o3Q1lT5jB8SO2eIcH/nAxq9KGpD8/SkPLgiQPaRRYxM+YF
         jDvJRu4HU84/GUk2CVwf6jIS9qK/eXLNdR6tV/1xyglOwcNfjwEhEoa0uDyvF83Vjqyt
         1QQj14fKtVOHFwdqj11EQDcZu+Z/147O6x9bcv2vY7MdfAkiMT/4lkEl29lgwAMAKPwM
         jgXw==
X-Gm-Message-State: AOAM530nLEjArBy0v3gDWeQUcUE0mpKGfKjo+N9BoBepEKMcuuyigVmN
        qxLduY3Xc0nHR/BZl0cNKBt5P09cyEmVEO3BrywVlyJrgAk=
X-Google-Smtp-Source: ABdhPJwaumQ02E9kw/pSB9Ks/8s/ndn264SasBMVkqJLVdv2Odq4jIRDRFnIFEdRIJwqqZ6RH6bxyj0fK/UPvLukTjo=
X-Received: by 2002:a17:90a:a393:: with SMTP id x19mr16574129pjp.228.1595857135248;
 Mon, 27 Jul 2020 06:38:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vdo22ofbCktupFYbfYy6PQ609fsk5B6u2b3FpfKxs8OQg@mail.gmail.com>
 <20200727131742.82289-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200727131742.82289-1-vaibhavgupta40@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 16:38:40 +0300
Message-ID: <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
Subject: Re: [PATCH v2] spi: spi-topcliff-pch: drop call to wakeup-disable
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

On Mon, Jul 27, 2020 at 4:21 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
>
> Before generic upgrade, both .suspend() and .resume() were invoking
> pci_enable_wake(pci_dev, PCI_D3hot, 0). Hence, disabling wakeup in both
> states. (Normal trend is .suspend() enables and .resume() disables the
> wakeup.)
>
> This was ambiguous and may be buggy. Instead of replicating the legacy
> behavior, drop the wakeup-disable call.
>

> Fix: f185bcc77980("spi: spi-topcliff-pch: use generic power management")

Fixes: and missed space.

Note:

% grep one ~/.gitconfig
       one = show -s --pretty='format:%h (\"%s\")'

% git one f185bcc77980
f185bcc77980 ("spi: spi-topcliff-pch: use generic power management")

> Reported by: Andy Shevchenko <andy.shevchenko@gmail.com>

Missed dash. Does checkpatch complain?

> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/spi/spi-topcliff-pch.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> index 281a90f1b5d8..c73a03ddf5f3 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -1648,8 +1648,6 @@ static int __maybe_unused pch_spi_resume(struct device *dev)
>
>         dev_dbg(dev, "%s ENTRY\n", __func__);
>
> -       device_wakeup_disable(dev);
> -
>         /* set suspend status to false */
>         pd_dev_save->board_dat->suspend_sts = false;
>
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
