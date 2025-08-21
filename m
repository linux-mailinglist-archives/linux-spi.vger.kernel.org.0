Return-Path: <linux-spi+bounces-9576-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEE1B2EEB0
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 08:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83FCE1893DF2
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 06:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1189A2DC345;
	Thu, 21 Aug 2025 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gnz7iZd/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BA327B33F;
	Thu, 21 Aug 2025 06:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755758966; cv=none; b=hyxbVHAGgfecLFVF9QkpWeux6DqwPgrxBVD0XdyL8IafGsXh8VdZK0j15PXUX8+9o1fpzybFHqK9+QOKt/uaioA5v64E6RlhTa9W9xRwrP0vxH18ebMYjlxfRu/Elt2tI7CBJb7t/nT6gtTuMyMqbupstTlqmXSeetDHNS6fk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755758966; c=relaxed/simple;
	bh=+dDruC6iw3EJwORfpY8MHfyohIHz8lNWLx1YR5ATtrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cz9DxYeEydwKXzOQYAb2ayY4g/myCRnn29lZZaUEDOmPRq2HaeODswby8ZN6VNjoAQsQyvBQYQ6cmQg3RFKWhI8cU641Z/Dn1qQysah19rbllqSdk+HGOUA7t8p3j0PivYwYYesh0bFrXdJQdEwHLpy3pU42Uuhn+e3hts9uULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gnz7iZd/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57B0C4CEED;
	Thu, 21 Aug 2025 06:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755758966;
	bh=+dDruC6iw3EJwORfpY8MHfyohIHz8lNWLx1YR5ATtrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gnz7iZd/BdECzBP5MOTF9P/jh0Oi3LHdU3YrbPKWmAylyObxiuwvHv8NJi6M18NMa
	 /iD93nWQZV4BBt47V3bsFUKncJuTQlkOdZx8JhvIonYEV1i0LWg5+rT6kcsm8G3DaC
	 7YeXIPbhBMCyfPTSovYxY1/vk8medqxI6Ya/HQIxUJ6mPKE9zVdmGEkgi49CGV38MZ
	 PszApBGc88nJXjTXgeAAc0CV6C7G3bo85VjTC4Ii66fhfS9fR5iMql0EC5wHJiwTFQ
	 UT4oHtIaZNifYwUzzuNQkc7Nvfxsk1PpdEV4eOwVdxGE5EaslH3fosSKGbV9bAEvS9
	 MNQAEvAr61Tpw==
Date: Thu, 21 Aug 2025 08:49:22 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Mark Brown <broonie@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, Ray Liu <ray.liu@airoha.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for
 continuous mode dirmap creation cases
Message-ID: <aKbBclHYmjI_H3jq@lore-rh-laptop>
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
 <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
 <78542bbe-1def-4aca-8424-cc26542d9762@sirena.org.uk>
 <e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu>
 <a18185a0-407c-4a1c-b915-fec9b3283b87@kontron.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fQ/mndwu5rqbmfjT"
Content-Disposition: inline
In-Reply-To: <a18185a0-407c-4a1c-b915-fec9b3283b87@kontron.de>


--fQ/mndwu5rqbmfjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Am 14.08.25 um 17:33 schrieb Mikhail Kshevetskiy:
> >=20
> > On 14.08.2025 18:29, Mark Brown wrote:
> >> On Thu, Aug 14, 2025 at 09:54:23AM +0300, Mikhail Kshevetskiy wrote:
> >>> This driver can accelerate single page operations only, thus
> >>> continuous reading mode should not be used.
> >>>
> >>> Continuous reading will use sizes up to the size of one erase block.
> >>> This size is much larger than the size of single flash page. Use this
> >>> difference to identify continuous reading and return an error.
> >> This seems like it just applies anyway regardless of the rest of the
> >> series?
> >=20
> > Could you provide a link? I do not see this in upstream linux repo.
>=20
> Mark asked if this could be applied without the other patches of this
> series through his SPI tree and I think that is indeed correct. The
> other patches are still being reviewed and applied via the MTD tree.

Can you please add the following Fixes tag?

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")

Regards,
Lorenzo

--fQ/mndwu5rqbmfjT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaKbBbwAKCRA6cBh0uS2t
rK9SAP4/fA0AATBO9QcF9hsrFQCmlkwxxrHcvQqs0F8yCLHidgD+M3A/bqxivvA8
dgQx6GY/EeGvfXJ4S0LIK2YiItbX7gk=
=6qIu
-----END PGP SIGNATURE-----

--fQ/mndwu5rqbmfjT--

