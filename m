Return-Path: <linux-spi+bounces-81-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352F67FD003
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 08:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B9B2827CE
	for <lists+linux-spi@lfdr.de>; Wed, 29 Nov 2023 07:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7FF10A10;
	Wed, 29 Nov 2023 07:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jO5WZpOD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3266194
	for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 23:38:54 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-332ed02ccd9so3155407f8f.0
        for <linux-spi@vger.kernel.org>; Tue, 28 Nov 2023 23:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701243533; x=1701848333; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7cONzvX3DJ5N2tJbhtl/3F0xHVQGSzTxNADSagct+E=;
        b=jO5WZpOD5NJKp2aVj/9F7Pz7r5lwf4r2/dGCPfXxghoxN1jC9vpHXYRc1Urv0ctdS5
         dWnqLkq8SjMf+gvw4WbCpKTyckvtBrPi/k+2vp9jifb9rgs8T7NbaNt5ssHp5edFjZdU
         Q/v+ugYO1kSif3CoJVsnUyVb8SmssREzSTEuVRzvYkiYkhDUam1c0BTLP2M1WHg3MEyd
         xcPH8r3iK1gy05Bdxix6DJZnDmG+oYkchV2Z4PCgl7P5cFiOkwUp8u+oPtRQvHZIJ5yd
         5WmaR0BiBOGkKU6LHYq8kqM5o2tq8Qn5V1UbmTLEKIoAe02230XT3ipBGoO2zzsYAShz
         vStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701243533; x=1701848333;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7cONzvX3DJ5N2tJbhtl/3F0xHVQGSzTxNADSagct+E=;
        b=EQ43lxf/gpBSm2P4turpDfH5TEeQYjIDH/9M82eDLlQoJ63QTd3AgfeJl5rjpW6bx7
         GuUdsKcTrSypm6AqeuWdjkodw3k+T2CMQsvlQJe8gumyuf0bRVs6q834H2GDMANklQkN
         IkF7YFk1x4XudRYjF1kwg6fSLNDCJ9aYPd3nTwbiwlSa+GoEHECL1qUzBf5gdAghAPXQ
         mjYVv01XRNo/hDriumSwRoTifxnKiaWn29gDlNB00Z2hY+Vx+Sbk2fHWT02NLRn64Y3A
         tDKdtlVKPpVpcNH22KTMKclMPkAbNjwkpCw3MqV5Cd/EfnIDlxhzgX9mCre0jbndo6FM
         BklQ==
X-Gm-Message-State: AOJu0YyEV8c3cnG7v/+9/Cb+1a9yNmKy0Vcw3xWaRNhvntYzNb5z1g1y
	8j3T5VwXG783TWvWL461UaQywQ==
X-Google-Smtp-Source: AGHT+IFqgVfitjC6Sy5J82ghxl/laZe5/WVwnFlMaeybrhcaJUuv6lF2MT2VXyu3Pser2LNo37WYQg==
X-Received: by 2002:a5d:6a42:0:b0:332:c50f:45ae with SMTP id t2-20020a5d6a42000000b00332c50f45aemr11339918wrw.44.1701243533133;
        Tue, 28 Nov 2023 23:38:53 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id j12-20020a5d464c000000b003330aede2besm4262686wrs.93.2023.11.28.23.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 23:38:52 -0800 (PST)
Message-ID: <6e81a443-4e28-48fd-9bec-224d07f1682d@linaro.org>
Date: Wed, 29 Nov 2023 07:38:50 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] spi: Unify error codes by replacing -ENOTSUPP with
 -EOPNOTSUPP
Content-Language: en-US
To: AceLan Kao <acelan.kao@canonical.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Dhruva Gole <d-gole@ti.com>, linux-mtd@lists.infradead.org,
 Mark Brown <broonie@kernel.org>, Kamal Dasu <kamal.dasu@broadcom.com>,
 =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Mario Kicherer <dev@kicherer.org>, Chuanhong Guo <gch981213@gmail.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231129064311.272422-1-acelan.kao@canonical.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20231129064311.272422-1-acelan.kao@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/29/23 06:43, AceLan Kao wrote:
> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> 
> This commit updates the SPI subsystem, particularly affecting "SPI MEM"
> drivers and core parts, by replacing the -ENOTSUPP error code with
> -EOPNOTSUPP.
> 
> The key motivations for this change are as follows:
> 1. The spi-nor driver currently uses EOPNOTSUPP, whereas calls to spi-mem
> might return ENOTSUPP. This update aims to unify the error reporting
> within the SPI subsystem for clarity and consistency.
> 
> 2. The use of ENOTSUPP has been flagged by checkpatch as inappropriate,
> mainly being reserved for NFS-related errors. To align with kernel coding
> standards and recommendations, this change is being made.
> 
> 3. By using EOPNOTSUPP, we provide more specific context to the error,
> indicating that a particular operation is not supported. This helps
> differentiate from the more generic ENOTSUPP error, allowing drivers to
> better handle and respond to different error scenarios.
> 
> Risks and Considerations:
> While this change is primarily intended as a code cleanup and error code
> unification, there is a minor risk of breaking user-space applications
> that rely on specific return codes for unsupported operations. However,
> this risk is considered low, as such use-cases are unlikely to be common
> or critical. Nevertheless, developers and users should be aware of this
> change, especially if they have scripts or tools that specifically handle
> SPI error codes.
> 
> This commit does not introduce any functional changes to the SPI subsystem
> or the affected drivers.
> 
> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
> 

I'm fine with the low risk of breaking the MTD related user-space:
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

