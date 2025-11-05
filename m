Return-Path: <linux-spi+bounces-11048-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDB0C36B63
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46293BEA45
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76F1315D22;
	Wed,  5 Nov 2025 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w3uwCUtr"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C8B31A54F
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 15:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358263; cv=none; b=r1BFCune9P2EziV5vMHDwfv/6t6A8QubyBpDRb8GXTGApDxgE6T6r6KW+euALDBJ+scgG8ibtZYEHNknprseV5CE7g3lVJ/7URdbJ0NiDYex3MNvTlxaPJYJjmZ8n+q9Kx21s87JJMvzjMX3uuUij/Ble4TTFIizurJyEk5ONQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358263; c=relaxed/simple;
	bh=YnSUOZY4yv1wHEA4ZNPWvccnW6Q2kz+n8Nso5t/pTU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V+Ahtf/vOSxeaH/UZUURxLR5MFPbBXbUxy2tI1XQwebQGSYxVsXzTpYz5mSZBeIoram5/1/qfhtPQk1qygcBxxixdE5os0+iy8HL0Vdfb6KiiomQU406ZZQZwvPacwlk0NScjJ4GFQAD5Vj9TLj1oeQWa6ZD7VY5sC2Zplq6YFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w3uwCUtr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so5670222a12.0
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 07:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762358260; x=1762963060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gi3ulz3Ij3cW2aD1iWY/9uEnz3868+Ej+OFb25qIT1E=;
        b=w3uwCUtr9zwYTYS+HIaCxRKDfjashVrjv0iXFeCl5/laHmeYSO1QE9ZzW9PDSiN3EP
         RRBV4B0KOUJaleYZHqcEpuzAYeDOFXnOGYLBCmmkjZlIQIrnLpCaBouegnd+lE1bSyXy
         4FqC770PpKLpnVD+st56EFPblasKyx885SxTRMXhgD739PiPVIyJKzBsE1V06N4SUlis
         j98LegfTyOJijStI7duulhHFaXh4RnoKL724cV+7jzkfo3NFq/wce06fvSNfD63KvYJn
         i+UpEHACDeeCWQ4+e2SdHMRcqOOGRMV8ZSWs0fPiWZqJea1caeBRbZXL17f1OaFfay30
         QF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358260; x=1762963060;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi3ulz3Ij3cW2aD1iWY/9uEnz3868+Ej+OFb25qIT1E=;
        b=J8luFKY+iTE3vK5QKooABc/faauBxxwXn92NCJriA+2D2/TKIjIwrSW6lztioehEiU
         R6bzgjyEPvXWpp3tqT7CT13G/j483q/rEE3RTHDOiDFaPFcGFfgg1LuSf33BWwFD4Nsf
         lapu972UBG94sV/dt7q0jKtKTyM7G0wVkTKp2w+tcoTjWFAbHaqiBtL8esShUe51lA1W
         5m2jxfpZDkIY4Gp3rZ2fnVUas3x9CvuizuoQNMBPDKzk3/fi7n4cyoSgm6gSb/fbbw6+
         sqEKzPQ3iypiVUxEQk/pJ5VOJPO8DZpSgxkUGOnmbpDWVVse2asOh/ZJWi1DOAFPFQ9U
         YhWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX5g2Q4E8+C3GwoZtxm2AdbXZ3HGCfO4bwQeBlXX+1LVxuoKnWG3mXxAQEeBMdKzUCUw1qkPQ86JE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDB5ygMiE6Xzv/krK/WdDJzv6KQEVCjNPt9o09+ESH1LRJLoCF
	SAy9V9/VQWCWnD00XR450O6AoiBdzXUOBAoxlKsCBUn9WnB0VF0i2WuSMCSoGCDPoH4=
X-Gm-Gg: ASbGncsoGTrrl5f0/WmEW7MTWnhC8cJRNNQF44EOPdlEEXL0ZunVH3BSl1bDKXU+rTD
	WC1ii99xCAhh8wXXT1JUKAajowygmOgIok6OSElNWI9/C/ksVaMtRxScvnlo2/MrWdpT7Yrluqe
	97+XgxsKEvpORRj2YzX1/rzJNdPx6IxEpCjYIMgtxIsiHZD0+sMIF0OiBMDmV6UH7vowWirXqcv
	nx7Ufb7/lKLbbUhMH6LTavPiTTcoEBBd8FhFmZhpu+B+GxxLodXtt6YQkMe3rISrV6jJ8l90KUw
	AQDMBjsQJRDwMLkfScvw8bD6LsjUnyIcR8cVcH76fQFCa/AuesuAwtv5m9OQGXrrKX+aopqVyky
	uKfIBEtl2W1fpXo1ykXkHXb+lc4OhPBaYlLPi++3LsD7oCc4CzTKTX7I4GAXCa4c7GINWHciymZ
	BDHJloXfzrLiqVv71YsuB5RAo=
X-Google-Smtp-Source: AGHT+IG8Ib7bTOk4rfnBCJBGTAFfgk2ImcjjuBmXvp18vfVvKZ16nOJ2X4KjkA2fJsMo226KrUYJSw==
X-Received: by 2002:a17:907:6d0a:b0:b72:5983:db20 with SMTP id a640c23a62f3a-b72654f55c1mr405051366b.32.1762358260191;
        Wed, 05 Nov 2025 07:57:40 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e26adsm522473466b.43.2025.11.05.07.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:57:39 -0800 (PST)
Message-ID: <efb8bba5-8805-4c95-ba1b-3bde46a4e528@linaro.org>
Date: Wed, 5 Nov 2025 16:57:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/28] mtd: spinand: Fix kernel doc
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-4-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-4-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> The @data buffer is 5 bytes, not 4, it has been extended for the need of
> devices with an extra ID bytes.
> 
> Fixes: 34a956739d29 ("mtd: spinand: Add support for 5-byte IDs")

no fixes tag for documentation.

with that:
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

(commit msg can be updated to smth like "update kernel doc comment" too)

> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  include/linux/mtd/spinand.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> index 927c10d7876958276a841a9f1278a74deeb89944..1c741145e49717169152854718f784e0e519ea92 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -287,7 +287,7 @@ struct spinand_device;
>  
>  /**
>   * struct spinand_id - SPI NAND id structure
> - * @data: buffer containing the id bytes. Currently 4 bytes large, but can
> + * @data: buffer containing the id bytes. Currently 5 bytes large, but can
>   *	  be extended if required
>   * @len: ID length
>   */
> 


