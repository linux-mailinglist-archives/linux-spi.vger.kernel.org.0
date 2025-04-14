Return-Path: <linux-spi+bounces-7567-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F58A87888
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 09:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 685523B0D9C
	for <lists+linux-spi@lfdr.de>; Mon, 14 Apr 2025 07:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83F024887F;
	Mon, 14 Apr 2025 07:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yEY+oDyM"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4A245037
	for <linux-spi@vger.kernel.org>; Mon, 14 Apr 2025 07:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744614975; cv=none; b=bfuanMOnxVuK37SRv3na830PkLx6xBgipGdjFMOP+kZWSmrDSguflqZjPS7vH4OQmXj44IptuREUFt+27NpKPY/GjNFKet4fKTXOLuup83mnXXXa2gz1ChmpTlAskBIXOOFD4ilpHdhBPHosUP4ym0zYsNm2irsvwu6R89nTEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744614975; c=relaxed/simple;
	bh=WK4NCloQDa0S4cRk3/OQggqH9gl0NPLMNlI5ytZg4G4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=aiKNdv4peVvTYa51hSuqZCDVcXkQ+1iz86adXApOQjQgUpp+omciBahs4usyZRV5l23/FQpaWd5gMfHl13ASKuR+waM/vjrhtA18PLkuy29xPCMUaAhxjjlvCXTBWrjLW2m++Zg29LqDS2hQW7a+fTzQNpAC9G6WHBXJn8uyA4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yEY+oDyM; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913b539aabso2262560f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 14 Apr 2025 00:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744614971; x=1745219771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4BBxO2Q/J6IMxfz+uEtm4Q1azghcdwE0iVwsVnnKvk=;
        b=yEY+oDyMCLlRp6ZJB9Tqsjsor6XXTOn6bRoowgIC39c/kjAil0UWnDRG3hfNTx2q4i
         gxK33yBiRoVpS6q8JTD+ClHRUVGtmOigPL1PP3u7aEp7Onad1d3+tII8aJ1f/Yy8jyQ2
         VJ+uqCkLSvC/jl+3oYO7XfvtWoEGWzaG/FHx7qebuClNHWbp/IMf3CetGCKO8Zdfqb0u
         aW4js7aMLrY/xHJOEis4LgkcLRAG8uWQyJIiGbgJC1dqFLDXGZQjmTM+4qRw/RAhfbAE
         UeKpL8me/jdNm00mmCMmvC97Ia1zrALfZ3Oo2XvyCCNMgZWqbRUtl4EsQNMDuwOFf8NH
         Oz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744614971; x=1745219771;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A4BBxO2Q/J6IMxfz+uEtm4Q1azghcdwE0iVwsVnnKvk=;
        b=jVXUkO9LoXs7i2onN0XL8GOd+XzRP9oZJnByEPZ1Ojjr1vcqyKOZVUJIdYPf91OKBe
         xA9hc+xbQNkCiphuhTd+Dr4hHMsoY3nq76Yal+B9txUxT5WuVlIweXz9Ysy+WGCmcRP7
         fsqogRe/6r1ccBLZycNmD0p9vAc7X7kUUnCQiqpXp8QT0V1Lb8NlfnIQtf65cD3l6vOY
         W+tBYkYQ6lGCiu3MzZKP5BQEIwaZWcr35cQBk3s0DFUOiDnybGvNHVHDAAGbPim1zGD6
         +DyfshA/29UgHVgTO5LnOZIV41N3KdO4oDzViqrGjnRced2YLDNqW4xfSoquKMsfjwas
         +cPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6IlTmbgBvCAkQ2x50J1Pl6Xv0LfjKJ47LebqICQN4pb3WBZ1XAQOVR1bkDXSEao8FtQ1cil2Xe2w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpAbaW5VBktMuO1IL+P7pUQhgLgREYwoCfpbaYRw5+zBCc1RoN
	pNsC88nhO3T317omLjGDI6J9EWnyLsOYXb6Hz2MA+wc8NRA0KDRhuyfAdh1sspE=
X-Gm-Gg: ASbGncvpLoHbANIU5/htiUXhy9bRmlstfAoacwfPFbns2AaXfHQr/LgLcTwP4dGbBHs
	9ydf+Hr23Q2oLzStTXIgVzJCaVTEP3bm/kWZ5IAIvONlUcsSHi6blQeqaysW9wQRdb0tVDK+59E
	uAvbSWMXRHQ/H1jQDXkaPpNTNMkSXElwoNLRN5lnoCWX2OSAGjyEkWAFU8h5bgblnmzPwt8PEEh
	fcKahYI6K9RLFHHmOIzUjF8T61G6UpmE+9lwnqIxjuNwwDv/tJ7qRbPp2boMqtLfCUE26pPAVeO
	8waWrluC2y6Dr0TrXK5PsCkWF++SbirTMgLZZEgFfwdYWHoh3NVw/+HyUR3yp1PlaYoj9Zyfj0I
	9vKeb8kEFIYFqsxyIcQ==
X-Google-Smtp-Source: AGHT+IFk/4b/d6EUYjjExv4IiKLoJZUz+hd9IYDUnYI9Yd0PRlZMBINesye58HTjAx7nVixJNpR1PA==
X-Received: by 2002:a05:6000:144e:b0:39c:1f11:ead with SMTP id ffacd0b85a97d-39ea5213077mr9016322f8f.26.1744614970477;
        Mon, 14 Apr 2025 00:16:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bf8a:3473:5c13:9743? ([2a01:e0a:3d9:2080:bf8a:3473:5c13:9743])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c614sm10221879f8f.27.2025.04.14.00.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 00:16:10 -0700 (PDT)
Message-ID: <576f0726-d238-4c37-8dc2-481df67f8fec@linaro.org>
Date: Mon, 14 Apr 2025 09:16:09 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] spi: meson-spicc: add DMA support
To: Da Xue <da@lessconfused.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sunny Luo <sunny.luo@amlogic.com>
References: <20250408-spi-dma-v1-1-3c38be62c09c@amlogic.com>
 <c29a8c28-996c-4e94-b0a1-0e4a37f0bebb@linaro.org>
 <aebccc51-14a2-40be-8d9e-20a55ce94459@amlogic.com>
 <d9d81cb4-12b4-4db3-becb-4578548986b2@linaro.org>
 <c9f0ca5f-17c4-474f-8370-fc0c83ac9093@amlogic.com>
 <CACdvmAg5px00er9TUd6_Nhr1GoSf=6LK6vSWOB-YcC1Ve0NRQQ@mail.gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <CACdvmAg5px00er9TUd6_Nhr1GoSf=6LK6vSWOB-YcC1Ve0NRQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/04/2025 05:56, Da Xue wrote:
> On Sun, Apr 13, 2025 at 11:14 PM Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:
>>
>> Hi Neil,
>>      Thanks for your reply.
>>
>> On 2025/4/9 20:35, neil.armstrong@linaro.org wrote:
>>>
>>> Hi,
>>>
>>> On 09/04/2025 03:49, Xianwei Zhao wrote:
>>>> Hi Neil,
>>>>      Thanks for your reply.
>>>>
>>>> On 2025/4/8 15:41, Neil Armstrong wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 08/04/2025 09:04, Xianwei Zhao via B4 Relay wrote:
>>>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>>
>>>>>> Add DMA support for spicc driver.
>>>>>>
>>>>>> DMA works if the transfer meets the following conditions:
>>>>>> 1. 64 bits per word;
>>>>>> 2. The transfer length must be multiples of the dma_burst_len,
>>>>>>      and the dma_burst_len should be one of 8,7...2,
>>>>>>      otherwise, it will be split into several SPI bursts.
>>>>>>
>>>>>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
>>>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>> ---
>>>>>>    drivers/spi/spi-meson-spicc.c | 243
>>>>>> ++++++++++++++++++++++++++++++++++++++++--
>>>>>>    1 file changed, 232 insertions(+), 11 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/spi/spi-meson-spicc.c
>>>>>> b/drivers/spi/spi-meson-spicc.c
>>>>>> index df74ad5060f8..81e263bceba9 100644
>>>>>> --- a/drivers/spi/spi-meson-spicc.c
>>>>>> +++ b/drivers/spi/spi-meson-spicc.c
>>>>>> @@ -21,6 +21,7 @@
>>>>>>    #include <linux/interrupt.h>
>>>>>>    #include <linux/reset.h>
>>>>>>    #include <linux/pinctrl/consumer.h>
>>>>>> +#include <linux/dma-mapping.h>
>>>>>>
>>>>>>    /*
>>>>>>     * The Meson SPICC controller could support DMA based transfers,
>>>>>> but is not
>>>>>> @@ -33,6 +34,20 @@
>>>>>>     * - CS management is dumb, and goes UP between every burst, so is
>>>>>> really a
>>>>>>     *   "Data Valid" signal than a Chip Select, GPIO link should be
>>>>>> used instead
>>>>>>     *   to have a CS go down over the full transfer
>>>>>> + *
>>>>>> + * DMA achieves a transfer with one or more SPI bursts, each SPI
>>>>>> burst is made
>>>>>> + * up of one or more DMA bursts. The DMA burst implementation
>>>>>> mechanism is,
>>>>>> + * For TX, when the number of words in TXFIFO is less than the preset
>>>>>> + * reading threshold, SPICC starts a reading DMA burst, which reads
>>>>>> the preset
>>>>>> + * number of words from TX buffer, then writes them into TXFIFO.
>>>>>> + * For RX, when the number of words in RXFIFO is greater than the
>>>>>> preset
>>>>>> + * writing threshold, SPICC starts a writing request burst, which
>>>>>> reads the
>>>>>> + * preset number of words from RXFIFO, then write them into RX buffer.
>>>>>> + * DMA works if the transfer meets the following conditions,
>>>>>> + * - 64 bits per word
>>>>>> + * - The transfer length in word must be multiples of the
>>>>>> dma_burst_len, and
>>>>>> + *   the dma_burst_len should be one of 8,7...2, otherwise, it will
>>>>>> be split
>>>>>> + *   into several SPI bursts by this driver
>>>>>
>>>>> Fine, but then also rephrase the previous paragraph since you're
>>>>> adding DMA.
>>>>>
>>>> Will do.
>>>>
>>>>> Could you precise on which platform you tested the DMA ?
>>>>>
>>>>
>>>> aq222(S4)
>>>
>>> Will you be able to test on other platforms ?
>>>
>>
>> I tested it on other platforms over the last few days. G12A and C3 and
>> T7(T7 CLOCK use local source).
>>
>> My board SPI does not connect peripherals and is tested through a
>> hardware loop.
> 
> I can test it on GXL and SM1 in the next two weeks against a SPI
> display and some WS2812B LCDs.

Would be great, thx !

Neil

> 
>> cmd:
>> spi_test -D /dev/spidev0.0 -v -s 5000000 -b 64 -l
>>
>>>>
>>>>>>     */
>>>>>>
<snip>


