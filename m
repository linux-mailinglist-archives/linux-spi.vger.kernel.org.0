Return-Path: <linux-spi+bounces-9869-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C15B40A90
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 18:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272D97A22E3
	for <lists+linux-spi@lfdr.de>; Tue,  2 Sep 2025 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD1A3314C8;
	Tue,  2 Sep 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn26u4lA"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C932ED5D;
	Tue,  2 Sep 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756830514; cv=none; b=ThN/xV75wZuSgsZEUvGv0ZfyjWToKe9m8S9KS7oHpXPhqeU5m13n0ElLbhCGDUVvpkqagBeIeYfH1U+Wu0R+eJJZXIaXPbcXzuRzULvLEcTDLxO5ddvbGTbTQrWzv3cU+a0mFXWBFDHxVjcW0u5KlfyuBQeDRAg/ohelW8vuHJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756830514; c=relaxed/simple;
	bh=3qWM1isXmW1mcxXD55WMamsR5tb/FO5a3JRgKcnuhrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OjyXszTPo2Z+deAVgDbuhDczbwKhh0QfWz8QB7geIA70Lq//WaULAg50mmTKLXgsSFJsmM01dnWTqE7oi1oIjqWHRe5FY3X9J3twiN8f/3M+pFYKq5bmMl8LSNkg/LYhSww/BYSrFIc+cMIfA4z5TAmRqwoVbgocGS/P6UeK6t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn26u4lA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 269C9C4CEED;
	Tue,  2 Sep 2025 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756830513;
	bh=3qWM1isXmW1mcxXD55WMamsR5tb/FO5a3JRgKcnuhrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn26u4lAcmOsj5NjbHiPcYo+hGRsmcYpIa69l1LpTM9+5drziCyDPrM3jCRJnUBgW
	 mLljXTGf70mgg73naRfBR8WkOJcOkqVcRxt39JATuc7PKTLYJ5u6xtbz4sy8uw0tlx
	 rTBiFEd6FxhGj49+TihpgIo9oKkMwmxw/TdcheuPplRRprnS+zBHYkMKMPvSe7t4LJ
	 3UJV8c4JLLYUBiw9UE/GDQZ2i+qXQOYRWJwBp9vYrXLqX7QBgPakkrPWpdqNz+/sGQ
	 YQAByyKauVqeWM8SrAIrdauuqCl/x3KGojyUZwlsrrcyrp9FNRg4+gP3crMqHlMEtQ
	 fg4uGB/+e4FGw==
Date: Tue, 2 Sep 2025 17:28:28 +0100
From: Mark Brown <broonie@kernel.org>
To: Harald Mommer <harald.mommer@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Haixu Cui <quic_haixcui@quicinc.com>, quic_msavaliy@quicinc.com,
	virtio-dev@lists.linux.dev, viresh.kumar@linaro.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	hdanton@sina.com, qiang4.zhang@linux.intel.com,
	alex.bennee@linaro.org, quic_ztu@quicinc.com,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v9 3/3] SPI: Add virtio SPI driver
Message-ID: <92d07f3f-8416-4b54-ac6f-c6e46869fd53@sirena.org.uk>
References: <20250828093451.2401448-1-quic_haixcui@quicinc.com>
 <20250828093451.2401448-4-quic_haixcui@quicinc.com>
 <aLWMZH3NTfM8qOUy@smile.fi.intel.com>
 <be8961be-2964-4571-9818-b5a23867b27e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G2RZgqiagCB3CCmW"
Content-Disposition: inline
In-Reply-To: <be8961be-2964-4571-9818-b5a23867b27e@oss.qualcomm.com>
X-Cookie: Vote anarchist.


--G2RZgqiagCB3CCmW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 02, 2025 at 05:54:39PM +0200, Harald Mommer wrote:

> I'm not aware of a requirement in the style guide for the Linux kernel
> that all used headers have to be included directly in the C file but
> this does not mean that such a requirement does not exist. Can anyone
> point my nose on it?

It's a general best practice for maintainability, I'm not aware of
anywhere where it's specifically written down but it's something people
commonly try to do.  That said so long as things compile I'm not going
to block anything on this sort of extremely pedantic review, especially
at this late stage in review.  I would have a lot more time for patches
for such issues, this is rather stop energy.

--G2RZgqiagCB3CCmW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmi3GysACgkQJNaLcl1U
h9BHHggAgKiHhB6Fw3H0O6lrMZi3Xk+xeRdeWcJk1ItgABmYtW93ddbteRFHyVf2
Pi7k8xYeSnk6ITDyl4VrESErjlC9AMEMO+pAdjWJ0vJ8gaOCLkKMd8KDVVhZWxDh
MZVcwBcm9CX04p6A5P1egihocy+sWrqfwrI54RQQyWLQT5moVkN8N2M2exIwuQZe
z5+8ro9aJvA+g4ET3e7Ub3nGt1UBYnTcVu/MD62fHHs6QaDLQ/b0QKQsFL1Gg9tU
ISyeZdeiJmlC24vfzDiQJyxhyWZec5dpUToWkyrwhVDaBk6N/6HmxiTD8THK8l1m
23ujwFdn3ldt7j+NPhDy/EWu8YjgLQ==
=1ZD9
-----END PGP SIGNATURE-----

--G2RZgqiagCB3CCmW--

