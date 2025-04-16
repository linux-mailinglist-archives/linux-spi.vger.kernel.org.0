Return-Path: <linux-spi+bounces-7622-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C49A8B8D5
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 14:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4BDC3B2464
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 12:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E90A23D297;
	Wed, 16 Apr 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NafguyGv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312DB2288D5;
	Wed, 16 Apr 2025 12:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744806209; cv=none; b=ZgDun8OKrc52ZFr60kv3oJyS6nYPkaXWqIZQHQcM/zjOjixzbCTqlxkDDiSVSCaxKSjn5hLO/9zbalfORqG1aFzAtXtF5s9MMtVQE5OqNYT4/16oy+1D4lQBsz6ztXxXPedrBx1IHdc/xIa0bUwEKiwyNYefzJZo+UDktuhC1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744806209; c=relaxed/simple;
	bh=P56Z/IiDnB23WkuikAUBMBExc1JHKB4iFe4OzvZkFfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omys6c5WtWyS0RgD1Uy57k+cEPSVyFUiwK1UzpjSE1pdi6w81DXx+rhsKn3O6vpUtzsqExzi7lUNMoyx4JEYuhHQGDtXwBTV8L47gkM0Kydw5+R00nuEnkZAnxvRIcgnsndGPKj3vr7+RpcE+uWGbIZMQwVsv0KYeZz7yScp1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NafguyGv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC786C4CEE2;
	Wed, 16 Apr 2025 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744806209;
	bh=P56Z/IiDnB23WkuikAUBMBExc1JHKB4iFe4OzvZkFfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NafguyGv20ELsWAGUq6gX+fnFbFkRb5H334d5h3lxUl7pwLz0MSmF4cuPDMLqYcFe
	 t16I2n7/WZO88iKhSLzVp+jYfOLbuFRyIK5Pb+1GXNI0b85fmW+9keG6ysnD/u6AIe
	 tum5V5fAbgE1+o6GfvSF93o80ZVgm8pGH4nm/5tVk7+3/Wq26jrjPZyiVwv/uicABU
	 xMTwEN2wNvrX07ZfXZFh0Leskf8Ic0xhWCzEBvrEdcLGjCOr15kCe9R/NnMtlUA0/a
	 6qbFjbpRmcUtVl7D+ZLowsxmNDPPabvG+zfrVSBHWS+DAtiV3NCgFWi279vjMyeBb4
	 A+GyYceskYKAg==
Date: Wed, 16 Apr 2025 13:23:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
	jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com,
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com,
	smangipudi@nvidia.com
Subject: Re: [PATCH v3 6/6] spi: tegra210-quad: Add support for internal DMA
Message-ID: <44923989-c102-4fdb-a95a-96962b2b79ad@sirena.org.uk>
References: <20250416110606.2737315-1-va@nvidia.com>
 <20250416110606.2737315-7-va@nvidia.com>
 <1484e250-bbb6-4d1e-9285-2ccf1b8215fd@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1+die5o1YKGXNoaP"
Content-Disposition: inline
In-Reply-To: <1484e250-bbb6-4d1e-9285-2ccf1b8215fd@quicinc.com>
X-Cookie: System going down in 5 minutes.


--1+die5o1YKGXNoaP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 05:27:47PM +0530, Mukesh Kumar Savaliya wrote:
>=20
>=20
> On 4/16/2025 4:36 PM, Vishwaroop A wrote:
> > Previous generations of Tegra supported DMA operations by an external
> > DMA controller, but the QSPI on Tegra234 devices now have an internal
> > DMA controller.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--1+die5o1YKGXNoaP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf/oTsACgkQJNaLcl1U
h9BBWgf/T/fpuX5zgXV8BczuJRzrU8Jrh6qt8bgpncRfHuoXzhUBmixR2IlRL9Yt
g+N5j2NezSezySp5y02xfnrUZ8ArPBDkOG/GKGApLx2NIS5uSuMBoGvigOGbk/ZA
HFmRgrJ3QjibMU/ZZXBjecCMEkLt/NTZxViGgED1QkqmnYMbP2BrKbWQizPw2s+h
Vfkl3mDqINQN/RrA+TqlluodQDmYeYNOobZ+5nVmbVKLUxSw6jDw5PlqVIxeQgXP
navmqs9qHHBjKicrJKHdFHiImHF43kkslfSN9Z0ffU6hqzNnJ6ihtdb+qd/Hefof
c3V8dIBvIksRuCjvuJ23YSgzJqCbJw==
=4OgC
-----END PGP SIGNATURE-----

--1+die5o1YKGXNoaP--

