Return-Path: <linux-spi+bounces-5120-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E62992EAA
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 16:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01CD62851ED
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9CB1D79B3;
	Mon,  7 Oct 2024 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SudSl63Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1DF1D61BC;
	Mon,  7 Oct 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728310598; cv=none; b=S5kWpIypkOHzCqT0TPM/xEHiIhFUD9El3LAoH3xu/E3cw37Yy95//Umplu8+ajIUGiJ238RNDkZzBAFad3DREyJOixmoVz5Alk9Gf13Ib7ghWNuYulDesnk1iJkHyTpdu2WEdGIJInibbsymrBUEjQCJNhEi+eXehvA+c2sJno8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728310598; c=relaxed/simple;
	bh=xV3HnEnY4Z3mtyPR63z8fPc7sUYywg9jaYruN4AJlh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECHo9NEpdR/b4I6WtIdB/W8aJaKBsHy565NJS7KB7dIb6W6MdquPTUPKbbwzLiuVhieookqTT18rF/O0+Y8HcPeLcqcqNpQO2Fl469UjRrwH9/PanMGtRdyXGHQGUNYfYqaUUB7OBCJwCjbm8BZzQwJfMMR6fjHF+bAxbeiDCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SudSl63Y; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb2191107so39791695e9.1;
        Mon, 07 Oct 2024 07:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728310595; x=1728915395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nqBERla7cNT4lhQEnVIR6EnNAL58omsDr6jI2Hs2sQY=;
        b=SudSl63YLwI1yqVRlbjbo8YIn8G9F5AVke4M0FdC+T+AfYy5KJ8W8iAI213O6Yslj5
         enQD5uD9nM/TG2YHujvbdwlk9rAkyQiS4wO8NJ3Pcu5gufdbQryc59aBfWohIg8HhQT4
         CSA02fFQ+hVW6aIW5hUhBrfkNKnzFucGSSJ8b2Xjm0+MGumU1Xjue2hs4dHMEWcvvboN
         JfYHaV6i9K1kWrIpX3wYQfYxtO7wL81yTI8ouMyZW4RtibJDFO6gClnIxHdQ5Fu5JnZu
         wsNaCpceu5UtDywdOrt+Bj8OX3YXAJNdn31Q/lCEzK96jkAJ++dJoMZsstVfEXdtF3iW
         rM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728310595; x=1728915395;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqBERla7cNT4lhQEnVIR6EnNAL58omsDr6jI2Hs2sQY=;
        b=DARAAIwrNA9kzwoVx2V8Tqd25weNbkD8ry4b7bHoe3iPerHLEqs1317jLxtx+ZAHil
         bhzJ0KiBKqIFdMtLVtaS6jhpJ2Om2vm2NDOyjERugMZ8Gv4Rl3+7dq6WsEYL3Ogfo+ks
         awa65fNkuvhuN8vA5Mf0LiU6b6BdariKiW62IZuSbylIUF51Fwd6q6nCuhLAATfOMf0C
         DCFohS2oipFi4b8dOS0PEy+3jnbRBTkQ106FE3JcijJVeH7GhWJirbqMUAnhJeXtNVYa
         8ELk7ba/DrmpmMiHgdnQeTw0Z3ytchRsSwg0GzKsqIH0TwyEULuojeN0cZjWwCtr3tUZ
         I1mA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Tg/ltPcPRvGOqT2pxTIhcREz9ljfTZys8JCRt6RY8T4hCUolphQVNHgOhOz3paOJv2XLat5Gj/t/@vger.kernel.org, AJvYcCUuyFR9eIO8B7VRrBaAELNtGmecyEQaQSuFMlD3q0vayXuf/yM4GwX7dnFUDIQ3C6xNE4lAA8e4QvGO@vger.kernel.org, AJvYcCVoFKGoyyWK65r4OjY7dCPNItPmvTJgqw6rUAXGptCgsbH3jMp3OgZsK8z5XqnFQphVHXis1f+UstOkDAZ/@vger.kernel.org
X-Gm-Message-State: AOJu0YwAzuOkudpPuD1y//lTQBTHdYS56H3WimCSMQEOl4jgJP3L/10e
	DdouYtkxx0hWbW/vAi02NUVjtCScKILEU5ppD4Z5tN583vfFW6PV
X-Google-Smtp-Source: AGHT+IEz4aEeV7QpqFysBezbHUdc56w4toBz8Fy9xUMFwmnvP59awFl/7fFjw2jZhM+HWsEE85VRsg==
X-Received: by 2002:a05:600c:4692:b0:425:7884:6b29 with SMTP id 5b1f17b1804b1-42f85ac1168mr84385255e9.19.1728310594413;
        Mon, 07 Oct 2024 07:16:34 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.162.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86a20393sm93428535e9.12.2024.10.07.07.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 07:16:33 -0700 (PDT)
Message-ID: <00894b3b-a79f-4d6f-bdfb-249535901e00@gmail.com>
Date: Mon, 7 Oct 2024 16:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Aw: Re: [PATCH v1] dt-bindings: spi: add compatibles for mt7988
To: Frank Wunderlich <frank-w@public-files.de>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Wunderlich <linux@fw-web.de>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Leilk Liu <leilk.liu@mediatek.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
References: <20241006102740.17948-1-linux@fw-web.de>
 <kmzl5zmqqudoq2jcdacfsbwq3axdvcml4m5kw5oqqo2hj6iiuq@xzeg6penuic3>
 <trinity-5ceed296-8a65-4892-b449-6f832a978d69-1728227502700@3c-app-gmx-bs41>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; keydata=
 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
In-Reply-To: <trinity-5ceed296-8a65-4892-b449-6f832a978d69-1728227502700@3c-app-gmx-bs41>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/10/2024 17:11, Frank Wunderlich wrote:
> Hi
> 
>> Gesendet: Sonntag, 06. Oktober 2024 um 14:48 Uhr
>> Von: "Krzysztof Kozlowski" <krzk@kernel.org>
>> Betreff: Re: [PATCH v1] dt-bindings: spi: add compatibles for mt7988
>>
>> On Sun, Oct 06, 2024 at 12:27:39PM +0200, Frank Wunderlich wrote:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> MT7988 has 2 different spi controllers. Add mediatek,ipm-spi-single
>>> and mediatek,ipm-spi-quad compatibles.
>>
>> Why generic compatibles?
>>
>> These are supposed to be SoC-specific.
> 
> currently i used the compatibles used in SDK, but got info now, that there is some more discussion needed with mtk.
> 

Ok, but please don't introduce generic compatibles. We prever SoC specific ones 
with a fall-back (to a different SoC specific one).

Regards,
Matthias

