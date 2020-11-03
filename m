Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E742A3DB2
	for <lists+linux-spi@lfdr.de>; Tue,  3 Nov 2020 08:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbgKCHbD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 Nov 2020 02:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCHbD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 Nov 2020 02:31:03 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65476C0617A6;
        Mon,  2 Nov 2020 23:31:03 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id e2so11735394wme.1;
        Mon, 02 Nov 2020 23:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7KgVirmbvdIiMP21lEZ8ftkXaG9MKlrI/k0Ihfcw+g0=;
        b=R4eovI3sazeMepUekKxQCQLY9UEJRs1DIZjvUfZFzNXzhw1rtq7bgCxkajL5B6AmOi
         Uf8zidW1HxXGIKtok6YhpF0Bdbmp7uGOM3PMtrSmi7H/YktZUViNF1LqH2s68uXPoLec
         J8MD5mVuwuqt4wMi/aUR4Raq2zz0yb83ldKo3vaFssYFrciaAfRdv5X7frYVUZKo/jzM
         0/a9vqqbCb+2zdQIxkxpI5eU7iktXN2FxIC93Jyjoeu5TjYZLR+CAhFgLGvtf1ZsZ1bv
         J8J/5voz2dVgt/XHt6CO9c3kAM5VBtRxGnm9bv9oqA6CG2T6DekL+7YxFyNhRdfqqG3f
         kajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7KgVirmbvdIiMP21lEZ8ftkXaG9MKlrI/k0Ihfcw+g0=;
        b=IB+DnCC9XeP9IV5dLO8DeIBWPrljrfZz/uBsThnZN/RfJzvR+5mFXvhyzkp2liCpVv
         Zq1JvFx7NCbb1i/Jj3OVMnqnn3oqc/5vsgY4qKWZM2tUITV+KurgJmkQd8z9zTovYWGs
         fDyCseduYPc4o9ZaLF6/iqLWJQm/9slat6GgZpqU9ejCbWXw6ow9XGiuvpQWiCVg84hb
         Lfwxad977EWLITZorHfghhDAoSEAtMhnIIM1rqJ6Jlfx/pr8gjSfy+UOYgZLE9pXdoZI
         RUCWfj9opKpAE4pVM2XCo8myRjFmuKPvS82g8QnT1TZp4S7db2O3vDcOcHbYY3f0h3+P
         oAzg==
X-Gm-Message-State: AOAM532vQJz35As5+m/iN0EiGwplV5zGP9dd5U1BsM8cVufxNRn/Pgvy
        sL7DesW008sEGAM6WHBEQx4o40M/lcEMDImH2lo=
X-Google-Smtp-Source: ABdhPJyQuxIP7zvHcr0dRqq4ygWppTBvZDNvhkaBROTmomAM7Tb/4rdgwTp0AMagODSWCVuSHcPtZaTU3K3Dcnl3kuk=
X-Received: by 2002:a1c:61c2:: with SMTP id v185mr1987039wmb.152.1604388660534;
 Mon, 02 Nov 2020 23:31:00 -0800 (PST)
MIME-Version: 1.0
References: <20201102112239.19218-1-zhang.lyra@gmail.com> <20201102181655.GC5014@sirena.org.uk>
In-Reply-To: <20201102181655.GC5014@sirena.org.uk>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 3 Nov 2020 15:30:24 +0800
Message-ID: <CAAfSe-tLpfFzCTzANspxAUVLus2UbWRZ3e6Ut0dx-geoKiuNEw@mail.gmail.com>
Subject: Re: [PATCH] spi: add runtime PM for transfer_one_message
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bangzheng Liu <bangzheng.liu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 3 Nov 2020 at 02:17, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 02, 2020 at 07:22:39PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
>
> > Before transfer message, spi devices probably have been in runtime suspended,
> > that would cause the kernel crash on some platforms once access spi
> > registers, such as on Unisoc's SoCs. The spi devices can be suspended
> > until message transfer completed.
>
> This commit message is a bit hard to follow so I don't really understand
> what the issue is.  We only ever call transfer_one_message() from within
> __spi_pump_messages() which already handles auto_runtime_pm so I'm not
> seeing the situation where we might get to transfer_one_message()
> without having already runtime resumed the controller.  What exactly is
> the error situation here?  This code has been around for a while and I'm
> not aware of reports of issues here and I can't see anything unusual
> that the Spreadtrum driver is doing.

With further tests and looking into this part of code, the problem we
found recently on our platform which runs kernel 4.14 can be fixed by
this commit [1].
In a word,  there's no issue here indeed, this patch should be
ignored, sorry for the noise and thanks for your review.

Chunyan

[1] https://lkml.org/lkml/2019/10/30/173

>
> Also why are we doing this in transfer_one_message() where it will only
> work for controllers using that?  If we're missing runtime PM in some
> paths then presumably controllers with a custom implementation are also
> going to be affected as well, auto_runtime_pm is supposed to work for
> them as well.
