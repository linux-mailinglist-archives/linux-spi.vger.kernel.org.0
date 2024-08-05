Return-Path: <linux-spi+bounces-4139-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D294774B
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 10:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210931C20D2C
	for <lists+linux-spi@lfdr.de>; Mon,  5 Aug 2024 08:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FFD14D290;
	Mon,  5 Aug 2024 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="Xz4N6dp2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09214AD10;
	Mon,  5 Aug 2024 08:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722846478; cv=none; b=Cz9IJj7L5CE0zN+C4QeskB4X3OFin0kUhn6F3dYoNIkJzE7IFX/bgZLyiCAOhEncKK0OKeDPus9hNgLA+dmagxhJJyaUiXQOgK/23c94TY2T/r19Q8Fv1IyzctnxsSywp4/pEGuUnl4udPQFNAkD3b6yEaNxs5u7maowSPSSUfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722846478; c=relaxed/simple;
	bh=pUqwKBDJFkodBBhte7QAw25AFRcMVF0f8NkCBp7prpE=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=o3vmXXVam7COES3neoUT01DrmOG8RzcUQq5ePPX5M9blQ4dLCgiM2F0U/LsyCF5MG2SgXfX3tNUUkp9z38jAOwNK7BFGXUnNcIUyxdqhFXk1q03qQk4xrcF58tF64JyMoTg69j8FIgJo0uuVSPx7IPXveJNy+SWvUCcFUltJAWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=Xz4N6dp2; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 6B1195A;
	Mon,  5 Aug 2024 10:27:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1722846473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=pUqwKBDJFkodBBhte7QAw25AFRcMVF0f8NkCBp7prpE=;
	b=Xz4N6dp22hYF2AXHtRYSTPjo7ZjKOR+ESIUofL4d1NxVw0oMPU3BOhc0n8s+hU33iEsO+k
	BLD1Fcxt8SCRjaFQxpfxypFZ4gASu3qKdA6ikTcmt0k1CqBwJFyYkInCPZnPN5BqyQCGvx
	NND3r8V7X3eMSuM17N5LL0GoS4Y2Tk9lnHBtFlprvZnsfIOk7q4gn/hAJimCcxncUhoTj/
	5wDS23MkipfNsVS57qYI5Cm8JADUklV8hBieOqoh9J18KK1E2hDr7MaoX2YAq864N+m9Fa
	EMHm/jWo/5yA5M9JtsyzORdTdojQpt9yMktitFJ9WOq8a0smAQlAU5LAVRPIyA==
Content-Type: multipart/signed;
 boundary=03bf29cfa3430590a1d9727a08ddac11bdf5dff27a995675d5ac3297628b;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Mon, 05 Aug 2024 10:27:51 +0200
Message-Id: <D37U3QPX0J5J.21CTXMW2KC72G@walle.cc>
From: "Michael Walle" <michael@walle.cc>
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
 <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>, "Neal Frager"
 <neal.frager@amd.com>
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
X-Mailer: aerc 0.16.0
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org> <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org> <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com> <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org> <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org> <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com> <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com> <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc> <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com> <D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc> <9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com> <D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc> <c01d048f-ad8b-417e-8ff0-96f9252c87f2@amd.com>
In-Reply-To: <c01d048f-ad8b-417e-8ff0-96f9252c87f2@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

--03bf29cfa3430590a1d9727a08ddac11bdf5dff27a995675d5ac3297628b
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> >>> All I'm saying is that you shouldn't put burden on us (the SPI NOR
> >>> maintainers) for what seems to me at least as a niche. Thus I was
> >>> asking for performance numbers and users. Convince me that I'm
> >>> wrong and that is worth our time.
> >>
> >> No. It is not really just feature of our evaluation boards. Customers =
are using
> >> it. I was talking to one guy from field and he confirms me that these
> >> configurations are used by his multiple customers in real products.
> >=20
> > Which begs the question, do we really have to support every feature
> > in the core (I'd like to hear Tudors and Pratyush opinion here).
> > Honestly, this just looks like a concatenation of two QSPI
> > controllers.=20
>
> Based on my understanding for stacked yes. For parallel no.

See below.

> > Why didn't you just use a normal octal controller which
> > is a protocol also backed by the JEDEC standard.=20
>
> On newer SOC octal IP core is used.
> Amit please comment.
>
> > Is it any faster?
>
> Amit: please provide numbers.
>
> > Do you get more capacity? Does anyone really use large SPI-NOR
> > flashes? If so, why?
>
> You get twice more capacity based on that configuration. I can't answer t=
he=20
> second question because not working with field. But both of that configur=
ations=20
> are used by customers. Adding Neal if he wants to add something more to i=
t.
>
> > I mean you've put that controller on your SoC,
> > you must have some convincing arguments why a customer should use
> > it.
>
> I expect recommendation is to use single configuration but if you need bi=
gger=20
> space for your application the only way to extend it is to use stacked=20
> configuration with two the same flashes next to each other.
> If you want to have bigger size and also be faster answer is parallel=20
> configuration.

But who is using expensive NOR flash for bulk storage anyway? You're
only mentioning parallel mode. Also the performance numbers were
just about the parallel mode. What about stacked mode? Because
there's a chance that parallel mode works without modification of
the core (?).

> >>> The first round of patches were really invasive regarding the core
> >>> code. So if there is a clean layering approach which can be enabled
> >>> as a module and you are maintaining it I'm fine with that (even if
> >>> the core code needs some changes then like hooks or so, not sure).
> >>
> >> That discussion started with Miquel some years ago when he was trying =
to to
> >> solve description in DT which is merged for a while in the kernel.
> >=20
> > What's your point here? From what I can tell the DT binding is wrong
> > and needs to be reworked anyway.
>
> I am just saying that this is not any adhoc new feature but configuration=
 which=20
> has been already discussed and some steps made. If DT binding is wrong it=
 can be=20
> deprecated and use new one but for that it has be clear which way to go.

Well, AMD could have side stepped all this if they had just
integrated a normal OSPI flash controller, which would have the same
requirements regarding the pins (if not even less) and it would have
been *easy* to integrate it into the already available ecosystem.
That was what my initial question was about. Why did you choose two
QSPI ports instead of one OSPI port.

> >> And Amit is trying to figure it out which way to go.
> >> I don't want to predict where that code should be going or how it shou=
ld look
> >> like because don't have spi-nor experience. But I hope we finally move=
 forward
> >> on this topic to see the path how to upstream support for it.
> >=20
> > You still didn't answer my initial question. Will AMD support and
> > maintain that code? I was pushing you towards putting that code into
> > your own driver because then that's up to you what you are doing
> > there.
>
> Of course. We care about our code and about supporting our SOC and featur=
es=20
> which are related to it. It means yes, we will be regularly testing it an=
d=20
> taking care about it.

Great!

-michael

--03bf29cfa3430590a1d9727a08ddac11bdf5dff27a995675d5ac3297628b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZrCNBxEcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+D0yAX9v9JlDnbIpdOCS72W3tYefpyIMOMJFhLT8
3eqCeFJUFK2hxDoU8gmixkNu/Kl4MXYBgKfLynzYT52vb2f71/plUjcnZdBYV4FK
7K4sPzf8p4h0phil2a/eiFugkFWYhC5dEw==
=jcIk
-----END PGP SIGNATURE-----

--03bf29cfa3430590a1d9727a08ddac11bdf5dff27a995675d5ac3297628b--

