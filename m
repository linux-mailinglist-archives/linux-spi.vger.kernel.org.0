Return-Path: <linux-spi+bounces-7053-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D61A545D9
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 10:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7844116E524
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 09:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392020967F;
	Thu,  6 Mar 2025 09:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GgM2XbKE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDF820898A
	for <linux-spi@vger.kernel.org>; Thu,  6 Mar 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741251945; cv=none; b=tN4KqUfo5yrzcKrQElMmEG4SvBvrL188r565VHxP1ShOm7jfVPmgUKRmg5PfZq+jJY0p1I0WWsGN4RN0F/fBk34Q90KH5SHyZHZ6vIwUvb5wvZf4aNidYtc1WqlWYS66n9vT/IGRNGjN/TzSRFx52Il1SBn4Z+3TNjfN/USFowA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741251945; c=relaxed/simple;
	bh=kunkjJAcUvV0KCgh6ETD7+I403QHX7q680xxS8wcbSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R6WH3z8OLmFp8lL8ZXHL0xh53VUVa1Whc+iQxnS5YWrfbppAyZ+koUz/C8XZDEw6RRt59auxWV6ggCHcTUr33klHf2/Vsgh1uh2CmPVsy9mj2ARup2YUBPMp3lorh5mQzy+Bbw7l7uB3s99U15T4IZMbmPOF78167NjIRfy2x30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GgM2XbKE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390effd3e85so397232f8f.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Mar 2025 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741251942; x=1741856742; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adQB8+6Zw/sSgz1UwZBYDa6M1wKK+PoZRlb7G1nfMus=;
        b=GgM2XbKE8WIkl7RVqpIsmo2JfPVEWsg7Zqg4N8GBxGXvWAy0sHaeU0XNkLvvqiFe5l
         3/3e+ZypSh4ltd5ugrGsJPLL+rtm3QfktF/Jz8XGc0GaCp+H/deQwlQ/feBeTinaVGN4
         GyEAXnkjjtTbljTEknkWBOLFEhMY2Unn3PAzbU+UmeU6NR4B4UVydiDbXchRUYf8lv2w
         VzyA5RbrAULuG0nE+x1kpgRDBbKEH4dYW8/AL0ywVakcuDI8A5rKw0a9VjeBvlL3DCpn
         I9VcoJtD3s/xo+QQCKL2LZ2jh4fMbmHw60sa5UV/ClgwBx1Pr9B3NuAeB9OuLPP7IOgU
         7mIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741251942; x=1741856742;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adQB8+6Zw/sSgz1UwZBYDa6M1wKK+PoZRlb7G1nfMus=;
        b=RRLJzXIujh+DlM/7efuoJgpn0KcMbJtfYpAx8AY33NELZietIuMNLjx7QJIWz3Q1Q/
         VU8rcIPkUz+NcrK3rdjJJ5RnA4/aZHhNVok3gewTKqAidsHinRM/AndPs18uyAQXxD3n
         VZ7wWnEdghHpWGJe6TddTWo12qtIZU/1Ebh6GTkwTxxiDAoAftJDeFrp2miplA5BEYyZ
         52r7o8LPNbCEVz1FlREXa2A5FHr/2cIgjcmQDFn4SzM0VrNnJ2+rHAa8PIUSoDkHk5qK
         saJK2NvG5xII2KmMFG47n97p5j/y5BaQ+j4mkNK91TlBWFP0rDbRSQFCHZmeS1SZKsUs
         etyg==
X-Forwarded-Encrypted: i=1; AJvYcCX/Tu5ssy9aoWuYH84j3jAsDDeXdyqGQqWiG0sQPsg/vHMR2ryXkWB9+IFxguZJwKna5+D//pVD0Sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhyLbfXIiAJ7nbP0ArUW0518xfpZGoXe5f5sDEjU9rYOpT/LJ
	1cAIezb02GJWhwHtBsbsZhg2dkPG5Dwemk7xMo3UGXOtlISuD9bOFlxxc4y2mhY=
X-Gm-Gg: ASbGnct85Jc4lgsQ7QCLUx+75biLLtxSrA8THl0v1JOZSewgIg6haKpPOKT2N7RJ7kc
	JJy50+QU/P7evSQVQNEqRKXep65aq8qv8MXBgf6RWsFEc3n3Qy6hpOnkUzGXROdkJloofRD9jv+
	waq4C4E1VD/Qxg5XY1ZQWIIR2CYtvyo852ZPHfkJeJ0HCL1f5urSIPKaiFxvwulIrbNzC3UUdie
	JGG2WNKAp7ZDdHkr0Goe3Dn8sxFFdpeXgqjEFY+RW6inMl6mXmaAkKaoA+2SfKZKNLh7XnzLaGI
	iwuyZxnGJtq1K3X/DUBkto2RSbdbIRFU93v1VTklI8Pduv4HGQ/nEg==
X-Google-Smtp-Source: AGHT+IG2WR6pm+lQbLvv11v29B3gp/STcFJfO0QYU/AqGm6a2aoZ3odgYlQN5EIQzEwh2KMIlvABhg==
X-Received: by 2002:a05:6000:2c5:b0:390:f9d0:5ed with SMTP id ffacd0b85a97d-3911f714ad5mr4725263f8f.1.1741251941841;
        Thu, 06 Mar 2025 01:05:41 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f10sm1366109f8f.65.2025.03.06.01.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 01:05:40 -0800 (PST)
Message-ID: <a073191e-afab-484e-9659-66b957301db1@linaro.org>
Date: Thu, 6 Mar 2025 09:05:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-mem: Introduce a default ->exec_op() debug log
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20250305201140.2513431-1-miquel.raynal@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250305201140.2513431-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/25 8:11 PM, Miquel Raynal wrote:
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -377,6 +377,17 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	/* Make sure the operation frequency is correct before going futher */
>  	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
>  
> +	dev_dbg(&mem->spi->dev, "[cmd: 0x%02x][%dB addr: %#8llx][%dB dummy][%4dB data %s] %d%c-%d%c-%d%c-%d%c @ %uHz\n",

Isn't this too "chatty", especially on page program ops? I wouldn't be
surprised if the prints introduce timings that change controller's
behavior. How about using dev_vdbg?

