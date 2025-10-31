Return-Path: <linux-spi+bounces-10934-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F2C25C7D
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 16:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB5C3AF4C7
	for <lists+linux-spi@lfdr.de>; Fri, 31 Oct 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D861257849;
	Fri, 31 Oct 2025 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rlwf91O9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C524A047;
	Fri, 31 Oct 2025 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761923465; cv=none; b=ckKI9IWLDkUxj9sYTnvopIjwnQusQZJMQf5TM7bfv7uN8UVqZfFFMf9oR14KbNtXIp7VlSsm6Nl2wg85GV7JbG0sPzIdduclMAKvUWi2JZnnQL2TfoviDTTwUUVHZqqLj09ArnQTv18CnQ7Jfm7246KvyUVKx3UgI2KyH0GxtOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761923465; c=relaxed/simple;
	bh=x3VSbBlEbgi98N0ASDLgCvMIMjNmer8kZpUmrY0wHSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlpywiS/CcveC7Dl0r/SBfGlMMsfZv4nGur5PxfV+32uBMpCZUR4cSJ2exGVzhKztBEA4lJMMdDWIJYlvp7NSnJZ6MW/g0d5yRl0HI6m6adCYM/XoHhSzXsieGPEXKKMnAmjdRly/+CWg/OeIeZ23Vrk5yw34RYYmuKogYB1k4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rlwf91O9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4A7C4CEE7;
	Fri, 31 Oct 2025 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761923463;
	bh=x3VSbBlEbgi98N0ASDLgCvMIMjNmer8kZpUmrY0wHSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rlwf91O9n6C1X6BtIrkR2zdlyxot6WLUec6wDdod0UT+oFLYi6tSdggBuqUMI7uWw
	 Oaruq14wC+HE6qrasfO48JNlVLoHVzoqCv9Y7wdL5DHSwXdjZFTGg/FEEA5euPKOxL
	 0yPLXnkV1i2QVIkANlxI2Mt+eU48R65OYlm7Bak4vFDK4JHk3C19cmTVxghuxvPV8G
	 zOX0npm6gjCyr2DHMgBYjGOYJaqOA9VdVyiODQktwVCaSmeb/Sk0696R1T+PuWLKa+
	 9Jldsln1OQZiNKlNW5rlEjSmBfp4Qc0Gz3/cRwBjWMjhB2u74yxskMu8k/RAqBO2r7
	 oqpZ7oqbZRlpQ==
Date: Fri, 31 Oct 2025 15:10:58 +0000
From: Conor Dooley <conor@kernel.org>
To: Jun Guo <jun.guo@cixtech.com>
Cc: peter.chen@cixtech.com, fugang.duan@cixtech.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, broonie@kernel.org,
	linux-spi@vger.kernel.org, michal.simek@amd.com,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: spi-cadence: update DT binding
 docs to support cix sky1 SoC
Message-ID: <20251031-pretzel-managing-5aaeb4d4ed7b@spud>
References: <20251031073003.3289573-1-jun.guo@cixtech.com>
 <20251031073003.3289573-2-jun.guo@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yvOpd+HVFAw+SZmX"
Content-Disposition: inline
In-Reply-To: <20251031073003.3289573-2-jun.guo@cixtech.com>


--yvOpd+HVFAw+SZmX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 03:30:01PM +0800, Jun Guo wrote:
> - Add new compatible strings to the DT binding documents to support
>  cix sky1 SoC.
>=20
> Signed-off-by: Jun Guo <jun.guo@cixtech.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--yvOpd+HVFAw+SZmX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaQTRggAKCRB4tDGHoIJi
0sG7AQD1fJR7wB0W6kUA2rGfkuGdEbH6r2TxX2fKQeL4MyhfCwD7BGSPcLs4m62A
mGkvhDiE5n78Y/8F5v5X7/LHr+JOJwU=
=LJmS
-----END PGP SIGNATURE-----

--yvOpd+HVFAw+SZmX--

