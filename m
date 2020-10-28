Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFA829E199
	for <lists+linux-spi@lfdr.de>; Thu, 29 Oct 2020 03:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgJ2CC0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 28 Oct 2020 22:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgJ1Vs4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 28 Oct 2020 17:48:56 -0400
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5D9C0613CF
        for <linux-spi@vger.kernel.org>; Wed, 28 Oct 2020 14:48:55 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id DF3BF100E4169;
        Wed, 28 Oct 2020 10:59:46 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id A7AAA12805F; Wed, 28 Oct 2020 10:59:46 +0100 (CET)
Date:   Wed, 28 Oct 2020 10:59:46 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Use after free in bcm2835_spi_remove()
Message-ID: <20201028095946.GA25358@wunner.de>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <20201014140912.GB24850@wunner.de>
 <20201014194035.ukduovokggu37uba@skbuf>
 <20201014202505.GF4580@sirena.org.uk>
 <20201015053829.GA2461@wunner.de>
 <20201015125335.GB4390@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015125335.GB4390@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, Oct 15, 2020 at 01:53:35PM +0100, Mark Brown wrote:
> On Thu, Oct 15, 2020 at 07:38:29AM +0200, Lukas Wunner wrote:
> > On Wed, Oct 14, 2020 at 09:25:05PM +0100, Mark Brown wrote:
> > How about holding a ref on the controller as long as the SPI driver
> > is bound to the controller's parent device?  See below for a patch,
> > compile-tested only for lack of an SPI-equipped machine.
[...]
> > +	spi_controller_get(ctlr);
> > +	ret = devm_add_action(dev, __spi_controller_put, ctlr);
> > +	if (ret) {
> > +		kfree(ctlr);
> 
> This feels a bit icky - we're masking a standard use after free bug that
> affects devm in general, not just this instance, and so while it will
> work it doesn't feel great.  If we did do this it'd need more comments
> and should probably be conditional on using the feature.  TBH I'm just
> thinking it's better to just remove the feature, it's clearly error
> prone and pretty redundant with devm.  I'm not sure any memory savings
> it's delivering are worth the sharp edges.

A combined memory allocation for struct spi_controller and the private
data has more benefits than just memory savings:  Having them adjacent
in memory reduces the chance of cache misses.  Also, one can get from
one struct to the other with a cheap subtraction (using container_of())
instead of having to chase pointers.  So it helps performance.  And a
lack of pointers arguably helps security.

Most subsystems embed the controller struct in the private data, but
there *is* precedence for doing it the other way round.  E.g. the IIO
subsystem likewise appends the private data to the controller struct.
So I think that's fine, it need not and should not be changed.

The problem is that the ->probe() and ->remove() code is currently
asymmetric, which is unintuitive:  On ->probe(), there's an allocation
step and a registration step:

	spi_alloc_master()
	spi_register_controller()

Whereas on ->remove(), there's no step to free the master which would
balance the prior alloc step:

	spi_unregister_controller()

That's because the spi_controller struct is ref-counted and the last
ref is usually dropped by spi_unregister_controller().  If the private
data is accessed after the spi_unregister_controller() step, a ref
needs to be held.

I maintain that it would be more intuitive to automatically hold a ref.
We could offer a devm_spi_alloc_master() function which holds this ref
and automatically releases it on unbind.

There are three drivers which call spi_alloc_master() with a size of zero
for the private data.  In these three cases it is fine to free the
spi_controller struct upon spi_unregister_controller().  So these drivers
can continue to use spi_alloc_master().  All other drivers could be
changed to use the new devm_spi_alloc_master(), or I could scrutinize
each of them and convert to the new function only if necessary.

Does this sound more convincing to you?

Thanks,

Lukas
