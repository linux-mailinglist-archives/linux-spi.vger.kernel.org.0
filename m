Return-Path: <linux-spi+bounces-7882-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6C9AA911D
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 12:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6299A3B81F2
	for <lists+linux-spi@lfdr.de>; Mon,  5 May 2025 10:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AAA1F7580;
	Mon,  5 May 2025 10:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsJ19w4c"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78443594A;
	Mon,  5 May 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440903; cv=none; b=rFqhtOdmKvgd9WTzfHMywFgBsa9xn/u5SdfhlybGKVd8+vQ6A89kNuT+yq5PEVGlaAxv1PpK7mX/RaQSEwpewpAUJXnAvsQhnS9jbzBnZC3XWMgkcHV6PjNeoxNFGEIvR0vgdSKWta0SkYtx6sTCGzquyyqBEG/OrYE4Vcf58pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440903; c=relaxed/simple;
	bh=66daequcQ/NDexhWr8PIUigqcaAhG0eSU90sQJO68FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ut1yfIRGz5Bho5xJQUMaumoNqSQlXdXGBw8kbk+cqWRUwt+KfLKtFzYIqh6VTtyX38SzJlUGP+DwgTCY1CVVIlT/aDKOX++kyFTMtL8fJVrCRIsFSZJRwLLYhHDjx19OHGBkQ7FLOM2h3zeON1H1jvhc8CQdFNNiscr6u4KD32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsJ19w4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7A0C4CEE4;
	Mon,  5 May 2025 10:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746440903;
	bh=66daequcQ/NDexhWr8PIUigqcaAhG0eSU90sQJO68FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FsJ19w4cA1oC7cBqw6eQAjq6/6g02V5qmGhXbNw41xQ9WRkFmDkRa7/ta7OYVLnvE
	 1TWtCGgCRaujzZ0p4XApFmIuMXhnP45k0N23iGWJ6oj6npo1hsfixjGB1qCCzCS1lr
	 nYUAzQFcQeO4BvFaADNp5Rjv/RsVehbnLEgsFDRPxr6L5SGqKmIr+9RTQuZ9qpNNVN
	 l9Aor1uINFFMiIKTX33SeuQGgPcFHJCTitJcqTV2oBjOPCZDc0NrNfddpIbd6a1xv/
	 pxnx9GXayfQMttXsmW/EL7O9jONmJsoAdz3elLqwNnkV09wvnmqDyzSUY/nciqg8f1
	 o3AWlE7VMAaDA==
Date: Mon, 5 May 2025 19:28:17 +0900
From: Mark Brown <broonie@kernel.org>
To: Aaron Kling <webgeek1234@gmail.com>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, ldewangan@nvidia.com,
	thierry.reding@gmail.com, jonathanh@nvidia.com,
	linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [regression] jetson-tk1: spi do not probe anymore
Message-ID: <aBiSwa1dB9i52noU@finisterre.sirena.org.uk>
References: <aBdOMUhuUqbZm9w1@Red>
 <aBfsJpId0Jrcz228@finisterre.sirena.org.uk>
 <CALHNRZ-At4WmJXoNs_x0XD=bRTRsKMBm1qOQGkFcNOvFfVDaMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="moz6Kvl7+K7SGkY9"
Content-Disposition: inline
In-Reply-To: <CALHNRZ-At4WmJXoNs_x0XD=bRTRsKMBm1qOQGkFcNOvFfVDaMw@mail.gmail.com>
X-Cookie: Well begun is half done.


--moz6Kvl7+K7SGkY9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 04, 2025 at 09:10:59PM -0500, Aaron Kling wrote:

> This should be fixed by a patch [0] which was recently picked up. I
> saw the same issue on a tegra 210 device and submitted that to fix it.
> Can you verify if it fixes this case too?

For those playing at home that's "spi: tegra114: Don't fail
set_cs_timing when delays are zero" - that explains why I couldn't find
where the delays were set.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--moz6Kvl7+K7SGkY9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgYkr4ACgkQJNaLcl1U
h9DLgAf/YK0kjuVbV4NkD/i11a7EiOqvMFi5Ma0zOGm075MgNWJ5Fo/EfBLcLyXT
TDFkpa9JnRh6geQNwY3J/qammrJIcVxEyyS0SyjCtQscBcjWnTQWfOKPadWx3svz
OxtarNeGVHzbfrMQcz4cncecSff3jQfoDC9FhTEpViEn+zpL27beI3YDrSAhfFZy
sx8eYWneAd5FVsnnbQzuUU+iIPxX5hANhSS+TnKjRx+yKt9dKjvrjMcLMXtO/puJ
U2z0sfqPq1jTMJwzTIrgKfPHmyCWxe6Z3nsiLQ1fDeR+TtSf2rfG+U6yIeMsZDta
gjh4s6Bpk0YATu8faAFEjdWBsJg+HA==
=qBFY
-----END PGP SIGNATURE-----

--moz6Kvl7+K7SGkY9--

