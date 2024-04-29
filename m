Return-Path: <linux-spi+bounces-2601-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5538B5D4E
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 17:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 374D2281A12
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 15:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6CF128376;
	Mon, 29 Apr 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZlfewv1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CCE127B6A;
	Mon, 29 Apr 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403560; cv=none; b=Ay4VlytlT7CYKBCumzQtTYc5LfViUvz3h+ulhqCvFwsoJKjB7/s6ULSc29az0U2v172wfhYOU8qDPnSp3FcRUCo8RSXjHwOVt8xX8QY1xq6nCukfWhpHb9UGK27WUd35jAETQBKJRRq4xjdrtaBghMacuk7YnvfXcVcgnI5/Nfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403560; c=relaxed/simple;
	bh=c9sdq6F9WJFd1i9w40KS05/T2PaCG63oCnCQk7bF6vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqS5DDX1I54GVmUOJ/Vs56frFvSyYtt5KR+ujJ6cqQilSmmwiSTEWW/GYvL8uLab9iQfVttBGpzSbS4BMStTE43/N3xzCJUPQbYxOPwXoLcc0k5MaULp44TLKnZWN3q7ZZpY9A0nRKg9PEW2Ny2aZwvWL3gM8kcBbLjefQa6dVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZlfewv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7F0C113CD;
	Mon, 29 Apr 2024 15:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403559;
	bh=c9sdq6F9WJFd1i9w40KS05/T2PaCG63oCnCQk7bF6vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SZlfewv1pSCieVmCJoaYyLZ3mJJaS4Cqy5N/4NWtC4MG4SkoJMXx16kr7QFzBaB6R
	 UI3YancX+cKSmBdJxFS3reR6ulvqYivsCrzHt1yXsKYi+PsO5EsJ665U9RRd9rZKvL
	 ce3n7ri7w7Aw4xM7GrKHFFFYsNMbVtSw30IHK3oyzUiQHlf9CjJoSx1sEis8zvstmM
	 8gqUxAgSjB+pD9TyV/lCBkBmoRXVcKMSA61JjgJMiBmmh+LBdy1WNiVV9JmfxYyfqS
	 b5kTf090RHZJIF/XW0ItiLTlImIby0l784C9ywWHdzSTpyslyOOz0OcUJQvxmqUSes
	 9MNh93yUqwlIg==
Date: Tue, 30 Apr 2024 00:12:36 +0900
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-spi@vger.kernel.org, conor@kernel.org,
	lorenzo.bianconi83@gmail.com, linux-arm-kernel@lists.infradead.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org, nbd@nbd.name,
	john@phrozen.org, dd@embedd.com, catalin.marinas@arm.com,
	will@kernel.org, upstream@airoha.com,
	angelogioacchino.delregno@collabora.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH v5 1/3] dt-bindings: spi: airoha: Add YAML schema for
 SNFI controller
Message-ID: <Zi-45Ontw6F7fnbC@finisterre.sirena.org.uk>
References: <cover.1714377864.git.lorenzo@kernel.org>
 <f3377b323f00589e6b7ed7950c4840d18129238b.1714377864.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/APeMIOzbfjLlGbi"
Content-Disposition: inline
In-Reply-To: <f3377b323f00589e6b7ed7950c4840d18129238b.1714377864.git.lorenzo@kernel.org>
X-Cookie: lisp, v.:


--/APeMIOzbfjLlGbi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 10:13:08AM +0200, Lorenzo Bianconi wrote:
> Introduce Airoha EN7581 SPI NAND controller binding

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--/APeMIOzbfjLlGbi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvuOQACgkQJNaLcl1U
h9CMMgf9FB2jCTDyO6nnRSM7nipNPs0d+3D5H+A+7z1SWqXNAZMv1DW4pAtt/+P1
cL44ZFemqNc29gE5hOEDjQ0GCiAVtE6IoSZl/RQt3P0qiy+SJ3OuApUiDpUkLJhl
yROzu8zzGVNwn7xMAZqZGlXaCcFC25uZmeCR9E7Z2xlEYBLMgq3e0GiHYPhhcPau
yN0CMaKSYgIx0Sb/eB4bPKCapGD/9vc6U+iTuyDSTdCtJDvc3chw90mlJxQwPFnC
G8Qmcs04+dX6HDspqYZObC+FmQudfC43R6uQstmquOKKv9qNiCbfSRL26bl/19ba
tLxibGAwAEKLH0i7lOSPWf4arrk1Fg==
=AE9x
-----END PGP SIGNATURE-----

--/APeMIOzbfjLlGbi--

