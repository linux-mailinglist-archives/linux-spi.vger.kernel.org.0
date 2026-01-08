Return-Path: <linux-spi+bounces-12219-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F1CD04351
	for <lists+linux-spi@lfdr.de>; Thu, 08 Jan 2026 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B52E3044597
	for <lists+linux-spi@lfdr.de>; Thu,  8 Jan 2026 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E5E2DC336;
	Thu,  8 Jan 2026 15:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="G3j41mTi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6BD2DB7AE
	for <linux-spi@vger.kernel.org>; Thu,  8 Jan 2026 15:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887853; cv=none; b=Wnufn/fUAT1UkWMsfzCx0r1a/alni7tJTeBhN9Bw662DA6nadbCA1ifo4TJzTavOgcOzcf7mmVvg4xaELiPUifgjtoKUkSlAvBb9jpmvYb92qF0AJ35JlMij4HGOxDfC4iLwFH94FjASE8ix2vVORq5QzkK5MXC8DsGb7zycqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887853; c=relaxed/simple;
	bh=XcIRTAb5PFlqniPMsUHB2MwKn3jJ/O2F2bHm2pJVK/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YCB0981+chTt2UcmyZ+MoViEdaroXeNGUk7GJXEOU0CTjUv49EPjp1ENGctlDplxfMjPWbuSjreOgf6eyYhRhDNY2RC5S97iswNd+lycAPzL50UJyLf3G1KKFLhTeLS3D6yLaJW6RY6kMqBBVNWh0zmqoQpwZvyEQTu4EqA3Jds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=G3j41mTi; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-7c7545310b8so1821611a34.1
        for <linux-spi@vger.kernel.org>; Thu, 08 Jan 2026 07:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767887850; x=1768492650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ChbNYybDAN+PlLSGQ3kv1WrtIpPyDTfLMW7/iZLxLus=;
        b=G3j41mTiH9RcwOYuX7LMffkbdVh5ol8NDyZn83UCLVsWLWe05zy9ilbTAvrSd2CZvh
         t1E6eLILdeV1xwCZ8z2fPt2WPrdc3QH7zwhSbOsc8tDCLQPcoKWV0xmCjFSjDq1vEOVP
         u1RF1y66OJ1TAWDptOcak8rpW8CNUBzy3in0XoPt0nstEVSn8KcbfADWwgzxh0VFQHWu
         NdFq5NP0LXtUMNb6VQMrH74SIEw5yvJsJwIvZGkTLVJVD9jIbFvtpiasC+W6JZGNwv6m
         jwjhd5hUcz5vjI16T8zOsDoN6F+w9ljMPTtWyt2pqmHJ8xricXwxBXvsiE6x1zaBCJzx
         cqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767887850; x=1768492650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ChbNYybDAN+PlLSGQ3kv1WrtIpPyDTfLMW7/iZLxLus=;
        b=jGSRrsat1w0UcdMgxUjrwpBsZ3wxqvtAOii2gYH07O9er8/H3IoJb0Q07QAD/81fd5
         Z1nej6W0PAat2qZNU5KTXMK+0Df1yrHxRrb3kck76nhjRAucWE/y3s4aTfaJMGQ18Xuv
         Kg7q+eMif50HoB7ZFcl8aabW7c/XsJOP1oxSqSBcM9WQAunFXStdFo5S9H1AmY1Y4KGc
         Yq/QBBJVTNFOtJVO4EyeZ78jKKCoNBmKDRJ4UjNfPABxmPOKuFq8CxEuJIxQaPNaMjQN
         iOm76kpisikmtZh0NqRQGkDUD+COYHNdf1UKG9ADHXgd/sbwNqfNlmcoV5PT8zF8e4I+
         dcLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHxCIYYwdqH0bz5geqjzpoIrVaMT7gjInnzNK5HxzvkHiuUlQMmUK9yvew/ER5jFwo8AH/x7Xfzeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYO5LicvQGtPJWmbV/gjZ4bbhdZeonDyqeQaGb1fsqGm/8Mr21
	AnNEEt3AOj6fqTuafuDtjYlpJKqPO3bjEabOqQ7AOwtgCc7g1OFijSmHj8XdxCJJtDs=
X-Gm-Gg: AY/fxX6HnFknKjM8z4jP4KW2ugjabs6Vljzr+ZKNYcPgNvOOe+u1cDFuaTuLGXfUosh
	gCVKB9Zz2xptUf+5eo3BXrjepW6YiFLvzd/MRwP/2KN7k61yZmLlo5qrQsUazLemcnkRO0ZsA+l
	obapmaY7QBXkOrCwSws5xjQ8POx7cKbAodfQs1brSuW9ICgbbCoOtQSt2m5itRCdBDqNy2xJ4Ho
	lT1af6NejyNy66osCIlOOZ0tEotUPdgHVqoxYANTVvE0iEYCV/FQ3aP3R6XX7QEzCvoxFlNcXa6
	HIIwXzpqZl58J3XUHSHbxSQf9zynooEy2K84Vt9o4pSdiYQAVbwJbd5rFXfbRtTwuPisaieNA6T
	MfK0VfL5CFpoJUsdM6j5YEGhviASW9jPAIGtLZpQQWiCXjXpZcnvlfD1OS2gtsbWl5nrBCLo3MO
	abOu9Ww00pnnmZxswPORLTOfWE5OEMjXXnbXys78oyGVvoC5lmkEe2T0+fAPWr
X-Google-Smtp-Source: AGHT+IEqkm4LvUk8v6PJn4dMOjcEAKptGcqeUy22nLPhpl6cUZVQsY3c5PT1cLF07hCu1ja1uiQnug==
X-Received: by 2002:a05:6830:6f83:b0:7b7:59c5:766c with SMTP id 46e09a7af769-7ce50bec1b5mr3163482a34.33.1767887850382;
        Thu, 08 Jan 2026 07:57:30 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c69c:7b5c:ce9b:24be? ([2600:8803:e7e4:500:c69c:7b5c:ce9b:24be])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af813sm5732105a34.19.2026.01.08.07.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 07:57:29 -0800 (PST)
Message-ID: <97096aa2-acf1-4e4b-b03b-b538c3c1cf27@baylibre.com>
Date: Thu, 8 Jan 2026 09:57:29 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] spi: Documentation: add page on multi-lane support
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-5-145dc5204cd8@baylibre.com>
 <aV-lzD1BEVSkGjba@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aV-lzD1BEVSkGjba@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/26 6:40 AM, Marcelo Schmitt wrote:
> Hi David,
> 
> Thanks for adding a doc for the multi-lane stuff.
> Two minor comments inline.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> On 12/19, David Lechner wrote:
>> Add a new page to Documentation/spi/ describing how multi-lane SPI
>> support works. This is uncommon functionality so it deserves its own
>> documentation page.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>> v4 changes:
>> * New patch in v4.
>> ---
>>  Documentation/spi/index.rst               |   1 +
>>  Documentation/spi/multiple-data-lanes.rst | 217 ++++++++++++++++++++++++++++++
>>  2 files changed, 218 insertions(+)
>>
>> diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
>> index 824ce42ed4f0..2c89b1ee39e2 100644
>> --- a/Documentation/spi/index.rst
>> +++ b/Documentation/spi/index.rst
>> @@ -9,6 +9,7 @@ Serial Peripheral Interface (SPI)
>>  
>>     spi-summary
>>     spidev
>> +   multiple-data-lanes
>>     butterfly
>>     spi-lm70llp
>>     spi-sc18is602
>> diff --git a/Documentation/spi/multiple-data-lanes.rst b/Documentation/spi/multiple-data-lanes.rst
>> new file mode 100644
>> index 000000000000..b267f31f0bc8
>> --- /dev/null
>> +++ b/Documentation/spi/multiple-data-lanes.rst
>> @@ -0,0 +1,217 @@
>> +====================================
>> +SPI devices with multiple data lanes
>> +====================================
>> +
>> +Some specialized SPI controllers and peripherals support multiple data lanes
>> +that allow reading more than one word at a time in parallel. This is different
>> +from dual/quad/octal SPI where multiple bits of a single word are transferred
>> +simultaneously.
>> +
>> +For example, controllers that support parallel flash memories have this feature
>> +as do some simultaneous-sampling ADCs where each channel has its own data lane.
>> +
>> +---------------------
>> +Describing the wiring
>> +---------------------
>> +
>> +The ``spi-tx-bus-width`` and ``spi-rx-bus-width`` properties in the devicetree
>> +are used to describe how many data lanes are connected between the controller
>> +and how wide each lane is. The number of items in the array indicates how many
>> +lanes there are, and the value of each item indicates how many bits wide that
>> +lane is.
>> +
>> +For example, a dual-simultaneous-sampling ADC with two 4-bit lanes might be
>> +wired up like this::
> At first, I thought calling these '4-bit lanes' was a bit confusing. I was
> thinking about suggesting '4-wire lanes' but I guess 4-bit is more generic in
> case we ever see a setup where data navigates through something besides wires.
> 
>> +
>> +    +--------------+    +----------+
>> +    | SPI          |    | AD4630   |
>> +    | Controller   |    | ADC      |
>> +    |              |    |          |
>> +    |          CS0 |--->| CS       |
>> +    |          SCK |--->| SCK      |
>> +    |          SDO |--->| SDI      |
>> +    |              |    |          |
>> +    |        SDIA0 |<---| SDOA0    |
>> +    |        SDIA1 |<---| SDOA1    |
>> +    |        SDIA2 |<---| SDOA2    |
>> +    |        SDIA3 |<---| SDOA3    |
>> +    |              |    |          |
>> +    |        SDIB0 |<---| SDOB0    |
>> +    |        SDIB1 |<---| SDOB1    |
>> +    |        SDIB2 |<---| SDOB2    |
>> +    |        SDIB3 |<---| SDOB3    |
>> +    |              |    |          |
>> +    +--------------+    +----------+
>> +
>> +It is described in a devicetree like this::
>> +
>> +    spi {
>> +        compatible = "my,spi-controller";
>> +
>> +        ...
>> +
>> +        adc@0 {
>> +            compatible = "adi,ad4630";
>> +            reg = <0>;
>> +            ...
>> +            spi-rx-bus-width = <4>, <4>; /* 2 lanes of 4 bits each */
>> +            ...
>> +        };
>> +    };
>> +
>> +In most cases, lanes will be wired up symmetrically (A to A, B to B, etc). If
>> +this isn't the case, extra ``spi-rx-bus-width`` and ``spi-tx-bus-width``
>> +properties are needed to provide a mapping between controller lanes and the
>> +physical lane wires.
>> +
>> +Here is an example where a multi-lane SPI controller has each lane wired to
>> +separate single-lane peripherals::
>> +
>> +    +--------------+    +----------+
>> +    | SPI          |    | Thing 1  |
>> +    | Controller   |    |          |
>> +    |              |    |          |
>> +    |          CS0 |--->| CS       |
>> +    |         SDO0 |--->| SDI      |
>> +    |         SDI0 |<---| SDO      |
>> +    |        SCLK0 |--->| SCLK     |
>> +    |              |    |          |
>> +    |              |    +----------+
>> +    |              |
>> +    |              |    +----------+
>> +    |              |    | Thing 2  |
>> +    |              |    |          |
>> +    |          CS1 |--->| CS       |
>> +    |         SDO1 |--->| SDI      |
>> +    |         SDI1 |<---| SDO      |
>> +    |        SCLK1 |--->| SCLK     |
>> +    |              |    |          |
>> +    +--------------+    +----------+
>> +
>> +This is described in a devicetree like this::
>> +
>> +    spi {
>> +        compatible = "my,spi-controller";
>> +
>> +        ...
>> +
>> +        thing1@0 {
>> +            compatible = "my,thing1";
>> +            reg = <0>;
>> +            ...
>> +        };
>> +
>> +        thing2@1 {
>> +            compatible = "my,thing2";
>> +            reg = <1>;
>> +            ...
>> +            spi-tx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for tx wire */
>> +            spi-rx-lane-map = <1>; /* lane 0 is not used, lane 1 is used for rx wire */
> In this example, even though lane 0 is not used by thing2, it is being used by
> thing1, right?

Yes, I can improve the comments to make it more clear.

> Just checking I understand it correctly.
> 
>> +            ...
>> +        };
>> +    };
>> +


