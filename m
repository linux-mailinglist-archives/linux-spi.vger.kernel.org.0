Return-Path: <linux-spi+bounces-6152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EEF9FB492
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 20:08:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959CA165453
	for <lists+linux-spi@lfdr.de>; Mon, 23 Dec 2024 19:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7007BEAC5;
	Mon, 23 Dec 2024 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="if2ua8W6"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED72B1C3BF7
	for <linux-spi@vger.kernel.org>; Mon, 23 Dec 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734980922; cv=none; b=OZlLNxy1oxSPp42nfpscNC5a9D0RSE3Wv04ZoGCBlhvw4VZn9qt6FgyVxPbBleYZuT9xcPEKdOvcGztCIllErzLumouKUeO7cuz4dq6+jWFXrzNOIHCulaQfQ+dNkECkdU1ehstmUi1KKZ5328ZZrozBORJL31c1MgG9BxrODfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734980922; c=relaxed/simple;
	bh=iRe+JXhtAfPFQN5Mx0KSzFJxJkvoZN6LR6pgoVr3jpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X4clRGHI89VN3c03POmy4bHMtbBkzuXe8ijchjVxhsxmeVApYzOE5bWXMhEfWj/Cy8kJHMqzkOTM5cuWyztJpR5GF1PJY7cb4XefqGIxijgjwGRo8AegopRI45oYQn73rcapGTbVg9+TFr/2MTlI+AnJUWaFHQqSpbbWGThdvZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=if2ua8W6; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4668FC0004;
	Mon, 23 Dec 2024 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734980918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqURXi3l46EDvS3X4w9AsKnpPDUaild06xBnrpCyckU=;
	b=if2ua8W6RHeDTM+5FSbytQdCWM4SlaT8RVKn8OTnrOSFEb0lq/cjCbrhlAcprQYjIiRSs1
	9rYUupBKoUauJABn7lkq53QF2iEX1s7+EwiZp6nhda+WJii5HWv+WtMLBT1H6bwlKRuDqf
	ug/5GlsaMHUWA0DDnrFM86S9eJd5JthB9vMY5QKOAoV4CsvVhRBtCgyv7kPDRvhqrMcRap
	EuPPmp0vR4caJvzNVfOcZ5bszW6qtslwdJZ2eO+zHj6swSpv0Pe1S8Bph9sAJRonw0FLQe
	1zZgaGxjk/sHPFbTMhxfKBVAoj8AxJhhVq3Rbmi2bYqc9L3t128JI5EmvIXFAA==
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
Subject: Re: [PATCH 01/24] spi: spi-mem: Extend spi-mem operations with a
 per-operation maximum frequency
In-Reply-To: <8738dbbc-e2a9-49dc-9234-65de6435bc45@linaro.org> (Tudor
	Ambarus's message of "Wed, 18 Dec 2024 10:13:39 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-2-miquel.raynal@bootlin.com>
	<e76ff30b-342e-4e4c-aa84-40312c3ffc72@linaro.org>
	<87jzc3oo6g.fsf@bootlin.com>
	<01f1bddd-7aee-4c90-9fa0-3b94c87eb469@linaro.org>
	<878qsde3i4.fsf@bootlin.com>
	<d12cc014-1e59-455e-8ee4-202997ddf846@linaro.org>
	<8738dbbc-e2a9-49dc-9234-65de6435bc45@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 23 Dec 2024 20:08:35 +0100
Message-ID: <878qs6rzd8.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello,

On 18/12/2024 at 10:13:39 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 12/18/24 10:03 AM, Tudor Ambarus wrote:
>>=20
>>=20
>> On 12/18/24 9:37 AM, Miquel Raynal wrote:
>>> On 18/12/2024 at 08:07:24 GMT, Tudor Ambarus <tudor.ambarus@linaro.org>=
 wrote:
>>>
>>>> On 12/13/24 10:46 AM, Miquel Raynal wrote:
>>>>> Hello Tudor,
>>>>>
>>>>
>>>> Hi!
>>>>
>>>>> On 11/11/2024 at 13:07:09 GMT, Tudor Ambarus <tudor.ambarus@linaro.or=
g> wrote:
>>>>>
>>>>>> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>>>>>>
>>>>>> cut
>>>>>>
>>>>>>>
>>>>>>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>>>>>>> index 17b8baf749e6..ab650ae953bb 100644
>>>>>>> --- a/drivers/spi/spi-mem.c
>>>>>>> +++ b/drivers/spi/spi-mem.c
>>>>
>>>> cut
>>>>
>>>>>>> +	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
>>>>>>> +		((struct spi_mem_op *)op)->max_freq =3D mem->spi->max_speed_hz;
>>>>>>
>>>>>> not a big fan of casting the const out. How about introducing a
>>>>>> spi_mem_adjust_op_freq()? The upper layers will use that were needed,
>>>>>> and you'll still be able to pass a const op to spi_mem_exec_op()
>>>>>
>>>>> I know it is not ideal so to follow your idea I drafted the use of
>>>>> spi_mem_adjust_op_freq(). In order to avoid the cast, we actually need
>>>>> to call this function everywhere in the core and the drivers to make
>>>>> sure we never get out of bounds, but here is the problem:
>>>>>
>>>>>     $ git grep -w spi_mem_exec_op -- drivers/ | wc -l
>>>>>     42
>>>>>
>>>>> This approach requires to add a call to spi_mem_adjust_op_freq() befo=
re
>>>>> *every* spi_mem_exec_op(). Yes I can do that but that means to be very
>>>>> attentive to the fact that these two functions are always called
>>>>> together. I am not sure it is a good idea.
>>>>>
>>>>> What about doing the following once in spi_mem_exec_op() instead?
>>>>>
>>>>>     spi_mem_adjust_op_freq(desc->mem, (struct spi_mem_op *)op);
>>>>>
>>>>> I know we still have a cast, but it feels more acceptable than the on=
e I
>>>>> initially proposed and covers all cases. I would not accept that in a
>>>>> driver, but here we are in the core, so that sounds acceptable.
>>>>>
>>>>> Another possibility otherwise would be to drop the const from the
>>>>> spi_mem_op structure entirely. But I prefer the above function call.
>>>>
>>>> How about introducing a spi_nand_spimem_exec_op() where you call
>>>> spi_mem_adjust_op_freq() and spi_mem_exec_op()?
>>>
>>> That would work to make the cast disappear but TBH would not be totally
>>> relevant as adjusting the frequency is typically something that would
>>> benefit to spi-nor as well (maybe in the future) and therefore would
>>=20
>> Right, SPI NOR will benefit of this too.
>>=20
>>> fully apply to spi memories as a whole, not just spi-nand. We can think
>>> about another naming maybe, but I find like spi_mem_exec_op() is the
>>> right location to do this.
>>>
>>=20
>> It's not the first time that we adjust spi_mem_op parameters, see:
>> https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/tree/drive=
rs/mtd/spi-nor/core.c?h=3Dspi-nor/next#n153
>>=20
>> Does SPI NAND need to call spi_mem_adjust_op_size as well? I see it
>> calls it when using dirmap, but not with a plain spi_mem_exec_op().
>>=20
>
> I ask because I'm thinking of adding in the SPIMEM core a prepare()
> method, and maybe rename exec_op() to exec(). And then introduce a
> prepare_exec() method that the upper layers would call? Similar to
> clk_prepare_enable.

Do you have something else in mind you would like to put in the prepare
step? I am not at all opposed to it, but I feel like for now the
spi_mem_exec_op() is a fine path for that, especially since there are
very little things to "prepare" (for now).

Do you mind if I keep the cast (not the one from the series, I cleaned
that up to have an adjust_op function as discussed) for now, and if you
ever go the prepare/exec path we would get this converted to use the new
API? I'd like to make progresses on other topics in the spi-nand core
and avoid being blocked by a bigger task that we need to discuss first.

Cheers,
Miqu=C3=A8l

