Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2E548651
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jun 2022 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385918AbiFMOzD (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Jun 2022 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386886AbiFMOya (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Jun 2022 10:54:30 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6DCE5DE
        for <linux-spi@vger.kernel.org>; Mon, 13 Jun 2022 04:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4E18DCE1261
        for <linux-spi@vger.kernel.org>; Mon, 13 Jun 2022 11:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BEAC34114;
        Mon, 13 Jun 2022 11:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655121413;
        bh=fAzzXO+Nco/eofmAxV94KrHqvRPzpRE5Fx8IXHBvvJI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyxtQyBfOCSNK8XydAS3ph3/0BwpgauJ3Pi/hAZ9oQl4kK01ycFj+rXZBWosnvkw6
         2QwaKfrej1BE5Hu+oeaUJ0WQ+C25O4F2a4Zn7zCj+asNxcRqb/Jc27ZXDMwuI2aJOt
         4kxAFT7K58Y1D14KWVgMTZffNIs+bnioyYimcnN5P65L+wAof77jOCJVF0idnFCn+w
         iGR+XZgLiM+gD5NEOKPLx3x1hFsy6b6Lg6zt8vfxtWCE0yt1vwUaX8q1G2br+h3pRo
         l72ljGahKH8aPHNRimJ8Lf2NVvjLjaBHwLniXE3D/GxYHYZ5+Za9XNGYTNbN6TXOsx
         h1gjMR4bGDgnw==
Date:   Mon, 13 Jun 2022 12:56:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <YqcmANJXrsLXI6LB@sirena.org.uk>
References: <20220525164603.57c98a0a@erd992>
 <Yp+ZX4XITW7bQtjn@sirena.org.uk>
 <20220608095409.2d8c46fb@erd992>
 <YqCIDNHjFP4p9xxs@sirena.org.uk>
 <20220609173421.437fe1c4@erd992>
 <YqIgXDZAHPAQ1Y4O@sirena.org.uk>
 <20220610092753.6e6c9e59@erd992>
 <YqNKCegdejr522lH@sirena.org.uk>
 <YqOKsumo2aXgCvFB@sirena.org.uk>
 <20220613110550.772c5023@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ASomvS7XMXbcScKW"
Content-Disposition: inline
In-Reply-To: <20220613110550.772c5023@erd992>
X-Cookie: innovate, v.:
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--ASomvS7XMXbcScKW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2022 at 11:05:50AM +0200, David Jander wrote:

> Thinking out loud here, so correct me if I am wrong.
> Basically what is happening in that scenario, if we had several async
> messages queued up, is this:

>  1. __pump_messages() gets first message off queue, stores in cur_msg.
>  2. __pump_messages() calls ->transfer_one_message().
>  3. transfer_one_message() triggers an IRQ or other context *A*.
>  4. transfer_one_message() returns before message is finished.
>  5. work queue idles. If someone calls spi_async() now, it will not queue
>  work, since ctlr->busy is still true.
>  6. *A*: IRQ or other context calls spi_finalize_current_message()
>  7. spi_finalize_current_message() schedules new work.
>  8. Goto 1.

>  Total ctx switches message->message: 2 (at steps 3->6 and 7->8).

Yes, plus also any transition to the context that submitted the message
=66rom completing the message.

> In this scenario, the io_mutex is taken at step 1 and released at step 9,
> inside the same function. The io_mutex is released either after
> transfer_one_message() returns, or after spi_finalize_current_message() is
> called, whatever comes _LAST_. I think I like this. Any potential problems
> I am missing?

I think that about covers it, I'm not seeing any issues right now.

--ASomvS7XMXbcScKW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKnJgAACgkQJNaLcl1U
h9Deawf/Sv06G9ao30XDx9gK+l+2r/9iCgaF0nPs873qNhXIl05ud86napoQ6SyF
GOcd++2I5gEQxf0Vs+R5rURYjeYA1xpCpK2uwkp4/Ewj+Rs9VcY5eeTE5nsUEcc8
cjiKzSK9+ynwoUvs4SitGCE8ORLREfTbLBuMyi3lfg6o6OXN7RzegEm+SrfEA0oG
iw7BGSOqKMqe5DJeuB2cH3gfefARldlOSK3HkL4Wn0dhNUXaqEGURMGwYAhaYTdu
bkVl1LteMzRU0yGZhF5DpUm2Ntszi6v8yMZY8K55SfhRbCW2+qeeHKQv6WhkSWR7
bJpVpYStAVw6zKJ1WchvSTPwfQz84w==
=NOST
-----END PGP SIGNATURE-----

--ASomvS7XMXbcScKW--
