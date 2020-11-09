Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3982ABECB
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgKIOgD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbgKIOgD (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:36:03 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1181FC0613CF;
        Mon,  9 Nov 2020 06:36:03 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c20so8338729pfr.8;
        Mon, 09 Nov 2020 06:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xilNWeTeSex4g4HDHalLR+J43P0h5RyAhWrk/nvF07Q=;
        b=J8lkBhEa8lUdD57OmUPSRsc6XdBOXWf9otsprjZJgrNXX/rtXIY1xlJNBzxgNxADgZ
         KeYdaMBEawlOXDQEyLQpByo3pCD1ouyoWJEMykJVHUeIve8WBerVveYZF0FIXv5UNNkE
         irsMLx2qvu+nMMFkyjNlf+TBXwCliLAaR4s+DcfiQzBY3hMADgKpB24+WRJmziJ+PqAr
         BJV+gbund7ykyY7ZZ27YX1OYGIowgA6+cl2UhwIXYZ9mK1W14flVV6zyxzHbXy5fqO8P
         o4wHWJUcljoscxY2Rj9ad/2YBbVOQBDAKpkFasRt2L61EDvWnFsavoGMnMfsis83Y59L
         85Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xilNWeTeSex4g4HDHalLR+J43P0h5RyAhWrk/nvF07Q=;
        b=kcen3qTdu1Vd/lJlhlKC0KoHeNn/aHIq3dXcuEreX7bqWKw1FEsNqvHrqZx3rqHZR1
         8qL50QEgMnT2AYVYkYY6TpjXkh6U1cD34UvJIVDwiX2IJFHmp0mELl591mTFbsy5sAqJ
         0rZHVLey9wGFYXrcWJXTK3uv964da34lHmXEqTu8T9MdrC+Xo3gOCSis+XFXk/SaSV9v
         +piPF9vehcZkClF1wjpRtOdsWB8BqB53kk3/LpgcQ9uLN5f7T9Qf/STiG+9b5Saf8isp
         4We0j3aDzck4GKMwkG2B6UeYEs9CQEf6bun+qi6+1oy3mhtjXXIUWpKOTnLZZL26yuhK
         1jaw==
X-Gm-Message-State: AOAM532diOtk1+NLH+rMi+4dblWcfrlwMF0E7NY0Jnvl2oEMEHTg1Tki
        rCnZCqYa1i+v79eL+SiojXYeVSCaL0rRR+K9Ans=
X-Google-Smtp-Source: ABdhPJwzwK9MU3KU7H7nhMnajS0MWTHr1ZqqSAX4On6SXXYvXxfNoTYFAoquD737Dk20mtKRVd4egDZF4KTi8c3SJxc=
X-Received: by 2002:a63:4511:: with SMTP id s17mr13056707pga.4.1604932562378;
 Mon, 09 Nov 2020 06:36:02 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-3-damien.lemoal@wdc.com>
 <20201109142529.tt5ojjyn36vd3ohe@mobilestation>
In-Reply-To: <20201109142529.tt5ojjyn36vd3ohe@mobilestation>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Nov 2020 16:36:51 +0200
Message-ID: <CAHp75VeXT8CMumY2fif6eBX0GRWvOV_47rETTbL5Yud+zBV0XA@mail.gmail.com>
Subject: Re: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Anderson <seanga2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 9, 2020 at 4:25 PM Serge Semin <fancer.lancer@gmail.com> wrote:
>
> Hello Damien,
> Thanks for your patches. My comments are below.
>
> On Sat, Nov 07, 2020 at 05:13:50PM +0900, Damien Le Moal wrote:
> > Synopsis DesignWare DW_apb_ssi version 4 defines a 32-bit layout of
> > the ctrlr0 register for SPI masters. The layout of ctrlr0 is:
> >
> > |   31 .. 23  | 22 .. 21 | 20 .. 16 |
> > | other stuff | spi_frf  |  dfs_32  |
> >
> > |   15 .. 10  | 9 .. 8 | 7 .. 6 | 5 .. 4 | 3 .. 0 |
> > | other stuff |  tmod  |  mode  |  frf   |  dfs   |
> >
>
> > Th main difference of this layout with the 16-bits version is the data
>     ^
>     |
>     e
>
> > frame format field which resides in bits 16..20 instead of bits 3..0.
> >
>
> Are you sure they have been moved from [0, 3] to [16, 20]? I don't have the
> manual for the 4.0x version of the core, but according to this patch:
> https://patchwork.kernel.org/project/spi-devel-general/patch/1575907443-26377-7-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com/
> it has been ok to use the lowest four bits for DFS setting. Is the commit
> message misleading there?

20:16 DFS_32
Data Frame Size in 32-bit transfer size mode. Used to select
the data frame size in 32-bit transfer mode. These bits are
only valid when SSI_MAX_XFER_SIZE is configured to 32.
When the data frame size is programmed to be less than 32
bits, the receive data are automatically right-justified by the
receive logic, with the upper bits of the receive FIFO zero-
padded.

3:0 DFS
Data Frame Size.
This register field is only valid when SSI_MAX_XFER_SIZE
is configured to 16. If SSI_MAX_XFER_SIZE is configured to
32, then writing to this field will not have any effect.

As far as I can tell it's an extension to the existing one (which one
in use depends on the SSI configuration).


The comment you are referring to is about DW_ssi v1.x (vs. DW_apb_ssi v4.x).


-- 
With Best Regards,
Andy Shevchenko
