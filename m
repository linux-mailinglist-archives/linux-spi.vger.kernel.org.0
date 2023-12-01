Return-Path: <linux-spi+bounces-117-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8A980142F
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 21:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F728281CA3
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 20:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EFB56B80;
	Fri,  1 Dec 2023 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uj+TV+vQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492D84E1C8
	for <linux-spi@vger.kernel.org>; Fri,  1 Dec 2023 20:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC784C433C7;
	Fri,  1 Dec 2023 20:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701461921;
	bh=NxTGq4XICzSbkv4PfwRRf+8lYts9VpVqDOrxlyo+0v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uj+TV+vQeoEuy/0GVxKhq6wsGPRdGTY9simuiPntm4YKXH81e5yFMrZEcP8E+5m9g
	 DRl6lTfNm0S7BM/B58uAMxkJxP02h2Mox6GSlfVM+trYvVHIYJl/x14eXz6FyVUTBq
	 d1a1M/ijkgLC0/vPRFwmutsrCM1Y3awaBVrhG7/FfNuH7sGl8Bh01FLRmZExwd3fSH
	 Vaa+eCW4YTHd+QPkRRbOuyDG3r4ZjCHjmy2o3S0hcuAf2OcuwiqDHRzLfSAwSbHMjC
	 RDjhl45FOPHKz9dWlwguh5vnDO6pdrwLKd6G/GKE/Nsa0TeLK3OfTFOTXluaCW4D4L
	 lu4e6iSZYQyaQ==
Date: Fri, 1 Dec 2023 20:18:37 +0000
From: Mark Brown <broonie@kernel.org>
To: nikita.shubin@maquefel.me
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5 15/39] spi: ep93xx: add DT support for Cirrus EP93xx
Message-ID: <e9aeb91e-3c70-48c0-a981-8a3111e9bf63@sirena.org.uk>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-15-d59a76d5df29@maquefel.me>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GULY8lxYL233GdGV"
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-15-d59a76d5df29@maquefel.me>
X-Cookie: The early worm gets the late bird.


--GULY8lxYL233GdGV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 11:59:53AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> - add OF ID match table
> - add device tree DMA request, so we can probe defer, in case DMA is not
>   ready yet
> - drop DMA platform code

Reviewed-by: Mark Brown <broonie@kernel.org>

If you hadn't added the removal of the platform code then I could queue
this even if the rest of the series still ends up getting stuck again
(which seems likely given the size...).  :(

--GULY8lxYL233GdGV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVqP5wACgkQJNaLcl1U
h9C7tgf9Gu6/hpm7OBciLHLVxKzom5b3rDAdVqnIuxFD6kiMi5e3fki1hEr+IAxG
fjHpG4iZrehHUCL8MBx2gierEUieRT0DIQUCMReNPxieQW20rWhzG6NFqZhimPCp
/oGzHWuhKAB855DBzzsina8TXJTmDUKtkNvVSgzdiv0pAbKxgXHXLBH+QXT7T9rV
MhK3jbzogBk8f1W4uaxqaZBJBOK5cy7dl/1eiLCCfrSHMB+uB3wIYbLqJMuYmgf7
CJfPCTmA6ALpvZ6MNRqLcKR7luhuTzLexbK2Dai2L8510SxARszF//9UsEvoqi0R
0EDZIrP3Uz1nQHajRDHMueUl+cgBtw==
=Phzx
-----END PGP SIGNATURE-----

--GULY8lxYL233GdGV--

