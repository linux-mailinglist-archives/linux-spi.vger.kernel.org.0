Return-Path: <linux-spi+bounces-6412-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94EA16DBB
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jan 2025 14:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 357EF7A2B08
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jan 2025 13:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0701E25E5;
	Mon, 20 Jan 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlqwG6us"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE291B85DB;
	Mon, 20 Jan 2025 13:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737380999; cv=none; b=oZC/rctrjjQn5heNN+Sl7jXhQo5x7+XzLTe7gxIdORbfKgWKYdQUA7qRoRGYxMfjDonAdj+SSR1CYTkPFCP65wpjiKnXlu802Kd2B9/at7L8Ofb/N3U2N7VSSskPoXhLidMxiApaGE9OMqRU4ICOzC7qWSZ77FIMzM3DffhudJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737380999; c=relaxed/simple;
	bh=ekPT5VREXyTo7IvgpNJfGqCy+Q9+hG3P3Q6HvU7wtDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNhJ7TBJxh7oinMu2s0OP1qMl398OgpAGLssmh1Pgmd4CfZgkYbjSbNM+wcSeHpjXsc4sJT0MlrHNGFz6qnVol469qN4K0HJCS/v2FkKS4EGwt3evpiriSCv9HFPU2/zA5sBZoxek3IgGjwsBUaADKHclvK/pajjYJdIu+Yjxdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlqwG6us; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E79C4CEE3;
	Mon, 20 Jan 2025 13:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737380999;
	bh=ekPT5VREXyTo7IvgpNJfGqCy+Q9+hG3P3Q6HvU7wtDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlqwG6usKeVgktDjvMgMWW+p+paYghSd0qaE9dR8dp6y15JyrWZREpXw9RPWUdfLu
	 v+F+RQBQqUs88VHw47QMppmQvVfFIAHpMg2brKZEPJnvDkaM0++DoUjCSQITb0PwXi
	 CQD2T5FAROtQO3+vFNBlGt1zq+AMe8Cd7m3+zDfRvOB93d7wpOaKefl4dVAallBDZ6
	 i5jDpkCVGySyethrRbxI/BmEyvFzF08eMKkDI6LWz7UiLipq57OCMUIjz/dIlrJJsf
	 W5FKcUa3g8zPX/43Fr2TKeCbBKLYxJyh4C6DXU6t/qwWmLTDKjXpsS0iSoGYdtxiWL
	 gdUJ09dogpfpA==
Date: Mon, 20 Jan 2025 13:49:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
	linux-arm-kernel@lists.infradead.org,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] spi: zynqmp-gqspi: Improve error recovery by
 resetting
Message-ID: <c1a3f172-700e-4079-a501-b3f3f08b41aa@sirena.org.uk>
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <5942e111-24ba-4d1b-bd4f-6b81dcc6c5dc@sirena.org.uk>
 <87h65xi977.fsf@bootlin.com>
 <1026d44b-0907-4835-bc95-32f9bbcf4831@sirena.org.uk>
 <8c9e6a12-e64f-4658-94e8-77469f393a0e@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9dv0D5YciXBsjgUa"
Content-Disposition: inline
In-Reply-To: <8c9e6a12-e64f-4658-94e8-77469f393a0e@linux.dev>
X-Cookie: No lifeguard on duty.


--9dv0D5YciXBsjgUa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 04:46:23PM -0500, Sean Anderson wrote:
> On 1/17/25 13:41, Mark Brown wrote:
> > On Fri, Jan 17, 2025 at 07:31:08PM +0100, Miquel Raynal wrote:

> >> Yes, unless the timeout is reached for "good reasons", ie. you request
> >> substantial amounts of data (typically from a memory device) and the
> >> timeout is too short compared to the theoretical time spent in the
> >> transfer. A loaded machine can also increase the number of false
> >> positives I guess.

> > I'd argue that all of those are bad reasons, I'd only expect us to time
> > out when there's a bug - choosing too low a timeout or doing things in a
> > way that generates timeouts under load is a problem.

> There's no transmit DMA for this device. So if you are under high load
> and make a long transfer, it's possible to time out. I don't know if
> it's possible to fix that very easily. The timeout calculation assumes
> that data is being transferred at the SPI bus rate.

In that case I wouldn't expect the timeout to apply to the whole
operation, or I'd expect a timeout applied waiting for something
interrupt driven to not to be fired unless we stop making forward
progress. =20

--9dv0D5YciXBsjgUa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeOVIEACgkQJNaLcl1U
h9BBuQf/YxmGXFN3bvsT+wvdAmzRP3BLKBHbrKm6SRHibYXb0uzIv0CnmhwcxPeI
gRPuv9X5KJUEeWBnK/uErCuisfmGB68sIo7lvvCKrwhMaXZmqfFt79QACig5QQDz
JASKZt13yublMzZQPAxrn9q09gB43Tqt+rJMntTijfL8f6Tk0fTT8m2FFSJRAGaJ
bfdLIgUWLDKyWDRCoJCP52A8XTf5wTJH8DV8iS+sW349p7tnfTrVNVk+jUnDz6OR
oEUMqc3Bk2JXGLMETvnwI6pVeVS6EIsmXLcgOjNAMbBHeg2HmESlViwi9aCO7bk7
ErHBsB+skFh4mx4GnntI2Zvoyg/tsg==
=dRmQ
-----END PGP SIGNATURE-----

--9dv0D5YciXBsjgUa--

