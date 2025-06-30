Return-Path: <linux-spi+bounces-8877-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041FDAED619
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 09:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4611A160946
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467971DA55;
	Mon, 30 Jun 2025 07:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="G68ILadV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650511E7C10
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 07:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269730; cv=none; b=DYBC5HYovGAVI00ugiqfDUNyOGeG7Cik5Qn8u+kvK4u92qYunHK2doPiPaglEAbdFm06f5qjM9JiNFq+H0xraYDkvpjtydfZ6geO/x1GGzDLOQ3PokE5ZJ+uOk5iSjYfae134TuKzLs+KHHN2W6d/qy+0vX+UtVsD+8QvOcD32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269730; c=relaxed/simple;
	bh=qf8NaywLRmWMHaEJuLsltQXouTMmM7A/UAbuopsgvUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeCX0o8FkfotnextPcBpdrMPKjsBGgVaYPNGd0nJoq5NotdjtQd7aYA1YLxaPhuxfUMYUPC8WfbmF0qdRfmUfMLGnkt6lzxuLIP2/Tkdc9RMH00nh5kZmIos0eDrBlJqd0a+HIFMnWiR+T9HMn90n39gPwPy/DIEsQbwWRY7pgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=G68ILadV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae361e8ec32so453967566b.3
        for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 00:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mandelbit.com; s=google; t=1751269727; x=1751874527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tZ+BSaUYjMYZPFRc5ahI5f+VB6TZxnMY7+aM/BHB0gk=;
        b=G68ILadVVZwyr8ugTC0v7wFBWa/DeA6lLn6W1yFZvySa5nJebBnTJnMtGqUCqytDtJ
         y0nO5dNZ6CFAzLmez2Thsh6Xx6VvUEE0MUdwDwrYkUQYCv5b0gximxXfnCsI28U/6+g1
         gnp0sml0albInrW9cB0UvHSHJT3YhXkSp0rEX3thEYTFNk0XEOeS/DeUgVLmx4jJi12h
         pRQrkPfwb5xpMl3iVdDeFKeA+qbOQaAG2RM6Fm7SfhORZuc9NE4pe/h42LD9rcVsy5Jw
         jWxPFiVun5aRzOs6iGdYPGx++f17kmtZNB3b6d3EmClXjvHImydMUmda4QzpoOtkVXtD
         71JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751269727; x=1751874527;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZ+BSaUYjMYZPFRc5ahI5f+VB6TZxnMY7+aM/BHB0gk=;
        b=IHkjbBsLWSJO4y9mbFfySasVvrF2soAAiry5oJpiWzoHc3rcPijNg93Hob2tmaJH5h
         BQJ9E3NRdEPv4yhlpl9JADPxr03ZFdmOtUnzeJnV8RovJSNvG1WAWgeO28yR04iELxAO
         eNl3JUVqeeV0mBe1IzHgPTNzWMczCAEqhjFhfRporFLzmI1ksLdHMEvX04YsaI1qUhuC
         3qzmk46SvvXxOxkWKs42fIRLX3frH/Dg+zxe9dd3z/BOLTxX7opzt2KkwQaQ1NUS/2kF
         +5RZ4j/CR3MWqxF8dpkB5n5sAsC5MWmMZvKqWzJvSiBJInvWreXQ18M4gNL0eyp3cay0
         Dsvw==
X-Forwarded-Encrypted: i=1; AJvYcCVzh20zEWCFaegdO/Q2dnPzFRMkdQAwYtshekwqTVJ5oDD9ioWiXfRGVYvlVrYK1uaZvEKl89tEEgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWJP0MAjfrqq7TNzn6VeUk7pTbdxvw2Dd+XJZTfxAsHCBJ+oE
	lmYEn5QIwhr9KLdQ+iUHKjwmqMXRDjsmR8WjubOODFndz1Wf1ZjIU4A66RsTjFgkHuM=
X-Gm-Gg: ASbGncuXQkjsLFWeilMwuF7cukVYRTRsotnA1lk7ET0MZieAl37Cacg0Rju6vVwhxag
	RJ5vqzK08v0nhvXDi0+A40DM6UZGJ4chIWfz7zcs8FzEs+yTpfOGfsw/ppNwxCFXOOW+s38E6li
	0wcWYPFjxvkcLGOfx1LP3HOi2rulFSZmLYaxKmCT4siV8TeT96tbQBlIGA5FSoVB3wWm2pRyokP
	LcEohaAXGuQlMe92/NYtjhVzTQHdjRvX94Ouy3PqbLL2tmTBxbtQvmWNvr5AK+5Tt3svLbBIXHv
	K1p/aCtQ9q3+PEywzPeyp6kYLE6tCCVBEdCJpmxWzQI+MnpPGFh1vsMC1RDz5WR+cBUYpOyTOly
	Jbp32hymQ21Ydd7q5d4En8Sdk
X-Google-Smtp-Source: AGHT+IFG8mxwherCyB+H+Ce/MDetYKrbqKrvuEJkbWn3WcmopojqghsC9D4gNWRWL3XhXfmKmOCezQ==
X-Received: by 2002:a17:907:8691:b0:ae0:ade2:606b with SMTP id a640c23a62f3a-ae34fd8ecebmr1192187566b.19.1751269726337;
        Mon, 30 Jun 2025 00:48:46 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:f5fc:eb97:a20:8b31? ([2001:67c:2fbc:1:f5fc:eb97:a20:8b31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b1c4sm623062966b.31.2025.06.30.00.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 00:48:45 -0700 (PDT)
Message-ID: <1c6f4024-be8a-4734-a724-f12b85a52ed7@mandelbit.com>
Date: Mon, 30 Jun 2025 09:48:44 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: stm32: fix NULL check on pointer-to-pointer variable
To: Clement LE GOFFIC <clement.legoffic@foss.st.com>,
 linux-spi@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Mark Brown
 <broonie@kernel.org>, Alain Volmat <alain.volmat@foss.st.com>
References: <20250628000227.22895-1-antonio@mandelbit.com>
 <1f49b8f3-44c9-43f3-a3bf-b931fb0726f4@foss.st.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@mandelbit.com>
Autocrypt: addr=antonio@mandelbit.com; keydata=
 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
Organization: Mandelbit SRL
In-Reply-To: <1f49b8f3-44c9-43f3-a3bf-b931fb0726f4@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Clement,

On 30/06/2025 09:34, Clement LE GOFFIC wrote:
> Hi Antonio,
> 
> On 6/28/25 02:02, Antonio Quartulli wrote:
>> In stm32_spi_prepare_rx_dma_mdma_chaining() both rx_dma_desc
>> and rx_mdma_desc are passed as pointer-to-pointer arguments.
>>
>> The goal is to pass back to the caller the value returned
>> by dmaengine_prep_slave_sg(), when it is not NULL.
>>
>> However, the NULL check on the result is erroneously
>> performed without dereferencing the pointer.
>>
>> Add the proper dereference operator to both checks.
>>
>> Fixes: d17dd2f1d8a1 ("spi: stm32: use STM32 DMA with STM32 MDMA to 
>> enhance DDR use")
>> Addresses-Coverity-ID: 1644715 ("Null pointer dereferences 
>> (REVERSE_INULL)")
>> Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
>> ---
>>   drivers/spi/spi-stm32.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
>> index 3d20f09f1ae7..e9fa17e52fb0 100644
>> --- a/drivers/spi/spi-stm32.c
>> +++ b/drivers/spi/spi-stm32.c
>> @@ -1529,7 +1529,7 @@ static int 
>> stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>>                              DMA_PREP_INTERRUPT);
>>       sg_free_table(&dma_sgt);
>> -    if (!rx_dma_desc)
>> +    if (!*rx_dma_desc)
>>           return -EINVAL;
>>       /* Prepare MDMA slave_sg transfer MEM_TO_MEM (SRAM>DDR) */
>> @@ -1563,8 +1563,8 @@ static int 
>> stm32_spi_prepare_rx_dma_mdma_chaining(struct stm32_spi *spi,
>>                           DMA_PREP_INTERRUPT);
>>       sg_free_table(&mdma_sgt);
>> -    if (!rx_mdma_desc) {
>> -        rx_dma_desc = NULL;
>> +    if (!*rx_mdma_desc) {
>> +        *rx_dma_desc = NULL;
>>           return -EINVAL;
>>       }
> 
> Good catch for both pointers !
> 
> For readability, I would suggest to define two dma_async_tx_descriptor 
> ptr at the beginning of the function such as :
>      struct dma_async_tx_descriptor *_mdma_desc = *rx_mdma_desc;
>      struct dma_async_tx_descriptor *_dma_desc = *rx_dma_desc;
> 
> And then use them all along the function even in the assignation.
> 

Thanks for the comment.
Will send v2!

Regards,


-- 
Antonio Quartulli

CEO and Co-Founder
Mandelbit Srl
https://www.mandelbit.com


