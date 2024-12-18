Return-Path: <linux-spi+bounces-6102-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D759F61E4
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 10:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1858118826F2
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3FE1547FF;
	Wed, 18 Dec 2024 09:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oHJB1j0N"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AB6165F16
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514634; cv=none; b=qjvm7BTTrliJHk8v1Rhkkd4DqXS9DZOnxyV76jjaQPV7+j5vIitnlSCk0qZslOlaVI78UFYzD8YiezIkcT3ir3VyQUG+rX6lcMC0lCl14Nh96QwmuyPk1nQ1YC2y1hhAUzgsGpRbgqiR82MY4DMitu9lDFrWTeP1HVgYEgoeLWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514634; c=relaxed/simple;
	bh=iUT5858rch9M7Sg8O/K72uKn0NAjabVvCmA5p9+Optg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zi6pEufD+SbIwzOxwB9rB7yhKuV67M17CCu7hDyGgPW9qMtemIovN4j6IIKwZe9yHeyq35DOShk4EFKQBvEGPmVunS4V5bUgozmcxv7z42XfNl0h4SlG1yptAXTOLzAq/4FycmWWUDCY5BMKI7rCWx+j89Gyf9EMd3mAN7TF2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oHJB1j0N; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 27210C0004;
	Wed, 18 Dec 2024 09:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734514630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IUfVG2ymBHDabdRbkyKDirMaGDsjbAhvPisQo1LMTg=;
	b=oHJB1j0NtAv+D4tmGyxnlDfgk+1kCVB/U6Zvzj5lmg8BFgIWR5HFLrsSzYBNySAFeRkzCn
	YAqJCAxsKdkoLcWZEX7+0VsZ89enQFWr+TgQ0QfSa2k0grs8B8efKr28p7L5RNvsrdkZOH
	PPVG+sVGVSolJDVndBqRRUvHX1xJbm5nBvgqmjiEQ7EsoOpd6u4A9iIVNkAn5b/JlCiwRR
	UGh8ivWr56F4v5VkwKPmFcYQ5sJIwQ0veXUGZoE2H0HKYO9wnSqOGYw7gR/EGRfcR+G1hs
	CjkxiSJ2Lf7giY5SnIwPOltUrU/Q+ac2636S0yFf93jnED9eEpt1Ejc3KwRM8g==
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
In-Reply-To: <01f1bddd-7aee-4c90-9fa0-3b94c87eb469@linaro.org> (Tudor
	Ambarus's message of "Wed, 18 Dec 2024 08:07:24 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-2-miquel.raynal@bootlin.com>
	<e76ff30b-342e-4e4c-aa84-40312c3ffc72@linaro.org>
	<87jzc3oo6g.fsf@bootlin.com>
	<01f1bddd-7aee-4c90-9fa0-3b94c87eb469@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 18 Dec 2024 10:37:07 +0100
Message-ID: <878qsde3i4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

On 18/12/2024 at 08:07:24 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 12/13/24 10:46 AM, Miquel Raynal wrote:
>> Hello Tudor,
>>=20
>
> Hi!
>
>> On 11/11/2024 at 13:07:09 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> =
wrote:
>>=20
>>> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>>>
>>> cut
>>>
>>>>
>>>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>>>> index 17b8baf749e6..ab650ae953bb 100644
>>>> --- a/drivers/spi/spi-mem.c
>>>> +++ b/drivers/spi/spi-mem.c
>
> cut
>
>>>> +	if (!op->max_freq || op->max_freq > mem->spi->max_speed_hz)
>>>> +		((struct spi_mem_op *)op)->max_freq =3D mem->spi->max_speed_hz;
>>>
>>> not a big fan of casting the const out. How about introducing a
>>> spi_mem_adjust_op_freq()? The upper layers will use that were needed,
>>> and you'll still be able to pass a const op to spi_mem_exec_op()
>>=20
>> I know it is not ideal so to follow your idea I drafted the use of
>> spi_mem_adjust_op_freq(). In order to avoid the cast, we actually need
>> to call this function everywhere in the core and the drivers to make
>> sure we never get out of bounds, but here is the problem:
>>=20
>>     $ git grep -w spi_mem_exec_op -- drivers/ | wc -l
>>     42
>>=20
>> This approach requires to add a call to spi_mem_adjust_op_freq() before
>> *every* spi_mem_exec_op(). Yes I can do that but that means to be very
>> attentive to the fact that these two functions are always called
>> together. I am not sure it is a good idea.
>>=20
>> What about doing the following once in spi_mem_exec_op() instead?
>>=20
>>     spi_mem_adjust_op_freq(desc->mem, (struct spi_mem_op *)op);
>>=20
>> I know we still have a cast, but it feels more acceptable than the one I
>> initially proposed and covers all cases. I would not accept that in a
>> driver, but here we are in the core, so that sounds acceptable.
>>=20
>> Another possibility otherwise would be to drop the const from the
>> spi_mem_op structure entirely. But I prefer the above function call.
>
> How about introducing a spi_nand_spimem_exec_op() where you call
> spi_mem_adjust_op_freq() and spi_mem_exec_op()?

That would work to make the cast disappear but TBH would not be totally
relevant as adjusting the frequency is typically something that would
benefit to spi-nor as well (maybe in the future) and therefore would
fully apply to spi memories as a whole, not just spi-nand. We can think
about another naming maybe, but I find like spi_mem_exec_op() is the
right location to do this.

Thanks,
Miqu=C3=A8l

