Return-Path: <linux-spi+bounces-9496-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B49B2A24D
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 14:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E5216A344
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 12:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88C53218B9;
	Mon, 18 Aug 2025 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uBlo3dze"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03E121ABAA
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 12:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521349; cv=none; b=B3c4+GSvOyHZ1HANKH/LQKslTDBfXR1uDyDyIN6yRG8qgyGfC9bJrXtGZ5n0u5sEA5O7wo96yI/KsBSe4p8ufrPrrVo476TboBtNxCvzSZx5nOLX/Ih6p6fQvD24gZJR3INqLQ1QeVG9z5iSV2wC92RTm4dbbUUaH/IGVWYEwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521349; c=relaxed/simple;
	bh=d/4oiYyxiS/NnOCFDKJgaU0KOYi66W2tjgszeyBpESw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7FKErxOfm3tQJ4FQQHE8Yl5BL9AoYkQINmxLClIKswZ8ymozMtWuwfpLXGrLMHhY14COrhMocsfNkZDUmYANltMrZ4b/N/D+If9nyghXK2iyHdF1aj62HCG8Y+kBpRyCX0xMuIWv7rWzX3GITBeIYVg6awt3yUoAJokOjtNSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uBlo3dze; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso32965445e9.3
        for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 05:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755521346; x=1756126146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UkGm5z4Z3MyJok0lbrc3ubgHxilQJm5hDG20AA7nHys=;
        b=uBlo3dzev05qb8F2TKJgu9wUu5lEdmkUHznU4Pqx2bOLVhfurMdAAasdfwnA7S9bg8
         v6plhCQZSmfCXF+m9A1JkhbB/s+jNCnu7lUrFpQlnTnfB5ABfm0yjnqiH+YkXiTeM6uE
         cNdZU6UxBVj+eAixzrru5oDVbzjm6HoT7OT0exmmMhDoH6aws4EFr1NxPeiIGJ65xt1w
         fvFyWgTywvljGodUV0FEG1G6ypluDYH3Qo88zZ/P4VqUSYU2TIhAGI6oESqxMY12vG3D
         5OVZ9lp0qbV5zpo6z0/7QUDzilrcFyJe+dXT3FSORagm3YU+hQoPQsEhBxEbimWvvkdP
         rzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521346; x=1756126146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkGm5z4Z3MyJok0lbrc3ubgHxilQJm5hDG20AA7nHys=;
        b=S/8CuHbf1h1UGRF+lsWmMBnllQJMN92sk/bMzaX/bZQ24ainhDdA6FaDFSrGF39xl+
         tgJ31emQn1abvIcPaTBuL/9z77uJ7K8gE69AW0yLJ4GdwQmZUQZzOu9uWWdrd4ntEtsA
         O5Xed3xH8X/73Xg7hqMbAVwufkucNJEJTfG7DWUGQP80g6X2WwC8qMK9gfTXvXK8kRlF
         DkSTey+Z6gMtS1u/KxTQeJakhCPBEk2SpLDW+ypiMMEmDiEbYC5j1viAE6Bx3mYuG7+V
         CZCtGJFGMU6tihw9o17UhURIiD7sz/3Zdy5FZsctbl7kF7rXm1YU+3QsgBaOExV2K+mt
         48uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzYOwftYxq4isYy8CFZGYRZKz2VS9LT7sYexYukhUi+ln7IKiX8Sy2fmnmfr0vVc2MzEM5qYjHBIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxngCaYgG3ucR6uEbbxELxG9wGGOAlC5/qN+iaT9/rKj7l5cTRN
	Eu68ytZCvaqhWEl19Nw2EdeYjI3pxSmeNKDYGYLIoaOMf0Bp3c7lltFRAhKb/W8D72c=
X-Gm-Gg: ASbGncvwNOocWkvlXA/Hd7aUF6vCJPaC+aGSNZGlKtM+bSBxUFf0QRbuRl8N//xipDf
	HloIrrnyGR5XStDYhPpUF+B5YyueBzbqErX1BAbe/Tueo/++U2bQ6hpdlbkp8EJcKV2Gcp5MiB0
	OcUBNkx3xZs17vjVwCW/U2SLMknewEX7aZ2TQcNR2rG0k+yVnGCrkeVCzikKUo0SUsJY9PABHtW
	Rp4RlIX8f24SPPyayZ48bMVzSnv3AdlnmU3KjEPR+BwpqrNh0EiIvNJhZyjsbOtc7tqYMOiUCjM
	J2D8lt7wBUEJq0g/FTP7VAk/Zu66jtOfPKtw2nll1tCx73nCDlL/PHygrzJYIC7kQjfWl8UWNUi
	JGY18UfICyKQ81etREj1KNWeDv1A=
X-Google-Smtp-Source: AGHT+IHuiGcAUnMgAsUaVIlfjKsl6OzEER3Y7bmvsDtd892stBZ8UDb+2o8NGAp8q2ZXnC179iYjNg==
X-Received: by 2002:a05:600c:46c6:b0:458:a7b5:9f6c with SMTP id 5b1f17b1804b1-45a26744554mr71257715e9.11.1755521345916;
        Mon, 18 Aug 2025 05:49:05 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a29e6d695sm68912945e9.22.2025.08.18.05.49.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 05:49:05 -0700 (PDT)
Message-ID: <ca3f3ed8-2708-4d22-a804-c094b449dc2d@linaro.org>
Date: Mon, 18 Aug 2025 13:49:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] dt-bindings: lpspi: Update maximum num-cs value
To: Rob Herring <robh@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>,
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>,
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Larisa Grigore <larisa.grigore@oss.nxp.com>,
 Larisa Grigore <larisa.grigore@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-11-9586d7815d14@linaro.org>
 <20250814205917.GA3894941-robh@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250814205917.GA3894941-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/08/2025 9:59 pm, Rob Herring wrote:
> On Thu, Aug 14, 2025 at 05:06:51PM +0100, James Clark wrote:
>> As mentioned in commit f46b06e62c86 ("spi: spi-fsl-lpspi: Read
>> chip-select amount from hardware for i.MX93"), some devices support up
>> to 3 chip selects so update the max value.
>>
>> This isn't a fix or functional change because the devices with 3 chip
>> selects support reading the number of chip selects from hardware, so the
>> value wouldn't have needed to be set here. However the commit states
>> that the DT could be used to overwrite any HW value, so the full range
>> should be supported. This also avoids confusion for any readers about
>> how many chip selects there are.
> 
> If reading the h/w gives you 3, when would the DT need to override that
> with 3? You only need an override for 2 or less.
> 

Maybe it should say "currently the devices with 3 chip selects". I 
suppose there could be one in the future that has 3 but can't probe it.

TBH the main reason I added it was because it was confusing to work out 
what the actual max was. This says 2 when in reality it's 3. I suppose 
documenting that it should be left blank if reading from the hardware is 
supported might improve it too.

>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>   Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> index a65a42ccaafe..ce7bd44ee17e 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
>> @@ -64,7 +64,7 @@ properties:
>>       description:
>>         number of chip selects.
>>       minimum: 1
>> -    maximum: 2
>> +    maximum: 3
>>       default: 1
>>   
>>     power-domains:
>>
>> -- 
>> 2.34.1
>>


