Return-Path: <linux-spi+bounces-5724-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9E29D11D4
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2024 14:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A54283CE7
	for <lists+linux-spi@lfdr.de>; Mon, 18 Nov 2024 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C787A1991C6;
	Mon, 18 Nov 2024 13:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TjnKsS73"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92921990C7;
	Mon, 18 Nov 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936448; cv=none; b=LIngyT0waQWCJN4paJgEOKl3/sTkvu+atoxyNGlWUM4JL/WHR0jVMjRA15TQNG8jNJy7AD02+9i2arQPlowSDHQAVptKWUlvhd9fe9KHCVwOF10ko4mgSKuPGKTHk5GS0rH3pHlL2soF/SZVJZbxyRbHIvQOZAqKERdwweVInOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936448; c=relaxed/simple;
	bh=j+2aLqPO8jT7pUqSoOdhBzttb3wUlOWGxh1jMETKNlc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RS3dOiBZS7UHY6HzWw8bCct0HDQRsRaV/GZdaJ+OxYd4qtKHfEWLsAYgydvHXcYqGLRuVZp3VjK2BQ4ib/+XDw4nJ53dupsc4F4Wr5JciPbVUj8fKC7rXLbyKlgW4xo3aHBJ7XWsoL7oFdixdXeAd+zis2z4DMNo89b8DjjjW8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TjnKsS73; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 491CE6000C;
	Mon, 18 Nov 2024 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731936443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C3aT8RFdCdTNdeyQreq16da7/I4iz4pcsvKIIFnCgCA=;
	b=TjnKsS73E0DI6Iz1Q01nvGmPESd+7DxF6LViNdUq0cX9Z0fhcRy+zhf1rsWcq79PUow3za
	RedWyADTe3BipekMwV1ef4XY/nveNr9lfcgJe4eucg+cC4f9nqXU1Al0w+rzpPv1ZlTkL4
	HWjP5twPA9CmE/HK7Q7xBEyU4DBsvYCeyZt+WyrLoXwfeDK9DI6KYjnW7Ab8tBOVTaZS3K
	YNrfEQzODkE3MW1LaAnQM5yksYIAph0J7GYoc5gRUVBOMDwH6TOBPu39VY25t+GtnWI1PU
	t+GuJMr7+z3Ssm8X8RkzTw6qDTocV4cBUXJ4Bck+T4PF979v2jPhGguDTJplDw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
Cc: <tudor.ambarus@linaro.org>,  <michael@walle.cc>,  <broonie@kernel.org>,
  <pratyush@kernel.org>,  <richard@nod.at>,  <vigneshr@ti.com>,
  <robh@kernel.org>,  <conor+dt@kernel.org>,  <krzk+dt@kernel.org>,
  <venkatesh.abbarapu@amd.com>,  <linux-spi@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <nicolas.ferre@microchip.com>,  <alexandre.belloni@bootlin.com>,
  <claudiu.beznea@tuxon.dev>,  <michal.simek@amd.com>,
  <linux-arm-kernel@lists.infradead.org>,  <alsa-devel@alsa-project.org>,
  <patches@opensource.cirrus.com>,  <git@amd.com>,
  <amitrkcian2002@gmail.com>,  <beanhuo@micron.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: mtd: Add bindings for describing
 concatinated MTD devices
In-Reply-To: <20241026075347.580858-2-amit.kumar-mahapatra@amd.com> (Amit
	Kumar Mahapatra's message of "Sat, 26 Oct 2024 13:23:46 +0530")
References: <20241026075347.580858-1-amit.kumar-mahapatra@amd.com>
	<20241026075347.580858-2-amit.kumar-mahapatra@amd.com>
User-Agent: mu4e 1.12.1; emacs 29.4
Date: Mon, 18 Nov 2024 14:27:21 +0100
Message-ID: <87frnoy8na.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 26/10/2024 at 13:23:46 +0530, Amit Kumar Mahapatra <amit.kumar-mahapatra=
@amd.com> wrote:

> This approach was suggested by Rob [1] during a discussion on Miquel's
> initial approach [2] to extend the MTD-CONCAT driver to support stacked
> memories.
> Define each flash node separately with its respective partitions, and add
> a 'concat-parts' binding to link the partitions of the two flash nodes th=
at
> need to be concatenated.
>
> flash@0 {
>         compatible =3D "jedec,spi-nor"
>         ...
>                 partitions {

Wrong indentation here and below which makes the example hard to read.

>                 compatible =3D "fixed-partitions";
>                         concat-partition =3D <&flash0_partition &flash1_p=
artition>;
>                         flash0_partition: partition@0 {
>                                 label =3D "part0_0";
>                                 reg =3D <0x0 0x800000>;
>                         }
>                 }
> }
> flash@1 {
>         compatible =3D "jedec,spi-nor"
>         ...
>                 partitions {
>                 compatible =3D "fixed-partitions";
>                         concat-partition =3D <&flash0_partition &flash1_p=
artition>;
>                         flash1_partition: partition@0 {
>                                 label =3D "part0_1";
>                                 reg =3D <0x0 0x800000>;
>                         }
>                 }
> }

This approach has a limitation I didn't think about before: you cannot
use anything else than fixed partitions as partition parser.

> Based on the bindings the MTD-CONCAT driver need to be updated to create
> virtual mtd-concat devices.
>
> [1] https://lore.kernel.org/all/20191118221341.GA30937@bogus/
> [2] https://lore.kernel.org/all/20191113171505.26128-4-miquel.raynal@boot=
lin.com/
>
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  .../mtd/partitions/fixed-partitions.yaml       | 18 ++++++++++++++++++
>  .../bindings/mtd/partitions/partitions.yaml    |  6 ++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-parti=
tions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partiti=
ons.yaml
> index 058253d6d889..df4ccb3dfeba 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.y=
aml
> @@ -183,3 +183,21 @@ examples:
>              read-only;
>          };
>      };
> +
> +  - |
> +    partitions {
> +        compatible =3D "fixed-partitions";
> +        #address-cells =3D <1>;
> +        #size-cells =3D <1>;

This is not strictly related but I believe we will soon have issues with
these, as we will soon cross the 4GiB boundary.

> +        concat-parts =3D <&part0 &part1>;
> +
> +        part0: partition@0 {
> +            label =3D "flash0-part0";
> +            reg =3D <0x0000000 0x100000>;
> +        };
> +
> +        part1: partition@100000 {
> +            label =3D "flash1-part0";
> +            reg =3D <0x0100000 0x200000>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partitions.=
yaml b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> index 1dda2c80747b..86bbd83c3f6d 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
> @@ -32,6 +32,12 @@ properties:
>    '#size-cells':
>      enum: [1, 2]
>=20=20
> +  concat-parts:
> +    description: List of MTD partitions phandles that should be concaten=
ated.
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    minItems: 2
> +    maxItems: 4
> +
>  patternProperties:
>    "^partition(-.+|@[0-9a-f]+)$":
>      $ref: partition.yaml

Fine by me otherwise.

Thanks,
Miqu=C3=A8l

