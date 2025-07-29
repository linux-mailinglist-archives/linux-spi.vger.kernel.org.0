Return-Path: <linux-spi+bounces-9208-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADCEB14DEB
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 14:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02CB3B351D
	for <lists+linux-spi@lfdr.de>; Tue, 29 Jul 2025 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9F92C859;
	Tue, 29 Jul 2025 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="yhXi6ckX"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA9B288CC
	for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 12:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753793539; cv=none; b=rPB2AWYurCJG/0kj/EMash16wre7QEnhE72Od1l4AbIJEj464lOAsceHqdxs0xkCWunQkZCAHbps1uawSr2xTqDJ+IiLlGzhQjy1n9lGiJMLlwjt7qOZnjEgAMfwd93+Xin3ZwtE2qno1nlnHp8V1GKrRvmwINV+nmNTSEX4h8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753793539; c=relaxed/simple;
	bh=s0eR5gp8Ag9r7D5VJgcBzrT96bpimRE6Ph8Y+o1Df28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umSyIADJioF4fgTdHWh7VAqcJ+oRXmZztAOn9SXULE2ZQCeMHNr6qiEVcEQAbv5M4badmRMUeWKzXWiQAHhpz0UP/Zjz/pg3NRyROnyO/RaorXYAFU3+SIZZIXNDZYAxgv+Flh9pMD1OLVsHX5u6Tr6cT9sAWliTTbyhEEIeFzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=yhXi6ckX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2401b855635so17648565ad.2
        for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1753793537; x=1754398337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aavvdqt97cstrZY9DrFTlKwuOG3lfE+vs0JuoYNVqPI=;
        b=yhXi6ckXa8bs5iqTFSW2TRLMtCJxKkx54UcCSDNISLFfsSCqJQYxKoaN2yiCpo3ovE
         /2T9qu7tY5af4u8nSsnXueP4ume128mISW540ioPKLlbCV2hLrF5ffQf9+xqC3Rcz9su
         U8fFD2EXadkPUYV9VLJvHO7PB54k3DOvsrQbFGO8+PgIT9VEnTiLGQ8scBOND4848TzQ
         jK3XtFw8XWvDNCos5ghYZ+pqfxO2dEZ1n4xynU9+wkieYM5xTfc3S4ytobTTtgvHYvdD
         SI6xKVYP5vZte2vQEfXwSeTEE/tYp6Lr5JFZmFm3eQT0Zki1wL3oqjJAo9e0dkRUh15H
         yRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753793537; x=1754398337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aavvdqt97cstrZY9DrFTlKwuOG3lfE+vs0JuoYNVqPI=;
        b=L2ZAclecXV3cwI0eP0zvK2wfDinle8FA0oAF2Z4EzNq5KXdjKF72RpMkxygWtf6jdk
         iFj8fFZnttx1jXwd86Loc52yhjT7BfxA2NVLoS6BZZOQMAtXH3n/vfX2LYyzOv3tD/aX
         aaR/7NwyDwvYhPX81bgvNxdmCmFPgum+DhJy8333pNnvBdP6CG8PkBv4jaON6fzdqIku
         V05jHhnw15HB+O6RMWWOMvWwthkalhW9Erd+KFYjRW68Dry6QTbTtylIjm9YEmPP59td
         W2DX++GIoFdnUPS1LuJwvaa+JOdr0ReK0kTsSii2ur1JfqVBFuA19TWw0CnW9XaupBCd
         glOQ==
X-Gm-Message-State: AOJu0YxUsLBhtkxEVdo4giMCQZq7+iiRfZI3zneEAp8BTHXbhu5Om6YJ
	KAGc1L14cKXUIFYuMLJT1eF2l0eDJZfc3d59X3Ko/WYNknjE4rgOvOgSeTW/qyhw+A==
X-Gm-Gg: ASbGncsA3Fp648W8AaJ4RRg19NuWOdl+2lceEU5LiPcSjCGobD7rsjWM41uVIzCoDlp
	GXlwwecNIQKBMUC3fympQr/kHloP6cJTnevmJwLmpRNWx0h4pvqLcylcXlRodIKbfpZhRit6Xb5
	GlalBQ9MHFPcnTFRbt6IGFoh3P/5Oz3kbTEmJK9BL5Hk/lb9NQOG3/oEX/z/sZX4NmLkdVMXVPb
	TvqYiaGs1pEV3bQguo2e/MaezqAhT84nEIKx9dvd/Nnlklh38Xt4hpqmGGN3Ru6R1VvlCsMJ0KV
	DGty7SyKRm/bWxAdMQr/hdvF6yoJgmyoscrN016ANx6U0rVmVmq6gfTaDAOmlFb8q0CmxdPg+Yd
	CRhdE4pDpFZRSuzztS71c3F29JKxxDGtXbAn1Q46AMy105Rk8gKbRzO1ktLocbxVPNBN+niuug2
	L79SttXuEsow==
X-Google-Smtp-Source: AGHT+IHB1EfOTj4QIbmsZVfLeJQmkfTf+eDCn0dFGah1RkVpZh76+BORDPSCFMWskbaqz2cuthKFBg==
X-Received: by 2002:a17:903:19e6:b0:240:71ad:a454 with SMTP id d9443c01a7336-24071adabbbmr35483935ad.1.1753793537141;
        Tue, 29 Jul 2025 05:52:17 -0700 (PDT)
Received: from ?IPV6:2401:4900:8899:25fe:4fe5:6353:8b2b:942c? ([2401:4900:8899:25fe:4fe5:6353:8b2b:942c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2403c96e4cfsm39463225ad.25.2025.07.29.05.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 05:52:16 -0700 (PDT)
Message-ID: <e01669d6-a233-4e64-a0e9-56b54c7d38cd@beagleboard.org>
Date: Tue, 29 Jul 2025 18:22:11 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] spi: Handle spi bus extension
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
 herve.codina@bootlin.com, luca.ceresoli@bootlin.com, conor+dt@kernel.org,
 Jason Kridner <jkridner@beagleboard.org>,
 Deepak Khatri <lorforlinux@beagleboard.org>, Dhruva Gole <d-gole@ti.com>,
 Robert Nelson <robertcnelson@beagleboard.org>, Andrew Davis <afd@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250729-spi-bus-extension-v1-0-b20c73f2161a@beagleboard.org>
 <20250729-spi-bus-extension-v1-3-b20c73f2161a@beagleboard.org>
 <c90da4f4-a402-43db-8375-575801ac2714@kernel.org>
Content-Language: en-US
From: Ayush Singh <ayush@beagleboard.org>
In-Reply-To: <c90da4f4-a402-43db-8375-575801ac2714@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/29/25 18:16, Krzysztof Kozlowski wrote:

> On 29/07/2025 11:51, Ayush Singh wrote:
>>   	for_each_available_child_of_node(node, nc) {
>> +		/* Filter out extension node */
>> +		if (of_node_name_eq(nc, "spi-bus-extension"))
>> +			continue;
>> +
>>   		if (of_node_test_and_set_flag(nc, OF_POPULATED))
>>   			continue;
>>   
>> @@ -2541,6 +2549,23 @@ static void of_register_spi_children(struct spi_controller *ctlr,
>>   			of_node_clear_flag(nc, OF_POPULATED);
>>   		}
>>   	}
>> +
>> +	/* Look at extensions */
>> +	for_each_available_child_of_node(node, nc) {
>> +		if (!of_node_name_eq(nc, "spi-bus-extension"))
> Where did you document the new ABI? There is no DT bindings patch with it.

Patch 4 is the dt bindings patch. I will reorder the patches in any 
future to make the dt bindings patch 1.

Here is a direct link in case it got lost in mail: 
https://lore.kernel.org/all/20250729-spi-bus-extension-v1-4-b20c73f2161a@beagleboard.org/


>
>
> Best regards,
> Krzysztof


Best Regards,

Ayush Singh


