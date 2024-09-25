Return-Path: <linux-spi+bounces-4962-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89F1985E7B
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 15:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1ACAB2A1C7
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 13:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C50211724;
	Wed, 25 Sep 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9GkXUzA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC6521171F
	for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 12:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266326; cv=none; b=SSvWwm3Ka7EMyjf2HjlIOofOFJbz1Z1yvZj/Q9uSah1yhnxbS7Rs7eiwib/ZLYfYMErPjCb1yPpvMUSyVdFaagatYfWfO1+5MOVoA6FuoovUJtLDHd1+n3gLL910FR9zNbv/us0jKA2EqkGbQuqiGnHj/fxupDLHW5OoWKSi6Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266326; c=relaxed/simple;
	bh=88pJgz/zRDkRfegbNqu0DcnadOc9zp5YlxV91SRrDK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXoQ3cQQN+h6jw1RhdZdDQCrfVliyem49PBgGdkjMpXLRbfR6zN27zRg+c6TCA/Q5qcEnC/hI8aOB1vphpSRxeXeeFSjk5M+Wb03E7E+kz/hoIpQTajmZUfoO9rjRXbYKeIa/XWZXJb7NZ6XC73Pl2UOhQBph17ghXByDl1Mixw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9GkXUzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3FAC4CECD;
	Wed, 25 Sep 2024 12:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266325;
	bh=88pJgz/zRDkRfegbNqu0DcnadOc9zp5YlxV91SRrDK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9GkXUzAkTgGktPWxw8k2pED21oOEqD+9F8NvHlB+DnwI1ekhYxnIc4rAvdlhfJ5t
	 xFGe3EG3rFSqUtzJWByl8b2hcyD7D1dUAjfEFYVqqqd+O65AO/ZX0eDE/nk9aWcBmL
	 3em718ZjGjrxx/Q+rsE4o4R3blBh7kASO3wu5hTmNFuBaF/TgaH1K1Gd0pvn2G2tU5
	 Y6S+oPANR4KRekbIIVPJzimv0RCRO45R9YbXdNzxQkmv9vhu5YoMwbdaU6Gv7iVz8Z
	 k4yU/jkmNYCk7lIOWTIDvdmn3IXlJJmUT1wOxBzZqtKu5JmkqSp/HRI/zn52kHcvom
	 oAVL7iEFK0u7Q==
Date: Wed, 25 Sep 2024 14:12:00 +0200
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-spi@vger.kernel.org
Subject: Re: [PATCH] spi: Switch back to struct platform_driver::remove()
Message-ID: <ZvP-EJZtGkddIWPy@finisterre.sirena.org.uk>
References: <20240925113501.25208-2-u.kleine-koenig@baylibre.com>
 <rv3skxgyilvscnrwxwhhtqkcdie4u7iezizhpb7qymwumlbyam@wa24gduwblpk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9DgP+H8U+DpUhEQY"
Content-Disposition: inline
In-Reply-To: <rv3skxgyilvscnrwxwhhtqkcdie4u7iezizhpb7qymwumlbyam@wa24gduwblpk>
X-Cookie: Editing is a rewording activity.


--9DgP+H8U+DpUhEQY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 01:41:44PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello,
>=20
> sorry, I fat-fingered the subject prefix of this patch. I fixed it for
> this reply. Please tell me if I should resend or you fixup s/usb/spi/
> in your tree while applying (or if you have other concerns of course).

It's fine.

--9DgP+H8U+DpUhEQY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbz/g8ACgkQJNaLcl1U
h9DyTAf/YpGo++wGVPCwq6oj39e5Vh11F8+SgpCKEXSOzlQEoDWnaQgYZU+4Bn3O
LNYh3KiukOuV6+GUSEg1TEkMwx/JFIaX1LWyNJAZqlmuii9eEJ89nYmxOvpqSFUF
EceZKx1ZncYkdFeV0EDDRRIyOFrlAlJk40CUYTp2AtdwFIJHM/iGrNkoGK22bu11
g6s9cV+4KSffoO1gl7w/bhttD9Orr9qAHkL5JKe6tokdA9u8GfXWDqGvN5Uu7F36
ShDuYAcVtiNgCac4K5FBajFejjphTqSf+80C89s+b59Kg0nDnwmoyYV4gLWL0lCK
CdPz/ze4wKwLcJ1ea9vpGkqQiRZ/Og==
=v0wy
-----END PGP SIGNATURE-----

--9DgP+H8U+DpUhEQY--

