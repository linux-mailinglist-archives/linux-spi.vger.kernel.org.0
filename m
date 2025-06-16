Return-Path: <linux-spi+bounces-8571-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E0AADAE34
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 13:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20DB170458
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 11:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9839E26C3B7;
	Mon, 16 Jun 2025 11:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hExHp9/8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B121C2750E9
	for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750072877; cv=none; b=RYlsrjkaf/Yb0pkF6Dn0Fh9fvpN+3VWnEVUBNPwN9ihWezbaB8zBKbz3ds6dSSA/NZyF4wJdgzLlIPDXIw2n6dPVYcgyiKZLW89rj8cUw0EyQamySuoysnu6el42femiwlh0WpMhybbLiCc8rXg8KnUe6Pj2zLIuo+lu5UjHiqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750072877; c=relaxed/simple;
	bh=qgYShiCICLGlyXPXkMFaa9MBddkYx+zhgvPZouJhpug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OW4Gx+kc9rCKEMKgxUG1GuviqzWAleyVx6rfPV3QjBexiNTZb5b3gYgriUBdxDY4af1W1UCa2oy/VoppOLoudVwqCDxhYo8vRy3cug0sDUlPPf/te1S/VtBo/mDy6+GTK0win0+XYT6QHeJVZu058tdDjmvNXRbwcglanWvVVyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hExHp9/8; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so24109295e9.2
        for <linux-spi@vger.kernel.org>; Mon, 16 Jun 2025 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750072873; x=1750677673; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4euJ7IL/UtIuqUuTsf6umM3mNJN/f7JKsQPFpax4oo=;
        b=hExHp9/875LeWT6ykEHjyAWx7hjRXx4I/jz3F3zzbyLI4pJjJtjB1N9IS1Os4Bko7t
         ta6y8ucgNyiEv56NAVFlcZWCRO5z4/9NjamcaBdHxqQmnoqUzO9Ag+kAEkog+h+iDgfc
         liMGVLt5zvXH6/GsfvY/T9xcBzNS3yqiRrqMyMGUGEQolnADI216pPY+dVx0WOjWbl/5
         beUc809JabUOTS/Pyaqk44pY14CK0FEjzOEYB0XKI1g0mGaWfftRW6yRLaft0FVx4mvQ
         WfVd8VrldHMB88S5Wdfq+at4z7osBsvH39CANk8uWrbnwrkL9RDEFdzZHvo2RxeW5VJn
         BnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750072873; x=1750677673;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4euJ7IL/UtIuqUuTsf6umM3mNJN/f7JKsQPFpax4oo=;
        b=tGzsBHawRqDwwL9jwRzexKyFAVOHszjKQwcQp+r7OoVDOaIZavV1YbPbDbaPsEK+OL
         2jNClQ6GE5uHeChdgmEviGv7ec0UodeLLn4O/DGLdgCLG6RDsLeAEEUX9/953gJWe37s
         he0ch/XZ9ujgUUPV9U1yLIoWi9jJ8QOdLrclAqxqjedO+jxG61qKo4TkFNLCy7WKy7vt
         tSn5QIS2jgewIznsFCvqHcnsuTvvNNec4pBF4lZEpAV5qPadnwD2Ftkbs24iESYMqCBn
         JmtS4bIgnKS+V5d6+TPx/zguGQGJss/eJueY0oLpGHzgkFKOjRb2JMVNK6fK9R8vijUO
         69rg==
X-Forwarded-Encrypted: i=1; AJvYcCW16izvChCSAj2ural4QYKCiGTszyxoZCMlCs+odOzU4JdkE9rpwIljmKqqcsgrMn9ONYvHT3M/EVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oU9Dx6qLa37MHPhiZMxLG1AjdPbbYMvV3/DRDbdcCigV0hjJ
	TS9wFBRtCNYlqwDpnTDwQryYDxQWFOQJRtWOURsJ2cxJQQ6Gdll6/ecnonTISxqJXB8=
X-Gm-Gg: ASbGncvRh/jCVQWnSao/SXcS3h6v8PioVsVkJC5JgP8QS4dUvU8yEHF9LesPpFaSPqm
	rRLsOs9UtBnI88/zjXFItuWPzNwiQ9Efmhkxr3z71gZfRhv4O88GN2hNP7o32RjYJLuFZks1KBV
	BhfhXGXc6oEzSTePq/4EcXXKwNTovixs8BzuEqBA90QGng/wSWyXN/zcItGDWKWuhiJ8fy8rZOL
	T2tJ0fIwIRvBBAWBz3RhAIHzzBayKsSWPVGIh8RxAeRmUD1H5hEdUwaU/p9g6GOT52fUwsbW8j9
	ZTxNlpeW2y+JLwKOyHthOEu1C2mrdS3xb7/Y8KwSBB50Nv+xzattew5TW9we6miSCOI=
X-Google-Smtp-Source: AGHT+IFm7lURtK3nakQke2Eo0A04R9F5ogbYQ5oAvV51pSxGomor7dB0raebWDwLvF03RocQuXgBNA==
X-Received: by 2002:a05:600c:a218:b0:451:edc8:7806 with SMTP id 5b1f17b1804b1-4533e57d98dmr39178155e9.32.1750072872918;
        Mon, 16 Jun 2025 04:21:12 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e254396sm145401575e9.28.2025.06.16.04.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 04:21:12 -0700 (PDT)
Message-ID: <7cf90a89-b381-48ae-98bc-1316022e03b6@linaro.org>
Date: Mon, 16 Jun 2025 12:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: Stub out dma_{alloc,free,map}_pages() API
To: hch@lst.de
Cc: olteanv@gmail.com, broonie@kernel.org, oe-kbuild-all@lists.linux.dev,
 arnd@arndb.de, larisa.grigore@nxp.com, Frank.li@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <202506160036.t9VDxF6p-lkp@intel.com>
 <20250616111749.316413-1-james.clark@linaro.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250616111749.316413-1-james.clark@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/06/2025 12:17 pm, James Clark wrote:
> The implementations are in mapping.c which requires HAS_DMA so stub them
> out if not present. This is required for some drivers to pass randconfig
> builds.
> 

So the commit message makes it seem like this fixes an existing issue 
and it would need a fixes: tag. But I didn't add one because it seems 
like it would only hit new users like in the linked patchset. It might 
be better to add a tag but it was changed 5 years ago and nobody hit it 
until now so I'm not sure.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506160036.t9VDxF6p-lkp@intel.com/
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>   include/linux/dma-mapping.h | 28 +++++++++++++++++++++-------
>   1 file changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 55c03e5fe8cb..766f28a0e11f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -161,6 +161,12 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
>   void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
>   int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
>   		size_t size, struct sg_table *sgt);
> +struct page *dma_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
> +void dma_free_pages(struct device *dev, size_t size, struct page *page,
> +		dma_addr_t dma_handle, enum dma_data_direction dir);
> +int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
> +		size_t size, struct page *page);
>   #else /* CONFIG_HAS_DMA */
>   static inline dma_addr_t dma_map_page_attrs(struct device *dev,
>   		struct page *page, size_t offset, size_t size,
> @@ -291,6 +297,21 @@ static inline int dma_mmap_noncontiguous(struct device *dev,
>   {
>   	return -EINVAL;
>   }
> +static inline struct page *dma_alloc_pages(struct device *dev, size_t size,
> +		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
> +{
> +	return NULL;
> +}
> +static inline void dma_free_pages(struct device *dev, size_t size,
> +		struct page *page, dma_addr_t dma_handle,
> +		enum dma_data_direction dir)
> +{
> +}
> +static inline int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
> +				 size_t size, struct page *page)
> +{
> +	return -EINVAL;
> +}
>   #endif /* CONFIG_HAS_DMA */
>   
>   #ifdef CONFIG_IOMMU_DMA
> @@ -438,13 +459,6 @@ static inline bool dma_need_unmap(struct device *dev)
>   }
>   #endif /* !CONFIG_HAS_DMA || !CONFIG_DMA_NEED_SYNC */
>   
> -struct page *dma_alloc_pages(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
> -void dma_free_pages(struct device *dev, size_t size, struct page *page,
> -		dma_addr_t dma_handle, enum dma_data_direction dir);
> -int dma_mmap_pages(struct device *dev, struct vm_area_struct *vma,
> -		size_t size, struct page *page);
> -
>   static inline void *dma_alloc_noncoherent(struct device *dev, size_t size,
>   		dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp)
>   {


