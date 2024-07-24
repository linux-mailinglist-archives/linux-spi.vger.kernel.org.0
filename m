Return-Path: <linux-spi+bounces-3949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B33493B07A
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 13:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45CA5282EB0
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 11:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84F156C5E;
	Wed, 24 Jul 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVavYBcB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E222481CD;
	Wed, 24 Jul 2024 11:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821177; cv=none; b=ppRev09KVxlJvYER/tQuoBycuLZWgpJlG1n/f1dS4Aw9lzB8qbNkAk6awM7nTHW9/67tbGo47N26E8mU4r9Eu8G5zVCHGS5ed7XA2du+S13ryadnNBiRYYMAEttvONNK/s3nVPJ3/g+TsnaWo1DOSFvTcN8AjBidWQS7Jq4COvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821177; c=relaxed/simple;
	bh=nnqgq9ztemtgfLjTFAP5+MDxvu+8MqpOsWppCHVm4ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu/EmAeRlGfc0tpxA6cG8jwwOYR11/jufzh74tvmyoo4KyR7TNVMjhk8BqtKbqbCdJY23bN3r3yYKcsYA7FROaNy0zGCuqcj1XBPjvs9wDmTSV0u6Ufs9QCZ/bQZQl2SaND1/upjWOsGx+kUq1jK6vZHLiNBY9lVkM6HDlUj1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVavYBcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C291C32782;
	Wed, 24 Jul 2024 11:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721821176;
	bh=nnqgq9ztemtgfLjTFAP5+MDxvu+8MqpOsWppCHVm4ow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVavYBcBzS7h93VQiakuaGhd1YyhjCL9s3In4J5On0DakVeXT4CY6cyZhMBzpF0OX
	 I26iDD//lBeN7wk3/yurc2vBEnYaY9CDUkAoQRPeFQIfs0T2QSGSOnddhqgg4dc7gz
	 jZR9s78QqaNc29wS43DfUXKu8oHfXSoIiJFCq5vt/9x6e007mS+x/Qn7r6Wq0dDuwO
	 FvnssHXClIjr2PQnVY72MKlM7c6cz7mY6ZP1Cq24CfTnNy9NLlF6vLjnUaMsD65nOy
	 t6L2d+1rg/Ax3rl9WsiLnjF/5o4fpxLy+ijDpAQjdAHaeYX5knJog41scFqUqOdoA/
	 MengKAFewlwsA==
Date: Wed, 24 Jul 2024 12:39:32 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: make24@iscas.ac.cn, linux-spi@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stefan Roese <sr@denx.de>, Wolfgang Ocker <weo@reccoware.de>
Subject: Re: [PATCH v4] spi: ppc4xx: handle irq_of_parse_and_map() errors
Message-ID: <514a8b85-e4f0-4b63-911b-69ab962ee591@sirena.org.uk>
References: <20240724084047.1506084-1-make24@iscas.ac.cn>
 <d8d29c4c-4c66-42ac-9e2d-821502b5f55b@web.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jQ458PBANBdPDbQD"
Content-Disposition: inline
In-Reply-To: <d8d29c4c-4c66-42ac-9e2d-821502b5f55b@web.de>
X-Cookie: Editing is a rewording activity.


--jQ458PBANBdPDbQD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 01:35:52PM +0200, Markus Elfring wrote:
> =E2=80=A6
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
>=20
> Does anybody care more for the applicability of such information?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.10#n398
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/researcher-guidelines.rst?h=3Dv6.10#n5

Feel free to ignore Markus, he has a long history of sending
unhelpful review comments and continues to ignore repeated requests
to stop.

--jQ458PBANBdPDbQD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmag5/MACgkQJNaLcl1U
h9CPcQf/TfwNZfeMIgNsdnwQ2yFwz0/+ZjQouqoOQ6DgQqTqQOFYdx+y5wXip/Kc
gmn7cELwO7WW//py8XbO08J7nTHU1dtX48zJHYkzKVIc4W4RTdPN2XlSajizLmXD
BjYFXUUgAbaijJUR9OT4FN2KO4DCcmq0fH+2VE25EuQAWO9TbSYdK7hosPJaATOk
dOESr8x7/x/AeakYn6LuOfj24AXSQutUvOyLux7JbKfsMrzMBGVov+RrpY7YiBFA
EG7uulme7+ihbDXUICCtmTSBV2bWts46bwrDZOWhDUQmKaZ6yaOhg3Ertf9xvIqL
Qn+mEVsYO17WiOC6I0F4yIZh47updA==
=ZJpK
-----END PGP SIGNATURE-----

--jQ458PBANBdPDbQD--

