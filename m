Return-Path: <linux-spi+bounces-8182-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CA2ABBB08
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A19B188E65C
	for <lists+linux-spi@lfdr.de>; Mon, 19 May 2025 10:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1462741BE;
	Mon, 19 May 2025 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XN+WfkKz"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8EB3D561
	for <linux-spi@vger.kernel.org>; Mon, 19 May 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650358; cv=none; b=FpK0sj1dGT6ieFKDmNwSxvFDWi8wf/ArD61cVAmao3m16vLAENGyDaBuppGghem/tWLZ3IJPrRtTA30VUcZhjy3XyaHOsP4oqyy+hal6W+D7nB8DM3nLFsv1jpco0FHrIad6JdA//ZM2EPIOo5Srd0+Q/djc9v09ars7Q72M7AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650358; c=relaxed/simple;
	bh=YShpb15KXh+rmJ913JTGgVe+ZLU1GE2+pipwYbXGm6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iv4xTSEK+pjwWpqy3uLjE6c6Br+3Fjk0XV5egc2GG0j8Ij0E2nVtM0565qt0xLc3vV4hE2IY6wsiFKVMpasSUUwWp4vHv4wGghMeP4zefV59/Dum9MfecEq2AA0bidrn+uc1g+4V+b/CllrHi+JmJKFz2kp8bVvBmXeF7uOzCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XN+WfkKz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cec5cd73bso27886365e9.3
        for <linux-spi@vger.kernel.org>; Mon, 19 May 2025 03:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747650355; x=1748255155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6fKl01pepPz++C68YkR59kWZjoR1MNzkY+R8bRjab0=;
        b=XN+WfkKzRbKXc0V9oYxI4/dLRG1TLmmtHvypoMDi8oOveerFK2iCNV9Eqoa/cw2OBy
         pqUIAXNO6J8cYuwBN97dYf1Aeyq81bm/xi/QCMTF//jAANxv7K165D5fnZAfNS0e8EfB
         ppYjzLLfsqwKGCdbcCQKbpSqT/4bVDo/sfqC48loKBgpBjZ+klKsAgrThxV2+tbRNbPr
         SfhhOUoYFxdTGI+josAphKaVrnXL0kD7OTSg71oPZL462F1XvrGvUimKq/KnAmj0qgg2
         rRzh0m6IjWK8jZUEYx2pwEGMsNBNoM9+rN9wCN2hHw2YOBVR41TWBusvzfdsNxzmqkAp
         O8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747650355; x=1748255155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6fKl01pepPz++C68YkR59kWZjoR1MNzkY+R8bRjab0=;
        b=ZaKU2wM5EZtK0mmvYXkUt0rnVJKR0R+FMmO6PglUnjL9c03iDU62H8xYK8/J6uAJf7
         AmJJ6LcNSMgE8NQ6Ub0u483PLaNUH5eOI9Cii4sICYtFQuvRdJ6DnjZK6X9UNnyAMw5j
         39jpjSMcMrHYdNYixuv/eBeYGYp7sAV6tpX1yiUHiOCbm3cpnU8w8xSD1BEWVJy4U2UR
         m0bpHQ1aFKDllVpDLUiLm03m+hPo5d2KyuhwOka0lgjBlL1aIZyQPspP9OtE+5mxSxY4
         KfOHfnhnGdrHN8zJbLmoIe2mBZ72XVm1vDTU/L7ZOJ/N+C9gIo0pJgo7AmLLtHG29Z+1
         +5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWaNLItS7/xE6YfabJTevl07RK2WcgTExABmseGpKjjT+2kOb08HSI7pxRHFQ0y5WPpvhoItkdRTtc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6j9WstS//xQNjQIgqBqpO58jncnwo/XJlCkErBfFD7kau6JEw
	Zt6PISPfNrmLavsAVztWugQyYiMK6AniZ7Ua4w+bm+4GEDgw3w2aWsJasiNyOCl5u74=
X-Gm-Gg: ASbGnct3JZQpq7c8YnErKYWIrPEgS6lBFeDIY5ztuJkAtgd/CXdP2biIwjcVqMCej+i
	o7NnmGEv3oIFbHA6ZEMuO09uOssdRFHcGm2deFkR10ZyuCHwKkZ6dfIHvcYyt3KIHYdBbaKOrNd
	kgHULoJ6u9nJltHytrUUpKqLWYdozyF5xD4Twgw38ZjwHLJ5e9+KLK7AjjV0SgNnFli2BcwJho8
	kFiuHhsCc/B4oRTDmiatJPWRwWhIDvvEJGbPGvG9Dk4JTF+4pK+VRrVaR6KHB+v9Js6nLLQKpFu
	5tJ9RP+yR6sTRlAp9utHH2qsZcCuUUtqtIer7VyTwh5J4Q6yKeGy5xPZ
X-Google-Smtp-Source: AGHT+IH4gcowvuA8DujFFeHc07e+oNKUAsI8ShmqZmjzECudwGDbx/+l7QdDfmfB08rAOTsCA3h/rw==
X-Received: by 2002:a05:600c:4f42:b0:442:dc75:5625 with SMTP id 5b1f17b1804b1-442fd60cb7bmr106438175e9.5.1747650355085;
        Mon, 19 May 2025 03:25:55 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442eb85a8f8sm122871855e9.0.2025.05.19.03.25.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 03:25:54 -0700 (PDT)
Message-ID: <8b7be083-cef8-4b68-af4a-2bb5b30a9b9c@linaro.org>
Date: Mon, 19 May 2025 11:25:53 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] spi: spi-fsl-dspi: restrict register range for
 regmap access
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org,
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Xulin Sun <xulin.sun@windriver.com>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
 <20250509-james-nxp-spi-v1-3-32bfcd2fea11@linaro.org>
 <20250509140622.n2tc3dd23ylyux72@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250509140622.n2tc3dd23ylyux72@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/05/2025 3:06 pm, Vladimir Oltean wrote:
> On Fri, May 09, 2025 at 12:05:50PM +0100, James Clark wrote:
>> From: Larisa Grigore <larisa.grigore@nxp.com>
>>
>> DSPI registers are NOT continuous, some registers are reserved and
>> accessing them from userspace will trigger external abort, add regmap
>> register access table to avoid below abort:
>>
>> Internal error: synchronous external abort: 96000210 1 PREEMPT SMP
>> Modules linked in: fuse dummy tun hse sch_fq_codel openvswitch nsh
>> nf_conncount nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
>> CPU: 2 PID: 18231 Comm: read_all Not tainted 5.2.33-yocto-standard #1
>> Hardware name: Freescale S32G275 (DT)
>> pstate: 20000085 (nzCv daIf -PAN -UAO)
>> pc : regmap_mmio_read32le+0x24/0x48
>> lr : regmap_mmio_read+0x48/0x70
>> sp : ffffff801123bb70
>> x29: ffffff801123bb70 x28: ffffffc873b5c000
>> x27: ffffff8010b408f0 x26: 0000000000000001
>> x25: 000000000000013c x24: ffffff801123be40
>> x23: 00000000000003ff x22: ffffff801123bcfc
>> x21: ffffff801123bcfc x20: ffffffc873a9e500
>> x19: 0000000000000024 x18: 0000000000000020
>> x17: 0000000000000000 x16: 0000000000000000
>> x15: ffffffc876189160 x14: 0000000000000003
>> x13: ffffffc873bf73ff x12: ffffffc873bf707e
>> x11: 0000000000000000 x10: 0000000000000000
>> x9 : 0000000000000000 x8 : ffffffc83fca4e00
>> x7 : 000000000000000f x6 : ffffffc873bf7083
>> x5 : 00000000fffffff9 x4 : 0000000000000002
>> x3 : ffffff801061f058 x2 : ffffff801061ee18
>> x1 : 0000000000000024 x0 : ffffff8011490024
> 
> I think you can leave the register dump out, it doesn't seem of much use.
> 

Will reduce the output and add a reproducer and fixes: tag.

>> Call trace:
>> regmap_mmio_read32le+0x24/0x48
>> regmap_mmio_read+0x48/0x70
>> _regmap_bus_reg_read+0x38/0x48
>> _regmap_read+0x68/0x1b0
>> regmap_read+0x50/0x78
>> regmap_read_debugfs+0x120/0x338
>> regmap_map_read_file+0x44/0x58
>> full_proxy_read+0x68/0x98
>> __vfs_read+0x48/0x90
>> vfs_read+0xb0/0x130
>> ksys_read+0x7c/0x108
>> __arm64_sys_read+0x24/0x30
>> el0_svc_common.constprop.0+0x74/0x168
>> el0_svc_handler+0x70/0x90
>> el0_svc+0x8/0xc
>>
>> Co-developed-by: Xulin Sun <xulin.sun@windriver.com>
>> Signed-off-by: Xulin Sun <xulin.sun@windriver.com>
>> Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
> 
> Do you have a reproducer for any of the supported SoCs? On LS1028A, "cat
> /sys/kernel/debug/regmap/2120000.spi/registers" runs fine and does not
> crash.

On S32G3:

  # cat /sys/kernel/debug/regmap/401d8000.spi/registers

  Internal error: synchronous external abort: 0000000096000210 [#1]  SMP
  regmap_mmio_read32le+0x14/0x38 (P)
  _regmap_bus_reg_read+0x104/0x140
  _regmap_read+0x19c/0x2d0
  regmap_read+0x60/0x90
  regmap_read_debugfs+0x15c/0x330
  ...

Not sure why it wouldn't be the same on LS1028A because the register 
layout is basically the same. Maybe it just ignores the read instead? 
Either way I think the fix is still worthwhile to backport because we 
won't be able to test every device.




