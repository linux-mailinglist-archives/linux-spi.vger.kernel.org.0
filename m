Return-Path: <linux-spi+bounces-12455-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00371D38964
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 23:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C1953034F8E
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 22:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117333128AE;
	Fri, 16 Jan 2026 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c9vZc2Fh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06518264A9D
	for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768603399; cv=none; b=EpLkSVzYFHK6OVvJZUeRNjwGg29nh09W5wJKIGtrVqKMuWUszCF11xh3thp+63WZcPdVdICb3O/vjgvKbJlwlJlp/DeH1yLm1vn+k/KNHIueIw3N3uOrY6DwZIKWdqQRS7iROPmjpAxji26mYM4+KHg8Q7/ElBvI4P+AL+JRcnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768603399; c=relaxed/simple;
	bh=uOdRd7+uMwmMYF4d076SdRnju1u6c6H+tWshE6YoqhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjX/Regc4t4jvQTUcDll7OM70ZVqE25a20IEJWhtZZjsGN5Bth28CNS2hLMgnvRyhZloGkRLuq0+ORvCxYXHkJT8NJyD4VaMAO4YGzwtiyTBLbfy28fHopLCW2ROKlbhjOHiPxrdsix3FQCtG3W6nFlfFZAvNTDbHc152iafEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c9vZc2Fh; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfd2be567bso1609660a34.2
        for <linux-spi@vger.kernel.org>; Fri, 16 Jan 2026 14:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768603395; x=1769208195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2PF8i3QyhCqQGmWWjUESbM/JH/zeGGQE1WnPk6IZFo=;
        b=c9vZc2Fhh6eidNdOD+u+hMhA2f9ka7IIzy8LbDHMIkBRCapPL/gmtNDsv2HEcuBMm/
         4KcCBTkXpjltsH9OlIHqn9tzd9YMT7kYSflHZ9bkNFve1MEy/rGPH0Ygxc19EoDcVVKs
         bh40tkHgWTURCBD0pRahxqV+SFkDCpGyec+yTLdeJ2sXIWx45TPeBUDBK5fIs08KuSnf
         vFaAc+850SpIR7d3GFInOHhYaMs0ovpo1h8YqbYpcsBXpKdO7yAI+dnTu2rSYuqGGQec
         3IvMwRqhe+NzfW/b5ebllklmYgdg1AcypETCvlW87OPYnGo7x3Fohi+chLcyFq+/eplR
         bLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768603395; x=1769208195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C2PF8i3QyhCqQGmWWjUESbM/JH/zeGGQE1WnPk6IZFo=;
        b=keglMaDYyMiEdE1tTiMViWFd4vFyrippGABUTOny/iUT0rAugke9zuj/8ozK950XMl
         LVDwbVsWKNVgcBywqMn8OtsrZTtE2o9ycfipfGVe6oDSJzU5BLwe5NFDxT5HDB+d2kJg
         EGots1sB924cUpU0IB8JTvhqdBVxmu8A3WgmHfL/92smdgAp7LJJ8zLdqQmx6JjdrIen
         BEEXE6Asvwzu1GPhvMFWiKe6OQqIF13U3wEWNrFCqjKmS/gbpfKFba2gc8yNkotm+rGS
         Z8qDjjVfsUMA7tgG3LcMSvqxsQuxaiznw4TPtDPEmutFAoicqUb1yGvgioNa0ZLUhX0B
         vqYw==
X-Forwarded-Encrypted: i=1; AJvYcCXyuJHK8flSUXNRA6ZP9SobrpmL5atQQPKTfJby4O/0yNQzY1gq9BuOOMwykikUYSGZRuQKK8omerY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlps/IF4qrro7KlmFvdXum6VxU+4FXblZvtQJAyh82wr7P/S1a
	8jkUC4+SW51MDLZEuNWwImFXJEdnNh7tz0nKB1N10YLlZSOoPeAxMrNXuMvFRbL/N/U=
X-Gm-Gg: AY/fxX50Dyx7kL/tncyG2DPcJBGuhmwXAAymyH8zvlXX2q8M+D2kiaJZvsoQ5LwOhTK
	nlsw+gXckI7yRZfWY7Tvka6zLXP3rEgXiljp0bDtznQmmuasGjXvaHMdLIJya2FMyNUhBm5Mua4
	1EvqiLqDOk42ysprGdNN5CPKVUHfk8iVfiz/vUQ5tr8FL1S+r/9OhfrHXxQ+PJX4m2+Lb9GCINl
	w6GDoBKucNDIo3JwDNeTlQsyQ5fN3Of8bSL47t/BVPR8X7AVLQd6R49H+pdFdaIr58pkf0SDTaG
	btbTa4pH4Vah3l2i952zCekVfmHXkZmPqHNsBR8Uylhk0tXg3uYyI89/ve9kWfJgkczXXxxWxtd
	a08KqfvVKET3dPw1tFT3XJbULpqeTu8SimjUNSleIkLNBDDur6UGBtp7g7D4OuTXOjxDCxinAI3
	hLk3/4AA3KAJi+3PTk1DbvN3fpXAzTCyAlFpr6i07kI7NcB3x4HTaYsTohhTi1
X-Received: by 2002:a05:6830:6507:b0:7cf:d9bb:639d with SMTP id 46e09a7af769-7cfded1f1cemr2245481a34.1.1768603395110;
        Fri, 16 Jan 2026 14:43:15 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:bd39:740e:f70f:5f7d? ([2600:8803:e7e4:500:bd39:740e:f70f:5f7d])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf2b57e2sm2440834a34.27.2026.01.16.14.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jan 2026 14:43:14 -0800 (PST)
Message-ID: <ce9e2b46-58c9-4346-9e87-d5fbedd13826@baylibre.com>
Date: Fri, 16 Jan 2026 16:43:13 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] spi: axi-spi-engine: support
 SPI_MULTI_LANE_MODE_STRIPE
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
 <20260112-spi-add-multi-bus-support-v5-7-295f4f09f6ba@baylibre.com>
 <20260114091617.170a9757@jic23-huawei>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260114091617.170a9757@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/26 3:16 AM, Jonathan Cameron wrote:
> On Mon, 12 Jan 2026 11:45:25 -0600
> David Lechner <dlechner@baylibre.com> wrote:
> 
>> Add support for SPI_MULTI_LANE_MODE_STRIPE to the AXI SPI engine driver.
>>
>> The v2.0.0 version of the AXI SPI Engine IP core supports multiple
>> lanes. This can be used with SPI_MULTI_LANE_MODE_STRIPE to support
>> reading from simultaneous sampling ADCs that have a separate SDO line
>> for each analog channel. This allows reading all channels at the same
>> time to increase throughput.
>>
>> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Hi David,
> 
> I kind of hope ADI make their versions backwards compatible (or at
> least try to) so the version check might be a bit over the top.

FWIW, I was the one that actually pushed for the FPGA IP block major
version change. There wasn't a default value for the new bit fields
that worked in every case, so there wasn't a way to make it fully
backwards compatible with older drivers that don't set those bits.

> 
> Anyhow, not my problem and the code is nice and clean.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


