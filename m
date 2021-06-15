Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F62F3A7A57
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jun 2021 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbhFOJXB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Jun 2021 05:23:01 -0400
Received: from mail-vs1-f46.google.com ([209.85.217.46]:37504 "EHLO
        mail-vs1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhFOJXA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Jun 2021 05:23:00 -0400
Received: by mail-vs1-f46.google.com with SMTP id f21so9421263vsl.4;
        Tue, 15 Jun 2021 02:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0jK2g39WfsSdf60Km6mFt1odDDTr/mSQBmp9dz5+HI=;
        b=Y51Ttck+8Df+Fmwgn1pI71iNoRyawqcuUMikI8u3RIglbha2HMKCJlhMR34A1M/O5P
         VDGdPab2Y/c4zTJWuNAniU8T/PsUsDkXUetQQinX6Hvk4VgAOWxxr1ICNQd/Z1jvHb8G
         GvNGt/4TSbua3mY1UEJaEED/InTOL3/x9oYSe+ILnPqPy96dM8rPaRsjPxvkb+3Wfxbb
         xQ5fHaYA82KHX8+kt/VquJn/yDUC+r4tO4+nLl89NFiymQEckPnF1wJBgpLRopLGwFGc
         xfLFgOGgrZ+NmB9y5tjDYdK66fHhU9jtefxVmBs3Fn28DmKR8rJe0caYsdM/Dp2/IU36
         y63Q==
X-Gm-Message-State: AOAM533fcT4jTx2JNFgaGXmoz68d5AF0xo+TcW1KJYIBtHZceDI/askf
        ZAyU+6dNWa7T8qjlvWrSZ5KOJvizxbuknVu1v+s=
X-Google-Smtp-Source: ABdhPJxFQ31CjllL9V28dyth5O3D9XZ9gTyWpGdc3FXIBH55QiETOOkopgK6U2Q0AISO+RefmXqpi+cLQaGhG2WTzy4=
X-Received: by 2002:a67:3c2:: with SMTP id 185mr3852936vsd.42.1623748856463;
 Tue, 15 Jun 2021 02:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210609071918.2852069-1-gregkh@linuxfoundation.org> <162370043177.40904.7910320297802442191.b4-ty@kernel.org>
In-Reply-To: <162370043177.40904.7910320297802442191.b4-ty@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Jun 2021 11:20:45 +0200
Message-ID: <CAMuHMdX34LNV9Q3Yan_7fxS_CzchghYgoCzLTGNW0opKMgv67A@mail.gmail.com>
Subject: Re: [PATCH] spi: remove spi_set_cs_timing()
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "leilk.liu" <leilk.liu@mediatek.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

CC leilk, Alexandru Ardelean

On Mon, Jun 14, 2021 at 9:55 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, 9 Jun 2021 09:19:18 +0200, Greg Kroah-Hartman wrote:
> > No one seems to be using this global and exported function, so remove it
> > as it is no longer needed.
>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
>
> Thanks!
>
> [1/1] spi: remove spi_set_cs_timing()
>       commit: 4ccf359849ce709f4bf0214b4b5b8b6891d38770
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
