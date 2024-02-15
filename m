Return-Path: <linux-spi+bounces-1370-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53660856BC2
	for <lists+linux-spi@lfdr.de>; Thu, 15 Feb 2024 18:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 092F828DF25
	for <lists+linux-spi@lfdr.de>; Thu, 15 Feb 2024 17:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A532B1386A7;
	Thu, 15 Feb 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BE8BehfJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0C61384B7
	for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 17:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708019920; cv=none; b=P51urkv/n+ejUBpxkKiVWJEUVSmqvpIbMwMuCBLgBjiMM0imNAHFNncxiLyEB8BvTrtH7oAWrdChQ2ZEh2onqI2G7ilGj0dN+adytoNOLWl9J6xynmLfkscNtdNvs8GzZP/4nDk1g+TL+kiF9W9sawt415dB0ETRdVdK/78mVuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708019920; c=relaxed/simple;
	bh=FxniF9sUhJygIjJxnay6eDIcmmIANtIm0kWzvZ5c6eY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWz5kBfjmSKwzXv2/18exYa72QWAaGj45bsWL2sascRR7929xUPZzuFKWUiEhIXlHAbHWP5H6np7+DGAXBaPT8iak5nmmPJOIsrGe+5rUzKWM4tzjUPhQwtpUnWfJmVbQ35DbZH0j8KM2TGS1Y6QKzdHi95j6B5RBcnbZH0Jll4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BE8BehfJ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso723161a12.2
        for <linux-spi@vger.kernel.org>; Thu, 15 Feb 2024 09:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708019917; x=1708624717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFU+FoaiQti7pQg+ivxZmwfsNKe8g3TQuPQL3hOyJhg=;
        b=BE8BehfJqQlvLspP2QSW0P5HUX6hlJtt+GVtNR7nIgr6Bg4/1IPB8zpTkQJnOKak+M
         rPatQzk7jXzlmXvXEHm3eDwdu+0dDXKQzKTVgUYjE5yV6ap5eqdWJkHRHPokXLUpeX5/
         XpXxDpFCZZMtQw7WCyYPvJBL+Pt14gK1ES+io90oDZAy/DiybieukHrllWV70wLJt4ba
         OdGbwq7Ac3ymPLgOIRIHn25wtxD88FPPianoe21QUQh1HbwOnv3oHdnie8OO6gAVT6P4
         VjtaA7VbGDgzMZgp7PlLyOm8DmuMzZvK4HpH0/gVEyi8rJ09AzxHLT6Wca6A/ke+u4rx
         0FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708019917; x=1708624717;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFU+FoaiQti7pQg+ivxZmwfsNKe8g3TQuPQL3hOyJhg=;
        b=I7eMNVqmJsLWRfdBiTszcAKu5at/hw/3RITsGEZNNl/xy3If4wKnseZzAfSAz3TI4z
         ptkh5lf8w/dwhbxg7Bzst3SfCtQmD4s8SWrbv/mdLEH54b4ihKa+QwUnAUm6/SgNzEQF
         j+/dfWRBqG0YMJZtLjzNayokFTJe32Fud+cY+Z6r6e8PsCus26GDoB4FrX/MxPiWhZdK
         EtG6PPnli6CKSuc1ziNj+VUKR15b3Svs8MgEHE1fUl44Fnw82pZ+Hm/RC6KK1/FJZLjJ
         4Jo62YdvBqAu7IFseBqLQ/eCaO0jSRtcOg3AM33QEikACGb1N8mgEbNwjwI8I7Sb04eI
         1nBg==
X-Forwarded-Encrypted: i=1; AJvYcCUR6CPQ5YSw96CExkww+WgHAyO3U9oE4fDGbQQbxQkkQMKweEEfZfvtCfp/ymm87g/LgZ0fmvh429Z507xKbXYN9z+VjuE54UfW
X-Gm-Message-State: AOJu0Yz/k83sJboobFUVZACTt6J2YKAcfEifoMfKAWTMHnkdOMh6B9QP
	xQJKrzmWhRQQ3nzdNi2VNNPC/FwPvkRdbdHdC4tRcFN29eFnnj4uhiUFWqhzn9E=
X-Google-Smtp-Source: AGHT+IHTjex65y4mQj3nNOE8pPpjQjNg0YEaQHCLGQL/RR19Sne4TStleiM+21YH/U851dkrGQUPMQ==
X-Received: by 2002:aa7:d812:0:b0:562:117d:2297 with SMTP id v18-20020aa7d812000000b00562117d2297mr1852030edq.36.1708019917258;
        Thu, 15 Feb 2024 09:58:37 -0800 (PST)
Received: from [192.168.192.135] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id h32-20020a0564020ea000b00561e675a3casm749438eda.68.2024.02.15.09.58.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 09:58:36 -0800 (PST)
Message-ID: <584a5308-c73d-4559-bb61-21d07cd63d6c@linaro.org>
Date: Thu, 15 Feb 2024 18:58:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: ipq9574: Disable eMMC node
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: andersson@kernel.org, broonie@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
 manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
 quic_srichara@quicinc.com, quic_varada@quicinc.com
References: <20240215134856.1313239-1-quic_mdalam@quicinc.com>
 <20240215134856.1313239-6-quic_mdalam@quicinc.com>
 <CAA8EJpqV=w38TqjfTp6OurAwHjR87PpmQTs2jUo6O7vF1-T-WQ@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <CAA8EJpqV=w38TqjfTp6OurAwHjR87PpmQTs2jUo6O7vF1-T-WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.02.2024 16:00, Dmitry Baryshkov wrote:
> On Thu, 15 Feb 2024 at 15:49, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>>
>> Disable eMMC node for rdp433, since rdp433 default boot mode
>> is norplusnand.
> 
> Are they exclusive?

Even if they're not, having access to the eMMC/sdcard would still
be nice..

Konrad

