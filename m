Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8924936F2B2
	for <lists+linux-spi@lfdr.de>; Fri, 30 Apr 2021 00:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhD2WrA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 18:47:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhD2Wq7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Apr 2021 18:46:59 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F177C06138B;
        Thu, 29 Apr 2021 15:46:12 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8F18422239;
        Fri, 30 Apr 2021 00:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1619736370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S2l6YZvxOM9B91GZzRwiNDNIKI1R5n/pf9yHC+ysRqE=;
        b=RAL8GgCuIWCgRFv3OE5uRyqcDDSv0O0Uxpic3XN5Crzp/YesK7qwhtMxzVViz3OBKLXmga
        pbfRTZT+vVhcpyI+rq3pI+9A8sY/sSnK2779ed7ppwYB30YwJNEDi5X0Q+M4JkD/44Iaq2
        6K2hhk5wznd2q4057Z2OO9JHiEkDn8A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 30 Apr 2021 00:46:10 +0200
From:   Michael Walle <michael@walle.cc>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [RFC PATCH 1/6] spi: spi-mem: Tell controller when device is
 ready for calibration
In-Reply-To: <20210429184109.f2pf3iyaiylumoyp@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-2-p.yadav@ti.com>
 <934c8c6f7bb71729bfdaefd39c63a262@walle.cc>
 <20210324080804.x7oemmpt2khi72mp@ti.com>
 <6dfbb3e4107887dc9ee3e19e4940e87c@walle.cc>
 <20210429184109.f2pf3iyaiylumoyp@ti.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <2c3461f38c93871fbc715a19aeecdd2a@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Am 2021-04-29 20:41, schrieb Pratyush Yadav:
> On 29/04/21 06:23PM, Michael Walle wrote:
>> I've had a look at the LS1028A FlexSPI calibration feature. The
>> reference manual is very sparse on details, though. What you need to
>> do there is to program a special read command sequence (the whole
>> controller is made of these lookup table entries, where you can
>> have a short sequence of operations for read/write/program and so
>> on). Therefore, for data learning you'll take the read operation
>> and insert a LEARN op in between and read a specific data pattern.
>> Then the hardware will automatically figure out the correct sample
>> phase for the read data pins.
>> 
>> Unfortunately, it does not mention how often you have to do it. It
>> might be the case that is has to be calibrated more than once.
> 
> I haven't read the datasheet, I wonder how long this calibration takes.
> If it is too long then the overhead might not even be worth the extra
> read throughput. Especially when using a file system on top which
> generally don't do very large reads in one go.

I was just thinking of compensating a possible temperature drift. You
wouldn't have to do it on every read.

There is a second mode, where it is actually done on every read. But
that will be used where the flash supports a read preamble, where
dummy bytes after the read opcode are replaced by a calibration pattern.
If the pattern has the same length as the dummy bytes there is no 
penalty.
IIRC the controller just supports a pattern of max 32 bits.

Oh I forgot to mention, this doesn't need to be repeated. I guess
the hardware already captures all possible phases (there are only
16) and compares each one with a predefined pattern.

> Anyway, when the do_calibration() is called the controller can save the
> calibration op and use it later as needed. It knows when an exec_op()
> will result in a read since it has access to the whole op.
> 
>> 
>> I'm just mentioning this so it won't be lost. If needed, it can
>> be added later.
>> 
>> Am 2021-03-24 09:08, schrieb Pratyush Yadav:
>> > On 24/03/21 12:07AM, Michael Walle wrote:
>> > > Am 2021-03-11 20:12, schrieb Pratyush Yadav:
>> > > > Some controllers like the Cadence OSPI controller need to perform a
>> > > > calibration sequence to operate at high clock speeds. This calibration
>> > > > should happen after the flash is fully initialized otherwise the
>> > > > calibration might happen in a different SPI mode from the one the flash
>> > > > is finally set to. Add a hook that can be used to tell the controller
>> > > > when the flash is ready for calibration. Whether calibration is needed
>> > > > depends on the controller.
>> > > >
>> > > > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> > > > ---
>> > > >  drivers/spi/spi-mem.c       | 12 ++++++++++++
>> > > >  include/linux/spi/spi-mem.h |  8 ++++++++
>> > > >  2 files changed, 20 insertions(+)
>> > > >
>> > > > diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> > > > index dc713b0c3c4d..e2f05ad3f4dc 100644
>> > > > --- a/drivers/spi/spi-mem.c
>> > > > +++ b/drivers/spi/spi-mem.c
>> > > > @@ -464,6 +464,18 @@ int spi_mem_adjust_op_size(struct spi_mem *mem,
>> > > > struct spi_mem_op *op)
>> > > >  }
>> > > >  EXPORT_SYMBOL_GPL(spi_mem_adjust_op_size);
>> > > >
>> > > > +int spi_mem_do_calibration(struct spi_mem *mem, struct spi_mem_op *op)
>> > > > +{
>> > > > +	struct spi_controller *ctlr = mem->spi->controller;
>> > > > +
>> > > > +	if (!ctlr->mem_ops || !ctlr->mem_ops->do_calibration)
>> > > > +		return -EOPNOTSUPP;
>> > > > +
>> > > > +	ctlr->mem_ops->do_calibration(mem, op);
>> > >
>> > > Can't a calibration fail?
>> >
>> > It can. If it does, the controller falls back to lower speed transfers.
>> > There is not much the upper layer can do about this. That's why it is
>> > not informed whether it succeeded or not.
>> 
>> Ok, if needed, that should be an easy change.
>> 
>> op is there to decide if we need a calibration at all, correct?
> 
> Yes. It can also be used to choose which calibration algorithm to use.
> For example on the Cadence controller, there are different algorithms
> for 8S and 8D operations.
> 
>> What if there are different factors, like frequency? For example
>> on the LS1028A its just a matter of the SCK frequency. It seems
>> that this parameter is tailored to the OPHY.
> 
> As of now there is no way in SPI MEM to tell the controller the 
> expected
> speed of the operation. AFAIK most controllers get the speed via device
> tree. So in the current case, the controller already knows the speed it
> should run at, and can decide if calibration is needed or not.
> 
> But if operation speed is eventually added to SPI MEM, I would assume 
> it
> would be part of struct spi_mem_op. The op passed in would have this
> information filled, and the controller can use that information to
> decide if it needs to perform the calibration or not.
> 
> I am all for making this API flexible, but with very few controllers
> supporting this feature in the wild, it is difficult to predict all the
> information that might be needed. In the current state, I think the API
> provides a fair bit of information to the controller about how a read
> operation would look like.

Sure, and its also quite hard to review without any other hardware
which supports that ;) I was thinking about letting the spi driver
call into spi-mem to retrieve the information it needs instead of
having that second argument. Anyway, if we need any changes in the
future this isn't set in stone.

-michael
