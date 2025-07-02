Return-Path: <linux-spi+bounces-8996-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 661DAAF5898
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D72B4E1208
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C41528689A;
	Wed,  2 Jul 2025 13:19:32 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9908428640A;
	Wed,  2 Jul 2025 13:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462372; cv=none; b=kcjmULwDiMF9zSv4xijJzljrz93xwVOHgNukCxl+ftSo22Nr/3a0+y4QLaes8gc6CrzgkPkyJVMMOovqWIEEz9fTmIZL/raIpb+6ypwGp3e7tetMNgJqMu+TBSDXuuU2lkb0oSYoyGqTr04tVOYwFs+r+EJL3NzPhylUXuTcGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462372; c=relaxed/simple;
	bh=1BbhlC+l1xKw8p+Nevl5eUTHDecQXYfUOAsFqanGWjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSkSx8VeMMdEGHUdu1g7B9bbZSPUn0bsNpjJvZqC4+PKMKb/XO/OACXmgTpUyTqGY8mWcDCFaLzmB+vblhV21ivpigl32HBEEvKPdiL0jOil8SYvgzhQYEGS9pSg1Y5Y+jb5fiLbjXfbSpRZCHK3fD96W20AnQUr74BL5G9VK24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1uWwab-00058M-00; Wed, 02 Jul 2025 14:29:25 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id A43D6C0C1C; Wed,  2 Jul 2025 14:07:45 +0200 (CEST)
Date: Wed, 2 Jul 2025 14:07:45 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Shiji Yang <yangshiji66@outlook.com>
Cc: linux-mips@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org, John Crispin <john@phrozen.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] MIPS: some compilation fixes for the Lantiq
 platform
Message-ID: <aGUhERHN5FH5Rwtc@alpha.franken.de>
References: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB1670163BDCA60924B3671D45BC72A@OSBPR01MB1670.jpnprd01.prod.outlook.com>

On Wed, Jun 18, 2025 at 10:53:13PM +0800, Shiji Yang wrote:
> This patch series fixes some MIPS Lantiq platform compilation issues
> found on the 6.12 kernel[1].
> 
> [1] https://github.com/openwrt/openwrt/pull/18751
> 
> Shiji Yang (16):
>   MIPS: lantiq: xway: mark ltq_ar9_sys_hz() as static
>   MIPS: lantiq: xway: mark dma_init() as static
>   MIPS: lantiq: xway: mark dcdc_init() as static
>   MIPS: lantiq: irq: fix misc missing-prototypes warnings
>   MIPS: lantiq: xway: add prototype for ltq_get_cp1_base()
>   MIPS: pci: lantiq: marks pcibios_init() as static
>   MIPS: lantiq: falcon: fix misc missing-prototypes warnings
>   MIPS: lantiq: falcon: sysctrl: remove unused falcon_trigger_hrst()
>   MIPS: lantiq: falcon: sysctrl: add missing header prom.h
>   MIPS: lantiq: falcon: sysctrl: fix request memory check logic
>   MIPS: lantiq: xway: gptu: mark gptu_init() as static
>   MIPS: vpe-mt: mark vpe_free() and vpe_stop() as static
>   MIPS: vpe-mt: drop unused functions vpe_alloc() and vpe_start()
>   pinctrl: xway: mark xway_pinconf_group_set() as static
>   pinctrl: falcon: mark pinctrl_falcon_init() as static
>   spi: falcon: mark falcon_sflash_xfer() as static
> 
>  .../include/asm/mach-lantiq/xway/lantiq_soc.h |  3 ++
>  arch/mips/kernel/vpe-mt.c                     | 35 ++-----------------
>  arch/mips/lantiq/falcon/prom.c                |  4 +--
>  arch/mips/lantiq/falcon/sysctrl.c             | 29 ++++++---------
>  arch/mips/lantiq/irq.c                        |  3 +-
>  arch/mips/lantiq/xway/clk.c                   |  2 +-
>  arch/mips/lantiq/xway/dcdc.c                  |  2 +-
>  arch/mips/lantiq/xway/dma.c                   |  2 +-
>  arch/mips/lantiq/xway/gptu.c                  |  2 +-
>  arch/mips/pci/pci-lantiq.c                    |  2 +-
>  drivers/pinctrl/pinctrl-falcon.c              |  2 +-
>  drivers/pinctrl/pinctrl-xway.c                |  2 +-
>  drivers/spi/spi-falcon.c                      |  2 +-
>  13 files changed, 28 insertions(+), 62 deletions(-)

applied patches 1-11 to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

