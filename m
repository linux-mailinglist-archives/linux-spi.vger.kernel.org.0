Return-Path: <linux-spi+bounces-12279-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 119CBD0F094
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 758DD300D310
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD033FE30;
	Sun, 11 Jan 2026 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BkO3z2rF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3190650095B
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768140318; cv=none; b=fVjw/iRFtmBOhKTqEa3n1L40uwykNhnx/bp/lgc+NslglNWaOYnuSzBDoTUKlMT6zj/TcCwYg2oktI/uxjig/7fNSHEhHMf7vS8VGRDc8pZ8g8xpct3xPuEMzFoENWCe7F5rKZjSXfzlijSl/G/ZDHDnVFSGlLEFOkKiCkEyZeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768140318; c=relaxed/simple;
	bh=XJxqouRZEHyqMQtDF2nj2CC7ybgayxpBpI1cIt6Nuko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NHxiv3DAJZ21WjF5xmNZN7gjXQLquwa/0nyo+t8b04synda/xtY4yGSzthKJUhXoSFT8rfVP83ki55GEjOBoBvao5+dQMCbfGqy9NkmHBkyid1XSqDzLc6F7ntwrLA4B4O+6ZuKWVW7NLH1RwcMKA5BgKEnUSreLErcEnd9DWeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BkO3z2rF; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so7898719a12.2
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768140314; x=1768745114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NCh2RDJxN8hiZ1nJoik35Pfikr6nPePDpNs7w6splE=;
        b=BkO3z2rFR8gLFu9KMsttbGGdCIwLHM9rD4383KQBSCw+CJ+lfOYeONmprcyoyZWmOU
         foix3ABm/QKUZPkXZQ02d3llbNlmYK1b5tc9qT1gTTv0gyY7qUa7qIefWRknEuSCSm4i
         dtOCIeiL/TlBE+Gfmpcvb0X5KY6ddxXob6/LF0uZxmTxV04l6TPHYYaxtu4hwIIp4UHa
         fmtFug7tDLjpgqcg6EFliBlyZwsk1p+jeIXItmgOOmkVnlOdQjQqKQsoa16x02wvvS3Q
         FmbIH2X9BIVh+p2zvY1E1z0YKmlJRqn0yUnTW1OtYT0tvX/SQ8j+q1FxVxl3md2KgMyv
         D8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768140314; x=1768745114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NCh2RDJxN8hiZ1nJoik35Pfikr6nPePDpNs7w6splE=;
        b=oT//EV5h5KLTw55cjMLvzW2hGW1MBywKWcUKhen6gxyH3WUotgn3w722fLMoYqPZ45
         Z1ZzVYybjIhyg1iZCz/sYKR0t1xFVRoaeOPwtaf5xDI6+5NPJfwNV1Q7F9dP+HX4lO66
         LL4y1a7qk+rGe3V4smjFiwBdnoW0upojvhc0lvCTlQ+7bE6MG0LnnMBSGZnefff0tHqX
         wAD1hK3CTGtVCgFM1+F5YQk57MbBw03b4XPmFDPOTjUyeatqIGrPac3dX4+hbppymwil
         WLxNqeL4YXlfUhSEQiKs03PGI0IJsuJI1KkwmjsrlHO2084z/RMsoR1NS9PfjAZBvPMY
         Pkqw==
X-Forwarded-Encrypted: i=1; AJvYcCX9qe0mLHEOvdKGtDLFf+Rnkq+Dz6gw49pxXqfWaGN7GVz61+DV4C6r4kzvlu3nteHB++bf7fOGUe8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaP+4NMpYhgsu39hsdTzdOMJUiOJcitH+3uC1G9OanK5Qa2rTf
	hKmI3WckgkENBqlcRmH4xH3nyG7O8kSH3AQpcnAFy2Eil2X5z+j2pz6palCnqIwD/70=
X-Gm-Gg: AY/fxX6bw5sINLW3M/2WtlB0LMy6jq+XU7K2n4HtYnZC9EA5y+YIhfBFCnT4NBKG27U
	oYrlAKhhN+JfVAIe9uWxaBiM2LWijoGwABlBr9gINFaS1RezmLRYdezBMSegLae8sd6lxfNL0hu
	NiLoYlyESwgfnWpwKQLFSnvgQpvRzb3wPrPnF0rmO3OqdJ4XMcccUnKhYWC8nro6PNqjE4FPIWM
	D66qQja86deslTnWgQ+RigFyQTLIDpgHc4KtNbuA1DZ8JB54TVlmkxCiG5s6mj6cO2O2zK2hirn
	IW4eihq8NfcSLuEmfE6LRz3FaQqCmSUjkviElrlVefu8RlspnKoETCDJZZbs5okyOfcujEy4WTf
	zHLECbcYjsIItIHsabkYU8D/BbtlKyvWdvxmcKRGotEvoSkmsc0nrUq9Vx0Je0zpnSaKMRqjMJI
	Zlvlk9PPMLqEIDCEFD5n6mLZO/70w2Dvgl/Q==
X-Google-Smtp-Source: AGHT+IHX4kBq5in8WgxEwJr9XbVFlnt6AItwyKhU9py/NMR0woB2X72z7DmCdf3HQxhQaT3H7Zh1Jg==
X-Received: by 2002:a17:906:ef0b:b0:b84:365f:10b9 with SMTP id a640c23a62f3a-b844522a6cfmr1333268466b.29.1768140313496;
        Sun, 11 Jan 2026 06:05:13 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8709d11b90sm221829666b.12.2026.01.11.06.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:05:13 -0800 (PST)
Message-ID: <1658b580-cf63-4f57-be1f-0691cc4934c5@tuxon.dev>
Date: Sun, 11 Jan 2026 16:05:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] dt-bindings: rng: atmel,at91-trng: add
 microchip,lan9691-trng
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, vkoul@kernel.org, andi.shyti@kernel.org,
 lee@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linusw@kernel.org, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 olivia@selenic.com, radu_nicolae.pirea@upb.ro, richard.genoud@bootlin.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.org,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr, Conor Dooley <conor.dooley@microchip.com>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-7-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-7-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN9696X TRNG compatible.

s/LAN9696X/LAN969X ?

> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

> ---
> Changes in v3:
> * Pick Acked-by from Conor
> 
>   Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> index f78614100ea8..3628251b8c51 100644
> --- a/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> +++ b/Documentation/devicetree/bindings/rng/atmel,at91-trng.yaml
> @@ -19,6 +19,7 @@ properties:
>             - microchip,sam9x60-trng
>         - items:
>             - enum:
> +              - microchip,lan9691-trng
>                 - microchip,sama7g5-trng
>             - const: atmel,at91sam9g45-trng
>         - items:


