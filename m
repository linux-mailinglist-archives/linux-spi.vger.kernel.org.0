Return-Path: <linux-spi+bounces-4504-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C495F968694
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 13:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EC91C22183
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885D71D6C57;
	Mon,  2 Sep 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pa4+LJtv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFFEA32;
	Mon,  2 Sep 2024 11:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725277723; cv=none; b=i1jF9HgJUK2/6awddGtg+jajPEgHSk6v/zSX0bKxzZOGTodHNfPGUQXdSByKMx7heRNL80l2DtKOaY9OH0LIKPaoERyatRyBaqKAwIrynmkcLN5zaeO09CqBDOQnlbsshtAqsHAsd6SU3Ptrlzpcm3E63PxoUItmZMZb3kbiQW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725277723; c=relaxed/simple;
	bh=fqh7S4l5FfCjahVC6pG6dmAPfdOpQaUhApgL1T/Xfl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L43IijgGQ4yhvKS9RK6v3HAvnpvt70N2MT+w9j3zSDXqX2OOJ4QSI8S5wH16XCmiP1IvXZ+EQzC4XFfm+6dGCWgw2dYtxAVBSBokTkbSyNWE5mvib6+jS3u9DGeuO3q26sET2wd93AzNqk30LtFiNecse4cKWZ4N45bPVJ/t7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pa4+LJtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE960C4CEC2;
	Mon,  2 Sep 2024 11:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725277723;
	bh=fqh7S4l5FfCjahVC6pG6dmAPfdOpQaUhApgL1T/Xfl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pa4+LJtvkKSQMzjPRPFDvFNzKlQxAqjwpyOCdkW9fv07g3S1T1kNxD+O5cwcgI+7S
	 LJLaC8L+56LdgFT/bQBAnq9RRekDAknsGsuYG8EQSmP+PnwhDuzNWYpYCVCn/Wf04L
	 /p2lxSlynXGM/nRTB7uue228zIWda5rN7YmZIvsXxUPW3qqQn7oU9BKkIQKLDg2/4P
	 ZkPAmJ/8apEMWdk46CyN5oGPmSV2TTNnQp0CnT0v5vLkCgMuog4JMUqoznunyGXvkV
	 w1WQx/lOhNUm/vJF81C+OAcEJYt5cpChMQ4cTrOfY0DU6ahKQ5KqmRdLy4pfDJyYuO
	 sOkQuzGbYnhvg==
Date: Mon, 2 Sep 2024 12:48:37 +0100
From: Mark Brown <broonie@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Yang Ruibin <11162571@vivo.com>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
Message-ID: <116033b0-a701-40ef-a5ab-a2d46885872b@sirena.org.uk>
References: <20240829033511.1917015-1-11162571@vivo.com>
 <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
 <0a906ee9-7b28-45e4-be67-ab3b6c5f89b1@sirena.org.uk>
 <20240830222332.GA3862110@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zbu+YNh/9tKK5I1D"
Content-Disposition: inline
In-Reply-To: <20240830222332.GA3862110@thelio-3990X>
X-Cookie: You are fairminded, just and loving.


--Zbu+YNh/9tKK5I1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 03:23:32PM -0700, Nathan Chancellor wrote:
> On Fri, Aug 30, 2024 at 08:57:47PM +0100, Mark Brown wrote:

> > I'm a bit concerned that this isn't picked up by an allmodconfig with
> > the -Werror...  I'm currently using GCC 12 for that.
>=20
> It shows up with -Wmaybe-uninitialized for GCC but that's disabled for
> the normal kernel build with commit 78a5255ffb6a ("Stop the ad-hoc games
> with -Wno-maybe-initialized"). With GCC 12:

=2E..

> Perhaps a KCFLAGS=3D-Wmaybe-uninitialized in your make command or adding
>=20
>   subdir-ccflags-$(CONFIG_CC_IS_GCC) :=3D -Wmaybe-uninitialized
>=20
> to the makefiles of the drivers that you maintain might not be a bad
> idea.

If it's causing so many false positives that it's been disabled then
that'll just cause trouble, it's always miserable whenever a subsystem
decides to go with custom warning options.

--Zbu+YNh/9tKK5I1D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbVphQACgkQJNaLcl1U
h9Ch/wf/X3dD1QdG+xX7qaqiz+UzIAIlp0QgQsHwrHEN1cvuL1ld/lpCmTlagzZP
cl3h88DlfB2PVWGSwrweozTmbqBc8dM380m98xmEamAGOUWgHwMRGdDtLNlnl0Y6
7/hZA9r4wI1vyj/KFAcXY9jQEOCJDt9hIw0dzRjZjAwpEA/gN9n/t3F6z82qnM48
15cuO/WIReKKwLuT6GI1QkvwrUbiJaUBTgFI0tq/XBV8B8x46wQ/a1nhaevwxdM0
80amAW4blsKm5KEwsyoKBKNq2skC69yrbP4iuK2+BgKGs06OtCgB3xwJ3IxY9EI8
GjU5JDGCvC8HxYHuY3wmHlZ4TKYFGA==
=CknE
-----END PGP SIGNATURE-----

--Zbu+YNh/9tKK5I1D--

