Return-Path: <linux-spi+bounces-12281-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204BD0F242
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA0CC30198B3
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA0D3491E8;
	Sun, 11 Jan 2026 14:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="c77L/krc"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368054654
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142549; cv=none; b=AkDnF9DQx7O+vhRaupXJAtkqnx0ozm9WPybbBrEb5tJrWim0Z8p0lV0X19VR8hOvkPZw+Gy1ylHfF270hthcgUmWl4oI40zWVrKFcTBlPaxK+JA13WRTYfrSq/xHkcnPLeE0NItLBsX0LkYt5H58QX9urZdQchCcfNmmQwYae4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142549; c=relaxed/simple;
	bh=nwibogWEaRHQR0G0uXO7BApOaM+RxcF4pitpiLWDTZg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rhED17Pt3guCJ5Zx3o+/9n98KDksUtNPoKHmkWMEj2+3dVahQsMta2ton5MUc9oPcPQctl+K60fyY0bhfo+S9/tci90mE52Pye+RdQJy5BstbrXR9HEmmJ5Z/kpLIHqgE6W8Ki5x2rIBCUOrZ3OkEx6tQ2xJExFM/T+1arQaGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=c77L/krc; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b4b35c812so9118732a12.0
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142546; x=1768747346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MkabSAxRfLn0dHpHfPolIqVil9ZYQkOUo+uqCMKmtA0=;
        b=c77L/krcX+Mfr24+FUl4++gD6P5i5AGxy0m+b1eI91GhsDm0sayjulKachXmaIlYnj
         wCOILRVKwoNMqwNVxiWqRG/2EpusMOG+6mI5UGjqQhrvQX/0x8TiI6/sD/LxA6Hib49A
         w1bH1nFUZyZHE7gn2ZaU+W23FBJAHpOkkENkXq3dyjTbNfVtcnT0ibchItmEiZ1Np1qd
         rc0qk+dTF5Uvu980fQlLsCVoritMg6f6VP48BGlFIXsO11MCq0nYJAdrEc8pu+EFAWms
         a9jgZUFbr9W0Mz4E+TgG2PBR7kf7gSyNi/WRoJKvSsndQ8k0T0kWq1Tnsly+JbkLGMdO
         RD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142546; x=1768747346;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MkabSAxRfLn0dHpHfPolIqVil9ZYQkOUo+uqCMKmtA0=;
        b=nnEihhFFUa1E6h+DcwrR4D2TcE3IYu6UD6qK+ZzKmI8Aw98im49j0D4eZfoZwaHlT6
         wewZjDGe6s5BSGAI4GZfC805J64qSt3C8oQtj0ZKMP7kSBp25e9A2ir/cPL81109lvky
         cRVBB2EiLYfAeAqlEZejhuYX3jeiN4GigMxPLHyMDQfTbhViQCVmSnhHzTXndCLPzNa9
         ZWvcHE4qcdpHz6MaMaTUZu075zvhkoHS9G0WS2Ps0WtsEYXhvb+T97K1XCl+KbqRCzii
         ztmVGLvG3iFZvGfm4CUQj0EuqeFPzovqTMK392Fzp1lOGJhllx95oUPpR3h9pgp4TmlX
         2zhg==
X-Forwarded-Encrypted: i=1; AJvYcCXk+fexnUiAcTuP0tWXqGhdycvGI81x0NB3ZiCHckzcRQB1g8wV0rOyEzRmeus4qkgC3/GdnZ5zGa4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5yJPp3IBKXlGccRNreRe3PPaXQC/S/+oRBd0DvSTeKBpmhve
	97YW9YEXbNQsa4vN0T4UoasbraIAy+p89qmlXZp+7sIZyAHRX03JQ3yx8t096qS7So0=
X-Gm-Gg: AY/fxX7JjvUaJWRLRNQ1e1OavpkbE2NbhJZplkLu6R1bhWmBI2HxxDQ+bI0cxODsZ20
	EpPnxTPRi9QyMbN+jO0sII10swo0kUvlQ6KcBegknckj395ZvjT+DvwX/N594d95mXQxXGRvx0S
	MZbXU4AGFzKtWzS+3HJwghFJlFvi3NzjnF5Y3f/DBg/5IicPe7jWzxihKtKMC2LF2y6G1qD3JIa
	kW/n2hc71yyx972m4jmBLVCWAXL3bvzgzvhP7MeG81IS1SBvk9earDDjVmZFFkG7ND4iSXYNCb4
	5Kv8z0WNK7oBinrPQglZb9j+2lys69AaxSGALzmF0dsdQGxkpBg5xgPBJaEHfSlE44uNXxB39Yr
	nSepdbvevo7w0ttJ2DlB6OZ8901d4zxbQ25m3J7LJKcBFsIjq0cNba3MHF4xHeqcORcDnqhOFjy
	Nr5XInmQcEzN9n/bykQhsLV8VRTU8KuNq5sA==
X-Google-Smtp-Source: AGHT+IFonU/ClDvId9huEtx8OVZbpqDSrZa3cVBTJbulbnKxAZxCbWxaUM02TgbsxBJ1Mah6guhUAA==
X-Received: by 2002:a05:6402:1469:b0:641:8a92:9334 with SMTP id 4fb4d7f45d1cf-65097dceb25mr14589135a12.6.1768142545311;
        Sun, 11 Jan 2026 06:42:25 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be658b3sm14914417a12.18.2026.01.11.06.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:42:24 -0800 (PST)
Message-ID: <2cdac084-4924-4ca2-85d6-2e6d9bf284aa@tuxon.dev>
Date: Sun, 11 Jan 2026 16:42:18 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Subject: Re: [PATCH v4 12/15] arm64: dts: microchip: add LAN969x clock header
 file
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
Cc: luka.perkov@sartura.hr
References: <20251229184004.571837-1-robert.marko@sartura.hr>
 <20251229184004.571837-13-robert.marko@sartura.hr>
Content-Language: en-US
In-Reply-To: <20251229184004.571837-13-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> LAN969x uses hardware clock indexes, so document theses in a header to make
> them humanly readable.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
> Changes in v4:
> * Move clock indexes from dt-bindings to a DTS header
> 
> Changes in v2:
> * Rename file to microchip,lan9691.h
> 
>   arch/arm64/boot/dts/microchip/clk-lan9691.h | 24 +++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/microchip/clk-lan9691.h
> 
> diff --git a/arch/arm64/boot/dts/microchip/clk-lan9691.h b/arch/arm64/boot/dts/microchip/clk-lan9691.h
> new file mode 100644
> index 000000000000..f0006a603747
> --- /dev/null
> +++ b/arch/arm64/boot/dts/microchip/clk-lan9691.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */

Shouldn't this use the same license as the dtsi including it?

> +
> +#ifndef _DTS_CLK_LAN9691_H
> +#define _DTS_CLK_LAN9691_H
> +
> +#define GCK_ID_QSPI0		0
> +#define GCK_ID_QSPI2		1
> +#define GCK_ID_SDMMC0		2
> +#define GCK_ID_SDMMC1		3
> +#define GCK_ID_MCAN0		4
> +#define GCK_ID_MCAN1		5
> +#define GCK_ID_FLEXCOM0		6
> +#define GCK_ID_FLEXCOM1		7
> +#define GCK_ID_FLEXCOM2		8
> +#define GCK_ID_FLEXCOM3		9
> +#define GCK_ID_TIMER		10
> +#define GCK_ID_USB_REFCLK	11
> +
> +/* Gate clocks */
> +#define GCK_GATE_USB_DRD	12
> +#define GCK_GATE_MCRAMC		13
> +#define GCK_GATE_HMATRIX	14
> +
> +#endif


