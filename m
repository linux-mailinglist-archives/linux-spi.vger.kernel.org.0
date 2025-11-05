Return-Path: <linux-spi+bounces-11062-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7686C36CD4
	for <lists+linux-spi@lfdr.de>; Wed, 05 Nov 2025 17:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FFF686390
	for <lists+linux-spi@lfdr.de>; Wed,  5 Nov 2025 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA4F337BA6;
	Wed,  5 Nov 2025 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrHzyh8Q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C59338599
	for <linux-spi@vger.kernel.org>; Wed,  5 Nov 2025 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360873; cv=none; b=LMoSCqyu4UP/n78T2QLwZEpewVib4zb2PzvwfbWHIGriA3WOxJh4oFxVH2ZITJLifGThhWeGLVQP7kZ3g3QeZ9WvLYLeHhf9jUqjmOj3qEKLQrySlsd4Ytjad4vNCUjVomnzbIK9KbcOhyrtUklyfe2KHvugCiw+71TXPw9aCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360873; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7DLUudrxfxXxFw//LHuy8t7QDLWBN8+qjSPPK3vz1Y2+MSYJCP38s0oro6mtLJx16TkZ5yviCxxnH54e9952VLgfvO+p9/csVlj2hU/2s5MesE8nOrB7XUQBVeXhak50JOkU3z+AMkqzg8lR58ECGAy5l8472q8RDgcNqEahe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LrHzyh8Q; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640e9f5951aso1875185a12.1
        for <linux-spi@vger.kernel.org>; Wed, 05 Nov 2025 08:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360870; x=1762965670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=LrHzyh8Q+KFvMM0AS/i9mN6l0K9Cz8QSgH3yhjiMSJ4bm6QYlSS6AoSb8FTb5y+7UI
         eHH5FIsHimyKzT/HcfDlWl+qZpsEQrB6J7XgrPPmSphTip0Z0rGkldJUznTI3kzbxhEt
         dj1UDE+txIhD1DQ5vBf3o0xRClMES2Z5USGG3jhmY1/g0NIhNti/b7XJ9iB4BsOZoKS/
         XpFbHl6biauCICm2yHl5d0A9MEEmJ4hZgwrdwGUPgvWWKoKV3QCgGrEMRiVQeJA/2HG7
         rf/osDUzwJVwvBrPJYxix6xOupAsKY67mtudzDqsAvXBz24tAFbyOF0YF/VYE8lPZgC5
         Nebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360870; x=1762965670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=AWNTQFXgM1gZrftJG6X1yR14SzOpuStO6E2y+TeGPJKKFu0TqLhcv/QSr1nqdXBP8i
         HTzHWN4Xi3iBrXoygrRE94A85mwzGTi1etNq43dGBZp8a3HyyC3QfVVNk1rIcP9+vy9I
         8qIo2YHMpzd//Td53GLpaYnusn6HtInM/x7SS+qneW/o++gkKVvDrs8+hYlPsZluYxe9
         vWgo4lF+FPwWOWzleMBrek9cJa3+sG/oDHZe8cpHTPkwTy/OZ9RcakSwALlRGhTVRe3G
         22DScXt/J7s/I2B/wf57lYe3pWmBIMcyK5Mi6femIDhSUTK/Ek11cXRTWxpjV5Hs+nC5
         0alQ==
X-Forwarded-Encrypted: i=1; AJvYcCVykUFWDvAhcoByVCwljQvdv5zIQaPjh3MxohwxXFt4zo+332E4/73s0nOWQytQmFf3OoWoxeTF2AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm5QHm1fGVscaayVASJFv+ZotskXr4Mg6LDe9pNcqK/p1Ugtcx
	M8NBxsJOzWtA/tG48dGAN6YJMM4v5AFkLxOFP5B+PvMKQS7D5jEZj9GBUwarNx+ZT9M=
X-Gm-Gg: ASbGnct9vG8fFuMLCONI5+FWExGIcudbb+BFIgsggebzKMh5VJETFvdc6y/Y3cTzODj
	LtGFv3QBLEYs6Zs8W33C2bGwAdsVuO8kYIq+zyTMPerBXyELpnGDuXANZoUPJHMnotXA/OIqemm
	5QgutKlNkIbrLJDJCmmTlE1MCR2uR05IQMPZEDz88GxHmRGLOgIruWWRTYxpeUk8NyhPcJ1wlOJ
	sdfJ2hd9UvqTtmkESUGowAGij1Q1e4mDTx+p7LVeLwymb9g9ivZigtQ0rQIV6QOp8KiS6LXGbpX
	8Gd0F8bubikWCZdEETioh3R0zsq0gxOPxyou//VI3okRGQgYnvwzITZ77g307Ak24Y1UBg4uePN
	y9+UZK1f4nORdY9xNpV04uYL3eyO34iMq4zRLFRsS8gYXYDu68q0d7VIuI2JIK///U6cQJOW5wO
	hCOkWH85pU+H+nScGFHDVCqjA=
X-Google-Smtp-Source: AGHT+IH2mUi79RN7exis38BOklTZsMNZ/FgOLFTlEt+kXnDPqwAEesKS5Bf1yq+oownV33g2WMoY3Q==
X-Received: by 2002:a17:907:9614:b0:b6d:6650:c3cd with SMTP id a640c23a62f3a-b72895a01bfmr1936866b.21.1762360864962;
        Wed, 05 Nov 2025 08:41:04 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728937d88csm1932166b.25.2025.11.05.08.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:41:04 -0800 (PST)
Message-ID: <b081a4bb-66bb-4825-b33b-52b55649cd36@linaro.org>
Date: Wed, 5 Nov 2025 17:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/28] mtd: spinand: winbond: Convert W35N specific
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
 <20251031-winbond-v6-17-rc1-oddr-v1-14-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-14-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

