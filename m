Return-Path: <linux-spi+bounces-2958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8A58C9E07
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 15:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB571F2253B
	for <lists+linux-spi@lfdr.de>; Mon, 20 May 2024 13:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031E1135A5B;
	Mon, 20 May 2024 13:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QULXfonQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD646133425;
	Mon, 20 May 2024 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211208; cv=none; b=KQDIxbLPut1Y+/rpBneuNIkH5PYSGNZEQV0PfmbSZdKXGHuSUa1aBvyAMP18V/NrAMcpGhexm9rBaJkqDoMaK9PlQv/bFMV4jBECD7zGp+CA5xXfwf5gh5ZV1w0pAKSD6kN32n1Pp8BbORzXfMOpF/gAJx0npESw3XzrxuuoIyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211208; c=relaxed/simple;
	bh=+UeaMW3/A1z0Fn3F6ZcWZjIC6nbjZWIHxmEB7YaIsAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V04emHtuK3Y3rXAQ+Ta8F4lWEcrE8uPfp/+QpQ8gSbXsSrtOJn1TqO/vFmDNnBXWVF8m6erduD58pqGUVko6+Pjg0WoZnw4Q66ibUXs2MNvGf45NoPan2uIvF0LrBSWS6cur48ofWhNzqihyew6MPWSGfrgu/NpIDrCgyt2NgPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QULXfonQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D7CC2BD10;
	Mon, 20 May 2024 13:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716211208;
	bh=+UeaMW3/A1z0Fn3F6ZcWZjIC6nbjZWIHxmEB7YaIsAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QULXfonQPmw3cDXkbQK77O2AkUSg09xxKw8UUDqJ0ojMvtstDt1HvyM/1cnSaL4Db
	 1LoEvrGZ+U3q6pL8FZkbZNThxVK5legI3Ybez3hGyk6k9o9hlcUTW4nW5cxD7M9199
	 alJKR5Q+PBkg2HpDFP/afpwf5o2xTbrqw1RAky9Mt4sU4mVjAa16fWBBj3Mfk2g3s2
	 iIxDZtL/YrHqyQSvGJQZ3MheLkSVEb4lWOwIVQiEn9gtQN20ypjw44/aKrzw15YdKz
	 zFBv4MOfgYr6hCmr1OjpdLt1o1RSxqwh7iJO/RtJfjDELs69rS7tmQCL7onL14ryOe
	 R8m/WCtQm1a1g==
Date: Mon, 20 May 2024 14:20:04 +0100
From: Mark Brown <broonie@kernel.org>
To: egyszeregy@freemail.hu
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] spidev: Introduce "linux,spidev-name" property for
 device tree of spidev.
Message-ID: <1ec9e8e5-0818-42b0-8776-d9cfb0585f42@sirena.org.uk>
References: <20240519211346.30323-1-egyszeregy@freemail.hu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s+JyqRfoTwUi6FDd"
Content-Disposition: inline
In-Reply-To: <20240519211346.30323-1-egyszeregy@freemail.hu>
X-Cookie: We are what we are.


--s+JyqRfoTwUi6FDd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 19, 2024 at 11:13:46PM +0200, egyszeregy@freemail.hu wrote:
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>=20
> Optionally, spidev may have a "linux,spidev-name" property.
> This is a string which is defining a custom suffix name for spi device in
> /dev/spidev-<name> format. It helps to improve software portability betwe=
en
> various SoCs and reduce complexities of hardware related codes in SWs.

This seems like what udev rules are for?

--s+JyqRfoTwUi6FDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZLTgMACgkQJNaLcl1U
h9CTPQf/WCjngVabwHijSli/3fOm/oBG0ACmD1HiQNhWggtDXSd7m4XraU+1datt
042b7g6rUyQHF7joD2BO7OxXKLhzRIQpDxZkZQCJfcub399mJ5O64/ujvp8vpTXb
uBc+HbzQ6DGUoLvFtbF7fV6BTybVW5zU+NGcYPAByRuwOoFTVoRCVVHekcOXpcAe
cBHqq58rDxC4PZOyxwb8SZXih59MBRum7TLAdsagaC+T9ULbVesMrHzYFya9vywd
j+4RC1IjgDlKVHsCwWoL00Y+nKG7fTK8FfswoQBRysDSU93DtwOmwwYOEjLPaaDN
/km94tV190L68rfHtwRei1PHwVDaHQ==
=0POV
-----END PGP SIGNATURE-----

--s+JyqRfoTwUi6FDd--

