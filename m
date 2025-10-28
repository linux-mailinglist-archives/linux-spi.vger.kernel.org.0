Return-Path: <linux-spi+bounces-10907-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB14C15ACC
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 64FE4563E2A
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 15:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20DE34320C;
	Tue, 28 Oct 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sV8YOsDv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65A233FE0A;
	Tue, 28 Oct 2025 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667100; cv=none; b=lx7ZyYmZwxiRXFYtuQI4IAxalkiYCwqItMw4MpHbeOASa9MOBaWUVrjutJqL3y4xiXCCajJMWzefYwym7OmLVa4Dgev4dc66IlERnozGKAARSBSdtHTZ0PNEaJgQWCMds586tig+Vd5UnuKP1GAkmuJM0NiEKptMYhwD7PCg0FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667100; c=relaxed/simple;
	bh=z/Wu5buoWq8ZI+3ZBm+yr8RnGsLB+4jjsmCKY+87MzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2jewiLVSfAGKYIGrE88lhFMdQlxvhKjPWO0d9GHuKB6s9f1ZZer/Y4qUkt2QFr9AB6oLJPm/sqYhXVmrx59a2dzaux2WkF22IexnoGCvOqQf/NznYp59xlCrd0ImFHKkRf/mwvydoVAuHb6qqoC728h+xNHlxMlMYciRyJCnfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sV8YOsDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8151C4CEE7;
	Tue, 28 Oct 2025 15:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761667100;
	bh=z/Wu5buoWq8ZI+3ZBm+yr8RnGsLB+4jjsmCKY+87MzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sV8YOsDvOHTWzPkGKDzyNmb3v/wc/w3O5dBBZVjt4goUUkI5Bjra/rz3GP92djT8d
	 hAvHn6eNWdAawDH8wzAdM1rKSZtuAYkGhBJ8FWPtoJjDCtJ6rSdzFzTSmQKhIz2krB
	 iOP2cdSCrWeFvtakPxO6OQoGq5eWl7uX70CRAdYGamWZ9frZDIj5NXCFTPEHMJuxwG
	 v0AjVzQdTgFDqkxzSvJd38uHYSAoIPjffm4pZx267ztTGzeKtig98hjxmWVpsrHJ8a
	 2gMxDqs7NBDJLYxgDNf1SbbFCYnCvPrc218J3n4vlqi9ayJwggk4Zux4g3dGdQN+1F
	 fRN1D1Ny9kBdA==
Date: Tue, 28 Oct 2025 15:58:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Carlos Song <carlos.song@nxp.com>,
	"mkl@pengutronix.de" <mkl@pengutronix.de>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support for target
 mode
Message-ID: <3004d4c5-4a5a-41cc-972a-c94fe75f5c2c@sirena.org.uk>
References: <20251024113107.513604-1-carlos.song@nxp.com>
 <aPt+JJhaB9dUOwL8@lizhi-Precision-Tower-5810>
 <VI2PR04MB11147AB20690F99BB6CEE2300E8FCA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <aP++6ghId1LvQ1NF@lizhi-Precision-Tower-5810>
 <VI2PR04MB1114746F42268876E27C1B93FE8FDA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <aQDko60j5lB1ngCl@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xTlnFY8BrN4Nh6BU"
Content-Disposition: inline
In-Reply-To: <aQDko60j5lB1ngCl@lizhi-Precision-Tower-5810>
X-Cookie: Your canceled check is your receipt.


--xTlnFY8BrN4Nh6BU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2025 at 11:43:31AM -0400, Frank Li wrote:

> Does SPI require send MSB/LSB first of a CPU's word?

Default is MSB first, users can specify SPI_LSB_FIRST for LSB.

--xTlnFY8BrN4Nh6BU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkA6BUACgkQJNaLcl1U
h9A4XAf+KtYjk/onJTf0IGV/Kcfy5Lz5Oqa/OJY8feX2oxlN+v826m6UKoqYMKkw
LrGCh1LdvznChXisujQayy0NKFi6NC9lnu6MG/1D42TN5dcH+9o45zz9XPhlimdn
t7YNi8QGxqbl+LPEV57TdB4uSP5yfXgZbPnW0FzE24dsZG6swxJX91b0owFIeu4U
A3q+dqJRedUOkc2bY1ULWpUdX5tGbXM8HbNwh9nuurjkI1HfBcV4wWYX37yjYBnj
Br0UblmjM5xUl7FkTHF7mCbTP7h2N8WoOosdKODL4cba66r9iVDZXTZkZUJ5UT7P
exFxSPSoLbdL8Ny+IaolsZ0whwNsnw==
=uDAT
-----END PGP SIGNATURE-----

--xTlnFY8BrN4Nh6BU--

