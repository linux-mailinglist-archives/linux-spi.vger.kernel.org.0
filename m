Return-Path: <linux-spi+bounces-11085-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 020F9C3B6D3
	for <lists+linux-spi@lfdr.de>; Thu, 06 Nov 2025 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EA71A47242
	for <lists+linux-spi@lfdr.de>; Thu,  6 Nov 2025 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222CA226D1D;
	Thu,  6 Nov 2025 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b="SMs3BUF9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320D9227599
	for <linux-spi@vger.kernel.org>; Thu,  6 Nov 2025 13:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436820; cv=none; b=JzNxwBxuIdXY7Z9ENhGVluRf750/aEpnRAf0mVVQw6uidzJB+XIQFJALSymKtatDG/xAE0jZ4SQn7Dw9zZSMwQccRQ/ErUD091Pc7bYhZ29C1ibXPu3FI5FLgDwyK2zQr2EFo6kD0mbtPCWIGOdkIByFUrsliU7YICyqi3zpsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436820; c=relaxed/simple;
	bh=bjkGinoYO3nljlduk9aivkJTiCtm7BYadLz4g/Z06Yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ftANn4GSenEMq0tupZfNWQ+7VQkp3jiZc8pj0thCLEpSya+Nozdr/agBr7bzJlL/lhOa0FNFG/4qEoYIxl5/dbQNRTqXSJEB96ilUTKr/Vwf6Bc2Q0+y575rp/DfXGHUW67/10o/U/cWH62n7ZKHjYlGqpLzsrAiZ8q+l3GsLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com; spf=pass smtp.mailfrom=hazent.com; dkim=pass (2048-bit key) header.d=hazent-com.20230601.gappssmtp.com header.i=@hazent-com.20230601.gappssmtp.com header.b=SMs3BUF9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hazent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hazent.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47112a73785so6444075e9.3
        for <linux-spi@vger.kernel.org>; Thu, 06 Nov 2025 05:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hazent-com.20230601.gappssmtp.com; s=20230601; t=1762436816; x=1763041616; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bjkGinoYO3nljlduk9aivkJTiCtm7BYadLz4g/Z06Yk=;
        b=SMs3BUF9333uzrfUPWXnmcVHJvpIKGUSBnM6ySCZLLEHsT0b0w2AJc6IQARY66C3ug
         YAGcj9w1E8aTYeVgzzbS5PkKA8gJQTeKT/cIT2JcOgYbKBQl4zDBjxYVcqnzCrytrgIt
         UkHZS/Eq13o59QZAUTkrLlr8aricpGJVZaAJg7/K9dcbcJo8DeyEVp5GB/+nPTy8x1O7
         foxoFEUb6h/1MQggrvM2wig8Rmf2uKmpdsqL4650j0Nfu2cOQgacvtV6GKqTuNSQht2l
         4QRkRhZRWz4yhCxEb4AtuOsz4GAOfhqzoBLGGiW7sDI49tO4T2xdjbNlveJFCMP3oGw5
         EACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762436816; x=1763041616;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bjkGinoYO3nljlduk9aivkJTiCtm7BYadLz4g/Z06Yk=;
        b=tVjHjSAmJRm3hKqXHQtmI6T53QPmRr19zz/7sXZ++wz9rAHilEuF5dFFaki5FsGVmD
         PoE3u61AyaC3qtaYNpj4c5kktMt6OdMZH5LxTBJbCmNYsMYsVVi1u075YhIw7N9tXxip
         XZJsMqivB8DXwLf7myV/gcofgmJelqV9ql3YCANw4xvt17ZO5G7RUuO//3kZEJlSUTk3
         xnGgotNLXS5qbazyuN+9xj8AFUBo1bHZ97PHGnpOrghnxWTc9N6px+gHp9hyaGsSoGp7
         6VMfQTAbiP8A5RIVV3oqwq1HbknJgoqvcXY+xh8StSc1b5SYlkxPqGF4wLGSmFQ8Wni1
         k35w==
X-Gm-Message-State: AOJu0YzOIbKS8DiK14HpWra5T93xtfVhVCwk4FG9UqdgDTAnkUb/neec
	X4PUxP0Z198Y7eRdjXy+8ViSuOMIe7nR+KbFyfJmlnyZBKvKFjP5GA0XRFnlsvNxcQ==
X-Gm-Gg: ASbGncuUgWKT+C2Lsqv5GroNinSaw0guv4s+6QjD7coIjiF9UOqz1DqQxF2NE+hqYrI
	o8S9yRIjL+emRtciO5zBwAVtbENhxVkSdLM5gFzsdU1CS4SLh7VKUCO0KnI3xo776XEXey2DJq7
	geGJEzmoRFCzuPGAX0bL83p3m1/Kf27PtvMHdocMMt0fo8Rvw49z4iSpp7py7h6/4sQrvEoIrQ8
	2Ib1lugakfXZ0RV8042XCiQDjw63Fva/Wo0ODMqiHGqejiccx2LRyFlSoWACnNN+lZULzr1YOtF
	wMM53kOwxSO2Ygp+qtT6UDinNMcNEldJ8FPyd7NCjZn3U7ElKUc0F+dRQpNyVN5tc1/hWUBbfZ3
	5sAnzlA+yFohPblXNiAzIEE9gLjeOiSJk1HlX8LHg6cTsjj/T6WAATR7qdsjC6aMYULjkUR1uRU
	qZLKR1mXta
X-Google-Smtp-Source: AGHT+IHaKLa2u+iO8Q0O3fWNzsoYv3refRV/v518UKELnIOoSjNE0pq62Zq8XDyZdxzAPxFNBvmAfA==
X-Received: by 2002:a05:600c:474e:b0:45d:dc85:c009 with SMTP id 5b1f17b1804b1-4776a911bcfmr8637735e9.10.1762436816244;
        Thu, 06 Nov 2025 05:46:56 -0800 (PST)
Received: from [192.168.2.3] ([109.227.153.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb477226sm5071517f8f.24.2025.11.06.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:46:55 -0800 (PST)
Message-ID: <3f6c524e9aa99e0f60d9041d643e343c7081bc34.camel@hazent.com>
Subject: Re: [PATCH] spi: xilinx: increase number of retries before
 declaring stall
From: =?ISO-8859-1?Q?=C1lvaro?= "G. M." <alvaro.gamez@hazent.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, Ricardo Ribalda Delgado <ribalda@kernel.org>,
  Michal Simek <michal.simek@amd.com>
Date: Thu, 06 Nov 2025 14:46:54 +0100
In-Reply-To: <aQyfVAmcS-WUS7RC@finisterre.sirena.org.uk>
References: <40ca72b63d52d2db4d03ed45d17edd1000290c3a.camel@hazent.com>
	 <aQyfVAmcS-WUS7RC@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-06 at 13:15 +0000, Mark Brown wrote:
> On Thu, Nov 06, 2025 at 01:14:04PM +0100, =C3=81lvaro G. M. wrote:
> > SPI devices using a (relative) slow frequency need a larger time.
> >=20
> > For instance, microblaze running at 83.25MHz and performing a
> > 3 bytes transaction using a 10MHz/16 =3D 625kHz needed this stall
> > value increased to at least 20. The SPI device is quite slow, but
> > also is the microblaze, so set this value to 32 to give it even
> > more margin.
>=20
> This doesn't apply against current code, please check and resend.

Sorry, I think my=C2=A0email client mangled that. I've tried again with git=
 send-
email

Thanks,

