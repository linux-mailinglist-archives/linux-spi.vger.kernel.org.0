Return-Path: <linux-spi+bounces-10737-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9BCBF2DBB
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 20:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B7144EA61D
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5CD92C2364;
	Mon, 20 Oct 2025 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="yL2syj3y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5642BF007
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983612; cv=none; b=TtvqlQUqcei60V7NZoZjs2zE7p/1XSfUPRTpZzV790cXbM1DuRmgpS0+mOZ8JSWaCbZvb66EMvFDcQOlNFCMqKy4ENMfP3fAT6JUSx/gNmY83Iq9kLeQr/fiYukzEXGc6EprCfJMld8EnH5Yk9wamtvcJzSfKud1Jca7645Rmzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983612; c=relaxed/simple;
	bh=JSD7zMinFfnI7sgmhr156UXVmdLj4D4xD4iX+dvck18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXiZ5XsNF0iH3l+jVGbZ/4mUf652MJqDwX6l+qPmK+OgvLU55KAbkftNKQBen9UskUY0WtqWSAR1oGV9cSwA2k8dYxOCFMkKc/SPSw47EVWT44LCRlezySmmpsnLlHPB3QBhKHhJVue4nxCfNANxJw5GoO8T2qUnqTDX6TavVSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=yL2syj3y; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-940d9772e28so55420139f.2
        for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760983609; x=1761588409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5AQlGU0mYQ6QSlBwOOl9dIxsMJVc/9az/WvQw51SeIA=;
        b=yL2syj3yBgiXoEj8bb/B4DosqxIP+OWLeFYusqaYaOFKse1m9BUCVCw2xd6rosL4Ge
         b61WVl1U8teBPjgTYcAZ485yPevfWJVl16PANjLe/pSOxFb/M69XPbFZqikhj2YcfuCm
         2VnEYENQX5mhJdGrn1p1WG61d0g9FB7Xo3aT4YnawCag4KKV5ItO7xDw6u9YUNNWoThr
         RDPfNB/+oc/dDBpfkOBfeR1SIk/RhCiklfJYLe+wc8UCOyuRJHG5p7zx+o4ejt2MxtRv
         nfTIFI2/fpsNT4W6VULv+NLKqAD2JlTJ4uS2eJBIP6o5mS3YrrsMxwAcOx+QZTcMyA8H
         uskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983609; x=1761588409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5AQlGU0mYQ6QSlBwOOl9dIxsMJVc/9az/WvQw51SeIA=;
        b=VbQfuigxFQFn2ijRe40c1bhMxoU4QdhV5qOU+yofr3vYJhYC4G0zKawcOas+7oWBZt
         avrgi2ggwy0Hm66jD8Yz9Nw6DTX83vuH6dbMxAzxM7TguSPkhDfCfVIgz20u4i29iByD
         UruIiAfFrQhXsqfANc6NPlScJL92Y9Hi4YU5Ji2EJhRNeN7gXfO9VYqey+2GmDWfiNLV
         On84V7bCwMmZ1/sa4dZOkRNopEC1xpg+mkXLRZ15vCarCiAxtqf1mWRmnQul18PfYpIe
         j3+Ypb0u7+SFw71KQszQDBamAFPy7Qiz6vIMsiQNanNneV1Vh+mleuAzgcoLGi9/633t
         fEQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFtte4kEM0bUKJb4c7tSM9KN3gqRLHP66otHZMywqMr8MAR2JD/+R11C36DglVJU8oqjR1NSQlC/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFp48u7lEi7J3HcD8bAURjD/8svfWO6MwsyMtgeIENPK75WgcT
	gc2Pwk0KBsmvTu+7/Mlc5gRtt8eQ86DzwXleKZLtCETGJbpt/83wcHGeB1YtnG51tFo=
X-Gm-Gg: ASbGnct9Lyz2oyjD2Od4qDLR2eJlMqc6zSb2ZYMKNfdAZJwUevxL/BQb6strnB7lsr0
	zpqU/Cea0xy19OBfMwGATd4Jgt8niZF5JsGIYUxea2nLB8UobJr+YvkleYgnrJPZ7RqVL88rG+Y
	GZUBXIWKaMGfWdCl8jfcvKlpHc28WigwkACk0UIJsGyyyoSnWK3skRvxuFs7ubKvteTMpYeC4sw
	iZaeF5Vszz2OVWJXo/C8K3kYWBB6tSmKVdcKzv1PmGYqw0xYnn64ZL4v0k2HzVFw0Xfo9nVILcJ
	P5LaIpXmU+47ji9DkihfYtO6pU8+WJccO3CnWf9/eYhZxdvoBDtpEv7vaXhjk6zD6yQV097B6iQ
	Ioa6wyb2kcd+QnrPrM5wf7BMf6ngdS/wBEktq/IxKRAO45v9vcyfZfDDRDd2oKeasteNQ8fm1EQ
	BZY9Q6SWgDkWOpXzi5AX153R7AFqDF5NMfQolOMRM=
X-Google-Smtp-Source: AGHT+IHBHKCx2YHdGAi+SFpNeca9RlxGKdmS/mH/TPdmxuSdnx64GJbh4fpZfHVsL9gExE3U3dhRbA==
X-Received: by 2002:a92:cda3:0:b0:430:b4ca:2696 with SMTP id e9e14a558f8ab-430c514e290mr212982775ab.0.1760983608698;
        Mon, 20 Oct 2025 11:06:48 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a961e88csm3172542173.15.2025.10.20.11.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 11:06:47 -0700 (PDT)
Message-ID: <b28d71c4-d632-4ee5-8c4b-270649fca882@riscstar.com>
Date: Mon, 20 Oct 2025 13:06:46 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] dt-bindings: spi: fsl-qspi: support SpacemiT K1
To: Conor Dooley <conor@kernel.org>
Cc: han.xu@nxp.com, broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dlan@gentoo.org, guodong@riscstar.com,
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, imx@lists.linux.dev,
 spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251020165152.666221-1-elder@riscstar.com>
 <20251020165152.666221-3-elder@riscstar.com>
 <20251020-blinked-primary-2b69cf37e9fe@spud>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251020-blinked-primary-2b69cf37e9fe@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 12:39 PM, Conor Dooley wrote:
> On Mon, Oct 20, 2025 at 11:51:45AM -0500, Alex Elder wrote:
>> Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.
>>
>> Signed-off-by: Alex Elder <elder@riscstar.com>
>> ---
>>   Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> index 0315a13fe319a..5bbda4bc33350 100644
>> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
>> @@ -22,6 +22,7 @@ properties:
>>             - fsl,imx6ul-qspi
>>             - fsl,ls1021a-qspi
>>             - fsl,ls2080a-qspi
>> +          - spacemit,k1-qspi
> 
> Are the newly added resets mandatory for the spacemit platform?

This is interesting.  I never even tried it without specifying them.

I just tried it, and at least on my system QSPI functioned without
defining these resets.  I will ask SpacemiT about this.  If they are
not needed I will omit the first patch (which added optional resets),
and won't use them.

Thanks for pointing this out.
					-Alex

> 
>>         - items:
>>             - enum:
>>                 - fsl,ls1043a-qspi
>> -- 
>> 2.48.1
>>


