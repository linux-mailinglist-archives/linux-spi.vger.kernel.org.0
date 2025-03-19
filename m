Return-Path: <linux-spi+bounces-7226-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D602A68D7C
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 14:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA36D3B315F
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C79256C94;
	Wed, 19 Mar 2025 13:11:37 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394E8256C85;
	Wed, 19 Mar 2025 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389897; cv=none; b=EYYtm+1I5OGVQejypbVhsKSHxLjg49JRrOLCtQTGc/xB961oS2F25li3CH6BWad8EH92d9VroQp0WV/cHahIxGgwc2QwXfhD/DoLeEclenoFxLO1jdrl3WU9eeaTx/VJtLh6owbgfAprg6WVJgJ5dZMI0xC+CoMUtS5piNDmEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389897; c=relaxed/simple;
	bh=9huppowp+KtkkZml9BTF1WTrMNxssBGuOz/gycuQT8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFONtIplYuvoyh4On55GSgNiNOn0qse6LNcOlh4T5jnV/jF7PabiHMs+PPQD2GhjDwiX7cUOdnX0/VsOvZ5Pjuj8MaEPC6M+x1AN3jrzWR0myCuQN9QQE/6uROMLSysv8ZnJv3J87g4cVvVrjE3Xv9VobrKVuWV4MsmUPpnL9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C3EC4CEEE;
	Wed, 19 Mar 2025 13:11:33 +0000 (UTC)
Date: Wed, 19 Mar 2025 13:11:31 +0000
From: Mark Brown <broonie@debian.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Breno Leitao <leitao@debian.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, noodles@earth.li,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>, jgg@ziepe.c
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <96c7cada-0e52-4182-950d-b736cbdf4d62@sirena.org.uk>
References: <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ciRcMA4KVLIkfejv"
Content-Disposition: inline
In-Reply-To: <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
X-Cookie: Chairman of the Bored.


--ciRcMA4KVLIkfejv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 09:07:28PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 18, 2025, at 20:13, Mark Brown wrote:

> > In that case it's probably more just refuse to probe in the first case
> > without the reset controller.  Given that the device isn't working at
> > all it seems like the hardware description is broken anyway...

> Right, I see now that it's doing a rather silly
>=20
>        if (device_reset(tqspi->dev) < 0)
>                dev_warn_once(tqspi->dev, "device reset failed\n");

> after which it just continues instead of propagating returning
> the error from the probe function. This is also broken when
> the reset controller driver has not been loaded yet and it
> should do an -EPROBE_DEFER.

Modulo the probe deferral it does make a degree of sense in the probe
function since there's a reasonable chance things are in a reset state
by virtue of never having been touched since power on, you do see things
like this as a transition measure.

> In case of a broken ACPI table, this would simply fail the
> probe() with an error, which seems like a sensible behavior.

Yes.  If we need to support these ACPI tables the driver will need to
learn how to get the hardware back into default state itself, assuming
that's possible and there's no FIFO clearing issues or anything.

--ciRcMA4KVLIkfejv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfawoIACgkQJNaLcl1U
h9DPHAf/dmDdWFoSPy3dFe6GWPEHnIKV/jPz9FM85cB1WqxoVZtchmPN0LCf1rp9
FPemeedKT3KRDE2io3C8s/eLsox7tJxgyQK7tw6s5T9bgo3B3HhJJy2OZMCG70M0
GuRRdUyL888o/l52ueAewTdOmgNrVS0/sjJU4yTMng8eYQDk5IdoU00tI0rkqB3V
k40cjlinUqpWMflqPjyEOI5X5ETywCXkN5Dmljnhkd26dP/8qLQB4bxuEbxz3Uso
O6BHu2UgCKxURy2oE6bexZyeFMGNeK1pWkCAMdT8FeZW61zSz9gYIH77UsN8iJIQ
ITNmfMvqCbeYQ4lN9WxFVtcfA9jm6w==
=Xoy8
-----END PGP SIGNATURE-----

--ciRcMA4KVLIkfejv--

