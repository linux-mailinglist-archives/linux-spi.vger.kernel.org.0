Return-Path: <linux-spi+bounces-5669-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2EB9C40B4
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 15:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E7F282D01
	for <lists+linux-spi@lfdr.de>; Mon, 11 Nov 2024 14:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913519E994;
	Mon, 11 Nov 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w042hmKQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9E519F13C
	for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334662; cv=none; b=bgcDNeMJOMxa/soPTJBKCYcS0LfvQKzdB03Gs5mrm22wQfgd2QSC8jK7jLv1WfL54M4Ticq9xUs/7wrZTAz3duCpaKmnoYSK3sFcDD4OgNuol8yEzMZ+P/PNY5/e1igCHLRsg5AyDEHEUQ0VNbmUzRBaN7OJUjKaflx0oIDBadQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334662; c=relaxed/simple;
	bh=UAJQjftRKdfHsGkVmo4ui1PVGOVKzIgUBAaQmVOLEZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuJJZXbEwvXr+KhuKkRT+l4kKd+eQAgAeUJf0fKSN1jhcQYo1YSsu3i04LYvBvOFdpxKcmpYcG0+M+uU4aASrPXOkAg+Lulnq/GI6w6yyBX2R5nNOUlsIq69V7HHjw1G3ozvzafpnKRW3Ij8BWk+NLYB7JK5rhdj0zlmVJWJfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w042hmKQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so3507771f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 11 Nov 2024 06:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731334659; x=1731939459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8X0PxEOLnM4Tfl8Ycc2hMSna6q9pPCn74dzWrTBOosY=;
        b=w042hmKQ+hDzQ5Qb2/4nmteRWA4e6OElDO9kStDfj2j+JGNMlEnLZMuQlmDJpgl35E
         cPdcrbAcONVzCwyl6Qp4wun/Wi6t/cHF/WfQSbu4s7YVcNypTRsP9dkzGmhlLPEY95Y2
         c5APsQ5pwWqWRiy4hSPfPs8BTsNbhJ0qwCgiBUQG+pF5PmDmBsJedDaDdXwVsbY/e8Qg
         7GCv4kWyaPqNKGQSBaGTCCFf9NfGgbmSYyITDNCvmXaje9f/8QiVvaS332hQArFKS10w
         I14mK2eiBS+8ITK1Rwa7fFpaYLT8HbycILXlTwBicoiZ70jAb4Q18T+F4YV58ZejXpKm
         pnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731334659; x=1731939459;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8X0PxEOLnM4Tfl8Ycc2hMSna6q9pPCn74dzWrTBOosY=;
        b=v9ewyp6O6tKGNKzlTB9dPCzIUcqU1C9JYMksuc3TgmdGOmOUZtS33bDSjC0ZVIswJR
         K+vDiN8VT7Yg813H1B4dp2P4Shv9CAcHLCF+2bFWWqsCNl19obDyh5Y3WVTkUiijxwi8
         w2A4UNCEVDxOockM9/Aw9AzNQuE2lK9kW+rHYUw8zvnuyq+bJFV+uVRFYK3JlEa94gyv
         HqioE2iBWPiN87Nf6WYE9J3iY9CuHYXDb3Nqjjj26f+dwDLcNqmvGg/4il4+rCHIAn2l
         muN01lmkOURNVxJJ2DHcHuM+KZkNDgHhCwYD3VUFMWFvEoFEfYWvLsueicnlK+srDEVn
         LQag==
X-Forwarded-Encrypted: i=1; AJvYcCUmLRT5t5aPsgWk4e0VogUkb2IcbIIuLmNKCDtqZrTYwOowxfvnwiv6qVnkmfMagdNAgoygBfsykYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTMOCKFUDxmJ6YlA38LlkFlA+6nw2ia44AcVUuM/Apn+57xVn
	7YF9U+2wvOESRuBJFdZ4f/7VmV7Pky4qd48i+hGxHCpLZZTdXqXD+qo+5xXvOCA=
X-Google-Smtp-Source: AGHT+IEfypfvfuhGwuCh2moR9U66zwgs3XzdAI100KcZp5oMFUAapog0JepiMKaoUqHLkllprnqFZg==
X-Received: by 2002:a05:6000:1546:b0:37c:d4f8:3f2e with SMTP id ffacd0b85a97d-381f1835b9bmr8731830f8f.55.1731334658861;
        Mon, 11 Nov 2024 06:17:38 -0800 (PST)
Received: from [192.168.0.157] ([79.115.63.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea93esm12841976f8f.66.2024.11.11.06.17.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 06:17:38 -0800 (PST)
Message-ID: <6e037ce3-1755-4cb5-9124-4b32773fbba4@linaro.org>
Date: Mon, 11 Nov 2024 14:17:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] mtd: spinand: Add an optional frequency to read
 from cache macros
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
 <20241025161501.485684-19-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241025161501.485684-19-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 5:14 PM, Miquel Raynal wrote:
> While the SPINAND_PAGE_READ_FROM_CACHE_FAST_OP macro is supposed to be
> able to run at the highest supported frequency, it is not the case of

what do you mean by highest supported frequency? Is it the max freq
between the ones supported by the controller, pcb and flash?

> the regular read from cache, which may be limited in terms of maximum
> frequency. Add an optional argument to this macro, which will be used to
> set the maximum frequency, if any.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/mtd/spinand.h | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 3730cdf914f8..6064029c5e05 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -62,11 +62,12 @@
>  		   SPI_MEM_OP_NO_DUMMY,					\
>  		   SPI_MEM_OP_NO_DATA)
>  
> -#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len) \
> +#define SPINAND_PAGE_READ_FROM_CACHE_OP(addr, ndummy, buf, len, ...) \
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x03, 1),				\
>  		   SPI_MEM_OP_ADDR(2, addr, 1),				\
>  		   SPI_MEM_OP_DUMMY(ndummy, 1),				\
> -		   SPI_MEM_OP_DATA_IN(len, buf, 1))
> +		   SPI_MEM_OP_DATA_IN(len, buf, 1),			\
> +		   __VA_OPT__(SPI_MEM_OP_MAX_FREQ(__VA_ARGS__)))
>  
>  #define SPINAND_PAGE_READ_FROM_CACHE_FAST_OP(addr, ndummy, buf, len) \
>  	SPI_MEM_OP(SPI_MEM_OP_CMD(0x0b, 1),			\

