Return-Path: <linux-spi+bounces-3644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B099D91AE79
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 19:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584D31F24181
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BE819AA4B;
	Thu, 27 Jun 2024 17:49:22 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCFC4C9A;
	Thu, 27 Jun 2024 17:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510562; cv=none; b=I9SHblNXJPFgWL47jWRbKQdQrBTGKCs7YvH2RPLKKaexhefmL+cwYJHGxphfXtI9xc16asyU2CpJ7q2TJifH7ZRWZfmKoGddcrq8tixp7DvMEnZPKu9KDrAIzMOHyPGAGOKT7zZVPb2h0GtZbK8qXzM/v32Z+muw4p/TUc2YYJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510562; c=relaxed/simple;
	bh=1w8PitqYQecd9A7PeIKvg2ekZZBQE6TegR88h1yVWps=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Ay+g27+fXRsj1YDT7dupEz97VkQLHOSnGt/Y1AOlXHpPNjMcfN/k/vFgrjDX4gObxGcZL7jMaKpk0iEOd0wq3tU73wVXdezYU8OFrSRkQwfQX0fS+yRnhW5qT8hHSEhiUaP2T3sNsBfaSoS1MSu18dOq9mzbV2n/WBQsHwGHz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [IPv6:2a02:810b:4340:4ee9:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 147894CC;
	Thu, 27 Jun 2024 19:49:18 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Jun 2024 19:49:17 +0200
Message-Id: <D2AZMD2YYGAQ.1B3AGXIC7B44@kernel.org>
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Ayush Singh" <ayush@beagleboard.org>, "Mark Brown"
 <broonie@kernel.org>, "Vaishnav M A" <vaishnav@beagleboard.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Derek Kiernan"
 <derek.kiernan@amd.com>, "Dragan Cvetic" <dragan.cvetic@amd.com>, "Arnd
 Bergmann" <arnd@arndb.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Nishanth Menon" <nm@ti.com>, "Vignesh
 Raghavendra" <vigneshr@ti.com>, "Tero Kristo" <kristo@kernel.org>, "Andrew
 Lunn" <andrew@lunn.ch>, <jkridner@beagleboard.org>,
 <robertcnelson@beagleboard.org>
Subject: Re: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
X-Mailer: aerc 0.16.0
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org> <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org> <D2AYUH4XY0SK.1SYOUCT0PLAKT@kernel.org> <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>
In-Reply-To: <e0f9754e-4d84-4ab4-82a4-34cb12800927@beagleboard.org>

Hi,

On Thu Jun 27, 2024 at 7:29 PM CEST, Ayush Singh wrote:
> On 6/27/24 22:42, Michael Walle wrote:
>
> > Hi,
> >
> > Could you give us a DT snippet of how this should look like with a
> > board?
> >
> > On Thu Jun 27, 2024 at 6:26 PM CEST, Ayush Singh wrote:
> >> +  board:
> >> +    description: board attached to mikrobus connector
> >> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > Shouldn't this be a subnode of the connector?
> >
> > i.e.
> >
> > connector {
> > 	compatible =3D "mikrobus-connector";
> >
> > 	// phandles to the parent controllers
> >
> > 	spi {
> > 		temp-sensor@0 {
> > 			compatible =3D "maxim,max31855k";
> > 			reg =3D <0>;
> > 		};
> > 	};
> >
> > 	i2c {
> > 		..
> > 	};
> > };
> >
> > I don't think you can introduce a new
> >    compatible =3D "maxim,max31855k", "mikrobus,spi";
> > if there is already a binding for "maxim,max31855k". But I might be
> > wrong. Why is this compatible needed at all?
>
> So I did consider the design you just proposed, but I was not able to=20
> solve a few issues.
>
> 1. How to deal with say 2 mikrobus connectors in a single system?

Yes, interesting problem. That info should go into the cover letter.

> My goal is to have only 1 overlay required for the board config at most.=
=20
> Ideally, I would actually like to add the dt for most mikroBUS boards to=
=20
> upstream and thus only the following overlay would be required:
>
> ```
>
> &connector0 {
>
>  =C2=A0=C2=A0=C2=A0 board =3D <&temp-board>;
>
> };

That's then per board, per click board. right?

>
> ```
>
>
> The problem with making it children is that each connector will require=
=20
> seperate overlays for board configs.

Right.

> Additionally, there are boards with 1 wire eeprom available which can=20
> theselves store the overlay. In the current setup it will look as follows=
:
>
> ```
>
> &mikrobus_board {

Where is that phandle pointing to? And what if there are two boards?

>
>  =C2=A0=C2=A0=C2=A0 thermo-sensor {
>
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ...
>
>  =C2=A0=C2=A0=C2=A0 };
>
> };

But here you can have subnodes, no? These could then be just
enumerated as usual.

&mikrobus_board {
	mikrobus_gpio: gpio {
		gpio-controller;
		#gpio-cells =3D <1>;
	};

	spi {
		cs-gpios =3D <&mikrobus_gpio 1>;

		spi@0 {
			compatible =3D "mydevice";
			reg =3D <0>;
		};
	};
};


> ```

Not sure what this is, but my mail reader doesn't render RST? ;)

-michael

>
> Which is completely independent of the connector. If the same can be=20
> achieved with child-node as well, then I am open to doing that.
>
>
> >
> > Also, the mikrobus-connector driver could translate the chipselects.
> >
> > -michael
>
> Yes, so it is currently doing that. Translating chip select name to the=
=20
> actual number. I am doing it the name way since some boards might use=20
> pins other than CS as chipselect and not all connectors will allow all=20
> pins to be used as chipselect.
>
>
> Ayush Singh


