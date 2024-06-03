Return-Path: <linux-spi+bounces-3200-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 843308D8804
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 19:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 219FE1F22AAF
	for <lists+linux-spi@lfdr.de>; Mon,  3 Jun 2024 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0995313777A;
	Mon,  3 Jun 2024 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1UgVgT4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C898513776A;
	Mon,  3 Jun 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717436066; cv=none; b=JFrsGrGbsgHmcaeWXo4kqV6tvjscqfmZhaKihzPDEt9JukTRKI2pgW1hZw2JE0n33iqhRX2XQ/0tZVi5fQ3GWPSIDifpkxtJSbrqTMSfre7c70ZWj7FTSLJBWcqErdJFhSurUwj5zaanKIWmSB65ZWR9GFdI3BBl6iGkR4muJkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717436066; c=relaxed/simple;
	bh=hWW3G0eifo7qT8oFYHPTIwPd7XmxHxx1suQ1k7AdbgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TSw2xfvZK2q20njoBaKMKLhp3p069k7m5bVal7LNzdjzlIFSLHTYrMHkCPP2Wj38qETVbm3TH9HjXnHqtKBRfV0qGvqZdwx/8Hn1ixX+/HDqBo7FMbC841/k0gYzbOAHlG3kzjobtl/Uk9i3SWx1fFwQkqTpHvDjgdQRWXweJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1UgVgT4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC063C2BD10;
	Mon,  3 Jun 2024 17:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717436066;
	bh=hWW3G0eifo7qT8oFYHPTIwPd7XmxHxx1suQ1k7AdbgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1UgVgT4Qr6tvNvx8llmrFJxjfAn3MdQs9s2jKLPe4Cp5AjISxZkN8C88mZkB3Q+b
	 jPN3PBuKR7aNtefP4hFXz/XsrsOLWu/E3kq6CbvuOECGy2y4aokTrjgwDH6mPc1Kh6
	 ul6iaIqhWTYr9Px4rlbU5vIb36PinqRbBxLXff5XKsNia6GbSlZXMjbog5BbGCy3ed
	 k6d+JszoayNQeqmdWfW6mjaQp0bAajkm776WD+LWfjnAz/8cmeP30oMLYkz/yrCHm6
	 zXFAA1GZD9vlsf61vkpcnVOOGi5LoHKatgvAVDCwjHDDlTOUGCRBn/fvEcmYmbO8jq
	 XlptYZSAti+bQ==
Date: Mon, 3 Jun 2024 18:34:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Kanak Shilledar <kanakshilledar@gmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Stefan Wahren <wahrenst@gmx.net>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v3] dt-bindings: spi: brcm,bcm2835-spi: convert to
 dtschema
Message-ID: <72d5a275-a4ba-40cd-a05f-a47c92300b9e@sirena.org.uk>
References: <20240603173028.2787-1-kanakshilledar111@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vhgvjCA3CxC/LJSF"
Content-Disposition: inline
In-Reply-To: <20240603173028.2787-1-kanakshilledar111@protonmail.com>
X-Cookie: Don't let your status become too quo!


--vhgvjCA3CxC/LJSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 11:00:23PM +0530, Kanak Shilledar wrote:
> From: Kanak Shilledar <kanakshilledar@gmail.com>
>=20
> Convert the Broadcom BCM2835 SPI0 controller to newer DT
> schema. Created DT schema based on the .txt file which had
> `comaptible`, `reg`, `interrupts`, `clocks` as required

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--vhgvjCA3CxC/LJSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZd/psACgkQJNaLcl1U
h9DrDwf/ZcVMdlLRdv4CYq05lqAZzjrck1p/12rqewZboO1aGn77HIFZsvjQvKBq
BeY925bI+ONdrK67SF1Xw+eY5CJYV7FtUsgqgdqVTWTU/liXsKIsgyUeiOSQRtMz
KtjlGWDGcLVx1s7brs9Lyb2Wl1F1pjkTzvg8rO3XE0GR78WILXNQF6UxgOf3aVYJ
g0aL9Ik9yxpDBAkPfAtl6KSlTWb4/I3jabJu9M9uvaGbOfuEIYDzei6/C9sS9Zr/
JDxKutbkF6ReYhlkd9LFXdQrkh1ZJ96d6dm+9EfH8Y21P/BT0lyT0W7HQ8oOOm9G
hvXbNQNo/J/s4HtfNCGCW4Nq7OhI1g==
=05Oc
-----END PGP SIGNATURE-----

--vhgvjCA3CxC/LJSF--

