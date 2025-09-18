Return-Path: <linux-spi+bounces-10150-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B55B86B74
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 21:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905D21C80EEA
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 19:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F552D9ED5;
	Thu, 18 Sep 2025 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UpPMRvqf"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4EE2D8383
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 19:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224347; cv=none; b=uF7OSbuJAmp1IFCPFpkBGydl1I7PkusgILT0X98ng8+ccrgr2h5Sln3X13swH+74fyeoYqa3+uNx12iQJ6Jy8Ngsx8waXANxuj0IRAMwsOiChnYgOw6IbIE/tXirQLAXD6jt2gujBUtdqrvwEUszpqLmpaqilJb78tNSex4t4sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224347; c=relaxed/simple;
	bh=VQ3t8/qxZa8M7ApZdBgI92YVOKX5tQcpsXI5KcrvT5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJQfvv6WzaGEOjgI0QqAy3wH5JgOPP5XOZ7jhOjpju/K/ZFuNyh9ox5hczGoZDqyS91VrxG804K3BQgrqaEn7eC1b54sQot3qYPsT1ZKxYSUCjxh+XfsVzUjS0xeiWQ4PHepJ5mAz48yMB0hrKYR5HhoBQPRvipgSBnk6MoafLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UpPMRvqf; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-62347d880feso844017eaf.3
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 12:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758224343; x=1758829143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lC1D1RXpqGWlfeokss9Ec91Msfh5uPWlxYgo1Th1KKE=;
        b=UpPMRvqfOgPqzydGEl7JaO4hSSi6dZcUjUkHSSoIz0DfqyvkvF9j/JsdUOSOYTuWhl
         o4jfmM7W5OJJ6zHMOS966ArVDhX66r3qIhCNyNAj/V5S/+eRnEUl4k/slQRRKch3DgS9
         1YXJQznDKqO0M3OQmVewpS7qGTYoAp4N50yo7l1yNvEz5eFrGGs5OHZCc9Lo+O1wNXLq
         SiE03ZfxmRahrzrVmBUYgrc1bMe2B6N/vEv1O/lZqi11l3GtvwdeXe8HMks8gQtDDZ5X
         YBAXo4JzP/OQgVSRtlPYASsrot/bGx966NlHvOMADKz4IdAl0D46ACEB4aAzub+njKCm
         2dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758224343; x=1758829143;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lC1D1RXpqGWlfeokss9Ec91Msfh5uPWlxYgo1Th1KKE=;
        b=QHb4YFKYJLl/hvHwwioieVYQt9FVAJ7+4L1Wd8ac20YdCbwawys1VEAZZ+wRK9gn7z
         or3RiclenVmL94ejQDgKgQElVRHbHZlpSf5XDp76fCiinYD+89QA70To3+obd+OlkEB/
         9qc+sajqlVL7id3Eb3PvmnSYqM+gGocYT5v1t+YpdGBWCa6vcEvIY3Xvy0uDXokznbKS
         Do1+lIz3EkM+PDS/Ky3TihCkPhhmLut843SHyG6j+HmjJL/acnSZz2iSM6/wSX3J+VoO
         D/LPWJiHIbKyn28pF30aaw7esl00GcMjltsjbmhA833MoyNkVlFg4NecAyQyIx/ojOyi
         SPVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmDePRZvXX/ZSy3gIC/S4uK9K2D9hCmfANMJ9V1DgTBSNquiuRWweGt3jlCsiyHToyHhNlzvmlg6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6MUjPC/jDs5nPghWdiCQQA2yLEJOhjt1BO2lwVMjHMiTJjscb
	b+fOhPuzx2yaYa1SWp873rf+qqmo3BaH++47ewek51snIg9opqXFOrbaO6gaUV0OmLU=
X-Gm-Gg: ASbGncsDA5r+WEMBVffGGHuKEWY9s/TfHa4iOJH2L99WOnZaBKGAQt2glruP5G6I6CU
	d+rNIO2lqW4maUWfRjcRsiQWSjC43IUMfcLQ4tHrRdFM4LBRZOaJJOuKbEWXte3BVXv6kzbGdFI
	mg3msYa4qHJAE6AHLv0B6LIRQCt+DY3c7JVNQ+afl67N4O7s3NRCt2RIpbl52W1wCVIogapN7ea
	JX4R0yFj2jOW04fFp04JvbwkdwitekvkCSHh5GiLCcvLSJeI8/A33rrGZDZD8iCaF2xB93IM2kq
	6JjXTkKEOCfa/3X4ZtSpMpxdlULUs5ijAz63nKXorCK7+K/1WWhmKbXIgtDkeWlWAPsHds79aCU
	04AN1CkkPhGaxUMqgAwko521SYmbB10ivn/qxkCee9hz65TRm7zjvjijh1dirYTfAPSVOCAJYtr
	yb6nWoU8cbHsl1RaomQw==
X-Google-Smtp-Source: AGHT+IGwPYMqQBvoGrbWLKmtCrh7hU1R/7J5LL0cXcvqHKYJ/id7TQ+ISZN+tixS6oxGOqJOrN22sQ==
X-Received: by 2002:a05:6808:198f:b0:438:bdb0:89b7 with SMTP id 5614622812f47-43d6c2c68eemr244526b6e.49.1758224343041;
        Thu, 18 Sep 2025 12:39:03 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43d5c881af7sm1142955b6e.29.2025.09.18.12.39.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 12:39:02 -0700 (PDT)
Message-ID: <f7d7f400-cc43-41d9-bc97-39d308363f14@baylibre.com>
Date: Thu, 18 Sep 2025 14:39:01 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] dt-bindings: iio: adc: adi,ad4030: Reference
 spi-peripheral-props
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
 eblanc@baylibre.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1758214628.git.marcelo.schmitt@analog.com>
 <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <5c1c448e3e731fc013e1e3b3fdcbc31f806d41fe.1758214628.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/18/25 12:38 PM, Marcelo Schmitt wrote:
> AD4030 and similar devices all connect to the system as SPI peripherals.
> Reference spi-peripheral-props so common SPI peripheral can be used from
> ad4030 dt-binding.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> index 54e7349317b7..a8fee4062d0e 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
> @@ -20,6 +20,8 @@ description: |
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-24_ad4632-24.pdf
>    * https://www.analog.com/media/en/technical-documentation/data-sheets/ad4630-16-4632-16.pdf
>  
> +$ref: /schemas/spi/spi-peripheral-props.yaml#

I think this is already referenced for all child nodes of a SPI
controller because of pattern matching of:

patternProperties:
  "^.*@[0-9a-f]+$":
    type: object
    $ref: spi-peripheral-props.yaml

in Documentation/devicetree/bindings/spi/spi-controller.yaml

So perhaps not strictly necessary?

Would be curious to know if there is some difference.

> +
>  properties:
>    compatible:
>      enum:


