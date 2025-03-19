Return-Path: <linux-spi+bounces-7221-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B93A6891B
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 11:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C3D3AD1C5
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AB24FC1F;
	Wed, 19 Mar 2025 10:10:04 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789F51F4CBE;
	Wed, 19 Mar 2025 10:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379004; cv=none; b=dIBMjbi2QxB6EjGq33nRz+DhD/26L+OwK3fyfdqnoO9yU76HscKeNj0cgrJNZGPlXFZOyQkCYo6+MWRWqlSalED0iFldVt//MKWz3nDsdjM1zHuKgA5fq0VgRrDAGsMxvbIBlypp4l3LTQAV1jXDUqUKL/S8ZSuUVITHLdRBzgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379004; c=relaxed/simple;
	bh=8ycg39I2wHuY+9uPk1NX0odRnxkh8w2jlOGBQ6BT3bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKOWo6ExfxMJMLPtolkyAPCrmIEgqSWS2gDLGiu2y2b0ASogy2iccdzWuOVRiLNnzRCYiiV3+RSaKeOlwJeIYEvRpPlEIxoMqYY54Lpy3lCuAgaVUDTNO9540z1av+R50Y7+RqrvHo4ALk0BAo7b2443bVouPBt9jCJ+qwd6fAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e61d91a087so10129682a12.0;
        Wed, 19 Mar 2025 03:10:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742379001; x=1742983801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mR0/XB887KCpYdNFg9r9RqYX9JCiuL75dasck2rSEYY=;
        b=Igb9XWiMiUS0Q71IeWL9X3svmcHMYCtuREbK6Y9pm527or8tKSEmRTVpVT0mwO7EUf
         nPj0azJ7IJJf9JrisYvi0XQjDOaNHSM5BjsxlOxyhJI4vMARyPd3ey519vCekzAOpSIA
         4viy4PrHOrwhRluJMsbjg4Ehi7t/cHVTC/S+2PQB9kPCSB8uhhXYxbXxMtlMq4esnupj
         jieVhBhMwXZa/zuUIosM8vczUuTZGaPfoRuMwty4ky33yQ/mUA0lMSxUEtmAjJQoTK7X
         mlkDVS0MKjNyF69DiNCcFRFQ2CKvSCEO96NmbAsw199mqzJHcQ4MyQ/AcCkqIr+aFloR
         h7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGy1rAEyCq6OZMy/VBNo70r80pceMXqlFjCy8XCc7AYbZY8ktVOiluq02nVp+dyUdRpwirNalXu7f+@vger.kernel.org, AJvYcCVliSKrN6r2rJmY24gFb360sfk0T/HL658psY066HfLkEt6ZDuRZT+//HkbVpWixHUfBDFLZvXAH2aRuco=@vger.kernel.org, AJvYcCXA17dGPeZGqML3i5jNoGUUYIKJXiiwBz5j3k9g0LimuSUc15DF4d6EsLj1skuyPil8ErxwRevwh5Phyjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9urZLHKx6TIJSh0iKD+iKRkfjBIkZrqHwCfG+PioMhgqmsRaI
	+fzIYgMCsSeb8hQJ7Hl3solD8AY32b2gTVgWAhs1aRn0GIokOo1D
X-Gm-Gg: ASbGnctXcLMr4tplNkWOnYLSD0T5OahDCGZChmoESyuG8TJMKK/n4OLcsb4BsQ7BXUO
	qlpjZVJp/kbbFjdUd9XiZKWSPh+4umS+0PIowK4r5Wlfl2MGK1m2/gLOvsWTGMExlw+tnv/Ut+1
	tIygVvpG8mqN6FIBdFI1ArR0Mg4B1KIuG10XDE20k9d8z0xlhKBKw20tsoDaB0BCy7oNbAVm2X1
	TcPbD4sZv3UF4pEFTBe0Mm0ENP+i87HD7SE02UO++UxRISnCPkKMtQJGu+tyUwCzHqZ9vV/2yxA
	TmRflvFg0pnwu3+h9ZCjrd9ih6pPjMYTYfE=
X-Google-Smtp-Source: AGHT+IGrRhA3xHX7uqYSsvheB0imCylMZtgzaDJ8aubkr0yjakEs8ZGZWHrPAdMOtzawR/3J1d9eiQ==
X-Received: by 2002:a17:907:944e:b0:ac3:8896:8c47 with SMTP id a640c23a62f3a-ac3b7f79431mr211303066b.47.1742379000383;
        Wed, 19 Mar 2025 03:10:00 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac314a4738csm981904666b.150.2025.03.19.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 03:09:59 -0700 (PDT)
Date: Wed, 19 Mar 2025 03:09:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Arnd Bergmann <arnd@arndb.de>, thierry.reding@gmail.com,
	jonathanh@nvidia.com, skomatineni@nvidia.com
Cc: Mark Brown <broonie@debian.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, noodles@earth.li,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>
References: <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
 <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>

Hello Arnd, Thierry, Jonathan, Sowjanya,

On Tue, Mar 18, 2025 at 09:07:28PM +0100, Arnd Bergmann wrote:
> On Tue, Mar 18, 2025, at 20:13, Mark Brown wrote:
> > On Tue, Mar 18, 2025 at 08:00:05PM +0100, Arnd Bergmann wrote:
> >
> >> That does sound like the easiest answer: if the spi controller driver
> >> knows that it needs a reset but there is no reset controller, shutting
> >> itself down and removing its child devices seems like the least
> >> offensive action.
> >
> > In that case it's probably more just refuse to probe in the first case
> > without the reset controller.  Given that the device isn't working at
> > all it seems like the hardware description is broken anyway...
> 
> Right, I see now that it's doing a rather silly
> 
>        if (device_reset(tqspi->dev) < 0)
>                dev_warn_once(tqspi->dev, "device reset failed\n");
> 
> after which it just continues instead of propagating returning
> the error from the probe function. 

This would be another option, and I would be happy to update this patch
with this suggestion.

This patch was attempting to address the issue the other way around,
where I was expecting that the reset methods are optional, thus
marking the device_reset() function as optional.

It appears that on certain UEFI machine types, the ACPI firmware doesn't
implement the _RST methods, and device_reset() will *always* fail. It's
unclear whether this is due to a broken ACPI table or if it was
intentionally designed this way.

Tagging the driver maintainer (Thierry, Jonathan, Sowjanya) who might
have a better understanding of the design in such cases.

> This is also broken when
> the reset controller driver has not been loaded yet and it
> should do an -EPROBE_DEFER.
> 
> In case of a broken ACPI table, this would simply fail the
> probe() with an error, which seems like a sensible behavior.

Do we agree that the device reset methods MUST always exist (on both DT
and UEFI hosts)?

Anyway, from my naive view, we should:

1) Mark as required, and fail the probe,  if this device_reset() must
   have available methods. (Arnd's suggestion)

2) Mark device_reset as optional if device reset is optional (as the
   current situation suggest).  

   a) If the requirements are different for DT and UEFI, then should we 
      create a "device_reset_optional_on_acpi_but_not_DT()" helper to
      handle such cases(!?)

Thanks for the discussion,
--breno

