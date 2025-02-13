Return-Path: <linux-spi+bounces-6801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8503BA33875
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 08:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D083166FBE
	for <lists+linux-spi@lfdr.de>; Thu, 13 Feb 2025 07:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CECB207E02;
	Thu, 13 Feb 2025 07:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2EmhXxp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E19205ACF
	for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 07:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739430330; cv=none; b=bp/AThsHPgUsViio7+wTPORiE/yHQ+pQKtWHu4GfIV7+bAD9j3zmIjhk/HMjGcONg71ePK6vPparA7yHtT/zrZ3YPZbMcqND7gKduQJENA0T5CeIL8B92ngkqtiJifYnSUG+zzoXN9OaTV1ZUMJiUldPe28ac9PnAWHKklshHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739430330; c=relaxed/simple;
	bh=QET72BwZuEgfgng3GFWuJsSpAa0rMxkNifDEi7QIWKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FH/npVQk6DxsLuSJAAub950+RqAaOvRZZikxCYfpQx9YelfGjRpO9lJEJrLUBKIMDlOeBGrS7vSxGW6CEmvF898mS8+SG7uJIqHiKMD48wYJNs7YX0W1a/JDy9uiCNGqqB1LyaCCSsKkrMUb3GlJweEAU/pb0IHgz0ijMiwe4J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2EmhXxp; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso67912966b.3
        for <linux-spi@vger.kernel.org>; Wed, 12 Feb 2025 23:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739430325; x=1740035125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KXZVhKJ2K7k3WzqdZVJwEQ+tPoZ58G31W+/pRY1rx9E=;
        b=T2EmhXxpoAAKfj3W6Vn+l2Z2CbXmlA+e0sBJGxHkRa5iQxixCrlPLZuNitxmJOpvVp
         dAwvd7WCOZ60w3hRC1HdmD8ptUuBjkPTDkdSoLnltuxuqeMTSR+x4EFtEhfNCKsLxS1q
         R8mOSaFYui/ndm2cfELc6PJbZyqIwlv/1sJt7e5TZ36SFLjb1BlQnwe/NKY0hQW/X4OZ
         hxiqxHLINuMXX4Txc9da2IqCFNRW5fdRA3dq5S30bIMx6XgwIpgqWSc4dxq/z3Na121K
         ieJmrvWr1iWQaLc4jf70Fz2GJB+JSMOSQwmMkExjkyVk4pxGqTvExlZJEhfv+/fQ9q0r
         p/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739430325; x=1740035125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXZVhKJ2K7k3WzqdZVJwEQ+tPoZ58G31W+/pRY1rx9E=;
        b=PVcLk1HeM+tFxoOStII4iDcQyS2njxFHglodL0WiM2nB95k0gDnLBo4M3rMEzMSuDW
         SdelhlQyZfUJJJkBHJuc9ylNOdbHFjp5dK98Rjve15wx8FBAyuawTWe55XrzCDvM2EUV
         uO7KDFSUQWucWPl6t+hBr0+w6H+IUwS5RdYRL2U5xuhC8LvJB9Pi/pN97zKEfmsV0Yen
         KgRdCnOG5odqcHAksQ8fuuSoYaQ7qnxLkSq6OERjkqTP/OEIqyicIGQWZWDz9YkiiY9p
         Q6fpIIIDNpWb0SVYICkGjePaZ4qm8X6hswmKlgecUjZ+Z77Rm9xOUh208HcjCbbBAbrw
         VqWA==
X-Forwarded-Encrypted: i=1; AJvYcCXeiZ1HYtEkwDKyX4wxKcuRJqbYGVlbLr7Q9ewJRE/I+M2R3zcz/ndmTXhG6W4/xl1w4JHgxu4Pkr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQpqCmVPjOniq5usflHFd19t7a/GDBdK+PNE4EJuSzaj83etqa
	Tcq2qp2iJpIuFoX+XR/ovkSUBecL25RYE2IktJARv76h4HAqCndQpLKwT+dMy+Y=
X-Gm-Gg: ASbGncuK0YQp3bBuRofgvJlAzEMM6vB/K4P0pe4RsTqv/MUY7SJ5syDjik+/0h4Tqf7
	5haslnw1rOmzliEiX7B+O1m/UlKN20BkrMaoZab9xqcJGMbisDQGNSZm1B9Kf7A9YgfUVNg9RK5
	iIkOP1yeqWriY/+jD1p8RwH/JfkIEEj1SLalhxamszkVeiHvit7yuE/H1a0bGPPgXqX6fXZYLRs
	fks2w4JjjiL3ESDBPp/qBNMYFsx5r5tu0hdxC2xCS5XAvqyck8SwrhSTplWZaUL4sjUue/biNeF
	i3zzzjI1nOKynxDoUU7UGXWB
X-Google-Smtp-Source: AGHT+IHMrmKjXCi72IpIaaGCXzDCq4ibYmkuB+z09aLzRAGtSKSlts+BhuC/X0899B2uE4MTHf5wAQ==
X-Received: by 2002:a17:907:1909:b0:ab3:84ac:4dbc with SMTP id a640c23a62f3a-ab7f31a3665mr647610966b.0.1739430325446;
        Wed, 12 Feb 2025 23:05:25 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5339dcf3sm68465366b.156.2025.02.12.23.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 23:05:25 -0800 (PST)
Message-ID: <bad7b5b6-c61b-4e93-9415-6476976c8e81@linaro.org>
Date: Thu, 13 Feb 2025 07:05:22 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] spi: s3c64xx: add support for
 samsung,exynos990-spi
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, peter.griffin@linaro.org,
 andre.draszik@linaro.org, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250212191241.280-1-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250212191241.280-1-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi!

On 2/12/25 7:12 PM, Denzeel Oliva wrote:
> The Exynos990 SPI controller shares similarities with
> the GS101 (Google Tensor) SPI implementation,
> but introduces specific hardware requirements such as
> 32-bit register access and variable FIFO depths depending on

gs101 mandates 32-bit accesses too.

> the SPI node where it will have to be specified in DT (Device Tree).

gs101 has some USI nodes that can work only in uart mode and indeed the
fifosize there is 256. Does downstream define SPI nodes with 256 bytes
FIFOs? Can you please point me the the downstream code?

Cheers,
ta

> 
> Denzeel Oliva (2):
>   spi: dt-bindings: samsung: add samsung,exynos990-spi compatible
>   spi: s3c64xx: add support exynos990-spi to new port config data
> 
>  .../devicetree/bindings/spi/samsung,spi.yaml    |  1 +
>  drivers/spi/spi-s3c64xx.c                       | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)
> 


