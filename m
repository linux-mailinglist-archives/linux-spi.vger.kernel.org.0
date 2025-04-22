Return-Path: <linux-spi+bounces-7716-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99543A96E32
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E063A9871
	for <lists+linux-spi@lfdr.de>; Tue, 22 Apr 2025 14:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25407281351;
	Tue, 22 Apr 2025 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nitWoKO2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82627815A;
	Tue, 22 Apr 2025 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745331550; cv=none; b=skC5u1LnBPI1Z1QgOWpc6ChOYJwjzhznrDiOXsFdGS7axCZ5aO98w5ZYJpsmbP5LxWWDxdhiosvRgpEYn9Q/A9oo7zDg09V1Ln+WtJx1kHHrh1TmKihbIj0/9TmGs7KzubCCDwRDB7rgeQowg0fOJsqH7BmHTYepbFKexVnP7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745331550; c=relaxed/simple;
	bh=w1GauKIh97EZDy9pa0MurZVUAga2xOVmbSmGutT8/R8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQOgvPnz8pjKhNQOr3S7mToenf/TvQWI7NyjdbG8u86LLwtkgZz2Ef6cyVu5GTmAxxZBQi319TNAFXAjyU1z2iexqfU0Ewhwhg0/sGFYZp8qTdS/ZbCoJ5MsVi8D4NGgeKAIFfdvFx9rFf0ShOFSViLsnmcuCgtpO7KzlqQ6kkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nitWoKO2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41E99C4CEEC;
	Tue, 22 Apr 2025 14:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745331549;
	bh=w1GauKIh97EZDy9pa0MurZVUAga2xOVmbSmGutT8/R8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nitWoKO2JTeUnaDdNDFfmbWVOSb2y7Jdm6/Fow+VvpcEVudm0YJhhvFXso1SGYt7a
	 KkSIIHAqHReZh7I0CYZWDN0OVLXx5a24wQNhZCgu6NFMGtwFUmaOl1PUhxllm9KvJZ
	 auXqKqwgD6Mc1M4g511BAX4Pd3W2WJuTjBoSsJcRjgjztPRJpymfqvozY3uuyDEhJl
	 JPxHh+tnZ+/wsAFcoXmTyNZy9JdeZ3q8kz+wLKQpMWAxPguR6+fP/dwxjDu+OKQtzF
	 NscSkFsjpEK5dnjosbMObKb4kwshO9Y2oK2yKgsA12FPtK/KswDyTu74XqXudByq4q
	 fzZxqKAqwAT8g==
Date: Tue, 22 Apr 2025 15:19:04 +0100
From: Mark Brown <broonie@kernel.org>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Haixu Cui <quic_haixcui@quicinc.com>, virtio-dev@lists.oasis-open.org,
	viresh.kumar@linaro.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, hdanton@sina.com,
	qiang4.zhang@linux.intel.com, alex.bennee@linaro.org,
	quic_ztu@quicinc.com
Subject: Re: [RFC PATCH v4 3/3] SPI: Add virtio SPI driver
Message-ID: <4ba22af1-fffc-46f4-bf42-675b5cda9ddc@sirena.org.uk>
References: <20250401033621.1614194-1-quic_haixcui@quicinc.com>
 <20250401033621.1614194-4-quic_haixcui@quicinc.com>
 <74698d99-db5b-4ec7-a965-eea2a29e54b1@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NLtFYHpFXQoiWzV4"
Content-Disposition: inline
In-Reply-To: <74698d99-db5b-4ec7-a965-eea2a29e54b1@quicinc.com>
X-Cookie: Why are you so hard to ignore?


--NLtFYHpFXQoiWzV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2025 at 11:33:09AM +0530, Mukesh Kumar Savaliya wrote:
> On 4/1/2025 9:06 AM, Haixu Cui wrote:

> > +{
> > +	int cs_setup;
> > +	int cs_word_delay_xfer;
> > +	int cs_word_delay_spi;
> > +	int delay;
> > +	int cs_hold;
> > +	int cs_inactive;
> > +	int cs_change_delay;
> Please maintain reverse christmas tree alingment.
> int cs_word_delay_xfer;
> int cs_word_delay_spi;
> int cs_change_delay;
> int cs_inactive;
> int cs_setup;
> int cs_hold;
> int delay;

That's not a requirement for the SPI subsystem at all.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

--NLtFYHpFXQoiWzV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgHpVcACgkQJNaLcl1U
h9A31gf9ECx7V2CDE4/WPOeFRSDtY4EyY8HBkyqJNJRWmdGZej7qBO1JPBZRsrmH
I8eSRhosdtm0PjVx4CdXjPqAanQOU3YEfI+4KPGwxdXCPPQ6u2YWV/bd1XVFWEIb
m2zpAE1YGB/rDl/wglmSymjDDXiF4hy0PaGqSkUGapeOFHSCy/jz9Pa30aBJbwkM
YESOd22GK6cyI9olnVAhiUtaxSbsM+2N1WMj2llH7LcqPYf7lH0T4MJez3ZoKQzD
ELSfgmpyGFi19ECl7HZqlA+J/Qc1SrnZzKXPAg0W00WI+OyQjNgZ4l65OIa6Ic6o
eoKLeifOFmVdbWfnFNyj9Ws3u+187w==
=V6yQ
-----END PGP SIGNATURE-----

--NLtFYHpFXQoiWzV4--

