Return-Path: <linux-spi+bounces-12189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0002ACF8506
	for <lists+linux-spi@lfdr.de>; Tue, 06 Jan 2026 13:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45762308D052
	for <lists+linux-spi@lfdr.de>; Tue,  6 Jan 2026 12:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113322F1FD7;
	Tue,  6 Jan 2026 12:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLEhYDz1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37C2DA749;
	Tue,  6 Jan 2026 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702146; cv=none; b=CO5f7J3O6ExIEGacQ5ZmpsrMr6tk30B1D5oBn40w2M1DCGB1lm65hxoJVjEBsSurojh9POwmW9VaA7cncPG52cg+qiHqkTx/tXOdHpDWby28izXtTNY3uo+LeIdQnvCQHoS3Lyq5BkY+tqxfCC2O6sDPL9lu+iDCs8AyBX6hbLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702146; c=relaxed/simple;
	bh=jrWrmUEcepjc/MxZzu/XcC1bCoyGapqRcLqcZx24Lh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ll8YF34PzM/Tx4b07SPVO+4/GsroLeBVzCtgg0wRr5H4965itGggjOPgNelRXS+V40phtIshPZxR0UcJXVImAjm38XjlcDSgiQ0PAMwqYkccPFniuvNVjDLbQ89tcJdLBSiUHuXETgnykveXUxASjAvgezM16OIcplhqj9/aU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLEhYDz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FA7C116C6;
	Tue,  6 Jan 2026 12:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767702145;
	bh=jrWrmUEcepjc/MxZzu/XcC1bCoyGapqRcLqcZx24Lh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HLEhYDz1TABUPl7Bt+1isx1W/IoqjaL0c9Bf8+Ejn7ltzoHcT8txIDSsusunYH2Gd
	 AEnQpgkabg5E14S7Xsffe5rTmchjuF96RorZW8htJhJ4USnPHdSuWYVef9LslrKGF6
	 FMtjp0BZiGTmVQvfLfLFUq2igbf2tginL2GyFbTxBCS2S8vPMm0WMyB6HKqdIW92rm
	 Xrur1LTvo7zCApwER3eHjBOQp0ddEQa7hnOjb71FzT8HSpgFZLzZMTHdqQ+am0Dk4p
	 pNoAnXaLUS3X+thFmGlAUm0AqjTKfiqo2kXoGqozTqHOzqLHYhE7YqEqaFdG+8vrL4
	 1+9mS7ARkBKxA==
Date: Tue, 6 Jan 2026 12:22:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] drivers: spi: st: use pm_ptr and remove
 __maybe_unused
Message-ID: <fe48d1c2-07c4-451c-a2e7-338570557e93@sirena.org.uk>
References: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RUu1iIbwe7xJ/Z4d"
Content-Disposition: inline
In-Reply-To: <20260106-spi_st_maybe_unused_removal-v1-0-8f5ca7136e96@foss.st.com>
X-Cookie: People respond to people who respond.


--RUu1iIbwe7xJ/Z4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2026 at 01:14:16PM +0100, Alain Volmat wrote:
> Update ST related SPI drivers in order to remove the __maybe_unused
> statements on pm related functions thanks to the usage of pm_ptr.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--RUu1iIbwe7xJ/Z4d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlc/nwACgkQJNaLcl1U
h9AbdQf+JYxZvoJLlKwbsDUTQjC4Mk5hdBG2qxuT/3zMqhob+VxeKNv5oFGesf+E
E3qS3sArsrkBNbU40i4mb4fCuGKhA+WILehyZ0DE3BmyjE1zwBWI6rruHu7AVuMG
uQ+2IA00P2lMlGF9Nsj5sf2r7kQ+EwOB2IfLJUPQs1BsBk9yoPbp8aNmMPuYWGiB
o18LxSypSDRAvCLu1IpBQ82TSjuAINHON+dHgiltYVXfebxeyvBocGulD5858d9v
i4+ghAzTRxSrol2f7BRtHjgK/n8+IVgHEC+FTa400Bwqh5gCezuol2de7fIRDXPK
NH/e26NI4zMfPcZ7HuTt+orpJyzEfQ==
=ZYVd
-----END PGP SIGNATURE-----

--RUu1iIbwe7xJ/Z4d--

