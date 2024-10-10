Return-Path: <linux-spi+bounces-5197-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D83998AE5
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 17:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2381D1C218E5
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9D91CB31A;
	Thu, 10 Oct 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lAovvxty"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56B619E7D3;
	Thu, 10 Oct 2024 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728572445; cv=none; b=LUgHyzLWQ5ZQtjjeDJcKtQgpycYYQ7+XWMblljGwb0BVWi7dFniaUaZMlG9QCGWxep/oUcq2GEC38WLeomvYGjJrGA/2KtC2AkZllzsoHQ8ON0qxLJuWGH7C/fFmjwHjB+2C05rXHZE2uk94N2jaYR+1pzPDxxrfBsl7oSsPrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728572445; c=relaxed/simple;
	bh=i6YxAqRcwcz/cNnFjqdAoRcTue8f+Pm/Ozecvt1SfsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SC17ghHgJmLuiitvuOYem0qMrbmvsC+wbSNNA0ADpq4ISFiTTqB/+02lWrF6vdlvrtreReO7nK8uHy+eZr6bSHjTriopkXAbJnEEixkFOkuKS+gyCZvWs6POth6u3vp08g/XQ/LqqsFgxvbZuazcQgO79elZui3sZtq32Qx5Xbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lAovvxty; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 50EE260002;
	Thu, 10 Oct 2024 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728572440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVZMs2+4Io1fiOqihAdk9nOoc2Kkn2C23QOtaCcVJvE=;
	b=lAovvxtyuEWjNDrbvDbZ/JCn99xSytxs4tLIBt0YjbjA60De6D5cMKL3z9DwFm1X8yJh52
	3/GPLC74/ITwLmc1RQP3dpsepxs4O6FiBwNMBXvrsYPuhGdwz9Ima68G6UWf0oyMGHz2vK
	ZaRJHNj5liMPV78OG+4kQ1UYUB753o3tk6oJWCskVeOje9cPuHiO+J184qqmLKfWVzHfDA
	9RO1vKW8QN92yBkuyAe5JeTo0bZCcu30XVo76jv6Fv0WYGj80MUcdXa+/3hwSxuru+rDDZ
	uQiOy599+8VADJM0xigLYyGRC1jPpLsKtqk0EZpVW2tDjh18jt2ieYHHe0Tr5g==
Date: Thu, 10 Oct 2024 17:00:36 +0200
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
Message-ID: <20241010165933.09a4114e@xps-13>
In-Reply-To: <IA0PR12MB76990FC67F334C0FEBDFEF36DC782@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <IA0PR12MB7699B360C7CF59E0A3D095F9DC8D2@IA0PR12MB7699.namprd12.prod.outlook.com>
	<20240930110408.6ec43e97@xps-13>
	<IA0PR12MB769930E81D3D66B51CDC8213DC782@IA0PR12MB7699.namprd12.prod.outlook.com>
	<20241010112751.01e5afa1@xps-13>
	<IA0PR12MB76990FC67F334C0FEBDFEF36DC782@IA0PR12MB7699.namprd12.prod.outlook.com>
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

amit.kumar-mahapatra@amd.com wrote on Thu, 10 Oct 2024 10:35:06 +0000:

> Hello Miquel,
>=20
> > -----Original Message-----
> > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > Sent: Thursday, October 10, 2024 2:58 PM
> > To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> > Cc: Tudor Ambarus <tudor.ambarus@linaro.org>; michael@walle.cc;
> > broonie@kernel.org; pratyush@kernel.org; richard@nod.at; vigneshr@ti.co=
m; Rob
> > Herring <robh@kernel.org>; cornor+dt@kernel.org; krzk+dt@kernel.org; li=
nux-
> > spi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-mtd@lists.infr=
adead.org;
> > nicolas.ferre@microchip.com; alexandre.belloni@bootlin.com;
> > claudiu.beznea@tuxon.dev; Simek, Michal <michal.simek@amd.com>; linux-a=
rm-
> > kernel@lists.infradead.org; alsa-devel@alsa-project.org;
> > patches@opensource.cirrus.com; linux-sound@vger.kernel.org; git (AMD-Xi=
linx)
> > <git@amd.com>; amitrkcian2002@gmail.com; Conor Dooley
> > <conor.dooley@microchip.com>; beanhuo@micron.com
> > Subject: Re: Add stacked and parallel memories support in spi-nor
> >=20
> > Hi Amit,
> >=20
> > amit.kumar-mahapatra@amd.com wrote on Thu, 10 Oct 2024 09:17:58 +0000:
> >  =20
> > > Hello Miquel,
> > > =20
> > > > > - The stacked-memories DT bindings will contain the phandles of
> > > > > the flash nodes =20
> > > > connected in stacked mode. =20
> > > > >
> > > > > - The first flash node will contain the mtd partition that would
> > > > > have the cross over memory staring at a memory location in the
> > > > > first flash and ending at some memory location of the 2nd flash =
=20
> > > >
> > > > I don't like that much. Describing partitions past the actual device
> > > > sounds wrong. If you look into [1] there is a suggestion from Rob to
> > > > handle this case using a property that tells us there is a
> > > > continuation, so from a software perspective we can easily make the=
 link, but on =20
> > the hardware description side the information are correct. =20
> > >
> > > I reviewed Rob's suggestions in [1], and I need to examine the MTD
> > > layer to determine how this can be implemented from a software perspe=
ctive.
> > > For reference, here is Rob's suggestion:
> > >
> > > Describe each device and partition separately and add link(s) from one
> > > partition to the next
> > >
> > > flash0 {
> > >   partitions {
> > >     compatible =3D "fixed-partitions";
> > >     concat-partition =3D <&flash1_partitions>;
> > >     ...
> > >   };
> > > };
> > >
> > > flash1 {
> > >   flash1_partition: partitions {
> > >     compatible =3D "fixed-partitions";
> > >     ...
> > >   };
> > > };
> > > =20
> > > >
> > > > If this description is accepted, then fine, you can deprecate the "=
stacked- =20
> > memories" =20
> > > > property. =20
> > >
> > > I believe that in addition to Rob's description, we should also
> > > include the 'stacked-memories' property. This property helps us
> > > identify which flashes are stacked, while Rob's suggestion explains
> > > how the partitions within the stacked flashes are connected.
> > >
> > > For example, if we have three flashes connected to an SPI host, with
> > > flash@0 and flash@1 operating in stacked mode and flash@2 functioning
> > > as a standalone flash, the Device Tree binding might look something l=
ike this:
> > > Please share your thoughts on this.
> > >
> > > spi@0 {
> > >   ...
> > >   flash@0 {
> > >     compatible =3D "jedec,spi-nor"
> > >     reg =3D <0x00>;
> > >     stacked-memories =3D <&flash@0 &flash@1>;
> > >     spi-max-frequency =3D <50000000>;
> > >     ...
> > >         flash0_partition: partitions {
> > >             compatible =3D "fixed-partitions";
> > > 	concat-partition =3D <&flash1_partitions>;
> > >         	partition@0 {
> > >           	    label =3D "Stacked-Flash-1";
> > >                 reg =3D <0x0 0x800000>;
> > > 	}
> > >         }
> > >     }
> > >   flash@1 {
> > >     compatible =3D "jedec,spi-nor"
> > >      reg =3D <0x01>;
> > >     spi-max-frequency =3D <50000000>;
> > >     ...
> > >         flash1_partition: partitions {
> > >             compatible =3D "fixed-partitions";
> > > 	concat-partition =3D <&flash0_partitions>;
> > >         	partition@0 {
> > >           	    label =3D " Stacked-Flash-2";
> > >                 reg =3D <0x0 0x800000>;
> > > 	}
> > >         }
> > >   }
> > >
> > >   flash@2 {
> > >     compatible =3D "jedec,spi-nor"
> > >      reg =3D <0x01>;
> > >     spi-max-frequency =3D <50000000>;
> > >     ...
> > >         partitions {
> > >             compatible =3D "fixed-partitions";
> > > 	concat-partition =3D <&flash0_partitions>;
> > >         	partition@0 {
> > >           	    label =3D "Single-Flash";
> > >                 reg =3D <0x0 0x800000>;
> > > 	}
> > >         }
> > >   } =20
> >=20
> > I'm sorry but this is pretty messed up. The alignments are wrong, I bel=
ieve the labels
> > are wrong, the reg properties as well. Can you please work on this exam=
ple and
> > send an updated version? =20
>=20
> Apologies for that. Here's the updated version along with the explanation.

Thanks for the update.

> spi@0 {
> 	...
>   	flash@0 {
>   		compatible =3D "jedec,spi-nor"
>     		reg =3D <0x00>;
>     		stacked-memories =3D <&flash@0 &flash@1>;

The same property should, IMHO, also be expected...

>     		spi-max-frequency =3D <50000000>;
>     		...
>         		partitions {
>             		compatible =3D "fixed-partitions";
>         			concat-partition =3D <&flash1_partition>; /* Link to the flash=
@1 partition@0 */
>                 		flash0_partition: partition@0 {
>                     			label =3D "part0_0";
>                 			reg =3D <0x0 0x800000>;
>         			}
>         		}
>     	}
>   	flash@1 {
>     		compatible =3D "jedec,spi-nor"
>      		reg =3D <0x01>;

... here.

>     		spi-max-frequency =3D <50000000>;
>     		...
>         		partitions {
>             		compatible =3D "fixed-partitions";
>         			concat-partition =3D <&flash0_partition>; /* Link to the flash=
@0 partition@0 */
>                 		flash1_partition: partition@0 {
>                     			label =3D "part0_1";
>                 			reg =3D <0x0 0x800000>;
>         			}
>         		}
>   	}
>=20
>   	flash@2 {
>     		compatible =3D "jedec,spi-nor"
>      		reg =3D <0x02>;
>     		spi-max-frequency =3D <50000000>;
>     		...
>         		partitions {
>             		compatible =3D "fixed-partitions";      =20
>                 		partition@0 {
>                     			label =3D "part1_0";
>                 			reg =3D <0x0 0x800000>;
>         			}
>         		}
>   	}
> }

Otherwise, okay for me.

Thanks,
Miqu=C3=A8l

