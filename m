Return-Path: <linux-spi+bounces-1933-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05BE881162
	for <lists+linux-spi@lfdr.de>; Wed, 20 Mar 2024 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D491F21E8A
	for <lists+linux-spi@lfdr.de>; Wed, 20 Mar 2024 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA76F2628D;
	Wed, 20 Mar 2024 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SV+iURKF"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4593EA9C
	for <linux-spi@vger.kernel.org>; Wed, 20 Mar 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935801; cv=none; b=FfjuLMMYq9jIYsjYzegzGpj4FslUR8gn49ym+em/RzLyabHkrMxzXchKN2PMmH6IWLpu1ePtZHktF0Yk/O/3mQpbLvH59xANqC5+v0QZrVyfEIATBVDy3X/EcXkDuaHraSGBTZW4ZZ0kGzmNw6+BfNMSW3z/F/O7+hbQVXsyPJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935801; c=relaxed/simple;
	bh=u0ncsvEOk5fTHYo26xFtqy72C82DS5xylR97h7UnQMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZVp0Fc4Gdz51LF+WMOdPJ6XBWUvjCKc7rtqruNmx/hsScPAh0FlNdsNIWx4wLxoczHdF/6a9t7GiDpj10fdWoAXtplld6rNGtC/baxa6PgbRPSTLd1YWNMGKXeqCLAegSVva9s8//KeOB8B4Bae1Wcr6DTGrv3+dw8F15DVJkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SV+iURKF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-568aa3096e9so1412543a12.0
        for <linux-spi@vger.kernel.org>; Wed, 20 Mar 2024 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710935798; x=1711540598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=FH7W+XVPP1mnMok1Pkpdeu03frvaBS4E23k4mFfPidA=;
        b=SV+iURKFaJLS6Zlu+nhXmpCkw0K0BQAnNJRv9vqhYxztYXRuaT/UnknZUCdt8ZPZt6
         d8JVkNdIurqvNbhwo5XfTy+3iN0e6jeBTRczqD/n5NvMvs4NMe0TzTnJFemtanB27M2+
         EIE4+N7Z//kMeDkzpU2LsuXulnA6k1+sLtWFudkXMscPtxoMxlWWBDrJXxW/OUZOd0XP
         boUepnG9XETP1AulZbJJW1GRjKFU6CKE5NEIoQ69wyz/cSLZRtXVfIX81Jxr1OzuFZRJ
         +iPnwL1112y0sMZV3YtbPQ44dYzoiL1JGbvpEH2kb74Y60guLzNsvZHdggL3IPmuRkJH
         fgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710935798; x=1711540598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FH7W+XVPP1mnMok1Pkpdeu03frvaBS4E23k4mFfPidA=;
        b=Mk57i1lPx3EX6Opw76LCoqNjrhg0Oj/T5Iq9jLjDMMy749v5mlzEiNNjj0aQoV7UIT
         LdXjQCOuoV4MOxxh5uEnGpLUhRLXHss3nnyRYC8eIyeaCJ9zVmAx/H7TSK+IbBqmdU3/
         Y/WsevkhWvC6JrID4IZAmGAGTEwNZMsrqLgtP/dV50r9MEowGHtFwcvNtAy/cWltSvVJ
         KN14efUt6vVpZDDLvJ+jCsw2e5v+fI/bahBuPBpKY7H8hF2ZEhSt0P+3oIFispF0bjCo
         rlxTtD8LN1EZ9PgEbs9030Rh1L3+Oq48x4FkD8kzRq3MPwUJSIkKS04khVSbuWHmLY77
         25wg==
X-Forwarded-Encrypted: i=1; AJvYcCW/zi1XWHvqk0GdnMY5JncxUMiK/gHhb6BnlaIfFIG74ymK4r88uheBfQldenfZsTltH9tvlMIL/w6Q6OApz3KJa4nbXP4uwvmm
X-Gm-Message-State: AOJu0Yw2sto+iG3WtPc9aOd/gBvFrU2IZWjrTQeKYYYKtAcbxLROrlgz
	BZ020Jp3QXa9CLQoZBIS94gXFIxd0qRZVOWr30x4D9TnqXW1EN8oOY6JfCUkp08=
X-Google-Smtp-Source: AGHT+IHXaB8NePf8kEDF74mZix6FJCLLunouDd0t/YTdjPNc84shp0nT2pD8txliKnB6MvR6X7W3qQ==
X-Received: by 2002:a17:906:4f03:b0:a46:301:dd98 with SMTP id t3-20020a1709064f0300b00a460301dd98mr1995254eju.13.1710935798158;
        Wed, 20 Mar 2024 04:56:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id w17-20020a1709064a1100b00a466e772597sm7311046eju.177.2024.03.20.04.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 04:56:37 -0700 (PDT)
Message-ID: <12c2369f-310f-493b-a090-0ba7aec98b70@linaro.org>
Date: Wed, 20 Mar 2024 12:56:34 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] mikrobus: Add mikrobus driver
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-8-ayushdevel1325@gmail.com>
 <8799b216-57a7-451b-80a3-3d4ae9693e0b@linaro.org>
 <402d1296-0a0c-4f85-a096-be7993869f94@gmail.com>
 <81d55f10-c538-494f-8274-6ea8c4366ab2@linaro.org>
 <28a5e314-30ba-4fc4-9228-51adb63e7aaa@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <28a5e314-30ba-4fc4-9228-51adb63e7aaa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 07:59, Ayush Singh wrote:
> On 3/19/24 11:02, Krzysztof Kozlowski wrote:
> 
>> On 16/03/2024 14:06, Ayush Singh wrote:
>>>   > Are you sure this fits in Linux coding style limit (not checkpatch
>>> limit, but the limit expressed by Linux coding style)?
>>>
>>>
>>> Well, I am just using clang-format with column width of 100 instead of
>>> 80. The docs now say 80 is prefered rather than mandatory, so well I was
>> So you introduce your own style? Then consider it mandatory...
>>
>>> using 100 since I prefer that. If 80 is necessary or would make review
>>> easier than I can just switch to it.
>> You do not choose your own coding style.
>>
>>>
>>> I will remove serdev, pwm, clickID and send a new patch with the minimal
>>> driver and better commit messages as suggested with Vaishnav. It is
>>> important to have good support for mikroBUS boards without clickID as well.
>> Best regards,
>> Krzysztof
>>
> 
> I mean after the whole discussion about 80 vs 100 column line limit a 

Yeah, and the discussion was saying: use 80, unless code readability is
improved by using 100-limit.

> few years ago, and change in checkpatch behavior, I thought 100 was an 
> acceptable column length in the kernel, but I guess was mistaken, and 80 
> character is still mandatory? Not sure why there was a change in 
> checkpatch and docs though.

You mistake checkpatch with coding style. What checkpatch tells you, is
a suggestion. It's not the coding style. The problem with checkpatch is
that people do not understand "why" it proposes something and they
implement its warnings literally, thus sometimes decreasing code
readability.

> 
> Regardless, I have switched 80 in the next patch since it is mandatory, 
> and I do not care as long as I can format using a formatter.

Please use wrapping as explained in coding style and deviate to 100
character limit only if it increases the readability.

Best regards,
Krzysztof


