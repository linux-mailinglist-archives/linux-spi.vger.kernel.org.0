Return-Path: <linux-spi+bounces-5778-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070F9D3788
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 10:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6E72823F5
	for <lists+linux-spi@lfdr.de>; Wed, 20 Nov 2024 09:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D1919E83E;
	Wed, 20 Nov 2024 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UMsqcLqi"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5960319CC3F;
	Wed, 20 Nov 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732096366; cv=none; b=t2tcIWfdCGb0RD4OYNCPo8VqDyULjidSkgfEZ3uelyeco77GrVpZtt7gZ1Zth8PpA0wQy2kfZBY16LjmF4Pi2d0GzBQZQE7eXnoH5n4hm4W7RCCiLDZ/MuEL//uZny0aSJFnX+fiC2wMW8gs1MvWG3gszybuIqDEGOl+KIjpg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732096366; c=relaxed/simple;
	bh=0k5XmDP3+QnNrEI2KbUVvvL7QkJFuQCAvDrn688lHe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M8PpRYusZ25T+rGrKvqHsh1Mpcsa3CgWXqRQecoX3WeIgsgGfyPCa2alphJzPKSq+aFnzjTtSPX6OMic2loTWV8msB8I+orI6NLMDMEWp/ICtqSuVTxWZ0VyCSSa03bW48011K9oBiIpU63kUgSbyRlM6/K2K50lySDyBa0HvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UMsqcLqi; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2BCCB60005;
	Wed, 20 Nov 2024 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732096361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CjSe/U+nzv9GiQYKnA55TJmWIVaBLG17HklLuP9BQuo=;
	b=UMsqcLqizhfjcdodWKdRRxIHV/G24AKIsGNrdAAq4ZT9e/a9MVuhkV/AOZQ0kRe+iAF131
	xWlc7VGm++AIHwxvSi1cFpq8y3AfypDdpXPHg+R8zytnvRnc/lXI4CndJZ+clFyZkMNUkB
	K4rSmJ+GW3cgI/j0F0Ziev7Q82q8O/t9yiUr50dDIellFUW7jQcHAjB3R7E1NepRa1KImD
	zdXTwbQ4eOAIk2e9JAty7V91bo9Bvg3JKqBs7gJs9pV6bIjkqcrbzasIiMFj3N6nPUXPjS
	hwLeJt9Ro2U3gRa7a/vAyOWgyPSCxvuhhqafKFS9d0uH3b3+344AeSnRRue/Ig==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc: "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
  "michael@walle.cc" <michael@walle.cc>,  "broonie@kernel.org"
 <broonie@kernel.org>,  "pratyush@kernel.org" <pratyush@kernel.org>,
  "richard@nod.at" <richard@nod.at>,  "vigneshr@ti.com" <vigneshr@ti.com>,
  "robh@kernel.org" <robh@kernel.org>,  "conor+dt@kernel.org"
 <conor+dt@kernel.org>,  "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
  "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
  "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
  "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
  "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
  "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,  "Simek, Michal"
 <michal.simek@amd.com>,  "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,  "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>,  "patches@opensource.cirrus.com"
 <patches@opensource.cirrus.com>,  "git (AMD-Xilinx)" <git@amd.com>,
  "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
  "beanhuo@micron.com" <beanhuo@micron.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: Add bindings for describing
 concatinated MTD devices
In-Reply-To: <IA0PR12MB76994483BBB757BD9F691513DC202@IA0PR12MB7699.namprd12.prod.outlook.com>
	(Amit Kumar Mahapatra's message of "Tue, 19 Nov 2024 17:02:33 +0000")
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
	<20241026075347.580858-2-amit.kumar-mahapatra@amd.com>
	<87frnoy8na.fsf@bootlin.com>
	<IA0PR12MB76994483BBB757BD9F691513DC202@IA0PR12MB7699.namprd12.prod.outlook.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 20 Nov 2024 10:52:38 +0100
Message-ID: <87sermxme1.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 19/11/2024 at 17:02:33 GMT, "Mahapatra, Amit Kumar" <amit.kumar-mahapatr=
a@amd.com> wrote:

> Hello Miquel,
>=20=20
>> > This approach was suggested by Rob [1] during a discussion on Miquel's
>> > initial approach [2] to extend the MTD-CONCAT driver to support
>> > stacked memories.
>> > Define each flash node separately with its respective partitions, and
>> > add a 'concat-parts' binding to link the partitions of the two flash
>> > nodes that need to be concatenated.
>> >
>> > flash@0 {
>> >         compatible =3D "jedec,spi-nor"
>> >         ...
>> >                 partitions {
>>=20
>> Wrong indentation here and below which makes the example hard to read.
>
> Sorry about that. I am redefining both the flash nodes here with proper=20
> indentation.
>
> flash@0 {
> 	compatible =3D "jedec,spi-nor"
> 	...
> 	partitions {
> 		compatible =3D "fixed-partitions";
> 		concat-partition =3D <&flash0_partition &flash1_partition>;
>=20=09=09
> 		flash0_partition: partition@0 {
> 			label =3D "part0_0";
> 			reg =3D <0x0 0x800000>;
> 		};
> 	};
> };
>
> flash@1 {
> 	compatible =3D "jedec,spi-nor"
> 	...
> 	partitions {
> 		compatible =3D "fixed-partitions";
> 		concat-partition =3D <&flash0_partition &flash1_partition>;
>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> 		flash1_partition: partition@0 {
> 			label =3D "part0_1";
> 			reg =3D <0x0 0x800000>;
> 		};
> 	};
> };
>
>>=20
>> >                 compatible =3D "fixed-partitions";
>> >                         concat-partition =3D <&flash0_partition &flash=
1_partition>;
>> >                         flash0_partition: partition@0 {
>> >                                 label =3D "part0_0";
>> >                                 reg =3D <0x0 0x800000>;
>> >                         }
>> >                 }
>> > }
>> > flash@1 {
>> >         compatible =3D "jedec,spi-nor"
>> >         ...
>> >                 partitions {
>> >                 compatible =3D "fixed-partitions";
>> >                         concat-partition =3D <&flash0_partition &flash=
1_partition>;
>> >                         flash1_partition: partition@0 {
>> >                                 label =3D "part0_1";
>> >                                 reg =3D <0x0 0x800000>;
>> >                         }
>> >                 }
>> > }
>>=20
>> This approach has a limitation I didn't think about before: you cannot u=
se anything
>> else than fixed partitions as partition parser.
>
> Yes, that's correct=E2=80=94it won't function when partitions are defined=
 via the=20
> command line. In my opinion, we should start by adding support for fixed=
=20
> partitions, add comments in code stating the same. If needed, we can late=
r=20
> extend the support to dynamic partitions as well.

New thought. What if it was a pure fixed-partition capability? That's
actually what we want: defining fixed partitions through device
boundaries. It automatically removes the need for further dynamic
partition extensions.

Thanks,
Miqu=C3=A8l

