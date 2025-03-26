Return-Path: <linux-spi+bounces-7321-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B8CA7196E
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 15:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A09B16E8FC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 14:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4961E835A;
	Wed, 26 Mar 2025 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iKLUqt1R"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF63E1F3B98
	for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743000536; cv=none; b=XJ2iGStYAnDma7+2MUkD/Qg6rCWV3C6a+1Oonp9xZt4M22PKagakpEpXLdtM+I8vxrlvfiO2jgKCRcxujqz/gUaOzSDtmbh2gL5oeVtP+J2XvKqqdZ7QttRp31IUIeEFBRJwvCOkgiAuw+NpF4Pz14g+JZia8De+9xEQQAynris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743000536; c=relaxed/simple;
	bh=V9OPN9ZbeHaXk5j2cNowUnTpyiTZNQfQrH6Jh2QA1EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XL5ZI1HvlUzX3uQjugYvaK7xiSx7nLVkhsir6+NwdB6MgVX2uRL3qx5R9wXVRsXwzbokAmBbNdgEykaxf8Wh7I1KgRENn9ujQesAo+mG1mdR8dc5ChqKo00q7IMJ5QAQvGay2RCANscPLX11LNgkrtA0jhiJScRVO4++M16hhzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iKLUqt1R; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso32035255e9.3
        for <linux-spi@vger.kernel.org>; Wed, 26 Mar 2025 07:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743000533; x=1743605333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7F63w5WbLJMRPxYzdb7qfC13R+bJpmQhvYwda9HcaI=;
        b=iKLUqt1R0jYGBxutzkmCFp3S/hyd2nI/oAS5cvHC4Q3r8YLPrxaMMk80CB0cADdfei
         y3GH4py+9YotW7Gb7TGwKSyO5xR9gAHL7yU/NJEo2/xXd0TOSxzKkMu33mjCSANPKxf3
         q6/NV2O5sf3qKitahjyy2QNCCpU/Q52SK95YDpIAivVYwjFebMhzB0lFwjnWFZDWLDvb
         cIsSskN50bBS8sakBGAUbPGWiIa9bml6u9bPU23c8iyw9ZCAk7ADX1bDpxXF7hYILyai
         ijtnVlfOcDrPIYV2xltXGIGjki4wVwd+KXKHvOBchvAtBnsVt1HBA8kYQ69UH9eO/foS
         nbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743000533; x=1743605333;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k7F63w5WbLJMRPxYzdb7qfC13R+bJpmQhvYwda9HcaI=;
        b=wz3hdrWl/+dLK6CN7pu1IEvgRTvOYv80EbVb1GKGpzgzD8JQBqk1MBllsL2ETwfUKo
         IfDskdCr/VdRUzyCU0fLGVsoGXoVF8B77giiwTk9l7oWkGhdtLgyvrL+eic8AYJbA9ZJ
         /QqlodrN6/Tn8pbjWr47/1CUGiQ+2X/nQycOVBPkpROI+AHn9dl/fDfvS0IhVVxkMkzZ
         mxW5X7fdtyvhEoSThML1OIFuIIsavU0bMMC1MCzj+L4skFkSpnpdRpDjGhD6y3OKi841
         lZVXMCRXwBdgv+xoEZ4/cTRjifL9qAQGcFAn86969DjxfMZGW4nPJ9zCGL6D0VQzCVgh
         pYgw==
X-Gm-Message-State: AOJu0YymuQlXWtQaJ9vu0+EmblX8r5+xWdp35VbvQS6B0dbrrA4/d+UU
	JYyokKPqCng1WQMB54Z1Be65F8fzh5rhuCUYGELMmEFe0YQRY3muv39a5we3BFQ=
X-Gm-Gg: ASbGncuy03x9/C3AW4y853wxRQpGK+/MlC/7dt8mxNRxN97rVBrte7nh4Vqqg2ueMfY
	U29Ev/FivFN5BU+i1uwrW6VLpAXYwwQpB9KCCmlpnaUSm2O5X9xfSksgF1MqjpXxAaxpr/cDAgf
	QhlnLaS6qLtTL7CrcKHFu+NA8hMGiDvIkig7GZuxe6Rvz2PVVB1Eo0OKEieY5+6VIst5iyVkk2J
	bGwStKJAIcWTAFLNkgLWsOwOUIpQhCqIvzDz7ttzN4FW6wk0ySpXIblF/SopbCRsogbJCRUEcoV
	ob5rQIfFk8SRzz/8q4+87tiWIxS3ZSmKujvV7/nHg8KxjmHDwOIFeGo=
X-Google-Smtp-Source: AGHT+IG054URsTL05MtZIrzYoZ2nRY1iaq/5fvUAR6DYti36wbbvJ51FuVkhLdk4NeF87evX5MRxvw==
X-Received: by 2002:a05:6000:1864:b0:391:10c5:d1ab with SMTP id ffacd0b85a97d-3997f8f61d0mr17080409f8f.5.1743000532936;
        Wed, 26 Mar 2025 07:48:52 -0700 (PDT)
Received: from [192.168.0.251] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef1f7sm16901316f8f.82.2025.03.26.07.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 07:48:52 -0700 (PDT)
Message-ID: <fbad733f-d034-4d63-ab82-ed867f0ed5d4@linaro.org>
Date: Wed, 26 Mar 2025 14:48:50 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] spi: Add support for Double Transfer Rate (DTR) mode
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 andersson@kernel.org, konradybcio@kernel.org
References: <20250326083954.3338597-1-quic_msavaliy@quicinc.com>
 <40db39ef-7ef3-4720-9c85-ccfe1c11c299@sirena.org.uk>
 <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <c89603b7-b70c-4b55-ac87-f84ce5be2c6c@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/26/25 2:25 PM, Mukesh Kumar Savaliya wrote:
> Hi Mark, thanks for your comment.
> 
> On 3/26/2025 6:34 PM, Mark Brown wrote:
>> On Wed, Mar 26, 2025 at 02:09:54PM +0530, Mukesh Kumar Savaliya wrote:
>>
>>> This change introduces a new field `dtr_mode` in the `spi_transfer`
>>> structure. The `dtr_mode` field allows protocol drivers to indicate if
>>> Double Transfer Rate (DTR) mode is supported for a given transfer. When
>>> `dtr_mode` is set to true, the SPI controller will use DTR mode
>>> otherwise, it will default to single transfer mode.
>>
>>> The QSPI controller driver uses this flag and configures single or
>>> double
>>> transfer rate using the controller register.
>>
>> We should have a flag in the controller indicating if it supports this,
>> and code in the core which returns an error if a driver attempts to use
>> it when the controller doesn't support it.
> Have added below in spi.h which can be set by client and controller
> driver should be using it to decide mode.
> 
> + bool        dtr_mode;
> 
> since default it's false, should continue with SDR.
> I believe for QSPI, it supports SDR or DDR, but it's not applicable to
> standard SPI right ? So not sure in which case we should return an error ?
> 

Please check how spimem is dealing with DTR, same ideas shall be applied
for spi transfers.

Cheers,
ta

