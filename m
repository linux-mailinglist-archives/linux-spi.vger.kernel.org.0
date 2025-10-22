Return-Path: <linux-spi+bounces-10768-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA9CBF9F2B
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 06:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728E63B4988
	for <lists+linux-spi@lfdr.de>; Wed, 22 Oct 2025 04:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB62D7D27;
	Wed, 22 Oct 2025 04:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="KAHKDISU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0642D7814
	for <linux-spi@vger.kernel.org>; Wed, 22 Oct 2025 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761107664; cv=none; b=nDoLl10sCM8FtNVwmHWk+DzVe9V+KvyjsbnRg9QQHgcFxjiIvheEimwfWBS44FidxzzjH1k+fUfBuOHrG61z21IGYJSPZoFWPv9feRJppgw011qndADbd+f6hc3iyRf5zY9k4Kl3cfY8dTVZgwmPYQ0L2aez3q7vGQha1i1Mvmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761107664; c=relaxed/simple;
	bh=szq/rOHUN+3GufB7hVfQTfjTIKoq4aYdgJfWA0SfWRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAbtKCBZS5diAvPMI3YzQPxBJFjF7qlRSxaX9b6pR1OSp/OnFOLkuCNOZUdrRFAEMMwJ5x3TAJFNywmOyTEq6GzzANsTyzNaigqU9OWCxNAM6ntDZN5hohgGf2bs2QWxhRV6jaX/5QhOKe3BCQMC0T38cZVqUfrEJVMFom6ebXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=KAHKDISU; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso5653a12.3
        for <linux-spi@vger.kernel.org>; Tue, 21 Oct 2025 21:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761107662; x=1761712462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXV9nPTtzRS7GB0GpGCBfWyozkzIjx5wpujc/niwppI=;
        b=KAHKDISUocfMwFBSSuAZDS2N0vPxvCNLwl6lMjLM0ohsr1ItTVlls1K98KQ4llrO0Z
         nUcIMHPqNG4KZOVjjdf22OfzEqZcz9wpjaq6p36Lhho6Qt8TvEZ8ln3NHSf4GRPQ0hPu
         gGWNxGQQJxEwavnHJBMiEGgPW4IobrI8oZ1aflO+euXhaWIz6aZZWms24abyjQ3slT/y
         3N/eU0LSw1XsGDCC491wEBmUPf5Ivx8S0jszqcplGcJ0IDNIB9DWhfU1QBQOxVamB2C3
         idJ7kcDb+ww+f34w4bTgVVZxVVm+/mirMTDtLYyLBp7H656+qCr5BnXpfHqXW0W8Lwce
         ja0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107662; x=1761712462;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXV9nPTtzRS7GB0GpGCBfWyozkzIjx5wpujc/niwppI=;
        b=LTOqoLkeAMXQZxl6h4SUCUcBA9PN4KnYuH0b2/umkQHVM7MhVEZfdG2hc/ITHVU+mh
         Kp70RHVjTdhwNDhvWQsZ/ByjduzBLMkK6x7jUU9OTTQXCIH9lton9CEPAGLeFZqk5VWm
         4FOjivg+KwPg7lwYJ11wOPp9TnwnE5boX0fpPf8A+i59cF0Aj/gYfl6nuOtxBSpbTnuK
         3HOxQBijoBdjVPjkQ1lSYwme9SYSKTcTAtuVwNO4DO1OS5JhHuYzwmBdm2ODFQyQ1IC/
         b9GquPtVIo6/WONA1DPcbG0y7aEJ6DIpnyQWJVyqSVGNcR3JYHdpNzE0SAfPs81Nk4DP
         IGFw==
X-Forwarded-Encrypted: i=1; AJvYcCUwE/I+BW1Nbg5t5qOX9LmEfR3FzrcwpO2ppVmp6mZK5A2lgmTooTGqxfqUw4kNqBdGyhrIvKTqEHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg4ixiGytffxXKz4/i+Ei8ceLcWVSCZijmTWwngkPeI+BGmOO9
	O03aROtj+KaHbo88bFAg/EalZVk7LiAmHVlEZE+3jcn7QsMt5HL0EOuvLrBaDWAC8Rs=
X-Gm-Gg: ASbGncuTIaMgQhQIh/nZVFeG+bfXUL7/8bBU2bVMu1rVhR/Rg8HW+dxMc6hhdHlkCoo
	rGlVCj2kj/SvbDt+mvxdPtt65VM3HRYOPkh6Hyfujaj3hPw/4u+KjRYURlo+ge1gRLTgm/h0Zrt
	JmAjT1ffPRObG6rBdLNMy1/GHBOID8nRAT0STOMg6zHkpbgKzaVZoQBAnSHzhc95/XJrtZNHxGd
	ocvm4vrIqW8EBHz6//CpopjcRNYEhDTa8I0zPqLhfXCfqLyKjL2DXg77t3OyKF5j4QJCC4yDLSg
	+8VQHqdfxcqg3/igDdBvNvHs7+8JkWJ23J+fvkOTP0IUDn5u9w/qai99QbJVOtVmjn+fmXzVveL
	zlGxJI2LrG4ADNFwYMZ0J1CEGWCuHW4ylRo2ULpzdRETn2Wou1nl76Il8EfukkxELnosDlI7ysG
	kT2QVkKdKKty0w
X-Google-Smtp-Source: AGHT+IGMxMq8ODA384WIjA22NE56jXOrifm3A5Z150bOKY/fGOgxvMMpMNK8BhQcEf3SEUsHJhYpWg==
X-Received: by 2002:a17:903:298d:b0:267:87be:505e with SMTP id d9443c01a7336-290c9cbc185mr219746635ad.23.1761107661774;
        Tue, 21 Oct 2025 21:34:21 -0700 (PDT)
Received: from [10.211.55.5] ([4.28.11.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fe4cdsm126257025ad.97.2025.10.21.21.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 21:34:21 -0700 (PDT)
Message-ID: <c93c1319-2f1f-4303-bb4b-751979f58149@riscstar.com>
Date: Tue, 21 Oct 2025 23:34:20 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] spi: fsl-qspi: add optional reset support
To: Frank Li <Frank.li@nxp.com>
Cc: han.xu@nxp.com, broonie@kernel.org, p.zabel@pengutronix.de,
 dlan@gentoo.org, guodong@riscstar.com, linux-spi@vger.kernel.org,
 imx@lists.linux.dev, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-4-elder@riscstar.com>
 <aPaIezCu/gXxJC01@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <aPaIezCu/gXxJC01@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 2:07 PM, Frank Li wrote:
> On Mon, Oct 20, 2025 at 11:51:46AM -0500, Alex Elder wrote:
>> Add support for one or more optional exclusive resets.  These
>> simply need to be deasserted at probe time, and can remain that
>> way for the life of the device.
> 
> Nit: please wrap at 75 chars

You're saying wrap at *longer* lengths, right?  If not, please
clarify.  I'll update in v2.

Thanks for the  review.

					-Alex

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   drivers/spi/spi-fsl-qspi.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
>> index c887abb028d77..1e27647dd2a09 100644
>> --- a/drivers/spi/spi-fsl-qspi.c
>> +++ b/drivers/spi/spi-fsl-qspi.c
>> @@ -36,6 +36,7 @@
>>   #include <linux/of.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/pm_qos.h>
>> +#include <linux/reset.h>
>>   #include <linux/sizes.h>
>>
>>   #include <linux/spi/spi.h>
>> @@ -267,6 +268,7 @@ struct fsl_qspi {
>>   	const struct fsl_qspi_devtype_data *devtype_data;
>>   	struct mutex lock;
>>   	struct completion c;
>> +	struct reset_control *resets;
>>   	struct clk *clk, *clk_en;
>>   	struct pm_qos_request pm_qos_req;
>>   	struct device *dev;
>> @@ -857,6 +859,8 @@ static void fsl_qspi_cleanup(void *data)
>>   {
>>   	struct fsl_qspi *q = data;
>>
>> +	reset_control_assert(q->resets);
>> +
>>   	fsl_qspi_clk_disable_unprep(q);
>>
>>   	mutex_destroy(&q->lock);
>> @@ -902,6 +906,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>>   	if (!q->ahb_addr)
>>   		return -ENOMEM;
>>
>> +	q->resets = devm_reset_control_array_get_optional_exclusive(dev);
>> +	if (IS_ERR(q->resets))
>> +		return PTR_ERR(q->resets);
>> +
>>   	/* find the clocks */
>>   	q->clk_en = devm_clk_get(dev, "qspi_en");
>>   	if (IS_ERR(q->clk_en))
>> @@ -923,6 +931,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>
>> +	ret = reset_control_deassert(q->resets);
>> +	if (ret)
>> +		return ret;
>> +
>>   	/* find the irq */
>>   	ret = platform_get_irq(pdev, 0);
>>   	if (ret < 0)
>> --
>> 2.48.1
>>


