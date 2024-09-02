Return-Path: <linux-spi+bounces-4503-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3F39685E2
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 13:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A2C2814EB
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 11:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8191865F7;
	Mon,  2 Sep 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iJ8ZqelK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528A183CA6
	for <linux-spi@vger.kernel.org>; Mon,  2 Sep 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725275598; cv=none; b=Unm+LVSMelDSGq/koTkNCfPXCkaUHZd/arjlSxN7hIjFsqIkxm9MBVwdy3Uh9niZ7W0WJaz+cJRX6f3W32sF7pCyizkAzs1J0UTof8iAOwxMS+MfgCO+QIPTzaPAVzlvgNG9AuLIR4casxx62gYKQjJvqLnX1q3p6HpcP2lp5UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725275598; c=relaxed/simple;
	bh=DWzn1hYA+MqPVdMdjEmyelcVAh57NyETVCIWQcpDC9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F0oVSNYLiDCezvM/PXw6UXkFXAE66l6NhxDZBRkimb6Zz/QRGMuqFFgrnNQ9OEDGMdqh7EMuqJ/oS7pOeh3VxIK50fUAD7dHJU8tF6QQb+ZDBsPbqgtDSE0fAyFnE6tJb9IronhARmua1Nwj0BGlfTXm+haJsNb1NfedCFt3uWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iJ8ZqelK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bc19e94bdso18530965e9.3
        for <linux-spi@vger.kernel.org>; Mon, 02 Sep 2024 04:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725275595; x=1725880395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t0y66KZsilWy5/q39E1+glqNVuSns5JZhAjLByhViBs=;
        b=iJ8ZqelKXJymdJWrC2q1XKRPSuI2+MxDVEE6CjA+fjLWqla5YFbXnVmIWbQCAbylI2
         FIumhjKQ+gJlmKiiezMg/SyqPoDKb6aoIKpOHyIwYyqLt2eyZ7vrn18EvwFt7qaY7eYi
         33xZkr7vhpE/QY+7gvnj4rOhyIdneZf75T7nv8WfLbhlkxe1FVc+wu/NbrsL1KslhacT
         yNjyIHwSerKUnMI6wdyntu48ZInsMmdSUm4bk0IgTGC7rfHT008SkKlVANK6Tjz7+2eK
         EWJXGe7JlGEuFOq2aXPuQkuvykzst+jnKHUS6B5ukPlTQuXpH9Zt8pe47tKjg4TCcTXM
         r0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725275595; x=1725880395;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t0y66KZsilWy5/q39E1+glqNVuSns5JZhAjLByhViBs=;
        b=rac/6Q7eeyd5q4gbHwl/mBYUZuWm8uxaQKvew/P55pWbZKGlEri0NP3FHOS9ljSCBK
         lWHoXxAvaiUyNhGLoY45oO9f39clacYydGtfQbxwBLyxJwsa7kHEvtPcH618Aogd6QfJ
         cWspp8jLK2IVrM3FJL7rwcBOu9a0NAhrGoKwCJ79dTvn4b/X60BXUG6VdcedWoMtEaXV
         TLrZxlYysprd7vpFxgTba6T+n/h2FhZoUIxtdOD0NctuYtt79ufSF3PEt3DUgkMBg6J3
         5CMm6MZWpX59wCzsR8UnKjbw2KiihDDu5F2l/MfZoeY9oiu69ErpokrBrYhFhgx9bHK9
         pPwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDDFPne8QqmDCDdaQ7khqVUC3XFWTNDHXuS0FZKZ4+uE2Cv3EJk/DWGlyl3QX2I06y8rY2wbWEVtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR87mExL47Dran7Qwrv8YhJEnDISPXTdgRLG0xWH87uaJoqTbN
	VjGDcv1LUHkro+/N8S27cAzbMEKG8ebEENlez5xIzpFKF8T/GXcQMTocUSW6+Zo=
X-Google-Smtp-Source: AGHT+IFxCzBbJEBnXgmaDcBmR8nMNXjOhCACiDRaC3OZHxGXv/tYXf8mnP+AgdXOfY0pl7t3Hw1Y7g==
X-Received: by 2002:a05:600c:3b25:b0:426:6320:7ddf with SMTP id 5b1f17b1804b1-42bb01fb0fbmr100596305e9.35.1725275594477;
        Mon, 02 Sep 2024 04:13:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42bb6e274ccsm136021455e9.37.2024.09.02.04.13.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 04:13:14 -0700 (PDT)
Message-ID: <ad18f559-b067-4f2b-9bbc-6830bbe2f252@linaro.org>
Date: Mon, 2 Sep 2024 13:13:12 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] dt-bindings: thermal: tsens: document support on
 SA8255p
To: Nikunj Kela <quic_nkela@quicinc.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
 herbert@gondor.apana.org.au, davem@davemloft.net, sudeep.holla@arm.com,
 andi.shyti@kernel.org, tglx@linutronix.de, will@kernel.org, joro@8bytes.org,
 jassisinghbrar@gmail.com, lee@kernel.org, linus.walleij@linaro.org,
 amitk@kernel.org, thara.gopinath@gmail.com, broonie@kernel.org,
 wim@linux-watchdog.org, linux@roeck-us.net
Cc: robin.murphy@arm.com, cristian.marussi@arm.com, rui.zhang@intel.com,
 lukasz.luba@arm.com, vkoul@kernel.org, quic_gurus@quicinc.com,
 agross@kernel.org, bartosz.golaszewski@linaro.org, quic_rjendra@quicinc.com,
 robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-crypto@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-i2c@vger.kernel.org, iommu@lists.linux.dev,
 linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org,
 kernel@quicinc.com, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
 quic_shazhuss@quicinc.com
References: <20240828203721.2751904-1-quic_nkela@quicinc.com>
 <20240828203721.2751904-14-quic_nkela@quicinc.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240828203721.2751904-14-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/08/2024 22:37, Nikunj Kela wrote:
> Add compatible for sensors representing support on SA8255p.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

