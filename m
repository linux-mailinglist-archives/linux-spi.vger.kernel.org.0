Return-Path: <linux-spi+bounces-5122-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319FA992FAA
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 16:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E00285FD2
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30D1D5AAE;
	Mon,  7 Oct 2024 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBZtBemW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC3F50F;
	Mon,  7 Oct 2024 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312190; cv=none; b=GBNm9yZgcWTTfxE+MDB6zGgalZjVZCb7tIKGQpAR/zVRWHSBLOoPZgK/xNu/LpEH8viKy/InJMxPfQOl0om4Cxo/vy8UOByPCmrmChnl/E2+tA7G3BYnX7p6skLLb9ZYqOnL8wqMHfequzGowYJ7V3/9fWebPIXg0YBqJYBvcGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312190; c=relaxed/simple;
	bh=eJcPBzPOo94qozRNulmiiqa57Jsp9yA4mklXXVuzvDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jm4GAqqjIQjlz91+A4ZlTbyMlaTkmPDnbZEvdt/L+nFUFZUL3w+bgKLoX9n9Onc56lKa2zr7XtzIMk2JbjMHKeB7QPx4hpjU8oqvtJuuURsZ64tsSrHGaseFlK+Cv6YqC4E+cxJp1h3pCwjJh43DWEK3BGyO2shDB2U4JT/yC2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBZtBemW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62370C4CEC6;
	Mon,  7 Oct 2024 14:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728312189;
	bh=eJcPBzPOo94qozRNulmiiqa57Jsp9yA4mklXXVuzvDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PBZtBemW8bI3a2O7I1dI0KMmYVCAWWCsfhu+4bUsvyu5eYvrD48xVPnlFxcy8O0xs
	 w5OELJCHnrwwkH20SIQWayKuIa9659om4Gj9HQC/zwipdvU5PeRfqKtRCccrWBImiY
	 EwKZEXEU+XQfALxq9i3ijAsLx4LNvGVm/hoCwgNQi0NtBpxCUrdIQZYf617PtbowXW
	 8ZnJ+hgyGAN7yukpbDfdubQ1q759MIRYUXQpGZPWpyOiYQRhxEJgN47K53LWoz30T5
	 CCp9UAE4l2CDP0EJ6CddgVtHM4jG+iBwESd4FH75I0WFga7vqIEvqK/0Z5Yn/t78o/
	 kbS7CBY1DWBDA==
Date: Mon, 7 Oct 2024 15:42:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	tsbogend@alpha.franken.de, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH 3/3] spi: spi-mem: Add Realtek SPI-NAND controller
Message-ID: <ZwPzav6dFQdXSnjx@finisterre.sirena.org.uk>
References: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
 <20241006233347.333586-4-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EQSz8Y55RytcW1nf"
Content-Disposition: inline
In-Reply-To: <20241006233347.333586-4-chris.packham@alliedtelesis.co.nz>
X-Cookie: Editing is a rewording activity.


--EQSz8Y55RytcW1nf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 07, 2024 at 12:33:47PM +1300, Chris Packham wrote:

> +REALTEK SPI-NAND
> +M:	Chris Pacham <chris.packham@alliedtelesis.co.nz>

Pacham?

> +static int rtl_snand_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> +{
> +	return 0;
> +}
> +

If the framework doesn't already support this callback being missing we
should probably make it so.

Otherwise this looks good.

--EQSz8Y55RytcW1nf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcD82oACgkQJNaLcl1U
h9B8vQf/f+utPoBaQipGj9uZ9LhmVUzoDgoFI2BI9OjypVnf2Dbvytwow5MGzxjw
UPWx6WsalMR6f2vXz5D/vjXkZfHtRtEZ2kSiihcOVQLuamSDMJBRd4HxZ716ytKv
MK3KE9efa6zssJDrY31blYzcGOucrLxXHG/2Y6KfDWhnsTFH9yQFmEL8OF55xC5o
bPVS0FTzrH0Kplrs2tD5g3p48ngm0tPxO9LzuY5SMrx0Z6P0YyxzCx63ZjHgkYMz
DONDFxLORmYr9DGleHsbVOXY8vtmgLhUJRxWKTx45Ene6VwdEqxyNK44NY4E1p2l
GElS7IvtAXqDRzAhubNdh8ToPrNqHA==
=9dFi
-----END PGP SIGNATURE-----

--EQSz8Y55RytcW1nf--

