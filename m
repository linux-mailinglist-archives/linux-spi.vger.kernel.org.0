Return-Path: <linux-spi+bounces-8038-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6687AB16E1
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 16:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0510F3A52FC
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 14:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67B523D2A0;
	Fri,  9 May 2025 14:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKk4nzz8"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88EA2A8C1;
	Fri,  9 May 2025 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799590; cv=none; b=Y6ZT+yvmloyNH/jP8qQre/UY+kJOiXUds2ysT0V+WeY3yBCl2dl3hlALtO0oJXPRLVBggGPrw46q6zrJF6ZtxFrVGt0QPoWzFa4Mn5sVS1YAar5erNoiuqEtVapc+dHNDOjY2q3AoHYTQ4bWqBL7HxTLwiXC0QKjyEK9S35Q1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799590; c=relaxed/simple;
	bh=EDEwnV0nE85Oqv0NR7mxnbl9Iv6yY6k//Uqp11s7Pl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOHbdDE4btYs6ttEIUwyQvRtpFiCN0lh5mmUSju4OVIwjfa9KtM40WGP0ukRRuZFXfO56Y3RtiI9djj3PlbZEJqMxbkHW4xSN24Ty7LyP7Y11vi0+2EhwOeGniflZyQxN6uyXmcTMCD+4VK0xanceokRYV5FWZTCm8IRqPPIv9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKk4nzz8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad1b42d7ea7so29038766b.2;
        Fri, 09 May 2025 07:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746799587; x=1747404387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vR3S5bFvr+HUo+LPE6J+nwHXZjEwfOX2Cga+g88x6Q=;
        b=iKk4nzz8DTK+aOG9lQeAXQkI9mznJ3B6ZZXFzVfq1OciCXEqAUzPN9cLJOpiR5QEwQ
         Kmewhtv9ApbWAD6WEL/xwlOwqlMNktZLkpfQdRbYPUIQTUzWLkqJW8GdeUmzp2J1jEA8
         6v9/muEN3eCw5wfiXfcCEO0R3mwq2ePAjOoeIp+MyI0QDtsSP/t0e9HLtcFGA4hl5Y9h
         vsUjyL7sQvJ5dfbdii+THe1wf1kRdzhD/gKAyemCPutRBk8Q/f+aOjdkYilIM49fzAd0
         ykZRH+kep7vMZEi5kn4iCVf3Ep2EhMBCB4VztkcMdR0TOCSlctYWSYFgi0uou7cW+L0U
         AuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746799587; x=1747404387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vR3S5bFvr+HUo+LPE6J+nwHXZjEwfOX2Cga+g88x6Q=;
        b=Lofnsp0Lil5VYfz9hvdtVvyflw8NmgaBHXjg8ZoUOCVMM8ipzncg2tfmfxmsIEWuvq
         EbvsLAEswR6KjQBAJ3oUj5Y0hlCFyX6j8B3o+OHuNK7Z0lNPBRkpUu+BtwwDLcp8rrLJ
         gbFI0sATvzA9SNne95IfE/QfOSmyQGt1dCxOaWzUIk+USrfw3nX+awxLvk5v2Csn9buc
         Ge40WWL7dV/Pa4JQJpGaO1If3zgdxcZoiEH/s1o63mRqC4NvllnBzdHC5qR1nOyRqPKM
         oPjb1jYZyweWcPwjPNrFLKKlzzWIqCIYIF3FUpS8S51/kCVs+tIEbsq5UReQTyo+HQa0
         JK/g==
X-Forwarded-Encrypted: i=1; AJvYcCUANK628VN7aF8e1JRgYRC3NIF8CIY6Cd9V0jjRcIkdgRlHLL6Q4KSbL8DrZ46vuuqeVoWbxW4Uwxyf@vger.kernel.org, AJvYcCUW8JYlhFUolgc+ddEE7rlvvFjhAVLEPa1+BcdFUI4QEU1DSQXDMjSykAz6sbXPwqDW9Q0mg8LhK4zf@vger.kernel.org, AJvYcCVtTqgE5bb9xjko5q858xMhW/n6Dz8aSmvRob4bFvl4fue4/A4vwq1+92PeXbVRGSDoPOBpT/r+x0QzmDre@vger.kernel.org
X-Gm-Message-State: AOJu0YxeyjakGYhFY5p1TtIG+A1UBySdr8xTrb5SqDLiVBhIrIorHe2D
	aFUP3sqZVtUrbrS3b/Kf5lTLUOXQu9suvnLOTWRP+9PR0vEeQ9FB
X-Gm-Gg: ASbGncubHxM2FsPkgkgripz9CMhXtV7Pc4+X/0q8GZJDDYG1oqi1qKsXTuFQH0JmFfc
	boHirAXJXSGcgnpiISmXroZW+hhnhe/5eR4dmYXtWgPAowTcChxTVeOnhNg5Emp4bYMIc2Nop3g
	u5segICnKdWUa37y+Nxc/fdETrcMV+iyToJVn6X/zyodYTte4Z8VR/k2jcENLcQQjx5PtU5o/82
	hRzPeHZDVqYzP3hD03labr0lSJAfXFu9F/6bpM0ZyqLcf0+cTN2efazBcFncW3wYmshcJsQCxkA
	CV86VsF6D/IOygpfNKJGW7D9WyQU
X-Google-Smtp-Source: AGHT+IFyBqJPuUpd/VkBty6rVNROepduGUENPpZDSw5zwcqT5KP0a0bpgkdNYr+JHP9i1uJjIlcABw==
X-Received: by 2002:a17:906:8474:b0:ab7:5fcd:d4db with SMTP id a640c23a62f3a-ad218f68a14mr108916866b.9.1746799586548;
        Fri, 09 May 2025 07:06:26 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192d4a1dsm158053766b.17.2025.05.09.07.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 07:06:25 -0700 (PDT)
Date: Fri, 9 May 2025 17:06:22 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com,
	arnd@linaro.org, andrei.stefanescu@nxp.com,
	dan.carpenter@linaro.org, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Xulin Sun <xulin.sun@windriver.com>
Subject: Re: [PATCH 03/14] spi: spi-fsl-dspi: restrict register range for
 regmap access
Message-ID: <20250509140622.n2tc3dd23ylyux72@skbuf>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-3-32bfcd2fea11@linaro.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-james-nxp-spi-v1-3-32bfcd2fea11@linaro.org>

On Fri, May 09, 2025 at 12:05:50PM +0100, James Clark wrote:
> From: Larisa Grigore <larisa.grigore@nxp.com>
> 
> DSPI registers are NOT continuous, some registers are reserved and
> accessing them from userspace will trigger external abort, add regmap
> register access table to avoid below abort:
> 
> Internal error: synchronous external abort: 96000210 1 PREEMPT SMP
> Modules linked in: fuse dummy tun hse sch_fq_codel openvswitch nsh
> nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> CPU: 2 PID: 18231 Comm: read_all Not tainted 5.2.33-yocto-standard #1
> Hardware name: Freescale S32G275 (DT)
> pstate: 20000085 (nzCv daIf -PAN -UAO)
> pc : regmap_mmio_read32le+0x24/0x48
> lr : regmap_mmio_read+0x48/0x70
> sp : ffffff801123bb70
> x29: ffffff801123bb70 x28: ffffffc873b5c000
> x27: ffffff8010b408f0 x26: 0000000000000001
> x25: 000000000000013c x24: ffffff801123be40
> x23: 00000000000003ff x22: ffffff801123bcfc
> x21: ffffff801123bcfc x20: ffffffc873a9e500
> x19: 0000000000000024 x18: 0000000000000020
> x17: 0000000000000000 x16: 0000000000000000
> x15: ffffffc876189160 x14: 0000000000000003
> x13: ffffffc873bf73ff x12: ffffffc873bf707e
> x11: 0000000000000000 x10: 0000000000000000
> x9 : 0000000000000000 x8 : ffffffc83fca4e00
> x7 : 000000000000000f x6 : ffffffc873bf7083
> x5 : 00000000fffffff9 x4 : 0000000000000002
> x3 : ffffff801061f058 x2 : ffffff801061ee18
> x1 : 0000000000000024 x0 : ffffff8011490024

I think you can leave the register dump out, it doesn't seem of much use.

> Call trace:
> regmap_mmio_read32le+0x24/0x48
> regmap_mmio_read+0x48/0x70
> _regmap_bus_reg_read+0x38/0x48
> _regmap_read+0x68/0x1b0
> regmap_read+0x50/0x78
> regmap_read_debugfs+0x120/0x338
> regmap_map_read_file+0x44/0x58
> full_proxy_read+0x68/0x98
> __vfs_read+0x48/0x90
> vfs_read+0xb0/0x130
> ksys_read+0x7c/0x108
> __arm64_sys_read+0x24/0x30
> el0_svc_common.constprop.0+0x74/0x168
> el0_svc_handler+0x70/0x90
> el0_svc+0x8/0xc
> 
> Co-developed-by: Xulin Sun <xulin.sun@windriver.com>
> Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---

Do you have a reproducer for any of the supported SoCs? On LS1028A, "cat
/sys/kernel/debug/regmap/2120000.spi/registers" runs fine and does not
crash.

