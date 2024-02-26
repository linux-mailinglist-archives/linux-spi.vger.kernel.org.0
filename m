Return-Path: <linux-spi+bounces-1500-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B1A866F02
	for <lists+linux-spi@lfdr.de>; Mon, 26 Feb 2024 10:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A651F273B6
	for <lists+linux-spi@lfdr.de>; Mon, 26 Feb 2024 09:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00487D410;
	Mon, 26 Feb 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OvT54s0K"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D11779FD
	for <linux-spi@vger.kernel.org>; Mon, 26 Feb 2024 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938599; cv=none; b=OnUDv/6NTplCnuqmZmRr3JRHG+/k8F6PRJBCFsp/o6s5LLu8RBGHRPnMIgnxJUavckwQkZKCUxxrV4R9D0IMF3r5FzaubykwLwlTj3Sh7H7UK5gAtlK6cjAZhaXAiY/fgPRDeRlUNVE9qnjMb3Fj3w3YaG4WKWhWSVvlZQBFHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938599; c=relaxed/simple;
	bh=ct1TOHYoPxonxO0bFO4cLk03fQ3qOhW0WvJYTBga/R4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YRgMxziRp2XwQ+JGzPZlfPY8Hyl+1VGygiasOyaCS/IGucCWccDMgiPDpyjT/0ieplXJflRRuAqAMKKP3Lf84a62L6vN8mdQ23cP9rHvKUmdrUKt52PNwyerc0RNWISoAnelJopQWzZJZZ2jDbNoi+wHPOjci27Twy34ZJYimNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OvT54s0K; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so4934282a12.2
        for <linux-spi@vger.kernel.org>; Mon, 26 Feb 2024 01:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708938596; x=1709543396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mK5SXJggE4aHASGE/tQgDSdJa0ijnvd6QarwqJf6+G8=;
        b=OvT54s0K+a28zSOVcm2TFOllS7IpPXF7gkT1ThaQyPKWlsSHpC1Xn14e3RBclPaVHr
         dIKBng0hTsnExiBafqY0fRuFwgwKy3f0WyODFU69n35xqxuL0ZXD+EfWtbiKNW9BjLG0
         /hPAofo2XZIGT45Gffy3Yenf7h6QOBMUIGkAUooQ2XfMAqN5xrrZTF4NDGsk51JLHRH5
         xvleU6d4y808NDchGeXVoBfTJW/pYTi+Qx1I8fhRZA4I/QzsNHhQS4zCzgPQiCxtcSG2
         C5HFX2YkynD6t8tYntmF7DP3QNs/cpfMxgpe945po0240IClJW6KuCMUfhm6TiMUmtk7
         +fYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938596; x=1709543396;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mK5SXJggE4aHASGE/tQgDSdJa0ijnvd6QarwqJf6+G8=;
        b=aTDPv9UOYMfpHJJj0A72nDGzVxXceWLifyuGIA1B2+5aZNkKBJDRQVjq0K8qs/EgHA
         7J0tgSlDDWtgOlkD49JWI+Z40F812oNL4IzIM/HXak2z3gF56sCK9uYie9E83/5HYb+r
         D6+EV7TLNilzJKz1R2nVtyV+9sCbOHKj9cw3bPptwf2+xGnMdYxHnHep9OOy9yWVAikW
         TVjt4YVBLexAolHpjimPDjq9jO7iJISLVQ/6DCnvSL8Dr5UT3p+B+zC7El22jdu9u/qX
         ix8R1/8t/StHF0SQ05iGcascg0pA9yel6L/8VAhH7sVYE0W27nbeUIlbQFDEXEt1kZrH
         kHNg==
X-Forwarded-Encrypted: i=1; AJvYcCX5iEsfwjL2JqVPWTtNfBp/tfq2QsFWIvg3s23Ph+dyspLK1k+SLk+aYMh5kSVVsW8YCerFAU4ywngI8HIiauCAtFFdcCD7GzSV
X-Gm-Message-State: AOJu0YwjJPfdBEj/jiI6nacx7cqF+wAt3i7/HLGJSQVTRkQ3DkF076sZ
	o3QeAfIyGfm5wPekpmx5IdYoe4XoYn2Kcn0h4ailIujmQSx2VTJdikrLfyklvyM=
X-Google-Smtp-Source: AGHT+IF6aQvjrRrePfU6POKTruS2ZK3YMDzr8yesoaXYtsQn1VeiXj93NQ+He8tS+fq6qiypfUn8FA==
X-Received: by 2002:aa7:cd42:0:b0:566:de7:ac4a with SMTP id v2-20020aa7cd42000000b005660de7ac4amr545717edw.6.1708938596393;
        Mon, 26 Feb 2024 01:09:56 -0800 (PST)
Received: from [192.168.2.173] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id r26-20020aa7cb9a000000b00565b8f955b8sm1790524edt.57.2024.02.26.01.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 01:09:56 -0800 (PST)
Message-ID: <19da0e57-379b-4db3-ba8e-db7efe336e15@linaro.org>
Date: Mon, 26 Feb 2024 11:09:55 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/39] spi: dt-bindings: atmel,at91rm9200-spi: remove
 9x60 compatible from list
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 broonie@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172638.672366-1-varshini.rajendran@microchip.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240223172638.672366-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.02.2024 19:26, Varshini Rajendran wrote:
> Remove microchip,sam9x60-spi compatible from the list as the driver used
> has the compatible atmel,at91rm9200-spi and sam9x60 devices also use the
> same compatible as fallback. So removing the microchip,sam9x60-spi
> compatible from the list since it is not needed.
> 

I find this wrong. I though we shall add compatibles for each SoC. Are
the registers and fields the same for the SPI IPs in these 2 SoCs? Even
if they are the same, are you sure the IPs are integrated in the same way?

> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v4:
> - Elaborated the explanation in the commit message to justify the patch
> ---
>  Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> index 58367587bfbc..32e7c14033c2 100644
> --- a/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> +++ b/Documentation/devicetree/bindings/spi/atmel,at91rm9200-spi.yaml
> @@ -22,7 +22,6 @@ properties:
>            - const: atmel,at91rm9200-spi
>        - items:
>            - const: microchip,sam9x7-spi
> -          - const: microchip,sam9x60-spi
>            - const: atmel,at91rm9200-spi
>  
>    reg:

