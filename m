Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC20477985
	for <lists+linux-spi@lfdr.de>; Thu, 16 Dec 2021 17:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhLPQny (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Dec 2021 11:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbhLPQnx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 Dec 2021 11:43:53 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7D0C061574
        for <linux-spi@vger.kernel.org>; Thu, 16 Dec 2021 08:43:53 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C48141F4133E;
        Thu, 16 Dec 2021 16:43:50 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639673031; bh=NRlWnUKSxIUgHuxirD6NYoUC5ZA2xF6iZlzklepC9FQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WOim5bl5S+nTsXk/ANhy88KBaCLLoDC3McEVMtZoPEet3N1DJQnWWKU8nvX1R0YDP
         FDrARNXt2GOu1pZKJSJrUlrZULJwP6CpL1KYOvNwJp5F99IyeFn0n1sy7Kxn2Q1rca
         gNRzwvNT4nzGl5dCmDHfjpVa2a1pJtkIi63y9OLQEN/r6mK2MlnjKsn0Ku8byDzvI2
         nAwNcAapTwLAOmCC0Q2LyORL3KcSYpNxbXJ9JphQS+L3XcfHRY0X/XkxhgNx7rRlqa
         q3KqtYEGmYDoSDmhTksA+sMxhS1kotpWQFlfVFwC3/6pwp+6HaL+QvhAk3/Nq+olFx
         EMYH1AetY1NlA==
Date:   Thu, 16 Dec 2021 17:43:47 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mtd: spi-nor: intel-spi: Convert to SPI MEM
Message-ID: <20211216174347.69cf611c@collabora.com>
In-Reply-To: <Ybtn1VTsspxdIeT8@lahna>
References: <20211118130543.11179-1-mika.westerberg@linux.intel.com>
        <20211118130543.11179-3-mika.westerberg@linux.intel.com>
        <20211216115100.448351e4@collabora.com>
        <Ybtn1VTsspxdIeT8@lahna>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 16 Dec 2021 18:22:45 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Hi,
> 
> On Thu, Dec 16, 2021 at 11:51:00AM +0100, Boris Brezillon wrote:
> > On Thu, 18 Nov 2021 16:05:42 +0300
> > Mika Westerberg <mika.westerberg@linux.intel.com> wrote:
> >   
> > > +static bool intel_spi_cmp_mem_op(const struct intel_spi_mem_op *iop,
> > > +				 const struct spi_mem_op *op)
> > > +{
> > > +	if (iop->mem_op.cmd.nbytes != op->cmd.nbytes ||
> > > +	    iop->mem_op.cmd.buswidth != op->cmd.buswidth ||
> > > +	    iop->mem_op.cmd.dtr != op->cmd.dtr ||
> > > +	    iop->mem_op.cmd.opcode != op->cmd.opcode)
> > > +		return false;
> > > +
> > > +	if (iop->mem_op.addr.nbytes) {
> > > +		if (iop->mem_op.addr.nbytes != op->addr.nbytes ||
> > > +		    iop->mem_op.addr.dtr != op->addr.dtr)
> > > +			return false;
> > > +	}  
> > 
> > Hm, are you sure you want to allow op->addr.nbytes > 0 when
> > iop->mem_op.addr.nbytes == 0? Feels like the command should be reported
> > as unsupported in that case. Unless 0 is a wildcard meaning 'any', but
> > that would be confusing, since operations with 0 address bytes are
> > valid, and I actually expect the number of address cycles to be fixed 
> > or bounded.  
> 
> Indeed. I will change it to:
> 
> 	if (iop->mem_op.addr.nbytes) {
> 		if (iop->mem_op.addr.nbytes != op->addr.nbytes ||
> 		    iop->mem_op.addr.dtr != op->addr.dtr)
> 			return false;
> 	} else if (op->addr.nbytes > 0) {
> 		return false;
> 	}

Why no just

	if (iop->mem_op.addr.nbytes != op->addr.nbytes ||
	    iop->mem_op.addr.dtr != op->addr.dtr)
		return false;

then?

> 
> in v5 if that's what you meant.

