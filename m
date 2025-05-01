Return-Path: <linux-spi+bounces-7822-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E5AA64E3
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1501E3BE373
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 20:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0291325334B;
	Thu,  1 May 2025 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3htQxm1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C313D251782;
	Thu,  1 May 2025 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746132430; cv=none; b=RyfoPavfGdXnsD9wHrq1vKbkpgNxHiJbisHJa62aPOrNfZ7vzic9g6ESqh0IB3IYMThbAbgMbfeXLXGNydUSTDsaARWDQpa0ZDNba8L+wbp3lkk7h7dHYYzuxpdvuTr0PV60e8sWurw7xkc5nm5smLyYY42X87f2ruDMZaa+IXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746132430; c=relaxed/simple;
	bh=UiNTIn9FoqDdnMleZU/ZZ/+fnIbmixeKKNoJ4FezKvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaNlMRZ6gzIwraDhioviBNLwY9ae4ldbkPf4RnOlWlts0MtwnBcBfDAQhYO+kSZkCcDFvDoHjI+bG+eOsCtowJVDDTz6xWcPXbceycQyUSER77WUsVZffldIoMNbXOue3mMft4cPxR2sw943xS1OfiFVKYbxc6bWOAIM7B19FpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3htQxm1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40F2C4CEE3;
	Thu,  1 May 2025 20:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746132430;
	bh=UiNTIn9FoqDdnMleZU/ZZ/+fnIbmixeKKNoJ4FezKvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m3htQxm1w0PQRO6PwU7oQ5gBPmJQnFCt4g8y6SxzOwE4G8eVW/gssjcKUegmHkZf+
	 FtHdz+sc/93ugffZFJK25wvcxSDF6qkqbY9xSSEP5h1j6VYHcP/OXlhQXjJer26b9e
	 5jkma23zBEwdZJv9AmPgS2mBegmzqarIU9r8HwRy1g/ITfys9JP4diuhIJ00+Iaz2r
	 ROkZq8WNSGz0ig7nIDr8hNNgGr8sZx7iV4fbK+HE4g/oloSdmPUmnNRm3wXGQ0mGRk
	 GE8uMmx7sqpqwNpKrI3n1kzLpryJWX/R6rncLGsBEj2r/KBEqZjDqXcul1JhF/x19N
	 DrS/u/7BeflWw==
Date: Fri, 2 May 2025 05:47:07 +0900
From: Mark Brown <broonie@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] spi: spi-nxp-fspi: enable runtime pm for fspi
Message-ID: <aBPdy8rR8M9x38w9@finisterre.sirena.org.uk>
References: <20250428-flexspipatch-v3-0-61d5e8f591bc@nxp.com>
 <20250428-flexspipatch-v3-2-61d5e8f591bc@nxp.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oAfTii5X1lsdJXzy"
Content-Disposition: inline
In-Reply-To: <20250428-flexspipatch-v3-2-61d5e8f591bc@nxp.com>
X-Cookie: Well begun is half done.


--oAfTii5X1lsdJXzy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2025 at 06:06:44PM +0800, Haibo Chen wrote:
> Enable the runtime PM in fspi driver.
> Also for system PM, On some board like i.MX8ULP-EVK board,
> after system suspend, IOMUX module will lost power, so all
> the pinctrl setting will lost when system resume back, need
> driver to save/restore the pinctrl setting.

I think I would expect the pinctrl driver to deal with restoring the pin
status over resume?  But perhaps that's not the way that API works?

--oAfTii5X1lsdJXzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmgT3cgACgkQJNaLcl1U
h9CoAwf/cEyw6JWwhqoZvJEjqEzp3rVMCMhB6y9xgiOpL5V4+GIZGoVC/uWMEPtD
J1uBokW0LCVxsplGWXY24gu49au+pxKTaEwyB8bCYfk6bR1McuE5cV+9Y6Jo+t6u
LlaEaFVPozTSfVnx5OX7XyBPVEcr777LgeSwqxl6zMZ7TfhDTEHhWHhlbvGu95m+
PgPSldOfFMH0JgrcIIUJ1wEnUpTUZuy1PSxbxtKO2XWYZtb1EoFNZe3Sl+FKNr06
tY1wS/of8qHiG5zbVIT4UWei7pb612kO7zQCaDsUx7RKr5Y5YEVTj6tSJ5KXLZlw
zRfiy9lUBuaPYLA/ODEmylfdFjygGw==
=1ET9
-----END PGP SIGNATURE-----

--oAfTii5X1lsdJXzy--

