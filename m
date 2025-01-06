Return-Path: <linux-spi+bounces-6232-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 492E3A02ADE
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E13A6951
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jan 2025 15:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4BE1DDA3B;
	Mon,  6 Jan 2025 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWcP2euO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D899E1CBA02;
	Mon,  6 Jan 2025 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177814; cv=none; b=FSWa31RSaJcI3p1lh8xUPJ1TkhS3+Q57feuTevy0K5/Y4si8ZYzdY+6Qymfe+teJ9doVYdlwU2n+WBH0g6oKGy4on5E77afhxS0HFk+uci37dZjmz8HFmy6fybIRo3lGx8AxyBXD5OQlNyqQ1YhgIrUnmKW2eDuysvKDFd/w/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177814; c=relaxed/simple;
	bh=QwinYCQ2WjYTC2sOkCWAxpCU3ScrO4vQVvf7WAwcGsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0pdO7VYCyIyIOkmn0anm0EqUcttav0H8hui1IAyR8PcUQTFbpJ1kS53HmSbNIHtvTAwH+1iaBM8SaTBGub3c86aohpBGHotSisATQ0LI/7siw1PH2LlzTRutIrCxdXO2gHRXaXBrqKjgIhgcIxl6SbAoIQj2nrI1HS8eLwCaoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWcP2euO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570F0C4CEDF;
	Mon,  6 Jan 2025 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736177813;
	bh=QwinYCQ2WjYTC2sOkCWAxpCU3ScrO4vQVvf7WAwcGsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NWcP2euOlEdfcSXUUfE945mBDShiSXLQzL1ktnPsWHOpZNeNs8+eLxhIWnVvNcuNJ
	 K7337VpFEkdEe7g+KR40Gw1t8OFeFFy8oOUUnVOl3C5Bu6Mhdg/M2jSPr378ajnm0A
	 8626XTlWXH5tQQVEJWzzcNFlPD7YYQ9pBsYo+tCh+1Ek9On+3k2L/xXEO1O6RK90Sz
	 gmY12s3r8cy6cte2UhGuk9mMJ9TMmJvmKb3DtGapXk2IqFYUQgPMQvx6yTLCZLDFo3
	 zqKvW6Tibx1gM/+qnLncSGP1gK9PJri2objS9aUpcbFUO/kIp1UroTM/LClZlZOBIC
	 wmW50xvt+68gg==
Date: Mon, 6 Jan 2025 15:36:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, andersson@kernel.org,
	konradybcio@kernel.org, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Tudor Ambarus <Tudor.Ambarus@linaro.org>,
	Frieder Schrempf <frieder.schrempf@kontron.de>,
	Michael Walle <michael@walle.cc>,
	Pratyush Yadav <pratyush@kernel.org>, quic_srichara@quicinc.com,
	quic_varada@quicinc.com
Subject: Re: [GIT PULL] mtd: topic branch for spi with Qcom changes
Message-ID: <96bdefb1-4607-4a4a-8bed-b4d9b5971171@sirena.org.uk>
References: <87jzbp9hnt.fsf@bootlin.com>
 <87bjwkoxwh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AqRwxSb805p5WCuC"
Content-Disposition: inline
In-Reply-To: <87bjwkoxwh.fsf@bootlin.com>
X-Cookie: Do not pick the flowers.


--AqRwxSb805p5WCuC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2025 at 02:49:18PM +0100, Miquel Raynal wrote:
> On 24/12/2024 at 17:20:38 +01, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > I'm merging the Qcom series, in case you need a topic branch to apply
> > the spi bits (binding and driver), here it is.

> There is a breakage on x86 with this series, I'm applying another patch
> from Md Sadre Alam on top, so I'd suggest to not merge this branch and
> wait for the next cycle to take the spi bits if you're happy with them.

Thanks for the heads up - I didn't pull it yet so as you suggest I can
just leave it and pick things up from mainline.

--AqRwxSb805p5WCuC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmd7+I4ACgkQJNaLcl1U
h9Al1wf/Z38j6IMH2sQcchcR65v7clNd2dtn6xeFvosviIPsVcUw6Wsj5IwN1hPf
MMJBlaFeJHfo9zaiBJOmChI+QxHThedm9IkCTMiW79Xm3tOh2e3BVt/IeLerNPvj
J4oPZY0L3Qg8VLHwbBSFsTtrb/RLFcpFixplb4rBh2SoY9T6FvSxw6PYM1aaGcLs
zfmLo9l3UGtW3d+O7610V6aTzx++Ixig6dk5c9L8kojPvq/xgbYJmEuY8B/SL72F
eqDg+cUq9OFi75blmdoTc9d4dtcWr7xkwjqP1l9hW+v5oQgvwcwuuXVuFvPiRcU3
stfh6D6Mpd0ETLC2cop+97PBajux0g==
=SsOD
-----END PGP SIGNATURE-----

--AqRwxSb805p5WCuC--

