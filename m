Return-Path: <linux-spi+bounces-4012-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9503E93D393
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BA91C2353E
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2024 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16BD17B51E;
	Fri, 26 Jul 2024 12:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b="YZdNMN0d"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9717B511;
	Fri, 26 Jul 2024 12:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.201.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998541; cv=none; b=hmfMr6FDfKFUwfdrIfoS/fXMwzmU3hDHwCshuoABsg5K8EP3VoE6h9wcA74GYs1noOe7rZiNPAxSQOqsp51VNYKVkCC+8Ho4AcdF4HVSj1NlGX154mrJ3ZmJkJGHqLR//XLbzO8mRrYYs3qy0coHcnOyT2gN3uSl/n48mc+1de8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998541; c=relaxed/simple;
	bh=yzOx6oM1nG1syyzmhuVhnMa728h4vx7kNlsuELDiy+4=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:References:
	 In-Reply-To; b=ioOUnjYtBbhCYXTftSW1mD4Uvsls6E1fCVBR5o7hEv53uUoTgIc3NQBO6e6x1247GNsVqiCpCNCywSXJANGpP9qwGiH+AqH4qJdSLmnPBHVmY1WkVdsLwepSWh57Z0nPqoakBMrO1bIuwXtfJhYZ40g/UzwXLFajEHvEqfKNPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc; spf=pass smtp.mailfrom=walle.cc; dkim=pass (2048-bit key) header.d=walle.cc header.i=@walle.cc header.b=YZdNMN0d; arc=none smtp.client-ip=159.69.201.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=walle.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=walle.cc
Received: from localhost (unknown [213.135.10.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id A8D4D3C3;
	Fri, 26 Jul 2024 14:55:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
	t=1721998530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=yzOx6oM1nG1syyzmhuVhnMa728h4vx7kNlsuELDiy+4=;
	b=YZdNMN0dE0uA7FnFXFdQTZc+gmQ70zEsvC94v1Q86rzibdNqDnJL5nrE5j8IB/b+AFTBzz
	Dt4IzhB9GH0pF8coLguAkhMykHFlDxsb7IQC+qSUYMRZcp5e5A77Zwq5byUEB5RusCBMwr
	7nlQc4/EIUzYkfbtqzGPcbrGikt6KKZioI14gpIIONVciaCFyrxrt33p0iZf5x4gZyx7YU
	U9OhZkBEgbYpE+W5LeXEPVV77ZZltUaVXsCYdDgDQq2CdX7+I45vXmnPFxI0vBpvf2FPAa
	fZ6T9AmMoYOvGazPddd7C7Lge7dhToJFuw15hwDu68RIEENxFamVE+FGrITgFg==
Content-Type: multipart/signed;
 boundary=3ce0a5c807a2ece26c72ec8034eaad1072585a573fd66fa563151480afdc;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Fri, 26 Jul 2024 14:55:28 +0200
Message-Id: <D2ZHJ765LUGP.2KTA46P1BL75X@walle.cc>
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>, "Simek, Michal"
 <michal.simek@amd.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
 <alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
 <patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
 <linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "beanhuo@micron.com" <beanhuo@micron.com>
From: "Michael Walle" <michael@walle.cc>
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>, "Tudor Ambarus"
 <tudor.ambarus@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>, "miquel.raynal@bootlin.com"
 <miquel.raynal@bootlin.com>, "richard@nod.at" <richard@nod.at>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "sbinding@opensource.cirrus.com"
 <sbinding@opensource.cirrus.com>, "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>, "perex@perex.cz"
 <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
X-Mailer: aerc 0.16.0
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com> <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org> <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com> <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org> <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com> <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org> <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org> <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org> <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com> <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org> <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com> <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org> <9cdb7f8b-e64f-46f6-94cb-194a25a42ccd@linaro.org>
 <BN7PR12MB28028B63E69134094D50F3E4DC2A2@BN7PR12MB2802.namprd12.prod.outlook.com> <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
In-Reply-To: <
 <IA0PR12MB769944254171C39FF4171B52DCB42@IA0PR12MB7699.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

--3ce0a5c807a2ece26c72ec8034eaad1072585a573fd66fa563151480afdc
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

> Based on the inputs/suggestions from Tudor, i am planning to add a new=20
> layer between the SPI-NOR and MTD layers to support stacked and parallel=
=20
> configurations. This new layer will be part of the spi-nor and located in=
=20
> mtd/spi-nor/

Will AMD submit to maintain this layer? What happens if the
maintainer will leave AMD? TBH, personally, I don't like to
maintain such a niche feature.
I'd really like to see some use cases and performance reports for
this, like actual boards (and no evaluation boards don't count). Why
wouldn't someone just use an octal flash?

And as already mentioned there is also mtdcat, which seems to
duplicate some features?

-michael

--3ce0a5c807a2ece26c72ec8034eaad1072585a573fd66fa563151480afdc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKcEABMJAC8WIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCZqOcwREcbWljaGFlbEB3
YWxsZS5jYwAKCRASJzzuPgIf+OcUAX9IjhR2BCZQ3HqidzuFStguMrN9iUIuss1D
/ACvRq7kf2Zbxhm0mck1AjUfrnZR1eABf0SfkJW5GxxyiY5HbWtKSnCVoTuXKQTM
LqmzqtPHKs+pr9bhbYutKEnQZiOlOyW93g==
=jfd2
-----END PGP SIGNATURE-----

--3ce0a5c807a2ece26c72ec8034eaad1072585a573fd66fa563151480afdc--

