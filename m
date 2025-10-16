Return-Path: <linux-spi+bounces-10692-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62BBE3396
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 14:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CB9A6353A12
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 12:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866FD31D371;
	Thu, 16 Oct 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtNK6XZK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5733431B105;
	Thu, 16 Oct 2025 12:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760616305; cv=none; b=qP9irx+70jnLzj+X69DOpU6Qi6SLwVR7OQSPSZfzYQDXrrBei8mtAOP9Qhk71r6QnqDuZUfT/XRohtWmMYaaoiBwvWLqU2CxhSpwMFDB8yP5LU9OMFt9+9bbZasi0xIiwt9y21+/+Tw3l2nr45IslSAVSuDDG45D0ABB7ODYonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760616305; c=relaxed/simple;
	bh=s5MxHDjhVnMQw7538nov8Jo1+Up40NCVNBoxNeVwnxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANKCAio5SxJmFff85aRbeRMzldVxS4Y7OGk7bc9aOBSdekWnVE1hulvDjEHnyGC1xV5OgVdF/cdDFHId6m4aD3dgF+NzE+czvAIuROOy9f7Pi5gRM6qyWDxxv9BZcNk3xF4pT30VBt/jpb3vXI9psp5rw2uIbK94VFlfOo0RHWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtNK6XZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0ABC4CEF1;
	Thu, 16 Oct 2025 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760616305;
	bh=s5MxHDjhVnMQw7538nov8Jo1+Up40NCVNBoxNeVwnxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AtNK6XZKFQXhYFJZyvQq+UuuWYZXaylSiYtJyc179f8ve8nE3MJwSs/g4w/SBM4Ds
	 1eMtuIoHjTFSJYqeycd0nnqlXUEeor7/wf0J9W4TAJxFiaK8SAVNWo+fZ5eEMP/Tbu
	 0MCaqqCpGjWdTUVX3Swj2pXS2swBlRp9pV3ScZ8zJKABsWfV8wD0xlHg2/9Cpm6g4k
	 Nv/HVulNrtSV2ni7GIal+DU/7h4fkG3ohYvx7hMzNabKjyOB8Z1m9WSJVM+UAKs9oe
	 KudcBdci2+JRYNR5Eu7/ofq17A3uE3cUUJGmn6810eo4ZjxzNbqPRyhLznJRVwHV6w
	 NWLARMj9H1rHw==
Date: Thu, 16 Oct 2025 13:04:59 +0100
From: Mark Brown <broonie@kernel.org>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: Re: [PATCH v10 02/16] spi: airoha: remove unnecessary restriction
 length
Message-ID: <dbefe024-9b5c-4531-abb9-a1a7e9d3d769@sirena.org.uk>
References: <20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu>
 <20251012121707.2296160-3-mikhail.kshevetskiy@iopsys.eu>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q3tFlK1kDVpufwE1"
Content-Disposition: inline
In-Reply-To: <20251012121707.2296160-3-mikhail.kshevetskiy@iopsys.eu>
X-Cookie: Whoever dies with the most toys wins.


--q3tFlK1kDVpufwE1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 12, 2025 at 03:16:53PM +0300, Mikhail Kshevetskiy wrote:
> The "length < 160" restriction is not needed because airoha_snand_write_data()
> and airoha_snand_read_data() will properly handle data transfers above
> SPI_MAX_TRANSFER_SIZE.

Non-fix changes should be after fixes so there aren't any spurious
dependencies.

--q3tFlK1kDVpufwE1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmjw32oACgkQJNaLcl1U
h9Ax0wf9Fl356s/j6iNh98poXzDgSc/amMedVpD88bacOl/P3k3rHfVm3j1ZPo7k
SpoHlhWo9B+lVhKzicATIsbyurrxmp/vKaanHlb3GmYQ0kM77wBC4t0EmLa5p/Ec
KL4Z/D0vD6MtAAASPFO4Dr0b2A0qSn9rKqw44FyekhlE42iJVFCKQ21CudKTkOYG
47VRzbVV2GoR+6W+kijZG5XMFay/720b9whQiyOqwGlzAkdR+aAOv6yrNaXzFUpV
m/Sy7u/XiRcozPGXlQ6G87JRx06RTDpXQbjY6ieyWHopjSOROafd381vke5qZusN
mhowoJz3f1xAAkkobiuujUY9Zuk8RA==
=wYyS
-----END PGP SIGNATURE-----

--q3tFlK1kDVpufwE1--

