Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F4717FA28
	for <lists+linux-spi@lfdr.de>; Tue, 10 Mar 2020 14:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgCJNDI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Mar 2020 09:03:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37500 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730512AbgCJNDI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Mar 2020 09:03:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id b23so8187358edx.4;
        Tue, 10 Mar 2020 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=txJ2cabPVl0jNbK99cKi2MZdmVuZqf+PAM3YUt+WpY0=;
        b=VPL1NDv9zsW2c/LoCdV3gm5ieOYlrqgDNUr2BxgqH0xen76hbXhEV588sgY5SwH4rB
         8E+cNUFwBI/RLNrdyXdAkkUGv+dK0ZcLvhT5ho+YckBFlqWDjgHKp2haa2BHow7SOHOX
         g7khzdPorVpRMuK4/6es/gQPuaHSF6GjklyuqO6h2cQARwrDPi/OESYRrS3DqvywlJtl
         R8lOOQvMErIjUUeB4/0CH6svMffjPT721SaIH5u90x+PamecPO9qiLUEJyX3dGrMVrYw
         tvHCePkp7A/KgtOGc/U9LfRdGRNXdzY00SKxkMtQlgI02WbI/bqfp1CVUMqAKftgyjks
         +pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=txJ2cabPVl0jNbK99cKi2MZdmVuZqf+PAM3YUt+WpY0=;
        b=CrIt8CMt7EzfXpQg+srJFd87pCngWm8fMD0hxxi47K6WA61OxALpZGiYqXOLVpads/
         Ii5TfWXUwk42I3uQpiI2SeLN8kAIw1s/RSjwojC5SDlxpCBrIROAdtEavZo5CoBkGjEC
         NY4mSlfnVjEZCbTiS5P9z0C9VT3tiQV8rohNRqG3n+FLJKR4b6Rt6OxMIZCi9RP/qL6q
         SjOQ44DRi9LZYl5HU1t09Na89iZTh8fHx81kV3FAP/LYv94RwV3lVdlwqnFSWt8a0nnM
         4X8s15E0zAKabvRjjUbead0pmyGhfBtDwq9bC0Wd+rcGbcwBikpAfhJJuYbeU6NfJC73
         emPQ==
X-Gm-Message-State: ANhLgQ0HkZ9Hi7X6mHYRe0mCTHJvFYiLDH6sva0bl3HdpU2I5tEJAMeY
        CObENGSrOGQoomPKQ6aTZs1FSeg+KpqPp2n8reg=
X-Google-Smtp-Source: ADFU+vs1w/5RE3liVq1Q7Pwg+zThawzvWjAb6j9Up4XFrDqRv545heteU8xxTv5jyHqAFCgssspoHkmUJvkcPk9tIbE=
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr19753036ejj.6.1583845381759;
 Tue, 10 Mar 2020 06:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200310073313.21277-1-michael@walle.cc> <4beb5200a76f2d817be7276444543de4@walle.cc>
 <ea6ffa30ddc2459d07935e5e61a41172@walle.cc>
In-Reply-To: <ea6ffa30ddc2459d07935e5e61a41172@walle.cc>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Tue, 10 Mar 2020 15:02:50 +0200
Message-ID: <CA+h21hqMoPhbq8YG0UeV1kP0iXApYsJvb9MZjPGX54dm2U-KnQ@mail.gmail.com>
Subject: Re: [PATCH] spi: spi-fsl-dspi: fix DMA mapping
To:     Michael Walle <michael@walle.cc>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 10 Mar 2020 at 10:12, Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-03-10 08:40, schrieb Michael Walle:
> > Am 2020-03-10 08:33, schrieb Michael Walle:
> >> Use the correct device to request the DMA mapping. Otherwise the IOMMU
> >> doesn't get the mapping and it will generate a page fault.
> >>
> >> The error messages look like:
> >> [    3.008452] arm-smmu 5000000.iommu: Unhandled context fault:
> >> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
> >> [    3.020123] arm-smmu 5000000.iommu: Unhandled context fault:
> >> fsr=0x402, iova=0xf9800000, fsynr=0x3f0022, cbfrsynra=0x828, cb=8
> >>
> >> This was tested on a custom board with a LS1028A SoC.
> >
> > Oh fu.. please disregard this patch. DMA mapping still isn't working.
> > Somehow I missed that the transfer mode was turned back to its default
> > XSPI mode.
>
> Damn. I need more coffee.. this patch IS working. Only the first probe
> fails due to EPROBE_DEFER.
>
> [    2.539706] fsl-dspi 2120000.spi: rx dma channel not available (-517)
> [    2.546200] fsl-dspi 2120000.spi: can't get dma channels
> [    3.622774] spi-nor spi1.0: w25q128fw (16384 Kbytes)
>
> -michael

I'm testing LS1028A with IOMMU_DEFAULT_PASSTHROUGH=y and I didn't have
time to change my setup now. I've also sent a v3 to my patch series
which is going to conflict with this one, sorry. I would have picked
your patch up with my series but I didn't have the right environment
to test it.

Thanks,
-Vladimir
