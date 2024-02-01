Return-Path: <linux-spi+bounces-948-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED695845572
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 11:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42D228D32E
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF2A15B98B;
	Thu,  1 Feb 2024 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9lhmmHA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E5715B978
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 10:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783606; cv=none; b=c6v5HMxYlzdTa1U2BMuYWdN+ehOeLHJhWuvB4t8NtrG0yZs93PUFzaGxawBcGreCJv5ueLJvNGYf1X2m/+kJ9tuuCnbJLuHM8ZuGk6C0ZXQGSidGuLvwkvU6fRSQmEekvVDiz2mBr9OCq0CfChHsNhVl2gF4e1Wy18xPJSmXYrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783606; c=relaxed/simple;
	bh=GlBPwm7a5otw9EILXtijeRE84vG/ltLhBHcp1CoLON8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHS/f8VjrqgpLupJvD23toWGqMLOj30jSFo611BMRI4Qc82EEpVBd8jDCwlIOqc9Kfgt1gQURgUfr8bHsIElWlp8htsFfoOmYgjbB7pmRzdS6ArSzRXAfb3ffsx3pKVK5TmL4HNqkCZC7PA5vCBm2G3hmxJIwJ3ZJGiFN9en5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x9lhmmHA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a354408e6bfso316446266b.1
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 02:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706783603; x=1707388403; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ECjESsw4J2tVE//l68f5LRtJ/ylD5ePg6AyS02rGK+I=;
        b=x9lhmmHAVq7WsZvMoA8dYJZhAgcCPzTpaomn2iqpbZOr/3RUqv36EDNGmdoHL1tgaT
         dpVdNyVCF435QugKGC2DlPCxUiEfzH999eNBf6BTksUlz65CFu7HOxn7TjHBfz+fvEK7
         6nK5U56BJ00B26iWptzU9lXGWfNfd9c2Gypc/kuINB1GPLvp8CLhxKqtA4J9iVCDBO/i
         44YrHzKV97U5LNWSeAVsSNZuUwBz+eCJY1QMpO1HGIYKUmmCqCJuUK8QdZoZJRgBeFsG
         e08eQt5Gtv9m0W+udH+o5cRxAf9VBQQUaWwjZONZMemz6uQiUbejmFLE3tqoMGkTO+Y5
         JRAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706783603; x=1707388403;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ECjESsw4J2tVE//l68f5LRtJ/ylD5ePg6AyS02rGK+I=;
        b=GC1F5JYh6q9NfM3eXSGFIu5wLoXk3D5J3XuFADxw79mucyK3GL7BgSZVp8Ig5EruU8
         Rd3BNQrJtPKABaknbVuY9OdAhOuefatR0qRMnVQXCRfYOckdi38RN1L7IFkfUEonPSaE
         k1SGY227eoSkv3Uzrm3KCxOIVT5kzML/c7/npjJ+kkAlHQbel1Ay7kcp8IxlLdPmT3VG
         2kta0s2gSoPSqvuEKBoam4fuNdKKtI5UsMdjG3DbQq44x9gqclYfRARHnD9ThzuiLzoq
         v8LsREG+yd2mrTIXnTcdeBWXg6rtKrQC2szrlzRKFifhwZhqGJsjCsOY//5MJf0icWUy
         bfrw==
X-Gm-Message-State: AOJu0YylqnAlgJ8M2BODokTaJTTehjMQnZWPQg5I+zNOJvaooI0GpFzO
	qTpqsWtus27CafrFektoV3WuMlI9+5xt+5SQwJvOGbQJ1/TGrZYlWMD1Di0+W+Q=
X-Google-Smtp-Source: AGHT+IFnq9gdrGw1N+h4fc5CMzAFuTkrsk1hTTJUDQ0wAy7ue+Ozc+QBh5QWfDyNdBUw8ExW+tZtwA==
X-Received: by 2002:a17:906:4e88:b0:a35:fb27:2e38 with SMTP id v8-20020a1709064e8800b00a35fb272e38mr3893798eju.34.1706783602193;
        Thu, 01 Feb 2024 02:33:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXYO2Dxpk1fDxl7YfeJPV5r02NbvAmQkySo9eau6yDxSoKDerlRY3HIC3HFjCuMTj+fVbtP+v4AmMGOSEIfaUnkgtc2UTo9Uf/XQwJzJa8tnCyYmBNGPu+TmBqL+mK4V83epY+kRAEZ/VdXl9KX5Yg5V+BjVsMwL5QVRW0xBWPshwVDszzgkMW2iztYSgTobXR9wcxZVuyo8T/07R2CewJ9Z9M0Bi5Dwwlpcbqi6LdGh8+EfFosr8ZXXA+rKX7wTxCMLrSAJRZXivrBglNYmIVL4QEPf3fYtNQTNz8QF9+htXqGgV+zZxFuISRQa+TEoedeuYao19xWfKnHz1B7bvLi106bzm2bDNlhUXxvb75+oLhjuhVufwknotVCiJwLtjuZDOby+8GyvFR+ER/XJ+rkKpfilThIQpyv7P6AO5RPT5W0XdY2ZsLvTLdCTbp+NCuIdjeoWgJUEv+sL1jMH8CSOfuMufgxzuUu+d3VhLphU/r/DIKtWBnlaPQ/qZgzNXExLAOB0Nv+ReP7JoBNmGV/KRyrcY/1u0H3lzY47obSRl22PY2dBkySz3K1R5c7pHYhq/g=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id d11-20020a170907272b00b00a360fe9a7b0sm2888875ejl.23.2024.02.01.02.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 02:33:21 -0800 (PST)
Message-ID: <85856b38-e42e-412b-b201-ee2798722f67@linaro.org>
Date: Thu, 1 Feb 2024 11:33:18 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ARM: dts: samsung: specify the SPI fifosize
Content-Language: en-US
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
 krzysztof.kozlowski+dt@linaro.org, broonie@kernel.org
Cc: robh+dt@kernel.org, conor+dt@kernel.org, alim.akhtar@samsung.com,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, andre.draszik@linaro.org,
 peter.griffin@linaro.org, semen.protsenko@linaro.org,
 kernel-team@android.com, willmcvicker@google.com
References: <20240125151630.753318-1-tudor.ambarus@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240125151630.753318-1-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/01/2024 16:16, Tudor Ambarus wrote:
> Hi,
> 
> The "samsung,spi-fifosize" was introduced in the following patch set:
> https://lore.kernel.org/linux-arm-kernel/20240125145007.748295-1-tudor.ambarus@linaro.org/T/#t
> 

Judging by Rob's statement the bindings were not accepted, so I drop
this series for now.

Best regards,
Krzysztof


