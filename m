Return-Path: <linux-spi+bounces-4926-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A5297E718
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 10:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93A81F21726
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 08:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EFEADDA8;
	Mon, 23 Sep 2024 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="gLY9Ci9w"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5791D4AEF5
	for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727078571; cv=none; b=LcRo2kZxiogK3Rv2CCF+zNrpRMzzPsdbjQcB4QqBM57k7lWcxEnJKNSjeGWO63vuNHtDE5AiRI01PmKMaDgZNrjTJ6RT2c//hIIgoVGOEGq+ML9/sgi76O2ULy+kJRQdNTIg+ct9j586JXXrj4Hae6dStqJKCMcKEfS+CbQd04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727078571; c=relaxed/simple;
	bh=KchvWex0IhOZHBE6ua/KkRqQ9ItP93fxk+0T7JEr9/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDjDZuBPKRY2VosNvYUP5QkI/MZu9YKdsz0zKOZHYtKj1HQB6mABtLTRVIE3nv2MR1YGFAf11iY0GIvbelrdYeYCN5z+87ezPnlddtHWS5Mc3mtuv8TVJFkhZITttzfG0UAys4xKfKX5KKG3ejp3CtwDiQyz0+bsN33AdrseGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net; spf=none smtp.mailfrom=ursulin.net; dkim=pass (2048-bit key) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b=gLY9Ci9w; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ursulin.net
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso52066895e9.1
        for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1727078567; x=1727683367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fC3Bk5dw1/gGRftPXPJ3V4u4Vjqap92J4A7d7sdxGEM=;
        b=gLY9Ci9w14rHp3z0mukV+zUAqueWwxwAuTf6HfZn9wqOpecgUf0ddUj+aoLbcq/BJr
         fAzRYAQi1wofmnndX5IItVzpqdqAJzQWOseK+/1oC8C09WWG2u3DaxNmtLXwCiWdbVQt
         xVaWW6ayCPJxHd4BdKFMyRnwVd8ePzENdsMIJfmJGq69s0XF0a8+OevoHotJ3/L958p2
         VLdA5i8TbaDN2jIkqIedXjPe+kS5kFKMql4b6iNBzoNKtDRF3ijg5j383lbMoK1ihFt7
         jDrlyHtVtHzagAWcIZ5kGbNk9RiAUGr5V6L81BFaye6JTXRISKrsgx0FPt1RauLBnlY4
         4q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727078567; x=1727683367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fC3Bk5dw1/gGRftPXPJ3V4u4Vjqap92J4A7d7sdxGEM=;
        b=dCWsiuJ2IGLuh1vE+1mb15hI3dOsTdozd6NKBXFdHizJwA1aIVwS9Zlt609p9RgtJt
         DBVMEGuiiJ24S2+t0v6Ks0Xs+WG77F2tb9B/OneC7irk7MVhrrHPfnWxeWq32AETUmX8
         gKbkNBvJ8o9w4VH/jY6yxYFIpJGeVD37kg9Hgns37mu6uMR65V819Q/p5OXlXKKK3S0k
         DhPlnfejgyXVMxcMq7+dDqzSNjaSFdx0b8CtVNLpuHyYlQlnEfZ6v8LbfqqAsWytHiea
         k6iifDcHFdOFIK5TMQ4uGpTGFWBQYhAj2dypKT4z3b90PUMYbKBqo/DJG3NJnt4ALTBp
         b0wA==
X-Forwarded-Encrypted: i=1; AJvYcCVdnwfl3ApWOfJKU71AkZUuimE22hbgc7VEOFEbbhT3WPuRyCeU22WD3JDgmbPJduUnihU0A9DLZAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhIrSIhBFru4mIyDKFTVxhl/9rOTG6e/fmrMAb5Je1Ot6bKfRM
	z8hGy9wD7ntB/U+Iq0UIPRiu4YH8gkH853ZeHNILFC25oDZcyJyPw4ztZXWSu4o=
X-Google-Smtp-Source: AGHT+IFh8B1YgLhKe+4RstOPDzr4ZktChxPzie9lMCmzjGXOU/dpCtHs6ZgyG/jWqji4/p+lC75vhw==
X-Received: by 2002:a05:600c:4ed2:b0:42c:bbd5:727b with SMTP id 5b1f17b1804b1-42e7adc01a5mr122382395e9.25.1727078567470;
        Mon, 23 Sep 2024 01:02:47 -0700 (PDT)
Received: from [192.168.0.101] ([90.241.98.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780da68sm23800022f8f.111.2024.09.23.01.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 01:02:47 -0700 (PDT)
Message-ID: <1b824cfe-2006-4f5f-a34e-3496c259cd90@ursulin.net>
Date: Mon, 23 Sep 2024 09:02:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 01/12] spi: add driver for intel graphics on-die spi
 device
To: "Winkler, Tomas" <tomas.winkler@intel.com>,
 Mark Brown <broonie@kernel.org>
Cc: "Usyskin, Alexander" <alexander.usyskin@intel.com>,
 "De Marchi, Lucas" <lucas.demarchi@intel.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
 "Lubart, Vitaly" <vitaly.lubart@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
References: <20240916134928.3654054-1-alexander.usyskin@intel.com>
 <20240916134928.3654054-2-alexander.usyskin@intel.com>
 <ZurWk_eXSQndgA4Y@finisterre.sirena.org.uk>
 <PH7PR11MB76057D2326D436CA9749A113E5632@PH7PR11MB7605.namprd11.prod.outlook.com>
 <Zuv9qsWJQhx7rbhJ@finisterre.sirena.org.uk>
 <PH7PR11MB760505A11C7A41DAB0359184E56D2@PH7PR11MB7605.namprd11.prod.outlook.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <PH7PR11MB760505A11C7A41DAB0359184E56D2@PH7PR11MB7605.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 21/09/2024 14:00, Winkler, Tomas wrote:
> 
> 
>>
>> On Thu, Sep 19, 2024 at 09:54:24AM +0000, Winkler, Tomas wrote:
>>>> On Mon, Sep 16, 2024 at 04:49:17PM +0300, Alexander Usyskin wrote:
>>
>>>>> @@ -0,0 +1,142 @@
>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>> +/*
>>>>> + * Copyright(c) 2019-2024, Intel Corporation. All rights reserved.
>>>>> + */
>>
>>>> Please make the entire comment a C++ one so things look more
>> intentional.
>>
>>> This is how it is required by Linux spdx checker,
>>
>> There is no incompatibility between SPDX and what I'm asking for...
>>
>>>>> +	size = sizeof(*spi) + sizeof(spi->regions[0]) * nregions;
>>>>> +	spi = kzalloc(size, GFP_KERNEL);
>>
>>>> Use at least array_size().
>>
>>> Regions is not fixed size array, it will not work.
>>
>> Yes, that's the wrong helper - there is a relevent one though which I'm not
>> remembering right now.
> 
> 
> I don't think there is one, you can allocate arrays but this is not the case here.

struct_size() probably.

Regards,

Tvrtko

