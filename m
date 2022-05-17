Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8C252A0E4
	for <lists+linux-spi@lfdr.de>; Tue, 17 May 2022 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiEQL5b (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 May 2022 07:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244349AbiEQL51 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 May 2022 07:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7936310
        for <linux-spi@vger.kernel.org>; Tue, 17 May 2022 04:57:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D6E560B71
        for <linux-spi@vger.kernel.org>; Tue, 17 May 2022 11:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E207C385B8;
        Tue, 17 May 2022 11:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652788642;
        bh=//Hu2gdNvx1/B5dqxRrO15ydpHXcHeRuei09+1t2Ftg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKAME4/mqfQe/IS4KmeJJKc/1iJIID8EklsY70b0BxnCgtUBu7NkAZMIIlf8cbTK8
         5e5ZZhz5qxmSGKVzf+pbsLxblG0A5kqkxUv38LlcGQiP6bfg0LjiRrL2mxsE7na0YT
         fKGE89fPuTBMfqZXPaGaTy+f50vuD7/39YXDILaCCbkkRWGtpyN2eweLbMwSw0GzI2
         KsGe3l896MDY1ORGUu3YTyYhmrXRmf/UpX+NjE/J+IWTkBc4ceONhUStLO67aGOkEh
         nPgbAINSS5TbkjXCrtITNrgvMcUI0C2Jvx1ZWGs3cMEK7EYD0yD/SI8qSQCGxGQjCl
         Cl4jNga7tlLYg==
Date:   Tue, 17 May 2022 12:57:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <YoONngxX/jdTjSOH@sirena.org.uk>
References: <20220512163445.6dcca126@erd992>
 <Yn1wE4TLyXCIm9GF@sirena.org.uk>
 <20220513144645.2d16475c@erd992>
 <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
 <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
 <YoKN/lqrgKJbVBVq@sirena.org.uk>
 <20220517122439.744cf30c@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qEXEam9aqxKJ/j7N"
Content-Disposition: inline
In-Reply-To: <20220517122439.744cf30c@erd992>
X-Cookie: Fats Loves Madelyn.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--qEXEam9aqxKJ/j7N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 17, 2022 at 12:24:39PM +0200, David Jander wrote:

> (mainly in spi.c for now). Time interrupt line stays low:

>  1. Kernel 5.18-rc1 with only polling patches from spi-next: 135us

>  2. #if 0 around all stats and accounting calls: 100us

>  3. The _fast API of my original RFC: 55us

> This shows that the accounting code is a bit less than half of the dispensable
> overhead for my use-case. Indeed an easy target.

Good.

> on, so I wonder whether there is something to gain if one could just call
> spi_bus_lock() at the start of several such small sync transfers and use
> non-locking calls (skip the queue lock and io_mutex)? Not sure that would have
> a meaningful impact, but to get an idea, I replaced the bus_lock_spinlock and
> queue_lock in __spi_sync() and __spi_queued_transfer() with the bare code in
> __spi_queued_transfer(), since it won't submit work to the queue in this case
> anyway. The resulting interrupt-active time decreased by another 4us, which is
> approximately 5% of the dispensable overhead. For the record, that's 2us per
> spinlock lock/unlock pair.

I do worry about how this might perform under different loads where
there are things coming in from more than one thread.

> > One thing that might be useful would be if we could start the initial
> > status read message from within the hard interrupt handler of the client
> > driver with the goal that by the time it's threaded interrupt handler
> > runs we might have the data available.  That could go wrong on a lightly
> > loaded system where we might end up running the threaded handler while
> > the transfer is still running, OTOH if it's lightly loaded that might
> > not matter.  Or perhaps just use a completion from the SPI operation and
> > not bother with the threaded handler at all.

> You mean ("ctx" == context switch):

>  1. hard-IRQ, queue msg --ctx--> SPI worker, call msg->complete() which does
>  thread IRQ work (but can only do additional sync xfers from this context).

> vs.

>  2. hard-IRQ, queue msg --ctx--> SPI worker, call completion --ctx--> IRQ
>  thread wait for completion and does more xfers...

> vs (and this was my idea).

>  3. hard-IRQ, pump FIFO (if available) --ctx--> IRQ thread, poll FIFO, do more
>  sync xfers...

Roughly 1, but with a lot of overlap with option 3.  I'm unclear what
you mean by "queue message" here.

> Option 3 would require a separation of spi_sync_transfer into two halves. One
> half just activates CS (non-sleep GPIO api!) and fills the FIFO. The second
> half polls the FIFO for transfer completion. This path could only be chosen if
> the SPI controller has a FIFO that can hold the whole message. In other words a
> lot of spacial case handling for what it is worth probably... but still
> interesting.

Yes, that's the whole point.  This also flows nicely when you've got a
queue since you can restart the hardware from the interrupt context
without waiting to complete the transfer that just finished.

> Option 2 is probably not that bad if the SPI worker can run on another core?

Pretty much anything benefits with another core.

--qEXEam9aqxKJ/j7N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKDjZ0ACgkQJNaLcl1U
h9CNeQf9GZX3cb6QFaZynG6VutAASXVUXGfwDXZnYO1/OvdUrPcH4WtgIYxOv9Hv
NBbwFAW8xnuQTy/CeviMXBpFIwjNwvpJYLkJdyJ73eKbaOKYbaP10VO+RjSNE3Sj
V/NyyhocKTh6fh4FBxK5vIbBXJI6Fe9AgNb8zdwuKAXgDdUzJYo6UyFMcPIYd/hy
SBt05+bBMazimr2f6wtBt3Nxr/xyfUSva0B7o+fNoNV0aUgKIMYLceYZ5tSUMdER
VlY2BCfOCxsjJrjb2zYlQ5xPCILehKch32I/HmFRxOiz8hXwRqAckLOP8yT90I95
lYY2gxuoJOHEjnE6+BOkH1gXaE5erg==
=qqv8
-----END PGP SIGNATURE-----

--qEXEam9aqxKJ/j7N--
