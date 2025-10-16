Return-Path: <linux-spi+bounces-10707-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F9EBE5518
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 22:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5053C483DCD
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 20:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191412DA779;
	Thu, 16 Oct 2025 20:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQrf2G3q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEDE1CEAD6;
	Thu, 16 Oct 2025 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645240; cv=none; b=VHir5JALNmkefVbDchy0/EO0viJbjpTRAYuxdqae8nN8NunVoFIZe/J/T9ARXxAPLZNiKS65IRhdqmCFlfTmpOl0U1aKElRFij1l23iiKFR76lugw4bo2VeeM0bvcTfLP99l53v1UGIUTiIk/TwoFU7M95XzW0mA+bOVXOu4ITk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645240; c=relaxed/simple;
	bh=b8A/8QJefHFzHEQJtja+BTUUIvgOL5xaNp24xSIDQ6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CydxPdCXJiJcbggW2u+gYriFy329MmL6tdCgsEoqK6cvUVMUos2+6nOexx4NgMdAZNHg/OyOB8LYRtevp7NoYZ8zIc7W48YWS2r42lO04kQtw2yokTcyN+YFa48cWsQ+0LlanffcABm3P0uMedNh0P3cwGsZChvnnrjzl7X7EbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQrf2G3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8367EC4CEF1;
	Thu, 16 Oct 2025 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760645239;
	bh=b8A/8QJefHFzHEQJtja+BTUUIvgOL5xaNp24xSIDQ6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FQrf2G3q7IGQ262axDmLxmlGTpFrCUt+iYRq6W12e86jBm2ZmAotSRTpJ6wI0YhkG
	 zQc3rkjsCpGzgo2oHXA/QeIwkHkhwKCCYfo4qrWf38t04DSQDb5LHotVqrSjeBk1Bd
	 8SP0x1nhxv4CYDnZs99wIDtF//r6OItKdOBq60V0drFqVBjiDD+hycPHBhidREjeXu
	 YstiqBLk9wEufOPcVtmWsgDUGhQxkRHIMIaO/tnfsOHAOCiUMOvk9yP6jVZ3EVc0nw
	 GUDyhT9sD/ej38NOmSkBODyy5ifBXXRlFO6EkYvV0iAFKQll6OyMf4nmVt9wZIZzrV
	 vRQ3x9dn7/THw==
Date: Thu, 16 Oct 2025 21:07:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: (subset) [PATCH v10 00/16] spi: airoha: driver fixes &
 improvements
Message-ID: <c4393e20-3fc8-45df-be7d-5f80dcb069bb@sirena.org.uk>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
 <176064054115.223781.11856902416382505599.b4-ty@kernel.org>
 <6255f959-e37d-4582-88c0-f3808f9701a1@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VlH0SB1DgdrCjiBy"
Content-Disposition: inline
In-Reply-To: <6255f959-e37d-4582-88c0-f3808f9701a1@iopsys.eu>
X-Cookie: Whoever dies with the most toys wins.


--VlH0SB1DgdrCjiBy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 11:01:04PM +0300, Mikhail Kshevetskiy wrote:
> On 10/16/25 21:49, Mark Brown wrote:

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

> If I do fixes or change a bit description of patches not applied to
> linux-next yet, should I post a whole series or it's enough to send
> patches based on linux-next?

You shouldn't resend already applied patches, base your new work on
what's already applied.

--VlH0SB1DgdrCjiBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjxUHAACgkQJNaLcl1U
h9BKoAf/W0hMhMelK+3lqNj1jeD0jDoQibBDbhBV1hWA9On1GlISCjan7/MV9jEz
wN7SXElGXKskOQNxNgRmNeaWl2XzvFzPQLKHY+cdM+PDr8CpS7Rf2MgVrwHtgFRv
2omdimPf6zi+b0Po9gv8FKpMTSKVcBz652KI4hvtllBwcpnMVVJYCJIkBVf8XTAP
peCwPUcDBnHPolj/GIf/oTJ8hV90oU/ZB5mu4jBoBWFcWcDGgG/wD5T5dr8tISUs
ocxD365zsJhMoiUTvyxPNB38ouLVDD6y7cAl29WonD4wUwQaeHXQj4L+gXijeH6O
fi+vIf/XBhXkMoEYdu9SJ4McZrwMZQ==
=R1yd
-----END PGP SIGNATURE-----

--VlH0SB1DgdrCjiBy--

