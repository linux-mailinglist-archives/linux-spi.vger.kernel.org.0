Return-Path: <linux-spi+bounces-9532-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB7FB2BE51
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 12:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223CB5A178D
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DA324466C;
	Tue, 19 Aug 2025 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdIooph2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452F53451D2
	for <linux-spi@vger.kernel.org>; Tue, 19 Aug 2025 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755597608; cv=none; b=tbW40Ieby0dDhJqacapAcruDyi7ubw9xouWhvZB4oAHVfYxuKVlyGTw5j97TwcYEJITV9jgOt1Fd1sOkeOiErHNJzyl7ByGd30FE9CuuUaU42Myir94ubto2k0jz+f1ngUdn/9XbGdplrxP62JcoID83iBJbB+LJWzLMUa/q+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755597608; c=relaxed/simple;
	bh=jzGnOmF7Sk4LwrNAoupPd1iop6vJLnCtHUZ3GO0ffG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=A0cNV2Lx41ewiUyqZVzG/ydroLBQSiha52Cb89LUxt07zv9bjv+skGF3kvTUoz5pgsUHYHD1pJX86amFczEc9CbvI+Lf2XrStFX0tp4iuouCJGvJycSvSqUziy85TQFzogBMCScIWiD03JnMk/YwcAu06mG/xYl41OeHqGnf96s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kdIooph2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb72d51dcso718234766b.0
        for <linux-spi@vger.kernel.org>; Tue, 19 Aug 2025 03:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755597604; x=1756202404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gjBR+kR0t8TJ8QuirCE4bg/F9pyLOUYw+FF6LSil2u8=;
        b=kdIooph2lqV0R4lJaAqUiRFto8KCbnHqUdqUc0UsKxtdmiVsbC39n6LkEaPrCqE90n
         OOacvCpM3z/Rw7dM37qltNglAAiOkGUgSVwnvkznYBsJaIV86sD8Hpu1zuixCRq4YK8S
         yZTjXVKlM1p3Rvf5xALrsyi5nF/Bi32snAOcQAGrPObj3tFC21T9OtG+cwxHbWYmhgVB
         WDv7gkVBlbKgo5PTQVyU5rbM/Dh88Ph0ubSBbLVD74Pjl/zHcY0Pfgss3c1xphH6aEml
         fU2IhvzAmqz+g1qB8FZBplSEbrG+iikKuLDrIou+LJIK3e7by/2XlJxWnxPURnWYtnrm
         5wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755597604; x=1756202404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gjBR+kR0t8TJ8QuirCE4bg/F9pyLOUYw+FF6LSil2u8=;
        b=a15yXdjcnYFdowFSnTgLqndcRomLdes2jWGz0Wtb8RW4QWsqOjSbq4CrcfN4kjCR54
         KnVZy2yMTaOxhR4N2NpxWvAp/qn2XoxJy4RkgMJRZDSSeeeM+cHHEypRtrVb4tF32u0g
         kQeDDUIab2mh34bSHCqU8JvmLbmv+FY/gM4b7RstH5EU1h7btdH/KCdP9OmU7BAKCHs/
         TbLx6SC4E3kxzqFguAy9G+2lnz0JC+CyRgfno9SkTmZ0HzqEHXZdfF1j2Lv9WQ7VNaUS
         41AtJXiFjV5JeY3LMVdOerNoht4U2LaeWkH9n074DnQeP0QZoQ0s2/lBMiLWLk+GgA9c
         +ADQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5mVZqCLFDsXubQehBN3XZcr2MVsjpZpi3Lfn3i9RbgHmXhgmzLNqQI5/aq910BUbPuYEzPCGPZnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzczQfNUY6vT8rcZJcaO+tGHiJEFquDL9pFF49ZfKiR92ZVzLox
	uCHwtNqpSBXc9rBuWSB3hF6MVT33eyhuYYi4chUj9Sj5sAHP2f2/i5xapRKoVbGF/xE=
X-Gm-Gg: ASbGnctkR/SHPG3j8WRPQPm5ftArSz0xodTV+JMVKzuQSkNsyEKzrf+xrZXjvxVrfyu
	tNMPdTuOeDtWQFSWAoWG/0FwN2lrJdTGDmfDZ2gnKHVEU8XXaGvZN7tGHSC8sND5W/DTEVca/9v
	kPWN1M7n/Cd67OEYYxjPRxs78Wf8lCdW9t0y1CUJxALyks7xnTDb9MrT+jfa3faMT7sEAYW+Fa2
	2fPAlsVkppFMBj6mlfh0ZWUPQExbEZ5j18Wq6F3nSWmCX1DnZRCxPAt/gLubWuQsmN/MroNL02E
	sYMEt6ljZqePi03z8ZV/JAMmIgMIJKCtdqD/uXFxmF4hQNwoACEQrkV5t9HxxscM2QSQZcyqruo
	KrwM1PtV8lNJxUf/rByhDTxzR+2HJLxuY1peM3o3/SzjB
X-Google-Smtp-Source: AGHT+IFPRArZTdTP+NLIy/Vie9G8nvUNWq182V7aJXvkqOBztXScKlilBZHnaP0cP/Vv2uPVCLOzAQ==
X-Received: by 2002:a17:907:3f1b:b0:af9:a4de:f092 with SMTP id a640c23a62f3a-afddd1caabcmr172982166b.55.1755597604424;
        Tue, 19 Aug 2025 03:00:04 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.104.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdcfccea7sm977812366b.67.2025.08.19.03.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 03:00:03 -0700 (PDT)
Message-ID: <e55326b7-7f52-4497-897b-32d67f522cd5@linaro.org>
Date: Tue, 19 Aug 2025 11:00:01 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/6] spi: s3c64xx: Remove the use of dev_err_probe()
To: Xichao Zhao <zhao.xichao@vivo.com>, Andi Shyti <andi.shyti@kernel.org>,
 Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 "open list:SAMSUNG SPI DRIVERS" <linux-spi@vger.kernel.org>,
 "open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250819092044.549464-1-zhao.xichao@vivo.com>
 <20250819092044.549464-7-zhao.xichao@vivo.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250819092044.549464-7-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/25 10:20 AM, Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
> remove the useless call to dev_err_probe(), and just return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/spi/spi-s3c64xx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index b1567243ae19..3a00f9e480c5 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -1268,8 +1268,7 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
>  
>  	host = devm_spi_alloc_host(&pdev->dev, sizeof(*sdd));
>  	if (!host)
> -		return dev_err_probe(&pdev->dev, -ENOMEM,
> -				     "Unable to allocate SPI Host\n");
> +		return -ENOMEM;
>  
>  	platform_set_drvdata(pdev, host);
>  


