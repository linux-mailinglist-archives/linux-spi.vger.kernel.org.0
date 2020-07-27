Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3322F8F1
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 21:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgG0TV0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 27 Jul 2020 15:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgG0TVZ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 27 Jul 2020 15:21:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F906C061794;
        Mon, 27 Jul 2020 12:21:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so10458260pgf.0;
        Mon, 27 Jul 2020 12:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gv1At7xomxbSkiHEMMp/MdVQGHl3xOeUcLOgVXl9jaM=;
        b=QPX8niCszCEYxpgHRA5feQ/5WYif4D6kceFBFbLizenbe1uHxoE95G8CQl0uVw6dVx
         iWI628gC8Auh8f2Sn2cYTiODS3rtto/PqyyXjC4aqXyPIQh2GRwnPvB78GrTYsdaW5Qk
         kCIR6b/geTpTRscY3wkdoVzf3PMZa135FxFeKrN8PYWdYPhwd2hOznrO0iMhyDSRmjc3
         O8aU3acP5lYmqS8KuElcP4uMhYjfaYoOxP6h1RFFlRlhvKj2XnPubCw1XDHHAHFSHoDa
         yUCtjmJXR+54EuDPRAeKkjeamRrM9si89qDs3TP3fkvV3+yS7Xnt+00eZ1EHkLgmP+7Y
         hAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gv1At7xomxbSkiHEMMp/MdVQGHl3xOeUcLOgVXl9jaM=;
        b=mzjln8AkR/+tHdNx92P0ohvgu6zUsRr8kBPwSYJpxgo8d5fZGyXL3DHsZQlEUnxVSs
         d49ttDTGZQuNjXzM4fro9ovqmuR+sCDD/cTGYHovyxGZRuXM2ahBeX8rh9RDbxNjHYHb
         lfnA7BhpSXyyabz+qqF9KtM1pgbyk5+Q2JkXfbGqQInlu0OcY4NSASgCidGb5owEML+7
         FtI9reKGL6hh9mQDrbBszFTqoFxEt1AWyXmqJoCDsF7kNHFQBJoSwSxj1oMMhnlaDMMV
         5RgW41a45VY2G2PPlyn5vVokSKmnBpAazdIsVqN4KzBlZldEMRj2zxPZRxoSx3j6lOO/
         pzpg==
X-Gm-Message-State: AOAM530QKlt2pH6nZSJUuj3MYEgkBt7prPcF9WQfm3VPJGNYpfmAefav
        yGVbNFaR/8MUILu3XGI9eAyE+/BJ+KcuQlHHodk=
X-Google-Smtp-Source: ABdhPJyfSvzZi2vRzSnEZEjBLSS9LyzO6gG6U0zP8zFBEhZmoVNYvIwmuUBctF5HQlx29j1LFbs3SnGVTiMNfMgihp0=
X-Received: by 2002:a63:a05f:: with SMTP id u31mr20695620pgn.4.1595877685130;
 Mon, 27 Jul 2020 12:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfmKvAy6bSk70g3c2qJcUzzo0AUhzxR6dFja+ZppGMLRg@mail.gmail.com>
 <20200727172936.661567-1-vaibhavgupta40@gmail.com>
In-Reply-To: <20200727172936.661567-1-vaibhavgupta40@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 22:21:08 +0300
Message-ID: <CAHp75VfdNJqviZgbsG5mQdFKVa_0Cu8nhT5L_hgKsgPB6gutoA@mail.gmail.com>
Subject: Re: [PATCH v3] spi: spi-topcliff-pch: drop call to wakeup-disable
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

On Mon, Jul 27, 2020 at 8:32 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
>
> Before generic upgrade, both .suspend() and .resume() were invoking
> pci_enable_wake(pci_dev, PCI_D3hot, 0). Hence, disabling wakeup in both
> states. (Normal trend is .suspend() enables and .resume() disables the
> wakeup.)
>
> This was ambiguous and may be buggy. Instead of replicating the legacy
> behavior, drop the wakeup-disable call.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks!

> Fixes: f185bcc77980 ("spi: spi-topcliff-pch: use generic power management")
> Reported-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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
