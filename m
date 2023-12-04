Return-Path: <linux-spi+bounces-122-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55C6803243
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 13:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D497E1C20998
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 12:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE96A22EFC;
	Mon,  4 Dec 2023 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8nq7UXm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE5224D2
	for <linux-spi@vger.kernel.org>; Mon,  4 Dec 2023 12:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D19C433C8;
	Mon,  4 Dec 2023 12:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701692079;
	bh=UO++fzPbk7oE2nPQaJdRbj1/Gln8Y85B2q+MfxWqQhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8nq7UXmsenLOa7cAonkmS0cjI3t+0bc5HMHksyIHgYSvDtOVHSg0hTVbW96bdWrs
	 UKQ5TiexUr3/G5zwi3cgjse5BMGZfYczPR5AbUkWo7oQPQ0DSnTIcLwcReyiV6TG6x
	 MaFhAEMm83Xdyd9pVvJCtmLqN9dFP5/FdZUSSPmBi1pqo78B1swA3pzZlxBHWUgyGD
	 rP6fkDP6mAcn1fMZtL/hTp3TyEonz9GeCuJFc+9Cmagm+ZbvswIjMxbXpF8cP68wsQ
	 DrU/tb4dNgkRwyEsVQemEHsTh0yNxOyFoulIAJ3R0vowBqfY/PXV1auGd/t24YhNR5
	 eWwpCSzq0disA==
Date: Mon, 4 Dec 2023 12:14:33 +0000
From: Mark Brown <broonie@kernel.org>
To: Rajeshwar Shinde <coolrrsh@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v2] spi: spi-mpc512x-psc: Fix an unsigned comparison that
 can never be negative
Message-ID: <b7b27bf6-3e17-4392-804e-c46324a5bdd6@sirena.org.uk>
References: <20230813141207.150336-1-coolrrsh@gmail.com>
 <CA+VNjV1=xVyRkvB6RAnLySAOzS=X1XiJihrtiMx3Jmifpdq9ng@mail.gmail.com>
 <df10d700-3f3f-4665-9197-534abc24523a@sirena.org.uk>
 <CA+VNjV1K6WoKPqP4zrax5SOF3UFCiJ5oYA=YamjZwfZ5fkEHWg@mail.gmail.com>
 <ZPTAQWZ0XoL9zfW7@finisterre.sirena.org.uk>
 <CA+VNjV3_JRvhjanLEdYRnxcTZv2pv307utD-bpmy_7QFT3Y+Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lu5MX3pFXYQCC8VH"
Content-Disposition: inline
In-Reply-To: <CA+VNjV3_JRvhjanLEdYRnxcTZv2pv307utD-bpmy_7QFT3Y+Pg@mail.gmail.com>
X-Cookie: For office use only.


--lu5MX3pFXYQCC8VH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 02, 2023 at 10:00:21AM +0530, Rajeshwar Shinde wrote:
> Remainder

Seriously, please read and act on what I'm writing.

--lu5MX3pFXYQCC8VH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVtwqgACgkQJNaLcl1U
h9BNwQf/S63rsI3fLUB10zkKjnEZzXJtFIBDO3bgRpZCsA5nS8LvamCOJiDRzKOv
/OZyxrDCvji9tZw9iUUvOi8Cq4s4Xx0GiJUl896iJ3vJOupYes1xhl1b4YvrNnWo
K4z+5STjLLGHEjrljSxORNEN5LdAfxfQQgT97mqNdlRc0dEBrhxe54CQmr2aqWby
+3Oq2mBFW6R0FRPqsd7BMrlOk6wY+pnAxZ46eMuEKInbaDUeCAQoSejhJyyYC6Bh
4KXuPb8arFpWhgv/MAbjb0PqGWH2RkHyJVQ4vITDhU7WO88RB9PMW6/f+kLySXYq
pWIPx37qTD0bb+Gi+UWiNLepWg6Y2g==
=tK58
-----END PGP SIGNATURE-----

--lu5MX3pFXYQCC8VH--

