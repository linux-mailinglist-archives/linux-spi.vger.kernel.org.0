Return-Path: <linux-spi+bounces-5952-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CDE9E8645
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 17:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59F91884474
	for <lists+linux-spi@lfdr.de>; Sun,  8 Dec 2024 16:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D4B15A85A;
	Sun,  8 Dec 2024 16:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FlAE7rAS"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678913BAD5
	for <linux-spi@vger.kernel.org>; Sun,  8 Dec 2024 16:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733675008; cv=none; b=pQJxtEcB4I1GTcjeYhlc7tmIKKgYI+lLhHu45StYeUfmir2KCg9WrR8KpSsxbY9rRnz9BOAfD2+S2RTjzt0PqKjcAVlAgpExdN5mtihsI4IkGfmMIZq2k2ph2hs3ejPLTWqiXWQCJ4hoszSt5y66phLtCTkI4uu/xXJw5O4sJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733675008; c=relaxed/simple;
	bh=JsGq0YhaA/fjrB5i30iNldjy4eoZqlyPCHjVboORafM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQA1cH8fLeLr8vDzQ8eENS/5dkyIVZ/B0jIPQJ7wbjjhcC3d6hUaB44/XsWln0JepYofnQy+kXDbpfIqg0Y6fU8NTd22AHr/U3Dg7eiN9cVV+sOYghbV4jHplfQcmWb4oUxZXcHH6f0wNXNehJnCTAq3y/hQLwHp+E4hV5PBsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FlAE7rAS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so4430437a12.2
        for <linux-spi@vger.kernel.org>; Sun, 08 Dec 2024 08:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733675003; x=1734279803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Ja4iyQmAzISPsWmv2Yy+J9mTuONiwkR0YrQmpPL14U=;
        b=FlAE7rASzQNuKr9euzhs9NzZvBARBYt/IpnehyvTb2Wy5sL4zB0eTp5N9X6agMmUqb
         0h9+3AhChPJObIzyWK37nEiK2m0Po2I4aYYNFOgnbEHYmYI8BEbJtcvBac8LozdrUn1+
         63l1VJlqJNHYyqXjdbBabCVY4u8eA6xCSZqOf1CNwZlD6Pp8eEOsrUqsC3wl31ZFunwz
         ouBnXinGMtGMmuG9ZII48//6wXYCvtKggsg29rC1oAThHYHv1LLdDlXfklJT/BOFvKh6
         BPu9vvaK5wgHWMwrNS1p5ci1Ii5+DYSmjx4Q+Q5UvO2t/CG46NWI+2xKkEoPgZuqit7i
         tbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733675003; x=1734279803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Ja4iyQmAzISPsWmv2Yy+J9mTuONiwkR0YrQmpPL14U=;
        b=sIYAP1gcbSOD+ncBfjmEehJZZs3wTREvptwLkyPmOzjfdCOJywXfkDvexG0et47gLh
         WXeNvg8tW+k56rU1WTWeuyGZnw/emjOCV0lL7YNwZM4a0rOfpGhN+qNeqq9NQebp4Ife
         Sp1379eUCavqh8s3UO/BJPZ7eVFt1hjHO1j4QTu3jrgP11fAaPrCgLO394QZtOpbjo++
         AjxF6d0FsEaLMoOgeFKzmJfjng89bDMz7wSG8YpPuyZHduPtDj7NcNrCr14BHCPDyeCF
         g7TaLQFO1iwexLm27cQOvYkwgW3J3RLp8Qyr9gZyHKfuRlkzdL8i+V9kNioVBcbpLSjo
         R4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7rCtlqeFOvsBXq5RabXcYdhLXE11goafzMuPYyvh12pJkZfY6cFzYyicx1nQXHiVSNcW2XnoX6js=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw++yRTqc9nP6YkD5OyjB7GuUBBW1pTJJXpr8lvmNudoXVDKMFe
	lmVVTNRsKef9rRC/RvAt0IVR+ATdmWEsVyqVr+oG5JsEbwSxr+bJHgfW+aF5ZJg=
X-Gm-Gg: ASbGncubBrIE14UpNJ7o7sz6mPXO3OUSYFF3fcxMCNBMmfB02WfoyZl0zWRuOczCvGf
	IIa8bjOTODUjWNTvgHO+68cEmecpk1TJhx7E4pWztPLaJ8ba2XUmK/uKJODEBrO39/Ekery/DrP
	SrXTF+JApcyjdsgB/jMY5n6kpDNQriI57d8+Q/Xj0VY4/CRsOzCeqWOpMFMmE4FjJQPsmnTO73F
	0UBV76JfG0Il9lRG6FBwO1EL1ds0fOK8Ekrk39pMiBpzK7P//YgdryxmK252eI=
X-Google-Smtp-Source: AGHT+IH86UBvGGnyAV0eg40dVkna/XfNJd8hDIG21j22U90IZW6G8d+OfAAcOP2EKLLK8RxyDrgbuA==
X-Received: by 2002:a50:8e1d:0:b0:5d3:d7ae:a893 with SMTP id 4fb4d7f45d1cf-5d3d7aea934mr5930138a12.25.1733675003295;
        Sun, 08 Dec 2024 08:23:23 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a49e48sm4883698a12.30.2024.12.08.08.23.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Dec 2024 08:23:22 -0800 (PST)
Message-ID: <40084072-8581-49b1-b0b8-e3c63dd39f3a@tuxon.dev>
Date: Sun, 8 Dec 2024 18:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/13] dt-bindings: ARM: at91: Document Microchip
 SAMA7D65 Curiosity
Content-Language: en-US
To: Ryan.Wanner@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, mturquette@baylibre.com, sboyd@kernel.org,
 arnd@arndb.de
Cc: dharma.b@microchip.com, mihai.sain@microchip.com,
 romain.sioen@microchip.com, varshini.rajendran@microchip.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <cover.1733505542.git.Ryan.Wanner@microchip.com>
 <d5a22763a2081daa0d2155e2c05b7dc0eb468610.1733505542.git.Ryan.Wanner@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <d5a22763a2081daa0d2155e2c05b7dc0eb468610.1733505542.git.Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 06.12.2024 21:59, Ryan.Wanner@microchip.com wrote:
> From: Romain Sioen <romain.sioen@microchip.com>
> 
> Document device tree binding of the Microchip SAMA7D65 Curiosity board.
> 
> Signed-off-by: Romain Sioen <romain.sioen@microchip.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index 7160ec80ac1b..0ec29366e6c2 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -180,6 +180,13 @@ properties:
>            - const: atmel,sama5d4
>            - const: atmel,sama5
>  
> +      - description: Microchip SAMA7D65 Curiosity Board
> +        items:
> +          - const: microchip,sama7d65-curiosity
> +          - const: microchip,sama7d65
> +          - const: microchip,sama7d6
> +          - const: microchip,sama7
> +
>        - items:
>            - const: microchip,sama7g5ek # SAMA7G5 Evaluation Kit
>            - const: microchip,sama7g5

