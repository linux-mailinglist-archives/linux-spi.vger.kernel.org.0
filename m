Return-Path: <linux-spi+bounces-10754-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C35BF66A6
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 14:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BABE9487235
	for <lists+linux-spi@lfdr.de>; Tue, 21 Oct 2025 12:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0361C84A2;
	Tue, 21 Oct 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILqRdPZS"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC5B35505C;
	Tue, 21 Oct 2025 12:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761048683; cv=none; b=f/N1ObJkmJxjOMAIJZZuxbVvzu4TBpeAsh4MNQJ+YCsDsl6mwjzckRjyw6LX4OLXJs5gaEPlNY/jAycKYUQLsLnodBBeQvVkczrfnJ2YwOXrJ+vXPOdwHlQayQPOkOmO+8a53v+6o47WNBvBKN+83Rjn78HtbRdsVRflm25s0g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761048683; c=relaxed/simple;
	bh=kLm/IAQP2+kJWXKn3GmdAfEMaI+3CWV0wc71MhB6j5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0ZAnV2pN2lu+RB0rvITHi/ajhb7uoZXNHzvfO9A+A5FGNdO0ZXGvpxTLUBteqIMQaAXHgCeRe3hv9OSu5b36DW17sseuFQINVGh57VTOQymt533KaLHKzJOxISIhpHmJE2U62redh6Qb0b/kDnPdqprLz9Oyc3248CJUXhGin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILqRdPZS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FEFC4CEF5;
	Tue, 21 Oct 2025 12:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761048683;
	bh=kLm/IAQP2+kJWXKn3GmdAfEMaI+3CWV0wc71MhB6j5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILqRdPZSGiv4RjMFEJ/thBxR1tHDHW65PAZkzPNmqLQfCYDkPZx4KEf7B06l3J4Rx
	 rkcFX46nHh5+hUcXCBR43GRmNeP2VM1IvSaU6yEdb/n5reiQnEXGtvFzFDx/Mt5tMR
	 3EZLW8toxK7UnuSyl6KwbcLYoDDIDhxkyrjTGtvqOOBGyAZmxjtLV8fSL2NLCioQlE
	 96dolgn4NH/5oAeWTKCwcHFBzH1CjVKumTHpWvSmdv8ec10vLokUmE+PiVnvMnn8NY
	 /rxctelM3ejNYERHCNpaUoRjf69Apy5UrhhvrS88sAD/pCtLc+WBGxZH13hmeUuluE
	 jPNPFxIg6AxUQ==
Date: Tue, 21 Oct 2025 13:11:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-mem: Trace exec_op
Message-ID: <5cdaba07-557a-4c19-bad5-a4c1547882e2@sirena.org.uk>
References: <20251020190333.1431664-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xA1qrxQmEEAexbK7"
Content-Disposition: inline
In-Reply-To: <20251020190333.1431664-1-sean.anderson@linux.dev>
X-Cookie: Accordion, n.:


--xA1qrxQmEEAexbK7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 03:03:33PM -0400, Sean Anderson wrote:
> The spi subsystem has tracing, which is very convenient when debugging
> problems. Add tracing for spi-mem too so that accesses that skip the spi
> subsystem can still be seen.

The change here looks reasonable FWIW.

--xA1qrxQmEEAexbK7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmj3eGYACgkQJNaLcl1U
h9Dmawf/RATxkvZsN8XZdUTYVUKp3hrtOyvJxLosnVTV0ysutXQlGserw2owslOE
Kjd23n8rKnznqjMOcZqvqMKg5HZuKnuv3eCOVzQrD/b2owgpyXz7bo0OUBGEFQUd
h4cL0UTdoy5n72M8CdOau+IDhe/mJZdrQW6MJByzG8zaZRUR30la1v9vA39jCAWP
ERi0zwySuVLEQeUgdBBOWjinNJIZ+zuUZrTB4ICNiVV1ldgFX/EVfQWc1WntiyIp
TY8fl/uKmBCemSzAFnNRdk1YFSPhGprsWdVkfF7D3jLdQUwnvXV6H7Py4FBMeOV9
kdiYTgjRhLn3fEGM5E/hmcck4+qjoQ==
=flUb
-----END PGP SIGNATURE-----

--xA1qrxQmEEAexbK7--

