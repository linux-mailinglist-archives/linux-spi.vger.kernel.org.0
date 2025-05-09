Return-Path: <linux-spi+bounces-8036-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347F1AB15CB
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 15:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33020189FBD7
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0A0293B43;
	Fri,  9 May 2025 13:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q/2ONir3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579772918FF
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 13:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746798388; cv=none; b=uVFT32c3WK97REgLy+99JPG4jPjsXaEdv8WqPYCjFrf4kNiD1NkqEqQApeajrAiuMppH4AdohsrY62i1Zr/G0MB+5krY2GXtFbkiVL8uQ+Y0a8nLyQwfUxgU/5dEXLQNDtBpiMtAR0j/v9ZLruaix1T91dRsqXaR6dLwUko7sXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746798388; c=relaxed/simple;
	bh=XO/wK7V6mXY9xU1mcWlD2Ct18mmjFn+FYLp11z65N7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Alqti6hknvdVLdQvcgk8CfpnrTDBoc7RC2Vow/RZuhlEi3V0E1XtZlDk2Dn5XfGkWvnUOm6kkj1fhjEgc6dD+NPpZOT7p3+vaL8AoB2rTfFQwgxbe1DI/jstItq1At5HD3j83Iaw7S0of2bzwWCC4W4bRNKLOzbVVtbI1L0XRGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q/2ONir3; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a1d8c09674so783839f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 06:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746798384; x=1747403184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PZUF6Q4Qc9CPUkc04ir0Y5K/i90KczoIYGaKnAPCoYU=;
        b=q/2ONir32GkMPFC6dT/uDWYlpzm2wytlHIoVmvWpLmYwgZOs6JxM06D/RXz4jLvFNV
         Gm65lYDwf/zt7/ZRFp5/ew7R0dtj7mTooxybtt8hzKWf0ldHaLE9jhW41AqdJUm+Qlg0
         jI6NtJvztVK0aTY4uOJ4rxYv8j1fj3rsTs8nfiwLAVZEueU0GP3CEQtcO/VvDKQv71/L
         IeYYVjMlT82hiCJM1Y0HN3C1CGQtFa7HAFpCRhfNXFxwdJISGyERrgSpwGwGZVOpQDsx
         oOMH8jkCNGyzfPEhHrOs+2dhsmTuWMsVrlFWMpO6OCVOwiG4DjLyBnVYyvKERNr8Rply
         g3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746798384; x=1747403184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZUF6Q4Qc9CPUkc04ir0Y5K/i90KczoIYGaKnAPCoYU=;
        b=PBSbBbhpjvU4ua218X3acCvpxKfHMHx6GUYkojfi3NEEG8MenoL6iDZEUQ5Rbg6R0L
         YqLjgxTZoiZ/hTXOD+rUKZUKfNTCYsEuvRH10H/2aDhSkPph5LltgGoNsQ69DsQAf0qG
         SUFi/y0202PwRGNxVMOv21Yv/cxlvFelNiGsTpXiMaghgsXVl01y19K3OQSYsIu59fPM
         j/QLj8jD+lAU074KrES796mQLt4iVvLn637EGBU27Fu2CgWqSHmMWZhmnIRE1mYv/6JZ
         yHVR9S5CeWIGQS8mS/8IE9d5rXk2mk0dymNhkl1LPf6Nys+LwQmJcmOzuEhQDqcsdo/G
         TxTQ==
X-Gm-Message-State: AOJu0Yz2tgW5/PwOREluJ19kudpF1CEgygP3kddZF/yTlE+qM/gnIjy6
	fKdHIeYZOHhckJKGZyNd71c3NjMg4M7LZRGp3NXeJcJiMyfuEkVreJnXB/6cX0A=
X-Gm-Gg: ASbGncuN55/Mjbv/K0YnLxnPOqnFb6RIvRJ+nzfeNwAELh3NMACWFRGBoKlubdnEooP
	VvoL0MVLRViZotCGwiarNya1GSiKrpbKF3tbmX5dT6hfi+4U6LI9yYgHWcK4geLRgo95YgqGqXh
	sMjbWUbGtcU1zU6bjykAA2Na7z5+ZVkpGLay3wIKKOjLZ/qOw+5kfO/E4OJzqvXRO06ikFdtkMx
	zO4mdlQUYOe4hkL3819EV2h3FaK9TctT9TSPb/Mgi40FmcUwsjYAFTT1S/FtZvrFRzFcSndIYjm
	kN99DRKzDSc7qFmFfvnli4JMoZ4gZMPlZ8lcSedfaIFD6lppkBcEDw==
X-Google-Smtp-Source: AGHT+IEo0jYrQRcALBtqnax8NWcKiAGj6scBJ0uiGs5jTKoY3ij/ij8y04Oz3H5GiqMjPbUsL8YJBQ==
X-Received: by 2002:a5d:5f95:0:b0:3a0:b84c:7c64 with SMTP id ffacd0b85a97d-3a1f6435b6fmr3000885f8f.13.1746798384562;
        Fri, 09 May 2025 06:46:24 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecaeasm3290573f8f.28.2025.05.09.06.46.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 06:46:24 -0700 (PDT)
Message-ID: <bc871cb9-0b50-4132-8bdb-3a764bc98180@linaro.org>
Date: Fri, 9 May 2025 14:46:22 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm64: dts: Add DSPI entries for S32G platforms
To: Matti Vaittinen <mazziesaccount@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org,
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-14-32bfcd2fea11@linaro.org>
 <3ddde799-76b5-43f9-971e-a52ec322e9b1@kernel.org>
 <16e91572-b132-4246-9fa9-8e8bc4c24f40@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <16e91572-b132-4246-9fa9-8e8bc4c24f40@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 09/05/2025 1:54 pm, Matti Vaittinen wrote:
> On 09/05/2025 14:26, Krzysztof Kozlowski wrote:
>> On 09/05/2025 13:06, James Clark wrote:
>>> +&spi1 {
>>> +    pinctrl-0 = <&dspi1_pins>;
>>> +    pinctrl-names = "default";
>>> +    #address-cells = <1>;
>>> +    #size-cells = <0>;
>>> +    status = "okay";
>>> +
>>> +    spidev0: spidev@0 {
>>
>>
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2- 
>> devicetree-basics.html#generic-names-recommendation
>>
>>
>>> +        compatible = "rohm,dh2228fv";
>>
>>
>> Nah, I really doubt. That's not the device you have there. It's
>> possible, though, so can you share schematics?
> 
> Actually, not even possible. There is no DH2228FV from ROHM. There is 
> BH2228FV though:
> https://www.rohm.com/products/data-converter/d-a-converters/8bit-d-a/ 
> bh2228fv-product
> 
> but as you know, it is unlikely this is the part populated on the board.
> 
> For the author:
> https://lore.kernel.org/linux-rockchip/20250213-calamity- 
> smuggler-5d606993be32@spud/T/
> 
> Yours,
>      -- Matti

Correct, I believe these go straight to a header and aren't connected, 
so this device is just an example placeholder for a 'generic' SPI device.

It might be more accurate to remove this, and then anyone using the 
board for development would have to fill in themselves whatever device 
is attached to it.

Thanks
James


