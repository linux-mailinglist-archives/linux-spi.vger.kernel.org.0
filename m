Return-Path: <linux-spi+bounces-3914-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C575C939005
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 15:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AA481F21B6A
	for <lists+linux-spi@lfdr.de>; Mon, 22 Jul 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB7F16CD30;
	Mon, 22 Jul 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3EIWpay"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35361D696;
	Mon, 22 Jul 2024 13:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655620; cv=none; b=Yqia+9phOyuRRCoT/hk95Z16cYeeRBSrWqLzrF0BDoZ/yMBxrPEnT3kguoQZeFT1Wpnr6JMQfDJ+3hsZIeOkHbGob/rAuQvf6mJDDvmaT3Oa9i8yrtoy/5rec6C/mw1xkf1W2hQEiZQ0Onkqvk3DR0L8DEajGcY/Niwu1s/usys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655620; c=relaxed/simple;
	bh=rZGFKbtpKbDrvqMnz5K9vjEwRQTJh8QOOkfo7MqkkVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzEQ6TLxh4PP/xpwflxvjs1fT/aONlyswEHKrfne4Iu8nBSoqab27q2n0Ky74TY36cb59scCLSb6vijgZWiR2pAACQRf79SncAMqwhpzxBm0lEvcyLMgxVB3q6f4IqINMIGZmki2IbNM/s9s3uu8IKECVEn7EMLNB100wbNYVAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3EIWpay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24B1C116B1;
	Mon, 22 Jul 2024 13:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721655620;
	bh=rZGFKbtpKbDrvqMnz5K9vjEwRQTJh8QOOkfo7MqkkVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3EIWpay8X4kfpKmKYuy+jxBvXC6JUlRNZOahRaFvELzwRXvvqzPyDQplwouxEzGT
	 pGo2XZBNGIawsvmeZyXWy4ZFy5uZqSSaq4womE8D/ugZK15k7xyZ9Etj6+m+5YySlt
	 /hXjlNJ/c/0iH308KUfCaLQ/cm+UeeTJrSeSZopADvjUbS0CySvvIjmJzZCrzGsSAM
	 5Uzh0qeIeO+EvPIRqfWwtrfGnjni90ie7+UPR/PrjJRZGV7DJHyXz1sygDDiPJOlVf
	 GPUhTVBub7jVgY6njUF8l+AOiY/r3FB9YYo+pD5MflURnAkmPND5M1O5Lk6/qhR46w
	 kbVjPj4M08qTw==
Date: Mon, 22 Jul 2024 14:40:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: sfalco@harris.com, sr@denx.de, dbrownell@users.sourceforge.net,
	jwboyer@linux.vnet.ibm.com, akpm@linux-foundation.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] spi: ppc4xx: handle irq_of_parse_and_map() errors
Message-ID: <6234dbfd-c153-4f67-a828-342919d41de6@sirena.org.uk>
References: <20240722123519.333088-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4CmWo2V43qz1bA2V"
Content-Disposition: inline
In-Reply-To: <20240722123519.333088-1-make24@iscas.ac.cn>
X-Cookie: Everything you know is wrong!


--4CmWo2V43qz1bA2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 08:35:19PM +0800, Ma Ke wrote:
> Zero and negative number is not a valid IRQ for in-kernel code and the
> irq_of_parse_and_map() function returns zero on error.  So this check for
> valid IRQs should only accept values > 0.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 44dab88e7cc9 ("spi: add spi_ppc4xx driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - added Cc stable line;
> - added Fixes line.

The Cc stable seems clearly disproportionate here.

--4CmWo2V43qz1bA2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmaeYT8ACgkQJNaLcl1U
h9BYigf+NBUu7Pk0mub0WJJ4W3R/oMZmv8uP0Ks/+xr4Fl1e9lfBjgJoGR7zhbT4
mSvv2VgYgNxMmVlikHTEf2s6exRkaGMw/0CcI4HtMPXeeC7zEdA4patRvBlyfM6p
m5+pPwFut8U9o4f/T63BRICKxLr65guvcwJBaWwgAdTpCPuMa0ulJ3YSbSSb+/Kl
wsiwhd+xn3kH8ghROSEi9J7lCdtfKB4bgX6B2cdbuOnESyLJxGnNMcfnCV4teWqS
90CPG3QmaIk/G+keHGJQGou5AKqTuRH+2MIBue5H73K/Qr/avErBnrwmKMHh3pV2
tsHbD3+yRMh/FwZh59tQwJiQiyIWlg==
=4r3H
-----END PGP SIGNATURE-----

--4CmWo2V43qz1bA2V--

