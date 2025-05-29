Return-Path: <linux-spi+bounces-8339-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC14AC83B5
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 23:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7061C003E4
	for <lists+linux-spi@lfdr.de>; Thu, 29 May 2025 21:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022BE22A811;
	Thu, 29 May 2025 21:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DdBREZot"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97412249E5
	for <linux-spi@vger.kernel.org>; Thu, 29 May 2025 21:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748555339; cv=none; b=UmZRexHmM85qkHFfaH0R71qvzukBBqeS4MXtk3IkfWKAl6e6Jz/5JadNd+IrK+l+0vANa4w7a/3PXQgXnUTbpwsw4s6wjZRcxfm3dijM5NnEM1cGaOsWdiwrFZjdPJyshzaXfdz/sFNP4GRPZQA9YvuwU0POX+6wO+r3PGY6t4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748555339; c=relaxed/simple;
	bh=ABQTqLGLlC3tANPQdemxVdZP6bntmM77J3igINat3t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ElJdOMaVscda4DEzIv9k0QBtAugDnvuehjteJGNW6WjHvQXhvuLUtNLA3kHzBkgpxBvpG3Xgv4hlTAKjs1F89pCy+omNr9F4y2ty5+iNMi0lEYM/C5B6Ed6PI18aDUt+JwxA18uHMCmeFw56fv6UV3QLgrfsUVNQNFNK/+kHmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DdBREZot; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742c7a52e97so1186975b3a.3
        for <linux-spi@vger.kernel.org>; Thu, 29 May 2025 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1748555338; x=1749160138; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7znCh6zDnVjvQkcjxiU/GSJCmce4JgiMV3o2WwlRE9U=;
        b=DdBREZoto3srM2lsLfR8fbXTgiNqHqSwsh2mNKCUzs5HftzH7+7p63nI740AqoF3wX
         JVwhkUSurMLEIUX3GzfdiXjGkSFZ9Bedixj3Gf1g9/99/HfRE4iPNtxfUmz5b+FGQCSd
         slywfuVuXZ+wTSjESc47sbtYHFKqQZYv6eEo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748555338; x=1749160138;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7znCh6zDnVjvQkcjxiU/GSJCmce4JgiMV3o2WwlRE9U=;
        b=k9Q0Y2BruAuNR1Cb1unfDRpqKTtJCQHnBPOi2YXcIREnSLKFJRKQFAo8VvJUiteaM5
         RYEwWsnjEV/g5/4rYqKSsiPBaE4ohq4mPSSP4DtgGXMEe+r5CHKgH0lAHfSMlginjfga
         GmsLjAgZtjSrqQ+/0RBvouTXkd1qQSFPGDjfxDyZgHT9HC7JKdHtv2lPhW7wIHPQb1G+
         sht8mOdSItffFjfhPBdsvoy02Nll9ITkHkcQ/8XgB1FQXSsdr7hHMZ+cGfcbag3ueNoo
         PJr6AnfPthzBnLw0v3tI7i/3XzEDswiNqa1Cb/g3zx8TjL3Hb2KWD3AHnPwqPPfxn3/F
         xE7g==
X-Forwarded-Encrypted: i=1; AJvYcCW9UMC66xyosbjmR3/pL2han1nCQzzk80WmtAH47vjFw9Fy9ZdEsXbBzKYjAIUal35nTjPv2dEhrwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy0aH7rniqIP9IVbyw9m8w+EW1KUAa3tCmJbMpWCsqTemO44GC
	wecBDSebhV1sWJoPIiSX70XIezt4/nU1hB4LRxR1/UQohjwbxf0kQaT3BPlDpURUSQ==
X-Gm-Gg: ASbGncvOJMMy+MnAvBSk6vvENYGGXx2yBr2cmWLC3d2KtsBpzbJuutLBsE+LXzqbZnK
	u1mSIKkiDXJYYpbJQ86ZP9xssWZjFnrLW6k1gFrCQzlcEWg9fR8MIZ8y1gsU/OHCDbwFnVHe5Cd
	hXXK7IQcsl/yLC4wIqZyUk2qXiszojpCKVTn5l5uH8kPlUQdfgGOPf5RRn/Boz8Gvo8eh12/Akj
	q01omJVp0bgQCbTz8/mhZtNfjmjQilaGJdMEvLbXmpKEp/BE0tDARE3ZmAl7b4Z6hTmyDCDdQeB
	yEGaq2Zz6LsIswUXTl/WLwlYNF3CDj2OZSptLSgEcW+rLrGLtu6ZsuusJwSJFdTcOlgdyY9mriA
	9HN8Kp0AqSlofxkNJ1M9t3Z0w/Q==
X-Google-Smtp-Source: AGHT+IHLQzUqXwC+6eoJQH8FpEmh8+zh1YVEa4qraw5X3qBwwjQyXGrhemm7JIaHqxee9ZUzekWCbg==
X-Received: by 2002:a05:6a21:6d86:b0:1f5:7c6f:6c8b with SMTP id adf61e73a8af0-21ad954976dmr1844253637.10.1748555337827;
        Thu, 29 May 2025 14:48:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff70b5sm1786617b3a.160.2025.05.29.14.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 14:48:57 -0700 (PDT)
Message-ID: <ea01ab65-c33c-40e2-9a99-ed8307c9d89c@broadcom.com>
Date: Thu, 29 May 2025 14:48:55 -0700
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: bcm63xx-hsspi: fix shared reset
To: =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 dgcbueu@gmail.com, william.zhang@broadcom.com, kursad.oney@broadcom.com,
 jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 broonie@kernel.org, p.zabel@pengutronix.de, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250529130915.2519590-1-noltari@gmail.com>
 <20250529130915.2519590-3-noltari@gmail.com>
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
In-Reply-To: <20250529130915.2519590-3-noltari@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/29/25 06:09, Álvaro Fernández Rojas wrote:
> Some bmips SoCs (bcm6362, bcm63268) share the same SPI reset for both SPI
> and HSSPI controllers, so reset shouldn't be exclusive.
> 
> Fixes: 0eeadddbf09a ("spi: bcm63xx-hsspi: add reset support")
> Reported-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

