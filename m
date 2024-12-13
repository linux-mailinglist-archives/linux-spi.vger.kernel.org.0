Return-Path: <linux-spi+bounces-6053-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1239F0C30
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 13:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392B5286563
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 12:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AF1DACA9;
	Fri, 13 Dec 2024 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DrirYdF4"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435DB1DF728
	for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734092712; cv=none; b=ZNbTefjCqEHiyCrK9b3qWFvjsOwZJxAxVIpf7KOH09Kz/6Ny7Hl0zBPXN4X5+jY6yoQoRfjKRokXyTOzI+DQ6uYOeT5et/sI3XZdnamC1+G5U4biN1EcVucSkMn29L52XssFOJ4mxKl61PKBuBYv6DRC759EsAVOFRiKi0P9cMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734092712; c=relaxed/simple;
	bh=T/jZVWUL0CozcpZgM2g8YaRZ9vjLeZmPCIR7ligyJ4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2shGciap9Gc1FtfFbC/0rdxh6/CciNxccQ6vPRM/hOP1UymhAgS9Uqdf2zwXcNbM66xIaq3vIFt8mo8wu6Nz79zaCMArbnx9jUBySdN+uuDuto3XQPHmeJTr1e/z/O7nfuXI273gpjQuyz64Ec4KL06S3p3iBlhcMkLjC9jFkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DrirYdF4; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8D15D1C0007;
	Fri, 13 Dec 2024 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734092708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNkaMwOFTWL7O+KUqEytGfx0AzC6/gMcfU1OW6erpzY=;
	b=DrirYdF4kTOc3fSbEvnJNIPlHYrhjdTXkNZKYFS4B0TJXaU000F+K1qNviss930aApyh2R
	a1ra3bGm2m2UDBNfCvM8QkuQw+ogONPyjaVuGeLo19oUkbziI4+uKzKqHEVd45Iw0rBfQ0
	CnN2o/d57+rqgZXXh7ldlxYd8M7Z/KZUuxpJtEgG4omgn2gDFECKcvFNxo2kxJd3JbegDi
	Iw+eyv0p406urMh6fX3tthzzOp3YhpbkC/VZ8F5BedWxLcAOHi3gYVrw/01MpgS5BjnQVx
	RgPL6wq4V7LjD+ls26Ze3yeN/nRXZ9f3N4wmqICwb2dMEw1jNmz+pT9X/PCLYw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,  Michael Walle
 <michael@walle.cc>,  linux-mtd@lists.infradead.org,  Mark Brown
 <broonie@kernel.org>,  linux-spi@vger.kernel.org,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  Sanjay R Mehta <sanju.mehta@amd.com>,  Han Xu <han.xu@nxp.com>,  Conor
 Dooley <conor.dooley@microchip.com>,  Daire McNamara
 <daire.mcnamara@microchip.com>,  Matthias Brugger
 <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>,  Haibo Chen
 <haibo.chen@nxp.com>,  Yogesh Gaur <yogeshgaur.83@gmail.com>,  Heiko
 Stuebner <heiko@sntech.de>,  Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH 23/24] mtd: spinand: winbond: Add comment about naming
In-Reply-To: <71d0cf83-6866-46be-b76f-291a8a6a1346@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 14:38:53 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-24-miquel.raynal@bootlin.com>
	<71d0cf83-6866-46be-b76f-291a8a6a1346@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 13 Dec 2024 13:25:05 +0100
Message-ID: <87wmg3kbxa.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 11/11/2024 at 14:38:53 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/25/24 5:15 PM, Miquel Raynal wrote:
>> Make the link between the core macros and the datasheet.
>>=20
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/mtd/nand/spi/winbond.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbo=
nd.c
>> index 686e872fe0ff..9e2562805d23 100644
>> --- a/drivers/mtd/nand/spi/winbond.c
>> +++ b/drivers/mtd/nand/spi/winbond.c
>> @@ -18,6 +18,11 @@
>>=20=20
>>  #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
>>=20=20
>> +/*
>> + * "X2" in the core is equivalent to "dual output" in the datasheets,
>> + * "X4" in the core is equivalent to "quad output" in the datasheets.
>> + */
>
> doesn't help great for an outsider like me. Is quad referring to cmd,
> addr or data? Or maybe of all? I need to read the code anyway.

I also don't like these terms. IIRC "output" is referring to the data cycle=
s,
otherwise it means address (dummy) and data cycles.

In single, dual or quad mode the naming is unclear but "okay". But octal
DDR modes can require the opcode to be sent in octal mode as well, which
is new. If we support that, I'll take care of using a more
understandable naming for all macros like Xy-Xy-Xy, X being the
buswidth, y being S (sdr) or D (ddr) and the three members being
Command-Address-Data. I might even be tempted to include dummy cycles as
well, because it is important to be clear if eg. in octal mode "1" means
"1 cycle" or "8 cycles".

>> +
>>  static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
>>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),

Thanks,
Miqu=C3=A8l

