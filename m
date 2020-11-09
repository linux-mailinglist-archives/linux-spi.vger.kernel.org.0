Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2982AC2F6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 18:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgKIR5F (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 12:57:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbgKIR5F (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 12:57:05 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72188C0613CF;
        Mon,  9 Nov 2020 09:57:03 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id 11so11466924ljf.2;
        Mon, 09 Nov 2020 09:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TDdC4VBGfaC0YPU2cbDOK4oEgDaGnWxSotX0J+aYafA=;
        b=tNK0dlAGukcobevD3Ui+HanJ5riK4b1RuGctsi5HUC4wHixUwR1xO8UhDLrhZQrdTY
         /KLcXfNq1bA767lZyiQb6FEtsW2ZhsbJ5SzmVA3x0xPNagUVVQok9UHiyCEGW6iVget6
         l4D2GKlaE1wkwSRVG3AK0D3nY8cvReQ9uQP+rpl3FkJF3m7fovsnpTqkYAYud4C65C4b
         zMJnuZZPzQb+XDbUgja0PPyr8nHS7MFHvQO7OZX1E8cRZoTVCgfMCIvN1a4XbsI6Zh8a
         +ERtWl41HCUZcubdLhor/DRHOvFD2k3d3TMKKKX7XUvhbQcYkdH3OHLk6oHCsIdgJ4lk
         d31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TDdC4VBGfaC0YPU2cbDOK4oEgDaGnWxSotX0J+aYafA=;
        b=omr9lUBOcwi16ibyARv2PywOA+cauqrvIHaDDfp8RByZLkZHFtjBGLaz7RoA/WD58p
         +9v+6zgulb2fSxa27+hAxwj3jKhwYkEwWoWHgCVZpbbrmvt6Gr/1sUD1lex9iFii2xPF
         QneK8z+XMA5rlxl4MY01vTAISKsKO8G/2RQn0I5q6zPREO2eGr5QQ65YYyvC42ynTLuZ
         6wxIO9Fxbud4ir9L0/i+8bVhfSRJKd6ZJlr9KQ+r8L/c88FlXG15PFXCkGRWsBiy0/1s
         8vwKEW/TSm1LzWfkcNRX1vQVnZrdIraEAsPltzZAtHT8+guBJyS3Ac4Qfo0E1RjBsWyD
         llog==
X-Gm-Message-State: AOAM532Y89qk/AspKkjlFlB1+tT2+2NdV+whIFV6+n/CFPB3MTKXF5Ul
        QAZA/MymUjqejCKKWOg8yNj2PksCunQTsvbJ
X-Google-Smtp-Source: ABdhPJwvCfO0zF+eiVJC7NsRyveQflGTHzieevzbazcb7Hmkk2IwVNnSGrnYLDnE/vzo823wANymKA==
X-Received: by 2002:a2e:8e79:: with SMTP id t25mr2425977ljk.133.1604944621826;
        Mon, 09 Nov 2020 09:57:01 -0800 (PST)
Received: from mobilestation ([95.79.141.114])
        by smtp.gmail.com with ESMTPSA id w18sm1813942lfc.5.2020.11.09.09.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:57:01 -0800 (PST)
Date:   Mon, 9 Nov 2020 20:56:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
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
Subject: Re: [PATCH 02/32] spi: dw: Add support for 32-bits ctrlr0 layout
Message-ID: <20201109175659.hqr6qq5qwk4sd775@mobilestation>
References: <20201107081420.60325-1-damien.lemoal@wdc.com>
 <20201107081420.60325-3-damien.lemoal@wdc.com>
 <20201109142529.tt5ojjyn36vd3ohe@mobilestation>
 <CAHp75VeXT8CMumY2fif6eBX0GRWvOV_47rETTbL5Yud+zBV0XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeXT8CMumY2fif6eBX0GRWvOV_47rETTbL5Yud+zBV0XA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Andy,

On Mon, Nov 09, 2020 at 04:36:51PM +0200, Andy Shevchenko wrote:
> On Mon, Nov 9, 2020 at 4:25 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> >
> > Hello Damien,
> > Thanks for your patches. My comments are below.
> >
> > On Sat, Nov 07, 2020 at 05:13:50PM +0900, Damien Le Moal wrote:
> > > Synopsis DesignWare DW_apb_ssi version 4 defines a 32-bit layout of
> > > the ctrlr0 register for SPI masters. The layout of ctrlr0 is:
> > >
> > > |   31 .. 23  | 22 .. 21 | 20 .. 16 |
> > > | other stuff | spi_frf  |  dfs_32  |
> > >
> > > |   15 .. 10  | 9 .. 8 | 7 .. 6 | 5 .. 4 | 3 .. 0 |
> > > | other stuff |  tmod  |  mode  |  frf   |  dfs   |
> > >
> >
> > > Th main difference of this layout with the 16-bits version is the data
> >     ^
> >     |
> >     e
> >
> > > frame format field which resides in bits 16..20 instead of bits 3..0.
> > >
> >
> > Are you sure they have been moved from [0, 3] to [16, 20]? I don't have the
> > manual for the 4.0x version of the core, but according to this patch:
> > https://patchwork.kernel.org/project/spi-devel-general/patch/1575907443-26377-7-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com/
> > it has been ok to use the lowest four bits for DFS setting. Is the commit
> > message misleading there?
> 

> 20:16 DFS_32
> Data Frame Size in 32-bit transfer size mode. Used to select
> the data frame size in 32-bit transfer mode. These bits are
> only valid when SSI_MAX_XFER_SIZE is configured to 32.
> When the data frame size is programmed to be less than 32
> bits, the receive data are automatically right-justified by the
> receive logic, with the upper bits of the receive FIFO zero-
> padded.
> 
> 3:0 DFS
> Data Frame Size.
> This register field is only valid when SSI_MAX_XFER_SIZE
> is configured to 16. If SSI_MAX_XFER_SIZE is configured to
> 32, then writing to this field will not have any effect.
> 
> As far as I can tell it's an extension to the existing one (which one
> in use depends on the SSI configuration).
> 
> 
> The comment you are referring to is about DW_ssi v1.x (vs. DW_apb_ssi v4.x).

Ok. Thanks for clarifying this. Now I see the way it's working.

-Sergey

> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
