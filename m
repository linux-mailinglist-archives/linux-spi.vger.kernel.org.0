Return-Path: <linux-spi+bounces-12479-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14564D39666
	for <lists+linux-spi@lfdr.de>; Sun, 18 Jan 2026 15:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 347F33002163
	for <lists+linux-spi@lfdr.de>; Sun, 18 Jan 2026 14:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E589633508B;
	Sun, 18 Jan 2026 14:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AU1u6WOt"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E633506F
	for <linux-spi@vger.kernel.org>; Sun, 18 Jan 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768744994; cv=none; b=DZkY2UWR8RMB91k/9A7OKG4aEXzJ+U8zLcOfqvbrzHpN0CVKZPr1X3dpMRfVLlt3ZuAX7w+0VQhYEFaiBIWFkzW6VMkbPpp78oXAsBgGkB1qHDW/IdIP3l1zsH0+pWrTvXiedWwmlB9kJXDeeGNtvOrHCgxm28APbWaHgt+6E2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768744994; c=relaxed/simple;
	bh=/GsF+Uwls1Cn2yinM71Z8W+ioXcZeW9vpkl4szRkNjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htw3GyPksbeFhRNpvNM4hAz4UJhkqtwI7AfxqxfS/Q1zteByDGhVuF/C+DDG3k8u6fZVSWtzutYTpDRxh+iFjMQ5ZCSQm+4p1U13avDB//FA6JOX2E9i5/+sQx1mPkE0p/6+sufKbEgXvgPwcjM5Sdbwi2kit1jKcjGsiYx3XvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AU1u6WOt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so24775485e9.0
        for <linux-spi@vger.kernel.org>; Sun, 18 Jan 2026 06:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768744991; x=1769349791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMK1YqKVaUf0IoyRsQOMCKJ4gS01F7A0JEX5JckEMXs=;
        b=AU1u6WOtLoi8xhtxE3eZH2de7tMEOJBbWbxjQ3yhiZkjPT2U+TxzYsQSeFKocZiPFp
         AfUR8WeygLNHXiE9Viiw1RtzFAsj1KyVxaWitGd2d8N3ANyj+Y7kO43+hm5JZhbBq+Lb
         lPvGKm4ZddOA32TKUnbLjuE3F06FWBpu3jNeWG8PxL6W7eEJcdrnLaI8SrtPWsd/V4W6
         +EAvlq2BKqQ/VvftFp9V9f78dx1EN5wahowO2gdSHzutwK6Z8mTGZRreowFvAg6oCWZ7
         I8ZU60NADPdABqce0/chNtZRxbKpG3J3sqT37gvVSYI6RT6C+EjRstJOaUfYQFkChaEz
         m0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768744991; x=1769349791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IMK1YqKVaUf0IoyRsQOMCKJ4gS01F7A0JEX5JckEMXs=;
        b=muT8/hWW/+xSKByP7aBZEOYPVe1Jqu1klmbOG4oBU8KYSIvgi2wdw7owuAZzsiKEnx
         qjHd8EK+vfEicQejJ/+YbzO95O7Q/6V3ymX4RY1U8lm45CXPhWNN9OX1lEkoYposrm/N
         mp0iUb7wbs4tLKoGW2z3JsS7bQ7t7iG6cfPEyvBfhdtBaCXxYhoDLIlvTnGpn5sF33I/
         jjXwvzRwClTBgB1ABIZM73zqTctb1ttUQ7q3aD/Gcob/QKeDzPQ9o2MtwnqW0Utq/8Fx
         Fa5M3mRxVz1R8ae9Q40U16U6rh8uBGA7RXsmB6y63f9u3tUIKdZDm9qNY6hSfS6f6HKw
         OBVA==
X-Forwarded-Encrypted: i=1; AJvYcCWHe1FfrK8jpUsWj6F6WkUo3imPtJALs5jqEO1lgbyWHa1ZowkpXXQu3q5EVl02TQx3Rr8hvp1P2VI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGbqJmf+nruwANXEZ5I5KicjOuyrAt2wc+kCr/P0A0cWYLPNS
	Cvh+RScdkzLXx8lOgQpESbTJse9RtM/llMM8wyApC/D5Q5q4WcosqUTwywLr84zvcMo=
X-Gm-Gg: AY/fxX6cHNHdzXcfVkIL9AME9qT+PwdRG5zwCKmWBCUvZ59QGzzPPhhdk8101peRwAR
	VrQ0Hfs6+e9kBbEx0aR7leBJWFIB3mh55z0hozZKKt7+GnD6h1pEsmZbuuB2kYYqQXpjqrP/VfL
	D+MbROOKNDSLZBhRsc5T/w2YPJqaSJ75GeOUbdL9mWumlY5qJTaFER98Ums2Y3mF969QvkSFvOn
	GZ7+xOqdP3eXnYqRzBinG6Y6Om8OyqaWy1zWMVmJrGniz93/afbXRuN22iXqkYeGlW00lNt7k0/
	r66pM337DHIlkQP94ZQXp3tbfCcGMes1/Ptt6/3gKk5lx8Lr1wgAXgbj0Rr4e8noNSfHZj4aA0a
	4OWWnRrzSbvoEmfwQfg/pNwSNOS62e+VptMZp871l6/PyjteA+2Fpii8MFZFn+uyvXhdknfp2la
	niAbzCq88wYAhhis6hzA==
X-Received: by 2002:a05:600c:4da3:b0:47d:7004:f488 with SMTP id 5b1f17b1804b1-47f428f5e9amr84049025e9.10.1768744990847;
        Sun, 18 Jan 2026 06:03:10 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921df9sm17725892f8f.3.2026.01.18.06.03.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jan 2026 06:03:10 -0800 (PST)
Message-ID: <9c34b805-8c6f-4711-9718-6c39a141d451@tuxon.dev>
Date: Sun, 18 Jan 2026 16:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: microchip: add EV23X71A board
To: Robert Marko <robert.marko@sartura.hr>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, herbert@gondor.apana.org.au,
 davem@davemloft.net, lee@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, linusw@kernel.org, olivia@selenic.com,
 richard.genoud@bootlin.com, radu_nicolae.pirea@upb.ro,
 gregkh@linuxfoundation.org, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, Ryan.Wanner@microchip.com,
 tudor.ambarus@linaro.org, kavyasree.kotagiri@microchip.com,
 lars.povlsen@microchip.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr
References: <20260115114021.111324-1-robert.marko@sartura.hr>
 <20260115114021.111324-12-robert.marko@sartura.hr>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260115114021.111324-12-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/15/26 13:37, Robert Marko wrote:
> Microchip EV23X71A is an LAN9696 based evaluation board.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

