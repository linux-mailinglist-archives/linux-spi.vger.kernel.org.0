Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294A03B2E10
	for <lists+linux-spi@lfdr.de>; Thu, 24 Jun 2021 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhFXLrP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 24 Jun 2021 07:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhFXLrO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 24 Jun 2021 07:47:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50CAC613CE;
        Thu, 24 Jun 2021 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624535095;
        bh=rkb7g6RrAfrtdrgd6Tf8cTWBC4nfH976znPeOl4qto8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pOBNTFp1wns21bK3cLVRk+Gx0uwFKSuUkiNXGgF8lJ7oHx7CdPZSz0X8df5GB9ut0
         inrihUnaENK56JOUoyUB79YeXB+V5DTXSj/UAJirL9l5zNlL+SEPluM5oezcjmfdOy
         4WUhd/dk/L9VvncpkGiZSXKeK6g0cKi1SRyV/+QEqr99kV3WLC35Fp1YamAk1pHg3A
         HKUy3VS/+/JYbATqqY2JrwyKhwG1nJUXFMssruuy+Nw4dH8odMSj8jnsWfTZ3SIPFv
         TKaWoGhifozLOjj/ECn+Vapfb+eA+o85RSq9fMk5eOpAIyS3kAczx0GcE1T5dSocY+
         HCwIRr7MWJLZg==
Date:   Thu, 24 Jun 2021 12:44:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     lijian_8010a29@163.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: Re: [PATCH] spi: spi-topcliff-pch: Fixed the possible null pointer
 exception issue
Message-ID: <20210624114430.GB3912@sirena.org.uk>
References: <20210624105056.167233-1-lijian_8010a29@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20210624105056.167233-1-lijian_8010a29@163.com>
X-Cookie: World War III?  No thanks!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 24, 2021 at 06:50:56PM +0800, lijian_8010a29@163.com wrote:
> From: lijian <lijian@yulong.com>
>=20
> The 'data->pkt_tx_buff' is used after called
> =E2=80=98kfree(data->pkt_tx_buff)=E2=80=99,it may be null when it is call=
ed,
> and null pointer exception may occur,
> so judgment is added when using 'data->pkt_tx_buff'.

> -	if (data->cur_trans->tx_buf !=3D NULL) {
> +	if ((data->cur_trans->tx_buf !=3D NULL) && (data->pkt_tx_buff !=3D NULL=
)) {
>  		if (*bpw =3D=3D 8) {
>  			tx_buf =3D data->cur_trans->tx_buf;
>  			for (j =3D 0; j < data->bpw_len; j++)
> @@ -621,8 +621,10 @@ static void pch_spi_set_tx(struct pch_spi_data *data=
, int *bpw)
>  		__func__);
>  	pch_spi_writereg(data->master, PCH_SSNXCR, SSN_LOW);
> =20
> -	for (j =3D 0; j < n_writes; j++)
> -		pch_spi_writereg(data->master, PCH_SPDWR, data->pkt_tx_buff[j]);
> +	if (data->pkt_tx_buff !=3D NULL) {
> +		for (j =3D 0; j < n_writes; j++)

I've not checked to make sure that the dereference can happen but if it
does and these checks prevent dereferences it seems that they do so by
simply skipping the writes that were happening which will result in the
driver just silently dropping data, probably creating serious problems
for whatever SPI device is attached.  We should ideally carry on with
the transmit, or at the very least return an error if things fail.

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmDUcB4ACgkQJNaLcl1U
h9BKBwf8Cbf2h7wD7pP0qwku78wjJrZXdhvRVLqCX5SUPv6gZqKBJJSrd5ZoABPS
TDSuXhf6FOhYQclnv1tt2YmiYZehAxVh613gUzOoXB/vYqyteY2wsvEzV/Fgo+E6
hFSjGDpixzO86/pzC3HQo6HTo1S9mPTkXHPfXDqjB/QnR5oWn5jyJm4ZKhz02PXT
z39Eg4N3IBgAXhaiRa3tVAtewboIuswFfG7j/Z/4keMQm2A7uh7oxacjG+jgDyd9
dtmNrnGsSCrxzYT8x2psZgfi6qt2tb4VeDKUt5pXhHinmHPNQcd2IVTB/nycmY8w
MzcVsDmrZmGmpjh9IWlusuvMUwBWew==
=u7Ze
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
