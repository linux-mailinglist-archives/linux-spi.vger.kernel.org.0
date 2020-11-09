Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDD2ABEDB
	for <lists+linux-spi@lfdr.de>; Mon,  9 Nov 2020 15:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbgKIOjR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Nov 2020 09:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbgKIOjQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 9 Nov 2020 09:39:16 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBFBC0613CF;
        Mon,  9 Nov 2020 06:39:16 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id 62so7288366pgg.12;
        Mon, 09 Nov 2020 06:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ffm6KC46cKGPhajXyegh9kwdKAZi/LxDhZRupkk2+WY=;
        b=PdsNeHrU36CbnidyPH8nvMrCkCSnvDbNdbChvGCp+msYDwsHcoUJGPstS2hIVBQDa9
         YIjzAfq1oqLdyBzuuGaQHjFM8qGqbhOZWKBHma84Q1uya0ewxyFniachwstu5CaDMnaf
         e0FTzvQXJbNuEyoAqqGbziv8jJoQPEu0PxOiWiI+2vRse/OHFGGC4X6Z+K/injdbIVPI
         n9bvHahef0K69VyBY4Wu9KkQxZDoURTu0TkyMp+HjTJmVZxzuQXAz3HS4WVfsPLR9hrU
         LO3ey6mxgLr9apMEegIyRzrJT9j4cW0Dqc5sqAsvkw+gO0Jz2HguGIvGvz+EGeRaT9aV
         wS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ffm6KC46cKGPhajXyegh9kwdKAZi/LxDhZRupkk2+WY=;
        b=dumdme/CVwxBlPsgMgK2JrBaoT5NCW/oxWx9kU48sgssMvHkWJJI0zFqYhlVvxvNGh
         BQ8xCnaqb2EhSXgm94nFF9A4hpxRC39U/0BmgRCrqHHpdV5sDqGTLbLoS18pgmTtr/vG
         hOnynJ3UqNje04Xp4sR7I4dm+YlSWKrZ0lvd1w1Lp+6iKDzN34zxohO2zMlkOUrChWey
         rmeVgTcqPjddFlDXec1qYcJS4/YpjMVfIOd+d/77sgq4vGYQsZqN+5KbM1Ek1LANYLZ1
         aLDtxfuQ3FgptPmUnxhd3PCgSmdSw7HfjEVgSKrmjLjxMHbRb4/r3Yw+wy4LFZyV9XvI
         IqMQ==
X-Gm-Message-State: AOAM530AJOTdOLaynw4XucHorM5M2TsweYAoY793mlcytAZ2ABF7US2L
        YiNKUNbL4SQ2yBqzg4LflSK1U250pHD87iXb2zw=
X-Google-Smtp-Source: ABdhPJyJOrsPckCzGNxst/26rQDteMKaKBS2MMunYNWtaF3z18NtyEmQgctYOprlHcSmFeVQ0WNOf3A38nQUhfWYJV8=
X-Received: by 2002:aa7:8c4f:0:b029:18b:f361:4aa3 with SMTP id
 e15-20020aa78c4f0000b029018bf3614aa3mr7819210pfd.73.1604932755994; Mon, 09
 Nov 2020 06:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20201107081420.60325-1-damien.lemoal@wdc.com> <20201107081420.60325-3-damien.lemoal@wdc.com>
 <20201109142529.tt5ojjyn36vd3ohe@mobilestation> <6dc6d52e-a39d-c351-5280-71b9e8eafe37@gmail.com>
In-Reply-To: <6dc6d52e-a39d-c351-5280-71b9e8eafe37@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 Nov 2020 16:40:04 +0200
Message-ID: <CAHp75VejtoTRAM1JmGib3OaJwzuw9Bb-qb08+XhdZUOuzTGUKw@mail.gmail.com>
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

On Mon, Nov 9, 2020 at 4:34 PM Sean Anderson <seanga2@gmail.com> wrote:
> On 11/9/20 9:25 AM, Serge Semin wrote:
> > On Sat, Nov 07, 2020 at 05:13:50PM +0900, Damien Le Moal wrote:

...

> > Are you sure they have been moved from [0, 3] to [16, 20]? I don't have the
> > manual for the 4.0x version of the core, but according to this patch:
> > https://patchwork.kernel.org/project/spi-devel-general/patch/1575907443-26377-7-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com/
> > it has been ok to use the lowest four bits for DFS setting. Is the commit
> > message misleading there?
>
> This commit message is a truncated version of [1].

I don't see how they are related.

> Importantly, DFS is
> valid when SSI_MAX_XFER_SIZE=16. When it =32, then DFS_32 must be used
> (since DFS is constant 0xF). Since SSI_MAX_XFER_SIZE is a synthesis
> parameter, there exist devices where DFS must be used, and also where
> DFS_32 must be used.
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20201016225755.302659-10-seanga2@gmail.com/


-- 
With Best Regards,
Andy Shevchenko
