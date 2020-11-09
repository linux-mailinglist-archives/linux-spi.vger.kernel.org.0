Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED32ABEE2
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730582AbgKIOkk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbgKIOkk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:40:40 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1C4C0613CF;
        Mon,  9 Nov 2020 06:40:39 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id i13so2534199pgm.9;
        Mon, 09 Nov 2020 06:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D35EDlDK16EWIltc01Yrg7/CsfVYBQcvvB8Ix+TT1us=;
        b=ip3BVgMKiauzd4a5fsf1ODx3qhmqLy8nttnSg5raPkaWQx8GjNJL+QhxhnUhWds9us
         OZStQB/ulbYJ3bslooxV9GsmwOwtAa6iavQrUWVkWhsZEC5ZcnchA9U7avBEJia20ymF
         /q+3MKFL4RH4/SRzyLE2dFSPINGxmc59RlVXmaKM5XE/YSS8k9oEDn8+81AVro5zT3og
         KHO7qAQm0GlxcFcFCD+QGCRXBUuXLbbk/fUHuCWkUe8zwbjlY3XQXcam+yzU3AdHSdnJ
         dVENfBn4851dtJ3MzTRVjuHOcr2mLKNMKs2dwuLSVJ4/XpyQkgcb/PffPSJV/wqpabv2
         flGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D35EDlDK16EWIltc01Yrg7/CsfVYBQcvvB8Ix+TT1us=;
        b=gD3/FfYzZ5/j4WoCbM643aGwdy0ZdMEFdXzMY5ij3BIBDrnDneFKFeVsaEMrMQpX7w
         LC6F9WFhoyjEybYoVfQidzMFA0ivroyy3cOThMcK1t3McucqzckpcBS0OgOPQjt1dES4
         n19TEg//tzYtr6CRvNcv6XDR7ZrNuoSQeH4dw0XCJtFrq0vTrbWkzNeyJx0Vxv8sksqG
         XOewVgWT9M2jJWMt49U2sSHpUJIrqHxjOUowRGGeXKEhJpWnNtMPZcExuQuwOWjJqgkb
         LLgOq9T5IUofKOb0gY6fXTpq/GAuI5ezmzIVh+t7i2brseGVOpBvQklu83Fl+yRjoCUW
         cVkQ==
X-Gm-Message-State: AOAM533oZtDEGdCSK3H00goMy9xe5/E2p+np8OQ6CpRBL9HlIspvdad2
        5wDwQAihMbISONSfRGDRxrxAHZ8n3hx6Z/jEvBM=
X-Google-Smtp-Source: ABdhPJxYLSKMi85uilQdG9UgvG5aiuKo/w+WnpjA83tGtKFNeV1eTUaT5WzTkYcsgycY2IhuNNcZK/y5O7B7qM4p5C8=
X-Received: by 2002:aa7:8c4f:0:b029:18b:f361:4aa3 with SMTP id
 e15-20020aa78c4f0000b029018bf3614aa3mr7824997pfd.73.1604932839518; Mon, 09
 Nov 2020 06:40:39 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-3-damien.lemoal@wdc.com>
 <20201109142529.tt5ojjyn36vd3ohe@mobilestation> <6dc6d52e-a39d-c351-5280-71b9e8eafe37@gmail.com>
 <CAHp75VejtoTRAM1JmGib3OaJwzuw9Bb-qb08+XhdZUOuzTGUKw@mail.gmail.com>
In-Reply-To: <CAHp75VejtoTRAM1JmGib3OaJwzuw9Bb-qb08+XhdZUOuzTGUKw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Nov 2020 16:41:28 +0200
Message-ID: <CAHp75Vc+h5PCqBUnyFshw8RE4zWusE+zdvKKSxBxfFw1_5k0vQ@mail.gmail.com>
Subject: Re: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
To:     Sean Anderson <seanga2@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
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
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, Nov 9, 2020 at 4:40 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Nov 9, 2020 at 4:34 PM Sean Anderson <seanga2@gmail.com> wrote:
> > On 11/9/20 9:25 AM, Serge Semin wrote:
> > > On Sat, Nov 07, 2020 at 05:13:50PM +0900, Damien Le Moal wrote:
>
> ...
>
> > > Are you sure they have been moved from [0, 3] to [16, 20]? I don't have the
> > > manual for the 4.0x version of the core, but according to this patch:
> > > https://patchwork.kernel.org/project/spi-devel-general/patch/1575907443-26377-7-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com/
> > > it has been ok to use the lowest four bits for DFS setting. Is the commit
> > > message misleading there?
> >
> > This commit message is a truncated version of [1].
>
> I don't see how they are related.

For DW_ssi v1.x DFS is always for transfers up to 32-bit.

> > Importantly, DFS is
> > valid when SSI_MAX_XFER_SIZE=16. When it =32, then DFS_32 must be used
> > (since DFS is constant 0xF). Since SSI_MAX_XFER_SIZE is a synthesis
> > parameter, there exist devices where DFS must be used, and also where
> > DFS_32 must be used.
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20201016225755.302659-10-seanga2@gmail.com/



-- 
With Best Regards,
Andy Shevchenko
