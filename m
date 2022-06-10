Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A615546C35
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jun 2022 20:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346841AbiFJSRa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 Jun 2022 14:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346557AbiFJSR3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 Jun 2022 14:17:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A9B3CE25D
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 11:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBF3C6219F
        for <linux-spi@vger.kernel.org>; Fri, 10 Jun 2022 18:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08546C34114;
        Fri, 10 Jun 2022 18:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654885047;
        bh=uBarlONavvgL3SXdfq5Bpo9B7c0nbyw1LLDrdI3wvIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aY8Z2w0DcS0pIzkp0JtTNEGlnPuelSu83xctEv3nlbAIry5XqPxByCgL9LzUb4ib9
         Cf4fH0Nx+bH1TWh4EQRy76Yl7xeWdsRYYx5hEU/SmiXNUXCLuY60d35suYvxAEyObq
         rJnuqMlYxIQU8CGlSp/n1PsvqDMx8gfjgu2yfXZFhGk3bczdSOxgHkqWySWGkm2Ihl
         LKfLatGQABEFfz2R+Htzow1ZQn8oCwmOz9pZo5r938D9ZumDF0s9Dw9WOBbpAUGq1n
         B2YZejyU2YMuo/slJ+vvxHQB1qlmfa0cS5OVyLZWrYmqtDaKYmj+41EQq6/IpMz0wW
         faMHlRcogqAog==
Date:   Fri, 10 Jun 2022 19:17:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <YqOKsumo2aXgCvFB@sirena.org.uk>
References: <20220525142928.2335378-1-david@protonic.nl>
 <20220525142928.2335378-4-david@protonic.nl>
 <20220525164603.57c98a0a@erd992>
 <Yp+ZX4XITW7bQtjn@sirena.org.uk>
 <20220608095409.2d8c46fb@erd992>
 <YqCIDNHjFP4p9xxs@sirena.org.uk>
 <20220609173421.437fe1c4@erd992>
 <YqIgXDZAHPAQ1Y4O@sirena.org.uk>
 <20220610092753.6e6c9e59@erd992>
 <YqNKCegdejr522lH@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N8fqv9FdSMX+yAwI"
Content-Disposition: inline
In-Reply-To: <YqNKCegdejr522lH@sirena.org.uk>
X-Cookie: Teachers have class.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--N8fqv9FdSMX+yAwI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2022 at 02:41:34PM +0100, Mark Brown wrote:
> On Fri, Jun 10, 2022 at 09:27:53AM +0200, David Jander wrote:
> > Mark Brown <broonie@kernel.org> wrote:

> > Ok, I first thought that this wouldn't be possible without taking the
> > necessary spinlock, but looking a little closer, I think I understand now.
> > One question to confirm I understand the code correctly:
> > An SPI driver that implements its own transfer_one_message() is required to
> > _always_ call spi_finalize_current_message() _before_ returning, right?

> Yes, it should.

Sorry, my mistake - I misremembered how that worked.  They might return
without having completed the message since the message pump is a
workqueue so it'll just go idle, spi_sync() will work because the caller
will block on the completion in the message.  It's cur_msg that's
stopping any new work being scheduled.  I was confusing this with the
handling of individual transfers, it's been a while since I got deep
into this.

The bit about allowing us to finalise in any context still applies - the
goal with that interface is to avoid the need to context switch back to
the message pump to report that the message completed, and ideally
immediately start work on the next message if the controller can cope
with that.

> > If this is a guarantee and we take the io_mutex at the beginning of
> > __spi_pump_messages(), then ctlr->cur_msg is only manipulated with the
> > io_mutex held, and that would make it safe to be used in the sync path, which
> > is also behind the io_mutex.
> > Would appreciate if you could confirm this, just to be sure I understand the
> > code correctly.

> I think that should work.  If there's something missed it should be
> possible to make things work that way.

Can we move the cleanup of cur_msg out of spi_finalize_current_message()
and into the context holding the io_mutex with that blocking on a
completion?  Don't know what the overhead of that is like, I think it
should be fine for the case where we don't actually block on the
completion and it shouldn't be any worse in the case where we're
completing in the interrupt.  Also the kthread_queue_work() that's in
there could be moved out to only the queued case since with your new
approach for spi_sync() we'll idle the hardware in the calling context
and don't need to schedule the thread at all, that should save some
overhead.

Sorry about misremembering this bit.

--N8fqv9FdSMX+yAwI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKjirEACgkQJNaLcl1U
h9C7LAf/VYlppbdf1ArEoT9f3ykClThTbL7NxTspbO5y44WR+6JFqrR/xLjgD83n
YFI/zH031fjbSH5cOod5KZMD/wzHxcoaIxjT4K9GISZyp5tjTItRLUbmAwNtut8J
JlWyYGy0zX9d0R8vbAwg4U68wASJJc2FyuuMjbvz95f2fkw3SmKaQvX01oAej39s
0Pcaft/VULqFTYVG2SZU9MeSvKetAwt0AUZlZcdee+MbfNj7UxKxp3peNyqgon8o
MizhSCpn7rt+0tR9QXBbFr5k30BmNnI7wEr/pq74KSBYbwLze0EUB8KM5Yzq5JBK
9YKj6BTJVOVvrdFBHaZqps5ChRkvHQ==
=Zp9w
-----END PGP SIGNATURE-----

--N8fqv9FdSMX+yAwI--
