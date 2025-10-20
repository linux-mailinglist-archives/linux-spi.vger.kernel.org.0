Return-Path: <linux-spi+bounces-10739-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF612BF2DCB
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 20:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D95C188677E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F301320380;
	Mon, 20 Oct 2025 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="0nZmb1Z8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382342C374B
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 18:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983615; cv=none; b=WAxBpCqdEm/8w6gpFHFPUiNwRYsKGk8WyfiTvB3KQtcnnVZG4Hk4CGkQExHcwDDfeInwSbbNE3XGConSGUkmNivinAbz6YqWvIXwxkCCq8uQx8fcJz2nhAX4yumfnz7Yp26GLxNuciidIBWrS30EC5QLXNQq7rPhtIcgR08EMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983615; c=relaxed/simple;
	bh=QTpmX6jrERRcIBu+6XueQEVtWkDEmNTcFOC27A5EpZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aEESSbJHpAkn+b8+EEG94+p/QGK+qE4kfI0sEhuE/Ac2kaghzJ6EZzW88a/Wed4/pO3ogvLCcsFhJFYHnc+8huXwL5RxCG1mupHm2J9ifRABAczZWczuIPra/GwCKCnfxSW1QS2X9lJYHAbShqskWOoPfJ/sPsb0IS6/I9TIxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=0nZmb1Z8; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93f11fdd538so106315539f.3
        for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760983612; x=1761588412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oXBtLkkB0DB8TY2tig01PgEU/TWly7nbkJIcjJq9f9I=;
        b=0nZmb1Z8dWaYBPpYKoUT2O4Ruc5mhORaMeLww3efuRkYNWl7gT+sdmc3ibERGDKVge
         trAOOhJ6CaAl83Og4PPEPsCvMdKothS2ysTKcPesgzgksWv9svNy07++dg1dSZrDhXGM
         tOM6SqmvBEcnRuAX735Y0EtK8+tTV/MYtsYwt47aurke7P3iWSrj0gU7fgWu6i0aiPqR
         /NhrpJbDY7Jqbp0qkVBWfFxAjVv9KnilV7Wv7iYKXHo3L+5I1fbBoap9b6J0RluBJ3e3
         3xBwASyvb2y5pnHO8M/HWzIVJkxW2lHKg3wMtP0udRJIpV5U5o+/n6+nsuBhVrMX4YPI
         uP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760983612; x=1761588412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXBtLkkB0DB8TY2tig01PgEU/TWly7nbkJIcjJq9f9I=;
        b=KTs6/1BZjWFAx1PjgjQ9upCkJFIe75xNJXVzIbmS+z1EiwEV5RkvcXJrx/HutqY3DE
         IdPc2hgT8bauRj9pSlSgvaNtV0R6ND8cP4CRpoTfuAB8cZZXz56tEb90DcBAflu9GW4c
         Utj48FjqcdvgRV3ocRco0pmQvA72M5Ep//kPRxNf3rLZhWAWtmipZuR9aq6P1BJxAP/V
         qQujpkdKrhu2MyFABiPqQfg9ahtWyo5gu2ekfdJgGmEE8OSyOPwDLIX1w52iIAAzgS6A
         2XyhU3ClQGoXSKbaUahNYMRgxD7mbTDLNlw5acMgddFju74MgWQ+4f1eGwXEZcM5SLns
         4+Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVeIitbsPqZXm7NNFFRg7Va5C9iBczX3VsQ+DhyBip7866WNmhv0Eko+07p1i/x7T+W/avXDZRUEWI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj6/SGGyvNXd87w7Nv3GSoPulc6aRKTdalBRucbycGol2SxNZo
	GmnUpaDI2J8eklSMb6DGBDBWAX8jPp7xbLLvqVKEuErQanaS8xEZbQCUV4DX57UsowU=
X-Gm-Gg: ASbGncssLc7hh+kZmspozyrG+Kge+F4zYiNSPfUQcfokmrKdbUYhZeshTzqFdGcZuDV
	gYIGjUrXHa3e2rClZs3o7btD7pWyeR6/xRNijef2VLTzrxoiV4otNlouVArnT8P21dfZpasUD/g
	mjdf4Cz4vgq7e9OsCGn/gG02/YARaJOofuds3sF4MD4vbJeJ1Cma4Cg7Sm3TAvcd1Gitua6QXPC
	MwQylJZKSuR/3VhPKj/Zk5esvGCXhrBegJhAom9s1kvUeMAMoOvTF776tTx4z+HMjUCGWZF2fiA
	GTG2FfLgpuKKT6d+/dAW5a2vvyZCnIW7nr1eEZIkRfmViJGjSUWkQal8RDQg+VMicAMgztgpf6t
	n8ebBvdng51JmYwuupHiWFZFUuMWN54/sfIW6JZlUjpg+DXS1JPB331x3R70Vo882OD92i8DGwo
	0jPw6ro26oP20I/lMn885o/N0gNdvkHYFEAvVWd1VzG1mSdZskHA==
X-Google-Smtp-Source: AGHT+IGevb4egGjj6KWxQP35Nq0zUYSUBGNvYU6Luo+078jNAKiHY5b+2d/guD5dVmi2NJ4AhRB7Qg==
X-Received: by 2002:a05:6e02:190c:b0:430:bf84:e941 with SMTP id e9e14a558f8ab-430c51ecf81mr209120355ab.3.1760983612156;
        Mon, 20 Oct 2025 11:06:52 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a961e88csm3172542173.15.2025.10.20.11.06.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 11:06:51 -0700 (PDT)
Message-ID: <08d99fcd-4d0c-4d81-a314-7e1a8bfaa64c@riscstar.com>
Date: Mon, 20 Oct 2025 13:06:50 -0500
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
 <20251020-utility-remedial-4b4dfc716409@spud>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20251020-utility-remedial-4b4dfc716409@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/20/25 12:41 PM, Conor Dooley wrote:
> On Mon, Oct 20, 2025 at 11:51:45AM -0500, Alex Elder wrote:
>> Add the SpacemiT K1 SoC QSPI IP to the list of supported hardware.
> 
> Also, you should really explain why this spacemit device is the first
> one to be in what's been an fsl-specific binding for now in the commit
> message.

I'm not sure how much of an explanation you're looking for, but
yes, I agree with you, it stands out that it's the first one, so
I at least should have acknowledged that.  I'll add something
here in the next version.

					-Alex

> pw-bot: changes-requested
> 
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
>>         - items:
>>             - enum:
>>                 - fsl,ls1043a-qspi
>> -- 
>> 2.48.1
>>


