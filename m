Return-Path: <linux-spi+bounces-4717-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FC496EC2F
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 09:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56851C21E90
	for <lists+linux-spi@lfdr.de>; Fri,  6 Sep 2024 07:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1FD155335;
	Fri,  6 Sep 2024 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cB0wo8oG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532514D71E
	for <linux-spi@vger.kernel.org>; Fri,  6 Sep 2024 07:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608344; cv=none; b=htuy0wZqtKbMtZ089HOHnXSmRM0Anu9gqr47r9+eePKVAGnxqB95z62VTaBHOdUsv8hvh8h2KOFz+Q35X7nIu2umdYv8hwfaz88TdlOwi6QaHWWOYmK6RkI1idaJ/cSHh3emzkeO/Dq2gZkyKt8NLjVx8ZqO/WvkP6NJZDW70t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608344; c=relaxed/simple;
	bh=/VfN5TZBKFESX0ktdJnLpkP+3s1XJrbvW7+e2JjstSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z7A2HiPADBetCQqKS6t8bEK1he0LFv8DqYxEcQq6UUD+AMNL0LdioKWqU8HuhArzEZPg4uvT7KL3MUgUtCjaF9laCKrRjgzMcHIKTJAwuK4dankzZK7TbjPJ0fixlIpWqSPdsdXQ0H5qmZFfjPdG4Bbr+bg29LvISHocL7JWnnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cB0wo8oG; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374b25263a3so785990f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 06 Sep 2024 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725608339; x=1726213139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xz9IdLmzy/T20GbDRPSYjXR1GKGx3xeoUvnivTDuQzM=;
        b=cB0wo8oGQ4gkqzsJUvwKF2bKsP3JPyJcvK8bOlIjlrk+jEwF2DTaekiQ5x9nIxU/UZ
         HaCsFa7RX/okxuGsDJAAUa9wIbIqORlQfJwHEEqjhATDZFBZXnh4K0gjB8TM9nBNytTH
         Lpx4ZaujIBV1Y4PChxe/m+H3cnhkvFDulli0meNFfyNDTGKB6IYEnbfb+WZVDITwgwyf
         Mtg9oW5A2dL3K3TxhVhVOTy8lY0hnWAOlVabsmGFF1FagxFC2iQ5AdRCVdjFdzQ4DQI1
         aRafG/lG6ZWwZAaCW2b0/DfSRhZ0jDCKGlajtSZAp+/RjNDaPd4p0xjNgqps9c0zsTCp
         8UzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725608339; x=1726213139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xz9IdLmzy/T20GbDRPSYjXR1GKGx3xeoUvnivTDuQzM=;
        b=ifa5AT1Ta/5ih8dYhCXlee7Ph5VYOrj+91vPU9VoiFZsMvJ59op1VjMzwmNzv/BOpH
         OTmAsaH/vXrp0dHj5cI3XnZXdGYJzs2iMuSTCFG1xYkguJ4vK5MGuA2xUkfy2DWo9wuQ
         r/GyGBuIVg9Yo20ySusRNcV6oHw1S9puQna3iFtp8CIZUH0C0XRKUBkupeqPhuLY3cYZ
         mIB7r3FG4ZrpYkieLWRg/zMhgiL9cHtn++z2cE10DBr1+GDeafSwhwZcyPgOdDC2uSDp
         ZWRPWVo1FxirSz0Ehqeu8fC8Q/ptR+QHXKKNhnZ6MWQzg4rh0CCEU823wHYnVTPYnfvn
         1eDg==
X-Forwarded-Encrypted: i=1; AJvYcCXaGGd/8HKc9HgyHbNYvxCAFoD4kR8PnvDijQ9G+IEQ+2qzoWd+vmqO0zVkjhF8mAFGi4vfJpuHV9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7pbcrqJYNcUwaLE4ZhMLID/nSCI8BUJHW1vN1bIK5cuPWAIqh
	KTCX6hdithRuTn+kVwCNerIRf3y2lpw7q0VlxyqUyL8bRWnS6O3y8syJxoDMzk8=
X-Google-Smtp-Source: AGHT+IGFHwFQ99mHOKHLLsrCtuLnOv+VrrxaTcWgKFCATGwuZhLv7Zk5Z474pGF9RhYDinH0QTPZug==
X-Received: by 2002:a5d:5f4a:0:b0:374:c269:df79 with SMTP id ffacd0b85a97d-374c269e0d7mr16000044f8f.22.1725608338871;
        Fri, 06 Sep 2024 00:38:58 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3749eea60e2sm21002351f8f.62.2024.09.06.00.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 00:38:58 -0700 (PDT)
Message-ID: <64758ccf-7ad4-4490-b938-864ade9ae74c@linaro.org>
Date: Fri, 6 Sep 2024 09:38:56 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/21] dt-bindings: thermal: tsens: document support on
 SA8255p
To: Nikunj Kela <quic_nkela@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 viresh.kumar@linaro.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 sudeep.holla@arm.com, andi.shyti@kernel.org, tglx@linutronix.de,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 jassisinghbrar@gmail.com, lee@kernel.org, linus.walleij@linaro.org,
 amitk@kernel.org, thara.gopinath@gmail.com, broonie@kernel.org,
 cristian.marussi@arm.com, rui.zhang@intel.com, lukasz.luba@arm.com,
 wim@linux-watchdog.org, linux@roeck-us.net, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
 kernel@quicinc.com, quic_psodagud@quicinc.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-1-quic_nkela@quicinc.com>
 <20240903220240.2594102-13-quic_nkela@quicinc.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240903220240.2594102-13-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2024 00:02, Nikunj Kela wrote:
> Add compatible for sensors representing support on SA8255p.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

