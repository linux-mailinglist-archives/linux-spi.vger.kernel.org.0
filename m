Return-Path: <linux-spi+bounces-11727-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA78C9C748
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 18:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F47F4E1E07
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 17:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D895F2C0F78;
	Tue,  2 Dec 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNcrFJQM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C90B2C0279;
	Tue,  2 Dec 2025 17:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764697587; cv=none; b=MbQvpaTzd458N2bqYYuxkc90JUndsY7xXCMb452WHILrHd7qgFElUukQWcHJ5NL4Xer48YwdrHmFpaK69qnWC59pzavEFCrSz89IoTn5MvnmA+Oge3lEPYcNJ++GQo8CvPXKHNb91lEQBVpNxiYETF06UbIgrvW3BWiXrDr6RNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764697587; c=relaxed/simple;
	bh=gIML5wYoTfC0TIigs6+dw32h2205dHgrvcul2gGjs/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnICgiuV3Ky86T0ep2HkflD8QCQ0z7aDwOJTVHEQ3a2StDGuGLzvSY0lrMMGzEWLro3C8ll3kLh/iRQ14mKgD9s2r9ViDsPRGm0y6zJWeW4krivfuJakIsmbAGiGrXi1qdyZ4BiOgDKz0cRAj4gGUYFfksGqo7wnnz00QRnysJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNcrFJQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE55C4CEF1;
	Tue,  2 Dec 2025 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764697586;
	bh=gIML5wYoTfC0TIigs6+dw32h2205dHgrvcul2gGjs/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tNcrFJQMWgUZnoTGMD3JKTle8x3QW3/j2wPVeDjhPJUa5JLe8gQ/T4kX5d37rRrRF
	 aAANcv+D292UxdKmLQGEl1TPZepwZX+sjPn/4LU5dK7jsmZbNwXzV1p6BahkY5fgq1
	 cMg/gRGXV0Qf8OQMKf2QfX+nWptP60LXTcZ8/l0rnA7USbKSzVZazpdlA2Jz3xjh24
	 nhZBRXQ8Q5sowU06jBxpUpeNqPfjWBUcGuxXhVwkJ+lezFkQDzmfmBWHlCjmh7D85k
	 y4ZtmJwXj5mpv5yNr0P0IUnCCzXvs+/swRfeqfg+2Fam31aEsdHWcb+lGmuXsDpBP+
	 3fXLT3HQkNNXw==
Date: Tue, 2 Dec 2025 17:46:22 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 05/12] spi: fsi: Drop assigning fsi bus
Message-ID: <5d5fbd29-2753-44b0-8fe4-5cf854a5271e@sirena.org.uk>
References: <cover.1764434226.git.ukleinek@kernel.org>
 <948f0de217633462f79a3fe2110f8f168f19dde6.1764434226.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YC7TrnJcx5B4flrv"
Content-Disposition: inline
In-Reply-To: <948f0de217633462f79a3fe2110f8f168f19dde6.1764434226.git.ukleinek@kernel.org>
X-Cookie: Beware the new TTY code!


--YC7TrnJcx5B4flrv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 05:57:41PM +0100, Uwe Kleine-K=F6nig wrote:
> Since commit FIXME ("fsi: Assign driver's bus in fsi_driver_register()")
> module_fsi_driver() cares about assigning the driver's bus member. Drop t=
he
> explicit driver specific assignment.

Acked-by: Mark Brown <broonie@kernel.org>

--YC7TrnJcx5B4flrv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkvJe0ACgkQJNaLcl1U
h9Bu7Qf/TCMyg9IPJQLXb9FGpcCFc8UiZRmdCTgQD3gJQW7X9p3IZJpHOs5Rjsas
VaG6ddWigAuwBUsqpn7O3M7mOnqDUXcOBW4LP+14SsEmCZ3TbbopK4amA7UnHwS5
ITpG/0851ow0qDiIgnY6969PDpNLPVS2ClqaMSaaDaMVbPRqB3ykY60tepO2GPy4
w8NLcN0Lq1CD1NvqIL5cWFruVlaFSmAdILLu4x4YGS6TayBo+T7I86AzcMNnd5C5
uzMlWgope/Rwyj7P/dO4nWXwxDG/K/UEHu4AzypW4ygfDTYWyN6VMWtTGTEhLrw3
WAs5VaifcoGVWDao3YzRg/4kqXnzzg==
=9gb0
-----END PGP SIGNATURE-----

--YC7TrnJcx5B4flrv--

