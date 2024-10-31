Return-Path: <linux-spi+bounces-5571-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E85409B74B0
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 07:45:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D04E1C21A52
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 06:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A819477112;
	Thu, 31 Oct 2024 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJ/7OrQJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81567282F0
	for <linux-spi@vger.kernel.org>; Thu, 31 Oct 2024 06:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730357152; cv=none; b=MPcQuB7hl6pwuwz1kHibwT0aCkmvtrUJv/J96ylYwSoLElAHMZunR7DaMnITXcpoWMC+g/6jXYi/8ggxH8re2t38cXUYqLEK2FMR08Eor2r1aqICHaYgnWxNM4R9zhbTfnKamNIs3cR3eDo1JuYYeBMKb3vushBizvylxIRKioo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730357152; c=relaxed/simple;
	bh=3Mtteln9jylXTnNcrlul+7rvUrjp56zv9Yaj883qdPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=op0MHDilkt9+pS+nX1BatAE3o6vc7+9XAdahf8AlaEJ1/ZaOr3xSdXXFGwrW5eBUrYW3lQp9+ifVW6al7q8gEehDEivlrVCnIl8UWN9qMBIfFaRfpwYO9MczItdCZAsXusEPH4LalpTMnLbwbcniRFNBc4ebDjI68fvmxnPfnqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJ/7OrQJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so5037175e9.2
        for <linux-spi@vger.kernel.org>; Wed, 30 Oct 2024 23:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730357149; x=1730961949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3OWm6Y24vWekejAsxWu5X3sn1wr2f2rD7TRcvjtf2NQ=;
        b=uJ/7OrQJvIaAxRqstSjYI1eKys5pTv+F5OEr52Omf+F4VNYShi+I21vysN/PagPHnD
         hFrCkUB9PzChAxeip6tnnfgX+IbM4rHQyR0yZd43/tG03wWaJoI3p5uYJjZ9C7nc4fHx
         pZXTEEvw4jEfTG6bKyBYQ582j2n1r6g1OjP2R8xvlMnfz97kQ+8qd2jFuNR4P43bvsmb
         BBDSXl6kQzPMpLucw2dRpYBqr2raY+OTi9ZErsWzGLjMkyDWbTfPbC924bANq1+qSGHV
         XBlciFt3/K6IeAnK3ooF1iovuORVLQBisjoYt3LMNPO6CIzo0kN3BqgfjZMZenxBSvG9
         GBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730357149; x=1730961949;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3OWm6Y24vWekejAsxWu5X3sn1wr2f2rD7TRcvjtf2NQ=;
        b=dRuQcmoid/7JmOV0QCt1A3/c402l4udkaeugBfgmlv7g/H8n7na019bd0FglSH32as
         0onDA8Sm4bbDD2Q4qzvX5Ivw39lGQ8SQbE+pUbpFLXwyK7ZZuXiyZQmGvu7vI6Yevd/0
         qhVS3r1VUeK93G1D8rgR+1GTmPDSL0CA1qmTJpWlzwjD5+66IYwUjhSg/uVI7wPPebS9
         RWgcdy94EWRFEs09Vel2KfAZazZU/UrIB+AHZckLkQHwznM+SYIVpP+oyVe01VreTYYB
         vkvrQyKJllJRw+aJ9cTC2E2NMNE8Vp77Eeo6x9kt9VYo1TY6JCYq7rbcGZt4JaOeA0yA
         5qDg==
X-Forwarded-Encrypted: i=1; AJvYcCUKaXZMeokQ37ptdv6Ucrm5U++uO61KbGfLbtYtsH3UhwINFHZeUJusNnWuAPinqfYuUIkMTOchXLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjeejZ3KqyfDBZbt7Ptm8bmZIfww7SXSqdImcKvLSexF8q3Uhe
	OnYy6b6x0Rbm6TnbTCrvNCjkLBxrPf4xCjOJ5BeVToFrAD2LiCieBZAOTSLl/WE=
X-Google-Smtp-Source: AGHT+IGCu52QNibWfbGLHARc+Q4U99DmGNqH3nGQBT77e42jajVuBVneE0F2NGfY1fDI5WmG4AbRyw==
X-Received: by 2002:a05:600c:4511:b0:42f:8515:e490 with SMTP id 5b1f17b1804b1-4327b6f959emr18859015e9.5.1730357148888;
        Wed, 30 Oct 2024 23:45:48 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm12987225e9.12.2024.10.30.23.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2024 23:45:47 -0700 (PDT)
Message-ID: <b4564eac-2ac9-4027-87e0-9510f6be8321@linaro.org>
Date: Thu, 31 Oct 2024 06:45:44 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/24] spi: spi-mem: Extend spi-mem operations with a
 per-operation maximum frequency
To: Han Xu <han.xu@nxp.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-2-miquel.raynal@bootlin.com>
 <20241030205252.ufylezzvhravfqr4@cozumel>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241030205252.ufylezzvhravfqr4@cozumel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/30/24 8:52 PM, Han Xu wrote:
> Hi Miquel,

Hi!

> 
> I met the similar problem when working on the Micron MT35XU01GBBA SPI NOR chip.
> The chip can work at 166MHz in SDR mode but 200MHz in DDR mode. I found Read ID
> failed on some platforms when using 200MHz as maximum frequency, so I have to
> lower the maximum frequency with some performance loss.
> 
> I think the patch is useful but the SPI NOR doesn't have such vendor-specific
> predefined SPI_MEM_OPS like SPI NAND. Do you have any suggestion on how to handle
> this case? Thanks.

Why can't we add similar predefined SPI_MEM_OPS in SPI NOR?

Cheers,
ta

