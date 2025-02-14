Return-Path: <linux-spi+bounces-6825-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF84A3571D
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 07:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296AC16E47C
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 06:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE9202C4C;
	Fri, 14 Feb 2025 06:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnFYzUfT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE3C188713
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 06:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739514684; cv=none; b=FLFPnOmMqZot1NNLeVC3pWUE5PPVq7O1D6qBcdxuGb0+d2+uo8n42FnXVpeAvbONWpwQWJ1QaYIF08YTKE4Y+LOaYJVaPdsiROQl+xbBSuq3Q7OMq9cxwJe8eSvnfZ6KG4biIm39QLj9u+fq0qSL8cjAoAImTzOpy5Pdg4mJZwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739514684; c=relaxed/simple;
	bh=bd3Ix1OlxqfISy3/YXIyFe4/qznReagdpNKuiCq9fzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UjFM6/Owe7+NbSJ3uBwAOg8tAQc4X5eQU0+BqcGQZaORm4Np6e6fVrWJR4/wJ9JefVGQ0WSpn3WNCBbME34qqy8h0yjQ8hYtjkpJTJgdEQJwF3r5kmfjbR7j52lNlcFw2rNnWwhUBigi36CWmRDKQJGxq6K9PPtJXrw/sjek2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dnFYzUfT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaeec07b705so279328866b.2
        for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 22:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739514681; x=1740119481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RS4NhYdSKIq0ZCVoddU4UM3ba+/5N5wTfgewbJrHpVM=;
        b=dnFYzUfTqhggHDVVjYAKRFrA0wFw7oXVtHSqXQIjzKSTAVCK6YpV1+mzjN+HuMBNXL
         8HppleUwQ0DDk6C3RNxNO3Tu1yJ104+gWoJs22e4RgFmEyYrTb9z6ILnH7o92Yv9dHcw
         eSHBbBGtDV4q4MHbeCh1QHNBV5lL+wy9CX9wZtw2scZGojnyU+ihXTBI3SXDh3eeueHy
         ziPAJ535vRQ0vrVq1vXxnYnPZ+GXpC5/57AyyyJPp0zlbPdS86GfmnBlFmtmcDLZD0au
         /FapofdbIumLEaoQUDsSPrl4f9T6ogxLWl/nMsUTEgR+oPf5r6fEv36Vm7igI/DfSn2+
         MyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739514681; x=1740119481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RS4NhYdSKIq0ZCVoddU4UM3ba+/5N5wTfgewbJrHpVM=;
        b=VZ+s+BRTvvb1TySWDp+5Yqss5tbeEWkqofOH7FTlYMYHEgRESM4P2g9ECK0GbYS+RN
         gxQ05UfV9NddfE6HWAt6LIXJefzray9RyDfKVid8RaJw0rseoLmJ6YIrFSZU8N+Quet5
         o6qgKXGXGYkK6vyKAZD+Rce5Mvbl31BrV3XdTc23Hmkvu3ny9sG0EAkoIJD3xTwHlOF5
         1SUW3LPUM73BqXT+jjWR9sRa6G7MV7RxUjAlvvUoa3mzbibNOoRA2fQPiAlG7FwSfbB4
         J5Sm3MVVR/Rc4lUPUNAgk1Nh9YMBurz+5fbDYcvDGPxcaK/KYd4dBxcZ2RRWn9vEXWrR
         LxRA==
X-Forwarded-Encrypted: i=1; AJvYcCVYi1HnuyVb3AVM7eLaY2Niy8AMaRdHhHU80TzahvdMy/gGbotlibVyeWufp5vwTslt9/MHOSX3gCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhnK53G7bOOaTR5QUB06tBtSMC+Eu+qBUb1DnJ0DRWKkORh5y
	zGV71N63XPsf+osJ1V7ZqIUlrEsodRGpmzF44YMXrilTQmvyoz0br3j44SYH6k0=
X-Gm-Gg: ASbGncssTc9LAm967BsylUMQp9htQuDuKVpOOFnZW5mqbqwtfzCEyBUx8TglVEWPR4t
	MyOBO3CFc8Z/OUjMqMsHsnXOqyJqWIZayCh6nNQKw1rWdqHFm/Rl0wemkve3pL22TRNnQnyQeLZ
	Ja+yBdmgtXNn9SGsfmjn7JvpGI1Hq6/hJYokfq9Y5KqBohjWCHDG7ug0hLAb69NPHzQmanksCX0
	bUcxQcJbv1yx7hUTM+nlwop2NN3ZOT7StH4k6n9VtoFgQN9KWlTOyzHaXjEZ7Mqc6hhKXphfqt1
	PvpXlPs1E8bpD8H0kgajzjo9
X-Google-Smtp-Source: AGHT+IEN/RRE5hxQ5xNZNtT7rJsPTV3GPjWwm8qrFkScK0MAqhU1b09AXyINMIOW8g0Zg6OABiY4tw==
X-Received: by 2002:a17:907:3da8:b0:aa6:79fa:b47d with SMTP id a640c23a62f3a-ab7f336d454mr924285066b.1.1739514680163;
        Thu, 13 Feb 2025 22:31:20 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece288e38sm2350948a12.79.2025.02.13.22.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 22:31:18 -0800 (PST)
Message-ID: <49ce4bf7-fec2-4d1a-aff0-e342b31c4f57@linaro.org>
Date: Fri, 14 Feb 2025 06:31:16 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] spi: s3c64xx: add support exynos990-spi to new
 port config data
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250213204044.660-1-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250213204044.660-1-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/13/25 8:40 PM, Denzeel Oliva wrote:
> - Added a default "fifo_depth = 64" to prevent crashes when "fifo-depth"
>   is missing in the device tree (avoids divide-by-zero issues).

no, you shouldn't use fifo_depth as a fallback, it's misleading.
fifo_depth shall be used only if all your SPI instances use the same
FIFO size. If that's not the case, as in yours, you specify the FIFO
depth via DT.

You need to determine whether your IP works with 0 sized FIFOs and if
not, make the the DT fifo-depth mandatory and check that its value is > 0.

If the IP works with 0 sized FIFOs, you need to update the driver to
allow that and let the fifo-depth property optional in DT.

