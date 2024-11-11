Return-Path: <linux-spi+bounces-5676-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172029C4126
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 509F41C20F4B
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2919519F10A;
	Mon, 11 Nov 2024 14:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/hhQHvq"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5073015A84E
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731336065; cv=none; b=AwnqaafhduKOOINZMQorNRAVh/5RbG/OrV3DLbJW1Sfs6t/yzNJCYt7Qxnrw6zTWcA80YgysfjMk+JD5KfgZbYChl0SgRliEjI5Ydt79zn436LqYU2OtWUv7xtCfecpPBEJUQIC+KBdvfcb74pWJvAJRHVBsaxg/dUc7sJzo+LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731336065; c=relaxed/simple;
	bh=gvU2O1sSz1VkPoidEfTxFGdFxo/TK6/eh4HqoW06Q1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZumRy7unLfoktsU1uktVSqmJMuqbrAyUHqUpNGnLnclC/iQMnLrjcvqinGmjF7OI4qBmysQxM1ktZpYSGDlULZX9GDNXkCYsEGmwU9zYCNxWSj5Fukc+pDIbcpwDb2YBeRe4kThlNTPMtm8X/RmXrLvj+gfl0w9BROM+6m+vrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G/hhQHvq; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a99ebb390a5so1040527966b.1
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 06:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731336061; x=1731940861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sBaJwCIVHki56Jj+IDVKoZSEhH2XbB/0VEF5wM/pZg8=;
        b=G/hhQHvqHC5+9YVjTOA52t67EAS93SGSXCF/dfzkmpLtipXIKGfmyZoMqNp+v2tjAu
         NHbjhUW6VVvcIBjY1DO52LvRN2RI24y+ycpw2MMNkzRHVe1v3GZhGRieTd27r/Ny7ywC
         n4D/lv0rfo3TPWbamj/74O4HYjNXdQGo5cagmCgiBN9XZuo/T0cw/znV6WXVOkwYUrlV
         GfOvv2QWxnsXalfZ30uqSoGSMrUrDjESx9Ih2/UfAhoHGlBffxwvgxBv5BsjJZOri9rM
         Xq+n5MVfW1Rz4czF5YZ6AJzsaNcP5giLRTgz/wc9XXvc4BdiEUVET0JnxQUmm59Ej+u5
         BDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731336061; x=1731940861;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBaJwCIVHki56Jj+IDVKoZSEhH2XbB/0VEF5wM/pZg8=;
        b=hW2l3MjoZ1DeWRjmMMfIdSaTdmwoPoqm/HFJojbwXPL48xxB8MtGZ7jun5VuyuIG5E
         My+SUsoDAIa8QBaze/yISR+es1KZpi+X9984f0Tad3RL7wOpIEtm2AFi4pVfZk9H4u1w
         i29jc2zB+zyQ1tAhd3BjZ7Annhyp6ltGAo2bj6z+i0LvLmRWA9d2sYKGXAOL6UR6dlhf
         OUErei29JwsINP0F3pPrTkQI4ri9xbssxGAP4fJP7y2K+0pLmMr3gMI7rEm0ZxAnLWzr
         xbuvHnMPMy6Z2IXV/+dtCON+JSf8nHC7j28HeM7OlLG53whWsCFcpGJiuOvXY/C93HHk
         OHHw==
X-Forwarded-Encrypted: i=1; AJvYcCU/jj28OFY+zpTU+H5HIiEPtyhnZ6nuvZeEHZdPsk3lvgMH5/gBOo/85cosxbL8Yw2VO+VH48yXATk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvm8UVez3b6rjI8wIr16PpdBr60BmPPM//yP/j79h8mLhXMSo
	EFXOLTeB/pO7mpmP8FVrdLxX70KZAeuZ+b8eIEzXEdbyKdzYnBwiZ/lT173+8Oo=
X-Google-Smtp-Source: AGHT+IERR516a4JtGNjcPgZ6V5U2luo4u3jxHu/GNHpqpdnYAcnjwD7hi7RJrs07N2gkwQYHmYO93w==
X-Received: by 2002:a17:907:3ea1:b0:a9a:ca:4436 with SMTP id a640c23a62f3a-a9eec9bf48emr1269661866b.13.1731336061502;
        Mon, 11 Nov 2024 06:41:01 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a176a6sm599070066b.16.2024.11.11.06.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:41:00 -0800 (PST)
Message-ID: <6029a01f-dc4d-4a35-ad21-fd17e3fed9fc@linaro.org>
Date: Mon, 11 Nov 2024 14:40:59 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/24] mtd: spinand: winbond: Add support for DTR
 operations
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 linux-mtd@lists.infradead.org
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-25-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-25-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:15 PM, Miquel Raynal wrote:
> W25N01JW and W25N02JW support many DTR read modes in single, dual and
> quad configurations.
> 
> DTR modes however cannot be used at 166MHz, as the bus frequency in
> this case must be lowered to 80MHz.

ha, what's the benefit then? Aren't we better of with non dtr modes
then? 80 MHz * 2 < 166 MHz?

> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/spi/winbond.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
> index 9e2562805d23..77897a52b149 100644
> --- a/drivers/mtd/nand/spi/winbond.c
> +++ b/drivers/mtd/nand/spi/winbond.c
> @@ -24,10 +24,15 @@
>   */
>  
>  static SPINAND_OP_VARIANTS(read_cache_dtr_variants,
> +		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_DTR_OP(0, 8, NULL, 0, 80 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_X4_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
>  		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_DTR_OP(0, 4, NULL, 0, 80 * HZ_PER_MHZ),
> +		SPINAND_PAGE_READ_FROM_CACHE_X2_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
>  		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
> +		SPINAND_PAGE_READ_FROM_CACHE_DTR_OP(0, 2, NULL, 0, 80 * HZ_PER_MHZ),
>  		SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(0, 1, NULL, 0),
>  		SPINAND_PAGE_READ_FROM_CACHE_OP(0, 1, NULL, 0, 54 * HZ_PER_MHZ));
>  

