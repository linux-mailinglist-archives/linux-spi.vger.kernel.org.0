Return-Path: <linux-spi+bounces-11244-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DBBC61938
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 18:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A50A53594E2
	for <lists+linux-spi@lfdr.de>; Sun, 16 Nov 2025 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1829A30EF80;
	Sun, 16 Nov 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BbTniSQp"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E030BB84
	for <linux-spi@vger.kernel.org>; Sun, 16 Nov 2025 17:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313336; cv=none; b=KMOf+TpKGcjoTMUBPx9gPdbxBJzf6rURN+WFYvnK/J/lJD8A7o+MDeXX5jDe0ms1sm5JeGvagzbJdZmo9/fweU+7qHuvAtvIMjER3k8ZVMwQMncJuMwxcjTb1ZF1HEQXv1h/7y6OVx54MtcLeDDses5tPdFLNwp3gPow3L8loAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313336; c=relaxed/simple;
	bh=re3s6imgircqSQj58d3+Y4a6sfcYlaa4sMPK0zTCn38=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGMb9UPPxcG+rE5annpm0p5gZkGvj6p7btF1+ac4/C4OwkRpVFLcYvbAT872+VtyOVOVQpwkRd8Ofj5vQiJE/X6p3PM0/1NDdGj6Rh1CAoIxfnUG70Qvr5g6e4h/nxauUHPcEeQ0Uksn6Gb53VsuQxBq8nq5bBHdcp07sCuvDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BbTniSQp; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-8823d5127daso42834946d6.0
        for <linux-spi@vger.kernel.org>; Sun, 16 Nov 2025 09:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763313333; x=1763918133;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=veg7RieeS26GseUe/EUMpLpNCpfmPX/ypl6sjKmpQ8g=;
        b=ZiG3ckmqKVVSbEk57EAjEAiuXtmf3A1RArVFzeDOPNWunu8UT8v3aDQXu8PMrdQkYA
         4TZqbO9q9YccU+SxMcLRcOIdxbHf2fpLNRpciLIOwlyUvG/XTjGiW42RuKcL+bu7jYVw
         bGn4MgkBmcH9wmf5THujL6gaRxvzL0TwjsT/P5b1I6WJQI6b1sfH3w+jC8Lozk6RXOS6
         7fpHzCbFw0NxwIvmmSkJmGX+Pim6WfnCDuSttSwKWWuRsk+eASsq7JOxj1XSfFNtLiXP
         r1PuwX1S1kN4CHOGYcw5DmiZLlQl0J+kJOE1mvN4MG0C/sLpMqejGtMuDSKq4Xh9sF7n
         f89A==
X-Gm-Message-State: AOJu0Ywn2e8f4Ftk1TThYlqoxtZ23JeydOJBnavZP72ze+PmTVTRC5IX
	483qqNrXGHzbR0MyH68dzc/4e5X4D9HtPv21XX8kBjEP7NZheHBadsaG35DHkfGJi7GGDfWNjan
	Y1+Wp5jJkB+q6zvCpBKyjsGrU9h/henR7JLNF/1GVsCdp4CDqSu6pdhvcvY/eoa54o7Cm4Y9iZb
	1+IL6SX3Egl3AN6nT8gjTOp7RSM7G8Ym9EktFGJn1VUF86WWZAzNnTO+3FW7GeVDfPYBGCOA7i5
	JuZPYe3qsBXc/jv6QvT
X-Gm-Gg: ASbGnct9S9/+FtrcHUFRazsjxWuyI0arEBb81PpzklFdnUZr+NuLPpYsRd7b1obFYI+
	2pAJ222NHxQp5lIjlQjFUFcso95ebiMytjwJEDBfo+9s+bpuYtQnaiQYN6XDML76p/2WWYx3v81
	deq+hl89QZA4nQJkz4AUslrnDVdvU+rSq8VM3sfo5jTKl8ZV33E69QzbHPDwKXk8ROeHGQ3X0HF
	BqnW2tN9febGwMn+TcuqJCYKlm2vykLMcAlwCw4YTawVZZJ8grMWAGEE1qAT2cPYoLUSHXn+7JH
	w8NkYMoPt2LGpwiQQq+8P806txwcZd6yoSs+Cap51sUmyv7lwlooItaE41CeFDbp5Zj/ku6KiB1
	K24l+cisgRdamkAWrwPwSfkk3eJA0IogKQaz+15mrcDdAHuaho1Q/wUX+qYuwksiL74hbad94eh
	bq6NeMBY/MaHConTTsFt7TeC9kbNICxrb3wOQ9mjLT5w==
X-Google-Smtp-Source: AGHT+IFzUCz3P+0aQhfWnR4ACXzb5WRyCPHDH+wEdf5+Fy8EZB80ItSIvXJgm+Dhl4/Zy9mfEl0pA/WR+7dL
X-Received: by 2002:a05:6214:2602:b0:87c:2360:d404 with SMTP id 6a1803df08f44-88292594572mr146059996d6.7.1763313333130;
        Sun, 16 Nov 2025 09:15:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-882865b13a4sm13428626d6.31.2025.11.16.09.15.32
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Nov 2025 09:15:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34377900dbcso5987267a91.2
        for <linux-spi@vger.kernel.org>; Sun, 16 Nov 2025 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763313332; x=1763918132; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=veg7RieeS26GseUe/EUMpLpNCpfmPX/ypl6sjKmpQ8g=;
        b=BbTniSQp4j9V/W2pBN193XvbuWQ3TSnsWnwg4WNpD0OBSNF7/ZH0DYzOxPk62nRl0C
         oj2FWsSLfAQlHC8xIdA7+qY0HuX9nE/s/7suE+x8CWeiq1m+Bnau09cFNH3ERh1jYypL
         PHrTqBujJZnmNhRYf/QYUDIwGH9++OT0hgzys=
X-Received: by 2002:a05:7022:4590:b0:11b:9386:8261 with SMTP id a92af1059eb24-11b9386849bmr2704422c88.46.1763313331882;
        Sun, 16 Nov 2025 09:15:31 -0800 (PST)
X-Received: by 2002:a05:7022:4590:b0:11b:9386:8261 with SMTP id a92af1059eb24-11b9386849bmr2704407c88.46.1763313331334;
        Sun, 16 Nov 2025 09:15:31 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b060885e3sm37453371c88.0.2025.11.16.09.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Nov 2025 09:15:30 -0800 (PST)
Message-ID: <ea87b04d-a7a3-4e2d-855e-808999a5f659@broadcom.com>
Date: Sun, 16 Nov 2025 09:15:29 -0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: bcm63xx: drop wrong casts in probe()
To: Jonas Gorski <jonas.gorski@gmail.com>, Mark Brown <broonie@kernel.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251116093334.17423-1-jonas.gorski@gmail.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20251116093334.17423-1-jonas.gorski@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 11/16/2025 1:33 AM, Jonas Gorski wrote:
> Both bs->regs and bs->{rx,tx}_io are tagged __iomem, so we shouldn't
> cast them to anything else.
> 
> Silences the following sparse warning:
> 
> drivers/spi/spi-bcm63xx.c:571:22: warning: cast removes address space '__iomem' of expression
> drivers/spi/spi-bcm63xx.c:571:19: warning: incorrect type in assignment (different address spaces)
> drivers/spi/spi-bcm63xx.c:571:19:    expected unsigned char [noderef] [usertype] __iomem *tx_io
> drivers/spi/spi-bcm63xx.c:571:19:    got unsigned char [usertype] *
> drivers/spi/spi-bcm63xx.c:572:22: warning: cast removes address space '__iomem' of expression
> drivers/spi/spi-bcm63xx.c:572:19: warning: incorrect type in assignment (different address spaces)
> drivers/spi/spi-bcm63xx.c:572:19:    expected unsigned char const [noderef] [usertype] __iomem *rx_io
> drivers/spi/spi-bcm63xx.c:572:19:    got unsigned char const [usertype] *
> 
> Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Not sure that deserves a Fixes, tag, but can't hurt!
-- 
Florian


