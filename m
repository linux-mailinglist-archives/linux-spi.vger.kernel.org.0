Return-Path: <linux-spi+bounces-10225-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09281B937A0
	for <lists+linux-spi@lfdr.de>; Tue, 23 Sep 2025 00:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849683A707A
	for <lists+linux-spi@lfdr.de>; Mon, 22 Sep 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1A62C187;
	Mon, 22 Sep 2025 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YZkVO44L"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDFE189F20
	for <linux-spi@vger.kernel.org>; Mon, 22 Sep 2025 22:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758579719; cv=none; b=EztUYjsyC20F0B4hYu6EeMwEBOwjq6nXkAKgeNp5VqdN0ePmMQK+S9KvqNuaHUbpMh1BM3fv/vh2pY0oFJ3ZVEv8tJXDJ6GA1s8R2A/4s2/h3oH3aQhW2lm8KrKz1SDGez1U2l+AbZBQ9WB0ZQr0HDk7c+UKPfmXSjNISHpGJT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758579719; c=relaxed/simple;
	bh=5oqT/+EskjT95UQ02iVrfraL+q6+UfPBzDvXMw+0rI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o1LihlDcML65XHzXDCXXkc2qDVCJlrbuz+BWPU4+2hclqd60L021oJL6gs7RlwUYeSgOwSe5mnys3KxlFs3penFCIdSWe1mZL/FpKqSQWmKn8GzIBQOyxv8G86S/yLaOG01/XcIIBDQFgaxKmUSqa1EiYYvYCTDz1edIlaoIvrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YZkVO44L; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-786e9b51248so475363a34.0
        for <linux-spi@vger.kernel.org>; Mon, 22 Sep 2025 15:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758579715; x=1759184515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DTLhvXVhX7GssWdco0zg+2qQigdBymvGbS2zk9aZ/b4=;
        b=YZkVO44LUNY3vxt7kxWyDXeNqzyuR++Rz818D7Si+mbLdRujhscDfTcJzV+TqsPESd
         2cP7Ix3AvbcWkWPDbnFJ07ZKzmLi/Io5PX+14qJM7gJ/L5EtVqOBF5nrN2gF8urJs9Sw
         NnRA5Yb4vRvEd0C43wdbp2udt7YSKl7WZ3KzPNx6JViGUOhsKJCIRGLuQJHAHoELtC9l
         3+5M5tt98zdj/R0mRkSNU+3RHAI4eh2hSs6Ue2ANQiEnxyGkDMjT06If4TnfbtV/hlFy
         HcvKk6P6HmuA91N9vmGDEtsy6P/TrCK1g1MUPuEVLZrdHmLHslSFPhdcwaCnaFiBWHkg
         xMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758579715; x=1759184515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DTLhvXVhX7GssWdco0zg+2qQigdBymvGbS2zk9aZ/b4=;
        b=e22Z38ybP0qDNdW/qWrucUCohLOVo45queuPJ+ExXGAMxfvHli8h756NtYsSdWJkem
         oJykq6MlyW4c7T2DMd+ElZyvfR8WotTsbsD5wOcsZBXVVl46sHY3xI9s3VobMlVHAMWk
         6nRA9oAZuv1SgvLYGjfIsgCGq0DK/pCf59B4tOlL8ByctSAf73vsVydB1PmDjC9SoNnc
         URCdpG2Qh6wBw/p8KYRPX1wJf3A5L1PNQA77J4R5GPMALmmsHh9i6EC87PsVjkPz85sg
         JIGCKjTyZaXh6V7IJaD6crLkCl4c5LJhQsja0XA15tNdGwLe4waX319Z6jX45zXbDSz9
         7Urg==
X-Forwarded-Encrypted: i=1; AJvYcCVw0uo+XRiwg2pcewyQfbroWbT72lRB3EiJ6+1vxxhwjqmLjpoDRpT0fFymCqwDm8b5XJ0iODUfKS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvPNK2P07YR5h3tSUIK5xioQw6qmC5CA9J/cMu7CWPBs1q/qtt
	w5LqgVANgd1oJ4WoBpEnWjyImpGgbCoxGVpv9E+vvFfejXFnNwQpuQBGB4Vq6w0MRoc=
X-Gm-Gg: ASbGncsm46K2sTD1rzjDE9U1BV+Da02/llr7ghX1yw1W/v87XwdkX8sF52eBJRPxVTf
	swZeYXZazSpx6erRYCu2z4kBbvwHiaSWbuk2EuX7euIEYjlHn5GyuI0h/nmjg8RG41UNbLuXq6k
	SiIZFx1OBfxzRfeLRtRPfXjUmqHp4XbBy/tmlyJr/jWf5YRritjLGZJEt7aAmBYYdKzdRrYdrfa
	/CvCPvtc1Ii7mrGt4Gad7uarBYQdSbzDCamQkLhYkj1bpP9MlDj/dfbq25Ex65JtTNv/GZDPif6
	C82udbF1ADk1rcFwOiMNxsJep9j49XE78A05cTMpKRN/SijPKqlQYqZIaT4SkwZGC3QJDwufkHP
	zXMgHtbKKUydXNvPXKSfWJDyiLR9lf/MV2nbWZF4Q+A/VPQiX0IhODCLh/CsAMGwCrMFxjOKol7
	7UbHCtcrJBhw==
X-Google-Smtp-Source: AGHT+IHIwhkhaTyaeI4QExDUkUooOZb2rugZFLrr3rg3bIJULREQlPjANVdD95uXqhOHKDLwlVrzPw==
X-Received: by 2002:a05:6830:3891:b0:78e:fd71:8e02 with SMTP id 46e09a7af769-79157d59395mr176216a34.25.1758579714829;
        Mon, 22 Sep 2025 15:21:54 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:505f:96cd:1359:fff4? ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-625d881ffd9sm4392310eaf.3.2025.09.22.15.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 15:21:54 -0700 (PDT)
Message-ID: <d1778ced-1660-424c-97eb-72a35152f13f@baylibre.com>
Date: Mon, 22 Sep 2025 17:21:52 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v7 0/7] clk: clk-axi-clkgen: improvements and some
 fixes
To: Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?Q?Nuno_S=C3=A1_via_B4_Relay?=
 <devnull+nuno.sa.analog.com@kernel.org>, dmaengine@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-spi@vger.kernel.org, nuno.sa@analog.com
Cc: Michael Turquette <mturquette@baylibre.com>,
 Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
 Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Trevor Gamblin <tgamblin@baylibre.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Mark Brown <broonie@kernel.org>, Mike Turquette <mturquette@linaro.org>,
 Xu Yilun <yilun.xu@linux.intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250627-dev-axi-clkgen-limits-v7-0-e4f3b1f76189@analog.com>
 <175847570323.4354.7019519707280531872@lazor>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <175847570323.4354.7019519707280531872@lazor>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/21/25 12:28 PM, Stephen Boyd wrote:
> Quoting Nuno Sá via B4 Relay (2025-06-27 07:59:09)
>> This series starts with a small fix and then a bunch of small
>> improvements. The main change though is to allow detecting of
>> struct axi_clkgen_limits during probe().
>> ---
>> Changes in v7:
>>  - Just include new tags.
>>
>> - Link to v6: https://lore.kernel.org/r/20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com
>> - Link to v5: https://lore.kernel.org/r/20250512-dev-axi-clkgen-limits-v5-0-a86b9a368e05@analog.com
>> - Link to v4: https://lore.kernel.org/r/20250505-dev-axi-clkgen-limits-v4-0-3ad5124e19e1@analog.com
>> - Link to v3: https://lore.kernel.org/r/20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com
>> - Link to v2: https://lore.kernel.org/r/20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com
>> - Link to v1: https://lore.kernel.org/r/20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9c@analog.com
>>
>> ---
>> Nuno Sá (7):
>>       clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
>>       clk: clk-axi-clkgen: make sure to include mod_devicetable.h
>>       include: linux: move adi-axi-common.h out of fpga
>>       include: adi-axi-common: add new helper macros
>>       clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
>>       clk: clk-axi-clkgen move to min/max()
>>       clk: clk-axi-clkgen: fix coding style issues
> 
> What is the merge strategy for this series?
> 
FYI, v6 of this series was pick up and merged in v6.17-rc1.
So I don't think there is anything else to do here.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/clk/clk-axi-clkgen.c

