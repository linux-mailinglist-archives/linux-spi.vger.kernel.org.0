Return-Path: <linux-spi+bounces-7518-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCF9A84192
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 13:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D204C3B94
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 11:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DA3210F53;
	Thu, 10 Apr 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDJ/YYu1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DEF1DDC0F;
	Thu, 10 Apr 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744283951; cv=none; b=q9BFfgo+MBPqv6hMflawqBFcyTt0+cBRuMMX3z1T63/VFnnNN9GZNWflOUS/cQCSr+Wohj+9AOFD8OLa1h/37aWJ50GDMquBBrBzrlJu2h/fZcMPbg2yTVnroreuw0R94YgT60J53U4zhtmlsUGuSIwhtOmcRhicKEsqk+90zgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744283951; c=relaxed/simple;
	bh=gAFvWpcAGBkegBSikm87MrNHJtZam8cHZvJScZa1YO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mukuBIonDJVSDJBU/4zpCM+/dEhXL1sdKSBvn66AOvzucdZA0onWeuLPlKg1pr21uEL6RcfilRWyNy6djl9wJaAsS46gosU8D8VxVr2lH3jdnvBBOQ4oee5IjaEfdDPbb1Rc7bRmtC11BCJWL24rjrLj5lGYPGKb1YVen5hJBdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDJ/YYu1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5194AC4CEE3;
	Thu, 10 Apr 2025 11:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744283951;
	bh=gAFvWpcAGBkegBSikm87MrNHJtZam8cHZvJScZa1YO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nDJ/YYu1BZTH/wCI43Y6qFG2VpBm778RH4Ahe5Lc/hjvbh1mPHOR+bvIjtIPJjYgJ
	 v76zeBUcAzeaobXpwpPB7F7N0ALkeKNOaFnrhpk6sh66f9Qq5EB3MlOqdwPKagcXVR
	 qESJGDXIsbKlwIZEcvsjR9TJHMy91PyntBiKbuwosnfvlBOiCpyaX6CEbo+QYYZdQo
	 989+V2m7iEwdmFqFModMA/SB7YnDKCkRP0j3+pIwbbXK833s0X/Mj41iX3O1OhOXiw
	 EGkOzcjwYaS1KffEtbBp/kiovBdomvAga1HaEZ7a6AukOUsLLIF4iCovZVhtRDb3i8
	 Ly1tWWkexHEjQ==
Date: Thu, 10 Apr 2025 12:19:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	manivannan.sadhasivam@linaro.org, absahu@codeaurora.org,
	bbrezillon@kernel.org, architt@codeaurora.org,
	quic_srichara@quicinc.com, linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mtd: rawnand: qcom: Pass 18 bit offset from NANDc
 base to BAM base
Message-ID: <79349446-2e87-4f3a-9644-9262a4ccb12a@sirena.org.uk>
References: <20250410100019.2872271-1-quic_mdalam@quicinc.com>
 <20250410100019.2872271-2-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BHGlqQ/YgKipM5ku"
Content-Disposition: inline
In-Reply-To: <20250410100019.2872271-2-quic_mdalam@quicinc.com>
X-Cookie: You will be awarded some great honor.


--BHGlqQ/YgKipM5ku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 10, 2025 at 03:30:17PM +0530, Md Sadre Alam wrote:
> The BAM command descriptor provides only 18 bits to specify the NAND
> register offset. Additionally, in the BAM command descriptor, the NAND
> register offset is supposed to be specified as "(NANDc base - BAM base)
> + reg_off". Since, the BAM controller expecting the value in the form of
> "NANDc base - BAM base", so that added a new field 'bam_offset' in the NAND
> properties structure and use it while preparing the command descriptor.

Acked-by: Mark Brown <broonie@kernel.org>

--BHGlqQ/YgKipM5ku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmf3qSgACgkQJNaLcl1U
h9A8LQf/Qdes70/Rw94WVFtMtWkzp5YAtG82yLUA5LOSLIt8DTuvKh/B7Q216lDc
DeHth7xNLhU0NKwpmVt0ESrPHrcLcMYMdq59924cs3EY5/HN4hk7YStIIX3OJxVM
qcLdtHyiWGvQBAKptqbjM997MTKHzNMtPSb0ZZWNXjLe/x/rizeTgOQ7loGdgxFv
bpDvk3Fy4TDZmBQ6ZcolMTFBV+B0S8ZIjv8bDbaN/hbbsuoayf1erKpP0tSW9Wvm
Ag+/0fS0Lp/aD4ZaRPMLNH9e5ZtgFfDWSSAf88NypR3se0QgelmM9Vi45JEdK0ML
fiTlbY3OQXlRIFO/WkjvS4GBx2t2sA==
=JRjg
-----END PGP SIGNATURE-----

--BHGlqQ/YgKipM5ku--

