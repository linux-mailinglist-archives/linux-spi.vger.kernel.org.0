Return-Path: <linux-spi+bounces-1083-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516184B34C
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 12:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52EF281938
	for <lists+linux-spi@lfdr.de>; Tue,  6 Feb 2024 11:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E293958131;
	Tue,  6 Feb 2024 11:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Emd4rPro"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DE312B14E
	for <linux-spi@vger.kernel.org>; Tue,  6 Feb 2024 11:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218378; cv=none; b=HV68O2j8sqHEXfDxt3uateAWSltkuArYcUKHj4tDuLtPerIuZWLpkcYmeDpsOzDsksMg/VFXESSRuljuuI+ybjhKbN733eVB9t9hLEsYP1EZCUZfMmj7hiYIxxKLa0YEjs972O/nZ+TOdRWkRap7+Eewy65aEEY318IB48NYRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218378; c=relaxed/simple;
	bh=05SBW2RoA/3K/8YQO0Gnyq+1QSApd62hUKEdwlkTng4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8gZEljcw36sE098vU7IRoatGlVwiFPA0bM9BQp162L3BjRXUqehVLNkh2kma9VmBiZipQOz7h36eUgWmxIhChpatIVaQZ77E6vxY3i9I2zU6dzSGaL2jmImWYKKowzJHW5YTWAIzxJeBGH46I2baatPFktD1S25U2Tj6rU61lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Emd4rPro; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40efcb37373so6200155e9.2
        for <linux-spi@vger.kernel.org>; Tue, 06 Feb 2024 03:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707218375; x=1707823175; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SNpmqyJxnfCh5R1BTBiPSOmEnJKZc/yAOGWwkfGZJqE=;
        b=Emd4rProubXt7OpdySUKtxvFneQRpgK8pYClmjoiX0SrtLvgEU1fZQGwFNSgakMFVH
         bkiWdFabaXMwiQQRbuQyvtAf1aTAWRgXmMOiGI26Qa2ICsO5hrnwt3Sa1gEAPqH4PlNg
         kMY0tBkp5AWzOhnx8D18AbE3pO+1rh8GHuycNYnZNlyEPvzDglcLKiKyedzBOp5ozp6b
         EzjEBC1aCn+2JuLbOPZw/E+LvSAInzlMxNaCyMFoUsb4FMpJ7F8CnlUvurlLJSpI0LHq
         tVc5zqV6sHC7gjUVgBpd+MxcRCNhHR6XTezuhnAz7l92imKvdiS6FJWZTjdamWISH6gJ
         QrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707218375; x=1707823175;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SNpmqyJxnfCh5R1BTBiPSOmEnJKZc/yAOGWwkfGZJqE=;
        b=jFAIzD938oqal2i41Rn6DnvsJvPip6BitTD7H4AEiQL1GAslgjlK/tjvnEFFUItWBf
         pEcPwFe/OSH0CKo53lcTpO2AWYPUNsbiRV8DwhrAg9ViXkvAeXDyKuXbrZcgg4yR2bEA
         iDLpNWfuAqCT2QIpzlz4DQkr5eJKYjnu4xzihuXD9E/ldtxmjPHQeZb/B5sC2BX/nvGF
         LS/ABo47tMMSNCYljoku0gZXz+jeM2r/x1RCpnmrKalEjdKJYWkRKNN1MHp15WHtImS4
         y6GRzkeEGbgJKaNHbCHhqw7UzZLsgjuii8YDN9WU3bAlGYUAaF8EOP+XS5Sa818FLnZd
         jv/A==
X-Gm-Message-State: AOJu0YzUncGmeWdIFaBjlzEtPyEPF9ahtkrbjgcl4NYRsKojNWkzL1zF
	7aiT5JMKxfndck6s1doC2afWu6Wpz9MLcNxyB/6OfST4hovjy6vcT2WahkqbNmM=
X-Google-Smtp-Source: AGHT+IFjT1Ydvn2sv5V2yh8bL/NCBlUPaNM+YZt3iGNOjRt9GuolrvDTXzr6SS95u7t+EQ6TQH6hZQ==
X-Received: by 2002:a05:600c:4f8e:b0:40e:7d8f:6b1a with SMTP id n14-20020a05600c4f8e00b0040e7d8f6b1amr2157121wmq.5.1707218375391;
        Tue, 06 Feb 2024 03:19:35 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW/7bw9GxgRT6lT0V974NgAvuX45uGhaWOue3hlgthJXjdo3VAWQZgLcwNb6jALIecCLaC0fq9xwTGFqhKXzSbuDTvQyEV1EeUJWy0zx3P7lO5hTu95lsEMXM7rtuiF2G15dzlB9yGn5D1vhXDOGGOIZ48x2Riz6bKnH9A3yMizJgEa8TwZdd93VMTvJegYb7D0KmfLbhtF7OOT7DFQTSC38AQBvyJSEOn0xuqL9Gjxjkc2x/ot1ytZcQngaoMPe0yJuCl3r1feBesov+VLP9A0rEnAr5pOemWAlg1xXVPlvSU1x7emubM/KP8/uc3iQmKUBbLwdTLNIR6mGLdWGwKQjAy8aNMyCsdaGTNnKwNJy0mTOLrlqgX0OwgKMY62SxbonLwPiQ4hA6MTPS/+GNXy21R/yuI2OkeKbZOFmEOGAMbxwjdZLYXxjgWG7XTG1uzZfEDPRBQvoKINk/l+6Nnodj3BZML1WcHO18UJG6cSvD1qwVRNZR3Jhx1Xvor+pFdFq/+OyProJr4VMKPFrfv8ml2XCYO6TGiZzzcNG0XZa7O59LT4GIpOPHmeUKvDcoI=
Received: from [192.168.0.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c300600b0040fdd8f5e18sm1612761wmh.34.2024.02.06.03.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Feb 2024 03:19:34 -0800 (PST)
Message-ID: <833b96e5-348f-4c5c-b157-c57c9a67e0f2@linaro.org>
Date: Tue, 6 Feb 2024 11:19:33 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] spi: s3c64xx: add support for google,gs101-spi
To: Mark Brown <broonie@kernel.org>, Peter Griffin <peter.griffin@linaro.org>
Cc: andi.shyti@kernel.org, semen.protsenko@linaro.org,
 krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
 linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com,
 robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
References: <20240206085238.1208256-1-tudor.ambarus@linaro.org>
 <20240206085238.1208256-5-tudor.ambarus@linaro.org>
 <CADrjBPqaE9Mmbr+zkHOAadr3aLSu3GMjS4nPPd4VZY4s2DTznA@mail.gmail.com>
 <ZcISMLoB2ytoQs/0@finisterre.sirena.org.uk>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZcISMLoB2ytoQs/0@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/24 11:04, Mark Brown wrote:
> On Tue, Feb 06, 2024 at 10:12:30AM +0000, Peter Griffin wrote:
> 
>> The patch ordering seems a bit off with this series..I believe it should be
>> 1) dt-bindings patch (docs first)
>> 2) Add the use_32bit_io flag / functionality
>> 3) gs101 support (this patch) that uses the use_32bit_io functionality
> 
> That's the ordering the series has?  There's a random cleanup patch
> tacked on the front but that really ought to be separate anyway.

I put the include <linux/types.h> patch first because I considered it a
fix (driver is using u32) and because I need types.h in patch 3/4. Fixes
first, then bindings, then driver.

Was I wrong?

