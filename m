Return-Path: <linux-spi+bounces-1887-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D887EFE9
	for <lists+linux-spi@lfdr.de>; Mon, 18 Mar 2024 19:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A25DB22A0A
	for <lists+linux-spi@lfdr.de>; Mon, 18 Mar 2024 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7CC25774;
	Mon, 18 Mar 2024 18:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="dMjyIKml"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5B8535CB
	for <linux-spi@vger.kernel.org>; Mon, 18 Mar 2024 18:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787304; cv=none; b=GHILI2QpQlGw9DF7TDEw+E+8jLqoc71eN2DIwkXqD6Uav5uPzz/cOQ45hlxMk3MEwuaqbIm6ZneWH8oF2t1Sy6wYT7MTQW/ZG4nGAXEZMhKfqI0WPfmfnlmJfb9LFGtBI0wUWdqg8xb9V+SFqG0hzb0gmX7e4OYRKUAXWNMCd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787304; c=relaxed/simple;
	bh=bZ8EF+f0ojIjoq6Dr918Kh/3SPma0ywuu31m4SVF0CI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JV7zZxHGf2zgUfLx6Rwjpby0JC8Q0fOqucHs0gjCk2xpbmvU7ywa7K0bzp3TS91hoB9TGGKETmCGBUBGCDbkrgGD8/k/5GBXb5LiAkKgfzx6CO0zfFYFeM4hiYAmGcWPG1hWGVP5WABaFlkr5ZPm5ZVDpU1En/Is+SlHZJ2RJes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=dMjyIKml; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430c63d4da9so12021901cf.0
        for <linux-spi@vger.kernel.org>; Mon, 18 Mar 2024 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1710787301; x=1711392101; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2Eahz5y1g6Io4kuIZCPOk+HRz1bynd6ShyA3Ce0EGU=;
        b=dMjyIKmlDNCMZ3lNdbPCCvzpwkAD6yspleRqJAznvikT+WCcOja2js+6+xd4hX2Asx
         leNBm+qNaNjoi4eFFyY3lgfUq9YftU2FuLRAdViMqVHLM0GVFCTB/Di0/RvySj05y0pT
         tMhRFiBLl+8rxRJxkk3GFhdGISmglhkBVPnug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710787301; x=1711392101;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2Eahz5y1g6Io4kuIZCPOk+HRz1bynd6ShyA3Ce0EGU=;
        b=IQJAWgZ/TZFgmJa/LmwpnMLVLl34M4eu/16+p7T/Zgx7WLR0SjiiN42HM8U15qv+VA
         V5gQIopHKsMP3nWmQR8+NqIX2uDt9aAfgENgHnjOFGavmAOexpViNVZRL/CwYzNYQXRc
         NmsqgBuQu3yCnu11qCXpT9BbKMcdPDMWhv9pzjbX8QKuxxuuqyVJjmVGiS+d1zbgSAMu
         IF/bLQbtj+d0BYF8eWZdw0GM8mYaOR5SApBNnXWGt5n5epeVRbrUd9OaZFuImQTRtFD6
         5XeGitjX/7ivA/9+qm8t0ixzuHHxqz6krSMnzCVMtmuupwaB/hYCs2phfyZ5NFBAZhYf
         Ei0g==
X-Forwarded-Encrypted: i=1; AJvYcCVwkK3gftIYLlq8W3ofh671kzhhml1Bkb/MS1W5QvM3O9mUYuDvKEgZP800oy85oIjmqnC7hcIEv6UGUm8Py3yewIwuREN/zEos
X-Gm-Message-State: AOJu0Yzp4VwnTmE2YYDTKYTtwrkwbju5eN9Z2puWW0G9QNHCqDHYRdeE
	6JVlCvKZSzvRU/QoiQDVOA6qYvhSgcIlp8Cb83d9t/iat3COXkuzy+wjf5GzPg==
X-Google-Smtp-Source: AGHT+IGa3DaP+ZQVnj5jdz1bnLoir7DhMaL4Yu8xli/2COHN6CI/dNA/dqupLIRNhbwqIkT59FDHPg==
X-Received: by 2002:a05:622a:248:b0:430:e4ad:afbf with SMTP id c8-20020a05622a024800b00430e4adafbfmr381232qtx.20.1710787301471;
        Mon, 18 Mar 2024 11:41:41 -0700 (PDT)
Received: from [172.22.22.28] (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.googlemail.com with ESMTPSA id fj5-20020a05622a550500b00430b423f06csm3796449qtb.86.2024.03.18.11.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 11:41:41 -0700 (PDT)
Message-ID: <3eb9d5c2-149c-460c-9684-3fdaf946c400@ieee.org>
Date: Mon, 18 Mar 2024 13:41:38 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Ayush Singh <ayushdevel1325@gmail.com>,
 Vaishnav M A <vaishnav@beagleboard.org>, devicetree@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, lorforlinux@beagleboard.org,
 greybus-dev@lists.linaro.org
Cc: LKML <linux-kernel@vger.kernel.org>, Alex Elder <elder@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Conor Dooley <conor+dt@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Kridner <jkridner@beagleboard.org>, Johan Hovold <johan@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
 Rob Herring <robh@kernel.org>, Robert Nelson
 <robertcnelson@beagleboard.org>, Tero Kristo <kristo@kernel.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20240317193714.403132-5-ayushdevel1325@gmail.com>
 <4fe6f68a-786c-4e3d-b97d-847d6965d1d3@web.de>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <4fe6f68a-786c-4e3d-b97d-847d6965d1d3@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/18/24 12:58 PM, Markus Elfring wrote:
> …
>> +++ b/drivers/misc/mikrobus/mikrobus_core.c
> …
>> +static int mikrobus_pinctrl_setup(struct mikrobus_port *port,
>> +				  struct addon_board_info *board)
>> +{
>> +	int ret;
>> +
>> +	if (!board || board->pin_state[MIKROBUS_PIN_PWM] == MIKROBUS_STATE_PWM)
>> +		ret = mikrobus_pinctrl_select(port, "pwm_default");
>> +	else
>> +		ret = mikrobus_pinctrl_select(port, "pwm_gpio");
> …
> 
> How do you think about to avoid the specification of a bit of duplicate source code here
> by using conditional operator expressions?
> 
> 	ret = mikrobus_pinctrl_select(port,
> 				      ((!board ||
> 					board->pin_state[MIKROBUS_PIN_PWM] == MIKROBUS_STATE_PWM)
> 				      ? "pwm_default"
> 				      : "pwm_gpio"));

No.

It's a complex enough bit of logic without trying to bury
it inside the parameters passed to the function.

					-Alex

> 
> 
> Regards,
> Markus
> 


