Return-Path: <linux-spi+bounces-6048-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AE29F0AC6
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 12:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2ACD1882260
	for <lists+linux-spi@lfdr.de>; Fri, 13 Dec 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A686C1DE2B8;
	Fri, 13 Dec 2024 11:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LUT8tmpl"
X-Original-To: linux-spi@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F141DDC26
	for <linux-spi@vger.kernel.org>; Fri, 13 Dec 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088832; cv=none; b=XeMF7W4kV/eiK4nFw5bxzRuek0ROjZdKXKM4t9QqHiObtHLltPwIguIXAQideII7aurf3VQa5d/vIgpiKfsZQJSTQhT4YWOumG5m0udUxrHInQV8ZOY2QsFiqLn91NkTEi4dP8U0qOBEzqH3QkWY8c90vV5w2OBLpZA29ruT3BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088832; c=relaxed/simple;
	bh=0Fgij9MPVQPwsbq1isbehcu7BwTg1JnfGMrzXgPyXA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LXsOH78vWDj0U6gi4N3F+VYDHjs1p5b69FGyBMth/mKPnEFw87liP20Zu6TFgGOXDcWp3Z7MCQofNeHqGRMi6OkwyTulD0LiXWTtX2DnnA/toGI4Icm0O6yFmtVqpYEeE8YhU1b6zkkFybVikytDGV48jtQpVpTnLRaxRATL+pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LUT8tmpl; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E38A760003;
	Fri, 13 Dec 2024 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734088827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgs5eEtaoC2aOQnCdg0dxxuEk8iGEvez1t1Gap2xNtg=;
	b=LUT8tmplMj5AlS5Pmj6PujybGRR/KCUjZQg6wtQ5+toJ1LogUfipwMkBK8DGjM1fYSTa3r
	7xdoV0aD+HCtZ+6lsfgJSRj1Ka7QqBYeqW0L+5SBCdkzXaLVrgXiyBs7J0yH6L9QwfR7lR
	q3553a1OhAiRNpE21nuxcnKHPHo46+qjM9tfPrISHEtiKD/h7fy46oGGbpMYWShp4Gx9EA
	uRXkCcTHeIy9jAweI3hmSkcQa0lLjGzkREFWqxnedt+g/3DKpXhSJM061REWHPltQDIIGC
	IU/AMbQQ00uqXV5rydqO9HMrRRJAXzBQ5pc4SQae+dJCmghi1JnV2Te24bWclw==
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
Subject: Re: [PATCH 03/24] spi: amd: Support per spi-mem operation frequency
 switches
In-Reply-To: <64ade17d-3800-4afc-847c-b8e5fc5d7360@linaro.org> (Tudor
	Ambarus's message of "Mon, 11 Nov 2024 13:36:15 +0000")
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
	<20241025161501.485684-4-miquel.raynal@bootlin.com>
	<64ade17d-3800-4afc-847c-b8e5fc5d7360@linaro.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 13 Dec 2024 12:20:25 +0100
Message-ID: <87zfkzn81y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Tudor,

On 11/11/2024 at 13:36:15 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wro=
te:

> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>> Every ->exec_op() call correctly configures the spi bus speed to the
>> maximum allowed frequency for the memory using the constant spi default
>> parameter. Since we can now have per-operation constraints, let's use
>> the value that comes from the spi-mem operation structure instead. In
>> case there is no specific limitation for this operation, the default spi
>> device value will be given anyway.
>>=20
>> This controller however performed a frequency check, which is also
>> observed during the ->check_op() phase.
>>=20
>> The per-operation frequency capability is thus advertised to the spi-mem
>> core.
>>=20
>> Cc: Sanjay R Mehta <sanju.mehta@amd.com>
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>  drivers/spi/spi-amd.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
>> index 2245ad54b03a..f58dc6375582 100644
>> --- a/drivers/spi/spi-amd.c
>> +++ b/drivers/spi/spi-amd.c
>> @@ -368,6 +368,9 @@ static bool amd_spi_supports_op(struct spi_mem *mem,
>>  	    op->data.buswidth > 1 || op->data.nbytes > AMD_SPI_MAX_DATA)
>>  		return false;
>>=20=20
>> +	if (op->max_freq < AMD_SPI_MIN_HZ)
>
> How about using mem->spi->controller->min_speed_hz intead?

Good idea. I think I used AMD_SPI_MIN_HZ to follow what was done
somewhere else, but that's fine.

>
>> +		return false;
>
> I find the check fine here, but I see however that amd_set_spi_freq()
> duplicates the same, returning -EINVAL when speed_hz < AMD_SPI_MIN_HZ

This one is useless, the spi core already takes care of this check, I'll
drop it in a separate patch.

>> +
>>  	return spi_mem_default_supports_op(mem, op);
>>  }
>>=20=20
>> @@ -443,7 +446,7 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
>>=20=20
>>  	amd_spi =3D spi_controller_get_devdata(mem->spi->controller);
>>=20=20
>> -	ret =3D amd_set_spi_freq(amd_spi, mem->spi->max_speed_hz);
>> +	ret =3D amd_set_spi_freq(amd_spi, op->max_freq);
>>  	if (ret)
>>  		return ret;
>
> however the return code is checked just on this call, and completely
> ignored in the 2 other calls. I find the code a bit ugly for the non
> SPIMEM case, but maybe something for the amd owner to address.

Once the above check removed (it does not make much sense there), the
function can return void.

Cheers,
Miqu=C3=A8l

