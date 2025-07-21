Return-Path: <linux-spi+bounces-9143-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8B5B0C561
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 15:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1F31787E5
	for <lists+linux-spi@lfdr.de>; Mon, 21 Jul 2025 13:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C6191F92;
	Mon, 21 Jul 2025 13:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL+Em7e5"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976501E521E;
	Mon, 21 Jul 2025 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753105205; cv=none; b=Rs5o92hckpkeuHO9inlFXdReZv79eBjk5zepRqdpfBdEhaDJfucyXApPPtKBhmhdceSm9UzM+k85ythdmdk98MrikdclYn3V7vqrGmifKiF5G0+/JJUdR792z1YpO2zdlW1ucDJ1rBUi2a/t6qBUUa2NNf2Bh5UeD/yYVLRzuSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753105205; c=relaxed/simple;
	bh=aqBdv0rBs3uhb4aYP7555kNHRCmkMNDCz8T38ZqdZU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGuLEcYAZ+L/oOyOZoYM7qqnhUf3yMJkY8gQrpJNIp5m61dquHLbx5R3wz3QKZZ1TyEWTGI15JlSMORSZohXoc5DylSVGRggyQiHazjHlhqr35PtN+IOY1XgbA5qv7DeAcv165814mPogRTF29gs+KfLfGnSorrRdRP+P9bZS58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WL+Em7e5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aec537b407bso53852066b.0;
        Mon, 21 Jul 2025 06:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753105202; x=1753710002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDniUm8HNahJCjx1uXd/VHwom2lOWNGXKKTWQ9DCUp0=;
        b=WL+Em7e5nUBiwVCnDPf0McrmhIZiV5k+E8Fr13NXirT+weM2acYUoq6D/DgBzfrerh
         JRp8anI/1lSDsqj99RcYZG3uX8CNDoTsduk6Oq3rOdcw4/wmFVdpy7j8dmws0VRqsw80
         OlLHcpHY8P+rw5mJl18TPa9nrnumxw3BOhKLmoH5ZXSxlQFgPXbObgGnoTsRvpi2RCfz
         pPzVzCC0ftLTBd84RNwltXbMcxY6tppk6v+ZG/yswjOkRVP3fOdoPwj/lV2JG2upGR4Z
         6LBBI4FGy2tERCEywxFMfJ8E2Zd69fxEgqOaVrYflpGMd0YbNjDEduShnzgGeE3FPTRv
         xDVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753105202; x=1753710002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDniUm8HNahJCjx1uXd/VHwom2lOWNGXKKTWQ9DCUp0=;
        b=jAkGa1z452oS2rpzrA6UWEjgg1pTQQc7hvw7uk8i0Y1TAz48k0AuhAPfc5Y3NIOmXy
         7qFM9DX/xyzUzglVruUWTFLEHwkDp5VUwRVh5JPFZ1o02fMjgobeDA6Vy3LU7X4C3/VO
         4WkewshqWWxO+4+6HWpjYF/GH54Euxdk5WFheD04ct5OTuiMoH5rX8hZ8jjXmh1ILtTl
         RcfpcEUIrYjK37efDdcjodMk0JIdUpzdy/IdRp6EbAywn4S+KVD7fSaZdUOjFBe0VzBe
         DwKi2GL74sFvsL5/m1NmNTAOlttFhGBLrkjQELMCyP3LPNc3KTBk2+9TJKCH1Vxo8yTa
         OO6A==
X-Forwarded-Encrypted: i=1; AJvYcCVgY0pWQJrvWkPHWOFbGuJC/pZZlnOfPudnWZoZaVL1G/sNTpsbgD0QvZnrduQpmueZeYMGF2P9n3BOPAE=@vger.kernel.org, AJvYcCXAArPXgE5oGRvmgjdsq8l3+B8i7cwqVLDQXnGZ7a7lsV94UnkqNpdoy/gVbJcG8fI5E3qQBoM9+N3h@vger.kernel.org
X-Gm-Message-State: AOJu0YzZiWw2oOHulvoU7L+OKr3DTZMM9pXnL1Vg2eDFOA0+fp2PPYaj
	qgJrULNS0G4BLFqLSj91gv2KfSoxvBb5K6koVNJP9ZxCkYY3RWMsIlEj
X-Gm-Gg: ASbGncu8YTvLOaX+NdkJ6WABlyf1aXJYLEx6AmvnLXpcEGg7V8vNrFWhnCp5hsGiBvH
	Yb2fxFt8usklyUfrJ6QjWYA0yD330LDwJ//qBLklcTKYpIlzhs280n81UUqDC4vOF5CrUY9QrYu
	gCaP/PYJ09WWNL/Ornd/w7W8WXDkgWaJpqfbTQK7PW+Rtr+LeNsCXnUgfcBqu7ehwCU/WSR0fzQ
	tbNlSd2vp6uMSFno67QdOdX4SmCKaNAjkPvytuECEHCo2XXZlOLU84PBCtnnPXmvINc43kAVCzo
	nfbtKL+cHjbK5WBUL8++BJaFGoDMZJ23CzmxRP1EVpnyqyHOjDPKQbeKDAqAexynybOLYK+U4Kk
	ZoE+QGmnOR8sSbHo=
X-Google-Smtp-Source: AGHT+IFsNh6bo2feFuFv54zmHMiND4KzOlDox4TOr3Hq8r6s5el6taFrP1THbgj0l+Pq22KHcj3ewA==
X-Received: by 2002:a17:907:3c91:b0:ae0:cd6e:5d0 with SMTP id a640c23a62f3a-ae9c9b210e8mr761689166b.11.1753105201594;
        Mon, 21 Jul 2025 06:40:01 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d00b:9d00:b8ad:2ca0:b375:ea32])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79f139sm679347366b.29.2025.07.21.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:40:01 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:39:58 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] spi: spi-fsl-dspi: Store status directly in
 cur_msg->status
Message-ID: <20250721133958.dhityxa7vvtqov3d@skbuf>
References: <20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org>
 <20250627-james-nxp-spi-dma-v4-2-178dba20c120@linaro.org>
 <20250627213041.vp6yfcgf4xysdklf@skbuf>
 <eb704af4-5800-49b6-9915-c990c5b23fa1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb704af4-5800-49b6-9915-c990c5b23fa1@linaro.org>

On Mon, Jul 21, 2025 at 02:25:55PM +0100, James Clark wrote:
> Hi Vladimir,
> 
> Just wanted to check if you are ok for me to send a new version with your
> fixes included now?

Yes, sorry for not being clear, the tests which I wanted to run were
these ones:
https://lore.kernel.org/linux-spi/20250630152612.npdobwbcezl5nlym@skbuf/

> I assume from the other discussion that we don't want to always enable DMA
> mode either, and we'll just leave it for s32g target mode only?

Yeah, for sure don't enable DMA mode unconditionally. I don't have time
right now to look into Mark's can_dma() suggestion - if you don't have
either, I suppose it is what it is, and the performance improvements
brought by your enhanced DMA patches can be brought over to other SoCs
at some unspecified time in the future.

