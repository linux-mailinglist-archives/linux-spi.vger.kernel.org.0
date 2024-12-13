Return-Path: <linux-spi+bounces-6046-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA59F0A01
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 11:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8DDF188CB60
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 10:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C11AB6C9;
	Fri, 13 Dec 2024 10:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vn0yJgrp"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE41C3BEE
	for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2024 10:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086817; cv=none; b=gjzln4DKUn95f5fGkxODdSko0YhOMfXu5khiCChwX0lSIoQbLXvVsFinUYPoxHnd1z/SfXXqacha1ClFtDIOqzo33lAizBUv2aSzfY41kZhOg5+tBxqew4BSkR4Cwv8/QO2d0N/EkOI10NgvKkTPF6c4hi9GF8vPCkzHSerHVGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086817; c=relaxed/simple;
	bh=VupM70urEAyH1Pawo4DcTxSzDfuexB1nqBKNq4BEaFs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SpiHaIL37uHXB2XVcLthcqGipyruPdHxdY6b9PGnzNuRkbV1mySienMXQYfb/BqC4d2tcJSfGmgTG/Vu7Z2VGj6TyD7Xmuq3q3aBGN+oR7GXvb1ZyhPZE5mEMHDYNxsRrhk9WI8zwvl5RREzFOI4fX5ETqqHvn23a1HNgEofb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vn0yJgrp; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5DCF0FF803;
	Fri, 13 Dec 2024 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734086812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpv1f4d1Denqxrkp/DJziBw32IQoHhesGRzVxzzRqrc=;
	b=Vn0yJgrpJ9sNCTp7+S8LY7raiq1WrUd2hXY2cTBL7DjOSfWLycK4rvw3Kmz2dn1KY0q/Mp
	ws2NecT6ZCuNjrzw2z6GBQMyDM8mh40radLnItljyIj8PWR1zGlVFY1RO3C6Ll3m+Z344Q
	TIejjkeCxx7e97oRmQTOiAahqJVUi6fjDF52InsR3FxU9vSAAttjtaogq7YsxHI4epDElL
	TazyINj/HTI/Z60GJamPFt3LU3RRecazS/fzdzGYuGgj3D+K+gA39xX0UuaiRdSUAUGYzm
	knCmP2zaqRA4ql4U+iHZh8Ow42HIFFz+mst5RuvVBSOf1sklgc7eW0+DuAGfhQ==
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
In-Reply-To: <e76ff30b-342e-4e4c-aa84-40312c3ffc72@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 13:07:09 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-2-miquel.raynal@bootlin.com>
	<e76ff30b-342e-4e4c-aa84-40312c3ffc72@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 13 Dec 2024 11:46:47 +0100
Message-ID: <87jzc3oo6g.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hello Tudor,

On 11/11/2024 at 13:07:09 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>
> cut
>
>>=20
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 17b8baf749e6..ab650ae953bb 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -356,6 +356,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struc=
t spi_mem_op *op)
>>  {
>>  	unsigned int tmpbufsize, xferpos =3D 0, totalxferlen =3D 0;
>>  	struct spi_controller *ctlr =3D mem->spi->controller;
>> +	unsigned int xfer_speed =3D op->max_freq;
>
> be aware that for controllers that don't support SPIMEM ops, you pass
> the frequency from the upper layers, without adjusting it with
> spi->max_speed_hz. Was this intentional?

That is exactly the opposite of what I wanted to achieve
initially. That's a very good catch.

>>  	struct spi_transfer xfers[4] =3D { };
>>  	struct spi_message msg;
>>  	u8 *tmpbuf;
>> @@ -368,6 +369,9 @@ int spi_mem_exec_op(struct spi_mem *mem, const struc=
t spi_mem_op *op)
>>  	if (!spi_mem_internal_supports_op(mem, op))
>>  		return -EOPNOTSUPP;
>>=20=20
>> +	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
>> +		((struct spi_mem_op *)op)->max_freq =3D mem->spi->max_speed_hz;
>
> not a big fan of casting the const out. How about introducing a
> spi_mem_adjust_op_freq()? The upper layers will use that were needed,
> and you'll still be able to pass a const op to spi_mem_exec_op()

I know it is not ideal so to follow your idea I drafted the use of
spi_mem_adjust_op_freq(). In order to avoid the cast, we actually need
to call this function everywhere in the core and the drivers to make
sure we never get out of bounds, but here is the problem:

    $ git grep -w spi_mem_exec_op -- drivers/ | wc -l
    42

This approach requires to add a call to spi_mem_adjust_op_freq() before
*every* spi_mem_exec_op(). Yes I can do that but that means to be very
attentive to the fact that these two functions are always called
together. I am not sure it is a good idea.

What about doing the following once in spi_mem_exec_op() instead?

    spi_mem_adjust_op_freq(desc->mem, (struct spi_mem_op *)op);

I know we still have a cast, but it feels more acceptable than the one I
initially proposed and covers all cases. I would not accept that in a
driver, but here we are in the core, so that sounds acceptable.

Another possibility otherwise would be to drop the const from the
spi_mem_op structure entirely. But I prefer the above function call.

>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index f866d5c8ed32..8963f236911b 100644
>> --- a/include/linux/spi/spi-mem.h
>> +++ b/include/linux/spi/spi-mem.h
>> @@ -68,6 +68,9 @@ enum spi_mem_data_dir {
>>  	SPI_MEM_DATA_OUT,
>>  };
>>=20=20
>> +#define SPI_MEM_OP_MAX_FREQ(__freq)				\
>> +	.max_freq =3D __freq
>> +
>>  /**
>>   * struct spi_mem_op - describes a SPI memory operation
>>   * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opc=
ode is
>> @@ -95,6 +98,9 @@ enum spi_mem_data_dir {
>>   *		 operation does not involve transferring data
>>   * @data.buf.in: input buffer (must be DMA-able)
>>   * @data.buf.out: output buffer (must be DMA-able)
>> + * @max_freq: frequency limitation wrt this operation. 0 means there is=
 no
>> + *	      specific constraint and the highest achievable frequency can be
>> + *	      attempted).
>
> nit: you close a parenthesis without opening one

Corrected!

Thanks for this very useful feedback!
Miqu=C3=A8l

