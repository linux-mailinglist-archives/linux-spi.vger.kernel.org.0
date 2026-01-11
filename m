Return-Path: <linux-spi+bounces-12286-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A52D0F2DA
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C1CCA3013BE6
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D9933C183;
	Sun, 11 Jan 2026 14:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="K9ADx+2q"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD3534A764
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142710; cv=none; b=PWMby75nUFMGj9zkh1ufbyb3ixENpISk2zRXhNBGQ6FgakQnHi75UFZvau2oVXJw9/qNSGfu1LBEdVcnMRWwPQhu6xHh5/Dp1ehgoG/iqVi494oTzWEjgzXeOth6h51q1/xKUd1ObA8wIcG+J6Ohx6zV7j1A4yT3OuCgOr2zj18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142710; c=relaxed/simple;
	bh=gDiL7diPPllfiqdrICUaz2pklt2cpfwEzlq/42pPJS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PLozaBgWrUyWl1PLMeCqZ3mzepUscAGrAzqyHtwMDSuoPAiCItJEVWTSx4zOv636Yoo5dSwdhvvTXbVQZpHR60VPlCPZZB1rucJ+UeJ86z2ocgixFeLmsUqrm27IwgG09UBeZpk/ve+8iWb6A/W9Czm0BUuakspuEL0IBv9f6oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=K9ADx+2q; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b870732cce2so64072866b.3
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142707; x=1768747507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bR5pMB9Z21CNTk1B6+opWEfUH+WjtdKh40K9u7GvYSs=;
        b=K9ADx+2q85hi1Y4+enhphqyqyZpZ50jBbUQejVQ9+lAyuPt1J7eUMJcsTH5Bdu91+/
         8uKGBqR2SSjJrxX/lCcEn9SiYTF/WVBgYkIGEyzvckX0wje75OhEfcmjaMUigKJwIZRs
         e06XzNxpm7i19SZ0LSNbNWyN8H9SmAT8nuB4Q15uT1Uv8OpT/U/AiGflgqftkaUx04wS
         FC9tKAq3ltBYaTZkCdn5SXY0EGMBHqbdzuQwDPZYYV0jMRzS64ApUPcVOjXPvySqbrOy
         U8+WS76PxjSbXLX1BI4gqBrNFoWcvXvKZgA6KNPOhcW9KOI4VzIXbxSQNQP75cdKv3IF
         4osQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142707; x=1768747507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bR5pMB9Z21CNTk1B6+opWEfUH+WjtdKh40K9u7GvYSs=;
        b=dPQbGOKrjFxu2VvpJ88KKb0YYlGIvmFn7u1ffiRZMe+4igeq5RboAfDA1kmbtVP7qs
         hLYtynsPwzbGR8KLl5uZeoQ3UCI/+OGYi4pULYEYKj7ebEPqspV+AT+CrJzFKPNluryv
         Kj59E3AJfh7VJ1HWvWVtRpK+fXeR/1nx2hMmIlHf11IA2GGWuzOo6nM7d50gSDnZ6ltr
         DxypgPuV/d0PHwbkfluMA2eUCr6B0yp5t/YCJ8RWHKr0hrcLXorvBrvqv7yNT25QmwX1
         vKwYIJNggR8vhKkGYt3x3xlLH8+SQRqxQQ/oD7JDGnqUU9e70ngBhy0vQ2BK8HNlq6tr
         ivFw==
X-Forwarded-Encrypted: i=1; AJvYcCXs5dVtkJFOpOR2ErvJySXYu1dUo+qjtmk17ODw3e3ilO44WLzw3QKTCDM1h6rFF4GrRgAZ1Pst/oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwk0ZKkrQ/F9DO0SnVO+ZBZ225OpIF2TBOyKVxg6Cosa4xhpfW
	2ftz9hwHz1gl7FXDJAaf5CS5h2GH4kRL2MVMqsjZrsH99tu5tsL1Lg36sO9EiQvmyQ4=
X-Gm-Gg: AY/fxX78leFnQ0WsdiQXiKb7vXxx1F1DXcYy7PWk9T9jFHN09d7TZYtOzpW5EnePyjM
	iJf9xSw2J2vTsPMtXtT7Ch58ReSCCSz7OGPByGROfJHRAcy+R3ma80zoq5g04xdm5+RyV3jZ9q1
	ZPhaMBbqU4adg6KIr9N5ZpRPc109ytLlPObthjd10i3m2ehJUWD8OuAwqzhFVZXhWltcF3kOfYW
	oYa4rVKgb0CK2kQLYd9+LIsSkbtwVR+8n3fM1h4nB0QvHKSh+PFyRTeu7wnoH1BiBhwHzurK3Fl
	YS6VQVw/OO5PM5+8BmHju8N0KkW1fV+7TIjQqeIOI1L05TRZIJY8nCjmr9ty+SBghjEiLVe6Te1
	HBJUomqiRTPDQ1anxw8EPSx9sY+Xnhd/V/2GRttV9lXCUXD6fWYzY3U0k1aGYofOG2waMqpBbZP
	jWitHqh8tgZuWTn8yIUdo62wNL5ZpGt6bvJA==
X-Google-Smtp-Source: AGHT+IEnRprofKW6iUFW+aOMnt2p1AYruny/NjK8tSS/dtcvBYVRc/tCV4eudi2xBk8lGr0c6zLI/A==
X-Received: by 2002:a17:906:dc94:b0:b87:b87:cdbf with SMTP id a640c23a62f3a-b870b880077mr194416066b.53.1768142707046;
        Sun, 11 Jan 2026 06:45:07 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a235c0fsm1673227466b.9.2026.01.11.06.45.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:45:06 -0800 (PST)
Message-ID: <19f25a94-fc90-4298-b3ea-58bd66cad11d@tuxon.dev>
Date: Sun, 11 Jan 2026 16:45:01 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add
 microchip,lan9691-sha
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
 <20251229184004.571837-9-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-9-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Document Microchip LAN969x SHA compatible.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>
> Acked-by: Conor Dooley<conor.dooley@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

