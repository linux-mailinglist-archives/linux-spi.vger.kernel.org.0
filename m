Return-Path: <linux-spi+bounces-6095-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3129F5FF4
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 09:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9188A1894938
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 08:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA53A35949;
	Wed, 18 Dec 2024 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoZdFJJL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D99A5FEED
	for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 08:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734509361; cv=none; b=ZSy0QBV4LgoVL8nz6eZ3SA38paBRcu3iuhPSfWsg7pyQGVWJ9bN4bgXZBS10S10faL77eI4wexVlJqkM0qllXBqgOb18IfNg9dXmi0mMDk30Tp6kAHNzrOATewe4R1zSxSMhriaBjvzGJRkiGM3fWKJOnOVeg49tUyfeFGBvCE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734509361; c=relaxed/simple;
	bh=WNcswUE5JWbva0O3d+IaHbMvjFkxv2hoDQ7xCUBiQsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AcUfJUa8euWB5oM4HP3PGinZ/tSAf7zn8yKtI5r4NarWeTGuS6AN0614IU9wbhevfGFnD0K4JXofAZsRSuudJbI88xDfKz+Z08/1g9OPLcno2CjaqBXc25qt3tjg4d8SgM5wYZRazPiPXaV5s0iclfxDVvgaKmUHNSObj3Er/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qoZdFJJL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso32034475e9.0
        for <linux-spi@vger.kernel.org>; Wed, 18 Dec 2024 00:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734509358; x=1735114158; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZRjVLU79fxtlCs8q/RqJY5LZOSIYLIuscUTeIz5cyfQ=;
        b=qoZdFJJLJG2UtoQopN5X1OFQP+5wpIlS+4p+oanMnACxoizdypRzcEYBjMHqB21g0l
         STIdPUnvDsZ1XANl34GL31DbyTgGO1wNSkk+JbC1pTg4NG1bXvss8+m02jig+rErVhPi
         ZYXk3T6h2xUtealD2Wbrs8Rc/s+pljro/971zURrKPyxSPnG/6pZHphfUtz2zFvEQYBt
         TOK6jvHxcoVUy78fwCEW5/F+BDK8JzQ+HPDqp6rcecq6vix8nFfLv+kQDEjH+CAQ3aYa
         Pe1An+2oCZWkG9lsSXHTXu2AYlw2hVf5cU1c5eUpRiMJ4m8Q08nqjy2P99/RZeUkeWTE
         o6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734509358; x=1735114158;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRjVLU79fxtlCs8q/RqJY5LZOSIYLIuscUTeIz5cyfQ=;
        b=qtWmCGL8HbtimtGEpUsYfr+uz+9b2meT/5MROxLOo/2Nx7X7SiG0KOdzyTmGStNIHF
         2MW2FOOLo1Ue/tv04Ulyms1Edz6Z4UZDENWCPKcB3XGzAThnUOj0DdEJuTPlPP5XRKK/
         uaGBfSuQSKcAXU5tfSIQFXU1liktOGF9CqARJnXVukM+0qvrcOxivgBa6XTx0+gnwnVk
         njThHpPE0mgCVBbwbfX5dQ1eKonqB5zrEEypt03MXykidpvQLXOsJLiOTC06DSMuD2n8
         p3Rivj3PY6Oyp1oH3O0+2JGz5ElbKDvEVNIAivfZHIr6pAY7Syvn+hw5cK9GjNlp2FWR
         thDA==
X-Forwarded-Encrypted: i=1; AJvYcCV8s5B6WUHf2nkqKHF8BIiiVK5xSAXe7HN9Gh/eP0FJ3wHzELqE7STbBl/eWgK0cVmjHTknQlRvCU8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv10ERxvRzn6mpsaWE6Obb+XSno3yoyFMIbzeQ0BaB0IyfjY+F
	KYiKK4D9n7C5Y7mIYhdpQ6tl3wPPgwnH7D8qfTrQ49Id6iHP/samS+bsgI9E/Ds=
X-Gm-Gg: ASbGnct4JoptbvFeTTtqTFJuO16gbI2H8S17PVeTEkTjht2C0y8xZeIwiJipodcFiwe
	X/+dnYIDmM4BhenL4+JhwU/K3lrPAEIw3fVLYpnpVkp2hUGQeI3tqiJfOcj2KZb3Zsj9ajGl75O
	RjeGeo0tS8oJ8qz/bBE6EjHJ9fNKM/Eu3j89bY3U6xplKnuX28pYC2xkrDkH2izzAe8rL7R54Yn
	9nUAA9F4aF2qo19YwH0SS60w+1j6Sxm/bAaF3wsKGuxiYUt1NpqBTFAQ81lzfZu
X-Google-Smtp-Source: AGHT+IGOAC3FvXgS5bR4S3TJX40I3g683RjVqEAtFMj/u/nm8PyH1S1tnMwfp3FxLzNoeKSWEmEo+w==
X-Received: by 2002:a05:600c:138d:b0:436:1be4:c9b4 with SMTP id 5b1f17b1804b1-4365540c42dmr12112905e9.27.1734509358224;
        Wed, 18 Dec 2024 00:09:18 -0800 (PST)
Received: from [192.168.0.14] ([188.26.61.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b12399sm12326065e9.20.2024.12.18.00.09.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2024 00:09:17 -0800 (PST)
Message-ID: <8feb356c-58b6-434a-99a0-d707b68aabf6@linaro.org>
Date: Wed, 18 Dec 2024 08:09:15 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] spi: amlogic-spifc-a1: Support per spi-mem
 operation frequency switches
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 Steam Lin <stlin2@winbond.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Sanjay R Mehta <sanju.mehta@amd.com>, Han Xu <han.xu@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Michal Simek <michal.simek@amd.com>
References: <20241025161501.485684-1-miquel.raynal@bootlin.com>
 <20241025161501.485684-5-miquel.raynal@bootlin.com>
 <9e942bdd-6ade-40a7-ae4a-104ed288a09f@linaro.org>
 <87o71fn6yl.fsf@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <87o71fn6yl.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/13/24 11:44 AM, Miquel Raynal wrote:
> Hi Tudor,
> 
> On 11/11/2024 at 13:42:31 GMT, Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
> 
>> On 10/25/24 5:14 PM, Miquel Raynal wrote:
>>> Every ->exec_op() call correctly configures the spi bus speed to the
>>> maximum allowed frequency for the memory using the constant spi default
>>> parameter. Since we can now have per-operation constraints, let's use
>>> the value that comes from the spi-mem operation structure instead. In
>>> case there is no specific limitation for this operation, the default spi
>>> device value will be given anyway.
>>>
>>> The per-operation frequency capability is thus advertised to the spi-mem
>>> core.
>>
>> I see the driver sets ctrl->min_speed_hz = SPIFC_A1_MIN_HZ;
>>
>> Do you want to introduce a struct spi_controller_mem_ops.supports_op and
>> check that the spimem op freq is not below the controller's minimum freq?
> 
> I was about to do that but I think we can do better. I am already tuning
> the max frequency depending on the op. I can just check in the default
> supports_op hook that the operation max frequency is not below the
> controller's minimum. So all drivers with this kind of limitation will
> be covered.
> 

Sounds good!


