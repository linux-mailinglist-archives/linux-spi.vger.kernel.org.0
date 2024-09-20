Return-Path: <linux-spi+bounces-4904-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6BE97D762
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 17:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEB21C2146A
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2722EEF;
	Fri, 20 Sep 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTHOI55I"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A931E521
	for <linux-spi@vger.kernel.org>; Fri, 20 Sep 2024 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726845272; cv=none; b=CG/5P7hWhEOXTdLijfOGugxF3oka/Q5wZjqkPCfPssakCQ2Ix2dwt8cMahXvg/vJp8N2ybUnXyUi7tqWH8/Hpx+XdXI4jgyx8VMXQQ6hV4xDBhTN0fyz9MQ7zDh5dIggm91xbvMjp0NSo/pCRh/gNgJSAk8tCpyYbqfyy0rBOPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726845272; c=relaxed/simple;
	bh=Awf5vk9NUKwneLFtXrrN52fi/D72mFUt46kuOsqzRvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdqoeqpqHhgJiF+RTNHvTPIX0ZM1gvhWFnOVzm5Bvh5Xc5HQRzug1YI/AHnDRLj9hOd15s7CBTq4hlCA+/z9p11pGO+U3UomSxnXTHu51KwI+BFKta8B7MwOF4JPOF4RJnh+8AT1ln5BUcEfiXRgYqTcVOHb4j79nnB0eO5DYFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTHOI55I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C7BC4CEC3;
	Fri, 20 Sep 2024 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726845272;
	bh=Awf5vk9NUKwneLFtXrrN52fi/D72mFUt46kuOsqzRvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTHOI55IQ1aO4nFlgbsCVvU4XENI/zF/NxqiEFE0GIr7cLBGoXkndtaY+PXKhjYJ1
	 6Mwp9Be5ujWJYQ1e8496uhT6i1S6dLMT0mSImQ7Wy6Ux/lc4O7DwIfh0sn5innVhzA
	 tNK4HZV866JbCC/2qsWlYIvwbmdjmoEskYxNeEb2SnA1vsG1nA9lx8+VMesWvl5mUl
	 PpldENDY+si3thd/v8HgHzwVoeeJ00azJ44EuK3cmSLDQNzEUo8IRP2CVTWgcSBvjI
	 7Qig1+jGZdKn/eXpGgXbJtC5h0apFPzVU2cOzKJOMCpkB/P83xtyI3KT/3Gl401LtD
	 qN71rNJ/dzlBw==
Date: Fri, 20 Sep 2024 17:14:28 +0200
From: Mark Brown <broonie@kernel.org>
To: Ralf Glaser <glaser@iotmaxx.de>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: migration from kernel 5.18.8 to kernel 6.10.3 spidev driver not
 loaded when device definition in DTS overlay
Message-ID: <Zu2RVC1vGUh_-KYb@finisterre.sirena.org.uk>
References: <7bbd3bc198a84e25ba25e28a6989ba3cBEZP281MB3361E029FEE3756F30ACBA99A56C2@BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KICOqffkINydSptA"
Content-Disposition: inline
In-Reply-To: <7bbd3bc198a84e25ba25e28a6989ba3cBEZP281MB3361E029FEE3756F30ACBA99A56C2@BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM>
X-Cookie: Editing is a rewording activity.


--KICOqffkINydSptA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 20, 2024 at 01:24:00PM +0000, Ralf Glaser wrote:

> sorry if you received this mail twice, it was refused by the kernel mailing list and i was not sure if it got discarded completely.

You turned off HTML for this one, but also turned off word wrapping...

> On 6.10.3 no /dev/spidev2.0 is created and /sys/bus/spi/drivers/spidev does not exist.

Well, if the spidev driver isn't there you'll need to fix that...  it
might also be worth trying mainline here in case there are any fixes
that stable didn't backport.  From a quick scan nothing is jumping out
though.  As far as I can see that's the issue, the driver just didn't
get loaded.

> If i however put the spidev definition in the main DTS file everything works as expected:

I've no idea what, if any, special considerations there are around
overlays or the specific mechanism you're using to load them on your
system, you should talk to the DT people about that I guess?  I wouldn't
have expected the use of an overlay to make any difference.

--KICOqffkINydSptA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbtkVIACgkQJNaLcl1U
h9BG9gf/VVOVmrRhx/WJwFx83A3robRXefHfl1cN/y23ed1U6esUKiu5BKaejsgd
a+Ws1axTwXzCR2ZAZzqVuyflSRspFWuG3rcAlkGUeamFpEgsB3ljFhmuGwKWS1TT
k5C7QvA2m0sDM8a597GwH/tLdKi4WbBrmDJwDE6yzgtR6nWR3aBycCQyp7zjkBBX
5UK0LAKH4U8iJjmMQBYysQCYLByqPKYWilrwAL/ChM2eEghA1aOKjxikk2BSxg2a
GdQTlFrPTsGwp+p8+vjzUaxUA5U3xUUg1qF6Y7nSPT88Uls3djM53d52LEKdY9PV
RXrhq45i7/L/+NhJs8urROhdLp6Srg==
=Q+ir
-----END PGP SIGNATURE-----

--KICOqffkINydSptA--

