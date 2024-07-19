Return-Path: <linux-spi+bounces-3910-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C0A937955
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 16:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E88E1F238E3
	for <lists+linux-spi@lfdr.de>; Fri, 19 Jul 2024 14:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E063D5;
	Fri, 19 Jul 2024 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5OjzuZj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4782F34;
	Fri, 19 Jul 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721400329; cv=none; b=kZKaH9zLqwISuCM0y9OrWTEeO3u5oYTHcLmA86byf/46+18TUMvMQ5+s8BT3H61QRsFb8nUifpujDLF755lvgeAj0lG0Oo50X3TsJX00cqEDHFSXYtrcSyHyPfaMpFMCqc4Ng93coYVzcm7Y58INCdCmKFkkyH5qHUI2D0UAaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721400329; c=relaxed/simple;
	bh=3gN8i0ecGflwS/gqmHmOVCtp5ecQSGdmhme4N9RR6K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcwhkdwgooEbjDY8fYX/b4jWqnYWgVN4NHRHRJ93o1P9sNvfwxGzMkziVgD2GbgyWNWvdwx9oxHsjSKjH4icxUDirPg+tV1z9wRdufNgAcqJpoD7sgIdz1VRjRav7GNMn7H5DugGmlkoyPUCN+fIMAGbT3+m0/7N+RdvtArHm4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5OjzuZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8306C32782;
	Fri, 19 Jul 2024 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721400328;
	bh=3gN8i0ecGflwS/gqmHmOVCtp5ecQSGdmhme4N9RR6K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5OjzuZjL/LrHoV5JhEBE26Dra5YTxS0+XxZ0fdCR46CcQ77b8j+LEIZCdhAyO0iY
	 d/AY9eyLWHN5QaNJcGoojQRECZy/MsBweEEic82LHGL/XwHDWrl5NQ6AUHycvM21go
	 WXy+B93qSuMh+IOlQrrcyp5P0d8KKMkCejltjGs2ULfHB4sn8kpPDx2UQakhlOd8Vi
	 BTfr5B9LayCbz+RAasQCXrUwDLHe+modrvtjJGllG8SIAG+yuLQ0DkEZkDctY/fXEa
	 EqEPDGOLRjuiTsOv/XkC1PzR3sqvpGrcwWp9HfmlbsvdTmCJsHohk/+rjMhvqX90Tk
	 NtmxZtm/rt2+A==
Date: Fri, 19 Jul 2024 15:45:24 +0100
From: Conor Dooley <conor@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
	otavio.salvador@ossystems.com.br, heiko@sntech.de, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: trivial-devices: Document
 elgin,jg10309-01
Message-ID: <20240719-unquote-query-a76fd9487bf9@spud>
References: <20240719111210.1287783-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AUkpv7o3G8AkpulG"
Content-Disposition: inline
In-Reply-To: <20240719111210.1287783-1-festevam@gmail.com>


--AUkpv7o3G8AkpulG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 08:12:08AM -0300, Fabio Estevam wrote:
> The rv1108-elgin-r1 board has an LCD controlled via SPI in userspace.
> The marking on the LCD is JG10309-01.
>=20
> Add an entry for the "elgin,jg10309-01" compatible string.
>=20
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Please send cover letter for patch series. The whole lot seems fine,
although ideally this wouldn't be in trivial devices - but I think the
series is an improvement on lying about what's on the board ;)
Acked-by: Conor Dooley <conor.dooley@microchip.com>

--AUkpv7o3G8AkpulG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZpp8BAAKCRB4tDGHoIJi
0i1dAQDtneQJQmGw29RK1t8zyZ/wMrb58UQaE4NonzLXl7gWwwD+IsGmw+ysJGoR
6Ua28t63G2bEnUp0p78+2CmvcLEmOQg=
=+lbN
-----END PGP SIGNATURE-----

--AUkpv7o3G8AkpulG--

