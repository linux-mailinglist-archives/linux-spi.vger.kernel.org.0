Return-Path: <linux-spi+bounces-495-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 921578314DD
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 09:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249EFB2498A
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jan 2024 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65128E1B;
	Thu, 18 Jan 2024 08:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mR0tYIq6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE2C28E07
	for <linux-spi@vger.kernel.org>; Thu, 18 Jan 2024 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705566644; cv=none; b=jBH8v3vT9mmBfYCO8hyDGmzspcbCFhR6qZ9dSyYu+FVnKAZGo3r0Aha3vqHmHVgI60ZUaC3yDs+c4d8PNhXn+GRA6aScEx/mTsbRmTusqXRPBgS7re70HRynQGa3Qd2qmyty1tb/X0DM0km7SM9RQOVw11WX1HB9v2IVa06efPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705566644; c=relaxed/simple;
	bh=zGsqogSjX8RwxX3YQBriocwwXXehTiGp70VQeEI0XOI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=krFbh9wOtfpG+6kv+qzOeSF/5MD09K/KS8hIooROoOCOkpEZaglvINh/j5uM4XOBJzDTLofyvogrBZtOY+eQZ1c8ixQ3SFIvflxBvc9VsDE40jk++TevwtsDyavQyEluFK5QRc7oqrLZSmUlVR4bQv5d1e8WAfAVXHB7VUBN188=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mR0tYIq6; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-559edcf25b5so1376515a12.1
        for <linux-spi@vger.kernel.org>; Thu, 18 Jan 2024 00:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705566641; x=1706171441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGsqogSjX8RwxX3YQBriocwwXXehTiGp70VQeEI0XOI=;
        b=mR0tYIq6/LeZ2qvJeP/usqHk9xJHxQFpjhfLJKV02jfo5wvQxBHS0xd/MX6/d3ljRQ
         g6r/HT2W84yn+MMkoJ+1rFJTMviBp3bbnBiK0mz7xN3DGm4EvuJqzq7Z8rC60+0i2IeG
         M6Jq8ZIljh+6k52WFFKJfpLKEEE2RcQVQbHWa3PdWjSPut4FqzwA8hWK69Yc04fHY8ZO
         QszdkoGU10aIsffxuY3EZCbZVrxSJ3qNcNjmFGV5uE8Bbt25VYj1q7Z/4TaEXirjdvhS
         3R+SWX8ObpOo8nqlfgNokQ8LqmPOJJs9d24FZv1tt9Nvpxxid4M8bkqRrM6uyg61QYaC
         MVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705566641; x=1706171441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGsqogSjX8RwxX3YQBriocwwXXehTiGp70VQeEI0XOI=;
        b=PkLpqkFd1XmnIGuNq88m9lBUKQ92WVu7Ib4eLBJioYoWg3JnCW1w5unHXi/HYJlAlI
         Oi1QayH9rABTUj0D8dTIou2CecwCeAracuNVh++TLLNbjrO0YxICN4naIR9V+8wk9vAD
         bpX6+IpClfU3apSclGaAdXqDBLjwD4sAXwPFStXkMmxNHkFcUc2YPPlZBa95dcks4J4U
         rTamhjpO0LWA/D+bwsQppxUhyEQts8TpxTFkBDswze6S5r6WIW/I09/UClOgTwSks6Sr
         FVfU2+N1trlWF4OQjX9FnnO9ED0peYsd98hv7pvpKJArBWRC27wYd1X9yoG4Ady259P2
         3mxQ==
X-Gm-Message-State: AOJu0YxJNqCuDX+hWqmS/DMaIH7rwmaY/pocnEsOp5CVyrYGusd3PC7y
	OPpgEYUd/vwgVv4w9Ky+Rp9eq3B9Z/w2+FJE83Z2PY+xAyJAoSCqK3BQz/jmKLrliVJQcBGCAyA
	Z58A=
X-Google-Smtp-Source: AGHT+IFDlUL6/pImYiJYx1SRljxT6BSIWyOxpFBuN38G/ZzfIuH3JjhTnmtNKTIA83MqE2HaFO2jzA==
X-Received: by 2002:a17:906:ad2:b0:a2d:5392:6cc0 with SMTP id z18-20020a1709060ad200b00a2d53926cc0mr300555ejf.60.1705566641093;
        Thu, 18 Jan 2024 00:30:41 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id i16-20020a1709061cd000b00a28825e0a2bsm8789955ejh.22.2024.01.18.00.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 00:30:40 -0800 (PST)
Message-ID: <f0a9f2af-f737-496e-a1bf-7758826089b9@linaro.org>
Date: Thu, 18 Jan 2024 08:30:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] spi: loopback-test: add elapsed time check
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
Cc: akinobu.mita@gmail.com,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 kernel@martin.sperl.org
References: <1489774651-30170-1-git-send-email-akinobu.mita@gmail.com>
 <1489774651-30170-6-git-send-email-akinobu.mita@gmail.com>
 <4f097d14-dc7f-453e-94f6-96ef568e7770@linaro.org>
 <e3db65ab-be7e-45dc-9104-fe2a3b046b7d@sirena.org.uk>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <e3db65ab-be7e-45dc-9104-fe2a3b046b7d@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/12/24 18:37, Mark Brown wrote:
>> [ 6748.913400] spi-loopback-test spi13.0: elapsed time 532837 ns is
>> shorter than minimum estimated time 82240000 ns
> That's a *very* substantial error, it makes me suspect that the hardware
> might be doing loopback at a stage before it actually clocks the bus and
> doing something like just connecting the TX and RX FIFOs.

Thanks, Mark! It was a problem on how the clocks were handled, I ended
up with a higher frequency than I requested.

Cheers,
ta

