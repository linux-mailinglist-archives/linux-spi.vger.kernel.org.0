Return-Path: <linux-spi+bounces-8110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A4AB5945
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 18:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE0E4654C2
	for <lists+linux-spi@lfdr.de>; Tue, 13 May 2025 16:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00782BE0F0;
	Tue, 13 May 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAt/MNrT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A484C1A3A8D;
	Tue, 13 May 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152207; cv=none; b=l8HOIg7lU0uUN3m4IwmmElOsH90zJJ9Bx1LS0xehD8LdI02k9PmD91URb6oZXOm/neSoJhM1ztf48kw4HsqgeIP2C7L2M5TyXg+NhBNd33IIJEXLI7jCBVGZmaxi50UGkKnP7QlmnhcSS7a0mOe0YaxlIlRVyESsTv1ajBremA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152207; c=relaxed/simple;
	bh=13mKWnaxT5MXOzb611tnGX4qcvA1eYL6YYsoXT+cCMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWWuoXcsTa9Qy9DxQpfXCVU7geruwg+9LPGJ03qjZwsEdFArULidUazfLzQ+mXksrgv4gxRbVTgr4iuJHYnxbydSkQ2L+iNTQEUhV/+klJna8n6ObUTlyoFVgyJHy5bvKgQqwXTTIl6EtZflAa3bKUGZ/imPwYqB68OAjfl3xkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAt/MNrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11CE6C4CEE4;
	Tue, 13 May 2025 16:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747152207;
	bh=13mKWnaxT5MXOzb611tnGX4qcvA1eYL6YYsoXT+cCMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QAt/MNrTxn0iThyD5AdDAea/tfvEikzi7gLLDWNg+JTnRnYZv9BL8rnTb4Rb+BXIg
	 hOD6S/ILAkSW+iVMOcn5vD+dr416w/erglIQ6cWTHBPIzFobTUM5iho+39yV+bxjn0
	 hE+gy92whnf4qQoYbsmXpCDJDzShjiyeNqlOu3rZqSVP84MHHjhUKmy7SfCfWbdH5k
	 dRXxRNIh8/D0VBDHDezRgX7z1k0JBiDPe6PURk9FNiYmADV3Qr3+68cPIPL4Cc7zLh
	 P3YWAJKG67QJfnHhZBpidVKLDh43rQURIx4J1iSn5R9ObjA8DgoscyEEwBGcPe1baU
	 pcPsSpGyYXXZg==
Date: Tue, 13 May 2025 18:03:21 +0200
From: Mark Brown <broonie@kernel.org>
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4] spi: stm32-ospi: Make usage of
 reset_control_acquire/release() API
Message-ID: <aCNtSVldu1yEO5rE@finisterre.sirena.org.uk>
References: <20250512-b4-upstream_ospi_reset_update-v4-1-982c6f7886ef@foss.st.com>
 <aCHlfED7b-W0pGXY@finisterre.sirena.org.uk>
 <c4a2ccb6-b052-4cce-8bfc-26bcae2a2e2a@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="F0dhLWNHSbTNzAtS"
Content-Disposition: inline
In-Reply-To: <c4a2ccb6-b052-4cce-8bfc-26bcae2a2e2a@foss.st.com>
X-Cookie: Well begun is half done.


--F0dhLWNHSbTNzAtS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 13, 2025 at 11:47:16AM +0200, Patrice CHOTARD wrote:
> On 5/12/25 14:11, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> This patch has been submitted on top of reset tag reset-for-v6.16
> due to dependency with new reset API devm_reset_control_array_get_exclusive_released().

> How do you want to proceed ? Philipp can take it on its reset tree ?

There was no mention about the dependency in the patch, please resend
with information about this tag included.

--F0dhLWNHSbTNzAtS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgjbUYACgkQJNaLcl1U
h9Cw0Af9GroN6ci/01CzKHevwNZB5THla+r860LWr9mzjOxwBHeDUf3Juey+6Pny
iDYe0dNqRLZ1xyoUqEjs1z/4ATnwJuWPLwju6P77kc/OGmTCL9rV1Fr1W6vVixBl
Fxqd0hwYGI42GoMREKv4F7bkFn2zDKy0/MKkch5/ZHORnVduiT3RAjeKmMJSbNsN
37wzzu+RQ8Dhhabqi4RxMwZz8mwvP+WuzVhFKTcTJoN0zUOPs+DZLuVECQoTprzk
28lFBw+xOzUUKKHKB3nu0c9yogV4a10VyaLUAkjFUqikHYz4sqn/ZP/5j1xqpreI
DQKwo74c3UZRaWjJ0sCEX4f4eGIVcQ==
=D6uF
-----END PGP SIGNATURE-----

--F0dhLWNHSbTNzAtS--

