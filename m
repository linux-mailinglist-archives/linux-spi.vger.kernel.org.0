Return-Path: <linux-spi+bounces-4390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0755B96355B
	for <lists+linux-spi@lfdr.de>; Thu, 29 Aug 2024 01:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4011C22253
	for <lists+linux-spi@lfdr.de>; Wed, 28 Aug 2024 23:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56741AD9F4;
	Wed, 28 Aug 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwmXUK3y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C78F16C6B0;
	Wed, 28 Aug 2024 23:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724887554; cv=none; b=DjfYQX+oU+1BT5FlHyE/SZ5VmgZBcxNSMHEcr2tiIAgZgc+4FtyUgYdCmF/7HIkDTbOL3sFD+QM59GCY78uNU55r88romf+cZpTojOtlJkc4Zc2HsfCOVW1nu+s0KmYuLZZz3+w5cGRnRB5OLucklGPQ6DJzPwVHjd0H6oIPVqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724887554; c=relaxed/simple;
	bh=Y3O1toRDNDojmdDwgxNMaHK3SbtdT1D1qQFC1lr+iMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGYFGfG+ZAHWwECMLOr1J8BOR/uZ+d3X+g+S887aIiyrJP3FdqMZXau2g5hlVtFIEyN00MBNAwBwDgYZylYpBSfCOWgehTtTlh/uXQXyoyY6NQpmURINMS8hoS8UsxoNegz0AZFHQuftQ1IxrEIF/Tqul9MmN4P8j3grYFfCdIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwmXUK3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7F0C4CEC0;
	Wed, 28 Aug 2024 23:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724887554;
	bh=Y3O1toRDNDojmdDwgxNMaHK3SbtdT1D1qQFC1lr+iMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwmXUK3yfmqCaw1agouAWAH1FkxF0PjSZ0hUE4JXlnPUmy+vUb46eTMfWM2Tv8sb7
	 QmrGZM0iTz7KtdtNQeGiu3uXDRg1hy4b/bbEX1cZ/QaxuZLZx4Q/5DbuFLzKyMY9h5
	 oDjBnk5Kh4MFhSVT/HDakNosxGi4Sw7mrYlR/YaOh79gqE1qzPXGkTB6yx5GrkCBlj
	 JnLV5BqhG4Nn6KxqDGPnpBrJO7cxpPOVTCj1MDg5F6zJLyN8JVY1tcpqwL5cxKztcj
	 zfdNW97s4dPnl+F6tjxyx9n6RlreAABRkN/rMly8llidja/8h99qQYsCJZ5jEaQGoi
	 z+oJkOETFVjcw==
Date: Thu, 29 Aug 2024 00:25:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, otavio.salvador@ossystems.com.br,
	heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH RESEND v2 1/3] dt-bindings: trivial-devices: Document
 elgin,jg10309-01
Message-ID: <0d6314a3-75a9-4f21-947b-194eaf1fe12f@sirena.org.uk>
References: <20240828180057.3167190-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sjSsBDRYzfDNfjS1"
Content-Disposition: inline
In-Reply-To: <20240828180057.3167190-1-festevam@gmail.com>
X-Cookie: You are number 6!  Who is number one?


--sjSsBDRYzfDNfjS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 28, 2024 at 03:00:55PM -0300, Fabio Estevam wrote:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.

Is there some reason why this is v2 and not v3?  b4 gets terribly
confused about what version of the series I might want.

--sjSsBDRYzfDNfjS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbPsfwACgkQJNaLcl1U
h9B87gf/WsHu9HDBTawryPAxLT9SeCnpesMndsZeDeHSICfh6+io3FxLGSTNKYc7
shA3hTic4oQtNsfLT/Yjr8G4JmhMBnfd51+0pqu4dtkxIIcVn6H0vmr1U5dTLU9x
2YOREdFOWSsMFLwrXyS6Jt60LLm1Itux38JLpE9BNt2vMgJvIDv0LraOijgGvhVE
z0FYKu/NgSzV5IUatx11o4CjyxYe97JYZFoXNdXMCj1vUjZUb6urJdw6VLIKFOCg
d0aR072BGrfGOzSRIsaKPDLTvqoOxHP2R8EnEETZCmV7PN8/nA+6FR90TVWeR0yW
R8MGFm74tGGt2Ie9dlSGG0ztAiOhsw==
=zZ7y
-----END PGP SIGNATURE-----

--sjSsBDRYzfDNfjS1--

