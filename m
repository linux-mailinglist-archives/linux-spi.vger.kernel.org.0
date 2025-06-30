Return-Path: <linux-spi+bounces-8905-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 878E5AEDCAF
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 14:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B06D1897747
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 12:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D92289813;
	Mon, 30 Jun 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq31+EHh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF631DFCE;
	Mon, 30 Jun 2025 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286331; cv=none; b=j90LaiAnf7Y33/x2aKj+fyWC0UXPjuj2zw33RQ1qmzGVwi6G8xExn17R02Gd8q+Fo4+ZBKyrhRAiF9l3AyKdCVUtTjaBQVaFqjIlxlhuMKIlQAN1JjsoxkKyhzRTMwWfJQmrZsG1dkzgTJrDD+wrHHkbvH1J6xpvMyDJpxxNsII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286331; c=relaxed/simple;
	bh=/Nh7668kx4y9SMLFnC5E0UKjVhGh1MQpDK17Uf7Pwfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwGd4E4Xr1R9OYvWyj8SWLxTj6amFUSO+7rFWScdn7Coe1W2iwhRG/zmF0ls/B6tbFCpE8eG5sfeeQs5a6etwEExNodiXABe7QXBf1T6QNqHk+V14AD07rIy45ZhjfVBTHC6BVaTd7ZiAex4DJ7M/Ny9MgkIQDChoKLls3A0ofw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq31+EHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FE2C4CEE3;
	Mon, 30 Jun 2025 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751286331;
	bh=/Nh7668kx4y9SMLFnC5E0UKjVhGh1MQpDK17Uf7Pwfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jq31+EHh8cTiZ17+wENiaURgg1te2Xb5+7q0x5uUY8ozaYODHKMTBs1WuSHMDel1s
	 gubtEHriP1LgIpo7fGTr936sNEUN90nu/BnAPE6V5ok08UzRqSEzhjR7qZ3fHIWusc
	 Cq9I2LMDsWe25PFPoZHQ9kUEkRL46wZlRwv/OoHelZ5WkodrxfY6Gm4kdiuacB1+zI
	 FFi6U/2koJSEx5ecVzO/HgJOitJDkmB9XPXiRN3JDFj0W9tkmWvhRq0aqgpa0Qp7vc
	 +nQ1uLWEeHXFBiK/rpjkIoqlltcEaR1Ax+g6AXQPFIL5UllNexfHGqWN1gpzWsVrhl
	 LndiCnbA4K1OQ==
Date: Mon, 30 Jun 2025 13:25:26 +0100
From: Mark Brown <broonie@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>
Subject: Re: [PATCH 0/4] spi: spi-fsl-dspi: Target mode improvements
Message-ID: <e5dabc83-eb1c-46eb-b24e-6dc8b19c4ff7@sirena.org.uk>
References: <20250609-james-nxp-spi-dma-v1-0-2b831e714be2@linaro.org>
 <175128365072.28911.16806664823646528710.b4-ty@kernel.org>
 <9f707fd9-a9f0-45d3-aaec-e20bad4c4f76@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ULz/ZILk8N8rSVNQ"
Content-Disposition: inline
In-Reply-To: <9f707fd9-a9f0-45d3-aaec-e20bad4c4f76@linaro.org>
X-Cookie: Say no, then negotiate.


--ULz/ZILk8N8rSVNQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 30, 2025 at 01:23:18PM +0100, James Clark wrote:
> On 30/06/2025 12:40 pm, Mark Brown wrote:

> > [1/4] spi: spi-fsl-dspi: Clear completion counter before initiating transfer
> >        commit: fa60c094c19b97e103d653f528f8d9c178b6a5f5

> > If any updates are required or you are submitting further changes they
> > should be sent as incremental updates against current git, existing
> > patches will not be replaced.

> Not sure if this is a mistake in the notification or not, but this one
> shouldn't be applied. There is a v4 with some issues. Although the
> notification on V4 that patch 1 was applied is OK.

Please follow the above for any fixes that are needed.

--ULz/ZILk8N8rSVNQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmhigjUACgkQJNaLcl1U
h9CSMgf/YSsjAHOhlw470DmgAfa5eyB/RpfrNpRQqI478cZFNf/4N28FGnl21eHz
B3otvOyTf68VUWsV+pGgboGL5nYWlTfulGAj355i545PpHLQO18Ir6RTPK1NGfBp
fJ2uOAfKszSO0hA6Djk3vkykARl8e6IdWYuiqaoJPuQJ2zZtDZx3yu+8nRBdBcuC
RLAcMJ1c7EbfJuPdyt/B3tyUuVPzVKYxSBaKDLjg9V3AUpmMMmFPG54lE2dN+eDV
r6NtOCbm+WGKp7eLgwBQCgAwsBKxWNDkt7vy6kleEyz2IMBXXXLQRRxtaAep5QXW
5yiOvoF49zuhZL8mig1Uvt2aT7t7+A==
=A9mb
-----END PGP SIGNATURE-----

--ULz/ZILk8N8rSVNQ--

