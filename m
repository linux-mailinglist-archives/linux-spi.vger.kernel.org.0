Return-Path: <linux-spi+bounces-9485-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1157B28346
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEE9A1888C24
	for <lists+linux-spi@lfdr.de>; Fri, 15 Aug 2025 15:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD923074A7;
	Fri, 15 Aug 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="royxHDIp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CD230749E
	for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 15:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272985; cv=none; b=L0i3ijx5MmKjCI/43clYn5F/wl/AKxbyKPUJfRVPwFizF/MFjKNnOaNx1U+/ZhGR+enqGE6qVnj2noG8ePd9jYpx+naiUjpEvj9LBVEEcmetueNonOlnYkcGnWLP4Z0lIMvwu2QnRsFX5+vfTAHOqmcD166cTtKYFoZZFlxCAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272985; c=relaxed/simple;
	bh=LDT1LlSRvClcQTESyvNZOcCDbQzHYlxIpeUOcGdwEq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fw1VhnPTp4V5LRct0q48m5s2PotlP+0CUzcJIOQ/1Yy+317idNe8EcYRwcX85zE1XLg51v56+W6pNGKPUgP39kqaLCTILKbQoRl0E/1/H69h5S3UGKpp9sb23zdagALqxGFB8rCSm/nImhH/PPkOniMsW0hWiVdMKpdBHOsmokw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=royxHDIp; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-74381df8cf1so583369a34.0
        for <linux-spi@vger.kernel.org>; Fri, 15 Aug 2025 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755272982; x=1755877782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYeMUsITLzLzX8aJHEpZBjK6mYQbUKQb8W2QJwQZHWg=;
        b=royxHDIp6fTpPf7/wF2Uis2NIQDsarsmTXle6OaQMmECNcLb0YOEcVASBVQ+i0V0zc
         fx8azFrjCN4BPJ1lWqFrnfqh2NcO4NEsTqF9w7d3pJbuTwXM/msNiSmwGLEy77D1moLs
         bDTEYhfNAgSHvJ9a6LZXFjYcEz2xdaWDJD7l8pyetL5vqh5m+rN8pzWOagnPJ60WnMuU
         fqvqk4FJF/1p/QFfMvW7BArhAaM/M4ff5vMppz4C9dNueUHbDwrGYLpnquJSbqDOaCOX
         zJS8U0mkK14N0OorqAZ1NKwV+dtrLPlTTUNdiNoIvVBxs1pWkw6ahiQhhjbmLv9eD0iM
         btyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755272982; x=1755877782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYeMUsITLzLzX8aJHEpZBjK6mYQbUKQb8W2QJwQZHWg=;
        b=xPLTJ56OLUA/2HK53o6Ke1/0r5Vn8R8wKcpMIEw0WJKuABUhn/MAf72KSvbgtuhF5w
         ALFQIFjivIDusRbeZoNlG5D8yrENGu/nT9ufnIb4zhX58OSsUX9SiKH1QM8DlBWlPaGT
         G+nRvLofOdRID4+3qv+T87Rk+I0GTpQdEyYuTsw2ZdKKKuzFg9lreXRDKU2Vz+RwRqqs
         5dq7b9dkbd4mSSmLe7wCV+G41gokQXtQub6BdVekmKfBCladpKsj6OcUGqKlzB5uUQCR
         DBpXUezrQi0R73WzaAtAxlsyBPFjXtrnKTO8qOgN3D5FoMw5Wdrbl4Jnc6mdOJQAa0KL
         6PcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV1tNUYhd14shIr69HrNhvoTz9PyRZT0zPCNJGsoWe2TvoMlFrMgNDiH1/IXZGerFhv4UZ1wfi4Wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+luw/8mEZIz0ARn1r7Qwt5v2eszEOoBY5z5HyefBmP1o7eGc3
	qtHZFxQOqdROx2fCMEjWVbu0wu6ZwagQbGXy+FGxaHRehdndlMlqK6M8MA2fOjWFjpU=
X-Gm-Gg: ASbGncvc9dSwfDUq7b6WAbHyPj6NXskdPHyPCDT4pQed/GGPweO/cYrqZAm67epCiMi
	18chMGNmUfOJF5jH2FiRWJupDoDS1Uq5vYWe4g3qhBL6GykAAkl2+yo9Kfs3DNvY/2DMOPoOKC4
	I9DzLiIXLdNYSDwfNhnzczINbJuIvzP4WC5Pd4PNQal2DQyjHlrI2FoX0PE3s4uaDSk8OEuBWhq
	4Q+7m47YbbeNtBAZjkbYSR+u//vGwKpJ7A4NMM1Kdheesk83nHkpxPRq9Muh8f+de0oaEYabFY5
	rxJyfwB/l3ArxfV+V67fdbyhU7nWKmBTd/p2k5t9F2U07SCKehOdEEAY1YWmgxpLQ6UkqNPVhRy
	f/PWyauaBK4OFQgrE6FZ4hd4ddCoD0/AS/A0vbuA27pt4QrpjR/VPfp2fctF6VLAflxtSEfThsN
	LG3Pti+nc=
X-Google-Smtp-Source: AGHT+IEoVnaL83a5r2gLAMPUw8k6gnxh57UaRSMs78wsysGd8hJtR5B/O1txsAfKqL986GFe82rtXQ==
X-Received: by 2002:a05:6830:4108:b0:742:f996:ef34 with SMTP id 46e09a7af769-743924f533bmr1526978a34.27.1755272981907;
        Fri, 15 Aug 2025 08:49:41 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c? ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203b5ffsm348082a34.25.2025.08.15.08.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 08:49:41 -0700 (PDT)
Message-ID: <ded7ba99-089b-47a7-95b9-ca6666dc3e29@baylibre.com>
Date: Fri, 15 Aug 2025 10:49:40 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] dt-bindings: spi: Add spi-buses property
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
 Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org
Cc: Jinjie Ruan <ruanjinjie@huawei.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
References: <20250616220054.3968946-1-sean.anderson@linux.dev>
 <20250616220054.3968946-2-sean.anderson@linux.dev>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250616220054.3968946-2-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/25 5:00 PM, Sean Anderson wrote:
> From: David Lechner <dlechner@baylibre.com>
> 
> Add a spi-buses property to the spi-peripheral-props binding to allow
> specifying the SPI bus or buses that a peripheral is connected to in
> cases where the SPI controller has more than one physical SPI bus.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
> 
> Changes in v2:
> - New
> 
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 8fc17e16efb2..cfdb55071a08 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -89,6 +89,16 @@ properties:
>      description:
>        Delay, in microseconds, after a write transfer.
>  
> +  spi-buses:
> +    description:
> +      Array of bus numbers that describes which SPI buses of the controller are
> +      connected to the peripheral. This only applies to peripherals connected
> +      to specialized SPI controllers that have multiple SPI buses on a single
> +      controller.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1

Finally have some hardware to test this series with using 2 or 4 buses.
I found that we also need an absolute max here to make the bindings checker
happy. 8 seems sensible since I haven't seen more than that on a peripheral.
We can always increase it if we find hardware that requires more buses.

	maxItems: 8



> +    default: [0]
> +
>    stacked-memories:
>      description: Several SPI memories can be wired in stacked mode.
>        This basically means that either a device features several chip


