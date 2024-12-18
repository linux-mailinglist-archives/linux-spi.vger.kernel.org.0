Return-Path: <linux-spi+bounces-6100-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6D99F61DF
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 10:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D95F1889E44
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 09:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCA01917D9;
	Wed, 18 Dec 2024 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ljKA7q9w"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40CC19CD01
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514443; cv=none; b=I2DIvr7yaY7eU0LeBNIdY4LqmI5Qq/SpHdLQuP3npv/agyiW4njxF1SqFDu0e9/BUcsOL/1nGb1cNr/EZbp61WaCWtUPauB2tfeGTH+1oM2hdRJn7dXhGb7efcyqOgF8MrRU8eFMtbpfSaKY6U0VcGHA6MeSe2svxSP7/qD+cBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514443; c=relaxed/simple;
	bh=N+yudQqu3EweGcHwQ5gLqs3DR+1G67EJPTe2nZcPmGs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Uoc4PFeuNgN/tsdzR3aXSmWQd+Um765pd1SI1bE0J3GChmqwVdXnfIEztzLC/D7p25fjo5unBxy/fPnnfseXWl83rcxWZW7cRZM82HYdzMM0Swaj5lpAciTi9n2i5fZyJ0HYkghRsr0ctDs9yHXmb/pbqi9v8EV0lVcGiNLZhIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ljKA7q9w; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 87FF760004;
	Wed, 18 Dec 2024 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734514431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqsSdcFY6IXV3OPCcBjCkZfAG7HDf4rwQ4pK04TCYsw=;
	b=ljKA7q9wvwJ/MFe13vh9Pb3DhgR8oAH7Liz2i4z7txpkWRHhfZSNSlLWl/r/lX5bC0iV05
	NG68ce8EcWtAN3YzIyAvIJ3ZyyhYpL1LUzfHtthD/2t8iXftNPvIT8hC3iBkBLhHT64urv
	FM0VHvRNPzq02AMDdbDOEeK42i4CDH/0rNK8Uk552igcz4Anf3qb3V1JRFgvzfzW2G14g+
	A2kss3vzjRGozq2aF/NlvUyXWY8JVq2RwqZMfDVDjVeC4taPi/E8CtlhQH//nLmJAiMzA0
	3Ta40e+YiJMT9dwpkSGZjiiH9ijVhCRbAO2CJx3qif664MOAgdOH5maYmiiWpg==
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
In-Reply-To: <e2fcc787-8fb3-4023-af76-c0db3f4b40d6@linaro.org> (Tudor
	Ambarus's message of "Wed, 18 Dec 2024 08:14:36 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-24-miquel.raynal@bootlin.com>
	<71d0cf83-6866-46be-b76f-291a8a6a1346@linaro.org>
	<87wmg3kbxa.fsf@bootlin.com>
	<e2fcc787-8fb3-4023-af76-c0db3f4b40d6@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 18 Dec 2024 10:33:50 +0100
Message-ID: <87pllpe3nl.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 18/12/2024 at 08:14:36 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 12/13/24 12:25 PM, Miquel Raynal wrote:
>> On 11/11/2024 at 14:38:53 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> =
wrote:
>>=20
>>> On 10/25/24 5:15 PM, Miquel Raynal wrote:
>>>> Make the link between the core macros and the datasheet.
>>>>
>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>> ---
>>>>  drivers/mtd/nand/spi/winbond.c | 5 +++++
>>>>  1 file changed, 5 insertions(+)
>>>>
>>>> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/win=
bond.c
>>>> index 686e872fe0ff..9e2562805d23 100644
>>>> --- a/drivers/mtd/nand/spi/winbond.c
>>>> +++ b/drivers/mtd/nand/spi/winbond.c
>>>> @@ -18,6 +18,11 @@
>>>>=20=20
>>>>  #define W25N04KV_STATUS_ECC_5_8_BITFLIPS	(3 << 4)
>>>>=20=20
>>>> +/*
>>>> + * "X2" in the core is equivalent to "dual output" in the datasheets,
>>>> + * "X4" in the core is equivalent to "quad output" in the datasheets.
>>>> + */
>>>
>>> doesn't help great for an outsider like me. Is quad referring to cmd,
>>> addr or data? Or maybe of all? I need to read the code anyway.
>>=20
>> I also don't like these terms. IIRC "output" is referring to the data cy=
cles,
>> otherwise it means address (dummy) and data cycles.
>>=20
>> In single, dual or quad mode the naming is unclear but "okay". But octal
>> DDR modes can require the opcode to be sent in octal mode as well, which
>> is new. If we support that, I'll take care of using a more
>> understandable naming for all macros like Xy-Xy-Xy, X being the
>> buswidth, y being S (sdr) or D (ddr) and the three members being
>
> 8d-8d-8d is common and covered by few standards, yes.
>
>> Command-Address-Data. I might even be tempted to include dummy cycles as
>> well, because it is important to be clear if eg. in octal mode "1" means
>> "1 cycle" or "8 cycles".
> I find the info about dummy cycles useful. I wonder if such terminology
> is already specified in a standard. If not, maybe we can put the dummy
> cycles after the mode, in parenthesis? I would refrain custom terminology.

I see you concern, but would you mind giving an example of what you have
in mind?

Thanks,
Miqu=C3=A8l

