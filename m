Return-Path: <linux-spi+bounces-4112-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0669431BB
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 16:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E3282AEA
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B292D1B29B3;
	Wed, 31 Jul 2024 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="RheJVGsL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4371B14FF;
	Wed, 31 Jul 2024 14:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435098; cv=none; b=EFaN3B8mo0PoWeGm9pPnGTurRk3HfC4woKTEyfmj44okIWvqov0u6OKkl8pywJEUdAkUethaVO1GDnS8DaLvvTvCvmXRyLhN0DajXNVIiIfB6t7iROgIKmdUBtHrU+hqSaVRZegWxoJZujSiCQOaeonO3dF7FtZyjGnZrnp/d3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435098; c=relaxed/simple;
	bh=g0FCq4nnchDFfxh51t3tr65YF79O4pzb8rTXeXDOps0=;
	h=Content-Type:Date:Message-Id:To:Subject:Cc:From:References:
	 In-Reply-To; b=UHLxxPtG81mjKaTi59KRc7sZumG3J4kGS2AwIUKyUbyuqeZGzLScHzXh399AOBlFi4ANlAzCFWeayCHUuF+QfMK5EkEUR99H9tBnApdeT8V4avWoIZ88O4dkznFkX6MMIWQd2IltblzCbVYXqfcJvuj79/Gj7sU+IBTQkTMQGtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=RheJVGsL; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id E4BD2505D;
	Wed, 31 Jul 2024 16:11:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1722435067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=g0FCq4nnchDFfxh51t3tr65YF79O4pzb8rTXeXDOps0=;
	b=RheJVGsLyDe1VaZaZGyLz41KRqG0eQbpu4lcvjRkmhqYsQxVpnY6SHspc+AJsru6X0q+4H
	bFookNN2M2VflPjpAAD+KOxP9DSJKXFp+N5ii2OEzP5Mgf0JxBAhKMVXa+A/z9hdaMiFVU
	fIYwA/Yrhh0W5AFk+8q9MlwIDS81LaZkUIvk2pT5xihTXbtf6qz8ClP1SJsvpKShFVOdsd
	d9SijFRnSMSkdjPpL9ejDJsPMgkEgPbHP2qO4t795kQoPdBkT7deSy2NsBu4gEQc2GD+eq
	+UD6qx97Lzo8BKfKecddrJISdAvVIB3G0WsxUA5xQY7a7wjGLRtxXewwju3sqQ==
Content-Type: multipart/signed;
 boundary=96d5968b07d14bbafb7edd54105440eb618b58c0255484c32a5e40a9f01c;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 31 Jul 2024 16:11:05 +0200
Message-Id: <D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc>
To: "Michal Simek" <michal.simek@amd.com>, "Mahapatra, Amit Kumar"
 <amit.kumar-mahapatra@amd.com>, "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "broonie@kernel.org" <broonie@kernel.org>, "pratyush@kernel.org"
 <pratyush@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "sbinding@opensource.cirrus.com"
 <sbinding@opensource.cirrus.com>, "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>, "perex@perex.cz"
 <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
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
X-Mailer: aerc 0.16.0
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org> <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org> <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org> <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com> <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org> <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org> <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com> <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com> <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc> <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com> <D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc> <9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com>
In-Reply-To: <9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

--96d5968b07d14bbafb7edd54105440eb618b58c0255484c32a5e40a9f01c
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> > All I'm saying is that you shouldn't put burden on us (the SPI NOR
> > maintainers) for what seems to me at least as a niche. Thus I was
> > asking for performance numbers and users. Convince me that I'm
> > wrong and that is worth our time.
>
> No. It is not really just feature of our evaluation boards. Customers are=
 using=20
> it. I was talking to one guy from field and he confirms me that these=20
> configurations are used by his multiple customers in real products.

Which begs the question, do we really have to support every feature
in the core (I'd like to hear Tudors and Pratyush opinion here).
Honestly, this just looks like a concatenation of two QSPI
controllers. Why didn't you just use a normal octal controller which
is a protocol also backed by the JEDEC standard. Is it any faster?
Do you get more capacity? Does anyone really use large SPI-NOR
flashes? If so, why? I mean you've put that controller on your SoC,
you must have some convincing arguments why a customer should use
it.

> > The first round of patches were really invasive regarding the core
> > code. So if there is a clean layering approach which can be enabled
> > as a module and you are maintaining it I'm fine with that (even if
> > the core code needs some changes then like hooks or so, not sure).
>
> That discussion started with Miquel some years ago when he was trying to =
to=20
> solve description in DT which is merged for a while in the kernel.

What's your point here? From what I can tell the DT binding is wrong
and needs to be reworked anyway.

> And Amit is trying to figure it out which way to go.
> I don't want to predict where that code should be going or how it should =
look=20
> like because don't have spi-nor experience. But I hope we finally move fo=
rward=20
> on this topic to see the path how to upstream support for it.

You still didn't answer my initial question. Will AMD support and
maintain that code? I was pushing you towards putting that code into
your own driver because then that's up to you what you are doing
there.

So how do we move forward? I'd like to see as little as core changes
possible to get your dual flash setup working. I'm fine with having a
layer in spi-nor/ (not sure that's how it will work with mtdcat
which looks like it's similar as your stacked flash) as long as it
can be a module (selected by the driver).

-michael

--96d5968b07d14bbafb7edd54105440eb618b58c0255484c32a5e40a9f01c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZqpF+REcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+L4FAYD66zueUFU1636OvgoGDTll3VhlpfWvCNks
ygBkg8btX0/kDdus+Zs1Lz63qoncGBIBfjSOIExt4q/UijTQMIfXmQjnzxUHEsUH
/aUgW/mzMqFLKqdncy63f8sPZX5ZY3vmAA==
=2i8/
-----END PGP SIGNATURE-----

--96d5968b07d14bbafb7edd54105440eb618b58c0255484c32a5e40a9f01c--

