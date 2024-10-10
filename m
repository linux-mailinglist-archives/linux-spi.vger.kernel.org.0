Return-Path: <linux-spi+bounces-5188-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CA5998223
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 11:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEC7287E09
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668771A264C;
	Thu, 10 Oct 2024 09:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HYHexWZb"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A3E1A00F0;
	Thu, 10 Oct 2024 09:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728552478; cv=none; b=s0ETjREnRYohf3inqi662uQK3Z06jkDT+djFtLyms2OC2WMkGckJdeyEuwb/EotEB/puh6Ayxwag42TtkE7zGsv6PDXvnLalT9wwyXe45Lpj+diqDjV5gnekemThGCtEpRkjvotJEUFdMo2GtpAa00ZVUFM8HA6EnPi31NiMqrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728552478; c=relaxed/simple;
	bh=Qc/AzkQlI2nXPdkpvLykvsnuBMgjz/SDo6Yy82JMdn4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ODU0yXRtj8AriTd+lRAjcKAYMFzhNFPmR+WpaDwckZicVv/iPtyYC6SPEJ1WCtnkFFYEyTSe3p3r7hUitiUL3m11lT9kh/BXR08OnBVMS4ay4jjVcVUAnXhdinF0CHr7isNXo34dKH1njNBpji/tmDRz6h+IAq54DcvDIqd9f5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HYHexWZb; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E8E0C240009;
	Thu, 10 Oct 2024 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728552473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SIpvFyTZgLUu94xOGDEGcr970RAQUxKWuf6ktquG0pA=;
	b=HYHexWZbzisi+7I32KvQ/3MgFxTE0vqgO/bvfPgFfvjFRZ5OL9sONbUEfexGaj3nIYFNBg
	rFZUaS9+M6En3zav/tnEjpEGrVtrUchLMaFKubrwz/WPA5PkH2uATnZ/FxbUUIIlOa9i79
	LftYlIOBb1T/NFh5hwpmp7x5qIojm8Qgq4Z8BE9AXAPsz6/N6EONB62+aL71r4rZPTGC05
	TbrVH8EBsOkG8a8EwJ/WP7/2wT5erFKgJoylTC6JKbG3f2l7lguUKdnT57IhBnrziOxfBW
	oyZsmZ5SKpI9QmYRMdUhHMS9zuORceU+OxkeXy4uL2O+2ozkIJp+R2VbWKooGA==
Date: Thu, 10 Oct 2024 11:27:51 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, "michael@walle.cc"
 <michael@walle.cc>, "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>, "richard@nod.at"
 <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>, Rob Herring
 <robh@kernel.org>, "cornor+dt@kernel.org" <cornor+dt@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
 <linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
 <nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
 <alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
 <claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
 <patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
 <linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, Conor Dooley
 <conor.dooley@microchip.com>, "beanhuo@micron.com" <beanhuo@micron.com>
Subject: Re: Add stacked and parallel memories support in spi-nor
Message-ID: <20241010112751.01e5afa1@xps-13>
In-Reply-To: <IA0PR12MB769930E81D3D66B51CDC8213DC782@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <IA0PR12MB7699B360C7CF59E0A3D095F9DC8D2@IA0PR12MB7699.namprd12.prod.outlook.com>
	<20240930110408.6ec43e97@xps-13>
	<IA0PR12MB769930E81D3D66B51CDC8213DC782@IA0PR12MB7699.namprd12.prod.outlook.com>
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

amit.kumar-mahapatra@amd.com wrote on Thu, 10 Oct 2024 09:17:58 +0000:

> Hello Miquel,
>=20
> > > - The stacked-memories DT bindings will contain the phandles of the f=
lash nodes =20
> > connected in stacked mode. =20
> > >
> > > - The first flash node will contain the mtd partition that would have
> > > the cross over memory staring at a memory location in the first flash
> > > and ending at some memory location of the 2nd flash =20
> >=20
> > I don't like that much. Describing partitions past the actual device so=
unds wrong. If
> > you look into [1] there is a suggestion from Rob to handle this case us=
ing a property
> > that tells us there is a continuation, so from a software perspective w=
e can easily
> > make the link, but on the hardware description side the information are=
 correct. =20
>=20
> I reviewed Rob's suggestions in [1], and I need to examine the MTD layer=
=20
> to determine how this can be implemented from a software perspective.=20
> For reference, here is Rob's suggestion:
>=20
> Describe each device and partition separately and add link(s) from one=20
> partition to the next=20
>=20
> flash0 {
>   partitions {
>     compatible =3D "fixed-partitions";
>     concat-partition =3D <&flash1_partitions>;
>     ...
>   };
> };
>=20
> flash1 {
>   flash1_partition: partitions {
>     compatible =3D "fixed-partitions";
>     ...
>   };
> };
>=20
> >=20
> > If this description is accepted, then fine, you can deprecate the "stac=
ked-memories"
> > property. =20
>=20
> I believe that in addition to Rob's description, we should also include=20
> the 'stacked-memories' property. This property helps us identify which=20
> flashes are stacked, while Rob's suggestion explains how the partitions=20
> within the stacked flashes are connected.
>=20
> For example, if we have three flashes connected to an SPI host, with=20
> flash@0 and flash@1 operating in stacked mode and flash@2 functioning as =
a=20
> standalone flash, the Device Tree binding might look something like this:=
=20
> Please share your thoughts on this.
>=20
> spi@0 {
>   ...
>   flash@0 {
>     compatible =3D "jedec,spi-nor"
>     reg =3D <0x00>;
>     stacked-memories =3D <&flash@0 &flash@1>;
>     spi-max-frequency =3D <50000000>;
>     ...
>         flash0_partition: partitions {
>             compatible =3D "fixed-partitions";
> 	concat-partition =3D <&flash1_partitions>;=09
>         	partition@0 {
>           	    label =3D "Stacked-Flash-1";
>                 reg =3D <0x0 0x800000>;
> 	}
>         }
>     }
>   flash@1 {
>     compatible =3D "jedec,spi-nor"
>      reg =3D <0x01>;
>     spi-max-frequency =3D <50000000>;
>     ...
>         flash1_partition: partitions {
>             compatible =3D "fixed-partitions";
> 	concat-partition =3D <&flash0_partitions>;=09
>         	partition@0 {
>           	    label =3D " Stacked-Flash-2";
>                 reg =3D <0x0 0x800000>;
> 	}
>         }
>   }
>=20
>   flash@2 {
>     compatible =3D "jedec,spi-nor"
>      reg =3D <0x01>;
>     spi-max-frequency =3D <50000000>;
>     ...
>         partitions {
>             compatible =3D "fixed-partitions";
> 	concat-partition =3D <&flash0_partitions>;=09
>         	partition@0 {
>           	    label =3D "Single-Flash";
>                 reg =3D <0x0 0x800000>;
> 	}
>         }
>   }

I'm sorry but this is pretty messed up. The alignments are wrong, I
believe the labels are wrong, the reg properties as well. Can you
please work on this example and send an updated version?

Thanks,
Miqu=C3=A8l

