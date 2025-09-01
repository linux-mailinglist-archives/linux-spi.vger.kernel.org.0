Return-Path: <linux-spi+bounces-9833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC4BB3DDAE
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7DC3A257C
	for <lists+linux-spi@lfdr.de>; Mon,  1 Sep 2025 09:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FEE304967;
	Mon,  1 Sep 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRO8+o3o"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12E3043BA
	for <linux-spi@vger.kernel.org>; Mon,  1 Sep 2025 09:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717824; cv=none; b=IUDdN8lAczwc24qR8ytnUHxqJ3qfSKTfZUTBRS2qy9nvDom8oF+N1AUgJHpL/whtNTmceU/2+vIS4+zAICKcnHR1sLTqH/1y8bWTa3Wf08mOsulj+BniKIi84pyOzBlT1lNSYTzk0cEkkKM3kD8wBMfKEMPmpUeVPltPq0ADomE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717824; c=relaxed/simple;
	bh=wHuP9vzcf0uxMcxpVzhAD7blzq8KbpGGUt0A4O2FaOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dxFyn2PM9ELg6OtVcd7qVlAdfFG3sz5BSLmO0kfxKXxPNYR+OyJFvEjWW/bNy7HgDxccsIJJGSLMvNUVgoTMWye1cNh0aLmbYFCBvqqSlq4tbVjK2nUSv/5ZhBH6LVYbnpkWJJtM4q7DJ95X4jvVWvwPaJijyQtPemNKlbVbsLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRO8+o3o; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d1bf79d6afso1286433f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 01 Sep 2025 02:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756717821; x=1757322621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=meHf9Dzi9Udu3DdPaq0IFaV1tFMGI7amWp2ppks2KVU=;
        b=SRO8+o3oq/Dqw+Ci1/BcDKx92BuyYldu3U1V5pzVWYIVKDx9k9a7Iq8y51mMnyPrk+
         m4+TPHniS6D+ZkZP18GeXW9i6MfyHIzPSTnAVbjTMesPpCTwGDUNWMWOJvRTeu7lWUnE
         ZCI0TtT8yoyjlCPaa12lnaNRWb7tTb5wsUgz9au30qLyFGqYgOTchOR1RbVzoJBqENge
         seOV6Ge7iP5ekg3L1mVio+llOypLGJUDQPRjalOoWJ65LM4zajLqUYK+Q1LDgo+JvHwe
         mBeQj7pQTnB1qGdFLLCIWb30EgI370k1C1FnwtI+W1FGn3HM4kT+D8U1nbdHI1fJZ4Fz
         9wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717821; x=1757322621;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=meHf9Dzi9Udu3DdPaq0IFaV1tFMGI7amWp2ppks2KVU=;
        b=deqUfeaAYStfqIs5dwJ+b44Z17plLjJW+QkVe8Ka70YVBWVA4wpEZ7ngeIutkymCRA
         +piktnkct8c81zc8k6IP0vbsmZMsDUrDjEbnXI63O4qHxm81cb7lmUW9n7c4X7cN0TmX
         vaKpFOV2C8eVvSmVbEgh5Ku1l84uSsa5qrf81dKGa6tKRE36y8zCzjQkBDyAhxHHdmr7
         43UIS9lT4oYwvUP/eblYv+9mRMw5he7CvUESNGbVetBlQSGbn06NglJcYwk/y+tn6nXF
         Ug7xTyBUKBr9fAnf4qmlKWoESyyLoxXsCPUP301Ml+BlKEqqCBxR5Z93e20OWKEvTYaQ
         ptew==
X-Forwarded-Encrypted: i=1; AJvYcCXqz3tvi98FIYZiGGhglsUQ72c7vONPcPTNFssXH5T0tlBCjkwfXT/d8xE4KJApVFXQRA8zwdCVAaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogILB2i0OTLHxX1YJIZOl5nZ3Lqp2ZtgokOvhoVb8JRfxfmsg
	tyiLV9JCOlIbKxQZW1crj3doGA7ZnMUwrInqwpjC1pOa1EwVHSB3Xk1m5/eJWM3n+oY=
X-Gm-Gg: ASbGncvvZwiJEXcA9XzBR9SHWyffWQWIS0E9gXxUZ8KiMlIp1xlm23RbS7Hrym04X4b
	SDYh0Qcb9oCh6br/rRu89niP5qV6+xAoz6JNjYvQwr1Js1D/Co17gN7XgSf9HZVg1DPQBHnPiNS
	HjzttfFIra93gERIGq5EVOLZegAHZRyWFnDS4DIbDArgc30JnUjlOPcVJ0uzbWm6QBqIFQrUjKs
	9Z+ytJn8DWKsn8JU+4+M10Khzkz/fYU+Ushh6gg/+n3wxBz0tB0+shB5v2m/yjXR/856YvyPRw6
	D6e/YrtdhFbJmc7Dju2M5hNelLgZ/954/SLlZifywd4nZBvsaj6hvf7kE65iAWGnXgNz2hdMEpO
	TC9nDxZS7BNI8iwJVX4N3bSP1SR9ZNdYe5Mw9kw==
X-Google-Smtp-Source: AGHT+IHwD9wQkYnnHFPyCoE+oRse9cNjidrfIe1Wag1mwkgXlb86FEc301H4rWNpqC3pM6+30woB+Q==
X-Received: by 2002:a05:6000:2011:b0:3cd:1cc2:f411 with SMTP id ffacd0b85a97d-3d1e0a986c8mr5227063f8f.61.1756717820994;
        Mon, 01 Sep 2025 02:10:20 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d85f80d8casm1010533f8f.54.2025.09.01.02.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:10:20 -0700 (PDT)
Message-ID: <7a40573a-1868-4697-bca5-fb22aac0402e@linaro.org>
Date: Mon, 1 Sep 2025 10:10:19 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>,
 Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-1-3246957a6ea9@linaro.org>
 <20250829125440.fuxwiekll53myiui@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250829125440.fuxwiekll53myiui@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/08/2025 1:54 pm, Vladimir Oltean wrote:
> On Fri, Aug 29, 2025 at 12:46:43PM +0100, James Clark wrote:
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The way I'm understanding these tags is: you wrote the patch, I submitted it
> (which is not what is happening).
> 
> I think the conventional way of describing it is:
> 
> Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>

Yes I agree, I took your patch a bit too literally and didn't modify it.


