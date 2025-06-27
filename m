Return-Path: <linux-spi+bounces-8797-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2364AEB3B8
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 12:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23B8F3B88FA
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4003294A1A;
	Fri, 27 Jun 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8YdLBY/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D082AD22;
	Fri, 27 Jun 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018725; cv=none; b=QyD7wNX5+3Flq0DBaEL/MgDhFd0DyKltuhGJgwo/jEjuHPqX1WoELOw7CRgWeZPIMYJwxE9muxCHNl9lchS0O8GokMkmuxFv8708UcPIuslRiEMWD8n/67vceLkqmLsI9Lh0WrNrf6w0mYjSuAlFbda4h3TVyEcN0BNvPg8dU8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018725; c=relaxed/simple;
	bh=8lTFqZcKLfzwA1yvfgPlXML3OGTH1zViNM6vE7IqfDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYHlc0yX2MMn8b+6C0Ddxi26hJ0lGjCozEjMAqv0HMXn+HEZ85dVbbTBNSZt98JqtyhOBNccO/wP+ru7m/exwdn7Kek4GW3Bu0ZWiv3JfiaJFdqTc9Z78UNS0iEZU0jhf0COEPLf1niSQhrE50GE4RcA26g8pFsmeDlP75EPVDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8YdLBY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5431C4CEE3;
	Fri, 27 Jun 2025 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751018725;
	bh=8lTFqZcKLfzwA1yvfgPlXML3OGTH1zViNM6vE7IqfDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8YdLBY/rjCGtDIkOaM8EELf1yfntFDFjf24Pe63sdWn7LU0iTPNcKp/D32He3kX8
	 uLT59TpbisfDYXDFtBFivcc+RJjk4nekyxXpxAHxRN92oxLIjOAeOpx8oIsSPyp1fH
	 ZupArlyiWY+LHJrtUPH3XlFDJPZIQ9k9QawFZHubBPXIo028CMmj1oPTAJ98AWQedI
	 Xk51dwtUw/BKGvBD64hdKraXd+qtrjbhuwIgqKSlRZNBex4ATCdIcG6rDrOekzfDwf
	 a6dJE1BnooE435aQ6dSL/0PMsMWyxUC5Y2XG8/TxevS7ZPh9FBM2eviL/0dXQBSFWe
	 u/q8prJaJ3t4w==
Date: Fri, 27 Jun 2025 11:05:21 +0100
From: Mark Brown <broonie@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: khairul.anuar.romli@altera.com,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairulanuar.romli@altera.com>
Subject: Re: [PATCH v3 1/1] spi: spi-cadence-quadspi: Fix pm runtime unbalance
Message-ID: <aF5s4f8TOpvDJFyB@finisterre.sirena.org.uk>
References: <cover.1749601877.git.khairul.anuar.romli@altera.com>
 <4e7a4b8aba300e629b45a04f90bddf665fbdb335.1749601877.git.khairul.anuar.romli@altera.com>
 <ab51dfce-a7d1-4eb3-b469-af35529dfbbb@sabinyo.mountain>
 <62b9964d-0f2c-4d26-9b35-bb7af3aa5c4f@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WgNgncGLVMpRLpcS"
Content-Disposition: inline
In-Reply-To: <62b9964d-0f2c-4d26-9b35-bb7af3aa5c4f@suswa.mountain>
X-Cookie: Do not cut switchbacks.


--WgNgncGLVMpRLpcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 27, 2025 at 07:39:24AM +0300, Dan Carpenter wrote:
> On Thu, Jun 26, 2025 at 11:37:53PM -0500, Dan Carpenter wrote:

> > In other words, if we failed there was some slightly complicated
> > cleanup to do.  But now it will do the cleanup and free things on the
> > success path if we're in cqspi->use_direct_mode.

> I suck at email.  What I meant was delete the if block:

> -	if (cqspi->rx_chan) {
> -		dma_release_channel(cqspi->rx_chan);
> -		goto probe_setup_failed;
> -	}
> -

Can you submit a fix for this please?  The patch is already applied and
in Linus' tree.

--WgNgncGLVMpRLpcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhebOAACgkQJNaLcl1U
h9DBdAf+PanRuDXcRs5EchLbhzchz1zUyWgkJgB0IwtB/QAvFzQoVBJKR/bFTtVE
Q8FzCW/Ssp8YzChDrRvzwuiJ2HechXsznAhsDqDRj5miMof6og/RiaG2U4pe7Z74
Lr8bdp/SLrd/91ufTF9ewHNfHWNbFeD++GYME9nAYMvLp3l1BWWbeC5PoOkCgmva
R730X3SxESfo5JeA+a/wrzWw/igkbdWP7fLrHDL9pC1Jr7rvzhFrqgSexT+e7y4d
RmFnZKmouW/czg8qqY0GlqnvyUAf+8Gpo0A0RfbUHrY12w7OjT3DAGTGol8x0swl
Qg1QSc4D1hnaJKWfT/fliLTyRip2LA==
=Buy2
-----END PGP SIGNATURE-----

--WgNgncGLVMpRLpcS--

