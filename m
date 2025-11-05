Return-Path: <linux-spi+bounces-11058-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDDFC36DB5
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC31A680517
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6BB3271E9;
	Wed,  5 Nov 2025 16:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/F0JTWb"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FBE310777
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360114; cv=none; b=P/FGGh2p9pVcDEQaELTCBcX8bREpiSikeNkuA4kJN0rFd5YH1iBmH5ZVmyTGQ41L/8ZuaaK76SjmSkPR4Y2uIoPIlhTBNBhb48ePTisJvU5DNCRBLeq5bisnCGsyFy63dlRIk9c/laQvygsUoOhw3qit1bh4IAi8uaHM9W4Vpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360114; c=relaxed/simple;
	bh=aJ1f5V0uew9Za4nsW1MyDwJoEjJKM36x0hfHj12g8Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMHaXLj+IW6ZIocYNnnOSNlz/TrBEq+KY2EFVa52oL81AVy/tk8zpOOF8O3qFdJliJD9eWJbHZGi14mljst/Q5PaCdNmutcnQJddUqwDIpIKSeHgk8joavFoZq1F2V2hTlfK7qxyx7kap9WUX+6ELMsFpezrzjlMBFNeL2/T5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/F0JTWb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b6d4e44c54aso922962366b.2
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360111; x=1762964911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tI1w+zRHNjqYgYKUw8eqjf6yQpSJ+H6WAlDRjf6NeDY=;
        b=j/F0JTWbqrHuHz6LJTbjXx7b4dVSDCaBdofPJBsUHdKCgfT63rha7QKOLh+jpWkdJa
         N7Zbo49aYpUr0H2KI7uYzUZCaP7l+go2kuSHdkduVVxgIKA/O754tDG8oskNFBZ4qvsu
         m11gAH7KmOEbIONpjaSdVcjvH5uu8b2Vum23ITuDGlCkhTPAJjnvpL2Yr0UKpubygod9
         36Fr2zxaxTB93GqkfRHh1vqRvD8Sd3TrSMdmUbHGQ69Cy11DkJ2ArkYZ0hjdAisxFRnW
         bR041+MeAu7AYzscYFwWvN1wbqKJCaj+euKWe2/N9UlL3PDUqet3zHKdkLZ7OJTFunP/
         5xqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360111; x=1762964911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tI1w+zRHNjqYgYKUw8eqjf6yQpSJ+H6WAlDRjf6NeDY=;
        b=S4cteqmlY5Xdckyt/A68HLTuEWIlJlWRDT6qErXOXai8m2xrr/CAzr91iBe29zikIK
         PjYho0hSAYJqf7DKpU20zq4jDBajyqs3zko8CVQcKRu7uPwMC9QLG3AwWAA7nQDmJI+p
         M25IczGnkmGccuoHuwME9QpCA3fpKzxYrLrRESkJAQga+ea6KDY/T2pL2WGptqUVR0b8
         GSnDrxXoNREPXZFS7gyNUQ7pcoyWy7TbYR2E75du/VDBrR4Xm9HZKdrzpSOqVGc7talj
         dnK/mnOFSGEpmd2fyy3uzHImknd0a8Xez5wkjqpkMnWPnRAtWUdKGaQAsmu5TrUTvVpX
         Mf2w==
X-Forwarded-Encrypted: i=1; AJvYcCUO6tiDCfIleN6gYT8gGSOPXR+w8VjmCVgDk7uoX/L6iX1MOJYVBnHD6bVCyCLS525sP7fk3xzfHjo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmUg2FKTibdhQq4W/2+wJf8gDFeJCw+86/MMzMZPdXBPZkoztB
	DvYurZ7jWiooawsa4yt/qrfkhko6xgcK9y04kUfcq+KGDu62Oo0y9G3dKsmUr+I8I5U=
X-Gm-Gg: ASbGncttWCr7LGVViyrtIOehAmXRb9YFq2hugvEch0AvqOWesNQzTiviihjKYhu5XDF
	pcUnPu6P0YPxSaDAZh0qw/T9NuKw/+sSk54GFezF9RWq5XJ2zeGx0TbNC8hu7GesodJqReiro19
	RBW4QUuzV6GNj2BM+FjHRXh1K/TVz95NABVpiZeFtlHfyygd6bJXGhU6Or7fdGINiN8llnuF+7P
	Nfbhaj+qAq4fMzz6Bla0G37gL+yvM+MVkblcRXptWFlZgwc+AfvwbAw8ui96K9mFkfZJbnjd2XR
	mSev/iAqHBzWJnNnJdnE454GxkgQ61uVZQW2Btu5ux3JTk5cEoDBbYLvx6Ubp8HyQENkzfNP6ZF
	abF6oOFQXicXSzESj8ftkKH2rvQs7Q36xVeinkSD2X3VFUkFch9baSGZU9RWDKYQWo/uiZliysc
	+sNBquSI5vnuy0HBs2TppX0+Q=
X-Google-Smtp-Source: AGHT+IHUIt7T9pXuVmpVYaL9XQ6GnLTYW2Usq+9EdzSRSWz7ihtMq4nQ0SqhbWd8MSLFCOpnH9FH5w==
X-Received: by 2002:a17:906:40d:b0:b72:6728:5bb1 with SMTP id a640c23a62f3a-b7267287f28mr269900866b.56.1762360111222;
        Wed, 05 Nov 2025 08:28:31 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0f1besm522399366b.31.2025.11.05.08.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:28:30 -0800 (PST)
Message-ID: <5680a2a8-aeb3-4274-a264-4ff658cc9246@linaro.org>
Date: Wed, 5 Nov 2025 17:28:29 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/28] mtd: spinand: Make use of the operation templates
 through SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-10-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-10-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> index 4afebaf5f0195b9bc617ea1f125f637f76fff9f8..a8fd04a67cfa9925bd68c57539d86e0816b76274 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -701,6 +701,93 @@ struct spinand_device {
>  			     unsigned int retry_mode);
>  };
>  
> +static inline struct spi_mem_op

Do we still do inlines?

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

