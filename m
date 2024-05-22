Return-Path: <linux-spi+bounces-2993-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B24F38CC0B2
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 13:53:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BBC91F21E1E
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 11:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B944E13D533;
	Wed, 22 May 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TaayML6I"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBF77F08
	for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378790; cv=none; b=Ttnsy+u0EkXsWdmGcywoYZN8drXixNE1kx+crgGr0h1/M4o3+nGkNTMQpHSjH1OAtqWcKM5Ma9NH/8Lt3vJJdV6Lpo4e9Kle/HpVLRmib3lU6XKkFxM6JSVbsmxhO4CYWPQQS0dtwBkBnLE3yHs/36ge5YPW7f6v0cUaTjK+zU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378790; c=relaxed/simple;
	bh=WXZH/yz80gYFyQ4BbC/w5IyTTWDKcC5KranzjFiKEL4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S+EAk7t089CZmmrfHXrO585feh9zKgFUqEse4UNBFk7Seo7QoeMl2gY3ksR+F77f4rnHyLg4CHhsO2fuolLo+aZmJNkX+s4v0z0alECWO8W5FBjG5Kf8Hts2X0ltqxUthz0kEPtmLiIlmK53Q8HTRNrf8yqAMFhY2WyCEnjJUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TaayML6I; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5cec2c2981so404828766b.1
        for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 04:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716378787; x=1716983587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lZc9L8nSVEY9ZvVjEf6riakUMqbgRISVhXQ6LxB8KeY=;
        b=TaayML6II0kHHVHrWwLC5JIM8ff/LcVqw6r24NFCuCaSgQ1eYUa+WMnVM+X9xy4chK
         o9t6bm6hxUd4QasRmKMFnEkStBch/BjtELV5IJsA20qiDlD6S9bOV0axKgH5hzk/UAwr
         IwoX60u1+z4F22y1nj9yeRk39ZmXHo834GjnAcLMtmxOdb7kGmcVFE57SYLcdEZiLgn5
         KZwK9XbV/MRBCGo0pgygZf7aa2saS06trCdtmaP/UcEuOy1YpjSykt03m62SSKBgz49s
         CwqsikpAlSU0PiNt3HodvSFvKf/oBCR0BMJoOGkQICozATjVxmXPCRqovtBPhzT5EG2S
         cxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716378787; x=1716983587;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lZc9L8nSVEY9ZvVjEf6riakUMqbgRISVhXQ6LxB8KeY=;
        b=l46hmSpF1jemr7GklWt7/H3o0sJjtpv4JJRtzhjdHDmPTPlfkNCVUrj623ZdHdMzDq
         P1IPO8+ueSb/MQmF5ZsPG3hrSvbJS8b2ywlw5BQ9RLJBMmAwhj/yoLqrIh49dXfxhJRK
         /i82l2SucJ+zAUHSZ2de7GquBB/xydbVSbQbA+bu6ZcYeUZINSC0Da1zYegtZjP9oAQU
         mt1uTDyG/I1WQWWpcJ8B9k8+kUD8kIr5Ss4Qzj33JPgWMujchh8XpcdEe6Zjt59T2Yyq
         68YhKDym87DtNpHoXr279W3YPx47z/trwBA3LHZqJUvsqji0DKZOD/5ygO00xpGOO81F
         FTXA==
X-Forwarded-Encrypted: i=1; AJvYcCUqIrAHV5pVv5o78LmGC3eRUOFson+qS+SHPucBl+9Aac2UbDAe7RPR+SDe3NS3AyEw26OOeylX15yU7bi8a7BcLYrzT3TAmWBD
X-Gm-Message-State: AOJu0Yxp+OyeoLhuhvXvg/BdNIWuvXSVO/qBbGC7+sd8qOJLHWlyRiv3
	a8z6CiuGyGKRGwqzzVmCXhe1lipfM4/gxzhDMQI2jzz+k3aYnaem/UTyl6AhPBj2gko3OLO3zdP
	o
X-Google-Smtp-Source: AGHT+IE4NBVO9QRHXYLTIYpzW5NCa2OlPs1k+MjfwqxSTPKnDPMzW1HQCLXvDCpYDeLK3/lR8XPvpA==
X-Received: by 2002:a50:cdcd:0:b0:572:7d75:a70e with SMTP id 4fb4d7f45d1cf-57832a8c715mr1390052a12.25.1716378786998;
        Wed, 22 May 2024 04:53:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10? ([2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5751ada828esm7285640a12.62.2024.05.22.04.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 04:53:06 -0700 (PDT)
Message-ID: <5c32d7fd-4a7f-4d9c-805c-87d4d14f741e@linaro.org>
Date: Wed, 22 May 2024 13:53:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
 <8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org>
 <Zk3X7Dgst5kVzJxy@smile.fi.intel.com>
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
In-Reply-To: <Zk3X7Dgst5kVzJxy@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/05/2024 13:33, Andy Shevchenko wrote:
> On Wed, May 22, 2024 at 12:03:33PM +0200, Neil Armstrong wrote:
>> On 15/05/2024 23:09, Nícolas F. R. A. Prado wrote:
>>> On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
>>>> Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
>>>> have checks for orig_nents against 0. No need to duplicate this.
>>>> All the same applies to other DMA mapping API calls.
>>>>
>>>> Also note, there is no other user in the kernel that does this kind of
>>>> checks.
>>>>
>>>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>>
>>> Hi,
>>>
>>> this commit caused a regression which I reported here:
>>>
>>> https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
>>>
>>> along with some thoughts on the cause and a possible solution, though I'm not
>>> familiar with this code base at all and would really appreciate any feedback you
>>> may have.
>>
>> I also see the same regression on the SM8550 and SM8650 platforms,
>> please CC linux-arm-msm@vger.kernel.org and me for a potential fix to test on those platforms.
> 
> There is still no answer from IOMMU patch author. Do you have the same trace
> due to IOMMU calls? Anyway, I guess it would be nice to see it.

Yes :
[    6.404623] Unable to handle kernel NULL pointer dereference at virtual address 000000000000001c
<snip>
[    6.641597] lr : __dma_sync_sg_for_device+0x3c/0x40
<snip>
[    6.688286] Call trace:
[    6.688287]  iommu_dma_sync_sg_for_device+0x28/0x100
[    6.717582]  __dma_sync_sg_for_device+0x3c/0x40
[    6.717585]  spi_transfer_one_message+0x358/0x680
[    6.732229]  __spi_pump_transfer_message+0x188/0x494
[    6.732232]  __spi_sync+0x2a8/0x3c4
[    6.732234]  spi_sync+0x30/0x54
[    6.732236]  goodix_berlin_spi_write+0xf8/0x164 [goodix_berlin_spi]
[    6.739854]  _regmap_raw_write_impl+0x538/0x674
[    6.750053]  _regmap_raw_write+0xb4/0x144
[    6.750056]  regmap_raw_write+0x7c/0xc0
[    6.750058]  goodix_berlin_power_on+0xb0/0x1b0 [goodix_berlin_core]
[    6.765520]  goodix_berlin_probe+0xc0/0x660 [goodix_berlin_core]
[    6.765522]  goodix_berlin_spi_probe+0x12c/0x14c [goodix_berlin_spi]
[    6.772339]  spi_probe+0x84/0xe4
[    6.772342]  really_probe+0xbc/0x29c
[    6.784313]  __driver_probe_device+0x78/0x12c
[    6.784316]  driver_probe_device+0x3c/0x15c
[    6.784319]  __driver_attach+0x90/0x19c
[    6.784322]  bus_for_each_dev+0x7c/0xdc
[    6.794520]  driver_attach+0x24/0x30
[    6.794523]  bus_add_driver+0xe4/0x208
[    6.794526]  driver_register+0x5c/0x124
[    6.802586]  __spi_register_driver+0xa4/0xe4
[    6.802589]  goodix_berlin_spi_driver_init+0x20/0x1000 [goodix_berlin_spi]
[    6.802591]  do_one_initcall+0x80/0x1c8
[    6.902310]  do_init_module+0x60/0x218
[    6.921988]  load_module+0x1bcc/0x1d8c
[    6.925847]  init_module_from_file+0x88/0xcc
[    6.930238]  __arm64_sys_finit_module+0x1dc/0x2e4
[    6.935074]  invoke_syscall+0x48/0x114
[    6.938944]  el0_svc_common.constprop.0+0xc0/0xe0
[    6.943781]  do_el0_svc+0x1c/0x28
[    6.947195]  el0_svc+0x34/0xd8
[    6.950348]  el0t_64_sync_handler+0x120/0x12c
[    6.954833]  el0t_64_sync+0x190/0x194
[    6.958600] Code: 2a0203f5 2a0303f6 a90363f7 aa0003f7 (b9401c2

Reverting  8cc3bad9d9d6 ("spi: Remove unneded check for orig_nents") removes the crash.

> 
> Meanwhile, I have three changes I posted in the replies to the initial report,
> can you combine them all and test? This will be a plan B (? or A, depending on
> the culprit).
> 

I'll try to apply them and test.

Neil


