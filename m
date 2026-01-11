Return-Path: <linux-spi+bounces-12290-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A74C4D0F31E
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 15:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A551B303C11A
	for <lists+linux-spi@lfdr.de>; Sun, 11 Jan 2026 14:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FA634A3CB;
	Sun, 11 Jan 2026 14:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Qam1s0sk"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3523491C2
	for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768142803; cv=none; b=YfhNYKArl84U1N97cseHoUehFz+RuCcc2SQQupLIZjkmU2IRfKwsd27pWLAb+bPe5dS6GPEkHEp+Nacvk6zCQbJI4n05yL3PMXDtsZWrAw/OQgvpaRHXCF0uLfGPcxZjj/vKGAAkjCGZMcEbF/rO2B1jFbYMIMDgSjqCZJUPMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768142803; c=relaxed/simple;
	bh=L2SAqNmu61MHKLD0agICr57xkRB0iGTI91g9rMmmRgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bm2qOCJj32C1MS1kRVV+7CktJRWUgu2BE5IfAOVe1oPnOl568ccuhy1z4vn87P91NFEJh+c2MOCkw8XWGXBaXLgSppNF4fCIXkBC6cV+gf+vPakcu/vR0oNBS2bk7uAhEKg6WTVB89htgmzpObJ8lXmXO8BT5j9hoVmzexYk1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Qam1s0sk; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b8123c333so8955031a12.3
        for <linux-spi@vger.kernel.org>; Sun, 11 Jan 2026 06:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768142800; x=1768747600; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=998LIQD26tTlqKe1Nt9hPTV8z5SAR5Xb1tsWRfDj7yM=;
        b=Qam1s0skrMJn1KfWZxSe96IKP81h22WhBDibkbxgWIUwpBSQNSN536T77TtojW3nxq
         kLFoyDPha3E1j8A98VyQxWws3pi3XVHEjYrLvuh2AjL/vNPcDkas+WMRnHVItePkIK5p
         yjOS8EtefDgl07rBXwJ/tP65Y/Vw1sE6EhWNK6+VRchLP7n6emPQxYYi/5H9xtlL6/P/
         ns7a6XFDQO9GAFW8hheFyqWsQk6Nsce0VyXmYi3J35Jk+Y3cTtzFIsWLZLPcx+gnyCUs
         9g1Vv5mta+IVdq3zoLjpJHhxhqt9cTIhUzchJVlA7JHMdhTyomaoN/CV+gPsigwenQok
         wOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768142800; x=1768747600;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=998LIQD26tTlqKe1Nt9hPTV8z5SAR5Xb1tsWRfDj7yM=;
        b=fqCJrq4r+M9vCDiBWUKEr2Csggnc621d5J0eqWKbD/jWepTnEYfC06I4d82I8HLNbI
         f9Df6pYdu7pJ40pIXM9vg6ACAuq6EmzDiwjRXHb8bFAc6GMNlo3xyKFZj6Tt/SPVJJFb
         4Nv9xUeDeAg7q4IsMWGTeJ5DgFYRSDfYzPQpIkwAxtvHxzTzxZSv6ztz06Pk0UJZfcpy
         l6VrRcxh5xuw6BSLyK8BXr79znKPHMVWRGI3BKWn7bHKkLq5MsXIlKfLgsseFU34Gb0w
         ojHAB1MArbkoWc3z7gHFZsUuAg0xo6wnc2hwEtrvJT+sJPjuOswEeFga9oeen+F+tz7c
         oKSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlJU0Sa2W4QXukFYWkWzyv4pgRdTfRfwV0+t7u5j/JuCA5eeRU9JtteNl4W2nmEVjbW3uLQ8BH04s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nkpPTmXSlJWiwmn3vYUL/Z6KrO38pB8dGlXIWmnudTkhBK0Y
	qvp1+fXXTamH/cWzwMd0LX+JVsYiuh+ZfYmJ5YhpbXS86AZmpIEdMzqhfEJhl+PuLPY=
X-Gm-Gg: AY/fxX7Ana14qsFEs8NMTHQKP5A6LAVm4llZOy60Y4hU3zbxmZi82QSmAMHZWQ8SEpT
	pS7qa6YejgLhCRiSjBq7LykpD7OJbk/qU1DA9Xg66hd7C4W5j34zjv7vOfSLrJNmSKthapzsRTg
	z1bey1DwPyK/hTZeWLGjQr41gZOZnqYbFRzu0oApk4wSQ7uwJLICH51dzfi7TiJwzz8yvfBrQGb
	KiP6Oa3whM7b4BFDDbda+OraDxs5oiFWJ7VQ9o2Ii1t0haYCk31ExLBP8tgtxAJepBseimprR8r
	K6ZowCrYMoMSnUn7ouY38I1NeMVvVehOusyxce70FjCbZADq5AZIQKUK0wgT8E3CbkI2eN7XuG5
	S8bfaF0hOZ8abmMBF1qhfogBPi/wov5CE0Qe33zSbh36G7Xf1rYxiXONsFFNJFSz2FJbsazxGkN
	HbS2s4hEGzphQUVggYumiy5lI=
X-Google-Smtp-Source: AGHT+IEEnxtsLJjgQBqtCtTKdKKJ7nKe93tErDCONdjzSpalyD4Cf1jf8cogFFk+Jwao/l06OHgHEQ==
X-Received: by 2002:a05:6402:26cc:b0:64d:498b:aeff with SMTP id 4fb4d7f45d1cf-65097e8e49bmr13880469a12.34.1768142800347;
        Sun, 11 Jan 2026 06:46:40 -0800 (PST)
Received: from [10.216.106.246] ([213.233.110.57])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507bf6d4acsm15318996a12.30.2026.01.11.06.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jan 2026 06:46:39 -0800 (PST)
Message-ID: <0ca4477e-cfd8-439f-946f-9d0205b62c6a@tuxon.dev>
Date: Sun, 11 Jan 2026 16:46:33 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/15] dt-bindings: arm: AT91: document EV23X71A board
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
 <20251229184004.571837-15-robert.marko@sartura.hr>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20251229184004.571837-15-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/29/25 20:37, Robert Marko wrote:
> Microchip EV23X71A board is an LAN9696 based evaluation board.
> 
> Signed-off-by: Robert Marko<robert.marko@sartura.hr>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>

