Return-Path: <linux-spi+bounces-4867-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5419297C63E
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 10:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BCDF1F26985
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 08:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A624F198E65;
	Thu, 19 Sep 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTZTGxyn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCB175D56;
	Thu, 19 Sep 2024 08:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735908; cv=none; b=pmfupzPVYkUUmn0YUt95BxqapS/kd1Vj/XsYPFDpqJFNAfL6LqvDc608PG+mq4IFRny+Bt9USI+AESPJ73vu+QgZbzTaH7DUjsnyM2XcJxHC2yUCXJDtyiVQGRCyFgIOpj2sDn2y5FfQCZ+o1wPS7OVkSG74yCb7Hddciok64tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735908; c=relaxed/simple;
	bh=ET6MA1OUiUW+N/7kbUYgh6FRGF0p6Gcyn7oMImLOVxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJiqN5cRmnn+GaOKQCfgsCC8zvo5ebSqblHQ6RDF3F+iOIZjQoqif/TaaWMJvZeDX7BH48iPNNCQ+zYzF2XuH0gn6ACmW+yetRfRnjJ1AIWU6Da9nQvsyXSRfrLUB0CByQTnpjreWgSOa8ycxuEiSA1ZoGT1487NvLxAbZt8iVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTZTGxyn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D635C4CEC4;
	Thu, 19 Sep 2024 08:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726735907;
	bh=ET6MA1OUiUW+N/7kbUYgh6FRGF0p6Gcyn7oMImLOVxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LTZTGxynmKcAzaveE06RD6KWoo8igj/9wiUHlTHgoEry0o1ogCGQeGN3aFfcbbw/X
	 LskVI2zRgrA15YmpaIQRu0v3xcguIyCP/QiII86cVh66HWtHmPrdRR8J89WFl9ZbHm
	 ydjQMUhuX9u7CZV1SNhHri9XgBwmNu56Ki93qAUtj5NOPtSENc+cUSj4xpqjOeLi7x
	 sEAMGPReFDX8W9ZHSD6xABAXzyDJ0IXWMFJkHAGydQ02ofE3qOHYEviKrXFscuDtW9
	 o6VajoEsBna2GL+NLNcOsCelAPHQ+EjSuEH7LsDYNSf8cXbAPVdGMWjJlMgQwMyGT4
	 2hocGEJbtV2Bg==
Date: Thu, 19 Sep 2024 10:51:44 +0200
From: Mark Brown <broonie@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	sanju.mehta@amd.com, krishnamoorthi.m@amd.com,
	akshata.mukundshetty@amd.com
Subject: Re: [PATCH 7/9] spi: spi_amd: Enhance SPI-MEM support functions
Message-ID: <ZuvmIG5h2hnicIjQ@finisterre.sirena.org.uk>
References: <20240918105037.406003-1-Raju.Rangoju@amd.com>
 <20240918105037.406003-8-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p3hRANhXXTAJ9udS"
Content-Disposition: inline
In-Reply-To: <20240918105037.406003-8-Raju.Rangoju@amd.com>
X-Cookie: Editing is a rewording activity.


--p3hRANhXXTAJ9udS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 18, 2024 at 04:20:35PM +0530, Raju Rangoju wrote:

> AMD SPI0 controller supports quad mode only for read operations and has
> limited support for quad mode writes. And, the AMD HID2 SPI controller
> supports DMA read, allowing for up to 4 KB of data to be read in single
> transaction. Update the SPI-MEM support functions to reflect these hardware
> capabilities.

>  	/* bus width is number of IO lines used to transmit */
> -	if (op->cmd.buswidth > 1 || op->addr.buswidth > 4 ||
> -	    op->data.buswidth > 4 || op->data.nbytes > AMD_SPI_MAX_DATA)

So this code you added earlier in the series is clearly buggy...  this
whole change should've been part of that patch, and the addidion of the
patch adding the new HID.

--p3hRANhXXTAJ9udS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmbr5h8ACgkQJNaLcl1U
h9CY0wf6A/l/KqqGOnYs+TtXstbPx3Ay1Gy0SbL59AC3NJU8YfVGhKFBdXxLW/xz
9+JIEW19463gO+sQ5pFjK1UPrBaP6nl42P+6iaIVt5a97E3G4eEIOp1L9uG2Q4Mz
O3CgiNkGZYUHcDoHEQkwl39i+sjBPXmFAcBjejQZLc7u2QGX8z2PVZ7DsJb3puXB
OUkwJrk4u69Nj+8nRuzFVWBSQv0mVW1nXbY7zxVeLNdBOK1qcl6RPJSRSBqa0etE
JYD8XrlafRC2rhRGC63jdizXqoP6o98OIfvljFh78WOVa2CZZJgxr0efiETu0/1w
LYvYV20lQQRSkE1F+kuHyJuRHtL4mA==
=d67b
-----END PGP SIGNATURE-----

--p3hRANhXXTAJ9udS--

