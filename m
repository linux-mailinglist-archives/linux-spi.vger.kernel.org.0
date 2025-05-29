Return-Path: <linux-spi+bounces-8338-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4F1AC83B3
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 23:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD421C00005
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 21:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41B122A811;
	Thu, 29 May 2025 21:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g/ub5XcA"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F37249E5
	for <linux-spi@vger.kernel.org>; Thu, 29 May 2025 21:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555331; cv=none; b=Jqtcnc/7Y5qB8xLmUQWdMoV0+l7QZXPThEKdCSflCsgHXYIplFYgL7uYgDSx5Z49Y1zOblkjsczrhqibd5lzjuJn6iHHTn2agnjZMOeqxQ5pazE5l//HzW4ruHPCEMsmodYtCRGwMcvxfv7aTAIrHtchHOWWUiaaXPgOVYLmgNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555331; c=relaxed/simple;
	bh=dJOYjPMUXFyM/9ihamvsM91Mu+OZMNo9b2u4FSLpFgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jwJ4WpyeZftcOCjXANg5UEXf5OrSrQ7O358N0lfXrHOIIxEVbu5yLs2jNwOrPX9MSk9CVHrwCepPF85e851tB1roD4CUtB7MvmiEVe1QKlJgxhvKCzk4TSylgLh3KtFKnVLdedN+2Ej7J7YKMpoUVDFn0Gmu7BKkDwu1bOrmyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g/ub5XcA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-742c9563fafso1167375b3a.0
        for <linux-spi@vger.kernel.org>; Thu, 29 May 2025 14:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748555330; x=1749160130; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=X0dZteGZJJIJ9Qm1S27Qbb5Af2ayRJsCBBhcuN4pSnY=;
        b=g/ub5XcAKwW107IpP6u20lENpTTnGpZ4c+t0nNgkkDa+u1OBAub4EkXWhK3HnCtZ+a
         b6Y8u3yuJ36GYrsOF/1YIf60qit/y5ZcAFiAggUbc9XTeTo+igHz1Dj+7O2w5x5dGTB4
         49jp+gJf3GPWAmZTpGESHsbcYzhdru3a2Hebs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748555330; x=1749160130;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X0dZteGZJJIJ9Qm1S27Qbb5Af2ayRJsCBBhcuN4pSnY=;
        b=Tgp5BnHolSCYHASL3Br7FcujubWVPSQdXtHLKvRfdVsfowPtFsDQgnIOg83x+cxn2S
         eogTunH1Nc3qA7YpIUkFK36SXshpHpr0d175rzqLsHBWG2qp+wZGXoEuqpekbddxJOUy
         KrdAJ8KewpD9rshJQuV55dgoacGPfPC0OuLc7zMr0/Bpn04v9UVchyEka4Fh0iKO7Bl3
         TqSfAfV6DoJW9B4dKJ81u860QLFbmLB4uTnLTYl0c5Fn4dfA1+avqPFyziharz+ljX7J
         O8ttGHuTKjef+Iu8f3R0MJDAGYqIu3xQnHJDMweoCmFwen2gXAVNUQto+lx1wTVWfpx9
         BxvA==
X-Forwarded-Encrypted: i=1; AJvYcCXEIW7sLc5O1rOZz0BIaIqx4FVh94ES0bhqAjQu90973nv5DeQvzCrLXtmwrLZzjwv9HJImjA62ySk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3aYPsMG0InSKTqkmfEsD2PEbboeiILZMDOKJ35ZzKh6NKJ0qG
	K8PwJLk72Epko39S6gNnU8E0UMXKffuLjHTGB6d3wv4JisgpUhw6bhB+biuIMHOKYg==
X-Gm-Gg: ASbGncvIAJdO40X9IyCx9wMKha+1dbW7KGKJcQZZQTwem6DVOF4AmIPPzzMGHJaYPIZ
	CpEFTtnhfUdEP4t7dh/VCS2NzirntYbV7K7RSnpzSp57KbJChvG2JRpSpFintDzoY1DXDSRnsWx
	f2+ivwcMYoNw4ZVFNkO+nA6Jd4QIF8lPXSAbceox164LWhp26C+zaqDzUszpGUJ4HnDpub4OedX
	FKzXx5BsuhvroXUoRz8MTK8B1o38OtoPJ4vikKm/dzowAALosmJep5L0G4eayVu8jgbE+dIQVhq
	yp/tvzWlcSH8/6QJ6JjtcqFEV8UkPHutjQJP52GqRkrDJdx6cS85FySBfH/ghFZOaTKHocCaqxC
	6unkFVnMTUlrMBdI=
X-Google-Smtp-Source: AGHT+IECQIFuFJQIQo7spxow/4rGedbVwpZnB5OC15Us4YjxIv3h8MLW6G8nfxsK55TvvCyuYzkq7A==
X-Received: by 2002:a05:6a00:b43:b0:742:a4e0:6476 with SMTP id d2e1a72fcca58-747bd954bd2mr1371245b3a.4.1748555329862;
        Thu, 29 May 2025 14:48:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff70b5sm1786617b3a.160.2025.05.29.14.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 14:48:48 -0700 (PDT)
Message-ID: <31ffaaed-b52a-4756-a53c-103b09241582@broadcom.com>
Date: Thu, 29 May 2025 14:48:45 -0700
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: bcm63xx-spi: fix shared reset
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 dgcbueu@gmail.com, william.zhang@broadcom.com, kursad.oney@broadcom.com,
 jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 broonie@kernel.org, p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250529130915.2519590-1-noltari@gmail.com>
 <20250529130915.2519590-2-noltari@gmail.com>
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
In-Reply-To: <20250529130915.2519590-2-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/25 06:09, Álvaro Fernández Rojas wrote:
> Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both SPI
> and HSSPI controllers, so reset shouldn't be exclusive.
> 
> Fixes: 38807adeaf1e ("spi: bcm63xx-spi: add reset support")
> Reported-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

