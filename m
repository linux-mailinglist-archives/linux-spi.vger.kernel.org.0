Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01BB1150498
	for <lists+linux-spi@lfdr.de>; Mon,  3 Feb 2020 11:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBCKxr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 3 Feb 2020 05:53:47 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39632 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgBCKxq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 3 Feb 2020 05:53:46 -0500
Received: by mail-il1-f195.google.com with SMTP id f70so12202055ill.6;
        Mon, 03 Feb 2020 02:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xA1slDoqBq1wNtrTR0f7nXbBTEQEIlnapNwEpNkpg9g=;
        b=EMf4Er6vqgT1LOu6aLpORiIOn63hrGTH1Ch3gUJjIQPtn4zvJLO1f4XvBdHLgVMazs
         PCdP5/YS/l7nIqgEai6oruDRAMmnWD9C48rHgg7GWqW37JolnCJq3wE6kna+JVHd2zSe
         agq3KnmnbYp5WkMsKS81aK6SE9V1mTQBvfAWuxAARuia+kwb6QGPqOOBIDIhTa/Wcptt
         kzR938ls/FRk/232pMp8Ox5SVYXE1TlnxUczlSroKOUNxqm7aZRMdKqBTnKG5kSzSn+C
         9qu3NJD23C3BbaNtTrOZa1sw01EQHv6NzfFxRESsTaYnyLSrA1uFEPHHsKoOXFpkhIA0
         fQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xA1slDoqBq1wNtrTR0f7nXbBTEQEIlnapNwEpNkpg9g=;
        b=OxvMyGfxV1KXczUFyE0jQf5IehD5Ecgw5n0Hz/7NeBhgyxC2SF0ZXyVIwzJ7LSz/jf
         ys190/iyfezZmN+sBixaWMbgLg5FfvUJa3jrCGPAaMURRQIyu1XDqoE3sPSFqCWevcZx
         XSHpQsBo1zdJ6jnDertEPRQXS30JrowHPaBi8kuLsHAlLXQOHpl/8emzNgUipE7p4URW
         xJeDCEGCdVZO81s84I9vAxUtoglo44uTq5XJXyQSc2iOD/PdXgPhggTLxctE+RqNfMO6
         iPHYPfFP4g2mYMauznEuuEziLJIMHyOqXH+WZMoqqtFhaLh3yOhYLMWZkdl7YtorhSbL
         jjcw==
X-Gm-Message-State: APjAAAVnVuClf6L8PnkjQ4jo4kMLqGgulc6UI0SYfIcC9sxJq48UxZPS
        r8VyW1MCQcuUuItXWMCJLSpEceT8MIw2gS3D3oypDH5T
X-Google-Smtp-Source: APXvYqwi2e+OZzwE+GaVgXvx0G8DUeuHxSXqJptgRY6pVJihSlOnoWPfMoYbRYTuQT20fciXDKoALEGsg78SgS3s+JY=
X-Received: by 2002:a92:1547:: with SMTP id v68mr20312779ilk.58.1580727225757;
 Mon, 03 Feb 2020 02:53:45 -0800 (PST)
MIME-Version: 1.0
References: <20200202125950.1825013-1-aford173@gmail.com> <20200202125950.1825013-2-aford173@gmail.com>
 <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
In-Reply-To: <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 3 Feb 2020 04:53:34 -0600
Message-ID: <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com>
Subject: Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-spi <linux-spi@vger.kernel.org>, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Feb 2, 2020 at 10:39 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Sun, Feb 2, 2020 at 10:00 AM Adam Ford <aford173@gmail.com> wrote:
> >
> > From: Han Xu <han.xu@nxp.com>
> >
> > Apply patch from NXP upstream repo to
> > dynamically allocate AHB memory as needed.
>
> The commit log could be improved here. What is the motivation for doing this?

My motivation is to get the flexspi on the i.MX8MM to work, and I did
a list of the patches applied on the NXP branch to see what was
applied on top of their 4.19 kernel and this patch series generated
from that list.  Most of the NXP commits are one-line commits, and I
don't know the motivation for what's happening.  NXP did it, and I
know it works on the Flexspi driver.

Maybe Han Xu can comment, since it's really his patch.


adam
>
> > +               if (!f->ahb_addr) {
> > +                       dev_err(f->dev, "failed to alloc memory\n");
>
> There is no need for this error message as the MM core will take care of it.
