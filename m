Return-Path: <linux-spi+bounces-9239-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E855AB163DF
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 17:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E075566939
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jul 2025 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71A52DCC05;
	Wed, 30 Jul 2025 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LB8kfxhH"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E6A2652B4;
	Wed, 30 Jul 2025 15:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890369; cv=none; b=pJ9tFYteLZbohSWBwfyINKfxE21BYTe4yVZkPKSpX7wXpTFcNm+bICLOHTqzmp14wxtXZmaMmcAPUpZ9o56v09fK8eBx/IlezWlF0k5nT1aE/bSJrhaPV8CjSnNQ0o//5EQqw+FtQuIXeFXnnPDOLTMHx4nno6/Fydgtf+F6QZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890369; c=relaxed/simple;
	bh=L8XzuUBtVMiUY3rJrZnCLHPBuVniF1PoqG4acgTlRg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkaxFUa2aVGic1Q7PLyBRwCehn4WdDwqKWL19Ba8AJMudomS7PKIv/7wDXLIRjSBgKG9OHb8Paej8BbFJZ+WvS1Pkt0dwWcMRLqJlPX5KHIW7z78w/T1zI8SUPPCyiCU7QXgHtwxkPXbqrcpmKnVS6uNpHzwO0fTsCEjsznBWDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LB8kfxhH; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB2DA43881;
	Wed, 30 Jul 2025 15:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753890356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BVuoo4VG2tlrXaQpp6d0XpKPV/Ar3pXYePMdRqvPDDM=;
	b=LB8kfxhHMjKFKuZDoPujS+Fa1sNVuy84ku1XnoiCqQfC820A/eyfM6Xrd3IcuX8XPe7Pnp
	ym7Ne/+6rpAvNDTpd55CUZcf8hGAejzcOtJRGL3tarBMONIWC77eM6yT+0RG8fDFcyE8oz
	iJ++aVnKu70MqWNrPT7zWBXIkG5rfadhW8gXhEcLAf1+3aWoN0riVVEh9MTzKuDGWrj7yF
	YEpYWwy02OUTU/cl7YWzhbu+dnG4ke0fGAN3St4df7l90pjwnW7Zx0carXWnt9cwpov+Ke
	UZnYJZUVlEGSPvXce1fKL7T8uShf2EXTIiF+ElzO1jtL0ct/hfTwDqt6i58kUw==
Date: Wed, 30 Jul 2025 17:45:53 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ayush Singh <ayush@beagleboard.org>, Mark Brown <broonie@kernel.org>,
 herve.codina@bootlin.com, conor+dt@kernel.org, Jason Kridner
 <jkridner@beagleboard.org>, Deepak Khatri <lorforlinux@beagleboard.org>,
 Dhruva Gole <d-gole@ti.com>, Robert Nelson <robertcnelson@beagleboard.org>,
 Andrew Davis <afd@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/4] devicetree: bindings: spi: Introduce SPI bus
 extensions
Message-ID: <20250730174553.4df8037b@booty>
In-Reply-To: <c65d26d0-51b8-4131-a755-6c72b7dea549@kernel.org>
References: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
	<20250729-spi-bus-extension-v1-4-b20c73f2161a@beagleboard.org>
	<c65d26d0-51b8-4131-a755-6c72b7dea549@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelkeefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhkeeigeethfegleeiheehgfdtkeffvefggedvgeegleekheejteettefhvedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudehpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrhihushhhsegsvggrghhlvggsohgrrhgurdhorhhgpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjkhhrihgunhgvrhessggvrghglhgvsghorghrugdrohhrghdprhgtphhtthhopehlohhrfhhorhhlihhnuhigsegsvggrghhlvggsohgrrhgurdhorhhgpdhrtghpthhtohepugdqghholhgvsehtihdrtghomh

On Tue, 29 Jul 2025 14:52:00 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 29/07/2025 11:51, Ayush Singh wrote:
> > An SPI bus can be wired to the connector and allows an add-on board to
> > connect additional SPI devices to this bus.
> >  =20
>=20
> ... so I found the binding. Not marked by my filters due to non-standard
> subject.
>=20
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>=20
> > Those additional SPI devices could be described as sub-nodes of the SPI
> > bus controller node however for hotplug connectors described via device
> > tree overlays there is additional level of indirection, which is needed
> > to decouple the overlay and the base tree:
> >=20
> >   --- base device tree ---
> >=20
> >   spi1: spi@abcd0000 {
> >       compatible =3D "xyz,foo";
> >       spi-bus-extension@0 {
> >           spi-bus =3D <&spi_ctrl>;
> >       };
> >       ...
> >   };
> >=20
> >   spi5: spi@cafe0000 {
> >       compatible =3D "xyz,bar";
> >       spi-bus-extension@0 {
> >           spi-bus =3D <&spi_sensors>;
> >       };
> >       ...
> >   };
> >=20
> >   connector {
> >       spi_ctrl: spi-ctrl {
> >           spi-parent =3D <&spi1>;
> >           #address-cells =3D <1>;
> >           #size-cells =3D <0>;
> >       };
> >=20
> >       spi_sensors: spi-sensors {
> >           spi-parent =3D <&spi5>;
> >           #address-cells =3D <1>;
> >           #size-cells =3D <0>;
> >       };
> >   }; =20
>=20
> It looks like you are re-doing I2C work. Please wait till I2C discussion
> finishes, so we won't have to comment on the same in multiple places.
>=20
> >=20
> >   --- device tree overlay ---
> >=20
> >   ...
> >   // This node will overlay on the spi-ctrl node of the base tree
> >   spi-ctrl {
> >       eeprom@50 { compatible =3D "atmel,24c64"; ... };
> >   };
> >   ...
> >=20
> >   --- resulting device tree ---
> >=20
> >   spi1: spi@abcd0000 {
> >       compatible =3D "xyz,foo";
> >       spi-bus-extension@0 {
> >           spi-bus =3D <&spi_ctrl>;
> >       };
> >       ...
> >   };
> >=20
> >   spi5: spi@cafe0000 {
> >       compatible =3D "xyz,bar";
> >       spi-bus-extension@0 {
> >           spi-bus =3D <&spi_sensors>;
> >       };
> >       ...
> >   };
> >=20
> >   connector {
> >       spi_ctrl: spi-ctrl {
> >           spi-parent =3D <&spi1>;
> >           #address-cells =3D <1>;
> >           #size-cells =3D <0>;
> >=20
> >           device@1 { compatible =3D "xyz,foo"; ... };
> >       };
> >=20
> >       spi_sensors: spi-sensors {
> >           spi-parent =3D <&spi5>;
> >           #address-cells =3D <1>;
> >           #size-cells =3D <0>;
> >       };
> >   };
> >=20
> > Here spi-ctrl (same goes for spi-sensors) represent the part of SPI bus
> > that is on the hot-pluggable add-on. On hot-plugging it will physically
> > connect to the SPI adapter on the base board. Let's call the 'spi-ctrl'
> > node an "extension node".
> >=20
> > In order to decouple the overlay from the base tree, the SPI adapter
> > (spi@abcd0000) and the extension node (spi-ctrl) are separate nodes.
> >=20
> > The extension node is linked to the SPI bus controller in two ways. The
> > first one with the spi-bus-extension available in SPI controller
> > sub-node and the second one with the spi-parent property available in
> > the extension node itself.
> >=20
> > The purpose of those two links is to provide the link in both direction
> > from the SPI controller to the SPI extension and from the SPI extension
> > to the SPI controller.
> >=20
> > Signed-off-by: Ayush Singh <ayush@beagleboard.org>
> > ---
> >  .../devicetree/bindings/spi/spi-controller.yaml    | 66 ++++++++++++++=
+++++++-
> >  1 file changed, 65 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml =
b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > index 82d051f7bd6e09dab9809c85ff13475d2b118efd..9b44ce4542f9552c94cb065=
8ffe3f6d3f29bc434 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > @@ -25,6 +25,13 @@ properties:
> >    "#size-cells":
> >      const: 0
> > =20
> > +  spi-parent:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      In case of an SPI bus extension, reference to the SPI bus contro=
ller
> > +      this extension is connected to. In other word, reference the SPI=
 bus
> > +      controller on the fixed side that drives the bus extension.
> > +
> >    cs-gpios:
> >      description: |
> >        GPIOs used as chip selects.
> > @@ -111,7 +118,26 @@ properties:
> >        - compatible
> > =20
> >  patternProperties:
> > -  "^.*@[0-9a-f]+$":
> > +  'spi-bus-extension@[0-9a-f]+$':
> > +    type: object
> > +    description:
> > +      An SPI bus extension connected to an SPI bus. Those extensions a=
llow to
> > +      decouple SPI busses when they are wired to connectors. =20
>=20
> I really do not get why you need separate two-way phandles for marking
> parent child relationship. IOW, if you need two way, then why not graphs?
>=20
> Or why not just making the device@2 a child of SPI, since it is coming
> from overlay.

For the same reason as in I2C (and the proposed solution is the same).

As you wrote above, Ayush could wait for the I2C discussion to finish.
Problem is, the I2C discussion is not moving forward: Herv=C3=A9 is sending
proposals but there is no feedback on the core of the proposal, and no
feedback at all on the latest iteration. In case your filters missed it:
https://lore.kernel.org/all/20250618082313.549140-1-herve.codina@bootlin.co=
m/

I think Ayush's series is useful anyway in that it shows the approach
Herv=C3=A9 proposed works unmodified for another subsystem and is useful for
a different use case.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

