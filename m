Return-Path: <linux-spi+bounces-8609-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFC9ADBD64
	for <lists+linux-spi@lfdr.de>; Tue, 17 Jun 2025 01:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811DF1754F3
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 23:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18502264CF;
	Mon, 16 Jun 2025 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jINVkrGZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255A2264C4
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 23:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750115442; cv=none; b=JAMl7nRKM+mk6BIiZdW6w3l945C3OYsE6k7cW1l6Cas01u2ri6qpkCOyYaOrbc/oJmEovajHyF/9bimcZUBkZ4P1RNEroNd0Opyq1ayJtIaB8PVjIOra8GM+vkEumItveJFfcSuHCdY++qE8Y7kzxs66YfI2UQp4IgfqXJKw6tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750115442; c=relaxed/simple;
	bh=Sg/Zeim155lPoBlFzQfHz+7xJEIx+3K9aJFJCsa+t9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q8kVoSD+sT7f5cZruY97Pu4qc3185rFxiCukWifdQJ+5MkZ+A56wfMoiUj58jUQPfxON03349PG8XjZpI7/I0uNZmV9U+KMiyqJIxjx7K6jsYVqYQzqHx8ebeQPfMtCWxPfgRiRgmENUPKyuS8j7iVp/LHCQTLPGtmJ18t8nQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jINVkrGZ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7382ffcb373so2656097a34.0
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 16:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750115438; x=1750720238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZhqwSDdN0As9EP8iCCAnsHFrVsuS6BmzZLRtm9F+Ab4=;
        b=jINVkrGZBWazZCfJTImqGL6jTnWdvwBZ+0zBKRsaphS95mW8HkhAXJGBuVf3nqR5VJ
         B+09AiZPh+XRbbkKVNbCzrvnvFSpU+Qj6yy7SQVUapFXBupuIoQBtTFd740OwN2uofSA
         33zLhZf/YGbx3iH6wyxxoSF1NqngJ83IXCS5aqin5SEy4OqG8C/dVlwUuaSgcSOXbuIs
         iSL+CcL5OQ+2tdMUXTevIJxB7hI1ziXD2Au1rUUqU+ttKkp5r2+mncYvp5tU/zyzYtJl
         eRtZ7qzQhx0VqYcQtzSrlTlwlyXdxS2GNROl1qK/BdI5Vx3zlztjVkJEOwekR4+xGdiX
         HelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750115438; x=1750720238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhqwSDdN0As9EP8iCCAnsHFrVsuS6BmzZLRtm9F+Ab4=;
        b=uoja+F4J4RmlCrON1N9XZVYrg0+MCO07mE9IRvYZ1Y4GE2hLHh0GDxANDiLI56bIAW
         eSd7KsGGNoQ5L0O4XxjL/vFVkUU9hYdDloht/483jNti40bqBz6c0ea52itPWHtgyz6c
         jXBa2hnDVdP0Y5ihbR0eCyv0UXPAhgdSzIih15tDn83XKeXcDG/1R9WKHXmHlujOJ9I/
         V3LdrMPcT0vi9LPjYbjAUnkXQ2xhj5Xt1OTVAQ4rrhsKaPESqVyVGByoO0vbcFSnVIXG
         fxOSPserBH5c9D/lsqkbtsBsV5tjFlfJgUYvrMW7sXr6FbA9/S4pHv03HpZKChM/C6YF
         /Zcg==
X-Forwarded-Encrypted: i=1; AJvYcCWayvgDWUysGhBEx0Xx4aDM7RvgkXhw5dZFJffeUIclDQq2m9FoFLfwGxxwGb0IyyRUWaBIw+4ztbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgsMaLxNQ249ecibdV/CIqMcDnd6OQgkqBxnzvIcz6lquNczoz
	8YcnjJowgiZzX8PwWjmM4XxyZxoZe1c0Fv1iAhyUUkUsQWqsTKMPtNq7ikLwxfTYwlI=
X-Gm-Gg: ASbGnctNxzt6De4JZSMUGU9MC5c6EyZHQ+LxyvLZmiqmZoJ3ZEnus6ydFV4JLYzpZFM
	fsWwqKXqpsXxVhFfYlNywa2OPql0RiUusGucQbhCYSdWt6lxYTY5fZ1AOk0Sfe3u5HnLoDD+qDs
	cbPhwKBFB+kDCXnultaqObegGDdwzkQ0bI2Cs+HDxtmsyP6OivAD4Ki2kYxcjkLE4hCyai5y6TB
	GLkv4Oxm42nEc+9WjYB1mACOoVpwLfK8I/pPtC+upalKq2qfzKn8mjUp9/tOSdY6ctq+6k6fFlD
	8UDiCQM6tuUCHyTQqld3/KWdgWiyNIhXprv52T5mEm1Cl10Le1quUZlz+TBhZLWqUYjT1ILrrLL
	TDxtVEwSNXlNuxniLOGLF3fKG7VpkTAs1OtXDsNY=
X-Google-Smtp-Source: AGHT+IEWczTOKpxrX7Kq4OJFYfDdAA9v5c0yaK836ViXrpfcsn3PHuwhhvfHdkmxcH18lsKBAQA0YA==
X-Received: by 2002:a05:6830:2908:b0:739:fe04:7aec with SMTP id 46e09a7af769-73a363ed869mr7767099a34.26.1750115438134;
        Mon, 16 Jun 2025 16:10:38 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9583:1e37:58ed:10ae? ([2600:8803:e7e4:1d00:9583:1e37:58ed:10ae])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a28554581sm1377254a34.61.2025.06.16.16.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 16:10:37 -0700 (PDT)
Message-ID: <e4d80845-ddf4-487a-8ad4-c9429eccea4c@baylibre.com>
Date: Mon, 16 Jun 2025 18:10:36 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] spi: zynqmp-gqspi: Support multiple buses
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-6-sean.anderson@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250616220054.3968946-6-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 5:00 PM, Sean Anderson wrote:
> Currently, selection of the upper/lower buses is determined by the
> chipselect. Decouple this by allowing explicit bus selection through the
> spi-buses property.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - New
> 
>  drivers/spi/spi-zynqmp-gqspi.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 595b6dc10845..add5eea12153 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -465,13 +465,13 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
>  	genfifoentry |= GQSPI_GENFIFO_MODE_SPI;
>  
>  	if (!is_high) {
> -		if (!spi_get_chipselect(qspi, 0)) {
> -			xqspi->genfifobus = GQSPI_GENFIFO_BUS_LOWER;
> +		xqspi->genfifobus =
> +			FIELD_PREP(GQSPI_GENFIFO_BUS_MASK, qspi->buses);
> +		if (!spi_get_chipselect(qspi, 0))
>  			xqspi->genfifocs = GQSPI_GENFIFO_CS_LOWER;
> -		} else {
> -			xqspi->genfifobus = GQSPI_GENFIFO_BUS_UPPER;
> +		else
>  			xqspi->genfifocs = GQSPI_GENFIFO_CS_UPPER;
> -		}
> +

We could possibly drop adding the SPI_CONTROLLER_DEFAULT_BUS_IS_CS flag
and handle the fallback here instead. Like this:

	/*
	 * If spi-buses was not provided in devicetree, assume bus is
	 * the same as chipselect (needed for backwards compatibility).
	 */
	if (qspi->buses)
		xqspi->genfifobus =
			FIELD_PREP(GQSPI_GENFIFO_BUS_MASK, qspi->buses);
	else if (spi_get_chipselect(qspi, 0) == 0)
		xqspi->genfifocs = GQSPI_GENFIFO_BUS_LOWER;
	else
		xqspi->genfifocs = GQSPI_GENFIFO_BUS_UPPER;

>  		genfifoentry |= xqspi->genfifobus;
>  		genfifoentry |= xqspi->genfifocs;
>  		genfifoentry |= GQSPI_GENFIFO_CS_SETUP;
> @@ -1316,6 +1316,8 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  		ctlr->num_chipselect = num_cs;
>  	}
>  
> +	ctlr->num_buses = 2;
> +	ctlr->flags = SPI_CONTROLLER_DEFAULT_BUS_IS_CS;
>  	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
>  	ctlr->mem_ops = &zynqmp_qspi_mem_ops;
>  	ctlr->mem_caps = &zynqmp_qspi_mem_caps;


