Return-Path: <linux-spi+bounces-10677-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373DFBDF99D
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D273B3743
	for <lists+linux-spi@lfdr.de>; Wed, 15 Oct 2025 16:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212C51DE8B5;
	Wed, 15 Oct 2025 16:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eiwxvlP3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FF6290F
	for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 16:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544963; cv=none; b=OtiZNOl/WaXXIEtTSPZ1UJIemQ7QCcKgDIncm10Gw5Y0mbOKX3xwmHOZsiJGrC9bvfCcpP/PqxVRR+X2CVvYomJKh7iOuIJ5lz0PkadeBNajVG1/UsOkP+1+jl5q9f7BCDlCidOLv/ECx8A0efthkjzrnYcZq7mXYfawytlQ4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544963; c=relaxed/simple;
	bh=EdQiZWW7dyqxU0xgwc+jBg+2jTFzaTPKjJl04aUEQl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s0bYnekKKRx9QC/UT6m/295+4ck4uiVqk5KJAPzDfdHxFy6u6DCRN4jRWuTGKIdBsMR/ubH1lBnw8uNQPNmK0HvvemfpWz8Q4fjBK+vgmqi7oNd1AC246+monph6LzEi3JwD0xUtqBzG/EQbEccdra9KNOjBgzF9yxSdWL8GzUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eiwxvlP3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7b4f7a856acso2587074a34.3
        for <linux-spi@vger.kernel.org>; Wed, 15 Oct 2025 09:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760544960; x=1761149760; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0cWhyFHm39c/QhmqoFNSj40kRTWbY1xbVx+yxyK9HY=;
        b=eiwxvlP3uwP0gVfa8oLrXd6MllFdrhI+qJFWvTLaERkqCazePpilhUIdNK10ULrFb1
         I42KdHfJjgLFOt4pdLr+wCkKLZI/rTZwhrYS2zWmV3OM0fzIeS0T80FKUJisby4TGK/R
         5ls1KznrDDMeqNIc44BWNIuCa3pfY6yX4KVdPo/spKptj+KPsBtA/4cB9kPu+PQfNr6u
         yxmiY19F4WmJkQF8H/WNKUnOxHhYknNs/u25wNPlKh/++rp0Rvac8kic2M9gXsY28WVI
         mvO2fdoUx7HfskGIcaDnhbBxFdCWsH8qiV1vCc6itq21BugPtMQU5WOkQRsyiI68F+QL
         hFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760544960; x=1761149760;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U0cWhyFHm39c/QhmqoFNSj40kRTWbY1xbVx+yxyK9HY=;
        b=dEYl1C7StMUs5YLO0lyCrlJwO1YrR4HFUJO0NRZ/IY2v8SYT9clxKxDDQNsbGkVk9p
         32whW5jY6gSFYuwnDJlThe8Qoed3SorkS/qkRwFHqCWHviGWMOu9KadcPCjyM0xl4bHp
         AvNMEYLCZOeKxveojCZSbkSq423Z5HWQukyQ7hBTFChg10ZMj8vRv/Eo+jHsBX0bpnuD
         0+AouVHpO292a+H34SKOPEox27JGMJZmlmqrEr/gdA0pSxMyTK9TCCUYrWWiZ3cyEMOR
         IY71X+P+IHTBSyItr0JyKDuiDPjxEuvoogJ5m4+gPHXsWl/ws85BNvHQ0zn7tXOeufB4
         AM8g==
X-Forwarded-Encrypted: i=1; AJvYcCX4wiImBkLhXNw6rxfp4UMLp9R3hpBXVBS7oBQ/gNifraCpu37AnGh4fyQELSej85FlpNW4O73qN9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0olU6QhUwwDiVNwrpHNQ687WCGxeNJu9d+7MMDW5MvkPjyPU/
	CWhWKcDUVE1U5TzD8sScEwxyHip54F7MwAjdlfeVYMMO385doa95Xu/2UwAMGVvNbGM=
X-Gm-Gg: ASbGncuAjqjZuME8SPyuQSsuYxmJZZStJRtV5ZAilRCD4EEQyE4LuenJwrj+A5Oykv3
	+IIIqC902M9NXdR73gDW/cTO30nFHvAdSnkEL0GkGvZfGfN7waLxEgYu2Z5wbf66kbx7WzSvUqs
	ZPPMiwTV9cFiv3PZoZWU9BEiMtoijQbbEUlPPEEL0bnEPkOSFOHZlt3r/GAMw2vafe9WrCjeayn
	r/E1x3l1F6LmXKDqu5fIoUiQlkEJrhg+es24HyrqItcbVKLFIbvKQFfqxiQ6b8c6zW+22Wg/kV3
	RHIasDviyrXw2J8rIwBHguwFOHXB7KfT7I4t4U6752mJ+cKZHV1tLNoLJGEmwPPnP+wr23BbbPg
	k2NYEfCTrpBdEAkQxazKUFrVmXsy9IFeUkofZWlgJgWnlWBoKBAq2su38vCUxViQ8Elullqoy+t
	EGRCZCOiJHPKfkoxOatwgzjU9vPQ==
X-Google-Smtp-Source: AGHT+IFFgA+tqvSvFVni6cS80/SuvU771uyh8uuWXEuBMXLiNeRlLuKT+VJpv5tOEAyKVAZjy3/I1A==
X-Received: by 2002:a05:6830:83ad:b0:78f:d54f:321d with SMTP id 46e09a7af769-7c0df720d1emr16302134a34.1.1760544959917;
        Wed, 15 Oct 2025 09:15:59 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:c482:1912:c2de:367e? ([2600:8803:e7e4:500:c482:1912:c2de:367e])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c0f904f161sm5419419a34.6.2025.10.15.09.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 09:15:59 -0700 (PDT)
Message-ID: <d9455d90-31ca-4be7-b17c-2b339e92f8a0@baylibre.com>
Date: Wed, 15 Oct 2025 11:15:57 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] spi: add multi_bus_mode field to struct spi_transfer
To: Mark Brown <broonie@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251014-spi-add-multi-bus-support-v1-0-2098c12d6f5f@baylibre.com>
 <20251014-spi-add-multi-bus-support-v1-3-2098c12d6f5f@baylibre.com>
 <9269eadc1ea593e5bc8f5cad8061b48220f4d2b2.camel@gmail.com>
 <409ad505-8846-443e-8d71-baca3c9aef21@sirena.org.uk>
 <12db0930458ceb596010655736b0a67a0ad0ae53.camel@gmail.com>
 <8c7bf62a-c5dc-4e4d-8059-8abea15ba94e@sirena.org.uk>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <8c7bf62a-c5dc-4e4d-8059-8abea15ba94e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/15/25 10:18 AM, Mark Brown wrote:
> On Wed, Oct 15, 2025 at 03:43:09PM +0100, Nuno Sá wrote:
>> On Wed, 2025-10-15 at 13:01 +0100, Mark Brown wrote:
>>> On Wed, Oct 15, 2025 at 11:16:01AM +0100, Nuno Sá wrote:
>>>> On Tue, 2025-10-14 at 17:02 -0500, David Lechner wrote:
> 
>>>>>         controller    < data bits <     peripheral
>>>>>         ----------   ----------------   ----------
>>>>>             SDI 0    0-0-0-1-0-0-0-1    SDO 0
>>>>>             SDI 1    1-0-0-0-1-0-0-0    SDO 1
> 
>>>> Out of curiosity, how does this work for devices like AD4030 where the same
>>>> word

The AD4030 is just one channel, so doesn't do interleaving. But you probably
meant AD4630 when it is wired up with only 1 SDO line. That line has to be shared
by both of the simultaneous converters so it alternates between sending one bit
from each word. This patch series doesn't address that case. But this series will
work for the AD4630 when it has 2 SDO lines wired up.

>>>> is kind of interleaved between SDO lines? I guess it works the same (in
>>>> terms of
>>>> SW) and is up to some IP core (typically in the FPGA) to "re-assemble" the
>>>> word?

Right, to be able to AD4630 with SPI offloading and only a single SDO line, there
would need to be an extra block in the offloading pipeline to deinterleave the bits.

> 
>>> So combined with the existing parallel SPI support?
> 
>> Not sure if this is meant for me :). parallel SPI is for parallel memories and
>> the spi_device multi cs support stuff right? I tried to track it down but it's
>> not clear if there are any users already upstream (qspi zynqmp and the nor
>> flashes). It looks like it's not in yet but not sure.
> 
> There's multi-CS stuff but what I was thinking about was the stuff for
> parallel memories, I was trying to clarify what cases you were talking
> about with "interleaved between SDO lines".

The interleaving Nuno mentioned is where one word each from the two buses
are interleaved one bit at at time and sent over a single bus, so it is
different from what this series is dealing with (multiple buses).

> 
>> Anyways, IIUC, it seems we could indeed see the device I mentioned as a parallel
>> kind of thing as we have one bit per lane per sclk. However, the multi_cs
>> concept does not apply (so I think it would be misleading to try and hack it
>> around with tweaking cs_index_mask and related APIs).
> 
> OK, so either just the parallel SPI or possibly that composed with this
> (fun!).




