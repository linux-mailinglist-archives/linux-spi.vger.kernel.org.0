Return-Path: <linux-spi+bounces-7377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D402A77850
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 12:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE1A18893AD
	for <lists+linux-spi@lfdr.de>; Tue,  1 Apr 2025 10:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B871EFFAE;
	Tue,  1 Apr 2025 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaU3dOGM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602F51EFFAD
	for <linux-spi@vger.kernel.org>; Tue,  1 Apr 2025 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501593; cv=none; b=XoQ/Cz65L7rWx0qPQabp//qe3fYyPvuKCLxesdlaCHrf2HjWkLOxjPXwu9fm79YRcW7Q99ZwBiRA5UBCfNGaQGlpicILv34N0iuiv5IavMv23dAiOEzTg5Yww+LQNMhW0NTSWLl8jz12AjlFiGfMKcbrPjm3sfVIUjZ7Uqu2YvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501593; c=relaxed/simple;
	bh=cFSB5SsHSm2CuDC4ukZ06g4lCht+ObovHbv2dHikEtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qW8CaBTNo++OJGTa64qBuNgfjRJQHeys3bCaQfxyoW2HfjDMx1YwgIgfQt/jOlaQP+LY5m/u+xwkWI+YMEXbZZEPJEZ4zRcQWo4N+37d3ibUIbAlDorYlePDk+F9qUJwZAwaEARvI+lWNGdqMEO7v/KPetQb+IOhVIMA1BF97yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaU3dOGM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8634EC4CEE4;
	Tue,  1 Apr 2025 09:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743501592;
	bh=cFSB5SsHSm2CuDC4ukZ06g4lCht+ObovHbv2dHikEtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaU3dOGMwda4Psqgp0UTfhsvfk0mosSBe+HvC3nLkmH7z35Yr3aAzfo0djFnYdzqp
	 cWrGHY4OC8NTVHnZ9sx9WtR0fNsrFjTaLOUBPge5By4JV0pdzMP5QEdm8wA7s1MtMp
	 iCRH0ZHBh1Zfr2qDHMlPobw2KwkP4yNTSBPbsvGFYvPFpKn/DdKt7LSFpS0xDd9yYi
	 qAcCht0W1hLM7KwcIX3VyhvQHhn+mRenXoVmA9npSYBNQWQCMwwEUMo+sAID9aV3RC
	 W2lz0hvDd/+oZvZYhRc/0VlojiWpzXePXLOOKPL6e9JESfx40y1xMo+oPsGURjugiN
	 sT+pu/f+aV/Qw==
Date: Tue, 1 Apr 2025 10:59:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-spi@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Steam Lin <stlin2@winbond.com>
Subject: Re: [PATCH] Revert "spi: cadence-qspi: Improve spi memory
 performance"
Message-ID: <5cf480d7-a5bc-44cb-9c40-11473be7d328@sirena.org.uk>
References: <20250328173500.3687483-1-miquel.raynal@bootlin.com>
 <01d6ed23-72e4-4c86-8b1e-d7d9fb440c0b@sirena.org.uk>
 <87ldsktdb1.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VyhpElZcgKQ3tkaW"
Content-Disposition: inline
In-Reply-To: <87ldsktdb1.fsf@bootlin.com>
X-Cookie: 15% gratuity added for parties over 8.


--VyhpElZcgKQ3tkaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 01, 2025 at 11:56:50AM +0200, Miquel Raynal wrote:
> On 31/03/2025 at 14:24:19 +01, Mark Brown <broonie@kernel.org> wrote:

> > Please submit patches using subject lines reflecting the style for the
> > subsystem, this makes it easier for people to identify relevant patches.

> I'm curious, maybe this is a semi-automated message, but do you have a
> specific style for reverts that deviates from git's?

Reverts are just normal changes and should have normal changelogs that
follow the standard style for changelogs.

--VyhpElZcgKQ3tkaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfruRMACgkQJNaLcl1U
h9Drrgf/WVmnF4yM89UhPFgeE2VDmwGUr4j3c/lY6szrbZmiJAHF5UkeOrdfScJS
lQcYEf26KWMaltKV0sNiF9f7QTZc9YefcUGIZifiF8UdxCM4N2YadRqqrGDgDdJb
XjISgnTA7EWwwMqKIq/Mlp2T0fD5PecZxVKCRQ9m4m3lMs2ym+l8V+0lRxTMddwH
Y2FxHgGTuNzXTirK9cPWoTl3423F+EjtCUWA7icaMgvkXQ/0zKVBzBYeH0FAudfL
l7ZvjaW+7MHRzk7Ad5C7nqlc+TU7m5zZMsRBECGq0yq8VpGu3Zjcaq8L52O06/VW
3eSTp+LxVi14+tVSLFA1IFy26UgsVA==
=HZJ3
-----END PGP SIGNATURE-----

--VyhpElZcgKQ3tkaW--

