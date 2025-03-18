Return-Path: <linux-spi+bounces-7205-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 587D0A67BE5
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 19:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B04A3B7674
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 18:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE03212F83;
	Tue, 18 Mar 2025 18:29:33 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B328212B11;
	Tue, 18 Mar 2025 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322573; cv=none; b=af3FrkSFmla+pPQ/bCpqZvAJlZFTqiwJbBKtJ2w8xfF3IqwmR+YedpfotA74VfqpZIiuv9RA31lv12CpO/3H23aYtWqw6igA2UkXHs3cgivh/fvNGaEnpmU8BTUL2vJDncjZGCWYdB76dFUk59wrsnvtzXUNluScrHLx4UOimMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322573; c=relaxed/simple;
	bh=XZaU+QsgriE+0W7uTBGeRFEwNDocH42OQl1yF2GceLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmvGW+j/rmzRD9H8Mt7ZxRVa/Ycdv6osLzjp/jgDtBKJFK3nBumt5KTBC6Qxo/5nD3152/7uGsGHSnzH5N0A3WXwvRhp0vNzvQr+XXOVg5ksol7UUgVSjTMjEF6aoI37gQiuh0EGXQovGCieGku+incz2bgUYtK6q9HcLpwr+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso1137495866b.3;
        Tue, 18 Mar 2025 11:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322569; x=1742927369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDRi+b5i5EYNJWCCIh+kIq/LKRqZzfsFXrDryAUVhac=;
        b=Mzr9MwqYWqMksgzkncYwUrXSntpMybCUoQAt6zC8ueVO4+w5+bJAIUChI8bN+Vtz+y
         kf40RHIiWu+HZqTsUk36PE5rDYUFuOMkuXiQ/Mx3yPJlF4A6JH0FrtFFtccSP110VxLo
         tlr0h/14Ysw8I0Pt5T9upPGEJJ2WwI7Dual/xX1mJevJz/zAThQKmFU36ID2tyYJaANs
         HXytVoqeTxXD04E8nW8nHWwhNf3pgMkMPfTLB8CE93eszKVqzZkaQ+e4ALB0t3/5Zo9Q
         O+bS4BHJJOFGoathI0jCzhHJOy6NHViPKLO4Sb/XJyWvMOeRmfJ5lLauvobyLSWbc9n6
         ePVw==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+OK98TWj4YFbVEzda86d22SEexLe3gGMyPtxtO8e7fh7FnNIse+5EC5vNMKuYFLBgnPKCWaS1IvBvYk=@vger.kernel.org, AJvYcCV/HTts08ueu+h8k8bc3I9L1WyL/MS1CV8LC5S1s/B6Qq/bn6VbJMv+ol5ejLgo4J7pgLM/7FNcy99d@vger.kernel.org, AJvYcCVz4Ca2/J4rM+igK3t1TLWV5T1zRXxfsiyLFDZN49BejNJLMOs3nkETHqyzxleGe49r3SE3S1ePWj6zlj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAF2JqQkvMKKgxZrhTP2rXyhsSMcQiCXrGrj2CX71LcwFG/D9Q
	qifozIHK0rsW8/59aSLDWSP7EgAYkawiUzibYAD3Chm4dKCfmNoS
X-Gm-Gg: ASbGncvyV9ZtXDsWPROgVBReTd4g134URyy9Dvu5y/0r488TAa0u3fYsH+QNrX7fTP+
	pFm2K1+aI2fB/iqyml+UgM4+LEkM8+9T1hycsd+e0dASeItZw/oZFfbHELBeG/c9/5nLq7Flun1
	kW2wWjHNkImWew9sJH3XGz8KtYsedHmR63glfVZ6XHU0YWrPHz+rCyNh9YCrqfHcdVoVqSaoWuK
	wJX4AgWOWESq8Xny5i/Mhs78pZ6SakCNgpujExLqr+dwn+PnGhEYTh7Rvm0mQVvAVQNPbCFw3tk
	bU/XVDLq5j9B9Cb7jZTj2sotS3GHs+R+OVw=
X-Google-Smtp-Source: AGHT+IFAA5JEMWN9EDWXhPMtJl8yiQlPxhUb/jPzaC4r+MCQp7Zku3g5WtLrzvfx7hVBHJwjcPAEQA==
X-Received: by 2002:a17:907:1ca5:b0:ac3:47b1:d210 with SMTP id a640c23a62f3a-ac38d552aa7mr595210566b.39.1742322569269;
        Tue, 18 Mar 2025 11:29:29 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bb0sm874764466b.47.2025.03.18.11.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:29:28 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:29:26 -0700
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
Message-ID: <20250318-boisterous-adorable-chowchow-cea03b@leitao>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>

On Tue, Mar 18, 2025 at 05:34:55PM +0000, Mark Brown wrote:
> On Tue, Mar 18, 2025 at 10:02:47AM -0700, Breno Leitao wrote:
> 
> > Makes sense. Another question, for platforms like this one that doesn't
> > have the device reset methods, what can we do to stop the bleed?
> 
> > Basically every message that is sent to the SPI controller will fail,
> > which will trigger the device_reet() which is a no-op, but the device
> > will continue to be online. Should we disable the device after some
> > point?
> 
> The SPI controller is only going to be doing something because some
> driver for an attached SPI device is trying to do something.  Presumably
> whatever driver that is won't be having a good time and can hopefully
> figure something out, though given that SPI is simple and not
> hotpluggable this isn't really something that comes up a lot in
> production so I'd be unsurprised to see things just keep on retrying.
> I'd expect to see any substantial error handling in the driver for the
> device rather than in the controller.

Good point. In my specific case, this is coming from tpm_tis,
which is not aware that the device is totally dead, and continues to ask
for random numbers:

            tegra_qspi_transfer_one_message
            __spi_pump_transfer_message
            __spi_sync
            spi_sync
            tpm_tis_spi_transfer
            tpm_tis_spi_read_bytes
            tpm_tis_request_locality
            tpm_chip_start
            tpm_try_get_ops
            tpm_find_get_ops
            tpm_get_random
            tpm_hwrng_read
            hwrng_fillfn
            kthread
            ret_from_fork

Looking at tpm_tis, it seems it doesn't care if the the SPI is dead, and
just forward through the requests, which never complete. Adding Arnd to
see if he has any idea about this.

Arnd,

Summary of the proiblem: tpm_tis is trying to read random numbers
through a dead SPI controller. That causes infinite amounts of warnings
on the kernel, given that the controller is WARNing on time outs (which
is being fixed in one of the patches in this patchset).

Question: Should tpm_tis be aware that the underneath SPI controller is
dead, and eventually get unplugged?

> Obviously there's something wrong with the device description here which
> is upsetting the controller driver.
> 
> > Regarding this patchset, I understand that patch #1 is not ideal as
> > discussed above, what about patch 2 and 3?
> 
> If I didn't say anything they're probably fine.

Do you want me to resend those two separately, or, is this thread
enough?

Thanks again,
--breno


