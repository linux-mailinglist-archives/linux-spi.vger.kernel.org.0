Return-Path: <linux-spi+bounces-8661-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CEADF177
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 17:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9F44A1675
	for <lists+linux-spi@lfdr.de>; Wed, 18 Jun 2025 15:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9059D2EF9AF;
	Wed, 18 Jun 2025 15:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfYxUja2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FAC2EE615;
	Wed, 18 Jun 2025 15:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261053; cv=none; b=VNHg5feGua4HshHM5c5Yvc0voaAsT6ZRjMLJ33Dlq28QPCXsTDIl7WVJhDLnNS/Zd5AbQIJPuvE4F5A9+NllqrVATYqFITYr/JJkkDOxbE/EtXIeziQaVDf8NCP3c6auKeVecn+zRNrD5zBFI86lZVH0TnJPQ4wqy6jRJLLZBHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261053; c=relaxed/simple;
	bh=38oLIBSzvwS9F/ZdoXgoz55RXnTesyPZaehl42RAHdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Js79QtLUdRS8ht+TF+6/uGNnqXUsWRaADoXt2M+76CAF8cXzJJPjuZWcbCuTqBNPnjbHiioYzeouXq5PToy0PVntOxT8wnan0CN+VJfNcpP4XVy/Q766FfnvCsPcNybFJ+gSQgGVDjCt7iYySiJxQp66Ud6tm13SKUpagIlFwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfYxUja2; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a51481a598so4126699f8f.3;
        Wed, 18 Jun 2025 08:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750261050; x=1750865850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rots1tBuEj+icP+SlfA9bvZe/4e1MCmHxB3VSaBaYU=;
        b=jfYxUja2tdX29FY5wAwfJ0jo11flwIEewIBsVHIGswC2urtX/8xTXLQcT+T4jkzhxN
         cfyv542vAefiimkaCBnQSe+F2EnW9ePMaKPHsQMNn4TEdRTo9CqFS4BI8V/SjBCpK1gI
         An0N5e61dtc8EV2qaQfOIblpg9gla7RtByWm9hkbdq2vaex5K2lbinI3Ro3rISlpHrmp
         vxAyv+keN/46moLV4/mz0vnPizdyCUXI/53hzlqPn3kMMqc8kAP5OKbm0CgemC/dxb+Q
         jTI0WiTyr5yYpoCRw1TvQ6EYDhAgdXmcbNpF6PFtdqOu9ScUwH5uhrRXhgBcEImP4TMs
         kVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750261050; x=1750865850;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rots1tBuEj+icP+SlfA9bvZe/4e1MCmHxB3VSaBaYU=;
        b=t7Z3RPvKfmqu6zHtoO/GBkp7c5RX4zhQfk2gmshr4qERVO3+F2B2ufw73TFB7GQk0K
         6rnmFeOEaq3Dt+gz7fPyM0c1gMh2+yUKImWoa4avl6n4UDnYCmdQPuPwPdSoFX2ISJ+R
         lUaMjABtuKuYuet3YBXl65W07yn6URSzVRmNxtyh4lD7h0iBmfFdckPKvjYvkMb3sg9Y
         PtSVuW/otl531tWA7k7L6Y1c5JFjD/8zgtJ4u/xB3/Rs5GP2ti9qG8gVBHwzWoV7rBcp
         5SMU4G4wmhtLEPwB1lLTpu+8KlR4af1Xf6JlkDcceqmLArnZeSGIHLBMTFSx1FXHUbyW
         NBig==
X-Forwarded-Encrypted: i=1; AJvYcCWL1WaWxG/McMC8JmE+PIijR0QvFXCLBCQ61O6EtiXybWMNLW+IW/NLoNIGOpZwaCONtPl0cE9PGx4R@vger.kernel.org, AJvYcCWlhqiblpjigRC4jWeY5Z2Pmi6XVgrGTed69Z4tYQFtzwEEvACQcQ46QkZxiMhjijw0J1wA2DQFxJnjZE2S@vger.kernel.org, AJvYcCXgez+hUpeqP9zoF2jMQ5gbj7cXMuskMKjwN2zfuGwIEIXQ6n20peHcuz3h4jyV/wfnpxYmTP7T9RYXMBw8@vger.kernel.org
X-Gm-Message-State: AOJu0YwL8Ybwm7u9K14rZM9hMg41AYJ5lOsHCsWoJMTQ8n/Q7hWEhcrf
	sS+y28+SHJz6s1cOO2LHyL2VajHQKWMQFKoz8MO8ojSATHnvcTCYE4MORdz46vJG
X-Gm-Gg: ASbGncut6iBwnBe9wklQqohBzHeZtNtFA9bvUhmOe8M78uXphaUvs229L3Zdqc2DFgo
	F2Lr5UpgnZQ0HKO/D4nAaLzoOY8WB6O1239D5JinKOQgS2TqeqK+vsh+clxksVusr4G+qvhcnMr
	CLACryn35DRWpY5Q2uEu23KHlbfs2b9i4HLorzABx0mlnuSHzS9Oj8ahlH3itFvPpOt/dVtpMZw
	rrwIFAU/MEDHp1mKNvzyw+wXuLsBulWn1ueLaOQAYZmMN4xFkQfOUXQpB1yYfgCyqboHuEp3g8D
	ZlhkwWfgWVgAf+BymvRBNKhQs6GtaIvsVrRtWdK0rhrRco06yR8X9xRT+Ljh8xKwSfz33Jj3IIy
	iajcyHUPfedvahKGfXTzJ9u8BW9sVlQWbUchrOw==
X-Google-Smtp-Source: AGHT+IF2VV+CTQDFvL+Rf1YFT4Teh7oJnJWmdd/7flA9WH+cFonugqwJIfxyEtFJSjjrtaGHyVPTeQ==
X-Received: by 2002:a5d:5f93:0:b0:3a5:1c70:5677 with SMTP id ffacd0b85a97d-3a5723676c0mr14030160f8f.7.1750261049844;
        Wed, 18 Jun 2025 08:37:29 -0700 (PDT)
Received: from [192.168.20.170] (5D59A51C.catv.pool.telekom.hu. [93.89.165.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b47198sm16964027f8f.81.2025.06.18.08.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jun 2025 08:37:29 -0700 (PDT)
Message-ID: <96e2a25c-89d1-42c6-b2e6-eb51b6964849@gmail.com>
Date: Wed, 18 Jun 2025 17:37:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi-qpic-snand: document the limited bit error
 reporting capability
Content-Language: hu
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Md Sadre Alam <quic_mdalam@quicinc.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-qpic-snand-limited-biterr-caps-v1-1-61f7cf87be1e@gmail.com>
 <87zfe5l8g6.fsf@bootlin.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <87zfe5l8g6.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Miquel,

> On 27/05/2025 at 13:08:16 +02, Gabor Juhos <j4g8y7@gmail.com> wrote:
> 
>> The QPIC hardware is not capable of reporting the exact number of the
>> corrected bit errors, it only reports the number of the corrected bytes.
>>
>> Document this behaviour in the code, and also issue a warning message
>> to inform the user about it.
>>
>> No functional changes.
>>
>> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> 
> This change no longer applies on v6.16-rc1, can you please rebase and
> resend?

It is not needed since v6.16-rc1 contains the change already (57cf46cd1fe3).

Regars,
Gabor


