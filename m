Return-Path: <linux-spi+bounces-5048-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BCD98A646
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E70E284A4D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 13:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2873A1991BA;
	Mon, 30 Sep 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE8l+AW/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6BB1991B4;
	Mon, 30 Sep 2024 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704388; cv=none; b=bn53/+730BY4q1C6LQhVTuF0JeFMwrF1DByWuxjFIJ0H9kiJiyitxg90Rh4LgiD+BRsXsx2fbF2RC80YS1yc0IVerJITvTqKNkYrt6YMBTPvp3dHxqjbaFmiI7xK2ACkRM26S95gAkAfunlNdotUSAQpkNTpgzQaFFscBFX04AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704388; c=relaxed/simple;
	bh=IVbbaE/GIT9RrXhfSo36FUKPNUq7GI5PpkcP9RyVysI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4GpRWPDsnrZgq6m6nkVhleV2Uw4f+DBOGJSo1easS0sw+7AM/NhvXLGEORg+XemT3GCBGJN1gYXhAR6HrI7J2ZEEWUYjzQv84XpoFNY/FeJugrqlLphzBDAR+GND1mpaGxsk/lsuiopNcNssTCZyNKC1yLyIu/ODArTn018fZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE8l+AW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9C2C4CECF;
	Mon, 30 Sep 2024 13:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704387;
	bh=IVbbaE/GIT9RrXhfSo36FUKPNUq7GI5PpkcP9RyVysI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rE8l+AW/ev6vEpAHKR2WC4QEXYNs3hT6guF09tK8fUmPpr7f5MTgRhhgdEHQM5HNW
	 uBOdna5ZPT3FbI12W63Xz76mxB7HGapWHhjgkP4mFIvSi+R9zODIcPRNBVlSpW2X34
	 gr1BeEIUHZ+/FyWFz/Zjsg4goMxZXAr/UZwLMuI66WUsyOpEHKn+ahVp3nHF7hb2Ej
	 VVnz0xpYa3L/VCc/ALl+XG6tceAQsCvR2NG+Nf/JZmiD4csPFWc/9tUqeTYkBj1/G7
	 Z069eM3WBeuiOD5eSW6H0rzg+yQI+c987yuHlC6znSuN9UIqZh0244NU8fhcpDStm5
	 QxDhvCSRUU5Ug==
Date: Mon, 30 Sep 2024 14:53:02 +0100
From: Mark Brown <broonie@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 04/20] dt-bindings: spi: add PIC64GX SPI/QSPI
 compatibility to MPFS SPI/QSPI bindings
Message-ID: <fbad3270-b6c1-4b9b-8a08-a66be80e7156@sirena.org.uk>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-5-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="usUdwGt1tk5eoW0S"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-5-pierre-henry.moussay@microchip.com>
X-Cookie: My EARS are GONE!!


--usUdwGt1tk5eoW0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:33AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX SPI/QSPI are compatible with MPFS SPI/QSPI, just use
> fallback mechanism

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--usUdwGt1tk5eoW0S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb6rT4ACgkQJNaLcl1U
h9Cylgf/SeKuUdqmIkH+cHNwBAWWRYyTEeqpUfZwfyyjxHpdrGqUQjadvhIrxKD5
+qrhBGBLCMXstynEo9BNUp0hcDk1nymSPYDQDzB/ZMSPheVHZE0EI6BpiY0/fYJO
d5oKcrC3wWNqJCdl9Yp2bJh95Ivm/4BmqoYay3vcIHKweyfgEBRrEq3DM1vknzTJ
9ou8L7M4+7syL7PMKeE8mCjhV/B2tW90OvK2m1J0Z1P5q2pDIVB6dQGz3y+6CDlg
/9OLCYuDK7YwhE1uTbpkx0q8D0otd0kuUJRpbYun4mTcd8HhlloYEch7U2fSk+cP
dw/45fsCzNOFyRmSspFhmkfgtfLvzA==
=Fi9v
-----END PGP SIGNATURE-----

--usUdwGt1tk5eoW0S--

