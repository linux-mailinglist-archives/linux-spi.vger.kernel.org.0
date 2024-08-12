Return-Path: <linux-spi+bounces-4167-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8F094E7C8
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 09:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8146283D8F
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A470E157467;
	Mon, 12 Aug 2024 07:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WEDU8dF6"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6C15098A;
	Mon, 12 Aug 2024 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447791; cv=none; b=oMSQ4ikgcz+flHoqtFg557VbRP7OgT0H9lX09O7/FeXxiqS0A4lwbCbBMe5Zf4prfwGx4wSAD4ec4xCNzmiu+PvY70PH6IqHqD5ldbURnOHbb96vs/yGA1HJ2yFVNen4WkS+/Li6IkzteqMDIJse3oArT02HelOJIh+H49e29WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447791; c=relaxed/simple;
	bh=Oafu0WWZyssl+BW+Fc+4njgLE2C72ugrKSjldnyJ7kY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DpNNucsU750x+ybYr7QpRxfntsluRPZ+HO/RhhSHYRLEk50CR5/pgFKapZcD7zw8lZSvWn3AyeqZWCfjKVRnDkQ7yIJYSaEFojDj8sb1GYh3C7f/V0WVqMyIbC/rxy/UCG1ipGjBwP7AXmK/WSx+sazOdh3mJsG3UvF9Lo5APiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WEDU8dF6; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B0A1D240003;
	Mon, 12 Aug 2024 07:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723447780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Oafu0WWZyssl+BW+Fc+4njgLE2C72ugrKSjldnyJ7kY=;
	b=WEDU8dF6RenmlSwiIq9vVp2pzFbsWxnkYCVxQLUKOYDBbFEFoQGMFFmc91lP0KUuHn4IDj
	8XZTuv2pMuqtdRDxi7wQ1OWVe02fI7Y2og656C23HlxDJpBXvxbubDNKYrIyi9lKoFZM4J
	9RoNxQ3bQlACBJEdCZvWEAkE6JfvLHRprKtow+JhVL/pMnA7NHqpl5er3BUf67rPBZ8yHy
	ovTZBKJ5F7SOsq66sVHnBsc0WF2noadJJSxD5+u2nNQJWt74CI6PLVOsvEzLiFzGsjZ7i5
	PILpt3F8Ui7nDkyVYvKrltfc3/+wgSa7Rt9w8NklTYmY+iSd5tZ2352tYgL7mw==
Date: Mon, 12 Aug 2024 09:29:37 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Michael Walle" <michael@walle.cc>
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
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Message-ID: <20240812092937.2bd5c85a@xps-13>
In-Reply-To: <D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
	<b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
	<BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
	<e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
	<BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
	<576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
	<BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
	<c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
	<9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
	<BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com>
	<IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
	<D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc>
	<e1587f61-f765-4a22-b06e-71387cc49c4d@amd.com>
	<D33M26RLVLHF.3Q5YARPBNSBOY@walle.cc>
	<9fb60743-3e89-49fa-a399-3cf2607a7e41@amd.com>
	<D33S9T73M6ND.G7CCJ4PDVYQU@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Michael,

> > > The first round of patches were really invasive regarding the core
> > > code. So if there is a clean layering approach which can be enabled
> > > as a module and you are maintaining it I'm fine with that (even if
> > > the core code needs some changes then like hooks or so, not sure). =20
> >
> > That discussion started with Miquel some years ago when he was trying t=
o to=20
> > solve description in DT which is merged for a while in the kernel. =20
>=20
> What's your point here? From what I can tell the DT binding is wrong
> and needs to be reworked anyway.

I'm sorry I'm now catching up, can you point at the thread explaining
what is wrong in the bindings? I didn't find where this was detailed. Or
otherwise summarize quickly what needs to change?

Thanks!
Miqu=C3=A8l

