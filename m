Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F2852EF03
	for <lists+linux-spi@lfdr.de>; Fri, 20 May 2022 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbiETPWS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 May 2022 11:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiETPWR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 20 May 2022 11:22:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E86580DE
        for <linux-spi@vger.kernel.org>; Fri, 20 May 2022 08:22:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B343EB82C36
        for <linux-spi@vger.kernel.org>; Fri, 20 May 2022 15:22:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A47C385A9;
        Fri, 20 May 2022 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653060133;
        bh=ICwlxezcm59NDEsz0g6ZaZPyw2CIGXjUg/pyuhjQ7y8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VYYOyGgSRacVbpJ+bpUQuCvMKBOMxNA1e7HQvo4w9pp8V855p6zKIszr1i6Sj24UG
         pPHIbjeikIZ0YwQOvJN7YAu8fZDaIxa+beFyuArBTwpCL/+Rna9maqIkEgED8jKPjz
         YvjP6ZVikVXCS+hfU9L3O7TaM+GHgSeBffRQksQGXRYYC8Z2mSc5f16mGXv9hPqSYd
         gh4OLWPRbutV1ghXui46QFxl2UfLXfLD6AP1admzKOppAhBJRFtuaJNU38Ml9HpXy/
         bY+clQGn5M/el21iUB4GJ4ECYwn097KBYwLPm3H1MsQTosUE9cKhIZDkTYddkrui8s
         7Kebsqt9riiiQ==
Date:   Fri, 20 May 2022 16:22:08 +0100
From:   Mark Brown <broonie@kernel.org>
To:     David Jander <david@protonic.nl>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-spi@vger.kernel.org,
        Oleksij Rempel <ore@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [RFC] A new SPI API for fast, low-latency regmap peripheral
 access
Message-ID: <YoeyIG+RGpRBm9Cc@sirena.org.uk>
References: <Yn6zU3mdgaSNy4Hc@sirena.org.uk>
 <20220516162851.fhczlq4qfqhu6jht@pengutronix.de>
 <YoKN/lqrgKJbVBVq@sirena.org.uk>
 <20220517122439.744cf30c@erd992>
 <YoONngxX/jdTjSOH@sirena.org.uk>
 <20220517150906.09a16a47@erd992>
 <YoOmn1k6yEtJofe5@sirena.org.uk>
 <20220517171626.51d50e74@erd992>
 <YoPm0qDaMEogH8n2@sirena.org.uk>
 <20220519101238.516c5f9e@erd992>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AZcG5ogteVlEPsio"
Content-Disposition: inline
In-Reply-To: <20220519101238.516c5f9e@erd992>
X-Cookie: Happy feast of the pig!
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--AZcG5ogteVlEPsio
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 19, 2022 at 10:12:38AM +0200, David Jander wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Tue, May 17, 2022 at 05:16:26PM +0200, David Jander wrote:
> > > Mark Brown <broonie@kernel.org> wrote: =20

> > > Nice! I like that idea. Do you want to somehow extend spi_async() to =
do this
> > > transparently? So we just need to introduce a second function
> > > ("spi_async_await()" ?) which would wait for completion and collect t=
he RX
> > > buffer? =20

> > We shouldn't need a new API to wait for the async operation to complete,
> > hopefully the existing one is fine.

> Maybe there is something I am not seeing then. The client needs to make t=
wo
> function calls. One to fill the FIFO and start the transfer, and a second=
 one
> to poll the FIFO and read out the RX data. With the existing API, I can o=
nly
> think of these options:

The client just submits a message using spi_async() and can use the
complete() callback like spi_sync() does to find out when the transfer
is done.  The core is responsible for actually interacting with the
device.

>  2. Use a completion or callback. But I don't see how that will work with=
out a
>  context switch to some code that completes the completion or calls the
>  callback, which is what we are trying to avoid having in the first place.

If the core doesn't need to context switch then the core should just be
able to complete without context switching hopefully.  At most we'd need
a mechanism to say that the completion is OK to call from atomic
context.

> > Or otherwise make it unobtrusive (eg, with similar techniques to those
> > used by the networking API).

> I just tried this out by re-writing the statistics code using u64_stats_s=
ync
> and per-cpu statistics, which get totaled on sysfs read access as Andrew =
Lunn
> suggested.
> The results are truly amazing!

> The overhead caused by statistics in my test dropped from 43us to just 1-=
2us.

Ah, cool.  I look forward to the patches.

> This was tested on a 64-bit machine though, so I don't know how it will a=
ffect
> 32-bit systems. Nor do I have an easy means of testing this. Any ideas?

Hopefully someone with a 32 bit system who's concerned about performance
can test.

> Also, I have converted all the struct spi_statistics members to u64_stats=
_t.
> It was easier to test this way. Some of the original types were unsigned =
long,
> which can have different sizes on 64bit or 32bit systems... is that
> intentional?

I don't think so.

--AZcG5ogteVlEPsio
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKHsh8ACgkQJNaLcl1U
h9C8Pgf+Ot0UNDKYW2DenCOD/OIwQbeTrPaGiONtkZIgvlLxevbC0ryYiHovoGGf
ynwhh9eAO/+yjZN9HEsHShyNofkh2vg/qTUUUcQkviOfqmIMne8fQZPth/C0ZjR4
YDOMtagYHVbXxi9W/imn8MYbQcRcbZ3ALh3WyiYruc/CaIrbCjemZ0rO2E9a0Ut8
A18cgWNg2fvoO7sxrkPELNzSSxWVIJs3Va1kuCLrTgFr7netCwzg4gdrJbjVpTFf
O7BRKMv0E0K+gUGWJnpL8+2Y7sezqC7ejP+ItignR7WqNsRs/mv6jcjWXyhMy/TK
dy3ErhOfjsl9RUT3f+f3F67pvqelCw==
=tAw1
-----END PGP SIGNATURE-----

--AZcG5ogteVlEPsio--
