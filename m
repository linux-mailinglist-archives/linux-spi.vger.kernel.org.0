Return-Path: <linux-spi+bounces-7203-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8EA67A55
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 18:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75EAE425393
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 17:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613EC211A27;
	Tue, 18 Mar 2025 17:02:59 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D636F20F069;
	Tue, 18 Mar 2025 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742317379; cv=none; b=GOqvlPfGguqE5Y8a2mBxx+RJRzmNo/oR7hGAZ3fiWE2STjmSdj1ltYly/pHyY3bWU7icwXNOsRIUCb2DezLT43po+k3UpIDSRH2ULItTux+cUqe7K7QsrE2E9dWdaIv2Z/ukM1Y+qM7mAaslBAABgk6AjjQQ7kInG6hf08DjZFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742317379; c=relaxed/simple;
	bh=nhtcbYHi5lm3IrxUinytExT68maJDKGPSfYxPLQRpdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBpyyBFXdRt5k7u5FctWRZWZ8FohTaknaEJEDakh4K+HiHa/D26rOQHZvm6ZbHEMWgBf8dTSUkRk5mP+p9Sd7HDEh7sgL3hp021tu2QL4KTlQ2GyCc4Ux49naWUtudCiBAoLGpbwd1Syj7wszh1qwShC4orlxZh38ZOCPmBDv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac29af3382dso966354966b.2;
        Tue, 18 Mar 2025 10:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742317371; x=1742922171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKMtKivFHG2YuzaLvPfKz8vHzvwRDQ2NNdJwGPgxU1Y=;
        b=mkCvJrklbTOQsttmwUtwgWDCCZ8E1ZnNvAGJbJkv+ckxVUHqY0lrY+g1dfnYskvPBp
         3Zeg4wkIjf38bWqmv+AC3FPFAvIAXGoGsqGXVFVrdZdtur2MnqhXTp1z4cR07mK8okaj
         GQEmemOYOFytbUrbitLzHWpNp+jY6Fbt/pgscTIyfRlDDD+g/VKSWJdlIhvhxeYcgpz1
         WE+P4S9s4JrlbxSbSmMNEJ9CREzqMvCKZ5eYOl2FBavX4pdxunA/I08SIcSCeAyTn5Ek
         /mc1FCtD9H6Le36HNvBWGBhykUIjamjenZii1VAsuH+YD8uYGTy913X/Doz3gqJP2MEB
         vfLA==
X-Forwarded-Encrypted: i=1; AJvYcCUBP1WztTaPhgpTVOVs6M1mJn76WE2ueaGYaiJVUj0ePUUSx1ZM1hcxn/CHzDAKu5J5gZOJu9dspxeY@vger.kernel.org, AJvYcCVZjUVyhdMDiUYhXMiWO7cxOW+qIaQMxStI4auqPuAI1SuqqdlV2OBs/zcdNWg4P2KH0awXW1wNfbF61gc=@vger.kernel.org, AJvYcCXVrmrv2W3Vdr0Sbr3SzG2ICFwSQj/W9CZj/JYNEy0cjQqM+VWuLnd9c80lQvPDS6qE8Ze/bUtl/7w/S6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDhf1mSFbHUQICE32qdhHZJ1tjt0JYhdpK9ySj/j4OUO6Z1d6c
	kQ5pvAfbiTPmMIokxvx3Ij5fPcQ3bnI6VjF3MLKNq41U2n54AxFFutdErA==
X-Gm-Gg: ASbGncvGjT0KHOVG6ZRt6xMPHzJzpW/eFaO0dCc1vVDAPvJuO2cwKPZNW2VCqoNLXH+
	Yx0VW7n3WZPn/C0mmofv8NYAn6r2MsI5oQ6WUCFL01Zqc3Y5ndCjFrm2MaYBKt0tRQekEwrjjGs
	FeDMDM5CagZVgSyeS85Y+82pv+0UZQpMMQa9rOYwPuxlaqEGMOY5+RJgiHgBRDIJ2pZj+G6xDFn
	jZ1aPXwyRvzdTskdaCrroEXD4kIH46vydLRt4Yck47qRYvVm4nTuJSwWATJtS8yiz6aplfTtacI
	UUS771jsAxI0Idj6P+4Gnl8+rsJPaCv78bg7
X-Google-Smtp-Source: AGHT+IFsRvAV0tA8fKhENsaOs9dC01WwOxgTrGI5Fm+CM8ivhTFPd0WbfT0Uf3RPtbYlJQNJ6k4X6g==
X-Received: by 2002:a17:906:6a0a:b0:ac2:892f:439 with SMTP id a640c23a62f3a-ac330444c7dmr1757583166b.37.1742317370711;
        Tue, 18 Mar 2025 10:02:50 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cfb96sm864228466b.119.2025.03.18.10.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 10:02:50 -0700 (PDT)
Date: Tue, 18 Mar 2025 10:02:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Brown <broonie@debian.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <20250318-furry-piquant-orca-da28c2@leitao>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>

On Tue, Mar 18, 2025 at 12:48:13PM +0000, Mark Brown wrote:

> Well, that's not clear to me.  It seems likely to work a lot of the time
> on probe but I don't know how well it handles a warm reboot for example.
> Like I say the error handling case seems more likely to be at least less
> effective without a reset controller so it'd be worth logging.  In the
> DT the reset controller is a required property which suggests the driver
> might be assuming it's got the hardware into a known state.

Makes sense. Another question, for platforms like this one that doesn't
have the device reset methods, what can we do to stop the bleed?

Basically every message that is sent to the SPI controller will fail,
which will trigger the device_reet() which is a no-op, but the device
will continue to be online. Should we disable the device after some
point?

Regarding this patchset, I understand that patch #1 is not ideal as
discussed above, what about patch 2 and 3?

Thanks
--breno

