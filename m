Return-Path: <linux-spi+bounces-4869-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC60697C689
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 11:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B16C1C223A4
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 09:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A675D1993AD;
	Thu, 19 Sep 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1l+m7Bh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FB819924D
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 09:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736715; cv=none; b=PzsmrnA28Gl0dI/EG9dyNQisYynzmcjIRT5ndnxwP2sJu/DBqVSxV05QkZEVLKszZlW21yol5NE+xm35EBIA1PhNqMKnFEJtS+nQf4ARG6hdaIgfoCjKuWoBZ44CNihIitcv+aINLSHTgLGZ5sHXNBl3JyYhlHyvlhXpBHnFD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736715; c=relaxed/simple;
	bh=MrpTQnJCrkN7tarzGfGxLC3if1lqpOlNC7nBUCW8+hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9+lJI6RBmHzUd8AdD5+/dlTtOGnzsjaaMmOLY2OGaKng0VmLt9dUF7z8hJczJZZFHLlJGDAGoNJ1zI/4wz6EtcXBzYdbUsBZW+gWIYDfDzqjXsM8fKPHYdprixprmwo9J5Q607mKnde/lNe/vD1D9q5U59b/8f3xT+To29NkTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1l+m7Bh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE13C4CEC6;
	Thu, 19 Sep 2024 09:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726736715;
	bh=MrpTQnJCrkN7tarzGfGxLC3if1lqpOlNC7nBUCW8+hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1l+m7BhmDchiIh90Lj1/tb4zQRE7Bk5NRjCCvm5vY7aIsSdxsfvpVfVcm2aIm7OL
	 Yo8isa2lF54sFyheDeqyE8MCzIcXL/t6XltsUvPmZQyos80fOdGMfenhF0hRFduzIZ
	 L3WhPi9idGF35/eRizzwpWtBl5KVf5mxTmkdheCDdtRwjtDkWmc9/2pB8pLNj76iQm
	 X2urL74ALlS52ZRA8CL2dE+CcymCSDTY+vNdo2Hw/WAQi0zwj2SUUwHFBBYXoo2AQK
	 1rBb+k4xBIOMlrJ/r9Skc2rXhZFs+BJ25J5bWornzX9zbQfE2jAEHntTuj3CzfwLpK
	 nKatx0OHeLpoQ==
Date: Thu, 19 Sep 2024 11:05:11 +0200
From: Mark Brown <broonie@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	upstream@airoha.com
Subject: Re: (subset) [PATCH 0/4] spi: airoha: Fix errors reported by
 mtd_test kernel modules
Message-ID: <ZuvpR9GJkZZAqbHI@finisterre.sirena.org.uk>
References: <20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org>
 <172673459965.1807523.13398242599346549903.b4-ty@kernel.org>
 <Zuvn6H9wmb7PQLac@lore-desk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XHsNIW3O82zdmcY5"
Content-Disposition: inline
In-Reply-To: <Zuvn6H9wmb7PQLac@lore-desk>
X-Cookie: Editing is a rewording activity.


--XHsNIW3O82zdmcY5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2024 at 10:59:20AM +0200, Lorenzo Bianconi wrote:

> I think we should include even patch 3/4 since it fixes some errors in
> mtd_oobtest kernel test module (and even some ubifs reported errors).

Your changelog doesn't actually describe what might be fixed there and
it's not obvious from the change itself.

--XHsNIW3O82zdmcY5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbr6UcACgkQJNaLcl1U
h9AeGwf/ajPYYMXOyA70GXik7jPHyVZb/TX8lazj5MMmAbb9SOP5sAMoU0MlXESW
o7qrMKWjlBK1IsGu0bB2T6amfTX+ulDrlvtwnEFoVgW7vRJihojIoYAzLX+zuMqn
+++zapXoN/iWBEB76uNuqQAz/qk7cZH4A91e5zyaQBul85aGF5OJ7RvoBXqDlYa6
u4ljNzo1kmGPYBDdAasEwTIAcf6579dndfC3s7ui6cOa6riJIX+54bnq3n6w3f6Y
tMdiE62ogz8PKU+cBANsnBuO2KVDv42PyGe2BcdzBxe1ZljcBA0lk9EExpiK8E0j
eFXgq/v5NRfSd2YagOPj4EhX7BCLAQ==
=qDag
-----END PGP SIGNATURE-----

--XHsNIW3O82zdmcY5--

