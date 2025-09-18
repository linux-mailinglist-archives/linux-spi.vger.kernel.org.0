Return-Path: <linux-spi+bounces-10128-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F04B85E20
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 18:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84CD561DDA
	for <lists+linux-spi@lfdr.de>; Thu, 18 Sep 2025 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551F312814;
	Thu, 18 Sep 2025 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="tv+rqrFD"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D42F7ADC
	for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211119; cv=none; b=T4QoCf/qwFKpTO9LZ/uV6U4l0OxX3aMwrEVzTycTLkEPAvZOaSifwMOxp5T+mkBpvnIbx8RR/da0bn2LBSh18MpoxHPc/XD0Ad5MsTyYqQ2i6YdJVCkdOCYV4gxePmBL4K12iCABfZMx6s/t5TQXoaH9shwpo8a1M+rjqNA9618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211119; c=relaxed/simple;
	bh=mBOMOV2UEaBJS1bN98PWLw1Tk1D7AqCi+UV4js6u0C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpMkCJYQSE1NSZ0VCOVQ+vFOKJhPraOzPkl6XwCyOJswuaF6dVEtI5qEE4vQ9/U9COKByJ8OP5ADqaf/6Q8ih7/jb8f6J5qkTFyX5rdUBGKsW9foe2LTJD1K3SLAryYOW3UtGHeNWCov/iYXqSJq2Oq6Lsly2mTQ6XWDV2wsl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=tv+rqrFD; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-892db7eb552so147889039f.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Sep 2025 08:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758211117; x=1758815917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWwPXk3+CMDIY3Ii9TMDH0aQbdb6ssOVOtszqmINL5E=;
        b=tv+rqrFDhhZ1zWEqMlc46R5cVvq1FwRB927hGDcUIHFE09mdtalr6//en/8gIqUILc
         I6PDe3a6dhEb+M5mmBNVcmhWy+A9f2KOQ3cjv4p30BUXKa6C13C9bpuOZYtb+LYiQrpb
         GqRXf5hrGK6ZweEtSgoV6XRqHsq+acdIb+1NiNvdT82lAD5cbx6anf14porOfX2ztoaX
         nQIWJOrsbJyU8XduM5YQPA4mcqgyDRDsgT7GmFw3vESLKRnrZZsbKpx7fRB3kQ8FEPvd
         dHiSGNuHMs7S+7dLoxehXxlyh4P5B4XpnvO11PeGwKu8maBUUeaUtnk0j8KJ8nlAzIGI
         3UmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211117; x=1758815917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWwPXk3+CMDIY3Ii9TMDH0aQbdb6ssOVOtszqmINL5E=;
        b=Gr0vKYvJwXHt7LGl0kRduRmsqQdsHxx9pzKZF6ym0CRUeS5E5YyNUxmRfmRBWpIQMU
         bJhA0c11bHqTtzKEDWD82zW3qXrMsfJ0AY2UKCV5FXURoapHlf3d+5JEHDWEMaXCyzcF
         kx5jEU7DInpK3jFzCZ5/WUhgbmN/76Tzqzrv4yRDjahQvcUcn0ImrS8O5zBbgNJh7/kV
         dPOsEhgvcrq4kkOtgJ/A55yD47mJhASMPXGi/h4ozBkYlkbcNcZifFKXjIDX2p1NA1Uk
         fLHOjY9TGm2cO4WOoOyFJM4BbgHf/qXyHhCPNXVVJDr1Pt13jt41cPEf8579sF4DtJFA
         9b3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2lf5uoBcu5ZvRF4njFFgJoE/IIrh4/vERTFjh0AMV2abkKOa4MVMxXlPovUUnVhHR/RtxG/56DA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0nAoHfv8jfW9QJLCf+8q/xcx99wIawkYMVZAc1mYGz7SFf9G
	e7FngcddJqOOJWXbNIHoO+uiL+Xx5ANODHfyTd+daWqeRpY5fTMGnAVR/ZdaB53SjRFJNCUD0rQ
	QTwao
X-Gm-Gg: ASbGncsD3pPVYrHV/CTM6HwcBOA8uOQk+YK0et76mILScBD8nSNdmtzCS0HKp5vEnTp
	Q7Dy8HX5lF0Jb9McarA5Xg3bEnMoLQo8MztGUv5KjY4TNM8C/nZJsmQDvRJYMQPH4H1B8584kRB
	g8h4Vwrv8BQPxhhkRVu4fHQb9lJSj5kXtIzq9NTmsMGFeIzWiJd04xBrq9QLk4RMjEVklnNG0L8
	sE4nj4+qDyIXf8KG9/HZrS3jScQOugZwZhVGqJ7xY9gs2dJMIVn8K7Qbq+k91TjiZ0gGjWKMDwY
	9/TxwmLNTgqGHAd0xhT82bFF+Q42xTAR1gcBKC5O/ZyHg4pHEXO8bDxXEsVIWwkDGLI1nJxEXkb
	RvoTBik8XgLNgPu1mJFTfF/8BDg4CcRW94G4LurA8lcsYHBRCTj4hVnUrSpR5a1wZ8bMnc76+zz
	15Zpcd2jBoclKqRA89
X-Google-Smtp-Source: AGHT+IF7L6Nzhpq00zRjUOtUlsvmOyj8YvPWYBfqvWW1/q2pHZGHXZWCIyaJ4bn8yb0d408EYIgLfQ==
X-Received: by 2002:a05:6e02:b48:b0:41f:8265:4100 with SMTP id e9e14a558f8ab-4248199c677mr962075ab.18.1758211113083;
        Thu, 18 Sep 2025 08:58:33 -0700 (PDT)
Received: from [172.22.22.234] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d3a591637sm1058871173.15.2025.09.18.08.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 08:58:32 -0700 (PDT)
Message-ID: <000a41ee-a099-4944-8ef5-eed768f905cb@riscstar.com>
Date: Thu, 18 Sep 2025 10:58:30 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] spi: spacemit: introduce SpacemiT K1 SPI controller
 driver
To: Yixun Lan <dlan@gentoo.org>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, p.zabel@pengutronix.de, spacemit@lists.linux.dev,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250917220724.288127-1-elder@riscstar.com>
 <20250917220724.288127-3-elder@riscstar.com>
 <20250918124120-GYA1273705@gentoo.org>
 <034cecd3-c168-4c8d-9ad5-10cc1853894b@riscstar.com>
 <20250918143928-GYB1274501@gentoo.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250918143928-GYB1274501@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/25 9:39 AM, Yixun Lan wrote:
>>>> +	virt = drv_data->ioaddr + SSP_TOP_CTRL;
>>>> +	val = readl(virt);
>>>> +	val |= TOP_TRAIL;	/* Trailing bytes handled by DMA */
>>>> +	writel(val, virt);
>>> I'd prefer to do like this, it's more easy for people to grep..
>>> 	val = readl(drv_data->ioaddr + SSP_TOP_CTRL) | TOP_TRAIL;
>>> 	writel(val, drv_data->ioaddr + SSP_TOP_CTRL);
>> This is an idiom I use to make it very clear that:
>> - The address being read is exactly the same as what's being
>>     written
>> - The value read is being updated with bits/values
>>
>> I find that putting the "| TOP_TRAIL" on the same line as the
>> readl() call obscures things a bit.  Like my eye doesn't notice
>> it as readiliy somehow...
> fair, let's put it into another line
> 
>> Yours is a pure coding style comment.  There are two pieces, and
>> I'd like you to tell me how strongly you feel about them:
>> - Using virt to grab the address being written and read (versus
>>     just using drv_data->ioaddr + SSP_TOP_CTRL twice)
>> - Put the "| TOP_TRAIL" on the same line as the readl() (versus
>>     having that be assigned on a separate line).
>> To me, the second one is more important than the first.
>>
>> Let me know how strongly you feel about these and I'll update
>> my convention througout.
>>
> I'd strongly prefer not to introduce 'virt', so be something like this:
>   	val = readl(drv_data->ioaddr + SSP_TOP_CTRL);
>   	val |= TOP_TRAIL;
>   	writel(val, drv_data->ioaddr + SSP_TOP_CTRL);
> 

OK.  I'll do it this way throughout the driver in the
next version.

					-Alex

