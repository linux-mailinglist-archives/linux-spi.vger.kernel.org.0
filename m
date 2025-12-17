Return-Path: <linux-spi+bounces-11981-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C6063CC757C
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 12:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C966E3004631
	for <lists+linux-spi@lfdr.de>; Wed, 17 Dec 2025 11:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD2C338592;
	Wed, 17 Dec 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rw1d9LND"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A9C2773D8;
	Wed, 17 Dec 2025 10:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765967693; cv=none; b=ZlX4rxNVqvh9lWhxRmc1mB/yThY/v9ApSdGrQ1zj9O6LOh4CntE0QuRd1J7wvJ1NKNXgr457bFDTw1HFHaA8CgpIMPmZMQyG0nOIvCVh5VmfZ3QrtoM1efeeV7TqSyITi03B7bEwb6Xmq1XmInNPNmfNpTXNXFhrJ07tg0TdEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765967693; c=relaxed/simple;
	bh=Foy6zGnD7BQC3a1gu0XohNgG2wyPR6aTb8JJIyQ/qiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwjaahkdV3DPviX+lhOa27xEAZFqjvkZD5sualOm7GvSm1BqxsLegLa1aOuvBWA7pcri1Ak/mwr3pP39ZiTRpX5WQTq1EvQT7KvtIuEpM5bDpxc475TKncHTFHbw35sdZWfGkfQBQtrlfrQgH4dExjh2jy8W0+1tu44bO5KsgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rw1d9LND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9795DC4CEF5;
	Wed, 17 Dec 2025 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765967693;
	bh=Foy6zGnD7BQC3a1gu0XohNgG2wyPR6aTb8JJIyQ/qiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rw1d9LNDUVdRDMGygn0tHVsslWJPk6AJrjxeZhfMfgKDHgG7z1SrsmRUnUh3cpug/
	 OgxUAXLihwj/7lb2UYsvFG0X1hD893wqd5aAfjv918eeV3u4NnhCc06Hye0lkNpni4
	 raQEy/8juAkOLY+WFJB/uhsAyf7VGaGGISnHC5PMXB6kOyXTfy82rbwSHkMu0Q3WBC
	 PRI/OletBehiWydtxP0GE2eV/01oEBrwxlaGahrzsPja/Uo3IWKBWgVya3pqKF8GTL
	 rNLlHx6QxP2scvBx/Wn0WhnOKy09JtdWBB69u9kuaWoCd59XwmtbVtvdjC0Jrs3Uar
	 W9nQk/uidy24w==
Date: Wed, 17 Dec 2025 10:34:47 +0000
From: Mark Brown <broonie@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-spi@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: realtek-rtl-snand: assign of_node instead of device
Message-ID: <3e3742de-0560-4699-ad4c-edce992b866f@sirena.org.uk>
References: <20251217062635.37764-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="waMK6jt8bPXLcFNw"
Content-Disposition: inline
In-Reply-To: <20251217062635.37764-1-rosenp@gmail.com>
X-Cookie: To err is human, to moo bovine.


--waMK6jt8bPXLcFNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 10:26:35PM -0800, Rosen Penev wrote:
> This driver is OF only. No need for device_set_node.
>=20
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

What's the benefit here?  This creates a barrier to adding support for
other interfaces and I can't identify a problem it solves.

--waMK6jt8bPXLcFNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlCh0YACgkQJNaLcl1U
h9AOCwf9HnrL5HbZElONyDgwLp5BOonL83bHDz0WKTT9Hp3GtvXDZZ3udvxRw48w
wYbl85Qn1evDO8pxBbjEd6XDUR9WftEbNoDxsMgnBJSwtdJAnfClLXnuJRT0C8e1
HFu3MEeR4JH+A9z1w9s26tpAQsGKy7fBCyCpICdJRf9/BJVv8tTxMi0mw6g7F4mX
yavMU7BR5sbVWIiFmcQlIJndnkqx+EFukTQba7Z/uXVfjsuPe4XKUbVr3EW3DcRE
H6AP+CFtlWxVCqOEauniCFhpXDA8eTz5phcJTIkr/biemi34Z0rJqoGaJFfzTEHQ
n+uWL6fK27CvDsrG85APnDqNHVXE+A==
=8BTn
-----END PGP SIGNATURE-----

--waMK6jt8bPXLcFNw--

