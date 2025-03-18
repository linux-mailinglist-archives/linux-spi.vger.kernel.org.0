Return-Path: <linux-spi+bounces-7206-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A23A67BF2
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 19:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED7591893925
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523001A9B53;
	Tue, 18 Mar 2025 18:32:47 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F7151990;
	Tue, 18 Mar 2025 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322767; cv=none; b=ARl6RO4fj8I3YVyKXBNjo3QhYncVuLD2xUXXClFmP4gxsd0bgMnJnB3+alSLYqYJoWrah56IV5roA3Vd3lq3sssSQNyrFrxSl0tVKXi1fDNI/p+u4QZE3duufClYz3TcOvkLqDy0ZxELOLngE2F/PZBn8ArfWjD3EKRqf31ivEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322767; c=relaxed/simple;
	bh=JqI0iFFNiB4IH3PEsiZwINZ5Ndy+RJYc4p0rp9yRLWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD4vYJuIISTzmUsEVD+LSB3yWYJAE/b4rSlQTUpKMUovqhJCPkLiYIY88YKdXSaEVtnt4Zo1j08yIIE0VnnAHlnymEK71dAL5NTVi6n85jLVEpWpJOgt5fFEHUZUZbbtpOo3MLCU4KXnUHW12YsSCcgNoJZCZNfl3Jf1nC7WWY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaeec07b705so937571566b.2;
        Tue, 18 Mar 2025 11:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742322764; x=1742927564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMS+hiRhtQW64OwJHH62Y+RuDNXIO5eGz38BBMChwO0=;
        b=lC6y2oqbm5reiQeBoOtAdgNRbMJ46kBVUeestSmM7gnMaql6lmnLq3VYdKbXSqZ5ns
         7DqocMdbxTysTV35viOhTWrIWhvFxcvDZfwNTotU1wnoOdBhEP79mCnzF6wPuJ+xmEeF
         Dq0CELC7/kuP6wcJMadxNGPEIAgYi4RMBbz6kycB3eOhryITFKeuP1o/TShvlaAMdzvq
         7D1SZahsOc4zJMhBysa/lnrbLnwRcunsCCEMq1vXPc0wPnWHwGQpSAl6tk6UksVkOVPC
         +GUjLqT8L8lFWRYLteO8sE+Zwi6wEdfz54gkeLViQ9kZRyjMNqDgRNzQPMIKN3xMx4LK
         ycKw==
X-Forwarded-Encrypted: i=1; AJvYcCU3vunTjprRscIoaNwPiRhk5e+oW3vxi6d6bMgGqyBK8QUkuCbLpbQRdHNUFFm4a20dFJkLjrXK2aXnyJ4=@vger.kernel.org, AJvYcCW5kBSb7Bq+acVS5aoZAtZLgIfX7YD5904i1featfrFJibYwpsNiSUS9sEAqL0coNAhRtUdIIyVwizDqEQ=@vger.kernel.org, AJvYcCXWJz9NGz0YXnp9YJy8x+WO7GH9VHlkkaZllkbY+xIOgIJBMxIrtCZ+Lw2ixYVtQZ45gd1fF6u5OFNX@vger.kernel.org
X-Gm-Message-State: AOJu0YzpTU4Zxj7TfdtsGf8KWuhrDN9XjasWNOsYXCEzh1hGTzvDt2TU
	6CDaqNciMROc/Jdqtq35FLcXGPwDWgL9xpfEoZuPkgBxNt0Z9XOo
X-Gm-Gg: ASbGncsz7cVzsTgpiwKqF0qLxmU7VEKDkjk8Z5z099h39j2gVLhqi6cvkcYR7I67pCo
	yp1WVZ8+GOUAblHqN+sWzYkRcZ85KUEbMde0kJNndoGQR/sKxeCcBvdFTvwwXW1NICs6iGs7ajZ
	w+pm0hXcMEKDAyRtr4UeFJGIh8w0DjzgGYo0n3HqwolPqnlh2WIDAsRkhfl8W6E1VY8jAWyBNV3
	Dm9780SiazJCFLD8zOgT9y4dE0ZjZKnVwsL2jacMtC4+4spUPAEnEkvbXeNlCDJ3odI5u6HF87L
	Abeag9rkuUUbFdIilxWVQC6uHpYq4+fVXPw=
X-Google-Smtp-Source: AGHT+IH87svm/sWe/ibvNzw0jLJOxbsLaNLq729RaCN0RvGdfJE8rNMTwuSwWUV4gDon4j6NlMfcKA==
X-Received: by 2002:a17:907:36c1:b0:abf:7406:a5c3 with SMTP id a640c23a62f3a-ac38d8d216dmr552092666b.51.1742322763761;
        Tue, 18 Mar 2025 11:32:43 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aea1fsm877951066b.22.2025.03.18.11.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 11:32:43 -0700 (PDT)
Date: Tue, 18 Mar 2025 11:32:40 -0700
From: Breno Leitao <leitao@debian.org>
To: Mark Brown <broonie@debian.org>, arnd@arndb.de
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>, linux-tegra@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	rmikey@meta.com, kernel-team@meta.com, gregkh@linuxfoundation.org,
	noodles@earth.li, jarkko@kernel.org, peterhuewe@gmx.de, jgg@ziepe.c
Subject: Re: [PATCH 1/3] spi: tegra210-quad: use device_reset_optional()
 instead of device_reset()
Message-ID: <20250318-psychedelic-thundering-guppy-22bba2@leitao>
References: <20250317-tegra-v1-0-78474efc0386@debian.org>
 <20250317-tegra-v1-1-78474efc0386@debian.org>
 <22ffa8f5-6590-4602-853d-ceffed580f22@sirena.org.uk>
 <20250317-solemn-debonair-sambar-f04fa7@leitao>
 <f3e47d12-f6be-4bb5-b87b-84aa0037e1ef@sirena.org.uk>
 <20250318-cuddly-translucent-teal-e2ac2d@leitao>
 <6355bbb3-a4b1-4fdc-8a97-d81bc5e1cf65@sirena.org.uk>
 <20250318-furry-piquant-orca-da28c2@leitao>
 <47c40ec0-291c-4664-a66e-d76bd6360c0d@sirena.org.uk>
 <20250318-boisterous-adorable-chowchow-cea03b@leitao>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-boisterous-adorable-chowchow-cea03b@leitao>

On Tue, Mar 18, 2025 at 11:29:26AM -0700, Breno Leitao wrote:
> On Tue, Mar 18, 2025 at 05:34:55PM +0000, Mark Brown wrote:
> > On Tue, Mar 18, 2025 at 10:02:47AM -0700, Breno Leitao wrote:
> > 
> > > Makes sense. Another question, for platforms like this one that doesn't
> > > have the device reset methods, what can we do to stop the bleed?
> > 
> > > Basically every message that is sent to the SPI controller will fail,
> > > which will trigger the device_reet() which is a no-op, but the device
> > > will continue to be online. Should we disable the device after some
> > > point?
> > 
> > The SPI controller is only going to be doing something because some
> > driver for an attached SPI device is trying to do something.  Presumably
> > whatever driver that is won't be having a good time and can hopefully
> > figure something out, though given that SPI is simple and not
> > hotpluggable this isn't really something that comes up a lot in
> > production so I'd be unsurprised to see things just keep on retrying.
> > I'd expect to see any substantial error handling in the driver for the
> > device rather than in the controller.
> 
> Good point. In my specific case, this is coming from tpm_tis,
> which is not aware that the device is totally dead, and continues to ask
> for random numbers:
> 
>             tegra_qspi_transfer_one_message
>             __spi_pump_transfer_message
>             __spi_sync
>             spi_sync
>             tpm_tis_spi_transfer
>             tpm_tis_spi_read_bytes
>             tpm_tis_request_locality
>             tpm_chip_start
>             tpm_try_get_ops
>             tpm_find_get_ops
>             tpm_get_random
>             tpm_hwrng_read
>             hwrng_fillfn
>             kthread
>             ret_from_fork
> 
> Looking at tpm_tis, it seems it doesn't care if the the SPI is dead, and
> just forward through the requests, which never complete. Adding Arnd to
> see if he has any idea about this.
> 
> Arnd,
> 
> Summary of the proiblem: tpm_tis is trying to read random numbers
> through a dead SPI controller. That causes infinite amounts of warnings
> on the kernel, given that the controller is WARNing on time outs (which
> is being fixed in one of the patches in this patchset).
> 
> Question: Should tpm_tis be aware that the underneath SPI controller is
> dead, and eventually get unplugged?

Adding Arnd to the email.

