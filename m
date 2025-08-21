Return-Path: <linux-spi+bounces-9577-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE73B2EEF6
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 09:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1711C827DC
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 06:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 801CE2E7193;
	Thu, 21 Aug 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsRpfLjO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592532D7806;
	Thu, 21 Aug 2025 06:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755759505; cv=none; b=Qppu+HzeuWG2UzpdFISvlxyDZu5mmw7KlEP98aH9n5Owl0iByVJhVrJbKKX6iL/h8SI+veUShE61qakTjg6x6RzGOSlcYTvuZObjB2mVZsx/D0LPzRgQ16WrJgIFKBUFq758PAgE1+8oKPX7A/JJW0VXmjs5TjOlPyHA/lMHtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755759505; c=relaxed/simple;
	bh=mZ4FUqwpeliFM+BfIUJKWhmDxAE2ZXgT86u5GAWrTAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scmlsw0Lwc6EuFPhdAfEpUz/DHAFM11x4V9ku/ersZ69Icd1q0sZwkU6SKLzhTU7JFpnJ+5l+Jfp8ExW1ztSfNobI8n9ZoLtKO7/qsd/uaB8DCLQOsuEHQbLhpwyh/ys5Pn2n9Auke8/g/Ou5yK93YpbN/3VOvTMo6kkUcItaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsRpfLjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490E1C4CEED;
	Thu, 21 Aug 2025 06:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755759504;
	bh=mZ4FUqwpeliFM+BfIUJKWhmDxAE2ZXgT86u5GAWrTAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsRpfLjOy3xC581SFRPJeAyZkyycZvl6aPn2IFA5QoPv9IeStQDToqlAa5mlJqPQL
	 89USDd4HGTiTtFM46F85AMnbO0B9pwrv1rES7j9hr4QJaQ32GjXhTKk/qum4+WCaOL
	 9YQ9Nej5JXVLvyMMJ5af2Q79KlBdLYxYt/+URZC2BVZaTeWN8RDe9L/ETsdIfNFizm
	 IjsXai0Q5igBl+5vgvQKLv76aykaU4ZImTGOxDJ2gi/xXbV5VTfJr+fn6HiceIp67x
	 yIEb5mXLA+7xUGuW1wI/g5uoBYo/sV8sE0QS1RbHr1f6vyMUSFvAgC9U1NvqUN4XLJ
	 cO8TVfCtXw5BQ==
Date: Thu, 21 Aug 2025 08:58:20 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
Message-ID: <aKbDjIZhJuWo3yFu@lore-rh-laptop>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1AUHNkd+gHsq61gf"
Content-Disposition: inline
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>


--1AUHNkd+gHsq61gf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This patch series greatly improve airoha snfi driver and fix a
> number of serious bug.
>=20
> Fixed bugs:
>  * Fix reading/writing of flashes with more than one plane per lun
>  * Fix inability to read/write oob area
>  * Fill the buffer with 0xff before writing
>  * Fix reading of flashes supporting continuous reading mode
>  * Fix error paths
>=20
> Improvements:
>  * Add support of dual/quad wires spi modes in exec_op().
>  * Support of dualio/quadio flash reading commands
>  * Remove dirty hack that reads flash page settings from SNFI registers
>    during driver startup
>=20
> Unfortunately I am unable to test the driver with linux at the moment,
> so only the following testing was done:

It seems to me this is quite an important rework of the driver. I would pre=
fer
to have some test results for this series. Are you able to run mtd_test ker=
nel
module for testing?

Regards,
Lorenzo

>  * Driver compiles without error.
>  * All changes were tested with corresponding u-boot driver. U-Boot
>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
>    additional fixes for continuous mode.
>=20
> Changes v2:
>  * minor fix
>  * add comments to code
>=20
> Changes v3:
>  * add patch to prevent continuous reading
>=20
> Mikhail Kshevetskiy (14):
>   spi: airoha: return an error for continuous mode dirmap creation cases
>   spi: airoha: remove unnecessary restriction length
>   spi: airoha: add support of dual/quad wires spi modes
>   spi: airoha: remove unnecessary switch to non-dma mode
>   spi: airoha: unify dirmap read/write code
>   spi: airoha: switch back to non-dma mode in the case of error
>   spi: airoha: fix reading/writing of flashes with more than one plane
>     per lun
>   spi: airoha: support of dualio/quadio flash reading commands
>   spi: airoha: allow reading/writing of oob area
>   spi: airoha: buffer must be 0xff-ed before writing
>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>     REG_SPI_NFI_SECCUS_SIZE registers
>   spi: airoha: set custom sector size equal to flash page size
>   spi: airoha: avoid reading flash page settings from SNFI registers
>     during driver startup
>=20
>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
>  1 file changed, 260 insertions(+), 248 deletions(-)
>=20
> --=20
> 2.50.1
>=20

--1AUHNkd+gHsq61gf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKbDiQAKCRA6cBh0uS2t
rJDmAP9GGuvSZEogcCj+X2sKTBaavTRJxM26qOSQDYgAAIL4nQD9HS0AIcUP+7jg
0doMcxD0fGbfIx1hqOoVPVYE1CgCWAc=
=YwyO
-----END PGP SIGNATURE-----

--1AUHNkd+gHsq61gf--

