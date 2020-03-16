Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 050FD186ABB
	for <lists+linux-spi@lfdr.de>; Mon, 16 Mar 2020 13:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgCPMRx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 16 Mar 2020 08:17:53 -0400
Received: from foss.arm.com ([217.140.110.172]:47236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730969AbgCPMRx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 16 Mar 2020 08:17:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A74D830E;
        Mon, 16 Mar 2020 05:17:52 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BB503F52E;
        Mon, 16 Mar 2020 05:17:52 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:17:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: fix cs_change for last transfer
Message-ID: <20200316121750.GD5010@sirena.org.uk>
References: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <45912ba25c34a63b8098f471c3c8ebf8857a4716.1584292056.git.mirq-linux@rere.qmqm.pl>
X-Cookie: I thought YOU silenced the guard!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2020 at 06:08:53PM +0100, Micha=C5=82 Miros=C5=82aw wrote:

> Generic spi_transfer_one_message() implementation introduced in
> commit b158935f70b9 has a bug in cs_change handling: it keeps CS
> asserted when cs_change is set. Fix it.

>  	struct spi_transfer *xfer;
> -	bool keep_cs =3D false;
> +	bool keep_cs =3D true;
>  	int ret =3D 0;
>  	struct spi_statistics *statm =3D &ctlr->statistics;
>  	struct spi_statistics *stats =3D &msg->spi->statistics;
> @@ -1268,7 +1268,7 @@ static int spi_transfer_one_message(struct spi_cont=
roller *ctlr,
>  		if (xfer->cs_change) {
>  			if (list_is_last(&xfer->transfer_list,
>  					 &msg->transfers)) {
> -				keep_cs =3D true;
> +				keep_cs =3D false;
>  			} else {

This is the opposite of the intended behaviour - we want to deassert
chip select at the end of the message unless cs_change is set on the
last transfer.  If this were broken I would expect to see widespread
problems being reported.

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5vbm0ACgkQJNaLcl1U
h9BMdQf5AWzcmvns3J9jyWP93QCJquixA0rC5Yq66TDu3Vo6Qrfavnr7xme7k1Wh
y6MTSaGKPYH1Y0WzSuQfoFzNOK8dTs9LskJ3D+rZo3hC4IhDKiJQzlEJXK45uLBu
7dQK6bfsI1wSkL6PW89MmfxhrtFV+/EtlocxGVcyy50c1Wo6bGC/U6rak0GUjQhj
xD9ig3QyjEBIqvVnv8+FxdE8bjQm2KEhcNOwcKveKKB1YtdYbNeiGw0qY3X6RaFD
oNGdZTtvaz5GoT9Wr11qWMWqD/fjecNXwxXWSioAm/UWCO3xN471cO2Ip8TXMZbU
Hr2VvQWOFAf5zN6N4XPf3/ZHGhku6A==
=1SXT
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
