Return-Path: <linux-spi+bounces-7342-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005A4A733E6
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 15:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7063189B01C
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 14:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F870216399;
	Thu, 27 Mar 2025 14:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlNePcCL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06667212B00;
	Thu, 27 Mar 2025 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743084429; cv=none; b=X1wfx+Mya4jtSuy3mbRYGjWqapbIimyyV8d9GRk+eZn1Ww406CHyXOOAOieL8xPFVSRlCFvtAjRYQtZZsbpIon2aKcD/e06zENFehxmN3NZumQg6GQ/14zYA/5e9XIZiSeJSS7xk/WItNgogO3BjPo6rdmfS71dhw/oO3gxOTpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743084429; c=relaxed/simple;
	bh=ylAWPbcULtSaZe34dKWVThPXcBtGPQIYkRD3zXK0jv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtfpTP5Rj0VuFUppJ19K81u+GBLwPYglV11pi8wp42Xwn7etmrOMeSNKg+FCM4ptTBbuyHm0SQ13BC03iaYRUT+KIP0G64p7JifEwQpC5aWamcVU9e5Z4GUyz8qrFyx2MBX5Kv/WMkBYs0ICtK1xtN1ahKveHsYXF7LXVEpZiYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JlNePcCL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E0CC4CEEA;
	Thu, 27 Mar 2025 14:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743084428;
	bh=ylAWPbcULtSaZe34dKWVThPXcBtGPQIYkRD3zXK0jv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JlNePcCLfToBC2V80buwbF7hDm4cODW591JUZKXC7jYOsbBYiLE3imKkGNI8oMDuv
	 aMcE1Pg4wpXRcR/WL/KlNcz4cVY7kyahY/rNM976Ke/WDaIlCCu1mzsa4jlJoUEw2r
	 D06695KHjfWkSZSZis1fG20XslUzL2qo+FzqN9DVsZkm3q8e9sK+qfLdFkhTxTVWAU
	 gs1Apq/l6ay9uP/nMwuPDhtS6lkzNDrVIZN8Z4kZ+nito8NSZ/+9JNEkgXumk27O1/
	 45lahgHvDPnm4IsxX4eQW2oRWEtZSo/w7Q+m9b6xHrvUcZyhImnR9hsU6g7RXdYgWS
	 xQbvUdMWftaCQ==
Date: Thu, 27 Mar 2025 14:07:04 +0000
From: Mark Brown <broonie@kernel.org>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
Message-ID: <f3115251-8fa9-4019-8fb0-145daf32cfa2@sirena.org.uk>
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
 <40db39ef-7ef3-4720-9c85-ccfe1c11c299@sirena.org.uk>
 <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
 <3aa2c190-ce4d-4805-943b-f65e98ce762c@sirena.org.uk>
 <8435b037-8b54-401a-b4f6-b4b497c4c3eb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UgfMhIpRC9osdcao"
Content-Disposition: inline
In-Reply-To: <8435b037-8b54-401a-b4f6-b4b497c4c3eb@quicinc.com>
X-Cookie: Multics is security spelled sideways.


--UgfMhIpRC9osdcao
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2025 at 03:33:15PM +0530, Mukesh Kumar Savaliya wrote:

> IIUC, It comes to the point of first identifying if it's in context of QSPI
> controller or SPI controller right ?

> Identify if SPI/QSPI controller has this capability using dtr_caps =
> true/false. Then check if it's supporting SDR/DDR mode. Can we then
> introduce below struct to first mark capability as true/false and then
> process dtr_mode ?

> if not supported (dtr_caps = false), then don't care dtr_mode.

We should complain if the device requsted anything the controller can't
support.

> struct spi_caps {
> 	bool dtr_mode;
> 	bool dtr_caps;
> };

The controller capabilities are currently mainly advertised via the
SPI_CONTROLLER_ flags but adding some bools also works, some things
already do use that.  I'm not sure we need to wrap things in a further
struct though.

--UgfMhIpRC9osdcao
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmflW4cACgkQJNaLcl1U
h9DO7gf9GK9kaZ7F5byJPJNQeOitCwqJBmRUPfkO3oVkQLL0DGjU/ckyHfNcq/27
Iv3KniQ2oZAEqO9UpGcOY7fjEl+e1eb+aDyEBGHBZnrJbqVbaAmB4dBH4PYu/zRm
F/u8ibgorqythriUu1YW8nTxg81x5sHZhNvLR9geyXyKrMrIXYoZJ/T8bAfnDpKo
EdBKdh3Skcj830O+HytvyPNcZDBKZQc2kMGPMh1qnGNKQc0GIa/oGOQ7g6vXcRjz
i+e8CScGMdLsDc0yp9t46TA/NF0TMNVo2N6bPrPSe9425vmOBz8fiN7kqnpxP/5g
1cdoovWzMFF/PNqGxnOkRHJDMbXTdg==
=rjSg
-----END PGP SIGNATURE-----

--UgfMhIpRC9osdcao--

