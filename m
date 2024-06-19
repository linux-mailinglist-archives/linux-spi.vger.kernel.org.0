Return-Path: <linux-spi+bounces-3474-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BEA90EF82
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 15:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D42B20B1E
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA7B14EC78;
	Wed, 19 Jun 2024 13:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ+SVYGq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C014EC42;
	Wed, 19 Jun 2024 13:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805393; cv=none; b=Lph7eshj/4tWmc0r8q+5o9YMh39sSgauQXLPHbCmoCy0pXpAfQdoObu1ZruI1SdbOR/cJmytVAQiPhZy+g9oYa58KVVBAGQaGmlIUDXjB8a7v9+imzDpJxx6+Q8zOUvSFBQ1hkYHx4iR8S29ybrStvGs7tb5/F///bopHIg92jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805393; c=relaxed/simple;
	bh=kO6IjmVeNjj5CEjr9nJQJniaZCK9I+ft04bhBCrTDpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAJRG+2IRZ1AevNn8ohRabsP+QEQUrSqqoKkgvUIv0NXSPhJFRt6LAe+bekzLNPoidIHftQ6sSA5pFQVQzFm5qXnDBi9V94AKixicVGjPo7doNnFXQlWjGaQsLghc6UtiVEMI/4jgdgQQ9WUMtL2TTFwOMm9CNP6x0DyniniYOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQ+SVYGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C31C2BBFC;
	Wed, 19 Jun 2024 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805392;
	bh=kO6IjmVeNjj5CEjr9nJQJniaZCK9I+ft04bhBCrTDpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TQ+SVYGq58VJVFZ+tqbFKeJOJQGu7BqiY/NXEt0CyaqUipQQyBens8+wJt/tqyr/L
	 ZUBdYIc8ApdfpLn3I1jI3snSc+KSrAXIRGJlYKq2l79Hhkjhxu8tbS1FYSzu4cFhlH
	 1A0MffOG/4QHw5gl3N//3KFjifAXWmrrZ2JCat1k0N8SyJ3/lELL/PrdoQAEkIxiIV
	 LoAdsgCKmIF322g+m2xKIFBmD8eVDcF0Kachy/5Pjn76e1yTUqrGk8qGxC0vv1z/4g
	 Kj5IHbmPBadu1LQVC17uA68RIIcdwZqsSTXRDkeLNli7mjU5oGBMr9VXxy7Hp1fARv
	 n3I6MpAWgGabw==
Date: Wed, 19 Jun 2024 14:56:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH v2 1/2] spi: cs42l43: Refactor accessing the SDCA
 extension properties
Message-ID: <4b967df1-9aee-424a-8318-ac08b0031f07@sirena.org.uk>
References: <20240619121703.3411989-1-ckeepax@opensource.cirrus.com>
 <171880144842.113265.13864100805243474696.b4-ty@kernel.org>
 <ZnLcjO67FH2weX+y@opensource.cirrus.com>
 <d7502ea4-03bd-425a-8566-9ab0a6ea32e1@sirena.org.uk>
 <ZnLftHS7RLRRQSk/@opensource.cirrus.com>
 <ZnLhbQmxyMJ9SAhq@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OUgZW01sFqGm3Td0"
Content-Disposition: inline
In-Reply-To: <ZnLhbQmxyMJ9SAhq@opensource.cirrus.com>
X-Cookie: Don't I know you?


--OUgZW01sFqGm3Td0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 19, 2024 at 02:47:25PM +0100, Charles Keepax wrote:

> Ah I see I think your applying to the for-6.11 branch, which is
> missing 60980cf5b8c8 ("spi: cs42l43: Drop cs35l56 SPI speed down
> to 11MHz"). I can send a version based not on that but might make
> a bit of an annoying merge conflict later?

Like I say I haven't looked at this yet.  I will tell you if I can't
apply it.

--OUgZW01sFqGm3Td0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZy44sACgkQJNaLcl1U
h9APywf9FQ3UxkcCaqcbkTYuGEL+ob52NcDguUcCMdSNxNnhp+Mo70qIrFqZUORu
/9V8TJ6H5wl/Swj3xoGzTLnF8SNddyyVR2x+haT4HcnwcJD1fTMRg83QdjfYLW/n
xvk/Ypp5DpiM4A2k928dIAbZa1oyxmp+tk4yZ6lGS+v7wIiMqbQZ33g/iaaaqybr
ilJIo5y14I4Gfk5Bc0C2zHGmFLV/ZtdX5i08bA+D7uICDzMk/yubeVjE9FIpJj4U
cn7pFt7FP8dyKbq9iNFGsTP/YMfOqHzjOehPyu0rwlvdfUwev1Kr8yyUSDOSfETG
3R5CDGbLU4ubhi14yKZbZBUdjqxYtA==
=95hX
-----END PGP SIGNATURE-----

--OUgZW01sFqGm3Td0--

