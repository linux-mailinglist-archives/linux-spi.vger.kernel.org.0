Return-Path: <linux-spi+bounces-10810-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D18C041F0
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 04:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD6B44EE6C1
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C3B25487B;
	Fri, 24 Oct 2025 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="NMW3t9lo"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75A1A3172
	for <linux-spi@vger.kernel.org>; Fri, 24 Oct 2025 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273123; cv=none; b=if3ao4A9LoogUF2bzj1pDejtU0dq+zrneP+mx/vmebMrnQacFfAWPowDmEMjrBRuBGVIsDh1z64fW6Mp/RDQzajnUPCamcrr3EkMleL7tQzwU5MCRxCKIRI/bhoC6SFy/0gEYUdi1KHo11z5LczozRmXO1Xo6mUJaYRh5Xkk9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273123; c=relaxed/simple;
	bh=55IQUxzDMcQ4mCOoGJfMg/Ei4ih5BPWUSJBpAl+kkgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjJZw3H2HFb/X2BCpp2JssRpqlb7JrE3VUsqn9DxJpZ6O31xmuZVwFrsDrY/KHQ2/sciZss6o2VGoGuVhZ4AU9GUwo/ZJoDTraupUGD1DqJh0RPveiWyfUbBEXivjjI5UoSTZ5J6gVswIUgt5Gcwxcxz974dBDGZ7a4RtkbPThQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=NMW3t9lo; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b608df6d2a0so1336999a12.1
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761273121; x=1761877921; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kzKUpWrMzxlp8IP1Hn+gGsM8P9oC4CEs0ABcpzIqxFU=;
        b=NMW3t9loBHUs5Vx9n99h5Ie6gpM8j5U7s3bDn3Cls/6feTVlLmHu38ep6x0QVe8W6n
         n2IlGcgxupOMx0ubV7gzywRzPtTM4tDdNvVK4GpTQw+qq8yeKHopehe2MO6D0rXhAI1T
         9y5qAv1zydNKTpY7uLfnblHL0bwTY1/xrtFiKg5DaDTibHoJc/x1EISWWoDT5vCHI00n
         YOSs7NewaFtmrOVN47KeDryanBPzb9SdIkRluWMtxvPmNKgf15RXWiO4URu7Cg+dFODr
         S0W9d0j0723K4qVA4wljg5EBs9gjMpXw0A+J2GcrHk5FQivlvjxakA+KLaEwk1q7JeaJ
         7qQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761273121; x=1761877921;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kzKUpWrMzxlp8IP1Hn+gGsM8P9oC4CEs0ABcpzIqxFU=;
        b=uoOVDSBg03atIBHAWqqwFA3TRbLivaXfurNOVS1/icKXoIU6ZSTCJtBp7zSpZnqWrL
         QIuckvxjlLmaZKe4TRkO/DYpbnhybRi2Xmb2NHWq63zyJUfF7vnC+gYIdc+5SXPSYvtD
         rRuPV3+SKDaPuU8q7BgVV0xF283Szsa7nFIs2XKGlbLW8W2Cnrhm+C3GAQ2Z+0mHAOtD
         LR7RKIgymDqib17opGcv7MeJPRNVlj2gjUG0qpI8NKKvTDMUjmB/fN8/je+qMpDLIx3Y
         zQwXF4n9QxhHuV2xASjY3nnBjwpeeJTgjoA9vyX4X8uXBiH4M7ahO8tVJsh0Bo4IeCyW
         n7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCXezdjUjHy5NLwEsBCkNCqUQIt3KB58Q9641/4zQBfb6h5XwaVUFQdA4E9aE/fLkSgaY+XHm50s2Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOh0U8VaNEQsdL6RtcOfsYyRvSyaJQOf36lTQ6SBG9fZR0VmoD
	7zLGVIZqNviyPUfe7PIa1SHCZgr37VAq1fxYMGa4d11JGIbrDmqEBbU26FmN6+HjGBI=
X-Gm-Gg: ASbGncukcFcOhESAsJYGqa/usbbmLo/LDeKaReXSlS8SrguvjsdMoYijNxhpSS+xp4X
	O6PX8OGioii+T+9u8NWyXA7FEhLwGVtgfDN7xdjKHPcApjxLLc70cAG6uLxL8HgiRPgb0hjsEP7
	lCo5w9cJRzWdk6KRKJ5w5TfRuvgygcO7chITb/e5dvW+Rd9+RZKf0wNZIlWbNbmz5CA2yl+z1D0
	5w9Mcmp6w9BKok7cJ4OmsbeCjGZXXFv4anxWYQmTonrqXFyuQtnglhpLYrH0b/d9YBbGnp+GmPr
	RoIc+eIkA9sNUpgzW6DPyx0U+NWPpu8TFXpkciQb7qncY5JS1ptN+i4n/K96qCJMFAWxhiDGUEY
	vc/i3s5mvljHRLddWAzpsg/7r+1t425Hrp8IQj9r9Io8Wvh5ncrwBEIGdYCzBAzUYnBriBY6x1S
	rTazJwT8y10gu1MGU=
X-Google-Smtp-Source: AGHT+IHA/K4QUyGTpQDn9ihnxw3kPWzudC8RYPggiHagQ4ZXS400Tm4j9rYxGD5oYzwHu+DSEJUE6A==
X-Received: by 2002:a17:902:cec6:b0:290:ad27:c1fc with SMTP id d9443c01a7336-2948ba7ccdfmr7272505ad.55.1761273121331;
        Thu, 23 Oct 2025 19:32:01 -0700 (PDT)
Received: from [10.211.55.5] ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0ef2fbsm39193715ad.79.2025.10.23.19.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 19:32:01 -0700 (PDT)
Message-ID: <ab1fae69-cf2f-4417-9f19-6383c648e4d7@riscstar.com>
Date: Thu, 23 Oct 2025 21:31:59 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] spi: fsl-qspi: add a clock disable quirk
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
 guodong@riscstar.com, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251023175922.528868-1-elder@riscstar.com>
 <20251023175922.528868-6-elder@riscstar.com>
 <aPq75FBuYvFQrbQE@lizhi-Precision-Tower-5810>
 <a43b6ddf-c552-4db8-89cc-49951015161d@riscstar.com>
 <aPrfSVEP5xasMEBr@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPrfSVEP5xasMEBr@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 9:07 PM, Frank Li wrote:
>>>> +static inline bool needs_clk_disable(struct fsl_qspi *q)
>>> needs_skip_clk_disable()
>> OK.  I was trying to avoid the double-negative:
>>
>>      if (!needs_skip_clk_disasble())
>> 	clk_disable...()
> Oh, Make senso, needs_clk_disable() is fine

I will leave it as it was:  needs_clk_disable().  Thanks.	-Alex

> Frank
> 
>> But I'll do as you suggest.



