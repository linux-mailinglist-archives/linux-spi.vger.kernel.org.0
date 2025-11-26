Return-Path: <linux-spi+bounces-11597-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A94C89CA8
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 030244E4D2A
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E5327C05;
	Wed, 26 Nov 2025 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vx7FzULc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0E2324B12;
	Wed, 26 Nov 2025 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160499; cv=none; b=OL9lRiilRDBYvSad3PYrLjXinZXC6RhztdmvCsZg3BCU3BEnC9ZHHeb7zEjTg6LjnU3z9RL14qyR4jgNGCCGa6AcyC/fgG0CBRDaJ1K3RqPJte3iVXvtHayV/rE/zIBQEpuXObK/azyUH5JN9isazrtKnLtlW8XiUdk2IBvIz9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160499; c=relaxed/simple;
	bh=NO+jxwYGQUW4/91VscWu18mwzEjbOCfwJE4IsBb1eQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pg0DP8zlwQPtHzMDzt7XWoSR77O46FYscvHTOD8JNzYX86cquVK534yF2kmyIAzOdNebGZNWiZly9onbP43h/MV4OIRrwInv5LZ//GE//vEvLpxf8n/KZmVbR07GuuVo8TQx4p745apFwTxuf/rF0e0MUrCglTUapAaZHeAo6IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vx7FzULc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F09C113D0;
	Wed, 26 Nov 2025 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764160498;
	bh=NO+jxwYGQUW4/91VscWu18mwzEjbOCfwJE4IsBb1eQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vx7FzULcO0TdPJhmsFSTyyENm9jzsyV1K/NL3PhKtDIm18vH/XX0DpIZ85ME7eXEN
	 EkMXXr4zUeunJaNIwo9z1IOnD8dX+fQQ4APn0CFuwLhvvCiYu9pNNpIBCocMZFeFAW
	 DwgYP8XFmHckgTLJp06huqQ364/Mp92VkaCL+lRsQZD/ygTTDoeNm4R1D8SkwpVkVA
	 JTBDpwjm+aROiKG7d7cuvYUbnQd4gGVaue0rUoqXRVVXHzODe9VuMmxHWZ6pmVCOWg
	 HnKNxIqb0wLPWoh2KZtODUuDYtwQAnzeINpZJ0hIHvSC37waXh9V1oKHHDn3D/8SKZ
	 in5IqWDgo+v8w==
Date: Wed, 26 Nov 2025 12:34:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/V2N
 SoC support
Message-ID: <b3e31f95-fa05-4a57-8983-88f237240068@sirena.org.uk>
References: <20251125214529.276819-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdXD3f3jN2F7c+yHmEb1C5Byc-e=sEXt_s=UpBQLv_F=Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D9wZWYxvylpqnlTF"
Content-Disposition: inline
In-Reply-To: <CAMuHMdXD3f3jN2F7c+yHmEb1C5Byc-e=sEXt_s=UpBQLv_F=Pg@mail.gmail.com>
X-Cookie: I don't understand you anymore.


--D9wZWYxvylpqnlTF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 12:38:28PM +0100, Geert Uytterhoeven wrote:
> On Tue, 25 Nov 2025 at 22:45, Prabhakar <prabhakar.csengg@gmail.com> wrote:

> >        - enum:

> Please don't bury the enum between two items.  Put it at either the
> top or the bottom of the oneOf list.

Can you resubmit with this reordering done please?

--D9wZWYxvylpqnlTF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkm8+wACgkQJNaLcl1U
h9AA4Af/eij7XdCljgN2w0Nx4vLnSql+00snr7h6ezyVCVdAtgr0QK/B1Nyq2gxl
0OzZSPlGBEbDKiZoa8n/cWfpVOS37PKYfu6jzqc7O3QIQEGZK+YM5/KN/Iibxgul
MVCDJwAxwZcBT+14WlG7cLgw0YIxMQQ8fDaUS1bCa4XbUtkW9yzwVCg1WPvD7cdJ
qjmI3jkUrXPAVceCUtaMz59AMK9dBCYr+Bq0LjKy8LJ42+aVbiJ1ILa1jzBCZ5Q+
Zv6sdeSktvUz+9fY+WtSEjFW5VklDjMBfKWGQopo8kMwZuXkxCytk0qeF0GdmU/C
CoKbCldluaShOeDQsPuztUXsR5nVxw==
=gpLA
-----END PGP SIGNATURE-----

--D9wZWYxvylpqnlTF--

