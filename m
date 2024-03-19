Return-Path: <linux-spi+bounces-1895-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10A87F712
	for <lists+linux-spi@lfdr.de>; Tue, 19 Mar 2024 07:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7CC1F2246F
	for <lists+linux-spi@lfdr.de>; Tue, 19 Mar 2024 06:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E04245C12;
	Tue, 19 Mar 2024 06:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMYeApRA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0194594E
	for <linux-spi@vger.kernel.org>; Tue, 19 Mar 2024 06:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710828258; cv=none; b=jrggDaSTO0p+ITybzDGXl2H7Ji4xHanMKX53XlpTNx/NK48BrQUb91f+YkgjovJf8tCzfyK3orakorXoYtUc0NB6nF04V5zc6s5/WVS8TlWB1xhHIJgfGKOk/VxlRhn+4GIV45g5+Vn4MrFpAhu6errLDqkBWlHJ7g8uBPsZEaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710828258; c=relaxed/simple;
	bh=RaGWmdsuO4LbZ2ZGyuKnhC4jDVUu4GNR/Eqn2VMxgLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tb/u/Mf7/GRJb0Uy8HmT3Kz/ywAOFUZLNoSTCyNP/nND5Rm9jUK6jHQ6Ff8KDu3XdiYXbbCH3w0OU188qUu0GByt8wx7YJNHwhAvgqhbhyTVI70gWjKHHaohAH9Q5ES28LeZom4nmvwHpU8oXMjCJhMOJ6m5SP1QVYwjSJbrOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uMYeApRA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-568c714a9c7so2807467a12.2
        for <linux-spi@vger.kernel.org>; Mon, 18 Mar 2024 23:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710828255; x=1711433055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XN9i1oXl8g4MhXfxTvu7RILQ82FANbsK7LyRVnqDJpo=;
        b=uMYeApRAvUQcsFYzQW692Aw3/aH06etwovKgneVewSWDNF+JYwwFSQZEvk0GCTa2Od
         izJY6u9Ol9AcJCPa+JwYS5wmBcQxF5fUf2UfG3KHxyUJ0miMaaNBD2eT3lazgIXoLAYF
         YLV8rh7/fGtsq4M3SACxP5OdvAygLhFTw9JVUE5iXAbzLK+1QwyrJ06mjkmtQIynU6mS
         ZI6ztcLdaWnI3XoYQcIHsqbCZthzk14ob5bdOgnh0DBST/VQBRW0JICVUTEWMwK9pqyM
         oTyQQuIp8LaRuntjz3uUl4ms5ac5cETpL2OYJYkXV94gg/tRUyk4hPEeGTiaqltvL/mk
         0Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710828255; x=1711433055;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XN9i1oXl8g4MhXfxTvu7RILQ82FANbsK7LyRVnqDJpo=;
        b=pJMLUIk2Y6mMsF0CVFmyC9jFwilFsCzbf6dK9bDIDpZyuJtbU48boD/WocEzUOVsPy
         1fjFS80F3JuS+UfzGdRPzmTw+EKbQ7N+wlY3yM467K/lKkK+9ndGk8GxV4DJUH5Pftup
         PiWgJJVQnFiSagoAhQ5jJM9xzSsFIEj+admDLqbZco/n/r3IVTIlv12MAkJoLykr8AIT
         tXSBTq6tGoV0xwIF6mRIGDCh0xOejp+QAwRo9/uN9recEYoLu8BMAj1RQc6RNGyEvfGT
         KY8aio2iEqcbxlqbNm1tpqOupjmFsKwqtgF1WAw+9/z2Tceri2HwAv+mDxHq+HPhm+HN
         nStA==
X-Forwarded-Encrypted: i=1; AJvYcCWmd/ybHIURdJZGagJQOnN54KWIpkamRN+k9UVK2cXpMBGWJgzxZ6B5shTnGKw0ehQJNr9S4T85uWYfQUBmXQ6bY/eOB6ja5w9a
X-Gm-Message-State: AOJu0YxbvvavcBBLKQogzyG0I6Jtbw8nBuqS7w4KPzMJSlIl6IiXCbjL
	SSE5lkoMKQdTW+dkVgQ79pfsum2n3cGEMgfsEFhXDcXexdKNIJn+kai99lu7bpk=
X-Google-Smtp-Source: AGHT+IFwPRCHuu46nmzj2xnoI8uFZMuticqgL9nDhk1kWyWTLUjAErZx9E3AtHC1qghXl7LrGSqESw==
X-Received: by 2002:aa7:c356:0:b0:566:95e3:1759 with SMTP id j22-20020aa7c356000000b0056695e31759mr7929906edr.26.1710828254954;
        Mon, 18 Mar 2024 23:04:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id a89-20020a509ee2000000b00568c299eaedsm3347638edf.81.2024.03.18.23.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 23:04:14 -0700 (PDT)
Message-ID: <06009676-6189-40b9-a6d6-66a112e4f387@linaro.org>
Date: Tue, 19 Mar 2024 07:04:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] mikrobus: Add mikroBUS driver
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
Cc: jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 lorforlinux@beagleboard.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vaishnav M A <vaishnav.a@ti.com>, Mark Brown <broonie@kernel.org>,
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
 "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
 Vaishnav M A <vaishnav@beagleboard.org>
References: <20240317193714.403132-1-ayushdevel1325@gmail.com>
 <20240317193714.403132-5-ayushdevel1325@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240317193714.403132-5-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2024 20:37, Ayush Singh wrote:
> DONOTMERGE
> 
> this patch depends on Patch 1, 2, 3

So none of your work should be reviewed? I don't understand this, but in
such case I am not going to review it.

Best regards,
Krzysztof


