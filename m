Return-Path: <linux-spi+bounces-7992-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC302AAF3A7
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 08:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71D333B71C6
	for <lists+linux-spi@lfdr.de>; Thu,  8 May 2025 06:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFF228E17;
	Thu,  8 May 2025 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGTu2Fmd"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7D20298C;
	Thu,  8 May 2025 06:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685331; cv=none; b=iD00keMriCid/xvqS6YvQz4RaYND3Fsx6jdYUkudSZqZie7jWFqYWSMrLa4tv63LpVK+KiZofPujRIfO7GwzSwgLNqN7HM9YhGng+xmcIU164TvKmmijCvU8Ksh+l+ogmTUaXQ5m7eKTWnwN/RAEEJ7ayeFj+uBqzo1AxhR0whw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685331; c=relaxed/simple;
	bh=UTfT43DfYGsrBz0pan09byc5cJNTiyCIUxAyVV244CE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDyvt99+ZrFHPvT2ETPnAinyxPDYmY94Dk8jh8c7+EwFNgBGqONiJ5UasNmTV/C7vVV2QvkrtHeOYUyKK7sqoS3DiZP2ynNiA7FmKj0MMZGa7/nOALt7s1Xrc44DbMJoTHFcgqUJmxjoFs1sSPzuII5YPdrm/2PV+ku2YHT6T4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGTu2Fmd; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e6880d106so4836085ad.1;
        Wed, 07 May 2025 23:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746685329; x=1747290129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yGRiPozPCKlTceAlJbkKm3qZDESryv+qOsVno6iyAH0=;
        b=JGTu2FmdWOzepGjrLuGDEbQAaLEgQ99jWnw1NjWPlaGcA4is6G+8BOYXlitKCBUsme
         HhUecVoSEIfPdS3UhQQOPBmVXTBLO4fTuBvdt5RqsnutRhrn/OHfy5XTneLQ/o/7n4+Q
         nzjI5s1HuYcFL3zEIMaauFAP/2wvhFnURQ8onskiLY01sSnXsoACC8AeS7n42FqQTwCm
         4ReMFqLWs5B5zZV92zl/zr8kUm7/qJuRI2e03AfT8Hby3nKiA+PVYpZpzrYTvdF/2rY8
         qISez/msdQSKFCcwoCN3/P4+WqrPTIHn/wlbu78/3r3v6u8k36tOQwTW4AStq84f0H2u
         TRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746685329; x=1747290129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGRiPozPCKlTceAlJbkKm3qZDESryv+qOsVno6iyAH0=;
        b=Vt3N4ciFevZRLVLG3numrTMzto/Jy1wQ4ZAPv2IexSN88OS0rAK3cClCuo+CEHFwf0
         juM7sWkIAkfI8qR6WdknJBaTIR9F9VlNjQk+8s8YwC1Wms+E6HP7J/q9ikXFY/h1/SeH
         Mc9SLXS2QboLVFoS9vaiSqsVRhSjniZsjVwDCR2OgA4319pyxgxQkWCqLGjBlb2y/6a0
         JmM+w12kzPaMbroMjJJSvrtFWSycKB89dEmdun8xUTK7ZLR6WzUquwF9qQ3i1NvfiXWe
         6wAyk/MQU4N2bV9OYw1cwBg8TSK7GU8KSlxg7BWA/VT+/iEnEGA85ycwmU14f5lH15kf
         Ir0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVD6I1khM+eFWBlXoOtQhzKmGrRW30PD97FiBfjwWYNB8VigE7aWWxFBn4+1NMQ31YW19gSu9ZDWYZ+kg==@vger.kernel.org, AJvYcCWgljOurvKgdCgw3S/GH9I28/tkeXyAtFdj7K6frBAZPe4QhIOftbEn1hn917+GNgx16XPExY16@vger.kernel.org, AJvYcCWkmFG5L9BMORNN9xoGc0nD1Wc0R8q9bdPq1uBfUgm1XO5X7PpWmcIEZkKpU9mO/UzGLa/Ic7O1OHeS@vger.kernel.org
X-Gm-Message-State: AOJu0YxIBrZGq3dazeig0vHpqIq2gQLEvE3R6d/nsN5y0dWng8aId1Ue
	HVmBOxDw/5jcJyhNa7SpKRp9kh63jGqDpD3V1Vfw6QhugVK3EbIg
X-Gm-Gg: ASbGncsEbOfTx2yKWy/mRHs3x8azyg8HMAEBY68AY5jS2inVkydanWS7wM3DLiBLxNA
	O2DnZJyDfs0w9PF8iZxvb75tJ9TUaTyxg51xQwxj95+rU4o+VOkYiH+QfcN57XG8aK04ZK+XFAh
	ZXvx6JeEVnxibgZ71W+nttyaV/+u7LmCMdEwTCOCxjVqxfLGPdsLCXcJkg+Ia4f0MNjoxZZ7xEq
	V4H6NCJAK70qZ7sMGQvHZPH+CCVkXdh6pi2HLN180tb37CNDebAu6ZWq6eyH1wCX+BSRX/Gall0
	/C2Genpg0/YkB93mEH0+MtcGifdX+dVsjWT03k3TyTHtWA/Lx/bx
X-Google-Smtp-Source: AGHT+IEzMVc56iAT+a/tMSCcX9N+OfWHSiME3hDRqUVurDIzobwAS9xBHQ7vI2Z7UkKgma9R7jLLrg==
X-Received: by 2002:a17:902:f789:b0:21f:2a2:3c8b with SMTP id d9443c01a7336-22e5ea643bamr92011055ad.11.1746685329124;
        Wed, 07 May 2025 23:22:09 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:61af:8a13:a547:7dd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15229399sm104436315ad.187.2025.05.07.23.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 23:22:08 -0700 (PDT)
Date: Wed, 7 May 2025 23:22:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Aditya Garg <gargaditya08@live.com>, 
	Berkel =?utf-8?B?SsO2cmc=?= <joerg.berkel@bfh.ch>, linux-input@vger.kernel.org, stable@vger.kernel.org, 
	regressions@lists.linux.dev, linux-spi@vger.kernel.org, lukas@wunner.de, 
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [REGRESSION] applespi from 6.12 onwards
Message-ID: <n73jgymwf62kfexrwrhpz45lrj5pc7e4x7m6otbvypctlowjdl@ztaox436vezk>
References: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
 <PN3PR01MB9597D8E327CC7910673849D3B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <122a1f90-ddd9-4e74-96d1-57e21e580ae2@linux.intel.com>

On Thu, May 08, 2025 at 10:15:31AM +0800, Baolu Lu wrote:
> On 5/8/25 01:07, Aditya Garg wrote:
> > Keyboard and touchpad stopped working on several Apple Macbooks from the year 2017 using kernel 6.12.xx . Until now I could only find this discussion affirming the bug on Debian and Fedora:https://github.com/Dunedan/mbp-2016-linux/issues/202
> > 
> > On siduction I also tried the more recent kernels 6.14.5 and mainline 6.15-rc4 (from Ubuntu) and the issue persisted with my testdevice MacBookPro14,1 -- see the relevant output:
> > 
> > kernel: platform pxa2xx-spi.3: Adding to iommu group 20
> > kernel: input: Apple SPI Keyboard as /devices/pci0000:00/0000:00:1e.3/pxa2xx-spi.3/spi_master/spi2/spi-APP000D:00/
> > input/input0
> > kernel: DMAR: DRHD: handling fault status reg 3
> > kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> > kernel: DMAR: DRHD: handling fault status reg 3
> > kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> > kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
> > kernel: DMAR: DRHD: handling fault status reg 3
> > kernel: DMAR: [DMA Read NO_PASID] Request device [00:1e.3] fault addr 0xffffa000 [fault reason 0x06] PTE Read access is not set
> > kernel: DMAR: DRHD: handling fault status reg 3
> > kernel: applespispi-APP000D:00: Error writing to device: 01 0e 00 00
> 
> It appears that all DMA faults are related to a fixed address,
> 0xffffa000. Is this address something special?
> 
> Also what does below message mean from a SPI driver's perspective?
> 
> "applespispi-APP000D:00: Error writing to device: 01 0e 00 00"
> 
> I am asking this because the IOMMU fault messages are about DMA Reads
> (device raised memory read), while above message complains failing to
> write to device.

When sending a command to the peripheral device applespi expects it to
acknowledge successful transfer with

	static u8 status_ok[] = { 0xac, 0x27, 0x68, 0xd5 };

but we are getting "01 0e 00 00" instead.

See applespi_check_write_status() in drivers/input/Keyboard/applespi.c

Thanks.

-- 
Dmitry

