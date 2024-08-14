Return-Path: <linux-spi+bounces-4189-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C91951DCD
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E325BB2B6FD
	for <lists+linux-spi@lfdr.de>; Wed, 14 Aug 2024 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575081B32D3;
	Wed, 14 Aug 2024 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a/65HTTM"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D6B1AE872;
	Wed, 14 Aug 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723646809; cv=none; b=gIcD3EGYD1GKr/APBSzZWjz8zF1vSqzxiZE0XH6NNARFwDo/paUEF4PhrrxBAr6wG0/x4F1fcKUIA8aOBKESgBQ6tuCzpjEl7eGjx415f7AqF3drXM1GxNxCDuF587U3SQxaV0l0qLEVajykKCN4Briqf8j9zNR4fwwg8g3R7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723646809; c=relaxed/simple;
	bh=MrMdfHFc7DN4P8cobS1SgsWZXFCwinhPD2p8GEm5rxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCNFhYqA9mUies7SbhDzytwu73qOkzpdWjrYelNwQVZRURNezN3xFVL5bm0nCt5n9OmG5YeULHrIB1BZPtUowuPw2xaLSNRmXvGRMW/zBe7rniwjRwuYyRTVOtBnjFkhyw5RyP9gQBHPHEW6pulpyDO8XEWj4WfhrpvZAAMytdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a/65HTTM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 620DA240005;
	Wed, 14 Aug 2024 14:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723646805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDfSsuNrPtx6YX5pobWJTyhNVK0h9n02y4gpLyd5QZ0=;
	b=a/65HTTM/Z2uuPVwZKhtoPVKYKAssPIOGi1yJ87QWyxc0Yy9B/HO9r53TlM7SKb4aDZ+/Q
	W6rJ9e2mF+xR+Jl744Ovws0z1I5cdIq31Vv1pwpD9wLK7HEBFJIpuIWK6Vaq7l0IYBIqV7
	4b3HVhC09ke19XLLWgBT/5VwLBJ8J7Oset9eu1j5nL89W/N3sK6iHbvqDSK38O0Ezl39Bi
	OFCgH/+vOzdJFjrKLhZCp7ZfV0xiV4MPwJkRjCHxESDQtvz8wbMP5qBNdtgqN719/o5xpQ
	eg3SAKUv5Kfqp+R+i9NkVYRsaGc0wZCqzTMUSS2knl3fnKuXGO3BFN+Hl++fEQ==
Date: Wed, 14 Aug 2024 16:46:42 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, "broonie@kernel.org"
 <broonie@kernel.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
 <james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
 <david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
 <rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
 "tiwai@suse.com" <tiwai@suse.com>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "michael@walle.cc" <michael@walle.cc>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>, "Simek, Michal"
 <michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
 <patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
 <linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, Conor Dooley
 <conor.dooley@microchip.com>, "beanhuo@micron.com" <beanhuo@micron.com>
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Message-ID: <20240814164642.24705f18@xps-13>
In-Reply-To: <IA0PR12MB7699670B7EE37C60C672FC5EDC872@IA0PR12MB7699.namprd12.prod.outlook.com>
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
	<20240812103812.72763f69@xps-13>
	<IA0PR12MB769997D5958C191215254983DC872@IA0PR12MB7699.namprd12.prod.outlook.com>
	<20240814104623.72eef495@xps-13>
	<IA0PR12MB7699670B7EE37C60C672FC5EDC872@IA0PR12MB7699.namprd12.prod.outlook.com>
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

Hi Amit,

> > > > > For implementing this the current DT binding need to be updated as
> > > > > follows. =20
> > > >
> > > > So you want to go back to step 1 and redefine bindings? Is that wor=
th? =20
> > >
> > > The current bindings are effective if we only support identical flash
> > > devices or flashes of the same make but with different sizes connected
> > > in stacked mode. However, if we want to extend stacked support to
> > > include flashes of different makes in stacked mode, =20
> >=20
> > The only actual feature the stacked mode brings is the ability to consi=
der two
> > devices like one. This is abstracted by hardware, this is a controller =
capability. =20
>=20
> Stacked mode is a software abstraction rather than a controller feature o=
r=20
> capability. At any given time, the controller communicates with one of th=
e=20
> two connected flash devices, as determined by the requested address and d=
ata=20
> length. If an operation starts on one flash and ends on the other, the co=
re=20
> needs to split it into two separate operations and adjust the data length=
=20
> accordingly.

I'm sorry, that was not my understanding, cf the initial RFC:

	Subject: [RFC PATCH 0/3] Dual stacked/parallel memories bindings
	Date: Fri, 12 Nov 2021 16:24:08 +0100

	"[...] supporting specific SPI controller modes like Xilinx's
	where the controller can highly abstract the hardware and
	provide access to a single bigger device instead [...]"

Furthermore, I rapidly checked the Zynq7000 TRM, it suggests that the
controller is capable of addressing the right memory itself based on
the address, especially in linear mode?=20

	https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Dual-SS-4-bit-Stacked=
-I/O

	"The lower SPI flash memory should always be connected if the
	linear Quad-SPI memory subsystem is used, and the upper flash
	memory is optional. Total address space is 32 MB with a 25-bit
	address. In IO mode, the MSB of the address is defined by
	U_PAGE which is located at bit 28 of register 0xA0 . In Linear
	address mode, AXI address bit 24 determines the upper or lower
	memory page. All of the commands will be executed by the device
	selected by U_PAGE in I/O mode and address bit 24 in linear
	mode."

Anyway, you may decide to go down the "pure software" route, which is
probably easier from an implementation perspective, but means you're
gonna have to argue -again- in favor of the representation of a purely
virtual device that is not hardware.

Cheers,
Miqu=C3=A8l

