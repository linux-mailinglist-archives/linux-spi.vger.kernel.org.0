Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7F319F1F
	for <lists+linux-spi@lfdr.de>; Fri, 12 Feb 2021 13:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhBLMuT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 12 Feb 2021 07:50:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:36612 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbhBLMtD (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 12 Feb 2021 07:49:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 348E8AC90;
        Fri, 12 Feb 2021 12:48:22 +0000 (UTC)
Message-ID: <cd41a204107900c890b0234847fa0b62701f74cc.camel@suse.de>
Subject: Re: [PATCH] spi: Skip zero-length transfers in
 spi_transfer_one_message()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Phil Elwell <phil@raspberrypi.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Feb 2021 13:48:21 +0100
In-Reply-To: <20210212123118.GB6057@sirena.org.uk>
References: <20210211180820.25757-1-nsaenzjulienne@suse.de>
         <20210212123118.GB6057@sirena.org.uk>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-v8DGUj7fz+Xkq1UEyNyZ"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--=-v8DGUj7fz+Xkq1UEyNyZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-02-12 at 12:31 +0000, Mark Brown wrote:
> On Thu, Feb 11, 2021 at 07:08:20PM +0100, Nicolas Saenz Julienne wrote:
>=20
> > -		if (xfer->tx_buf || xfer->rx_buf) {
> > +		if ((xfer->tx_buf || xfer->rx_buf) && xfer->len) {
>=20
> I think the issue here is more that some users were passing in buffers
> with zero length transfers, the above check was already intended to
> catch this case but was working on the assumption that if there was
> nothing to transfer then no buffer would be provided.

Fair enough, maybe it makes sense to move the check into __spi_validate() a=
nd
propagate an error upwards?

Regads,
Nicolas


--=-v8DGUj7fz+Xkq1UEyNyZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmAmeRUACgkQlfZmHno8
x/7SsQf/TdB8vXIJOKUbyFOgMkt+2pL2NOhrR7/gOHjvswb5nPNd6x4hOAl1tPiM
8As/5uPnXbPvxhmsMzsXKjwcylJDD5z00lFCXNZNzmxOBGcBnEtfwDD9/9nTpke6
T5EsTsbMAU+nLbzlmX0pR6z0FGpzQkToxop0X+mp2IX8Hdxt9FwepKB3MdnC/Oq9
Af4G9mp0pd8tjEHmjckZLfAymQ4mJ1HW/xwSk6bnv1mG34UysJYWIOBfsx/IQM4F
OSTjB+D/2yDcA6eS2MceKh9qV0CJA5UPEW3Z2zVfw9tq/R8/8iuzsjcoMPWY2bXL
xW8iaDHqlzwPJkY6WfkQdbLNnQuR3Q==
=2avD
-----END PGP SIGNATURE-----

--=-v8DGUj7fz+Xkq1UEyNyZ--

