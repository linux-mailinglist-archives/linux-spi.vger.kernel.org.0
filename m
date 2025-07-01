Return-Path: <linux-spi+bounces-8938-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4535AEF905
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 14:43:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD384E0542
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 12:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE462741A1;
	Tue,  1 Jul 2025 12:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYDyCiv9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544981EE033
	for <linux-spi@vger.kernel.org>; Tue,  1 Jul 2025 12:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373771; cv=none; b=B5WpKm/2WkZmcOrRwFrVO5/RkiuBathFHgcLC1z8wXVTi7evOeECdPqVLttMyCXmi2j4iv9lmxQih7HBrOg/1ltKozwIr8cF6C8iNDinH3BlxKiVNeWKPQ7K2a4FBdCs5wEzD10Q5bH12fXUK8ClQjrMiUKJaTc/PIKw9zxZHGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373771; c=relaxed/simple;
	bh=2USRWzkHY9LDDjXfilZDHGMHlXswQOI+HCwfX1yZ/fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1blZNvybiqslEiRTy41Tk2e1GsjILs95R1+sxrxNr5t8E0satczIAooI8bw5M0M1JsKmXkWfyRNTKLI4Fg2gEm2SSDq8HtSRVl5xcxpt+uOzYbDQNzsPKetgQUz+IO04a5o2JzCHbjCtNpOzCd10hMPrx8DVtogcbBvc3osRZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NYDyCiv9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537edf2c3cso55799865e9.3
        for <linux-spi@vger.kernel.org>; Tue, 01 Jul 2025 05:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751373768; x=1751978568; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsVCbz5zR4RqV+iuMQyZvIjkyF6mk+aRWwFqzLZi86I=;
        b=NYDyCiv926Zb84kMYRq3uZbh463JS8dlmsszVdO0HJn9tp/AEP5v8F/g/8DKLN/4Cw
         VyPb8qPp1fMjYWPoOZWYQXyAGU4zZGu7mHDM2fg92+LXF5OWF67ibrV0tBbqbBplHAhw
         VdytyFQIlL5X50n/dX7hXGhTcoDpVTRc2+DhphvFdkkULZ97vH7xZY0O4rt+zsow4XBU
         +rDwTxHngLpHSDJbQmfgKuLQ47AhbMTvq/mv4JzePdSnGXxM6ypulGss3/HuarIFhRZc
         S2ux9W4UhGHY+cYqTHacrZ8VlTe+qZ0USK3flaWS26paJyoSYbowGOC98M4TdE/KwDzB
         7biw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373768; x=1751978568;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsVCbz5zR4RqV+iuMQyZvIjkyF6mk+aRWwFqzLZi86I=;
        b=lw80U8nO1SvNP1niLrg4B2SfUv1946azxbZvaZ+UD0OOja2kQOdu1mjnse8DjxelG/
         NuDDuimsFtCeI2AbolGEaKZvNSMtC1i9xJMVGbx0bYwOHLVf7c0Fa2U1hIVDqgAVta5U
         p4a8R0j5OvnkTXz0H+sjqqXARt8rMs+pDdBssItSB54PmfFaFrGQU0Q6f+4pB8RmL/FR
         Bj0s4+gMlrZEaLM/JZ+fbCRlfBOAKzSSy1b27+zhgjMhm7+ssaKXlvrGJtOhJiqgePWW
         Sb6IstbI0ghG+8pYxaLIW9l1TZAbJiMUgIibJIfCbqt6tgGrLv+OGqJJWPVRUVBVhXhd
         5g9w==
X-Forwarded-Encrypted: i=1; AJvYcCVcHSqeSFlvXXx8svt0BeV0gfnKwIqqWqamqY36Vw7j+wMYh085eeV3OfaO2spr86NaBRSi8ujabSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ufxK+czgQtpjl3YcGZ2/9Jmu4b3pW7KJIMCk5iRlcaG/6bdi
	wPZ+Mh9ZtGMt4ljbmVSQrUUsVMEjnPchzcEGVXLDb3nTwkPaVHBGIwuFjgFAuOVG8FU=
X-Gm-Gg: ASbGncu5/y7Zh5DX5HxsHXoc2qQRKTrmdma54PVJOlA+pAqgBv1IWsu0xVf03nHixIc
	YnP4BNmxZbCJ9NXLY8IQkdme6nSe8WfP+SdM+4odrqBu5fl5z82oRkcL68c/hywddx575CeI/91
	extGUiJ9Gs9o0r7KceFrdzvMLIVRStIzoW/F9afjrovcnmuB/oD9y4g3PV1JpUZ6hRAtONR1hUH
	BaysY5zGXaRjwki5X8QFln31OW7XUYGTzatWVWJiIuJnNZyubv986e4oCqLAK/P2dbzryAByMt7
	6XCKttx0g+f01Dyh+xjx3NjxIeVZ/m9iC2x2zbKdJPOeVePKk2lT3M1/Pn3wdEC+jeg=
X-Google-Smtp-Source: AGHT+IGzGtmISDr4u15qcknVybwuXswS0vgnEq/kCyZSCSHrqvkYh2GXlp+x4RvRaQKJVW3fIdsSmQ==
X-Received: by 2002:a05:600c:6986:b0:43c:fa24:873e with SMTP id 5b1f17b1804b1-4538ee278d6mr164093505e9.13.1751373767557;
        Tue, 01 Jul 2025 05:42:47 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453966eb3e0sm104937695e9.28.2025.07.01.05.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:42:47 -0700 (PDT)
Message-ID: <c9bf945b-9fc6-4829-addf-2fb7a7d4eb36@linaro.org>
Date: Tue, 1 Jul 2025 13:42:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] spi: spi-fsl-dspi: Target mode improvements
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Larisa Grigore <larisa.grigore@nxp.com>,
 Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
 linux-spi@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250630152612.npdobwbcezl5nlym@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250630152612.npdobwbcezl5nlym@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/06/2025 4:26 pm, Vladimir Oltean wrote:
> On Fri, Jun 27, 2025 at 11:21:36AM +0100, James Clark wrote:
>> Improve usability of target mode by reporting FIFO errors and increasing
>> the buffer size when DMA is used. While we're touching DMA stuff also
>> switch to non-coherent memory, although this is unrelated to target
>> mode.
>>
>> The first commit is marked as a fix because it can fix intermittent
>> issues with existing transfers, rather than the later fixes which
>> improve larger than FIFO target mode transfers which would have never
>> worked.
>>
>> With the combination of the commit to increase the DMA buffer size and
>> the commit to use non-coherent memory, the host mode performance figures
>> are as follows on S32G3:
>>
>>    # spidev_test --device /dev/spidev1.0 --bpw 8 --size <test_size> --cpha --iter 10000000 --speed 10000000
>>
>>    Coherent (4096 byte transfers): 6534 kbps
>>    Non-coherent:                   7347 kbps
>>
>>    Coherent (16 byte transfers):    447 kbps
>>    Non-coherent:                    448 kbps
>>
>> Just for comparison running the same test in XSPI mode:
>>
>>    4096 byte transfers:            2143 kbps
>>    16 byte transfers:               637 kbps
>>
>> These tests required hacking S32G3 to use DMA in host mode, although
>> the figures should be representative of target mode too where DMA is
>> used. And the other devices that use DMA in host mode should see similar
>> improvements.
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
> 
> My test numbers on LS1028A:
> 
> Baseline XSPI (unmodified driver):
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 8 --cpha --iter 10000000 --speed 10000000
> rate: tx 2710.6kbps, rx 2710.6kbps
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 16 --cpha --iter 10000000 --speed 10000000
> rate: tx 3217.5kbps, rx 3217.5kbps
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 4096 --cpha --iter 10000000 --speed 10000000
> rate: tx 5118.4kbps, rx 5118.4kbps
> 
> Baseline DMA (modified just DSPI_XSPI_MODE -> DSPI_DMA_MODE):
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 8 --cpha --iter 10000000 --speed 10000000
> rate: tx 1359.5kbps, rx 1359.5kbps
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 16 --cpha --iter 10000000 --speed 10000000
> rate: tx 1461.1kbps, rx 1461.1kbps
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 4096 --cpha --iter 10000000 --speed 10000000
> rate: tx 1664.6kbps, rx 1664.6kbps
> 
> Intermediary LS1028A DMA mode (using non-coherent buffers but still
> small DMA buffers, i.e. holding just 1 FIFO size worth of data):
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 8 --cpha --iter 10000000 --speed 10000000
> rate: tx 1345.1kbps, rx 1345.1kbps
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 16 --cpha --iter 10000000 --speed 10000000
> rate: tx 1522.5kbps, rx 1522.5kbps
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 4096 --cpha --iter 10000000 --speed 10000000
> rate: tx 1690.8kbps, rx 1690.8kbps
> 
> Final LS1028A DMA mode (with the patch to send large messages as a
> single DMA buffer applied):
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 8 --cpha --iter 10000000 --speed 10000000
> rate: tx 2247.0kbps, rx 2247.0kbps
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 16 --cpha --iter 10000000 --speed 10000000
> rate: tx 3477.4kbps, rx 3477.4kbps
> $ ./spidev_test --device /dev/spidev2.1 --bpw 8 --size 4096 --cpha --iter 10000000 --speed 10000000
> rate: tx 8978.4kbps, rx 8978.4kbps
> 
> So after your patch set, DMA mode on LS1028A becomes more performant and
> should replace XSPI. This is an outstanding result. That can be done as
> follow-up work.

I wonder if latency could be higher despite increased throughput? It 
probably wouldn't be a big enough increase that anyone would care. And 
based on the structure of the driver if throughput is higher the latency 
might even be lower.


