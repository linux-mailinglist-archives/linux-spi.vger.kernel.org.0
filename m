Return-Path: <linux-spi+bounces-12375-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F7D2017E
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 17:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE891300D924
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 16:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61ABE38737C;
	Wed, 14 Jan 2026 16:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5CxSbs5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7B23A1CEF
	for <linux-spi@vger.kernel.org>; Wed, 14 Jan 2026 16:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406989; cv=none; b=kGbP6yR+mqfTkTLiSMC44s0hnkkwrWJ1AgDADlKVFqtKOygc80oFAxUCSVXVZKznBfFZdLl+ts0MUSQEbEWl7IrRIVABi4g7zpXz6vBiDWV6xEF3zercszAXyf9X4Ir8Ng2e+CxD6o8xT1jh0iAhW1+rhCT6e0MuwTh6/TfBKgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406989; c=relaxed/simple;
	bh=870AG/k+JCmTXeqAGtRSOJr8JZoAAFyBoAS/sTkHY/4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EongBvBLkat8ExtbygSMD8BC/0aoYGtK6uGQRx/+P+9kqErlFdvNQKaddAPsR3/hjsD945C+YUroCCF6cSxFK6gKnKtJjNHAThyy3Xt0svJNrkAQ354oyw4GCPfDykTfQgZ2FaGnlxVZBrVZ46ta4y56kE6lfM6iqbo2s7+5T7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5CxSbs5; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c24f867b75so901247985a.2
        for <linux-spi@vger.kernel.org>; Wed, 14 Jan 2026 08:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768406987; x=1769011787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CvSobjH77Q9GEAjWyqemD7/74Kg/Yj+9ZW2qiuIARXI=;
        b=K5CxSbs5yxPu8f6NpaNbOo2CR8EueuBEtBz0AWNAcBxKimy/bZhBsM6kCHngZ77jZI
         uosuIVduARb3bPlovcOAOwsmLmuE2vxh95PIC7WtsrbQhbpes/bp317W68Sg80vHpauJ
         1sOcWTseqjaCNZKz0lbUOpUAN4KAjU+xWpPSd/IUNY84igtD5ZbnBkNqYpyMa6QrSl+K
         obxUIFHgdPOZ+krxNXFX77JbV82mMCcHpPMP7ZepXmRWAoedH94Vp5egIEBkt4HZYHDM
         9C9cpcryDn1XTZ8g9j/ESpOrHvjfzrJCsu4Uq0pihZc8bRJfEC9rqnr3direyNVBcsBi
         50tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406987; x=1769011787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvSobjH77Q9GEAjWyqemD7/74Kg/Yj+9ZW2qiuIARXI=;
        b=A5HiHiB5lPGDYPC0NgPgvppu+FQjshJL+bK4ljkl7fAclLjYryApf+XNmCuST+o2Zv
         g4DJOqm5iDmhRg8WUJ7yF8/oGwYwKQXPoRQsewTX7HR/GooB4GFJbXVOE2A3Q7mj4+2M
         M2xAMd5TvU4Zae0Q3f0PkCVyP9fCOOK7/P4GpRjVHsLzueSv3QCaDbzwRmkt85aYvTfY
         hiuVUugnAVKm/nC/49ogm8f7/gE9NmJBbkkxS69keVickflIKBiV9j8lIC2jyIpxB9GF
         IVp2hb2Pr4Xr65KRUq0tPz2Mqq9fOG+TADuynHnFjFkl3xndSDIBblJccbbMzL79JjBm
         cB9w==
X-Forwarded-Encrypted: i=1; AJvYcCVRuTLdMa3b6aUatDTyeUCRuoTeg0I8VNyv65ABUnXf3PGgeEgNSxZ+skMpMNLhCfJX3rPUZ/Ro/WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZxrhRRID9yVz20tosQ/JzO/ZPdY2ENI3udPrgLUXK14AmkHF
	3l+5MDSpqe7sE2Sqa7w9GWK+9Bl2DHV56JgL2ZmnawIyR8XIdVJjKZP1
X-Gm-Gg: AY/fxX74t2KjM4KrxfD6ZFBBLM+WfRBYY6C6XMgALlVZOHs2laOdm8SjLqYMyZ6st7M
	OCc6x1lJxTLwJh/3G4TtQfq1c1l+IeoQbqSxhle7S1JnUnLqLSqy+0LEr6o6yoiZpUcP/Yk3RA0
	+OZMlHTsYtDKn4mqoxJHGs/VFCoGjjW63MbwdxbafSRZBWHd/tzcHbEaTUeiyzbnT4AZ76X5XaE
	S3ABpdTGOauExPfu0UZ83/f/7EiKqF5Lz1pYfnReSmznR7qLOY9zLQ0beCsEOU3Q5RrocGzZhw1
	DZtuLIl9OqiqWBUPv8JYjLZPvItd4zTx2i4aZXeXCgQW67qW4+wjeIDJW0gUlvZGLJ/Y6cn5zN+
	UMLshE945qsi1Xnrw2N7izewB4dkxfnZMNfc11U4TYD0rOQ08vF31uzaAWyHFLQcf7K1RAkt5Rl
	fbxysk2//tUYjvnSC+H0Wwv5UbXpouhiwT9q7S6xUwIld/cNbPLpe20Vu7bIx7tdGPs05Uns1AW
	cgJXK80f7cirCo=
X-Received: by 2002:a05:620a:4804:b0:8c5:1fb5:1631 with SMTP id af79cd13be357-8c52fbcf18fmr451977085a.76.1768406986626;
        Wed, 14 Jan 2026 08:09:46 -0800 (PST)
Received: from RDEALENC-L01.ad.analog.com ([24.206.116.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c5319a3b59sm155280685a.22.2026.01.14.08.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 08:09:45 -0800 (PST)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 14 Jan 2026 16:09:39 +0000
To: Mark Brown <broonie@kernel.org>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jun Guo <jun.guo@cixtech.com>, peter.chen@cixtech.com, 
	fugang.duan@cixtech.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-spi@vger.kernel.org, michal.simek@amd.com, cix-kernel-upstream@cixtech.com, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] spi: spi-cadence: supports transmission with
 bits_per_word of 16 and 32
Message-ID: <lbijvnnwsnddonmm5pveqzap6iibxhl4maneq43x4j6w64dev6@u75qhm5cwiob>
References: <20251031073003.3289573-1-jun.guo@cixtech.com>
 <20251031073003.3289573-3-jun.guo@cixtech.com>
 <fu4ujdxwlhyhuwjtsiebje5pyc32rfs52vo2gyy7nay2krkxeh@wpls44xdfgy4>
 <0dbf3a5b-6a60-46d8-a358-61b8d527a8da@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dbf3a5b-6a60-46d8-a358-61b8d527a8da@sirena.org.uk>

On 26/01/14 02:16PM, Mark Brown wrote:
> On Wed, Jan 14, 2026 at 02:14:35PM +0000, Rodrigo Alencar wrote:
> > On 25/10/31 03:30PM, Jun Guo wrote:
> 
> > > +	if (xspi->txbuf) {
> > > +		switch (xspi->n_bytes) {
> > > +		case CDNS_SPI_N_BYTES_U8:
> > > +			txw = *(u8 *)xspi->txbuf;
> > > +			break;
> 
> > > +		cdns_spi_write(xspi, CDNS_SPI_TXD, txw);
> > > +		xspi->txbuf = (u8 *)xspi->txbuf + xspi->n_bytes;
> > > +	}
> 
> > cdns_spi_write(xspi, CDNS_SPI_TXD, txw) needs to be called regardless of xspi->txbuf.
> > Otherwise, there will be no clock for the read operation to work.
> > This is a bug I am seeing on a Zedboard running on 6.19
> 
> So the device needs to be flagged as SPI_CONTROLLER_MUST_TX?

yes, It works if

ctlr->flags = SPI_CONTROLLER_MUST_TX;

is added to the probe function. At least for my case handling with "xlnx,zynq-spi-r1p6"

kind regards,

Rodrigo Alencar


