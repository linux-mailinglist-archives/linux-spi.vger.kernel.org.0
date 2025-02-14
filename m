Return-Path: <linux-spi+bounces-6828-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AFEA357A5
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 08:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DC73AC73C
	for <lists+linux-spi@lfdr.de>; Fri, 14 Feb 2025 07:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331B206F13;
	Fri, 14 Feb 2025 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O0N96O70"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635D6205ACB
	for <linux-spi@vger.kernel.org>; Fri, 14 Feb 2025 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739517029; cv=none; b=d4pLPK1UQg+4ZCZn6Q4C+JkCpe2vAYtULwy8bSUH2dtBeDvieWilhuEfknjthdQY4aNf/N6VpqF2TGwRXe8MJssi4Izdg5rWbo+D8gAGEPjpVCYY9A5fra2/prxMi3S5gEeWOUOxgIaIgFVJ60vS+31Ly7nWhYE/YyJAKZSo/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739517029; c=relaxed/simple;
	bh=MFTdgdlExpqx8TY76AlrGCz5tN5VnT5stMEnutUk1/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Whh/c5iP30+XI1jNGA98YQGRXM8o0sTccGD7dy+woldqEqsC6zzrnSyI5pLHRJBJt6xtkokhc87zuJ7EVj2icX45dvu/eUA5ml6fh6QP0wR2c03VWNGw0zQGNGzNSPtjzbca4JHOxC/yhlWNhRcTDkJerl9PT0LZt6yIg27gy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O0N96O70; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so3163883a12.1
        for <linux-spi@vger.kernel.org>; Thu, 13 Feb 2025 23:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739517025; x=1740121825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D3KRD6Y81KP0hnKo/0jrjQjgKZ+r4kg7mu+pEFOiLI4=;
        b=O0N96O70xOcPoqujVsaCZ3lujDp61gTywZBB4UWVXCCSwbJbgcG7Q1u9vaPG0rkueA
         0uFDGGo7nMy/Wk64VzGtzeVAc276BMXvGjUWcGScBfBdp9OCqSb77L7kAwlzzEWyuDm/
         yeKCrhzy+acC/rqcfsIT8zqYz//Y9dTNcfWJytgrARVFJQ/l0yhWBdal0s1cgyzTawud
         141cpus2f/j1KzKVfoQt8pmvwxje2ep4wrYGQlf4xe3gfeWt6BkJI5YGaHB0IvLHEbXM
         1VzRRrRZDcJTQR6DaHr3DE6CLTxNL4GWdWSAK6I967XSHbvyEeCcJ/OGyRNVU3o0Zwc5
         8QkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739517025; x=1740121825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3KRD6Y81KP0hnKo/0jrjQjgKZ+r4kg7mu+pEFOiLI4=;
        b=XQYP3KOzvXKkX3LHJcT+8FZfr9qyvUTRJyMVrYu0MieLLLfbTITxHYaQirc/oeDpeT
         600wZXcPZgsadrtpjsPZRsnw+X7FevlL11kVqom2MBDjpn2anJf/YdLhW/8VvAmHzLYD
         XcZ3hkxyy5Etes+CA0TbIJK32vuOwZsIK+hBAXmrhqzQTzURBU5Lwb8DklDWXnnj4XMF
         X1BQXE+D5FVhxRUXyxasXO+P4dHh7OKnk4hYGSpKwGch4YLPq/h8zCDkp9aNLCfRVFsk
         vajExF6svJvzXHqUuOls/UYIDNS+iyYTeVr68hsrgOitNgw7Cclcd/8/1Vq/ArmOqeVZ
         /SLA==
X-Forwarded-Encrypted: i=1; AJvYcCV908R9vDEvXpHM6pcH0UmH3HL6Q1Tvx+bkweQhx17YIwjWhSKJ2ogSfZWZYLjEXIFv3+Y3UAd74Pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc9IBsZKtBrjLHosFI7EDnLVmtekYlGMjUg9S4bi+PImDUR95D
	moFemR35FwnvEGgiv751rm64Ol6HNZ/slaZxbBuBn2rRC2OH2mPprzO86Mdbz7E=
X-Gm-Gg: ASbGnctSSm4AwxIRw/jcqfyj2GpHzhjAdpmvppb2u3L89yUfPz3f5K7hCYu1rWIl+tk
	IuVs91RzVh509Ga83ECSDZqoY1asMdzvovegZBx6REQ4cngy7b8uZ3wbO7+pa1MD5RBZeqfbRkN
	rEbi0D0P9L8dOrT5rsHS8fELlyS1sFzYTnJq9TfzkiL0fDaOcZof9IzRuaxM6OcDUotBbCKMZR+
	/aumWPcQsOvDliNapTFyQZlTCFqpqkAeEEw6yhN3TYAz1q5KqdT1sb6JF/uQfMBVgW5a0tQAI14
	dR/wK2g6+yq65S7uAsSmF/ws
X-Google-Smtp-Source: AGHT+IGi8WLS5WHEderG6CbIqrMmNonKomIvShKsRt+y2awNKUvUu9Cp4ZCauxABS0cVTnSGyBw2GQ==
X-Received: by 2002:a17:906:7316:b0:ab7:effd:a395 with SMTP id a640c23a62f3a-ab7f389fdf1mr929358566b.52.1739517025159;
        Thu, 13 Feb 2025 23:10:25 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba533bdc41sm279199866b.162.2025.02.13.23.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 23:10:24 -0800 (PST)
Message-ID: <12a67e21-220c-40d6-a6e0-64ba23cf6ecf@linaro.org>
Date: Fri, 14 Feb 2025 07:10:23 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] spi: s3c64xx: prioritize fifo-depth from DT over
 port_config
To: Denzeel Oliva <wachiturroxd150@gmail.com>, andi.shyti@kernel.org,
 broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, alim.akhtar@samsung.com, linux-spi@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250214043343.263-1-wachiturroxd150@gmail.com>
 <20250214043343.263-3-wachiturroxd150@gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250214043343.263-3-wachiturroxd150@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/14/25 4:33 AM, Denzeel Oliva wrote:
> Rearrange s3c64xx_spi_probe() to ensure that the 'fifo-depth' property
> from the device tree (DT) is always prioritized over the fallback
> values in port_config.
> 
> Previously, if port_config had a fifo_depth value, it would override
> the DT property. This prevented DT from correctly setting the depth
> per node.

sigh. You had a fifo_depth of 0 in the driver at v1, this proves you
didn't test your patches, otherwise you would get a divide by zero.

You can't do that, you risk to get your contributions ignored:
https://lore.kernel.org/linux-samsung-soc/fbd06330-ccf3-485b-800f-83f624a7c90e@kernel.org/

Please provide prove of testing in v4.

Anyway, you shouldn't prioritize dt over compatible driver data, see my
replies in your v2.

