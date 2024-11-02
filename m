Return-Path: <linux-spi+bounces-5597-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F539B9C5A
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 03:37:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC63328265A
	for <lists+linux-spi@lfdr.de>; Sat,  2 Nov 2024 02:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B1C130AC8;
	Sat,  2 Nov 2024 02:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMT2VHK5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF9D9479;
	Sat,  2 Nov 2024 02:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730515021; cv=none; b=dzKHKLHODAc4d7VLDRSkg9NypjUnjTMHcpKPX0g+pmaafMeNu2N4RltUlnk//afpzAMk8/1BY2i19sbP8D95wieShGb2+Jk6VBUIcCaNIy8fER64/wQ1eIKj1UP1NwlBv/bkSwGJ1oWVwExpMPrmMnP+2LF9Vaxfla2RP3BOcAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730515021; c=relaxed/simple;
	bh=HAm2uFR/BmaPeA/QPdAV5p1sBdlEXjYIAwxP1zNZREE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+bwJWzvv6cnTjCKrz940pYiFiDnCuXTw6jQGYaIXylLEehg1xbWTHZ59VAEYZhj7DoaQ96sBFzlcuREHJoxpgBWySkVXXbPrbAIDtsnli+/7/zLzdr7F3JfY6OBgZ6JT1NvFjBBl18IdinF5EvRLAasjA1BABN3ztl91qrBtF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMT2VHK5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so2255775b3a.3;
        Fri, 01 Nov 2024 19:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730515020; x=1731119820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=52ooFznqeRMYHCyQ/j8hVCDyBghXj5ug7pBFSOFL7Wc=;
        b=eMT2VHK52yGGtEpzpMoH/bz4UIbB7JAgCDSUS2zPhpjumyX94CFbASW9WzHLLTbxV2
         H4uDv8nv26DCq2Vbg+lV3/6j92VFGdlkQJv710bWhgQjrSQnrOddFR2EAZUSGg///3cH
         FTgz/3fIy8pL9XEGPd+wldU8zaeMKPTUD6WpLZcmMbXfEZrsUnv8ZHu7qLhpsjuXUFG8
         mjQ6ZQ/Kxha366KhCFdhDg6kDxxw5CMZ0xEdLfEYq8pFYaBD0ueMJCYT0RuhExEyBIAP
         OgWeInZC/MNK6hj1ICf15qaMZ8AnGaQXoU7V6Mr6dKGnvLJ/gkV5Lkub2KiGBLvUqnb/
         WtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730515020; x=1731119820;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=52ooFznqeRMYHCyQ/j8hVCDyBghXj5ug7pBFSOFL7Wc=;
        b=qVUF8i289iIidR6x+eYXIVMmFiMV7v+ZXnZVQqLTtR1mgRNIWbqdWfC/IBQdoobIPm
         5KIaQ4dlfNueXLTHzcqPrfvHo1hECAj3g1E8Ad1mn+/I9a52JpGN4v++98PRzTwKXbyg
         1II4U2K/jXbKm/RmZBFsJxfMYbaxeQQtDc6QPqwHbjwuJOIMCBRKQ9GpnQS6NyHtQ2ar
         6JGsyZ9XiugnMBqKeadMYjgQiHMAn5egoc1Sw4dtzA8opeU9uruKCbq+UB5gRMr+IuSX
         llkAvpotSIDV3J5jhrYe0u3FBCCt3Lzaaa+vdpKYCTj/OQVohfoVtqo2FQymO7vGarLi
         R5Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUipQVO4Ko2wS99nOrne/nHrVpQkxYsWuFLNFHSHjTEzprsPkBtnP91995Glh/dAf8tVe74jvAu3J39ZgCk@vger.kernel.org, AJvYcCUt3960TWka4jOc47Ps6Y1iajBcMCGmtvIjj/FIAzc2jpmE33S77N2bmsw8eK5iUrsig7nCU7kpC2mA@vger.kernel.org, AJvYcCWKqP8k27kVdlGgBdI3Xe80MG9A28sRegjwgkGXmWujKO/2orwf2jDLlgnTzeVEE54i1D1PhVK2zAq7@vger.kernel.org
X-Gm-Message-State: AOJu0YyShzvC05PrgvqMPpjZpIkL2bhp/hCcbWLtTfv7bRyYbyMXeCxd
	aAWtTz6GAWI7IF8qqpQaoTDgMeW6bv/24pNzqp0MCiMsiipK9cTJ
X-Google-Smtp-Source: AGHT+IGQ9zfRcHvemJpUmA2q1CaZU/zY095T+aeF4SHQo9LbXPUf1m6TDA8Q4+PugPH5HaynDPT5mA==
X-Received: by 2002:a05:6a21:710a:b0:1d9:a1c:7086 with SMTP id adf61e73a8af0-1db91ec3ed9mr13201042637.44.1730515019885;
        Fri, 01 Nov 2024 19:36:59 -0700 (PDT)
Received: from [192.168.0.122] ([59.188.211.160])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ba19asm3338528b3a.21.2024.11.01.19.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Nov 2024 19:36:59 -0700 (PDT)
Message-ID: <46b31874-9fe2-4534-9777-816765a265b1@gmail.com>
Date: Sat, 2 Nov 2024 10:36:56 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: apple,spi: Add binding for Apple
 SPI controllers
Content-Language: en-MW
To: j@jannau.net, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241101-asahi-spi-v3-0-3b411c5fb8e5@jannau.net>
 <20241101-asahi-spi-v3-1-3b411c5fb8e5@jannau.net>
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20241101-asahi-spi-v3-1-3b411c5fb8e5@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/2024 03:26, Janne Grunau via B4 Relay wrote:

[...]
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,t8103-spi
> +          - apple,t8112-spi
> +          - apple,t6000-spi
> +      - const: apple,spi
Apple A7-A11 SoCs seems to use a Samsung SPI block, so apple,spi is too
generic. Fallback to something like apple,t8103-spi instead.

[...]

Nick Chan

