Return-Path: <linux-spi+bounces-4947-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF169847AC
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 16:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB5BB21DBD
	for <lists+linux-spi@lfdr.de>; Tue, 24 Sep 2024 14:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3C91AAE20;
	Tue, 24 Sep 2024 14:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlFdBqfL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D81AAE13
	for <linux-spi@vger.kernel.org>; Tue, 24 Sep 2024 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727188184; cv=none; b=K80vx5/qlxPPR5v5+LHr0/jWgZLPr+5nCSjrbbb4QKLx43r7pHBWSBmrGIvb7k8zg1WzP5Mk4P7C3wUFDAYFh3ngd0Wj/C8LD3BzNZTbROF50eU8gIiREHSI76WQivbnZOMXYXEzdqlHljZY5Z8lhT9spguv8MQFX0vtDZE79zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727188184; c=relaxed/simple;
	bh=FngZq51ki6qCptx3vUMPj1acgIGtnSKHuHPNES28BJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gPOa3Mhy+Q0KvjwXIAPMMLkej9dW3U1+DAgQF8FdPP821RKzPK0IhI69YyQJ7c19FNIU4Vvro5DMY/iKucCnmv1UaWlm3InpoGoKA8wU2X+R299J4WLPNvgwxchNFZAAYRc/mfTcE5Tag7ld2XXZUFZpfIiUnuuLANT2Xo8LodY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MlFdBqfL; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53655b9bbcdso6626760e87.2
        for <linux-spi@vger.kernel.org>; Tue, 24 Sep 2024 07:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727188181; x=1727792981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f4cZlZAMjE0Ne1cxdgDT0MlDCgX/48/03XwVDrLKtwc=;
        b=MlFdBqfLRXeILdMKeUFGE/O8MaqhrNmOjmgUwlL5luUrOzOst1O/oQ3ZMu65DgcMt2
         2D1+nemtS0xsLtmzu/yRmFWOApL09KggFvsK1ZS8mSpuvHioswjcbP9516pccK8fpzm9
         39JuTE9l4XatVybiasatkWeftvzaS2QjwKruRri2aBjNPAywkCwdnbEKhfyXt3zshwFY
         F9dFwTDj4uFthNueThbKoHtyb6z6sPyK5SHG42PZMSDDG/BLj3frTe++Grk6vlw3EuL8
         FCKlITs1tateGuR4/nb+xx25A0Da5zl1Wdnow90wHLs8kBmRPKo0fF1HWAiPq6QrYC+k
         vMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727188181; x=1727792981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f4cZlZAMjE0Ne1cxdgDT0MlDCgX/48/03XwVDrLKtwc=;
        b=T9iJdbE45Nu7H1xue0kBaeKaoUwVzGvxefaVW0jRVVKfH7sRyRQBDz/cblX27Xw9oh
         LVF/dlVWaS/rRvkjc4dQSfLU/uZbzDURnttQugxzaITxE3sAvFKJQctlA2TGs/OAb8aY
         h8Etm59+HFE+7NVLXbLkEHUPCpgbSVYT/xtr4UJcUya18yb2+F8U+k+1mmvrZJFioIon
         dZLfdsBrc1vLiUUd+ST9DN526TqREfeyffW4q1sfl7aOWPGjvqjxZpsvvrq2xVaN2VrR
         UajDF38om3VxbFayKuV5WWWlsS1jj+HVjpGoV5euJBJFg9b/JeRr2byaS/ThfOIptgq6
         /Y/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWE/wbrrC3CNg24pAwRf7P+G0QAbqpMr1NPh4fH+LCMGn8OrJqUMEUEhQ/sdMZK61x51NCOnzNcTOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn+s/uAyhZ4/AhcURXv6eww3PLzBiHFxqrHvOM9KC+15NBHr3b
	KPRzXrbydjVhh9GfxaPP73Y7PFTP2xIF7onbGwHlmOqTfEu5zsepRiw1CWZp63Xwu9pmxQw/imv
	h
X-Google-Smtp-Source: AGHT+IHqqbNSNbNJsHX8o3utWIHB/GoQ4Xc0CjtuLGIi0iI5bbvuRybVAXmwL11ncdRlK449c9p3oA==
X-Received: by 2002:ac2:4e09:0:b0:532:fdba:e7bc with SMTP id 2adb3069b0e04-536ad3f168fmr7657143e87.57.1727188180585;
        Tue, 24 Sep 2024 07:29:40 -0700 (PDT)
Received: from [192.168.0.157] ([79.115.63.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930cae67sm89840866b.121.2024.09.24.07.29.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 07:29:39 -0700 (PDT)
Message-ID: <a87a159e-eff1-45c3-bf26-115d4ca5a9be@linaro.org>
Date: Tue, 24 Sep 2024 15:29:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/6] spi: mxic: Add support for swapping byte
To: Mark Brown <broonie@kernel.org>, AlvinZhou <alvinzhou.tw@gmail.com>
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, pratyush@kernel.org, mwalle@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 chengminglin@mxic.com.tw, leoyu@mxic.com.tw,
 AlvinZhou <alvinzhou@mxic.com.tw>, JaimeLiao <jaimeliao@mxic.com.tw>
References: <20240718034614.484018-1-alvinzhou.tw@gmail.com>
 <20240718034614.484018-6-alvinzhou.tw@gmail.com>
 <ZvKktPc0luV9hItN@finisterre.sirena.org.uk>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZvKktPc0luV9hItN@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mark,

On 9/24/24 12:38 PM, Mark Brown wrote:
> On Thu, Jul 18, 2024 at 11:46:13AM +0800, AlvinZhou wrote:
>> From: AlvinZhou <alvinzhou@mxic.com.tw>
>>
>> Some SPI-NOR flash swap the bytes on a 16-bit boundary when
>> configured in Octal DTR mode. It means data format D0 D1 D2 D3
>> would be swapped to D1 D0 D3 D2. So that whether controller
>> support swapping bytes should be checked before enable Octal
>> DTR mode. Add swap byte support on a 16-bit boundary when
>> configured in Octal DTR mode for Macronix xSPI host controller
>> dirver.
> 
> driver

I can amend that.

> 
> Acked-by: Mark Brown <broonie@kernel.org>

I'm fine with the SPI bits as well. Shall I take the SPI/SPIMEM patches
through mtd and provide you an immutable tag? I can do that after -rc1
is out.

Or you can take them directly through spi/, but I'll need an immutable tag.

Thanks,
ta

