Return-Path: <linux-spi+bounces-157-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E2980726D
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 15:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECB61F213B9
	for <lists+linux-spi@lfdr.de>; Wed,  6 Dec 2023 14:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E923DBBE;
	Wed,  6 Dec 2023 14:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fG9Xra+R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E4DD44
	for <linux-spi@vger.kernel.org>; Wed,  6 Dec 2023 06:30:15 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50be3eed85aso6314343e87.2
        for <linux-spi@vger.kernel.org>; Wed, 06 Dec 2023 06:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701873013; x=1702477813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecDK9XgOWPDwKNtXxUXDKXSM0zmyupQJGPO18jvHP6A=;
        b=fG9Xra+RRWmWRTGa0vySPcEsTKVcOE51X/E33gXUqlEtZfJlEG9xb2G8QUzpi33dXV
         BUtdqucaZQhhsLhnjnNAdAf8N51BSM1YPVMT9xrRjwED+QGASuVSui+IU37jBRt85tPP
         ZYJqLpbRtYbY2jQSIAd49whUflpitWL9D/vh381gK33IkQdIBYTlhbjDGArN8P1haTep
         sHeUApGcYNsAi2LJxMEW3e6Lba3mBPs+TH00xxX2f0cPv+C6pyZgdncPlaaTUMb4nucV
         bPdXs3WiaEKnaCBFkWb7hwf54LFooICmHGTIRU3JX2Z5/7F4QONrCVGtVix47j3oMTwV
         gp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873013; x=1702477813;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecDK9XgOWPDwKNtXxUXDKXSM0zmyupQJGPO18jvHP6A=;
        b=b9eUfmQ2Zx8IAddqZkOxnYf4FTgftTdUMB+3ZxpTCM/CBn+Xgyi0+K2N3SoYJ5yiXv
         hQBOxYULXRwL0BFIN7k9YQpqGYpOsrupR9PArmSolwHsbme6ck3Jy3JaXavtl5p3bJOH
         +NlWJvQfcuX08fS8WaNq86PBr0vGiglDO5kw4HF6De0jJOzTAchc2JvgraYiJiK8vvZE
         gyxVo8oZJ3mfE74cl8fuDJGpmclAR0kCtq155Wla/nZJJI/Lk5e9Er3TReTsXx3442Br
         s5ZRLnkqMqVK3O8OihLqheP9CH1fXPcdyao3mQULBAt0pLPlQy4rS5Q8qK+MZsKiUneM
         6kyw==
X-Gm-Message-State: AOJu0YzKQNHn9mFnMNoZ9H8Hb45AMv25GPCbNMIGYyxq9mFjaCZv7ZUK
	qYVaMR3m05am7X4RaTYrgB3tNQ==
X-Google-Smtp-Source: AGHT+IFFLwb6J1kg4M4UnYbam4jWK0loSvNCLNafUtgmro7h6iWF18QP/GUyGS9AQ5j9Y3MfsdsiMQ==
X-Received: by 2002:a05:6512:29a:b0:50c:d30:3a05 with SMTP id j26-20020a056512029a00b0050c0d303a05mr695875lfp.25.1701873013467;
        Wed, 06 Dec 2023 06:30:13 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id gs20-20020a170906f19400b00a18374ade6bsm8391001ejb.67.2023.12.06.06.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:30:12 -0800 (PST)
Message-ID: <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
Date: Wed, 6 Dec 2023 14:30:10 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, broonie@kernel.org,
 pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, sbinding@opensource.cirrus.com, lee@kernel.org,
 james.schulman@cirrus.com, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael@walle.cc, linux-mtd@lists.infradead.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, michal.simek@amd.com,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, git@amd.com,
 amitrkcian2002@gmail.com
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Amit,

On 11/25/23 09:21, Amit Kumar Mahapatra wrote:
> Each flash that is connected in stacked mode should have a separate
> parameter structure. So, the flash parameter member(*params) of the spi_nor
> structure is changed to an array (*params[2]). The array is used to store
> the parameters of each flash connected in stacked configuration.
> 
> The current implementation assumes that a maximum of two flashes are
> connected in stacked mode and both the flashes are of same make but can
> differ in sizes. So, except the sizes all other flash parameters of both
> the flashes are identical.

Do you plan to add support for different flashes in stacked mode? If
not, wouldn't it be simpler to have just an array of flash sizes instead
of duplicating the entire params struct?

> 
> SPI-NOR is not aware of the chip_select values, for any incoming request
> SPI-NOR will decide the flash index with the help of individual flash size
> and the configuration type (single/stacked). SPI-NOR will pass on the flash
> index information to the SPI core & SPI driver by setting the appropriate
> bit in nor->spimem->spi->cs_index_mask. For example, if nth bit of
> nor->spimem->spi->cs_index_mask is set then the driver would
> assert/de-assert spi->chip_slect[n].
> 
> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> ---
>  drivers/mtd/spi-nor/core.c  | 272 +++++++++++++++++++++++++++++-------
>  drivers/mtd/spi-nor/core.h  |   4 +
>  include/linux/mtd/spi-nor.h |  15 +-
>  3 files changed, 240 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 93ae69b7ff83..e990be7c7eb6 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c

cut

> @@ -2905,7 +3007,10 @@ static void spi_nor_init_fixup_flags(struct spi_nor *nor)
>  static int spi_nor_late_init_params(struct spi_nor *nor)
>  {
>  	struct spi_nor_flash_parameter *params = spi_nor_get_params(nor, 0);
> -	int ret;
> +	struct device_node *np = spi_nor_get_flash_node(nor);
> +	u64 flash_size[SNOR_FLASH_CNT_MAX];
> +	u32 idx = 0;
> +	int rc, ret;
>  
>  	if (nor->manufacturer && nor->manufacturer->fixups &&
>  	    nor->manufacturer->fixups->late_init) {
> @@ -2937,6 +3042,44 @@ static int spi_nor_late_init_params(struct spi_nor *nor)
>  	if (params->n_banks > 1)
>  		params->bank_size = div64_u64(params->size, params->n_banks);
>  
> +	nor->num_flash = 0;
> +
> +	/*
> +	 * The flashes that are connected in stacked mode should be of same make.
> +	 * Except the flash size all other properties are identical for all the
> +	 * flashes connected in stacked mode.
> +	 * The flashes that are connected in parallel mode should be identical.
> +	 */
> +	while (idx < SNOR_FLASH_CNT_MAX) {
> +		rc = of_property_read_u64_index(np, "stacked-memories", idx, &flash_size[idx]);

This is a little late in my opinion, as we don't have any sanity check
on the flashes that are stacked on top of the first. We shall at least
read and compare the ID for all.

Cheers,
ta

