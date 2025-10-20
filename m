Return-Path: <linux-spi+bounces-10736-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 15530BF2D40
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 19:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36D534E99D1
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 17:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B23321C6;
	Mon, 20 Oct 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txdlpjK2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D520331A79;
	Mon, 20 Oct 2025 17:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983091; cv=none; b=sFoVMs3293o9xUeEggwa6W2oMh9o/ObI3I6VlNtTsbrZJSmY+xwChQhNFgnbVfvso5aurPfwr6JxXxjC0eQuCsZRFJOtlsqRVYxn1WpZu927wbLiQ3UrGWKIYx5Qynfu6k8tIZXi85JMpYet5iF1UH9OlXwFoJbmXkgof5Nc4Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983091; c=relaxed/simple;
	bh=3eybZrHiTS9wZG23hXV62FCDJFtCcIIaUJqij9JPSCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVYAHVOVoQgJZ2Ub1P1/RLMiEQZx08buB1zvnl/gwDh7D1I5Zwj+Dbe+6FO03GHeZ/qbBADpdCc4MF/1mHcD7vumYXC+uXoxffYVglLx0zhGjeJsTm+/+4aJNsdUI0pj7EvxUOo+h43oDqR9X31ZqYE1UuPkLIgisMr6emlxnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txdlpjK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000F9C113D0;
	Mon, 20 Oct 2025 17:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760983091;
	bh=3eybZrHiTS9wZG23hXV62FCDJFtCcIIaUJqij9JPSCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txdlpjK24x3VCahUT9ZDmp1hV0WioZsFGhVrgeWjDL9cx419PRG+z1aKhv4F5V0L9
	 JapR/jG2vy2nXcja7HIJQuklXNawrWVBoUolmzXHNRskdSKILmpFmLNOHEd+Btk5Pd
	 qyn6a8t3q415LXmmbB0OmJ+br+Yk6RQ1zNWN7tT8gECh7sss9pQprEy62S4/LcnEEi
	 bzGWKnucEFvyT7CGRoAUWazf3X6ltNAtyfv4e0VnzA2dTCxa2eFGSqKKQxR/kr6l2F
	 ZCkJiMMNO3p8R/OE5SRiIEDOKEE+VOtTJOVUdsPeE+y1j3RcqM8+8331BV2BKQeHCp
	 idWOt9+MTZi2g==
Date: Mon, 20 Oct 2025 18:58:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: devicetree@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>, Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Gatien Chevallier <gatien.chevallier@foss.st.com>,
	imx@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, Liu Ying <victor.liu@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>, Samuel Holland <samuel@sholland.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH 0/4] dt-bindings: treewide: don't check node names
Message-ID: <20251020-coroner-headstone-c8685f6e3868@spud>
References: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ifIYyPcG9nWKLWH/"
Content-Disposition: inline
In-Reply-To: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>


--ifIYyPcG9nWKLWH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 08:09:49AM +0200, Wolfram Sang wrote:
> Node names are already and properly checked by the core schema. No need
> to do it again.
>=20
> These are all occurrences I found in linux-next as of 20251015. I did
> run dt_bindings_check successfully. I haven't done a way to run
> dtbs_check yet because I would need to identify the proper architecture
> first, right? Is there some tool which tests all DTs of a certain
> binding? At least build bot is happy, I don't know if it checks DTs as
> well, though.
>=20
> I'd suggest to give subsystems some time to pick these patches before
> Rob applies the remaining ones?
>=20
>=20
> Wolfram Sang (4):
>   dt-bindings: bus: don't check node names
>   dt-bindings: nvmem: don't check node names
>   ASoC: dt-bindings: don't check node names
>   dt-bindings: spi: don't check node names

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--ifIYyPcG9nWKLWH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPZ4KgAKCRB4tDGHoIJi
0nQOAP9zt58K2r6VVxQGAjEOeExklSakIE1QYNmtoG9DXBZsvAEAw5tz28SP3wVF
gblhCrRV4FJmV7bWABaDA6WjOT5AlAI=
=dLoT
-----END PGP SIGNATURE-----

--ifIYyPcG9nWKLWH/--

