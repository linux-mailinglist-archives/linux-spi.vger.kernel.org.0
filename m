Return-Path: <linux-spi+bounces-4169-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F094E8BA
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 10:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B85282A4F
	for <lists+linux-spi@lfdr.de>; Mon, 12 Aug 2024 08:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227BB16B38E;
	Mon, 12 Aug 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c6AlCNyi"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64B14D599;
	Mon, 12 Aug 2024 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723451907; cv=none; b=q1gC9jiJdQ7RlyWf7lLW7nHtJa9SDjbgr6ReT/dP6GbcNhOC2VU0jocRqmBhGql+BJ9ej+ZHY7wpn9MhxRKjarOlTkTSCSALssXEUvw3MP/tjsFaH3ifI5QZ9bW1omM8v27PmtapV5ApFo23Gn0ITuLFF1QzbRDnTSBJCAjp1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723451907; c=relaxed/simple;
	bh=C39qRErPUQkJNzW9w7SV07Iow5wNuuOXfmuMigKGNYA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i39c7jR62SLQe+da6HP8AXqhpnhHi2F+IFNFlPsyejk8y4IMEu5JqtMfzQhZIGEQKKyayPQmD7xNyhZmtw5m2qLuZPg0V7hpYXHnXVrrePVHQO86IisZYLt4dI2uL5u3F5612R+G1Xzz2DETleberqjvpMBKlrFnLOLuGTx/mEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c6AlCNyi; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9CA3DC0007;
	Mon, 12 Aug 2024 08:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1723451896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpp+yPNEBFJMfjQq3cL+mUf+1IBUOb95UB4rmwmrlsY=;
	b=c6AlCNyiO8HVav7lY582H4/RuX+O01sHF3FNBasOHB+VazJm8ydFO5xcwvZJ6d0jkuT1+i
	Sv6Jmq7TiB6stzxv6fHQQa+YoLJwE6CB0pLKjHXsxJutvIaUi3XWsYO0U/WLuaOQKhRMaj
	oYCvTZD9GQ24ua+nUP3gCpF3C6okHJvfQouuv+Um04e3FbRgfLwABTZb1Gz3Bv7n8iXw03
	x9Asn7ip/Md3h2Z5s2eWCP8HOY68mRsa/1Af21B9Pn6tV6LjyvoVyXtr2k+qyIVZjDyrqX
	hZ95LcD6Gu/o+tPGUr5jmWRM7yJB3Z7WuAv3A3Gh79rQQk5Q9dDD2WZqwYr7Vg==
Date: Mon, 12 Aug 2024 10:38:12 +0200
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
Message-ID: <20240812103812.72763f69@xps-13>
In-Reply-To: <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
	<BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
	<c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
	<BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
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

Hi,

> Hello Everyone,
>=20
> I would like to propose another approach for handling stacked and=20
> parallel connection modes and would appreciate your thoughts on it.=20
> But before that, here is some background on what we are trying to achieve.
>=20
> The AMD QSPI controller supports two advanced connection modes(Stacked an=
d=20
> Dual Parallel) which allow the controller to treat two different flashes=
=20
> as one storage.
>=20
> Stacked:
> Flashes share the same SPI bus, but different CS line, controller asserts=
=20
> the CS of the flash to which it needs to communicate.
>=20
> Dual Parallel:
> Both the flashes have their separate SPI bus CS of both the flashes will=
=20
> be asserted/de-asserted at the same time. In this mode data will be split=
=20
> across both the flashes by enabling the STRIPE setting in the controller.=
=20
> If STRIPE is not enabled, then same data will be sent to both the devices.
>=20
> For more information on the modes please feel free to go through the=20
> controller flash interface below
> https://docs.amd.com/r/en-US/am011-versal-acap-trm/QSPI-Flash-Device-Inte=
rface
>=20
> Mirochip QSPI controller also supports "Dual Parallel 8-bit IO mode", but=
=20
> they call it "Twin Quad Mode".
> https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductD=
ocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf
>=20
> DT binding changes were added through the following commits:
> https://github.com/torvalds/linux/commit/f89504300e94524d5d5846ff8b728592=
ac72cec4
> https://github.com/torvalds/linux/commit/eba5368503b4291db7819512600fa014=
ea17c5a8
> https://github.com/torvalds/linux/commit/e2edd1b64f1c79e8abda365149ed62a2=
a9a494b4
>=20
> SPI core changes were adds through the following commit:
> https://github.com/torvalds/linux/commit/4d8ff6b0991d5e86b17b235fc46ec62e=
9195cb9b
>=20
> Based on the inputs/suggestions from Tudor, i am planning to add a new=20
> layer between the SPI-NOR and MTD layers to support stacked and parallel=
=20
> configurations. This new layer will be part of the spi-nor and located in=
=20
> mtd/spi-nor/

For now I don't think you need a totally generic implementation. As
long as there is only one controller supporting these modes, I'd say
this is not super relevant.

> This layer would perform the following tasks:
>  - During probing, store information from all the connected flashes,=20
>    whether in stacked or parallel mode, and present it as a single device=
=20
>    to the MTD layer.
>  - Register callbacks through this new layer instead of spi-nor/core.c an=
d=20
>    handle MTD device registration.
>  - In stacked mode, select the appropriate spi-nor flash based on the=20
>    address provided by the MTD layer during flash operations.
>  - Manage flash crossover operations in stacked mode.
>  - Ensure both connected flashes are identical in parallel mode.
>  - Handle odd byte count requests from the MTD layer during flash=20
>    operations in parallel mode.
>=20
> For implementing this the current DT binding need to be updated as=20
> follows.

So you want to go back to step 1 and redefine bindings? Is that worth?

> stacked-memories DT changes:
>  - Flash size information can be retrieved directly from the flash, so it=
=20
>    has been removed from the DT binding.
>  - Each stacked flash will have its own flash node. This approach allows=
=20
>    flashes of different makes and sizes to be stacked together, as each=20
>    flash will be probed individually.

And how will you define partitions crossing device boundaries? I
believe this constraint has been totally forgotten in this proposal.
The whole idea of stacking two devices this way was to simplify the
user's life with a single device exposed and the controller handling
itself the CS changes. That is precisely what the current binding do.
The final goal being to double your storage transparently. If your goal
was to put two chips aside, then none of this was actually needed. If
you don't care about that anymore, then all the energy put into
discussing the bindings initially was useless and a controller property
could also have made the trick.

>  - The stacked-memories DT bindings will contain the phandles of the flas=
h=20
>    nodes connected in stacked mode.
>=20
> spi@0 {
>  =20
>   flash@0 {
>     compatible =3D "jedec,spi-nor"
>     reg =3D <0x00>;
>     stacked-memories =3D <&flash@0 &flash@1>;
>     spi-max-frequency =3D <50000000>;
>     ...
>               partition@0 {=20
>         label =3D "qspi-0";
>         reg =3D <0x0 0xf00000>;
>     };
>                        =20
>=20
>   }
>  =20
>   flash@1 {
>     compatible =3D "jedec,spi-nor"
>               reg =3D <0x01>;
>     spi-max-frequency =3D <50000000>;
>     ...
>               partition@0 {=20
>         label =3D "qspi-1";
>         reg =3D <0x0 0x800000>;
>     };
>   }
> }
>=20
> parallel-memories DT changes:
>  - Flash size information can be retrieved directly from the flash, so it=
=20
>    has been removed from the DT binding.
>  - Each flash connected in parallel mode will have its own flash node.=20
>    This allows us to verify that both flashes connected in parallel are=20
>    identical, as each flash node will be probed separately.

Well, you don't have to verify that. It's a basic hardware design
constraint for using this mode.

Otherwise same comment as above, this description doesn't allow
correct partitioning and that was one of the main constraints back when
we discussed these needs.

>  - The parallel-memories DT bindings will contain the phandles of the=20
>    flash nodes connected in parallel.
>=20
> spi@0 {
>  =20
>   flash@0 {
>     compatible =3D "jedec,spi-nor"
>     reg =3D <0x00>;
>     parallel-memories =3D <&flash@0 &flash@1>;
>     spi-max-frequency =3D <50000000>;
>     ...
>               partition@0 {=20
>         label =3D "qspi-0";
>         reg =3D <0x0 0xf00000>;
>     };
>                        =20
>=20
>   }
>  =20
>   flash@1 {
>     compatible =3D "jedec,spi-nor"
>               reg =3D <0x01>;
>     spi-max-frequency =3D <50000000>;
>     ...
>               partition@0 {=20
>         label =3D "qspi-1";
>         reg =3D <0x0 0x800000>;
>     };
>   }
> }

Thanks,
Miqu=C3=A8l

