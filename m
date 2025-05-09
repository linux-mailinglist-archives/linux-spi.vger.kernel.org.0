Return-Path: <linux-spi+bounces-8035-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C55AB13EA
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 14:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD60A981CA5
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 12:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FCB291157;
	Fri,  9 May 2025 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1B+YBYN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE65290DA4;
	Fri,  9 May 2025 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795293; cv=none; b=HrcsQFhHjLI1aJf8f0wPK5H13M5BQG9RZd9nLnuxusKgU3z22ZJA+NNarpd0/0lNX50jXFOwEKDB1LcAxXHlPgVr956LVYsX5iflRcM0nT+OkaT8STg52FQKKkrcV7UAH4ywe4FjR67jW9aKOtn31KwWM7yJjDHW0TRwTBZkFBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795293; c=relaxed/simple;
	bh=mdjay/bt0YQTImzRRyNTf7+nM7Iqt5fpIRc4hBQRXqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gDWRsP3qi9GezEztZimq+yNWnc+O12xAo4Ox30nQvUpTbd7gw2VmdXF71+zPe72ivQEG5a8cksrNqT0uqfIOYF+GcUVg5et3I//RvF+XKm1I7J6n2tpWMEPyD+6xSpuquAWGnp8g/ibBN61w9b//ZOvEZ1Oay2VJYQlnQo3it8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1B+YBYN; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-549963b5551so2368672e87.2;
        Fri, 09 May 2025 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746795290; x=1747400090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VUkV8BywuFWcK3XlHlfeRzzwdT0Xtem3jQh4BxB4+2M=;
        b=Z1B+YBYNXVt1LA+Hh6w9jB7h0xJ2UsTL8rSCZVMHD53bt2VZcOGiDOQ9vloHS/Wep0
         Hl5Z2BvnGAZstrnlTUMYFS+cehwDJVN9I5G4vE59Vg0nLTA9+j5Fm9Rzt+ecRfwZvxQS
         CGKWR78YyF71XE9md9/QjV3ui4aE5FOw7cudDNI+NJVlnXLL4hstB75VRfjVw313NNji
         IXO9D81+1BMPLY/nIQPv1gAKRiyxNj4d7PzZ30AQY7D9jQ3Hvq+TZ561JpyssJMpwj0g
         BxjP4hBgQmuoeqlwNW0kqmhVbl9VMPe2afu8SCdMfnBYj0cNMI0NRk7dIQL61n5hNw5n
         HCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746795290; x=1747400090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VUkV8BywuFWcK3XlHlfeRzzwdT0Xtem3jQh4BxB4+2M=;
        b=K9+ezftC0MtxQNJ48OAhX1aJX4E0V9xLZsitABtybuz+tBF01rb1UzKoOKJ2yBUAMU
         SSZqKG1BAegXy6pHrluqk3zqUFC2hRodtkYJfEXZJT1w+h10xRtFtQCoXVuI5Gk4b9i2
         VXXlsK6QdhJkJxqp/dm4J09fZQl1TtmqBmaJWLSWRIzix28MkjU7HuNHo7C+wy1ormgS
         mRhIsYdYpMHuUVZjydHcgUsxS9UxbGYx+iK7j9jeypRCRJOLkh54/PN25NKCaMpUe6UT
         yJe7RTZ3VNgAwiPLKqHqW4mgPzkbiyRXtxwpXzOpENV0WfWo4UzLkDwMyfztxi8dhJpJ
         pgjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVupWFRF0ncXbWOyM5eWpa+I+MyiwzfgGdBjwV1bpD5wKN2P8wEKRczitRLnmYRLdnWkb9fhXS99/8P4Dad@vger.kernel.org, AJvYcCXA3XcDG+gSu7ah5NrIrkwVb/6FL0ZBoI2D3a89TdaqGd42xtoLc47VZWdOzpOz9oI47uob8ADglLyf@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs/0TBDrEYAWrwXG+S2ul9NMJTV/VfYWNoWUCNB/ZkFt48ypj8
	Zb0VbTvzvCUPm+S+i2ePXAdQtbylzaPxA354sxSFnAqFxklhZWK2
X-Gm-Gg: ASbGncszHBOo6TL3OdmrDRLdlRPjkD5Aq3uXvsuKHfiRDcUEamuRzga7ejMtIoTvTUr
	dnsAz2cK/cl2HNLp6hoHAmDiPQvfzg0uBdBLIatYoTPzgP9TzVS7MRXjOA/CQ0MnfQxJ2BQ0vV2
	+/VF5D3IoIpz3GiY68zXoQrkN1Q5FC9tDJaRAhuJmW4qr/aF+rUo8mrORZGcm10Wuc9d7zY5xfP
	y5WmVDF3i++FpZ3aa9anHxdNLNRmR3DlYeH3vHovL3BfGKdgpCG9VEfYzb0IVAKGyCxe4uaJu9Y
	09GRDTBvDByaUhoLtm87agFxSBCHLL6H3lns3TaNqi2rq2CdSoqo4NsNSccVGbgn/ig5Ao72HGm
	tOb0hiO9QikpUQ80YPoTVPOLUpOQbLud2
X-Google-Smtp-Source: AGHT+IGB0rBm4Sd2c2ZAuOBq1Wdz7EzM8zgvpzQWNHnTdOFbsdIwxpR9iWs0VxeI4bDlh0fT/50rUQ==
X-Received: by 2002:a05:6512:6506:b0:54f:c074:f91b with SMTP id 2adb3069b0e04-54fc67c95damr1229451e87.24.1746795289472;
        Fri, 09 May 2025 05:54:49 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc645cdcbsm270564e87.69.2025.05.09.05.54.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 May 2025 05:54:48 -0700 (PDT)
Message-ID: <16e91572-b132-4246-9fa9-8e8bc4c24f40@gmail.com>
Date: Fri, 9 May 2025 15:54:47 +0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm64: dts: Add DSPI entries for S32G platforms
To: Krzysztof Kozlowski <krzk@kernel.org>,
 James Clark <james.clark@linaro.org>, Vladimir Oltean <olteanv@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org,
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-14-32bfcd2fea11@linaro.org>
 <3ddde799-76b5-43f9-971e-a52ec322e9b1@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <3ddde799-76b5-43f9-971e-a52ec322e9b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2025 14:26, Krzysztof Kozlowski wrote:
> On 09/05/2025 13:06, James Clark wrote:
>> +&spi1 {
>> +	pinctrl-0 = <&dspi1_pins>;
>> +	pinctrl-names = "default";
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +	status = "okay";
>> +
>> +	spidev0: spidev@0 {
> 
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> 
>> +		compatible = "rohm,dh2228fv";
> 
> 
> Nah, I really doubt. That's not the device you have there. It's
> possible, though, so can you share schematics?

Actually, not even possible. There is no DH2228FV from ROHM. There is 
BH2228FV though:
https://www.rohm.com/products/data-converter/d-a-converters/8bit-d-a/bh2228fv-product

but as you know, it is unlikely this is the part populated on the board.

For the author:
https://lore.kernel.org/linux-rockchip/20250213-calamity-smuggler-5d606993be32@spud/T/

Yours,
	-- Matti

