Return-Path: <linux-spi+bounces-3171-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BD18D6182
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 14:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DB541F22614
	for <lists+linux-spi@lfdr.de>; Fri, 31 May 2024 12:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91F1157A67;
	Fri, 31 May 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBGkownq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7A1156642;
	Fri, 31 May 2024 12:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717157748; cv=none; b=U2KWD2b5sOgkcV3WeDM7P6wEznpUlmhG+AU+qaWq1w4r9E3/GGSiaLFRHkkW+i6MDA+ZMOusle2/k/qI9Nsb0GRgBeZV32Ho3duvp1X9lnssqh6NfM1N3Zx2boCaGEzkyqhWQSdwN1f+rrQRKNO8doCK4rHidpDgpmnbKUW4hRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717157748; c=relaxed/simple;
	bh=C6xB1nDESVx0Syg7LxSCeyhpZd+rSFV/xbxquUbHsuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FZ4VoIGo4CM38YaepR4CGPCh7+r98S8BIclBphXnewTvDJkq9n3kG5C0PlV9TWLzdRhC1Tf9ncbXzdqHOkihfiXfuBWGQi0isbupa7WVEeAKEB5SPtHTgbNbAJQMzmNU5Sj6X32xBddDXTEQi9nzefTtGs3GYqkQZlu6i34y/Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBGkownq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC407C116B1;
	Fri, 31 May 2024 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717157748;
	bh=C6xB1nDESVx0Syg7LxSCeyhpZd+rSFV/xbxquUbHsuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBGkownqQ6neOy7hYpoxpmiBICuPMhYSOZi45SlhM2C7jVosQ0witSgdOv4Jresxn
	 tJDgr9Llh/aUEhB0/SKSoO/aFLYvhQk5sjqlPSrY/8j7v0PkW1sAcUWkLsOBEmXRmI
	 iheLVnYKYiW6d5ES7WOnNz88hVQ1yF1pHgmE2/yIf8VVHeOgrp1b4aQUjRo/gR6+IH
	 zGjkC5ryRDHmZvjN3tt+LlNojv120nAuZYNT5qc8yvhfbebgPmevK3+2EHAZoAdBjd
	 UqlUANUpXpKnwiMutnzPUnOU5XikzNFI4AOfDCgzCtKjVvHTO4CAx2ScCizORIVXXa
	 zVnn/G+zJ5j4A==
Date: Fri, 31 May 2024 13:15:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado <nfraprado@collabora.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 1/2] spi: Revert "Check if transfer is mapped before
 calling DMA sync APIs"
Message-ID: <3305f8ef-ccc4-4f95-8141-67c7adeeb21f@sirena.org.uk>
References: <20240531094658.1598969-1-andy.shevchenko@gmail.com>
 <20240531094658.1598969-2-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wlFOObGIjMM2ZEC5"
Content-Disposition: inline
In-Reply-To: <20240531094658.1598969-2-andy.shevchenko@gmail.com>
X-Cookie: Serving suggestion.


--wlFOObGIjMM2ZEC5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2024 at 12:44:32PM +0300, Andy Shevchenko wrote:
> This reverts commit da560097c05612f8d360f86528f6213629b9c395.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--wlFOObGIjMM2ZEC5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmZZv28ACgkQJNaLcl1U
h9BZEQf/YM+dycv11IP8yrggeWxGe/6YN8Z1d7tqkPcwT7dEt5KD230gcLXIN0zz
G1ryFhGkmMp1kyxH0kVq208XsObvb261WhMMRtgnd/1ZYkqXCKKqduFKeLlPjSbu
QM+AlW6lRmP+Wxeon4lU+Bnqf6V4oPPrlF1rPKU2qvXUtqp0zYzNsFzW8EVNF/sb
fn8qH62Oan2GesHyMJcZrbm+A8jxT4IgOeXl9jI42RWTeZXOVKYOCDU/dwcFYhiv
bzgNm0OZ15JlotEWE5jaqP9bBfK3/di1MiVyJQZHjWFcKXhyJVEGTW9/9OvoYYan
bdSkJUO4ALnerVk99d3kAcfUWuREhg==
=nfGh
-----END PGP SIGNATURE-----

--wlFOObGIjMM2ZEC5--

