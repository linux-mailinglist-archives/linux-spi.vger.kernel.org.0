Return-Path: <linux-spi+bounces-11044-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C857EC367AA
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 16:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436D93BD4DC
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7A525F984;
	Wed,  5 Nov 2025 15:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Az15c20r"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3FE258CD0
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356915; cv=none; b=YvtR5/f/J/f+aeRcIZp7REadG7Vb+5AdlHcbdP329799EnpzJrDbmmz5IwYwK50KRla+8dMqkeuRmoW4JH51plCGVZEYfTUUcD1ZxcnQHYfoT234BHGJEu7F9xi3791lr+FNrH39WI+xFgIjddwRuMkDe7ZbpgOA302yl9/aGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356915; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bd+UNjaXGvKkREqUxbGTKQvl+FfNMXzPowydMKdJ44vHr9KjJcCyTZVu2gXoFgcR0x3C6n/XfJCBT0HsuGlihsvudnUQ6wv2f6vVzr3AflrKUDAnpcCcG2+KkpNII9uDUXitVn1wAHg2LUz3XZXhUkYl68pikbK+0sE9xKRujDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Az15c20r; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b4f323cf89bso479842366b.2
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762356912; x=1762961712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=Az15c20rSkoYvwPxvUVQJIrbQfSVMngmjoA/m25zigW1HKN79DAG4lMJSTpaq0dgMY
         OSRboyigHLIEhKdN9YpeAvM01bojHSnCRWp3MTzKXw29F/GUwd7kW7Gczp6PsgvsjWkh
         AN6FBuJrQhyEoHJNpNizQEWzBJQ9z3O5Vd1F44BUoZhAD92vEUMHGRg3GMx9b9mZPD+q
         8mb7nV1YF1nLX99iun0aPtT9xAXs8CIUcpNT5lxa7QNOBhuaAt0Cfu0vcZpcN6iJerLG
         b3JwJ7lgFVUwgsiOJluTjexeuA3WfSz7hS5yTnLQEUaYqDug0LQymyQ6qGRXyQGvT4ll
         AKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356912; x=1762961712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=HqQPkyvtKr0CXRxnZ17v1oDsyMIBQFXjpbpXV2Rkqq+BjM3fUvA/dqHc8H/3iBbme+
         3rZ87GO5KSLYTMnIl6fiKXuX+oAF+A+rIuDrFN6Hv+JqqUMFFIGdU2p9Ex5sJkf4q/QV
         dd4pikFEzU/K9M3eEK9joNmX7Db74J71DjkG3+f75cgbT1N3FfdVV4mAwexiVXEIKgVt
         xDbmjTF8cH0Ek9VKNwNBA+17fylo6gxbxE4eXP32sM7S0SIuQs7MDddCEm4+DkgSQzoJ
         ie5oR61SPwYyY/F/0ORlXIIgv96Q/c62eQcc516sxfBzfYn5YN7r7Q3L32svN2SnE641
         bW5w==
X-Forwarded-Encrypted: i=1; AJvYcCVJVTfLcGE02UOeTWzDJviAUZvNGMKKVBKoQox7notpiDn1oh+0DY8iKeHhctE7FJ4wPUL2LuGAeDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrYViWWWq+KE7ek569sg2pFjjsCDTvbSOcyQ8+EORxF8ZsdK/L
	aiClL7L859I/P+QPAZqKGWCjdioY2zKkOSlzrLBY4tsGyFX1DWMyFmSJIpm0rBgt+GE=
X-Gm-Gg: ASbGncuwX4TjvYJjmB+wJaej78t4WarUKZwSu78zhLzkORilwnJ0EMNr07X9DaEnywS
	migzUvI1k2ZJ77yYyYBs/u8Tu9NxHBQz0JE+2ZALZFtdvNQqgJd1ZPH4OkACUtR6eZvaBVNxp6X
	UXnvt2Ui+B/5mVxzxCT94ejZZ/1CxctBp7TyRatuSzFjIOybPdvlfj5AxLfgwqsmGTEAbqum8JX
	p4XH7L7SQOli6QKqqT3LdrTDH+7MumfANjfADrG//2fb/TORqjbO2ZKujiZex67e0Thpu6o04AB
	2tjNMxBURPlnaO+o95K8BtcjJQSsTMjuX4oDfUyYvBnIag4qrIAk3GTmGYGEHl4tpbVeyAN5rde
	Q2hS8fjMr/SGvchUto9nmrO1FTbcBIH82kyMfhFTslHdR47fGEh28Iol3wJXXP9ELe6fWPLJCBu
	NLWDbPx39mdc/4lRPTQMj6ino=
X-Google-Smtp-Source: AGHT+IFck5XRDPyHoaLZAuLhkGx4XDGyeWcDyTrgg5x4OYR9WrckK2spEl21YFRwG98d8k3Tyo7H5g==
X-Received: by 2002:a17:907:2daa:b0:b6d:5840:4b43 with SMTP id a640c23a62f3a-b7265400cacmr325257066b.22.1762356911886;
        Wed, 05 Nov 2025 07:35:11 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b726ae98aecsm178597866b.11.2025.11.05.07.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:35:11 -0800 (PST)
Message-ID: <513be88b-a205-4cea-b9ac-fea4da968f91@linaro.org>
Date: Wed, 5 Nov 2025 16:35:10 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] spi: spi-mem: Make the DTR command operation macro
 more suitable
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-1-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-1-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


