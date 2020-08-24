Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E495424FD6E
	for <lists+linux-spi@lfdr.de>; Mon, 24 Aug 2020 14:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgHXMEp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 24 Aug 2020 08:04:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45206 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgHXMEp (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 24 Aug 2020 08:04:45 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 863A729903F;
        Mon, 24 Aug 2020 13:04:42 +0100 (BST)
Date:   Mon, 24 Aug 2020 14:04:38 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <simon.k.r.goldschmidt@gmail.com>,
        <dinguyen@kernel.org>, <marex@denx.de>
Subject: Re: [RESEND PATCH v3 7/8] mtd: spi-nor: Convert cadence-quadspi to
 use spi-mem framework
Message-ID: <20200824140438.14e72ca6@collabora.com>
In-Reply-To: <00394d38-20d9-60a5-0068-5f9f023520c2@ti.com>
References: <20200601070444.16923-1-vigneshr@ti.com>
        <20200601070444.16923-8-vigneshr@ti.com>
        <a86aebbc-943d-6cb3-191c-797709692f80@siemens.com>
        <00394d38-20d9-60a5-0068-5f9f023520c2@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, 24 Aug 2020 17:14:56 +0530
Vignesh Raghavendra <vigneshr@ti.com> wrote:

> Hi Jan,
> 
> On 8/24/20 11:25 AM, Jan Kiszka wrote:
> [...]
> 
> >> +MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
> >>  
> > On the AM65x, this changes mtd->name (thus mtd-id for
> > parser/cmdlinepart) from 47040000.spi.0 to spi7.0. The besides having to
> > deal with both names now, "spi7" sounds like it could easily change
> > again if someone plugs or unplugs some other SPI device. Is this intended?
> >   
> 
> You could use DT aliases to make sure OSPI0 is always at given bus num
> (say spi7):
> 
>         aliases {
>                 spi7 = &ospi0;
>         };

FWIW, we've added the ->get_name() method [1][2] to avoid such
regressions.

[1]https://elixir.bootlin.com/linux/latest/source/include/linux/spi/spi-mem.h#L218
[2]https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-fsl-qspi.c#L810
