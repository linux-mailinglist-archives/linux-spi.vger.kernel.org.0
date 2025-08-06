Return-Path: <linux-spi+bounces-9300-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC39B1C2C2
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA84716C665
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9028937A;
	Wed,  6 Aug 2025 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m1h55Hf8"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81052E370A;
	Wed,  6 Aug 2025 09:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471035; cv=none; b=MEfXOcX+0Jww6Q5ARIBIaQdB/e57LgeUIYRpZhpLhU+DgGoxW8IplPxiCED8Qu5CpTAnsIC2Lwp7/IiuwLEqSmCQR51IKVNBFlaCmZTuH7PCtQYdcPQPP3V5d3yKn7Azi4RVrRnJOmkzofB12UTBl5lqjpvRe4Ghlbg20KQwCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471035; c=relaxed/simple;
	bh=vg4Rrt/6beAYpsaDobMRwP84DTVCO2vyvlG9w+YZJx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F2Gq1L4TiyD7JdXh4akldLrlWD3Jyzvv3JNR/OsQRpxC+WUY+gYA87mG8oSHCdhT3AsEv+StuMjZh+mkWgWGTZadyH4CgpE6d4wYxVCeJggiKcmpBPAqH/6KiOH9zwPZAfZShCw+5wKBsMaTfKobrsDjDy8ahMiYwnZNLByb62c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m1h55Hf8; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BC1A42E80;
	Wed,  6 Aug 2025 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754471025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2SJZ+WkY9JJeEOIvvNfCty+u80yCMpablRY/xpxidc=;
	b=m1h55Hf8VZKSJxHXFh9xDevBv211iW+KdfELcDweNdedMwQTyjFCgPBdxYGqo8tRNcQlfR
	81Ub7UJjEPC3WwYXwArokgCufykW4OTShM5w778954lVUssyGkw7XGZ3gmMiauiv+mDvOg
	pGT4fChW9kWLrWG6Mtfdtn3t4cKuK8ahYxRb29T7v0gaO+yHJWWYxfDjICR4JUo8LsaTbL
	2F35PG4l7NzS8EwwWwe14hKyjxQ4ntouLF/5ap4rbNgq5juZwPJ/JcqP/n5SKdKbTE+fHc
	A6vQltP2e0YGTjoYf8Ga5V9B85+7x74zG3ltQasDqI9wWgOLkIwr5fSbUomVfg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Lorenzo Bianconi <lorenzo@kernel.org>,  Ray Liu
 <ray.liu@airoha.com>,  Mark Brown <broonie@kernel.org>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Martin Kurbanov
 <mmkurbanov@salutedevices.com>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/4] drivers: mtd: spi-nand: try a regular dirmap if
 creating a dirmap for continuous reading fails
In-Reply-To: <74646064-0c8c-46b9-8ec3-653c4f80b70f@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Tue, 5 Aug 2025 18:35:32 +0300")
References: <20250804192132.1406387-1-mikhail.kshevetskiy@iopsys.eu>
	<20250804192132.1406387-3-mikhail.kshevetskiy@iopsys.eu>
	<87jz3hhjlj.fsf@bootlin.com>
	<74646064-0c8c-46b9-8ec3-653c4f80b70f@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Wed, 06 Aug 2025 11:03:43 +0200
Message-ID: <87cy98g6ts.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejieegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedugedprhgtphhtthhopehmihhkhhgrihhlrdhkshhhvghvvghtshhkihihsehiohhpshihshdrvghupdhrtghpthhtoheprhhitghhrghrugesnhhougdrrghtpdhrtghpthhtohepvhhighhnvghshhhrsehtihdrtghomhdprhgtphhtthhopehlohhrvghniihosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrgihrdhlihhusegrihhrohhhrgdrtghomhdprhgtphhtthhopegsrhhoohhnihgvs
 ehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtuhguohhrrdgrmhgsrghruhhssehlihhnrghrohdrohhrghdprhgtphhtthhopehmmhhkuhhrsggrnhhovhesshgrlhhuthgvuggvvhhitggvshdrtghomh
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

>>> @@ -1114,11 +1114,32 @@ static int spinand_create_dirmap(struct spinand=
_device *spinand,
>>>=20=20
>>>  	spinand->dirmaps[plane].wdesc =3D desc;
>>>=20=20
>>> -	if (spinand->cont_read_possible)
>>> +	desc =3D NULL;
>>> +	if (spinand->cont_read_possible) {
>>> +		/*
>>> +		 * spi-controllers may return an error if info.length is
>>> +		 * too large
>>> +		 */
>>>  		info.length =3D nanddev_eraseblock_size(nand);
>>> -	info.op_tmpl =3D *spinand->op_templates.read_cache;
>>> -	desc =3D devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
>>> -					  spinand->spimem, &info);
>>> +		info.op_tmpl =3D *spinand->op_templates.read_cache;
>>> +		desc =3D devm_spi_mem_dirmap_create(&spinand->spimem->spi->dev,
>>> +						  spinand->spimem, &info);
>>> +	}
>>> +
>>> +	if (IS_ERR_OR_NULL(desc)) {
>> Here if the problem is continuous reading, I expect an error and not a
>> NULL pointer.
> NULL is possible if flash does not supports continuous reading
>>
>>> +		/*
>>> +		 * continuous reading is not supported by flash or
>> Not by the flash, here if we get an error, it is the spi controller
>> (still without '-' ;) ) that fails (please fix the comment).
>
> we can go here in 2 cases:

Yes, and that is misleading. It feels like the code is unclear this
way. Could we find a better organization?

> 1) spinand->cont_read_possible is false (flash does not supports
> continuous reading)
>
> 2) spi controller returns an error (spi controller does not like
> continuous reading)

Thanks,
Miqu=C3=A8l

