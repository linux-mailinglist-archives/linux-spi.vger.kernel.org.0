Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169725A960F
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 13:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiIALwo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 07:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiIALwa (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 07:52:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A73CE1929
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 04:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9018E61E0F
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 11:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB383C433C1;
        Thu,  1 Sep 2022 11:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662033122;
        bh=O53KqzoowVo9ZiXeH2WyFSp7Jz+cVEV7o3fm61Ptwpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U/8ZYCH08sPcaEGrS+pNFnblkXPCqSo6s3C6X5xpLtEX0Tv/pE17fhnvZ583UhFh1
         /cSkJeCGp3P3OrWm9UEZQ2VweOR5cfp1X20Cqn6vTMclIgB/qU1VmMHTaFqtS+FMmL
         0H6AKruj+6zot9aywK4xtk0YD248/3BAaHdKsu/e84Z8r3tOgUT8VFjPadQ1HZikw5
         f4HlkzUAMrwFGDFvGA0GvHw0oCaNe5RTB6bPAJErQDzSgGOJiUoHsU8Z/kpmL0x1OE
         epBrnWiG0FEeCjRZdKbpDMSgium0nPN42o4NNucWiAtEI8UtGjKaq4HUxPc5wEMRPw
         SsgEquPqmwA1w==
Date:   Thu, 1 Sep 2022 12:51:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Casper Andersson <casper.casan@gmail.com>,
        linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <YxCc3ZELRekaQSfN@sirena.org.uk>
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
 <20220829105613.476622d2@erd992>
 <Yw+HTj98V1ToLWIL@sirena.org.uk>
 <YxBX4bXG02E4lSUW@axis.com>
 <20220901130222.587f4932@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="leiTRKuGc1oZxzkr"
Content-Disposition: inline
In-Reply-To: <20220901130222.587f4932@erd992>
X-Cookie: This bag is recyclable.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--leiTRKuGc1oZxzkr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2022 at 01:02:22PM +0200, David Jander wrote:

> @@ -1727,8 +1727,7 @@ static void __spi_pump_messages(struct spi_controll=
er *ctlr, bool in_kthread)
>         spin_unlock_irqrestore(&ctlr->queue_lock, flags);
> =20
>         ret =3D __spi_pump_transfer_message(ctlr, msg, was_busy);
> -       if (!ret)
> -               kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
> +       kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
> =20
>         ctlr->cur_msg =3D NULL;
>         ctlr->fallback =3D false;
>=20
> The problem is that if __spi_pump_transfer_message() fails, the ctlr->busy
> flag is left true, so __spi_async() is not going to queue new work. The b=
usy
> transition is handled right above that piece of code, in
> __spi_pump_transfer_message(), and the mechanism is to queue more work to=
 do
> it. Apparently work was only queued when the transfer was successful, and=
 I am
> not sure why it was like that. Queuing work unconditionally solves the is=
sue
> and should not be a problem.

This looks like a good spot regardless of if it fixes the issues with
spi-mux, can you submit it as a patch please?

--leiTRKuGc1oZxzkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMQnN0ACgkQJNaLcl1U
h9Dc4wf/QVWE7oBFvO/9u54pl/VJZB+DJRS7wM3ed2FVj98+7oGZwLuqvOe3DQ7i
tD8wNrp53M70SMFci3hnDHhRmR2YtbLKX0TtKgeMHY6005HPxSPELbmn4ugLzWuL
XYggLng2Jcp0/++Tj6i77kMz4q3o2QNSFZypMhkfEvMAshBTRaL6zESHRTHaZXhv
MG/9ECPfp3VOIGD1GfTsGXst6aXCcn7MdPbqUbqjLFs78PB/ZvU1dA1v8K6WOBDS
D/RVL2ZtnbrEupzZ+0AhgI1kEtqFw5TyZHqOpUlWo6Q7OHkN34dnwZE/Rfwq0VOe
N963hK6GUOpa/90dK6052hyHipMdlQ==
=mjDg
-----END PGP SIGNATURE-----

--leiTRKuGc1oZxzkr--
