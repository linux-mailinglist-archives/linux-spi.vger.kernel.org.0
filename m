Return-Path: <linux-spi+bounces-5090-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88ED998D36A
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 14:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184D5B20A95
	for <lists+linux-spi@lfdr.de>; Wed,  2 Oct 2024 12:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF66B1CFEB7;
	Wed,  2 Oct 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLLuT003"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76371D52B;
	Wed,  2 Oct 2024 12:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872677; cv=none; b=VVvOcGX6U/etmoFxheBSgovasRjUdSQOFJcu7p9EsvVVfQTnQYecVE5juIjK+/fovQz/I+MIqAqDWdFIhBbFalyhFao/XOgdSYoQJJh9h8bPFHQvzyidJXGcjYrBNp32OHuezpeDHISB3o4O7hCQQ2bCXPLPKVTOQYwmXhOGy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872677; c=relaxed/simple;
	bh=Zr3qG7yk+b1Bz30f5tpvH6L2wVymtxZSeG5whbD2oJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0aLf4EtlasojECoKlXq5cXAtXBNmwxTyBT+eH6gj7u06wDnX4QnOJmwwA6T5TkwH11hcxy2RFkqHkiTRlqXTNqObUnEGF2zrj4kS8OVxvkf8DzC1Sgqu439yRqHJekJ2xLgXkZcFa3txcZtumxTx/e08zWvgaNy7rIkbX+Sk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLLuT003; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176D1C4CECD;
	Wed,  2 Oct 2024 12:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727872677;
	bh=Zr3qG7yk+b1Bz30f5tpvH6L2wVymtxZSeG5whbD2oJA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLLuT003JhieKmOhkLoKQKc8vJ7bitISz/Bcd9ykRfQ/2qDVbiNoxL4YOBoTWiekR
	 Ujz3a7qqx6Fok8WSvQxP6E3653xCvQ2bjli3JH8mSPLJ1uOiubvEElMtVPB1Zs/PtG
	 FE/tOmQPfnebZJdFh/onH+b7zkTgO/fpSQKH4ozX2evCc1En4KIrE6I3RNA2I2+ZCZ
	 Pc/IhOpdt98vuWG8iPYuxrpQ7vQ1kmmyx2PV/Aw4yxiXgJu/Q8QEzCcTm8WXG6GJW/
	 BVp5BaGF5dlw715SsXXUYoHDadYjwHNfLrLi02VSdqtdUtHyXiCty5KPBcqdPD/5N8
	 11y9BoCGtIHwQ==
Date: Wed, 2 Oct 2024 13:37:53 +0100
From: Mark Brown <broonie@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>
Cc: linux-spi@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: (subset) [PATCH 1/2] spi: s3c64xx: fix timeout counters in
 flush_fifo
Message-ID: <b3c48d09-5b5e-4a10-8735-b734c4ff3401@sirena.org.uk>
References: <20240924134009.116247-1-ben.dooks@codethink.co.uk>
 <20240924134009.116247-2-ben.dooks@codethink.co.uk>
 <172782953761.2314893.16208330510622172964.b4-ty@kernel.org>
 <xbfyok2lvzxknt5aiaa4jgrkabl4eircidpnuktux7vetp6dek@cniaesdxaj4d>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6pQHZGjt0xhSpyuW"
Content-Disposition: inline
In-Reply-To: <xbfyok2lvzxknt5aiaa4jgrkabl4eircidpnuktux7vetp6dek@cniaesdxaj4d>
X-Cookie: Know Thy User.


--6pQHZGjt0xhSpyuW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2024 at 08:07:32AM +0200, Andi Shyti wrote:
> On Wed, Oct 02, 2024 at 01:38:57AM GMT, Mark Brown wrote:

> > [1/2] spi: s3c64xx: fix timeout counters in flush_fifo
> >       commit: 68a16708d2503b6303d67abd43801e2ca40c208d

> This still had some pending comments, besides I think it also

There were some suggestions for stylistic changes in the code but
nothing that can't be done incrementally (and which expand the scope of
the change).

> needed the Fixes tag.

I'd raise the fixes issue with Konstaintin, that's b4 not picking things
up.  I don't generally worry too much about stable tagging given how
eager the AUTOSEL stuff is.

--6pQHZGjt0xhSpyuW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb9PqAACgkQJNaLcl1U
h9DvoAf9EzBBbLlahjUfDPuqiPT06N9D8olIXY+LCjLE525bwesTer92K40zbYWI
LD2nuVJLL65SEZayREacgSoNzwP01OL2U5tA8FUrr3hibeolifOO3XDIQwTLLeIf
6oFso/v1J7RiCliYMFSLmPMhA3xNJjdbCk5BrkcuL+zC5WfEW/wUGABDNYr0hzgB
t5taaPQXf9X6ic/pS19hnYucZERSzvCJiX6iWcOtYJisbdFjraYI9zA/m1pf/suN
XkPU6L6vpOIGImd4PirHEU1GtMyDGbfCFslshFlKfZ/8tqwFWPrcNvHOJ1/xKH0i
vQ89y285LNx7yhPhFXTjlraY4biMKQ==
=ezJC
-----END PGP SIGNATURE-----

--6pQHZGjt0xhSpyuW--

