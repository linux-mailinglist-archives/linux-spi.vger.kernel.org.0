Return-Path: <linux-spi+bounces-7359-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBEA74A7D
	for <lists+linux-spi@lfdr.de>; Fri, 28 Mar 2025 14:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD921733F1
	for <lists+linux-spi@lfdr.de>; Fri, 28 Mar 2025 13:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F5A136349;
	Fri, 28 Mar 2025 13:18:45 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C233BBF2;
	Fri, 28 Mar 2025 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167925; cv=none; b=sBNFR9eZptbPHSzKqp/L9LZi15WXOAzN63uDKRM6+R31F3oxCafEVGXXuu6cDtZKKt1wTGGtRyL8OeTL61GZuQ9F9BLAh/qskRE3WlzXMWdCI9tFBQ655p6+Qowg98ofiaU7msHF5NQviNyprxP5QWd5kej2FsMZxaJSaTCYNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167925; c=relaxed/simple;
	bh=HZOUS+PWb7Cr3MGhmbLuaegDSQ0rRmvqM9EEeLCZVCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW9a37ERW5KkuqqTKfI+76dQGh+gonD4kR/+/PfIriAJ4op2+cyUws2s/2PnEaFrSDuwNnrm9/f1thkaOKizjtBAV+yJ/fo943igYwp+/b2j2I00HHHmE1+1CeE4V7YVmwVjvDzTVFuGo16kAW4NHGUji5ufEYZK7Bc/IrXD/Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e535e6739bso3556909a12.1;
        Fri, 28 Mar 2025 06:18:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743167920; x=1743772720;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/J2cOgy63HBd3SFmOcX68BhFn1IrtAbwO7Zr3kIoI4=;
        b=C2KhYGrIHr/JcisPKR/0OwS0zqxR+zXtUY3nPKvvxPIzd3AYgwBhoMMDHCQLlX45mR
         7F9yXtfOirYpNwKlV8CJvMKvbCTFyPzLvo1BABinWLmOfwIPNhs+aKDSphVkHo/d6/wi
         Tx5EAPjPQOzwxC6cjRDpzxqZN8H/Y8DeYsFjilAZUImjPhi7wkv/COT68YEtqzIubQxA
         ckVib19tjywQx7hT77l070WsOT5KI61wL0Ka+108MgPWutqXQ3gDp/dXiWgDnfMZch5k
         GdE7UtN9W5YgaNTTgKcW7iTlwvB2mT7Lw9nM9WkG9PMEjHU8Z7BuxWZgDGcjK5qntHPR
         kQ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUMyH8ntBTJYhMmKmW4aoI4HqKOMvGXsJZJ8C12H3gMx3KiLhMpFL2CnoXBnCHtkemjxMdk87rknVvmFFA=@vger.kernel.org, AJvYcCVFacWXv2JSMI+74KY+iuiehTpkP2JAgh4XF1ZSXTdy8LN5RvTSnHoWR99k2E/Y2wRdFhXbV9zAXEh3@vger.kernel.org, AJvYcCVztgwXWj/VuCUFC2eg9G0tM+xQpj8CiWl9uDwwi86s3Q7gA3tKZJWzS9wLRddp1Nil2FVRzpyuOa/oBeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfyEV7hrmpM0u32FpKZuBaBWijJfSmUiy6lr0vx9u/o5+cBdf
	BhFzbnxIi1L0IG/FxnS7EjezaMwbqQTyPWf5x5aXYT7FQRW10wZh
X-Gm-Gg: ASbGncs/8UO/hDoY4wv1VqmMhimbyuF2c3f+/pootiWBNSY6v5M8y1a5aFxApWbANK8
	CpdvACATvTw2eg+BfmvxLhDPUafXavQFPYT/cLhiwKZWo3L/3uQ0GTDfRO4J9b97YE/zgzFy8lr
	fjUc/bHH/Y0ZBknDGz47XyCpV97DFlIAjBpW/FCgWU0fglwyJfKpa/jy9yjGJOw8eMjHR9yKuZt
	rfgJWCeTKtg/lWvTA+t89y0i7ci77TC52RAksSmqmPS4G2pyNpEdrR2De1Vxvw2A5xtBdcIRS4j
	iHvZmsOpUGJCgbSD0UOfrVCxh2+7hh0r5NM=
X-Google-Smtp-Source: AGHT+IH4nxWj8z2XCECUyRadqO61bkkhsUaebs/NIycC0jeOT18nTHV2isXTdzA0/o7nZufkWNF5iQ==
X-Received: by 2002:a05:6402:90c:b0:5e7:b011:6c09 with SMTP id 4fb4d7f45d1cf-5ed8e5a5425mr7129028a12.18.1743167919297;
        Fri, 28 Mar 2025 06:18:39 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16f12ffsm1398693a12.45.2025.03.28.06.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:18:38 -0700 (PDT)
Date: Fri, 28 Mar 2025 06:18:36 -0700
From: Breno Leitao <leitao@debian.org>
To: Thierry Reding <thierry.reding@gmail.com>, broonie@debian.org
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
Message-ID: <20250328-cinnamon-mushroom-of-proficiency-a17ba8@leitao>
References: <fbeca9fd-38a6-49ba-bb5f-6df5302d139d@sirena.org.uk>
 <6cf8af69-634e-40fa-af45-912540b29aac@app.fastmail.com>
 <20250319-aloof-rottweiler-of-perception-4c1ad4@leitao>
 <5doq6itaz6uicvqcn37q2dkaxyzy3etz5qgv6wlsyd5troqlag@yqs6ltjp3gsz>
 <20250319-unbiased-rousing-finch-95ecdf@leitao>
 <ac44uxpojpov7fcdx3qfiif3idhbp2hrrr4efqeat6jazbosv4@uoy72g6u3ibf>
 <20250321-colossal-binturong-of-debate-055aeb@leitao>
 <5dky6i7v2ml3eggy5slmxcw2rqi5xofcan2uqx7alcvh6744cp@el5ybhfevgfg>
 <20250325-delicate-kittiwake-of-emphasis-3eeb6c@leitao>
 <q53apce4sltvnyd75j4o7taatocxiduq56fqsoxp3vrjmaqphk@o5kce2wb3dnz>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <q53apce4sltvnyd75j4o7taatocxiduq56fqsoxp3vrjmaqphk@o5kce2wb3dnz>

On Tue, Mar 25, 2025 at 06:05:28PM +0100, Thierry Reding wrote:

> > I want to come back to how the driver should behave. We probably want to
> > distinguish what is the correct behaviour we expect from the driver,
> > they are (IMO):
> > 
> > 1) The reset handlers are NOT optional and the device should fail to
> >    probe.
> > 
> > 2) The reset handlers ARE optional, and we should mark them as such.
> > 
> > Can you shed some light on what is the right behaviour we want to
> > implement?
> > 
> > From what I am hearing, we are more inclined towards 2). Is this
> > correct?
> 
> Yes, I think 2) is what I'd be inclined towards. _RST is clearly not
> available for at least certain firmware releases, so they are de-facto
> optional.
> 
> Even if they are ever implemented, it'd be wise to keep supporting the
> case where they are not available, so treating them as optional is the
> right way to go.

Thanks for the clarification, Thierry! 

Do you know if this reset method also optional for device tree devices?

So, these are the options we have now, based on the clarification above:

1) Mark the device_reset() as optional for this device, as proposed in
   this current patch.

2) Ignore that this is optional completely, and let that "device failed"
   message to go be displayed every time the device is probed and restarted.

3) Create an "device_reset_optional_on_acpi_but_not_on_dt()" method if
   this method is only optional on ACPI devices. Waiting on Thierry to
   clarify this part.

