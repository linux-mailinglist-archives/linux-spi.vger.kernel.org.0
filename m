Return-Path: <linux-spi+bounces-5047-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4AC98A60B
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687DF1F24741
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3286B1917E9;
	Mon, 30 Sep 2024 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4oCRo+5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672E1917DE;
	Mon, 30 Sep 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704368; cv=none; b=KMkmCx7I/yzTHM2XIDuoCCDNWCofAmFZwYE1F/+KNm/5SXlKk9QHAgvrjGHTP3RJXe16ul43ll6v0ZV7bWsx5W2eD0T4ihZedBgfIMVtDtWWo8LrGwdCI6xPLiJWIlqBjkBQY58cK0r+CzJ2wFOUdL0V8Hs1zi98YITdc1fJIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704368; c=relaxed/simple;
	bh=wdUZmpIBZdNPj4I1JKNhPU/kdEl+3H2071J5EjhlRZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YoVbLhTWX+aZC+qMf98C8WsctTkvFmq0AIFZEoDsy0Xf/Ecf5fvZJHxlX8AeUSbG3XrbiR1lw3TfwzLJNXYKKTN5LEaxiQEtQmHpScf4S/hCxc9OUHU8f10j/idqGOIsI0RujFKYq0ZnrCJkkOmGseOwk9A0+G6OmC++gouFk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s4oCRo+5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F75FC4CED0;
	Mon, 30 Sep 2024 13:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727704367;
	bh=wdUZmpIBZdNPj4I1JKNhPU/kdEl+3H2071J5EjhlRZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s4oCRo+5A1o9iOJUsyH14zG5F7G1eSVDx443n9SPjYn/xpC77MlhtrQTLwEIDzxaH
	 MGWxMvDbyCgAjoJFM4i7FcuzzjU61g6rpMJ1sPpZ2pSe/mlIcPCvz+PyzWQu8qcmPQ
	 6yBBVyr9NZtWJxeOCg/mISrLnUt7T5LCnZG/1b067RXvpUtHP7Hn7fPF7w8Wz1UHun
	 uXJHhrazCTWd3OlV1DUHdXc3JutB4iEH32dQKkzUF3nRIUYI5IPdCqMeQxI3OCAAmI
	 A52H+a8nq1Zy4vYv4QbGP/C9ol9B3EvVh/4ATIF2iCsNV2chK4+L14/sWfeGotDhJH
	 ZcyxnXgo5BEmQ==
Date: Mon, 30 Sep 2024 14:52:42 +0100
From: Mark Brown <broonie@kernel.org>
To: pierre-henry.moussay@microchip.com
Cc: Linux4Microchip@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [linux][PATCH v2 04/20] dt-bindings: spi: add PIC64GX SPI/QSPI
 compatibility to MPFS SPI/QSPI bindings
Message-ID: <1f54805f-f06d-4732-a124-270a36dbff4f@sirena.org.uk>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
 <20240930095449.1813195-5-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ON/Pr4mvjRo5l4wh"
Content-Disposition: inline
In-Reply-To: <20240930095449.1813195-5-pierre-henry.moussay@microchip.com>
X-Cookie: My EARS are GONE!!


--ON/Pr4mvjRo5l4wh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 10:54:33AM +0100, pierre-henry.moussay@microchip.co=
m wrote:
> From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
>=20
> PIC64GX SPI/QSPI are compatible with MPFS SPI/QSPI, just use
> fallback mechanism

You've not copied me on the rest of the series so I don't know what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--ON/Pr4mvjRo5l4wh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmb6rSoACgkQJNaLcl1U
h9D1pwf+JFH727JFNoEx84gYQwKAvz+cdKLsqrQxz+8QuE0z4nlSUrRoNCV9BKSN
TzRE6wddI3I7fl5W1cnqDvRHoevwreZDTzqMW9dVVuFhyUcIriUH42yFTk1nsGt7
A58VM0bneMcjyltwtT5ZdVanMl8dJCuNsPXEedQ3RdEwHO3s7VxyAJFVfGflPNPC
6fk35U/arMyMZHcKrzNFXYdd4SJxa2zFK+9Ns4uH4K3N/F8JmzYwT85cXNrW3Jd2
Mp7o/ztY8UAuP3oclsjlelUGzLgFIVjQ49+wm+cq0t5IOWZ4IgmZT9HWTodbMWcC
3d2VyHY/9NrlSjyMrz4HJNwJk97u1g==
=CNfL
-----END PGP SIGNATURE-----

--ON/Pr4mvjRo5l4wh--

