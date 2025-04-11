Return-Path: <linux-spi+bounces-7560-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6ADA8679A
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 22:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3B23BAFA9
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A0828D83A;
	Fri, 11 Apr 2025 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMpbqU2S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774128150A;
	Fri, 11 Apr 2025 20:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404635; cv=none; b=TWkXUklKvpzBdpf/qBAcLbL9DhmldBBoD1IUHI+k9sMdT74QyMRBgLkx5hWiX7qzijb0TQ86vI/UUV3ejq+P0GIBgBZN4qWmRNEWq0++KsbJ6M5ohAmVlEEr1sLJQGROejaaSpaAQRj1550W2vh0xvGPuKFnBFzL6kZkX9dPn8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404635; c=relaxed/simple;
	bh=v7tIIykVpkEeHOHOdVPrbm4pD3gJatssoBZugakk8FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYvUM97it6sHn+z8PPqNervFC78mRsszHy4SnqqA3vNZ9Wl8js9bfFd11MJR/0tlYBLOh2mCqIsMjkvRot3COXOOFoQTyf61xsOKRUuIOS2fEC5Swsz8rezPXki/N0tmKfOua8xnJ/+Lsp6vh1fuOszfOZpdC9m04kr4AEJdyaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMpbqU2S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5E2C4CEE2;
	Fri, 11 Apr 2025 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744404633;
	bh=v7tIIykVpkEeHOHOdVPrbm4pD3gJatssoBZugakk8FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMpbqU2STK5lIwzX/bYaFEDT5mNwvs2Eox251aQahEaFWvcGdjRCUqLMEwhuAo5VZ
	 q3D2TRw+ySJvovXAPJ+Q/c9DQ5ParyjN2e9LaaJrpEQStHIFOHpZCG3alMxAosqKCn
	 iBa4n3xAxZT70+GjwFMnAkaWkC8Hh99rJzWISJypPYVw7TbA0X0KcBBEmWxSA5Qu3d
	 s9ujKKNJ961v82mdsw50NahhCGc2eEXumTr3djWDnx9FzfR5nx+rKHv+i6zMZ6uhJs
	 st0Hz2SNm5rfVLtR1BMUTg32bDKVH7rXkjnlwBXXFZ6X+wqebdUHAOXidbfb5LnHfd
	 3SteTcsAX5JLg==
Date: Fri, 11 Apr 2025 21:50:26 +0100
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linus.walleij@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: remove RZ/N1S bindings
Message-ID: <d2620b77-166a-427f-86e1-9d2dcc34d9ba@sirena.org.uk>
References: <20250411194849.11067-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vH/+6C877RGjxnCX"
Content-Disposition: inline
In-Reply-To: <20250411194849.11067-2-wsa+renesas@sang-engineering.com>
X-Cookie: You will be awarded some great honor.


--vH/+6C877RGjxnCX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 11, 2025 at 09:47:57PM +0200, Wolfram Sang wrote:
> Except for these four quite random bindings, no further upstream
> activity has been observed in the last 8 years. So, remove these
> fragments to reduce maintenance burden.

Acked-by: Mark Brown <broonie@kernel.org>

--vH/+6C877RGjxnCX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf5gJIACgkQJNaLcl1U
h9AkTAf/fHk08GWeoY58+CGME4cGPGaOVstp6Z/ekdWGfQ0wrNfuxqg8Zt94GxVI
zAuDxwQG9VCHjlvq7DeZK89SLXXtsZsPlHQDtfd2kLFqDqmPe3ndETnR8Qn1sscC
J3TJsFsKiETLY2zhvFBM6Kq11iFMmmIO8fBbFwbJobVDG8NAoc2GSH8n1VdxOqEW
hP7WRlZqOFVxKnonHLSWq/PLCCs+f5vx3gVWyLbb4klnz1TCoMKQRxr7x+isA4/4
OSUEqEgpvUo6rqRMCbGcLVbV9usNRpSBtWNsoPobP0KWrXNlgecasFlYeyZq2CtH
MlnA6YWkvtgQf08S0/8KUpzmpPJZ5g==
=cMYw
-----END PGP SIGNATURE-----

--vH/+6C877RGjxnCX--

