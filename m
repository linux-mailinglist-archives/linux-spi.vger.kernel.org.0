Return-Path: <linux-spi+bounces-4110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1494942A3E
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 11:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10271C24423
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 09:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6528C1AD3F5;
	Wed, 31 Jul 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="GF+4IjxB"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1271AC436;
	Wed, 31 Jul 2024 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417554; cv=none; b=BGbU7DYI7V2fTxdwfcmZtHqp5caKGIwVgB9gaxu/VBqXuSfATCvbeDzXUqNLDTTIns0Ngdw7tT/AE+tVnKbT9pzqNHTekhtXBBlxYLr2YOZx4ygl9BSZs3jY0AWqRQ/pD0Ia23E9LJZaZTEk37g4XAgHJSvnmD9N0yBPeAFJbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417554; c=relaxed/simple;
	bh=HprpdnPTmMpjlLpYTx/G5QGJKkhmU8L+PeKIYH3jtBs=;
	h=Content-Type:Date:Message-Id:From:To:Subject:Cc:References:
	 In-Reply-To; b=jECQ5K8L45Y8yBVGgdxU6Sg6NJWiUjQQRsgT0XTAgpqYv5wgtxkb9LFPl8GOvYe16WEEDequs8nKKYK1NiGo0DZcm/R1v14bZWvsq28M0n3YBm9WWhQGUQRA6IupAabyfodLHO4J18/IvaoJiPfT4FsbavCHTih+8RPDwuM6sUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=GF+4IjxB; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 254664090;
	Wed, 31 Jul 2024 11:19:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1722417543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=HprpdnPTmMpjlLpYTx/G5QGJKkhmU8L+PeKIYH3jtBs=;
	b=GF+4IjxB2TIt42gTk4Pq7iBvhsew8XFF/tg3hs4xxBp2l4el+lQQsXPhZvZFqqB+B/yaW6
	pzeQ2eS8abDXh6pdv1yxwcvJORltW5gNWTIW0M24ZEJ7ykvuKYGpIuVnXI7NGUsssc7EbO
	zsO0EbswGGZ3xx8mYRyGCm+PvftxCaOhhWWI18zvToFcWjLI3dI8n0hmd6FN0UblTS4N3g
	4KjFaPK/srzD4zY+qjD0495XF/PXdGoT4ddnA/+P/Ur9npBDCLkIoX8f6Yg1ZcNXm0ks7m
	tSJ6zIh9C1UpyhD0IJCKiR+s+z5RScfmnR3LiHAR8TWRFiVWsf33B8zZU3w3mA==
Content-Type: multipart/signed;
 boundary=ca39702cffd96d931aee706a09ce1aa2ba1611296eda65bd78f72e98793e;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 31 Jul 2024 11:19:01 +0200
Message-Id: <D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc>
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
X-Mailer: aerc 0.16.0
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com> <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org> <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org> <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org> <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org> <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com> <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org> <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org> <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com> <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com> <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc> <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com>
In-Reply-To: <e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

--ca39702cffd96d931aee706a09ce1aa2ba1611296eda65bd78f72e98793e
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Michal,

> >> Based on the inputs/suggestions from Tudor, i am planning to add a new
> >> layer between the SPI-NOR and MTD layers to support stacked and parall=
el
> >> configurations. This new layer will be part of the spi-nor and located=
 in
> >> mtd/spi-nor/
> >=20
> > Will AMD submit to maintain this layer? What happens if the
> > maintainer will leave AMD? TBH, personally, I don't like to
> > maintain such a niche feature.
> > I'd really like to see some use cases and performance reports for
> > this, like actual boards (and no evaluation boards don't count). Why
> > wouldn't someone just use an octal flash?
>
> AMD/Xilinx is not creating products that's why we don't have data on actu=
al=20
> boards but I don't really understand why evaluation boards don't count.

Because on an eval board the vendor just puts everything possible on
the board.

> A lot of=20
> customers are taking schematics from us and removing parts which they don=
't need=20
> and add their custom part.
>
> But one product for parallel configuration which is publicly saying that =
it is=20
> using it is for example this SOM.
> https://shop.trenz-electronic.de/en/TE0820-05-2AI21MA-MPSoC-Module-with-A=
MD-Zynq-UltraScale-ZU2CG-1I-2-GByte-DDR4-SDRAM-4-x-5-cm
>
> I am not marketing guy to tell if there is any other which publicly sayin=
g we=20
> are using this feature but we can only develop/support/maintain support f=
or=20
> these configurations on our evaluation boards because that's what we have=
 access=20
> to and what we know how it is done.
>
> Also performance numbers from us can be only provided against our evaluat=
ion boards.

Which is good enough.

All I'm saying is that you shouldn't put burden on us (the SPI NOR
maintainers) for what seems to me at least as a niche. Thus I was
asking for performance numbers and users. Convince me that I'm
wrong and that is worth our time.

The first round of patches were really invasive regarding the core
code. So if there is a clean layering approach which can be enabled
as a module and you are maintaining it I'm fine with that (even if
the core code needs some changes then like hooks or so, not sure).

-michael

--ca39702cffd96d931aee706a09ce1aa2ba1611296eda65bd78f72e98793e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZqoBhREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+FjVAYC5j+67h/KcneaPcQzec/oCTc8m829x/Zf8
EK35rLhdUySt8hQX8KGtzw5kcHwOdKEBgPjKd9pncip/3XoPQTsDQcLTz0R/NsXm
914ogzDCj82ep11eIYUq1UjdDpsyJWJMFA==
=QrXm
-----END PGP SIGNATURE-----

--ca39702cffd96d931aee706a09ce1aa2ba1611296eda65bd78f72e98793e--

