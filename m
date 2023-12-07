Return-Path: <linux-spi+bounces-169-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7802F808EA0
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 18:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39BFE281418
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 17:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE75495F0;
	Thu,  7 Dec 2023 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LIraSdGE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DAD19A8
	for <linux-spi@vger.kernel.org>; Thu,  7 Dec 2023 09:24:54 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a1caddd6d28so160042266b.1
        for <linux-spi@vger.kernel.org>; Thu, 07 Dec 2023 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701969892; x=1702574692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSaCKj49TdBQE/wW0nBbIlYjNisy5X/gJJF/8cHix4E=;
        b=LIraSdGECWO5t07MKS3BLatmmOjnaU/i9lSaejma3SuvcK292+cy6HZfwVlTMs2Ajk
         Y+gJwKny2rBCWoe3d/VCuueff38nvjeSD6o0QKl7N0Xm7O6ZCxHXKorPx5x30dWOnO8g
         rhN/KwmgeLTLJHZYpiFhboBk/kUIG8Rjetu8rKys8fMtuncgFlijUmzduv2JIjzBrZz4
         vIdZb2ndFYx2cmlSD2k9m+hlZ7yq6nyPowWnvJ2pCOU/j7CHTSTy8ZS66dzb8mdMo8iL
         eSl5LWwg76mxf/X/Yr60tw1Klo7QVULLD8Z9SxB+2mJ5YkzVwoI6y7kffEFq3MdwLT3T
         0elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701969892; x=1702574692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSaCKj49TdBQE/wW0nBbIlYjNisy5X/gJJF/8cHix4E=;
        b=MPPkKwDLlrcTl8cjxTzYqUJ+s9VHcH4ItAHLNhjtgEREY11mH/RouAHGj9a/66+lEZ
         aZg0q5ZRSga9Y4MFCFUrVz1xeK7Wiu8LSv3YXN8CgHCmYSQUneDGaDRxh5JeIhNc5OjN
         X/B6eLeayKgYcNWEK3dVMXaWasKK/avtYS/MLHggRPdTeB2NHHMKATTJQfSqjClFCOou
         JjIgv9Mg3iAGmAsYRPGtcb9rJf128HqbuArBnFk8i1AUMKC3gjPKAh/OTi4U/6sAgby4
         2DvG7mf80YblePf5C1qRPhvUP4mkUK+c6Oj35O9dlV0zaadOV82cA3KhGXDjkIbc8BWz
         dmWA==
X-Gm-Message-State: AOJu0YzPJVPmH6o/zkAFKvMeCfKPN/m+HOiNGXWy1S/pIBvk+SdBNxUb
	PDKw05xlD61aCibxA9JMHVdYIg==
X-Google-Smtp-Source: AGHT+IEtTd+pA4mJobxUqdqM7SglT4EunogmAQ8lpbogM+tHlUMEk4Qwu5mWYwLQ9J+s2P4F/4V7+g==
X-Received: by 2002:a17:907:5020:b0:a19:9b79:8b5d with SMTP id fw32-20020a170907502000b00a199b798b5dmr1010958ejc.110.1701969892432;
        Thu, 07 Dec 2023 09:24:52 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id a14-20020a170906684e00b009fd0102f71asm1078898ejs.176.2023.12.07.09.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 09:24:50 -0800 (PST)
Message-ID: <797b9023-e56b-404b-bb4e-6e178b7ada88@linaro.org>
Date: Thu, 7 Dec 2023 17:24:48 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, broonie@kernel.org,
 pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, sbinding@opensource.cirrus.com, lee@kernel.org,
 james.schulman@cirrus.com, david.rhodes@cirrus.com,
 rf@opensource.cirrus.com, perex@perex.cz, tiwai@suse.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 michael@walle.cc, linux-mtd@lists.infradead.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, michal.simek@amd.com,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, git@amd.com,
 amitrkcian2002@gmail.com
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231125092137.2948-8-amit.kumar-mahapatra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/25/23 09:21, Amit Kumar Mahapatra wrote:
> The current implementation assumes that a maximum of two flashes are
> connected in stacked mode and both the flashes are of same make but can
> differ in sizes. So, except the sizes all other flash parameters of both
> the flashes are identical.

Too much restrictions, isn't it? Have you thought about adding a layer
on top of SPI NOR managing the stacked/parallel flashes?

