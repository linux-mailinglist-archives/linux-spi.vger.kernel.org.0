Return-Path: <linux-spi+bounces-12060-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC55CCD2D08
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 11:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF8B53015872
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 10:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B4C30648A;
	Sat, 20 Dec 2025 10:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="eEIN8UDX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F33054D0
	for <linux-spi@vger.kernel.org>; Sat, 20 Dec 2025 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766225597; cv=none; b=S8ZD3hCyBmnxL+D6HFa3s6M2FKaHrYhAD17CRZWp/Yw+MQiJYx70xWl9tFfjZWVIsjZPozAKP5VIk56ETgV5QIRmnMOO1febDDbwWC/rHV3kPHuQcBEE3WFBrX5bY/fWWioPJHpRIi6GgfVGx1XmRnLLzpafDQ98dwE85fR2qSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766225597; c=relaxed/simple;
	bh=gAuOBF3f0hkBgiPiqamaBypeCsXH+DhyKhilcONbXUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8npean3tWpxJ1HnUbOjFRZm3T+UjfTgsZ/CzFTKNxrsO0LZvxT2C6dhDse1PVfRua0DIquw9kaHT6qGSIgfPGdbeYLP/aFOHAhXJOq4/DunMAwIMHP3ynLjr8mwtipnPYSzw55BBSptVqTJIFIEtMaXjimYG2Q9XODYJGETEdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=eEIN8UDX; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=F1SZ
	nX8uTYw4RU9sPUVygoFCAsfV6eHNib4IP/t81Ng=; b=eEIN8UDXxIH+rs30AwRY
	CIL1rwiDribOOibHmkn6NLZp0HGGX3Sgsc9gvumblHPuaqWN+JOkwPAmxuTPjBTA
	A/3eW5ylnaFuTboCsyep7ogL/G1aBO8UJkZ7oKYXx1SndOIT+9uenUSN3qDee9J7
	4inf6khdqJxdW2tKSaYIbTfvLy87W4YDVlnv2oy7WWOEgBtZp2ub4rmXimn89XBe
	z8lL/CGiVwNBveGOvmVAdJfBiEBItxm077mjsjATxTFhb1OJToE8NFiB2I5mGnRs
	/WrhL+60bSIh5Hyo/ec2LT9rgJG9slYxp22PnvYKJiAMvz1D1UdGiBa7KhOprlMO
	lA==
Received: (qmail 3057683 invoked from network); 20 Dec 2025 11:13:11 +0100
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Dec 2025 11:13:11 +0100
X-UD-Smtp-Session: l3s3148p1@TgXycF9GQIoujnvT
Date: Sat, 20 Dec 2025 11:13:09 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Vaishnav Achath <vaishnav.a@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?utf-8?B?SGVydsOp?= Codina <herve.codina@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Santhosh Kumar K <s-k6@ti.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 01/13] spi: dt-bindings: cdns,qspi-nor: Add Renesas
 RZ/N1D400 to the list
Message-ID: <aUZ2tbK8fMoY4AZ9@shikoro>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
 <20251219-schneider-6-19-rc1-qspi-v1-1-8ad505173e44@bootlin.com>
 <20251220-sexy-feathered-gorilla-3a6aab@quoll>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KFHGkTmyD5jx9cyi"
Content-Disposition: inline
In-Reply-To: <20251220-sexy-feathered-gorilla-3a6aab@quoll>


--KFHGkTmyD5jx9cyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +      - items:
> > +          - const: renesas,r9a06g032-qspi
>=20
> This should be enum, knowing how Renesas adds more devices.

In general, yes...

>=20
> > +          - const: renesas,rzn1-qspi

=2E.. but this platform is old. We are at N2 meanwhile. Extremly likely
that no more N1 variants come out. And the other existing ones cannot
run Linux (no SDRAM interface). I think const is fine in this case.


--KFHGkTmyD5jx9cyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmlGdrEACgkQFA3kzBSg
KbYePg/8DJVXcRtDO6h5KAW0kqvin1jUALsHySkAu7Eu3i+HHRXTOKHEvotlaS7k
dthQirpnE9EItGiNuCpJ7M5hHTLcgBL2hILThtgJfhcY+UbRoCFs21+ASw3Z3Cqq
XPXMLpGUwVZ7QLipPuFJjdrjJnMAuSdD12cdZ/Wkf3VSiCJiMSgw0/5OPu4YgleQ
NNRf32p37pVT+kY73TdkeCNGWKbE43/Xiyn1DWEfqrGZ7+8wYZf0PqrvidAuHT3N
hwzytpsYPQLTvTq6vbABIMTLZ3W2d6bdfbMIG8lvF3Dn9bh5t8XWp7E8EZ8+P3DD
QUHx3PhfKApPtYkH5QcIgKKBWEr1vdiRF2XAN5WHXdOGMbVIxdK+zA3uQfz3oivc
CCXmcd06fYxWQsTPsK1z8d9pdz6QOmUfOnF5trDJF98yaXstXOw2eosAsAQNIfdy
lGZJnxecoQLnT/TDUBqw/PmlyBUG3n13nLPav5+Df6sBsRvP7hmMScTbSFh19t4n
jiDHPBSO3vPf3VBtxPpKD68avPfA92dVGdStF6hCNDMWsBPhbww1f4v+zNTs4qD0
i0YJESq/3F51Ad2s31SgHm5nkRv+eybv3nYVwmHq8IqV9+hGemJBQ6ooDE/2RIM7
CrOixMM7DrPn5kqlV4mbNpS0HyFvI0y461cIYawSudWtZav2+7s=
=rMG6
-----END PGP SIGNATURE-----

--KFHGkTmyD5jx9cyi--

