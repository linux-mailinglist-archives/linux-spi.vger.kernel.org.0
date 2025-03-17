Return-Path: <linux-spi+bounces-7177-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CD1A65A99
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391427A32A8
	for <lists+linux-spi@lfdr.de>; Mon, 17 Mar 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDCB18C337;
	Mon, 17 Mar 2025 17:24:30 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FC18A6DB;
	Mon, 17 Mar 2025 17:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232270; cv=none; b=KVe8DaDckBDiEvb9L1MO5QjcC0s7R8kR0zrAmpnaN2TGHRlZdKYUC0jAGbnoSAyu8UL/wlNf29SOvvmndjJ+NyLM7tih0tu3G5QxQu8NRsuKNgTIxuKtddP2tFbqE08Kawi7oo3TFI2bMof+lijoDlg61pIZFlcBpN8ZwzjsLfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232270; c=relaxed/simple;
	bh=zbbR6WbFaC4VlMNV/gml+ZSldzu+moegdui9CEsqH7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJwiby4Q5TakEO9zG5KfzZY+hTzzaEzNPaqJnIo7tpaK4ckLiyAbOEtxsEoFrQ3MTTZ/OynzRULQoaA3kVSJyDiaUmB3cSwPLO6XWCy9A7z9JSWjukWXGI5dr4nx4SZOE+CoI4afhKqh6/dhRzra30qgR3xgsHsDLSPHTnAi0/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5114C4CEE3;
	Mon, 17 Mar 2025 17:24:27 +0000 (UTC)
Date: Mon, 17 Mar 2025 17:24:24 +0000
From: Mark Brown <broonie@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mKVuPqVh/OxM585l"
Content-Disposition: inline
In-Reply-To: <20250317-solemn-debonair-sambar-f04fa7@leitao>
X-Cookie: I know how to do SPECIAL EFFECTS!!


--mKVuPqVh/OxM585l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 09:56:43AM -0700, Breno Leitao wrote:
> Hello Mark,
>=20
> On Mon, Mar 17, 2025 at 04:45:31PM +0000, Mark Brown wrote:
> > On Mon, Mar 17, 2025 at 08:44:01AM -0700, Breno Leitao wrote:
> > > My UEFI machines with tegra210-quad consistently report "device reset
> > > failed". Investigation showed this isn't an actual failure
> > > - __device_reset() returns -ENOENT because ACPI has no "*_RST" method.

> > That's not the case, it's returning an error because there is no reset
> > controller discoverable via any mechanism.=20

> Sorry, I was not very familiar with this subsystem, but I chase down
> __device_reset(), and I found the return was coming from:

> 	int __device_reset(struct device *dev, bool optional)
> 	{
> 		acpi_handle handle =3D ACPI_HANDLE(dev);
> 		if (handle) {
> 			if (!acpi_has_method(handle, "_RST"))
> 				return optional ? 0 : -ENOENT;

> > There's no specific handling for ACPI here. =20

> Do you mean no _RST method as stated above?

That's only happening in the case where the device has an ACPI handle,
the SPI driver has no idea why the reset API failed to look up a reset
controller.  Your change is to the SPI driver, not the reset framework.

> > It's also not clear that this is a false positive, the
> > driver did indeed fail to reset the device and especially for the error
> > handling case that seems like relevant information.

> If the driver failed to reset the device, then device_reset_optional()
> it will return an error code, but it will not return an error code if
> the RST method is not found, right?

> Sorry, if I am mis-understading the code here.

Clearly if no reset controller is available then the driver will have
been unable to reset the hardware.  That seems like something it
actually wanted to do, especially in the error handling case - it's a
lot less likely that we'll recover things without the reset happening.
During probe it's possibly not so urgent but at other times it seems
more relevant.

> > At the very least the changelog should be clarified.

> What would you add to the changelog to make this clear?

For starters the mention of ACPI is irrelevant to what the SPI driver is
doing.  This sounds like a change specific to ACPI but it affects all
users.

--mKVuPqVh/OxM585l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfYWscACgkQJNaLcl1U
h9CdMwf9HG+W0/aFm8iS2Lnww7hNSddYKsFT9JGqqbd6NHP0gTTAJcjrJmauPW/+
uRbvYzVP7ps9l53qUJZaYoY2nbrywHmog1aV4bdes+XrWGLOixff+NsV7P3OmleR
DquV/mN6H1IQ4C8uCPJUE4br/wfqNakpThSRXAAhhYgShwm38WMAjH2fV1XprU4o
P2FAjBQAWXPq6HdQ96zkNSWhgyLk13F1vHT8YBCaCnpZ+EFwM4gtK0vFxBNzyCzh
o5v5BV9TlA+U1jJviDltp4BYQ7ZmHcJehbEIxJNJSWO3fDh/IHPp2LodWYDs5GJh
NtFMyB/t6cj2H0ED1Uq2WXwvDwvA3w==
=zlnz
-----END PGP SIGNATURE-----

--mKVuPqVh/OxM585l--

