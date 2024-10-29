Return-Path: <linux-spi+bounces-5535-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4F29B4E03
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 16:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B0241F21B9F
	for <lists+linux-spi@lfdr.de>; Tue, 29 Oct 2024 15:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748F8194A66;
	Tue, 29 Oct 2024 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z6cIzhPE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC602BAF9
	for <linux-spi@vger.kernel.org>; Tue, 29 Oct 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215853; cv=none; b=ZAfd182//djOe+1wucOFmcpEazbra3GjZfmgoG7o3Z8Ih5seZvuYUKak1788TIbL74oiGeGtfSgOl5ATNK5yFQnUUgFvaPBEvaMlMhZpuVz3iAxfzsj5dw7AISg62V7azJMAp8UtM4d2pVajxXFQinfcqvUZi9IkWAn1f54VPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215853; c=relaxed/simple;
	bh=C2Bf/CpiazCRHi+JMjkoraHCMogNvMrpX8KWNoU7cSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1jDVxRSKaVRWXDNMgAzlPURrc8RzlPArUdkIJWJ2+qk02QIjRiDwwHFgjjMXsTOB8PUZ7qQz0Y6Dnbv03w++zjijgy3GKQx7hMrw7FIGfvTBHyM0cmTXvM5fW9WWfZBEpVsOeyNMpRQ5zks2kKi5vCFKKB6wwcLn2ORXplMXHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z6cIzhPE; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-28896d9d9deso2626001fac.2
        for <linux-spi@vger.kernel.org>; Tue, 29 Oct 2024 08:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730215849; x=1730820649; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n6oLt4cwqIvtLgDoKzl4RIUjXVN/+Dx6j96wTlFjHfs=;
        b=z6cIzhPEa1IGJh40CFi+FEMWamYrZIx08dC+vmYjtQCDOxvW364Gclqd78i3pcDygY
         XrJGjkkYmldK/lyBICRa0H8sSFN2kihL8XYLFJm7qte+ktQQldASeI39x93WHJ55EP2z
         0InmLEndWN6PjlmGFTImRaDr9PYRIsP9doGC/gQY6uqschjpZl6m652tdNgvG5q67Zjc
         pqNXnCvtIEwibGgpAPtu44nHhaigJfiUMO7pp8OKTfhSrw2fEztFj+hLsfnai6gnZvz8
         VTqqsN94QhMtfsTDfiDemVi8Ot1L8XFgpwhg4ro7rOdfdrk64tWThk79aEBxDe8cb703
         24kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730215849; x=1730820649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n6oLt4cwqIvtLgDoKzl4RIUjXVN/+Dx6j96wTlFjHfs=;
        b=GGs90qvRkdm6kwQYYn6y+N0zS12N3aP0i0HUvnS5VMrPfpwjN/pUAznWDRhFu+S8Nu
         gniU5hjEmT3L4tZRYebgUg3FfRL+7Ks7tz1MfkMieL3BIX5py2HPzL3+t3raedDWHQxR
         Httjveoax0jrv0YbA1O3vzaM8/pdrTtp4SwGBGGCpQLf3wtr1nyj5fWb/qQ/gVtGBExq
         r8lUGbgpu2TiGzHiYEzUsWgHFhUK0tZd22Ls8ITE/a5Jzs4DJ/XhQfAhWdn8X5k7Mmep
         4x9ZsFBmRbrLWXSZ+hl0K+CsQEH7jdi+RMsE52iuypjt8oRHk/qM2novypS7uZO7vOvO
         aE7A==
X-Forwarded-Encrypted: i=1; AJvYcCV+3f5b9W7m7TFtpWaFKTMvxdi7sMqw9YDN7LNuiScTHWbxGFy23lKuww5PHt/0+ZopzQ9B+/8UKRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxy7IQsLPwXsrEasVc2cm4Bhzkib/AQlWrBPy8c7RxZqwtSnT22
	BUIUXL9eIzLx+6q7qSdPYXSgvFYiTXV4i8oYUt7L/OLK5I2h2nRfi6pHrJqqdD0=
X-Google-Smtp-Source: AGHT+IE2SkDygBFnyOcXc/xSl2iBsuYxGCBH6q3GOhnV+kWltCIyrT3d5jLZv9ddzix44MMFYznHAA==
X-Received: by 2002:a05:6871:69f:b0:288:34aa:20a3 with SMTP id 586e51a60fabf-294649be62amr49618fac.45.1730215847206;
        Tue, 29 Oct 2024 08:30:47 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-290360f4540sm2856004fac.31.2024.10.29.08.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 08:30:45 -0700 (PDT)
Message-ID: <82edfbb9-5e65-4292-b15b-d5cde7b53e42@baylibre.com>
Date: Tue, 29 Oct 2024 10:30:43 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 01/15] pwm: core: export pwm_get_state_hw()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Guillaume Stols <gstols@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>,
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
 <20241023-dlech-mainline-spi-engine-offload-2-v4-1-f8125b99f5a1@baylibre.com>
 <mavlxxjza7ud7ylgoewz6fz3chtuwljvcjjf6o3kcv555iolwa@wdnrsiow5u5w>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <mavlxxjza7ud7ylgoewz6fz3chtuwljvcjjf6o3kcv555iolwa@wdnrsiow5u5w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/29/24 3:05 AM, Uwe Kleine-König wrote:
> Hello David,
> 
> On Wed, Oct 23, 2024 at 03:59:08PM -0500, David Lechner wrote:
>> Export the pwm_get_state_hw() function. This is useful in cases where
>> we want to know what the hardware is actually doing, rather than what
>> what we requested it should do.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
>> ---
>>
>> v4 changes: new patch in v4
>>
>> And FYI for Uwe and Jonathan, there are a couple of other series
>> introducing PWM conversion triggers that could make use of this
>> so that the sampling_frequency attribute can return the actual rate
>> rather than the requested rate.
>>
>> Already applied:
>> https://lore.kernel.org/linux-iio/20241015-ad7606_add_iio_backend_support-v5-4-654faf1ae08c@baylibre.com/
>>
>> Under review:
>> https://lore.kernel.org/linux-iio/aea7f92b-3d12-4ced-b1c8-90bcf1d992d3@baylibre.com/T/#m1377d5acd7e996acd1f59038bdd09f0742d3ac35
>> ---
>>  drivers/pwm/core.c  | 55 +++++++++++++++++++++++++++++++++++++----------------
>>  include/linux/pwm.h |  1 +
>>  2 files changed, 40 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
>> index 634be56e204b..a214d0165d09 100644
>> --- a/drivers/pwm/core.c
>> +++ b/drivers/pwm/core.c
>> @@ -718,7 +718,7 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
>>  }
>>  EXPORT_SYMBOL_GPL(pwm_apply_atomic);
>>  
>> -static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
>> +static int __pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
>>  {
>>  	struct pwm_chip *chip = pwm->chip;
>>  	const struct pwm_ops *ops = chip->ops;
>> @@ -730,29 +730,50 @@ static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
>>  
>>  		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
>>  
>> -		scoped_guard(pwmchip, chip) {
>> -
>> -			ret = __pwm_read_waveform(chip, pwm, &wfhw);
>> -			if (ret)
>> -				return ret;
>> +		ret = __pwm_read_waveform(chip, pwm, &wfhw);
>> +		if (ret)
>> +			return ret;
>>  
>> -			ret = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
>> -			if (ret)
>> -				return ret;
>> -		}
>> +		ret = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
>> +		if (ret)
>> +			return ret;
>>  
>>  		pwm_wf2state(&wf, state);
>>  
>>  	} else if (ops->get_state) {
>> -		scoped_guard(pwmchip, chip)
>> -			ret = ops->get_state(chip, pwm, state);
>> -
>> +		ret = ops->get_state(chip, pwm, state);
>>  		trace_pwm_get(pwm, state, ret);
>>  	}
>>  
>>  	return ret;
>>  }
> 
> I don't understand why you introduce __pwm_get_state_hw() (a variant of
> pwm_get_state_hw() that expects the caller to hold the chip lock) when the
> single caller (apart from plain pwm_get_state_hw()) could just continue
> to use pwm_get_state_hw().

Hmm... it seems like I thought there was a good reason for it at the
time, but looking at it again, I agree with your assessment.

> 
> In principle I'm open to such a patch and wonder if there is already a
> merge plan for this series. If you send a simpler patch soon with the
> same objective, I'll make sure it goes into v6.13-rc1 in the assumption
> that it's to late for the whole series to go in then. Or do you still
> target 6.13-rc1 for the spi bits? Then it would probably better to let
> this patch go in with the rest via the spi tree.

The SPI offload stuff is not likely to be merged soon. But there is
ad7606 + AXI ADC support from Guillaume that was just merged that
could make use of this. So I can send this as a stand-alone patch
so that it can be made available for that too.


