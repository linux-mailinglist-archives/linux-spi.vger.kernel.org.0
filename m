Return-Path: <linux-spi+bounces-6435-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB393A19513
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 16:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2706A3AD033
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jan 2025 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8720A2144A5;
	Wed, 22 Jan 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxER/s7r"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436E22144B5
	for <linux-spi@vger.kernel.org>; Wed, 22 Jan 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737559399; cv=none; b=oJDZj2q4U0EoNohFNXdxJwsPIVTwGjpncX/xTaw9Dbm0rL9TBskUWh8UQgAjsgo3Xgv1xbs1jE3IkXRWJN307xxe/u58yWRWAdklFgV7C1+zm5YM5HmtMsL7FuequgMqxHoSiXDkzoeSFHxDV8tB7ef6OfyjtBNFcKeOvdpeIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737559399; c=relaxed/simple;
	bh=wAP83diBEz+AA2qcf51inkom2/geCIiYSbIDyd0Q4WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L3rumujdUJJkKlDFiORida8jCAPR0jKpjoxhNJjSllaHtZWuwmRHff9elPdvYZu6b7h4pKfQOPii0cyUIVfn73DBnJhEy9zFG5zJT5laLgg59iWeifhR33yKKdV2FhgJj/FpL2v9ddeko74BACo9DTsuViR7UtuppZ7g2ij4zAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rxER/s7r; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3d143376dso10622399a12.3
        for <linux-spi@vger.kernel.org>; Wed, 22 Jan 2025 07:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737559395; x=1738164195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsyK8TLyexE3P/C1c9h6HEl+LHjkyAQXdUwejp4Smrg=;
        b=rxER/s7rSstOtNeLuOuxz7ALG2NHOZ/Tw8wtYfDym7HIxG2GyaidqW72yDB6uLRHG9
         OioCO2Qr0DtFhRouhNM1Rv/lkbcQsB4CQFWjBOtXhacQrGn2Jl5CQ0By6jVwfV1oQ+0u
         Ckkcf8vBb58OiU9XRAjusc2N+ezb22taq80ykBn4Vps/oinN5RmClTwBHqSjP3v+1l9y
         cMMXCoGcWfkEKHTV2iNcjB73la5qcMJ4TR5ma8RO65qnJ4d6DKwhX4NBnbDfd7xV3a2P
         zaA8A1S6xN+CmD1CPmlzBSJI3wuWg1dUhVAmpeOlM9W/W0MuEZlEZiFgWjFl7u6/GHfZ
         AG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737559395; x=1738164195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dsyK8TLyexE3P/C1c9h6HEl+LHjkyAQXdUwejp4Smrg=;
        b=bwt4ME47AQehAsE9wy50h6pShyVjgZJZ1KQYUldX0ZIad4pLFB2zNnaq/c4uyadlPU
         SI+OJ4oVPDgwxsmf9b4J0VlTYtntaXBmg70lujm6qGvMGZ9A7+ozEVvoTCBuuhV7gTGu
         0IXGFqHVC6SHdSMWU/o3eqn8BQyfOHB5TKYcZiC6JI6ky4J07UVGW8ynwxz8LZ9IHCzm
         5WQFp7sb3mhj3yPOedI0O/JdfDvYVMeGmuOl92nB+f9F3J60MnLB6V/4bUDFU+JDDTBh
         MkWd5+UvAfp9GQc3FuFGFruCUNUvYmt+YuJnrVGaKyWIRhRMDBF8VWAC9VLjhlOQ5PUn
         37Tw==
X-Forwarded-Encrypted: i=1; AJvYcCVjeMBGmMwVgb+VbM3lSshiqlIHoC+PFcGBKSAS6McDUyZpZxg938dIMjc7abevmuSXXvywbxPX+D4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtohVs5IRqCxYCD0Uou8ECKAt3DRXqEUgD8gXHWnbwhU4Kgoh
	5vEPcQuhpI5iVZENHjZm39AQVPokaoPnQRT/D0TcwFoJS8mztIhfsvyKLlDPRyc=
X-Gm-Gg: ASbGncsOWAURRMEafNR8FcslX4roqFl67Xg9p4cq0lkkPeuFI+98Zx85qhISRTVsyNJ
	OPAktACcqWYMgx4JLMj8gOEjOTZICg17gbGCBTgdihSqNmEii9tiToWRiTQ5DcRhWW9mnopzypv
	S0vWW9DjVIgYBmStcIkDhu16hbYWPDIaAM4VBeOKCP2PNkTWSlB0WdojLyWl3Wsk/DRClSLsJTk
	QzwLTuvpH46u6Gsxm5U3ROnBL0CwVdqezg4ChCjXAfUhns7CedtMb0J54PKmuiofFq/0h79lf/f
	7iH/KO9M9b388uD7+v+4UJy+iDZdVK1F+CJGlMwv8mCmz04IX1Vf
X-Google-Smtp-Source: AGHT+IF2GekVFn2VaCplK+AEro1Vcp1qYSzsLme/+8HyYjLIiatYxywySBSc4FZMck0y/zR6BsjrSQ==
X-Received: by 2002:a05:6402:1d53:b0:5d1:3da:e6c with SMTP id 4fb4d7f45d1cf-5db7d2f87admr18744153a12.10.1737559395412;
        Wed, 22 Jan 2025 07:23:15 -0800 (PST)
Received: from ?IPV6:2a02:8109:888d:ff00:ca7f:54ff:fe52:4519? ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73edc8b7sm8484554a12.76.2025.01.22.07.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 07:23:13 -0800 (PST)
Message-ID: <56ef1276-9d58-4a94-ae89-5faf5870c10c@linaro.org>
Date: Wed, 22 Jan 2025 16:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Add support to load QUP SE firmware from
Content-Language: en-US
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 Viken Dadhaniya <quic_vdadhani@quicinc.com>, andi.shyti@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, broonie@kernel.or,
 andersson@kernel.org, konradybcio@kernel.org, johan+linaro@kernel.org,
 dianders@chromium.org, agross@kernel.org, linux-arm-msm@vger.kernel.org,
 linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-spi@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <66fb0c6d-472c-4131-bd25-83266cf497e4@linaro.org>
 <17138798-b72b-4e78-8fad-419e1a63fa5b@quicinc.com>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <17138798-b72b-4e78-8fad-419e1a63fa5b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Mukesh,

On 10/01/2025 07:56, Mukesh Kumar Savaliya wrote:
> Thanks Caleb for your testing and sharing results. Since Viken is on
> leave, i am following on this.
> 
> On 1/7/2025 4:55 PM, Caleb Connolly wrote:
>> Hi Viken,
>>
>> On 04/12/2024 16:03, Viken Dadhaniya wrote:
>>> In Qualcomm SoCs, firmware loading for Serial Engines (SE) in the QUP
>>> hardware has traditionally been managed by TrustZone (TZ). This setup
>>> handled Serial Engines(SE) assignments and access control permissions,
>>> ensuring a high level of security but limiting flexibility and
>>> accessibility.
>>>   This limitation poses a significant challenge for developers who
>>> need more
>>> flexibility to enable any protocol on any of the SEs within the QUP
>>> hardware.
>>>   To address this, we are introducing a change that opens the firmware
>>> loading mechanism to the Linux environment. This enhancement increases
>>> flexibility and allows for more streamlined and efficient management. We
>>> can now handle SE assignments and access control permissions directly
>>> within Linux, eliminating the dependency on TZ.
>>>   We propose an alternative method for firmware loading and SE
>>> ownership/transfer mode configuration based on device tree
>>> configuration.
>>> This method does not rely on other execution environments, making it
>>> accessible to all developers.
>>>   For SEs used prior to the kernel, their firmware will be loaded by the
>>> respective image drivers (e.g., Debug UART, Secure or trusted SE).
>>> Additionally, the GSI firmware, which is common to all SEs per QUPV3
>>> core,
>>> will not be loaded by Linux driver but TZ only. At the kernel level,
>>> only
>>> the SE protocol driver should load the respective protocol firmware.
>>
>> I gave this series a spin on the RB3 Gen 2 with U-Boot.
>>
> Is it possible to try on RB8 board ? Because that's where this support
> is enabled. It also needs respective TZ configuration to allow FW
> loading from Linux.

I don't have access to RB8, so no... This support will also be useful on
RB3 Gen 2 for U-Boot support, can the next tz release for this platform
include the necessary changes?
> 
> 
>> After fixing the compilation errors, it seems like there is a consistent
>> hard crash (the board freezes and resets) at some point during i2c
>> controller init with this series.
>>
> Can you please share exact repro steps ? We can try locally and check
> what's wrong and also review in future how we make it working for U-boot
> combination.

If it's true that tz changes are needed that would certainly explain the
crash.

Unfortunately it isn't currently possible to boot QC Linux via U-Boot
since the ESP uses a 512 byte sector size on 4k block size UFS which is
not supported.

If you build an image with a correct ESP (mkfs.vfat -S 4096) then you
can boot U-Boot from upstream by following the RB3 Gen 2 documentation

https://docs.u-boot.org/en/latest/board/qualcomm/rb3gen2.html

You'll also need to apply this patch to fix a boot regression
https://lore.kernel.org/u-boot/20250122-qcom-parse-memory-updates-v2-0-98dfcac821d7@samcday.com/

On the Linux/DTS side, apply this series, add the appropriate properties
to enable fw loading as-per the dt-bindings added by this series and
place the qupv3fw.elf file.

Kind regards,
>> I noticed a similar issue with this same logic implemented in U-Boot.
>>
>> Could you clarify which xfer mode is appropriate for the i2c controllers
>> on the RB3 Gen 2 and maybe give this a try yourself, or let me know what
>> other info you'd need to debug this.
>>
> Yes, please share the procedure , we will try internally.
> is there any DTSI change done as part of your testing ?
>> Thanks and kind regards,
>>>
>>> Viken Dadhaniya (7):
>>>    dt-bindings: i2c: qcom,i2c-geni: Document DT properties for QUP
>>>      firmware loading
>>>    spi: dt-bindings: Document DT properties for QUP firmware loading
>>>    dt-bindings: serial: Document DT properties for QUP firmware loading
>>>    soc: qcom: geni-se:: Add support to load QUP SE Firmware via Linux
>>>      subsystem
>>>    i2c: qcom-geni: Load i2c qup Firmware from linux side
>>>    spi: geni-qcom: Load spi qup Firmware from linux side
>>>    serial: qcom-geni: Load UART qup Firmware from linux side
>>>
>>>   .../bindings/i2c/qcom,i2c-geni-qcom.yaml      |  11 +
>>>   .../serial/qcom,serial-geni-qcom.yaml         |  12 +
>>>   .../bindings/spi/qcom,spi-geni-qcom.yaml      |  11 +
>>>   drivers/i2c/busses/i2c-qcom-geni.c            |  11 +-
>>>   drivers/soc/qcom/qcom-geni-se.c               | 445 ++++++++++++++++++
>>>   drivers/spi/spi-geni-qcom.c                   |   7 +-
>>>   drivers/tty/serial/qcom_geni_serial.c         |   7 +-
>>>   include/linux/soc/qcom/geni-se.h              |  17 +
>>>   include/linux/soc/qcom/qup-fw-load.h          | 179 +++++++
>>>   9 files changed, 692 insertions(+), 8 deletions(-)
>>>   create mode 100644 include/linux/soc/qcom/qup-fw-load.h
>>>
>>
> 

-- 
// Caleb (they/them)


