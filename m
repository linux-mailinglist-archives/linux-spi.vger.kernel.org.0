Return-Path: <linux-spi+bounces-2835-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 130778C4528
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 18:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7641F21715
	for <lists+linux-spi@lfdr.de>; Mon, 13 May 2024 16:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2315B3;
	Mon, 13 May 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b="aA/OnQIz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE751CD06
	for <linux-spi@vger.kernel.org>; Mon, 13 May 2024 16:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618223; cv=none; b=qau2rioj9C5z6WozOyjhqUQEEa8CslVErnk1rZ2kmDY8pVrD33t4OY5oC+M524WwhhbqA2+iOR/FttUw+F78bN2eGGOEr4WOtZni1PuIM3EvJbxJ0dyrS8rMk+lkH5aSy9mgI3M5umGuVDatD49GDASs+vx7Vk1IlKTS9Kknedg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618223; c=relaxed/simple;
	bh=HB/ZQWK82QJzttDHy6A5em5xmW4L2ZDmWpvy9z6d6Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXv9YUeWSRs9F0M9oyv+vw3V76Um1Ix+PTd+fyv7/cFF4IdziZQ7oRdxHVc+kmNzncX+YxwHyX4JYfUFZornc6ICaH2kIGfIRhEwMOpbK7jZ2sU197UJrCxvvd7NGF0XAGjXOh5cBLX6xkpCMR6udqSkhPXQt7lQi/1LxAC0Rs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com; spf=none smtp.mailfrom=hefring.com; dkim=pass (2048-bit key) header.d=hefring-com.20230601.gappssmtp.com header.i=@hefring-com.20230601.gappssmtp.com header.b=aA/OnQIz; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hefring.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=hefring.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-792bae4137bso467992985a.3
        for <linux-spi@vger.kernel.org>; Mon, 13 May 2024 09:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1715618220; x=1716223020; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UhNPxyDIoyt90UWgtYorTleVUvtJf0Skch2qUWjrKUo=;
        b=aA/OnQIzWdmFAzVZUoybkQLbPHPGRjK9jzSLnuEulA0kOqGdr51eC4/XJGCDBkV/EB
         cBzpUvIUmNMwJ6JHfMZJvZGjnFDvcAcCGNgkw1SSQ8PG5r4pDq3EwntqYMotnzduY8mZ
         NDntGqNLXyfndyguwa86uSDwGm4XaJdUoQ2o5KAEJjhgn2X4jceRMziWAOyTDd9+W+Lv
         s46vjgvC0PoYmcSxJk1K2moZymhMrmcSrP1RTV9a7y9CpDacDaLh1/O3C5j52eAaCbZz
         0JO6puVbOVbMX57/3pPHeA2XSEG8a4wAcqcWfXLUFAkjQ6J3U2Bppm19wnyhfKlniseT
         c2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618220; x=1716223020;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhNPxyDIoyt90UWgtYorTleVUvtJf0Skch2qUWjrKUo=;
        b=Kb0d7phhjHKpQVeOImZwI+6N7pewqbUYFW5frdYfqTjF+p1RdCVRaKz53JuF7ZEG5R
         ItJFDOglcNMTPxoN0fleCncXZdrDwrJ64DSHC/VfUsoxKZCElke2twOy+Tbk5oG8uGHd
         clWMEf65byO5WpERcx1p2oDFhNMAKVhNw6PCKQY783PHfGvPMOM2TnXEmZqDj2YK18El
         adihyJXFjTtVOLvvm5k74J6+TrRnaHC9N5H+EUmR/C0pImet63oo3IFaWgp4l2jRBBXP
         8PVPDC/romviQGUInBqFUtQWwPCyunogsIWltHEPSZRn1Jtyo5JGmJA6X4DkBXQTICJu
         C+kg==
X-Forwarded-Encrypted: i=1; AJvYcCVTGG+PzV+fHFw+iaeugozSTrj6N2pTvL2OUxqhLBEV7X3aSnXfXpyRyifJPbiNdGU2rg8Bx12cnNwnxyfYEzMWgea3QLQcijNB
X-Gm-Message-State: AOJu0Ywkzh6oVZ2e7zFBKARCgTFVlF5tNL+hDWP/wRNdqUlrH0Twrvce
	EnTykQy2ulUHrT8pYnAl5v5/OUgbF7KOP7We7iWYzKE04ENMkwOtbfp9eCEK/Sw=
X-Google-Smtp-Source: AGHT+IHR+PMA8mzP/ODUs2ari2ZHO3kfobx2t3yRaJYmectZkzl57AVHabUnpaYuaTgcCtztbZ6HWg==
X-Received: by 2002:a05:6214:319c:b0:6a0:81b4:9871 with SMTP id 6a1803df08f44-6a16815f5a4mr84632286d6.15.1715618220631;
        Mon, 13 May 2024 09:37:00 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d6f30sm44727336d6.110.2024.05.13.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 09:37:00 -0700 (PDT)
Date: Mon, 13 May 2024 12:36:57 -0400
From: Ben Wolsieffer <ben.wolsieffer@hefring.com>
To: Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, linux-spi@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH v2] spi: stm32: enable controller before asserting CS
Message-ID: <ZkJBqSbJakye6BBc@dell-precision-5540>
References: <20240424135237.1329001-2-ben.wolsieffer@hefring.com>
 <39033ed7-3e57-4339-80b4-fc8919e26aa7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39033ed7-3e57-4339-80b4-fc8919e26aa7@pengutronix.de>

On Mon, May 13, 2024 at 10:29:49AM +0200, Leonard Göhrs wrote:
> Hi,
> 
> I am in the process of updating an STM32MP157 based device from 6.8 to 6.9
> and have noticed SPI related issues that may be caused by this change.
> 
> I am testing on an LXA TAC Generation 2 (arch/arm/boot/dts/st/stm32mp157c-lxa-tac-gen2.dts)
> and the issues I see are SPI transfer timeouts:
> 
>   [   13.565081] panel-mipi-dbi-spi spi2.0: SPI transfer timed out
>   [   13.565131] spi_master spi2: failed to transfer one message from queue
>   [   13.565134] spi_stm32 44005000.spi: spurious IT (sr=0x00010002, ier=0x00000000)
>   [   13.565145] spi_master spi2: noqueue transfer failed
>   [   13.565183] panel-mipi-dbi-spi spi2.0: error -110 when sending command 0x2a
>   [   13.769113] panel-mipi-dbi-spi spi2.0: SPI transfer timed out
>   [   13.769163] spi_master spi2: failed to transfer one message from queue
>   [   13.769164] spi_stm32 44005000.spi: spurious IT (sr=0x00010002, ier=0x00000000)
>   [   13.769177] spi_master spi2: noqueue transfer failed
>   [   13.769210] panel-mipi-dbi-spi spi2.0: error -110 when sending command 0x2b
>   [   13.977028] panel-mipi-dbi-spi spi2.0: SPI transfer timed out
>   [   13.977082] spi_master spi2: failed to transfer one message from queue
>   [   13.977095] spi_master spi2: noqueue transfer failed
>   [   14.460924] panel-mipi-dbi-spi spi2.0: SPI transfer timed out
> 
> Followed by workqueue lockups and the device becoming unresponsive later
> in the boot, preventing me from logging in and investigating further that way:
> 
>   [   17.026263] spi_master spi2: noqueue transfer failed
> 
>   TAC OS - The LXA TAC operating system 24.04+dev lxatac-00011 ttySTM0
> 
>   lxatac-00011 login: root
>   [   62.434326] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 44s!
>   [   62.441321] BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=-20 stuck for 44s!
>   …
> 
> Reverting this commit fixes the issue for me. It may be some time before
> I get around to investigating the issue in detail, so I thought I should
> ask if anyone else has already noticed this as well.
> 
> We are currently in the process of adding the device in question to
> KernelCI [1], which may help in catching such problems earlier.
> 
> [1]: https://github.com/kernelci/kernelci-core/pull/2542
> 

Sorry about that; it looks like the STM32H7/MP platforms require the
controller to be enabled later. I agree that it should be reverted and
I'll try to think of another approach.

The STM32H7/MP devices are significantly different from the F4/7
devices, which makes it difficult to change shared code without causing
problems like this. I wonder if it might be better to split the F4/7
support into a separate driver. This would duplicate a bit of code,
namely the initialization in probe, the baud rate divider calculation
and the SPI mode config, but would make testing easier and get rid of
the indirection that handles the different register offsets and field
masks on each platform. The code for actually transcieving data and
handling IRQs is already platform specific.



