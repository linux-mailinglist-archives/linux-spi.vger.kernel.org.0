Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4A92DE0A4
	for <lists+linux-spi@lfdr.de>; Fri, 18 Dec 2020 10:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgLRJ6o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 18 Dec 2020 04:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732804AbgLRJ6o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 18 Dec 2020 04:58:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C72C0617A7;
        Fri, 18 Dec 2020 01:58:03 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id DED361F4614A;
        Fri, 18 Dec 2020 09:58:01 +0000 (GMT)
Date:   Fri, 18 Dec 2020 10:57:59 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>, <lukas@wunner.de>,
        <bbrezillon@kernel.org>, <tudor.ambarus@microchip.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 5/9] spi: spi-mem: Mark dummy transfers by setting
 dummy_data bit
Message-ID: <20201218105759.43789ccf@collabora.com>
In-Reply-To: <20201218092106.skwej2g6bk3oksbb@ti.com>
References: <1608236927-28701-1-git-send-email-skomatineni@nvidia.com>
        <1608236927-28701-6-git-send-email-skomatineni@nvidia.com>
        <20201218092106.skwej2g6bk3oksbb@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 18 Dec 2020 14:51:08 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> Hi Sowjanya,
> 
> On 17/12/20 12:28PM, Sowjanya Komatineni wrote:
> > This patch marks dummy transfer by setting dummy_data bit to 1.
> > 
> > Controllers supporting dummy transfer by hardware use this bit field
> > to skip software transfer of dummy bytes and use hardware dummy bytes
> > transfer.  
> 
> What is the benefit you get from this change? You add complexity in 
> spi-mem and the controller driver, so that must come with some benefits. 
> Here I don't see any. The transfer will certainly take the same amount 
> of time because the number or period of the dummy cycles has not 
> changed. So why is this needed?

Well, you don't have to queue TX bytes if you use HW-based dummy
cycles, but I agree, I'd expect the overhead to be negligible,
especially since we're talking about emitting a few bytes, not hundreds.
This being said, the complexity added to the core is reasonable IMHO,
so if it really helps reducing the CPU overhead (we might need some
numbers to prove that), I guess it's okay.

>  
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  drivers/spi/spi-mem.c   | 1 +
> >  include/linux/spi/spi.h | 2 ++
> >  2 files changed, 3 insertions(+)
> > 
> > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> > index f3a3f19..c64371c 100644
> > --- a/drivers/spi/spi-mem.c
> > +++ b/drivers/spi/spi-mem.c
> > @@ -354,6 +354,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> >  		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
> >  		xfers[xferpos].len = op->dummy.nbytes;
> >  		xfers[xferpos].tx_nbits = op->dummy.buswidth;
> > +		xfers[xferpos].dummy_data = 1;
> >  		spi_message_add_tail(&xfers[xferpos], &msg);
> >  		xferpos++;
> >  		totalxferlen += op->dummy.nbytes;
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index aa09fdc..708f2f5 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -827,6 +827,7 @@ extern void spi_res_release(struct spi_controller *ctlr,
> >   *      transfer. If 0 the default (from @spi_device) is used.
> >   * @bits_per_word: select a bits_per_word other than the device default
> >   *      for this transfer. If 0 the default (from @spi_device) is used.
> > + * @dummy_data: indicates transfer is dummy bytes transfer.
> >   * @cs_change: affects chipselect after this transfer completes
> >   * @cs_change_delay: delay between cs deassert and assert when
> >   *      @cs_change is set and @spi_transfer is not the last in @spi_message
> > @@ -939,6 +940,7 @@ struct spi_transfer {
> >  	struct sg_table tx_sg;
> >  	struct sg_table rx_sg;
> >  
> > +	unsigned	dummy_data:1;
> >  	unsigned	cs_change:1;
> >  	unsigned	tx_nbits:3;
> >  	unsigned	rx_nbits:3;
> > -- 
> > 2.7.4
> >   
> 

