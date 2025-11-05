Return-Path: <linux-spi+bounces-11061-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC2C36D4D
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC48667E81
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C87D335546;
	Wed,  5 Nov 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W34+0bjg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67A318146
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360853; cv=none; b=dpiU0pN3JhRukjurqXNVIRCBwD0kKhgFZ2pZRdtb4c2T8kABkB/YDXu32W8yEVZz5u7w0eFgtG1p5WJifFGAXasaeMHURnsiDt0+/QZ5i3DX+OaLhsIRxmRTdXSX9v43cvFzAtk5xuKrVNGLanSII4R/x6iPFW5iuJOU+Y4Orro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360853; c=relaxed/simple;
	bh=J5y3cvvKo5+9lQfpJmQgggsGD6TUmDXFlvyHA/c6DMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLj3Qcd7TsvVBU/BV43emlUskZ0+EIVBczQ4duMemvAb9V52QK9QqDpQNMj83rUCFAvYSZq8/nPBp1+sfN7ifBgoinKnbLfONeAqLzYfsHnJv1FcZ049zovKkqVAg+BI9METJNg17zTdtLXLtSrybbyCmkcGbIDZBWSiMxb2MjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W34+0bjg; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640741cdda7so9211098a12.2
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360850; x=1762965650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5y3cvvKo5+9lQfpJmQgggsGD6TUmDXFlvyHA/c6DMg=;
        b=W34+0bjgbI78Rx+fR0lg04ark2YnP8VK9JxyOkqWiouRBWde9OcDfYOq2ISUsjVkLm
         DuL5H0sgzpBeou5g7N0EUaxi1fmVAqvWC5z7n9BJsaGq9Hfs3vMlKcSEQDf6jYeVnvU2
         s/ADY+N9e6C0OoZWm4z56RogzYKWIa3/7q7ZL0uyUP2lAwNNwxDg/bsEhj6GNREZQ5nm
         Fkodonb6O2+AsKaS2mvnjLaQWHHUdVRrhxbh8l/FV62Z/NQ9SdBqJ6v7TByUYwlc8aH1
         69Zy4UC7Hg3y8CFxR9WDqI6qgVXJBVW3DEBwpX6olpk3ohMjLBrSCBucEr92fUeLfig+
         jpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360850; x=1762965650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5y3cvvKo5+9lQfpJmQgggsGD6TUmDXFlvyHA/c6DMg=;
        b=E7zsjUNae6Rgi7SpaQNhODpP8a9HdTwM6wT5JAZB8gzkjDG1eNAfr6GLIQh4ELffdk
         TWJa5ZsHM5u56yveQ8DV4lRPiBvs8P5256k1AXFYdkVTKz2H/5rhzM3o4TUjPaZfzVrT
         c/3BoQvGDG+D04HZwTDWgh4JVcRQjPU/wnOEE7PQA2WwwzDfmMWFnI9sji+22Cdwh6Yg
         W/sVXkDR7RrV6fuKLy4O6AMb4+zZp3WuZyudTU0/o0TL1kBKBu648CiNXaxUU31t2KvG
         SV8Qy+LeN9WeXXKIcjAG8YLMfNtQKByFpdNkRuWBj0r0i8NB1iugcmHoYCBA/dQ49tIc
         RZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCXu0EM5CjMaCc0QiCmtuZSkhjiCCDVF2mSjWea8J6uCBzCitnhFR8/hzT/EyUrd5NFGMsNBhBffIlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7lZ1piPX+xEMwAs1dElf+FkD+FQL9YKrA4vD7y7yNnrOVJpLQ
	rKMRNOf4lcu9iYZUIBEAxRlJwhGSarNXco5/KHS+301QSBiOxV9xDmsgaHHF9bTpeDA=
X-Gm-Gg: ASbGncv7LVJG7OG3WQLlL/dRnyt1Bf1gX+Eq+wXeUWbaDINe4S6KUCbg215SCywM5ua
	nhdBluq/KZJ4ij8V7qAY2OQt9e4BdnMOmNIUWbktkScLM7wxF5RW/HM4LDyZs9WVZqJxzgunhHN
	Lg+kABqkeXhttYlwpar5uugkLEn5pC4lJGdT4YfV1yTEEQL5r/bJ8z+jwSK08S5o8ZR60ZgJtD6
	9i82SY9v+uUF2Q7CdBY8VTWKp6g8NioSrLwOPlAlFuo4zZ4jlrOH0S0rLJBzxTNbUbSefc5NeNC
	bQ1lhN2uPM7XBRH77mCcHGUxptqvOcVZhjVVztFg1wcCpmllvZeNSEBlevX92AvChKOXS6bPlsF
	zc5LuEoKROIUkWM6cR3ROvIjOTsoz3W67M/GkUdeQNmhP4pw0rYt5D4+yMAFUwbKheTcn7XU2Rt
	ovhkbRXjbtQDLoiHS6h7j6+8k=
X-Google-Smtp-Source: AGHT+IHHiXKeERAxAGoA9dz0LSZUAmCzTEFW6Xdym3PQ8+7oh8lHWXBcPCZ2UhPmAtNDnOKZfma9sQ==
X-Received: by 2002:a05:6402:280f:b0:640:b573:a30a with SMTP id 4fb4d7f45d1cf-64105a44b13mr3577815a12.22.1762360849881;
        Wed, 05 Nov 2025 08:40:49 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a5c881sm5086735a12.22.2025.11.05.08.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:40:49 -0800 (PST)
Message-ID: <e469cab3-c0d8-4d68-8eb9-4570ded1884b@linaro.org>
Date: Wed, 5 Nov 2025 17:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/28] mtd: spinand: winbond: Convert W25N specific
 operation to SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-13-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-13-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

no inline, good :)

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

