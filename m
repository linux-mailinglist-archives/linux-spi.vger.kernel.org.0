Return-Path: <linux-spi+bounces-5038-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821BE989D9D
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E77287EBF
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E8186607;
	Mon, 30 Sep 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oopwFy97"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5294C1865F1;
	Mon, 30 Sep 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687065; cv=none; b=aEFroq8T5VuF5+oPNSzPurLlosJNHkPC/YAsGJZrG/d5SwNhj7+0eZ7doSAjTVZfgZJd0kX0x7Nu2unGgT+K1TE9lA8/upwERUxdIY3Nhbvx6ukoBMxGi0CSJ7JwLn/dsJ+GZLe8HEyNu8H6oUZDffFdFZkkJePc4FycdkKT0EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687065; c=relaxed/simple;
	bh=5vfmCoWhJfN9myIJ8um04DTZKKRCmBeNbBVzguOQXMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCNwgE0FS6DbFsWJ1FGN4fh0G4BEsJmFtD4dmFGKbg8oaV1PHGhG1giVc6ILImtI57jZBrjRYML5VglV8xAH5iuvSeVFCP3jhSvIL76ZpZK7wNDExRV1m041O3H1WWPYKtKyt692OmEk2oJ1Kq2B5/hVOul8pYDeGtEijnYGgu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oopwFy97; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 29C2D40009;
	Mon, 30 Sep 2024 09:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727687053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I/Yd74SXWwnJNHzkH+B1zGDPYPSWPzutmB3r6NlN8+k=;
	b=oopwFy97Xs7m4K3UfEGC1hiSSNHKTDyWZt9dJs73tB3PhVekjYUwWjFTpXxO9rhGuwRcmO
	7EY460BtJoyBI+PszIgN0UqnD7FmeuGdO66U/wzlSL49YKAnVFWxzKZQqg5GViNphID+YS
	GoW6P4MpEYAGoSwerOwunKoJeKsq5S7j+qpOV5xD/FKvGAzX4OMK2gx61LXZ8CWjDIOEXS
	+7H8X+m6td/vhZ38an6ytEtNTgQNe8GqLcq3hxsAfAS0En8/N59vH5/z446z+0K/TdOA5Y
	riEwwRZm+c++1OUJ0NH0ycTAbZzXXGCnsAHUqCs6sQ6pgE8FYRgGMxIkB8Voig==
Date: Mon, 30 Sep 2024 11:04:08 +0200
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
Message-ID: <20240930110408.6ec43e97@xps-13>
In-Reply-To: <IA0PR12MB7699B360C7CF59E0A3D095F9DC8D2@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <IA0PR12MB7699B360C7CF59E0A3D095F9DC8D2@IA0PR12MB7699.namprd12.prod.outlook.com>
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

> For implementing this the current DT binding[1] [2] [3] need to be update=
d as follows.
>=20
>=20
>=20
> stacked-memories DT changes:
>=20
> - Flash size information can be retrieved directly from the flash, so it =
has been removed from the DT binding.
>=20
> - Each stacked flash will have its own flash node. This approach allows f=
lashes of different makes and sizes to be stacked together, as each flash w=
ill be probed individually.
>=20
> -  Each of the flash node will have its own "reg" property that will cont=
ain its physical CS.

These three first points are just describing the existing bindings for
non-concatenated situations.

> - The stacked-memories DT bindings will contain the phandles of the flash=
 nodes connected in stacked mode.
>=20
> - The first flash node will contain the mtd partition that would have the=
 cross over memory staring at a memory location in the first flash and endi=
ng at some memory location of the 2nd flash

I don't like that much. Describing partitions past the actual device
sounds wrong. If you look into [1] there is a suggestion from Rob to
handle this case using a property that tells us there is a
continuation, so from a software perspective we can easily make the
link, but on the hardware description side the information are correct.

If this description is accepted, then fine, you can deprecate the=20
"stacked-memories" property.

>  - The new layer will update the mtd->size and other mtd_info parameters =
after both the flashes are probed and will call mtd_device_register with th=
e combined information.

Okay, this is back to the mtd-concat thing I initially proposed, but I
believe it can work.

[...]

> parallel-memories DT changes:
>=20
> - Flash size information can be retrieved directly from the flash, so it =
has been removed from the DT binding.

It's not really about the size but more about the fact that two
memories are in use. If the stacked situation does not require anything
specific besides the partitions trick, then you can assume that double
reg flashes are just two flashes and this can be your way to
discriminate the data organization. But I don't like much this shortcut
because it is not future proof, and instead I'd keep the stacked-memory
property. If you don't like the size, I don't really care, just use it
as a boolean. But I believe we need some naming to tell the OS that the
data is spread in a specific way inside the memory devices.

> - Each flash connected in parallel mode should be identical and will have=
 one flash node for both the flash devices.

This is already the case.

> - The "reg" prop will contain the physical CS number for both the connect=
ed flashes.

This is already the case.

> - The new layer will double the mtd-> size and register it with the mtd l=
ayer.

This is not a DT change.


Thanks,
Miqu=C3=A8l

