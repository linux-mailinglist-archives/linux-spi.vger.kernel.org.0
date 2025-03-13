Return-Path: <linux-spi+bounces-7115-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF635A5F50D
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 13:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 162713B9EDF
	for <lists+linux-spi@lfdr.de>; Thu, 13 Mar 2025 12:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8502676E0;
	Thu, 13 Mar 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m49Xp00X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232F266590;
	Thu, 13 Mar 2025 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870765; cv=none; b=Wc0L6wym5t2NB6a1x9rZ71boBRlZ9icMarTgJNQlY3Jjdx4DcFGa69KfJdJ4tC1/KAQx8TfCwnrf5Ylv3wxT3rvVFb8Z0C0AeXsMLaxy6fmczYN7/b7nA56helObQ3xSxvn8bcrQuYCfA3r+zoP4g6m+kvUVgNzSBPsovrO5DCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870765; c=relaxed/simple;
	bh=o1JokyjlqWN8gJ/eoZQUlSigREd9jnHfkinY7XpmE+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DF7je9gIXzFRG74cxLtNsVSA/LkmsPQV8VjdzhQJ2OXg/Xmf86EEsXfGI/NWac4KyZLcBvJD5XVyeGJPD0XMJtPdtEtyvGvEuNs5Nd19W1C2abcjpJyJKEHA3hCUb8kYpGeYTFak0WxP9fnyMIdUntCBzW1E9/fkkGwuCGYZORU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m49Xp00X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71668C4CEDD;
	Thu, 13 Mar 2025 12:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741870765;
	bh=o1JokyjlqWN8gJ/eoZQUlSigREd9jnHfkinY7XpmE+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m49Xp00XfLAITcQER8VcGT7UtdqnNpSa1iL3rBZcQfRBl4OU9q69SQCwjLgBUE2Q4
	 gXm5/MBUy1x5igul64eQjyxQ4oiK36VPOECUmdurnIepNmPPbqKtKJCdsTuxkNAJXf
	 5mhYVJdv+N0Xuk/XywDFy0wYSPyIIQEM7p2qZdOfHIs6bIJ54NrWNpjDqVloX9PZ9V
	 ZNVvxaUvFUsenAoPFLkyqWPNZUY/mzxXOA+6cqVO/uZcyYYR3mo6DLSvpyGY6Vl/j+
	 +YMT4tfKsVdj2Q5BD8Xlw9QcuxM02TjC5j1ovy8Hw7N2EL0h398eLZp5lZhOoVJWZU
	 B8qqSZkPyLB8g==
Date: Thu, 13 Mar 2025 12:59:20 +0000
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com,
	richard@nod.at, vigneshr@ti.com, bbrezillon@kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 4/4] spi: spi-qpic-snand: set nandc_offset for ipq9574
Message-ID: <ac5673a7-d573-42ca-8535-254e2c1083aa@sirena.org.uk>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-5-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DLVPIcV9y3hPcH44"
Content-Disposition: inline
In-Reply-To: <20250310120906.1577292-5-quic_mdalam@quicinc.com>
X-Cookie: A beer delayed is a beer denied.


--DLVPIcV9y3hPcH44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2025 at 05:39:06PM +0530, Md Sadre Alam wrote:
> The BAM block expects NAND register addresses to be computed based on
> the NAND register offset from QPIC base. This value is 0x30000 for
> ipq9574. Update the 'nandc_offset' value in the qcom_nandc_props
> appropriately.

Acked-by: Mark Brown <broonie@kernel.org>

--DLVPIcV9y3hPcH44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmfS1qcACgkQJNaLcl1U
h9AZQAf7B6HWMHCl2lowKK3SbhxOes8At7H7cGoilgVUlhRLpGHnkHSjYEJ1FlTG
QDGuOYVraIvxayTbRQNnxBDDAaGWWD4JYR/ukvFPL3CbN5+pyAuOKM1R2TsLwafC
TidjQjxxD1Azv9+NwPaJYn9wTcwis7D/ENNLUqW7H9edkdxCmKIEYPQ0jtOIq4hI
UnEtYy1FJN6ADYZeDJXLQZKyZY7steggwFKzz5HBekgS7Z2ILo3sFAfAVqb3C6p7
qdf4X1H1fs+QuSAPJa1k632ZKMiPHy95hGkJssPyz/ft2zBuUbjQJbaDvt/GQAhk
6Ha6C1g0bN2cV/ts0mfZaO2q2ld3BA==
=pp4l
-----END PGP SIGNATURE-----

--DLVPIcV9y3hPcH44--

