Return-Path: <linux-spi+bounces-12489-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D912D3AC29
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E7BA9300AAE3
	for <lists+linux-spi@lfdr.de>; Mon, 19 Jan 2026 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2823806C4;
	Mon, 19 Jan 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZ9DPoOu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EBF37F758
	for <linux-spi@vger.kernel.org>; Mon, 19 Jan 2026 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832861; cv=none; b=TGO0ZrDQ0YhfZUMfIU54oOyjBfVkaZTMPqtyK/em+dG8GKv3KorIBVyS3NiEn/89ugfEU9cBSiArkv03TntAhDvJTfOGgK3yhComirxiB9pzcgQ7WJwpuCI8Wt+1aGZqgjBLBMCtWI5AC8lpJ7DJ75+drmbo17ZxcQmWGxuDhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832861; c=relaxed/simple;
	bh=kjHiqqLy/VhcKjNMXw8pNr9KRe4Ems9i8vLfqVCrwRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uS5csdJoPvY+7AAevm2cX/fZw3OAOBhDxiQC5i9AeSOPid7jcsej3O6suWc7StxlhxNHaA5RyKU/HRkjn0ulqrN7BpLUADpYm5d2Eyg8UVKTp05xsApFTkp8z65U6bLy1W+dUcrtnBGbvygzIGciNHgY1uxu+vJdkOJd+q4wzW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZ9DPoOu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CC7C116C6;
	Mon, 19 Jan 2026 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832861;
	bh=kjHiqqLy/VhcKjNMXw8pNr9KRe4Ems9i8vLfqVCrwRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ9DPoOuqtI9aEXSsLx8mnMdNTANKK3Ue8+QcYKf8D12vOry6vboRA7e590PEdu1i
	 9K084cQPsK7CCy41NQqX3cqq3mx+kiiEdE+HWNWNqklbmV9AkbtyP+xPxL4ls81zHv
	 uISNwvz05riBxhcbownGZAEC7D4ua3+86akjrgh0Ztgz8HYve1aZ7fMJt8gTWjXv39
	 JJnaJ0jRolXUyv9Ds52pTl270T2jxF2jMwxi0QVn9zHUMQmf01CNHJwfkc/8opNJbw
	 Dc8mfxzmLOxL47SezMAj2AEaRZrS9TVlI/I4+u0lbgxiypQuHHNimEs8OaDjN79PuE
	 gH3NmtdGjhnEg==
Date: Mon, 19 Jan 2026 14:27:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Florian Humblot <florian.humblot@bluecurrent.nl>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: Re: [RFC] spi: ar934x: Question regarding hardcoded num_chipselect
 limit
Message-ID: <12a72c4b-4bdd-4dd7-85cd-7816e34b1758@sirena.org.uk>
References: <GVUPR01MB125993E3E5EA1CA05FF4B08189B88A@GVUPR01MB12599.eurprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bIBL6r2cvXU9PHjw"
Content-Disposition: inline
In-Reply-To: <GVUPR01MB125993E3E5EA1CA05FF4B08189B88A@GVUPR01MB12599.eurprd01.prod.exchangelabs.com>
X-Cookie: Does not include installation.


--bIBL6r2cvXU9PHjw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 19, 2026 at 01:43:12PM +0000, Florian Humblot wrote:

> I am working with the spi-ar934x driver on a ar9331-based board
> and encountered an issue where cs-gpios properties in the
> Device Tree are ignored for indices >= 3.

> Currently, drivers/spi/spi-ar934x.c sets:
> ctlr->num_chipselect = 3;

> Is there any hardware restriction preventing us from increasing
> num_chipselect to allow mixed usage of native and GPIO chip selects?

> If not, I can attempt to submit a patch to relax this limit and enable
> use_gpio_descriptors.

One potential gotcha with using GPIOs is if the hardware has mandatory
chip select control as part of normal operation, you need to figure out
some handling for that.  If there's one pinmuxed to nothing it's fairly
straightforward usually.

--bIBL6r2cvXU9PHjw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmluP1kACgkQJNaLcl1U
h9C2OAgAhcmwq2RsirWfcFyZ/e2zqNy5xFEDu/qb7+t4QX83vNBrFoRKGx5Nm5+8
yJs8fkOFD2C9KeynZTXnNnm7iThLb2dduy0vkt5aCGXGyHzwBrn1PA434IT0mw0e
gF8jx7npZwQ1TUR9dsQ6yPYGFLoJTHH+PGCL3L1gEMCp1sscVvDCFFILihihST+6
8CNVJQvVPcPd5Qy8RPieExexrU/N+Zoeu4U4/9a2fV3T/zuY/LZ21R8C89ISdKfF
8j14Z1R4z06ptLS8ueT+SyIsthfyNYN69uc9APan+r3PE5s1jY5cnzF4WuxyIhQ3
9kWXLrUme0wPMhaw2ZT20KLlrC8ilg==
=jj6O
-----END PGP SIGNATURE-----

--bIBL6r2cvXU9PHjw--

