Return-Path: <linux-spi+bounces-9072-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B08C4AFCC70
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jul 2025 15:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9635D1AA62E7
	for <lists+linux-spi@lfdr.de>; Tue,  8 Jul 2025 13:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B46F2DEA76;
	Tue,  8 Jul 2025 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CGDdLBPz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1761E5B91;
	Tue,  8 Jul 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982612; cv=none; b=Ja/gAVkRxUmFrBp/Vxu7wETygrm6iL407g0E84Jme+udXtjtVddHVSL9XgGMhq0+sCYkjZ05GTF6W/sSYGQJKAA1skfmT2ZglDOHaoVTISvmifKAONy+iBdsPUZrK6OZrdS4+LorbOBzEu69+34PvmCnnSKoZItYZe8KcEME4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982612; c=relaxed/simple;
	bh=29g+uhpj2QzdZ423+An5/+0mpgfq6lvJTx/RgRs9JIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h93nEctUSVqGHWlCT7W3ZURmS9VCvkol0JLT9V0UDXkCKeAKwVMBwYJ5JcxPALY6QvWTSkgoRiUWGMLHk+voH0+w0a0IGRF+9x71P5SjCKD6tGlgSHXOBUf9WvkgVLxrLAs1PZYm2E4utz5DNd8hMPnWbVZqFRjkbH0CY2H77ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CGDdLBPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF68DC4CEEF;
	Tue,  8 Jul 2025 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751982611;
	bh=29g+uhpj2QzdZ423+An5/+0mpgfq6lvJTx/RgRs9JIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CGDdLBPziNsNLj2//q2YZHfQEIKfINZQtkKL3CD9FUYVTmjnu/BVwx1YODx3LSe66
	 JMGISY2VmKWjNHZCnEGjsecJ1gFTqM/2PZpFz9P1Uj0y2nNUXfvsfTDTVgFCBiFel/
	 GiDnG0aaryHhiCELTDUsq3c23EO7MSDt9pKHdtssJpcXbYIVMGoXWZ9tfi9xErRoKB
	 bVcUH4CMDl8yIhNe40PTJqHvOXMJr4C8YgmBbrbrW8QaofqrnXY5Y/TvssOK81x5GP
	 xPss8tOHNBhUtwKLxBhSZEcuY2RV9ImO4Jytft4x9a5wezJZS/uTmusTopAXsDxFID
	 S1Fwhnc6M86lA==
Date: Tue, 8 Jul 2025 14:50:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
Message-ID: <aG0hU5nbjLjTWS6p@finisterre.sirena.org.uk>
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com>
 <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
 <3ac88119-9980-42df-9e1c-c0ec30bbaadd@sirena.org.uk>
 <55ecc836-7fed-44d5-aa4b-94bc17894ef0@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WrWFthDkvK4JeMBC"
Content-Disposition: inline
In-Reply-To: <55ecc836-7fed-44d5-aa4b-94bc17894ef0@amlogic.com>
X-Cookie: Do not cut switchbacks.


--WrWFthDkvK4JeMBC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 08, 2025 at 06:34:02PM +0800, Xianwei Zhao wrote:
> On 2025/7/7 21:05, Mark Brown wrote:

> > Is it worth having a copybreak such that smaller transfers are done
> > using PIO?  With a lot of controllers that increases performance due to
> > the extra overhead of setting up DMA, talking to the DMA and interrupt
> > controllers can be as expensive as directly accessing the FIFOs.

> If the data volume of a single transfer (xfer) is small, PIO mode does offer
> some advantages. However, since PIO requires the CPU to wait in a busy loop
> for the transfer to complete, it continuously occupies CPU resources. As a
> result, its advantages are not particularly significant.

The CPU overhead tends to be higher (you can avoid some of it with a
dead reckoning sleep), but the latency vastly improved which for many
applications is a worthwhile advantage.  It tends to be things like
accesses to one or two registers on a device with registers where this
wins, 16 bytes or lower would be a common number off the top of my head.

> If PIO is to be implemented, it can only handle one transfer at a time (via
> transfer_one), and not entire messages (which consist of multiple
> transfers). In contrast, when processing messages, the SPI controller can
> handle the entire sequence in one go, which also provides certain benefits.

It's probably worth adding something to the framework to be able to take
a decision at the message level, for writes this tends to all fall out
naturally since the write will tend to be a single transfer anyway.

--WrWFthDkvK4JeMBC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhtIhAACgkQJNaLcl1U
h9ANKAf/TOPGLrepxVdVEdgQXME4De4Z1WJWC5NPGi72O7c3tqTcPlr7JVtjPorg
OSsLf4N4B8tjQZy/HHdpY7B1CgmiRU2EHrkGj0nJhJy2/HWG++cjbEOXp2IYvgbz
5OPv+8spjS8A3WipQLKHGelthRYC/vFjPmQ6AgYJvy0fhXrg32z99mtvz0+qY4+D
LxJxMX44/4sD7ODMSe39XOjNvEfJ1a1MRZqPehGdvh05H0D9qzaNiYUEpXBj2yQa
Rvtb3EmoXCMJR/1dXbXmVtIVnO5+rKOUHEU0eV8Payk2wldyYox43oPWkF6dj/5L
o/cQvnwE35OoA2dfZrIm0korHc8asA==
=3T3v
-----END PGP SIGNATURE-----

--WrWFthDkvK4JeMBC--

