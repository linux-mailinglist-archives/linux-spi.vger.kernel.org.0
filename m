Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5070387E86
	for <lists+linux-spi@lfdr.de>; Fri,  9 Aug 2019 17:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436761AbfHIPvp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 9 Aug 2019 11:51:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:53532 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436723AbfHIPvp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 9 Aug 2019 11:51:45 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E1DC928CF3E;
        Fri,  9 Aug 2019 16:51:42 +0100 (BST)
Date:   Fri, 9 Aug 2019 17:51:40 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-spi@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] spi: npcm-fiu: add NPCM FIU controller driver
Message-ID: <20190809175140.77747c8d@collabora.com>
In-Reply-To: <CAP6Zq1hc0kNHzCE6tcLZdv7NcNWEdn5nh=Wzd8pdbZTuj31Hbg@mail.gmail.com>
References: <20190808131448.349161-1-tmaimon77@gmail.com>
        <20190808131448.349161-3-tmaimon77@gmail.com>
        <20190808173232.4d79d698@collabora.com>
        <CAP6Zq1iW0C0FDOoqmn5r_xk5HQFWw+GgLfeapvt-8mB50N2Vvg@mail.gmail.com>
        <20190809172557.346e7c41@collabora.com>
        <CAP6Zq1hc0kNHzCE6tcLZdv7NcNWEdn5nh=Wzd8pdbZTuj31Hbg@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 9 Aug 2019 18:47:08 +0300
Tomer Maimon <tmaimon77@gmail.com> wrote:

> On Fri, 9 Aug 2019 at 18:26, Boris Brezillon <boris.brezillon@collabora.com>
> wrote:
> 
> > On Fri, 9 Aug 2019 18:26:23 +0300
> > Tomer Maimon <tmaimon77@gmail.com> wrote:
> >  
> > > Hi Boris,
> > >
> > > Thanks a lot for your comment.
> > >
> > > On Thu, 8 Aug 2019 at 18:32, Boris Brezillon <
> > boris.brezillon@collabora.com>
> > > wrote:
> > >  
> > > > On Thu,  8 Aug 2019 16:14:48 +0300
> > > > Tomer Maimon <tmaimon77@gmail.com> wrote:
> > > >
> > > >  
> > > > > +
> > > > > +static const struct spi_controller_mem_ops npcm_fiu_mem_ops = {
> > > > > +     .exec_op = npcm_fiu_exec_op,  
> > > >
> > > > No npcm_supports_op()? That's suspicious, especially after looking at
> > > > the npcm_fiu_exec_op() (and the functions called from there) where the
> > > > requested ->buswidth seems to be completely ignored...
> > > >
> > > > Sorry but I do not fully understand it, do you mean a support for the  
> > > buswidth?
> > > If yes it been done in the UMA functions as follow:
> > >
> > >                 uma_cfg |= ilog2(op->cmd.buswidth);
> > >                 uma_cfg |= ilog2(op->addr.buswidth) <<
> > >                         NPCM_FIU_UMA_CFG_ADBPCK_SHIFT;
> > >                 uma_cfg |= ilog2(op->data.buswidth) <<
> > >                         NPCM_FIU_UMA_CFG_WDBPCK_SHIFT;
> > >                 uma_cfg |= op->addr.nbytes <<  
> > NPCM_FIU_UMA_CFG_ADDSIZ_SHIFT;  
> > >                 regmap_write(fiu->regmap, NPCM_FIU_UMA_ADDR,  
> > op->addr.val);  
> > >  
> >
> > Hm, the default supports_op() implementation might be just fine for
> > your use case. But there's one thing you still need to check: the
> > number of addr cycles (or address size as you call it in this driver).
> > Looks like your IP is limited to 4 address cycles, if I'm right, you
> > should reject any operation that have op->addr.nbytes > 4. I also
> >  
> Indeed our IP limited to 4 address cycle (bytes) do we have NOR Flash with
> more than 32bit address?

spi-mem is not only about spi-nor, it can be used for any kind of
memory (NOR, NAND, SRAM, ...) or even to communicate with an FGPA, so
yes, you have to take care of that.

> I will add this limitation thanks!
> 
> > wonder if there's a limitation on the data size you can have on a
> > single transfer. If there's one you should implement ->adjust_op() too.
> >  
> there is a limitation in a single transfer but I handle it in the
> npcm_fiu_manualwrite
> function.
> Do you suggest to use ->adjust_op() instead?

Yes, should be exposed through ->adjust_op() => the caller needs to
know when a new operation (one containing an opcode+address) is issued,
because sometimes such splits are not supported by the memory.

