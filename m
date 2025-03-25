Return-Path: <linux-spi+bounces-7301-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB1BA70770
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1362A167E21
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2925332E;
	Tue, 25 Mar 2025 16:56:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5A719EED3;
	Tue, 25 Mar 2025 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921777; cv=none; b=T94IJ6Qu8ILLLyTQEPP92NpKRaStevOaOtNh3ARnFw07etHoKO8rzuNu+y5mOpE4CZ7tdbQEQZeo20cVcfHVg3n20sGnvDmXraIclHu98nkuypS0I9nbZsgStLZAZfYD8gXOF5K8o1yh/2V3ZhSVpEzBBM5rHZClThAMU/1d07g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921777; c=relaxed/simple;
	bh=jxuku+BwViW2bttBVWyXeQfX0sVvb0gyBGvd7R78hmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLiNmSHulS9O05RyV70M+rw/UXYlGndK3CPRhCDbsTMhP/eUEV3B1t8KCjYccyXI2AAwce4g7pkkm60oTGo14Xs/PoG1ob4UWE2pBAMXZE2l56/K2LngY2FgjFzvN1S8qY1w1hCRCG4lK+tEI28HEgN6MAALk+Sw6O7T/OyTsUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abec8b750ebso1070421366b.0;
        Tue, 25 Mar 2025 09:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742921774; x=1743526574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDmsaVLnWhL38x8/UhQJRCae72OxIJbNZqkcgNzQ/Cs=;
        b=JDGdvqCJvEhSP5BcK2xkv8imKAH6r4ZiTiyQYN6fttNZyq+y7kaL03XfqKTJOIUGog
         0OxlGxuf5kDKVURiEeVbQP8MhyQMvkmRYcIVv9qH5vp72N4Wa/kUWuINiLF2DCBZicrg
         PQpGZqsGv+BYIVtOS49Apu79QW7v01XwgeGM/pfifUwFUq+WcwrYaI2OQ6bPfUcnLPTO
         GO2WcXcAeC/AUcvGtRr6iF/ikQfHEtG79/y71RRH2U49xhb+ljbPo763+NxN0wPq5E2g
         v/YTd+eWsIoMVtPtdUJ7+J6UYzpDR2Dw5HZUwpdWcbo0dVRHHv2rapAsxo/fU0+pQ4V1
         2odA==
X-Forwarded-Encrypted: i=1; AJvYcCV5QFhGXmEUSngQNgcd123DuItk4tjmE8PlHE0KRGZI3kELF4hFf5NdqBDK7UGpgtDNahqChzxrgo4b3Rk=@vger.kernel.org, AJvYcCV7rx6QMESx7ZxpnDrBDZmdfIv0HTX9ROjU4uH7Afnd4ZSPP7Oztl6g2k9mtozevomNbXJxTYcc69q6Xjg=@vger.kernel.org, AJvYcCW9ceCHUS58l4JqidaCIuYTTl7ApnQqx5azWDIOo73nGK0AA+xIwygy1vOXYRX/x/jXtCD0kcz63wUx@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMVbGgGBCzql8Jyc8Bk9UtyZCGkbWcullpq3YTO6bP3o/ptAb
	47huCZcsXZzmje4PhlMJ/FXaMJm533jxiJAzljPFX79yIpmM5gl8
X-Gm-Gg: ASbGnct/QCkgmEkEXzRTMU6AQqDTQtLWknPy2YCO+x3uRwqyALGFVucSLaehVTAWREN
	i0wlhaNgv+kwxURKBUBEgO5KVw+i0N/GAvkserGybLJq7GSS1jciqtm+e8bKewGgN+g5cc37Rdz
	llDxLaOAsPevevjzjquF8Cf2njC+WDK+geWm+3sHkiu7CB7iRTB5gwSZ+09TerFM9Aw7kVP97cQ
	kwg/9g/THhk4bJD0+++3fsPkeb/eMgkXkJHneRD4VQ+ozCdFNZ4X14O/giOPRUBen4I8Di70qW9
	zakDzK3EbvbmOEhZuuX07GetgDGqsQeR2QY=
X-Google-Smtp-Source: AGHT+IGltnhVp73DG3dXrYcKaVFfrwe9oR0ket6TpUwmTxoxXnZqnsaw24+56AxozKCZmo4yBMiqBQ==
X-Received: by 2002:a17:907:9444:b0:ac2:c1e:dff0 with SMTP id a640c23a62f3a-ac3f212b6efmr1598318466b.19.1742921773784;
        Tue, 25 Mar 2025 09:56:13 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd47d66sm886259166b.166.2025.03.25.09.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 09:56:13 -0700 (PDT)
Date: Tue, 25 Mar 2025 09:56:10 -0700
From: Breno Leitao <leitao@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, jonathanh@nvidia.com,
	skomatineni@nvidia.com, Mark Brown <broonie@debian.org>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, noodles@earth.li,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <20250325-delicate-kittiwake-of-emphasis-3eeb6c@leitao>
References: <20250318-psychedelic-thundering-guppy-22bba2@leitao>
 <b3da27ce-161b-4462-a608-c36f4b0696ce@app.fastmail.com>
 <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
 <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>
 <5doq6itaz6uicvqcn37q2dkaxyzy3etz5qgv6wlsyd5troqlag@yqs6ltjp3gsz>
 <20250319-unbiased-rousing-finch-95ecdf@leitao>
 <ac44uxpojpov7fcdx3qfiif3idhbp2hrrr4efqeat6jazbosv4@uoy72g6u3ibf>
 <20250321-colossal-binturong-of-debate-055aeb@leitao>
 <5dky6i7v2ml3eggy5slmxcw2rqi5xofcan2uqx7alcvh6744cp@el5ybhfevgfg>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dky6i7v2ml3eggy5slmxcw2rqi5xofcan2uqx7alcvh6744cp@el5ybhfevgfg>

On Mon, Mar 24, 2025 at 02:17:11PM +0100, Thierry Reding wrote:
> On Fri, Mar 21, 2025 at 09:28:34AM -0700, Breno Leitao wrote:
> > Hello Thierry,
> > 
> > On Fri, Mar 21, 2025 at 01:40:44PM +0100, Thierry Reding wrote:
> > > Can you maybe help clarify at what point you start seeing errors induced
> > > by the recovery mechanism?
> > 
> > This is after a while. Something happen to QSPI and the warnings and
> > device reset failed start going haywire.
> > 
> > Most of the machines are fine, but, some get into this situation.
> 
> Is it always the same devices, or does it happen randomly?

We got this in two different and unrelated machines, already.

I want to come back to how the driver should behave. We probably want to
distinguish what is the correct behaviour we expect from the driver,
they are (IMO):

1) The reset handlers are NOT optional and the device should fail to
   probe.

2) The reset handlers ARE optional, and we should mark them as such.

Can you shed some light on what is the right behaviour we want to
implement?

From what I am hearing, we are more inclined towards 2). Is this
correct?

Thanks for helping us to figure out this issue,
--breno

