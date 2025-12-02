Return-Path: <linux-spi+bounces-11717-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 295E6C9BD7C
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 15:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C766834794F
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 14:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6791EDA3C;
	Tue,  2 Dec 2025 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W7MBCM8H"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3A119A288
	for <linux-spi@vger.kernel.org>; Tue,  2 Dec 2025 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686864; cv=none; b=nlo0Om+ZvGCN2YXoVKfDMAuBlUi5Z6A+71aOIWdh5EdOwCBsy5ocihVDNviWQMDHMCUZjSxVmz9f/R7ZJR3lbpx7XSPtii0jRWxGIj6JqMvgwDwqKQlqzJiBIm7A+FCYNRL+0IcJdypDXgOHrL9aBP5IeBQGhlE7aWiFbtXBGLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686864; c=relaxed/simple;
	bh=j/hJMqTXwhzzvBjqIRxoO6jbaLMP06mK7nDDmR4iv0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eqb/vDSUV5glFzU8wbWho9HPbiKHwJFXiTGNUaPeLZ0ehlexwzRp7vainnIV+r5djjqsCvSptqDjv5L65xqrzkLxMnYZYkEtHkb9KVUMK7IZtCfLVnIR+Xmfb1kerfFah3qOPXAjStSqFLryMH80hX9CAUUEY0qda4yyRrTHghw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W7MBCM8H; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7c78d30649aso4272200a34.2
        for <linux-spi@vger.kernel.org>; Tue, 02 Dec 2025 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764686861; x=1765291661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+tEzflJd04qeyR/h8UHFGgrO3/py5YXCxp0B1Oxmgik=;
        b=W7MBCM8HskoJBTOULvYQ7+A9nypewqtelbYCDg0f8RXTkhROdZNr53MhlIjRRfxcEy
         Nevya92JE0TePI1W8Ha45FqaSYA6ICOimIX9TmkJ5b+7Ss7NHDBZ1CYn7TMD0shlMulS
         Dc6J/QJsGVev2KHugDAkPllqPzK9rZbSvcRHH5a8zok/clCkOUd73LKxi0kfMjuCv3AF
         dMlJtXGkCViKj+cFVh3np5hmSdA2lcCJxZbuIlK0kreTmOyqX0BJes66D9cG7lbAd6Ky
         TsoSzY888Z1wpsRqljJAULHUcxKyYqz47VBg/d0zdbs43mAml6fg16GRJgXpaSYDe59m
         m6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764686861; x=1765291661;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tEzflJd04qeyR/h8UHFGgrO3/py5YXCxp0B1Oxmgik=;
        b=uPxVXGrzZUcTuwEMK3TUDY/bxk9k0Wlj4vu/wq/z7f3p31Y8MQuxWT1ej91EwAWqp/
         HLiSPC1dnjoTWnGt2Z4VinxgYForRRD63EnCp+ddRGrXpESIc1UL148rCCqusBtnynfF
         5Orqk9qvYl70ow2Md2Yi1Xgd8ijxNO0Gku5CdLhafcT5NQZ4ByPBzoScYLtRuac342y+
         vAQY3hFDX2bF/cPtFESJFnqAW/Ndn7kB60+R1N6elu/wk/YaMAKzeD+8NA5AMBw8PJI1
         OUh5hqm/r+ndWKnDhO6YzTvk1gwgAj4HyHTSJiW8UK7UMHy1jM0WUclEgQNnG3N1Jisn
         d7JA==
X-Forwarded-Encrypted: i=1; AJvYcCUObqgiF4nvouPTs2GM1zl03x+q4nS19g+y1ZczqrksA8vP644Omx/ZMc1oWtKbJILXhT6GE90r9JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wnqlpJWLVccK/w0kcPEzEdyXwwBjbRrYeEEnbYoZmY7RrHyO
	z8PKvQ/qCq3SDP22RCf76QGoTyxm0Kxt5zBhRuYPLphcSFm0/lfnQgKGNgaGW3jHcw0=
X-Gm-Gg: ASbGncvMw4b0VghKh4CKiEP+dxcCkOQxmSRQM97SFJPLI4TBuYR4PmPf7KlJKCUqRR8
	XnmerPym4O/2ITk8IXgf0mztDJYnhTd03kP0O7FpYmS0EwNkj/jZ4LY23ZHOSasfYrQ9lY5htBk
	BJCNzonjvUpbmXb8Ki9a51T30pv4COOXtwl00h0nVuAS0YVfKQQYcuGb2DJvvda/eQtBFzSyOw4
	zMtqKUdcMRb1x8+ZqXSiFMrgkHmHPLWwnh3S57Q7/sIavIClJ3JZvmucz/JSgwWQ0WCDT97wWtS
	5SnjkI9ts80KgD96LzvbiqBbgjrF/31C1tq16vVR8fw5taDEwVikgok+M5igAzizMlLSgpJKqq4
	6Y+MTFLbm1AoOfqgYnDEQ0laTt7WgMeVpqBlZt5hRWwgV2nP+adT4LICc74I4FNOVUARs3tXXpn
	rEfPT8zwTT65JY7ZDC1zqu+mqP7j9h4uwU2bnS1uu7OJakLlcbuuJLoNEn3uOt
X-Google-Smtp-Source: AGHT+IFgYmrHE78K2ff5Q5D4WQZpVhHqerF4eN/B5q1CnMh5N4a8DwGM9R9To+9W7QSfdd4c5rIlbQ==
X-Received: by 2002:a05:6808:2f15:b0:44d:ae60:6606 with SMTP id 5614622812f47-451159c7a46mr20381289b6e.13.1764686861256;
        Tue, 02 Dec 2025 06:47:41 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:8f05:e265:a988:1b22? ([2600:8803:e7e4:500:8f05:e265:a988:1b22])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-659332cf153sm4138532eaf.1.2025.12.02.06.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 06:47:40 -0800 (PST)
Message-ID: <f6f66056-f508-497f-a1a3-f4d933754859@baylibre.com>
Date: Tue, 2 Dec 2025 08:47:39 -0600
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] spi: Support controllers with multiple data lanes
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcelo Schmitt <marcelo.schmitt@analog.com>,
 Michael Hennerich <michael.hennerich@analog.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
 <20251201-spi-add-multi-bus-support-v3-2-34e05791de83@baylibre.com>
 <aS77X7T50D8x6yZR@smile.fi.intel.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <aS77X7T50D8x6yZR@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/25 8:44 AM, Andy Shevchenko wrote:
> On Mon, Dec 01, 2025 at 08:20:40PM -0600, David Lechner wrote:
>> Add support for SPI controllers with multiple physical SPI data lanes.
>> (A data lane in this context means lines connected to a serializer, so a
>> controller with two data lanes would have two serializers in a single
>> controller).
> 
> I'm a bit confused. Does it mean the three data lanes require three
> serializers?
> 
Correct.

