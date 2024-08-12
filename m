Return-Path: <linux-spi+bounces-4168-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B434994E7EF
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 09:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41FF1C217A2
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99A2158203;
	Mon, 12 Aug 2024 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="AkzbjScU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9001474D3;
	Mon, 12 Aug 2024 07:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448240; cv=none; b=UCcNbki0S4hK7d/ypQAX9tIOvKOoQ0fcqh5+qdc7paCqzkTk19Vk2q1f2lYCLtfyaehUBTV7W5Zkqf2AmotujmMiV68TCbAZfnNaYSh4yzHfp9fvGA5YNJS14q+l+PybVISMHHDQEoSvOrIfhJzQwchgwLYPgDBfYe6d0rrLywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448240; c=relaxed/simple;
	bh=Ht+N+M8B+B3kbQk5vj/Y5jdskCwHjTQjDHS8S8jMFoE=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=NH1oGyYGgCnoSGVTGhx2LtW7+FeIM4wdapPuYzmHqr7ihZ5yRpFcZocKeR8/7xAT4Fj2Fq07a5MPUSp/90ZN1olyS4IvWZp7qZSfEZp+ZwhC559HRriXl+T8OuNPpq0XXhBvHaFtQKXoP8yLhM/OW3Oo9Nrr1/B9AT3j156UoiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=AkzbjScU; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id C68914E1;
	Mon, 12 Aug 2024 09:37:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1723448229;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=Ht+N+M8B+B3kbQk5vj/Y5jdskCwHjTQjDHS8S8jMFoE=;
	b=AkzbjScU1M0U22mz4vNqG+wEZuZA/HnOzvtfYOhqtm+aoBv8UcPR5i8Jjo9f4pPNKLISN0
	cbD/rIQPlx3RlRIVHYJPIb02JPYmMWQmip92i8MaTaaXCDmDXPsUjZjh/sAUpkTjxZbMWP
	dbKftvKLPZ8qdGcu9TVUsqn/S3RCgj8nuMkWSLZhmQovHprJSJGJ9ciWKFEloMRldQ9O77
	f4JOQH5CB9/FvQm0DReuPOvHMF+bhOlVkuaZN1khj45m+vSoKgHe/Xo711WEHOQkuYw2oe
	y68AVBZ20jkEO8vgEMngqkWF5V1UAlfFo445YUFCNDdls+i1+3OO0Di5nMo93g==
Content-Type: multipart/signed;
 boundary=223c054a831d10cf82c25ffa0250f24ef7d81ccf0ed949c366b87bf81bfa;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 12 Aug 2024 09:37:06 +0200
Message-Id: <D3DREP874QG7.2UOSZSBI3BRQY@walle.cc>
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Cc: "Michal Simek" <michal.simek@amd.com>, "Mahapatra, Amit Kumar"
 <amit.kumar-mahapatra@amd.com>, "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "pratyush@kernel.org"
 <pratyush@kernel.org>, "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "sbinding@opensource.cirrus.com"
 <sbinding@opensource.cirrus.com>, "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>, "perex@perex.cz"
 <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
 <patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
 <linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "beanhuo@micron.com" <beanhuo@micron.com>
From: "Michael Walle" <michael@walle.cc>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
X-Mailer: aerc 0.16.0
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org> <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org> <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com> <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org> <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org> <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com> <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com> <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc> <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com> <D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc> <9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com> <D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc> <20240812092937.2bd5c85a@xps-13>
In-Reply-To: <20240812092937.2bd5c85a@xps-13>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

--223c054a831d10cf82c25ffa0250f24ef7d81ccf0ed949c366b87bf81bfa
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> > > > The first round of patches were really invasive regarding the core
> > > > code. So if there is a clean layering approach which can be enabled
> > > > as a module and you are maintaining it I'm fine with that (even if
> > > > the core code needs some changes then like hooks or so, not sure). =
=20
> > >
> > > That discussion started with Miquel some years ago when he was trying=
 to to=20
> > > solve description in DT which is merged for a while in the kernel. =
=20
> >=20
> > What's your point here? From what I can tell the DT binding is wrong
> > and needs to be reworked anyway.
>
> I'm sorry I'm now catching up, can you point at the thread explaining
> what is wrong in the bindings? I didn't find where this was detailed. Or
> otherwise summarize quickly what needs to change?

Somewhere in this mega thread Tudor had some remarks about the
bindings. Amit also mentioned it here:

https://lore.kernel.org/r/IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7=
699.namprd12.prod.outlook.com/

-michael

--223c054a831d10cf82c25ffa0250f24ef7d81ccf0ed949c366b87bf81bfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZrm7oxEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+PctAYCbuUNxmdpx/X9rB1exzej6BdgcJkd3X4VZ
PwvBiJJJwfBXsF9QanNEeTL8VZQbzQUBgLkzbud/s0TfQrzHuMn9pAovYMF4/C2l
/lZ51bqyfaZad2v94+7DWWCbHWBW5f/7Yg==
=hWwd
-----END PGP SIGNATURE-----

--223c054a831d10cf82c25ffa0250f24ef7d81ccf0ed949c366b87bf81bfa--

