Return-Path: <linux-spi+bounces-11059-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27296C36BB7
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B3718910BD
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2632F32ED57;
	Wed,  5 Nov 2025 16:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XJwG80bY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549ED3358D9
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360225; cv=none; b=qhI450YcVWU9b+ERYVgJr5JrsCrIUa51Ya5H7A1OKD6yrKZ4uRNGBVRDVIaTeKRFrhlwzBck3zogoWA8XP/60TDVb8cTehBwsWbB4exC95XXgllyPCldjAVYPf/jkDs1M1+wYztBgihxgKIpKgO00y06QDNLh1UqAqtIGRryak0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360225; c=relaxed/simple;
	bh=aLMWc2wz0lR+J9epmU7ClTbyI4cwZQ7jLjWyLp9sQaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jUIJEH5nmeMqNMc3pJP8joIWPEMvOLZ7oP+p7oY5FH4JLlImhp7JPahmlNEhQ7BBBk279LLp7SkmRwYRswejvm1eHlnTDHk3kZSvmlVSI/JDAQX46mRJr/ko9IwJTQr5m/8pycmbqNGO6BRgdRv9rMD70wCIdi717VPrLEhBVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XJwG80bY; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b7277324054so1253966b.0
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360222; x=1762965022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0ElpEfU23zmMJp6XAE1iet2IvdsDeFlwy28hHUB1VQ=;
        b=XJwG80bYnUdB1x5t2V1mvvxGzmfX2iReVIBu4sTdXpahTpnRhGqH2OcNhugni2L7nz
         l14ElFYtblMAXTJxOZlHQ3tQ0rv8Wq9NIYcM9oPK6nUAJFy4E3LiSSgDzf2tfEAXs1fU
         37/r4BCerfxdnP4OFHN2qRjJHDcLW2Fbr9M8sUfIMI2zmffNtGRAD3Gfg3xH4q9M21rx
         lYZ6s+fZOBX8R3UvsgIqUJl2Np2cRj2+rNqsmkG/wgu/pTGiwLBQStvztTxfMM8uyQyh
         369bk+xt8WJtIXuV20ts9iJe25fn9oe19pplIHKFSG8e35h6Hf1kfmp6fMnaXGVzBNKw
         uyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360222; x=1762965022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0ElpEfU23zmMJp6XAE1iet2IvdsDeFlwy28hHUB1VQ=;
        b=M66V78iZT9CfTsN9x6AgqKsH1TuouGpahZVfqQG9rSAkYhU0Yg0sACMsdqgnB+NZOU
         P0p5sHq/oDX528Xl6iPotw+JlDJL7nCMEEOcuPWaDf70C9kogphRfCj6T3BHguv/RlTn
         SuNu3jToKMm/+/0dhFxFwtndoVgB0WQc987+raS4K5Hgo5z+mUM4nj9XOoCu5/3ufFv3
         k914LU48idl1HRFanmrEL6KBDYcYnpnnR6Xanptstn3nlSDYj+3LZlLVf8rwovKzZioo
         9/BGwoUEo6L1Jrwhp/rqtnnx+5LKLJchaxMgd3yovKkijLPGgtrP2boDs60GU/dvKqbI
         7JdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYo8vFA6TcM+QQacryGnQyigmYoAwl1u2UgDJXogP8gXFXRws1nsLCFKQPobfBkDC/9CK6W5FCcO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrDl3krl5FH0T0ol6/3m/VWAKd5C4766fPQ5M2hafEbEwAaHEz
	f4PDPEq5vNUfiE6LdyCKTbJequIYPPpI3Z6hfSw/JmS45pagu4N1ihlTzNARPV8ELmA=
X-Gm-Gg: ASbGncvW2ovsh/RpGoKTD5GGg8ukS7ONLSQYdxJbeWQ5e6TWOyHMwJMqqnwLV9/TjhE
	FcMFUtMJj46IKVWKyQPakDANm7G+2vfc8rT/Lkmnh6UTZ16dCXmkUegrmG8iXKhQYJiQUIe4RUe
	e19wLPyqZsQW8pJKOpP6IbSnw/xP3vD3ykHdggioASY21d3TuExwQW0pmfG40PunDfJchtEF9Hr
	rakdrNatmJGdgHTtjOpXrleWzqDX3P15WJZCse7fAYp42dD4ZP5WXru3D5MHB6+8ebOIOJ9Kqr1
	co7DqBbMxgyyHLSRM30wPV/XpeONeXCUrThWvdL3WTQK7QPWTuWC7ZojGjaBUZ9H+hQplM2nuCP
	fJC0NEDjcPsmer9HSbLp3ZsLgY6fLZ0+uZxdjoNwUecjgCv1nPLM7xhKV+t5u470MlND25SyRIw
	LvcnPm4wumqskt23Fm6N3kCQO3EMMBAVxQtA==
X-Google-Smtp-Source: AGHT+IEsYpuKCxcTkA8jk0GtWL4UNm/KQc74RM599U6pQuabiThT7lxCazj2PKzyq5T1ntntU8gerQ==
X-Received: by 2002:a17:907:3f24:b0:b42:9840:eac1 with SMTP id a640c23a62f3a-b726553b597mr370430566b.49.1762360221599;
        Wed, 05 Nov 2025 08:30:21 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7289335c6bsm313966b.7.2025.11.05.08.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:30:20 -0800 (PST)
Message-ID: <d77310d9-f865-45cf-90ae-ff542cd1140f@linaro.org>
Date: Wed, 5 Nov 2025 17:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/28] mtd: spinand: Convert vendor drivers to
 SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-11-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-11-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> This macro allows to silently switch bus interfaces, use it outside of
> the core in all places that can be trivially converted.
> 
> At this stage there is no functional change expected, until octal DTR
> support gets added.
> 

Shouldn't this be squashed to the previous patch?

