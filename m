Return-Path: <linux-spi+bounces-2991-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4DD8CBEE6
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 12:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E817D1F22F25
	for <lists+linux-spi@lfdr.de>; Wed, 22 May 2024 10:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE1811E7;
	Wed, 22 May 2024 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrD33bpY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1168004A
	for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716372218; cv=none; b=FgbZCgWr43JjcpLDzeCGUEMPW9pwUz2zpIvkNDWJJVXptBmYn5ffUEtubxgTBGtBwl2hDoMnwOU7dgToMAAQVFemv6Wy32FwfOLPhBO97BJbPKTys9Xp8fyplAtCe6sMisxmpWlC4rDE/vVucZlxCatbX46B+PxmIf5pM8aVaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716372218; c=relaxed/simple;
	bh=/k7o1FlpsuDLyby8iRf12Ndp/lanSci+8mtZup8bZi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foU//DH9fRByMaiC3oeZ47qz7igtIw2y7moPLWjiONSiiV6+BluQYbpvWp1hkwstD8hr1HLSMtwtBKeqFI+THq5w95vL9aB+aZOj76wvvtObZBBZNgm9OhNV6mJ8OhxExdL9phgtR17QMFlLYrSyHyky+hO6q1wqY4yEwn75l5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OrD33bpY; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-578338936cbso823132a12.0
        for <linux-spi@vger.kernel.org>; Wed, 22 May 2024 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716372215; x=1716977015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :reply-to:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d64ojxj39b0qv5REMXtMjChEe3Uv1kOQgULYr/XjNNc=;
        b=OrD33bpYUkA25WXKpVqmF581yT6aDhSPdPWP3RPrPP04coDIMyPCG1J89IOSXn41na
         ZFi2iCE/wbVodNegOQc/qn8j+10nd3JvxQGXCBXp6SmTkZ/4aKjd4xXmfN3pkZHlnavO
         hmOYmZibp3l7jl1sTP9Gm3W/3d18v0nT59XzusBfjQuu6oa7Wtapia6QeHIwtNol6ITg
         W8e0UY/DqExBb1+HmPIAFzsOq5KVEHXkVFPfe0UzyFqeVvkD+l1mRUJSupFcehllJwSp
         EKvdKvijq3/FLlFNq5HZ+zWJrUj9TzZBxOjnG4nkvE08q8N0Iz3unptk/UEuu1CbgUBb
         X06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716372215; x=1716977015;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :reply-to:content-language:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d64ojxj39b0qv5REMXtMjChEe3Uv1kOQgULYr/XjNNc=;
        b=kf++Dsp248u92x6Pt0lpilXA0WrPhtwgEROkC9D8gO7h8gc8t0Nt8S4TJmYliyygWH
         f++DjFo5p8KVpYGJItJTOV/BknOK/tLqxF4iqns2TC6tmqT5JsL1VZQh3qZjEmJRkGFg
         8CWKCEManYxWwz8NlhIHSZMNTRMWbDNRgV9XeVYfU7EjeWqIOsvYcFJdoY30xJRZraXG
         +J0taqQo7WA8NWVuV3k57Im/JNNfigVtj77ZyCf/yLSa5sBx41vrLf27BlAgZAlypUcq
         uoNvOKH7m3G2MeoJ/ox++Wst6Jm657MFgOti5NCeIjzfXiu9LwZw7UuG98YWbhXG6d7q
         +sFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0iaPbr2H59256WGbRU7d+P+8MVTTCA5ZzSArfU0EqSsGnVlFVUcftfvzWFH56EhAafDM+bdZ1CruzU707pfRO4jk2L1jAwOdE
X-Gm-Message-State: AOJu0YxrTCJZ5Hz4gbzYg9n+bywKOhBL509OhwA3qaAPkNfeCYPHgT98
	e34I+cze6XHn5sGMIT6cKgc8oOV+RARtu6C36AF7VE7yEwAOmGMreUPhzsm5V2o=
X-Google-Smtp-Source: AGHT+IFkxiR9PhRSPZuvVIEMlN1GSVH/+Mr890U2cXQ5AP3tfjhD8hpXjgmKxUPhWJDxANGVLsevzQ==
X-Received: by 2002:a17:906:48d0:b0:a59:bf27:5f2e with SMTP id a640c23a62f3a-a5d5b01c094mr1102719666b.20.1716372214413;
        Wed, 22 May 2024 03:03:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10? ([2a01:e0a:982:cbb0:8b9d:52bd:4757:6b10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm1749615666b.31.2024.05.22.03.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 03:03:34 -0700 (PDT)
Message-ID: <8ae675b5-fcf9-4c9b-b06a-4462f70e1322@linaro.org>
Date: Wed, 22 May 2024 12:03:33 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] spi: Remove unneded check for orig_nents
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20240507201028.564630-1-andriy.shevchenko@linux.intel.com>
 <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
Content-Language: en-US, fr
Reply-To: neil.armstrong@linaro.org
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <d8930bce-6db6-45f4-8f09-8a00fa48e607@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 15/05/2024 23:09, Nícolas F. R. A. Prado wrote:
> On Tue, May 07, 2024 at 11:10:27PM +0300, Andy Shevchenko wrote:
>> Both dma_unmap_sgtable() and sg_free_table() in spi_unmap_buf_attrs()
>> have checks for orig_nents against 0. No need to duplicate this.
>> All the same applies to other DMA mapping API calls.
>>
>> Also note, there is no other user in the kernel that does this kind of
>> checks.
>>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Hi,
> 
> this commit caused a regression which I reported here:
> 
> https://lore.kernel.org/all/d3679496-2e4e-4a7c-97ed-f193bd53af1d@notapiano
> 
> along with some thoughts on the cause and a possible solution, though I'm not
> familiar with this code base at all and would really appreciate any feedback you
> may have.

I also see the same regression on the SM8550 and SM8650 platforms,
please CC linux-arm-msm@vger.kernel.org and me for a potential fix to test on those platforms.

Thanks,
Neil

> 
> Thanks,
> Nícolas
> 


