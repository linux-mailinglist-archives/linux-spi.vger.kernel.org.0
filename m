Return-Path: <linux-spi+bounces-4488-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43015966C37
	for <lists+linux-spi@lfdr.de>; Sat, 31 Aug 2024 00:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758D11C21A46
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 22:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC661C1754;
	Fri, 30 Aug 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4RVNyaY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DCD136337;
	Fri, 30 Aug 2024 22:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725056615; cv=none; b=QXADGMwp0x8mACNQubr4gXn5AWGF3ykYZt0NZUv6WjDCToyu6xJJyekpxcqC7CDwkS72pBNkSfchr4t0ASStuGpdPfCIHTC2fmre/8135/3EU/qXA7iCN2pmPMt2hCnfY240hUjJ0I+wMEaZF/ugUihg5wji0Y7NxcArbjJPm64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725056615; c=relaxed/simple;
	bh=B8VQl5DFu5C3eYK4CExKtHZCyDO+jvgcRht3lHI+Qwk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeHl/zROMjC3o+cMtu7Zni2ilPpyFnjPFKNdH7TQ+JxucVnzOa/wXnny7qFUbU4tF0HhSOf/qKmVHK/Ojx3kYkQyrAlrRN+FuMxYSDHi2eBvoWkseicnWbfpcgqP6JK4YT2Mf1qJ0Yzd36lCJJHosAYJ+EnF4SyX+XURL/9pIvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4RVNyaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B00C4CEC2;
	Fri, 30 Aug 2024 22:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725056614;
	bh=B8VQl5DFu5C3eYK4CExKtHZCyDO+jvgcRht3lHI+Qwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T4RVNyaYiUfiztps76wYOxGaAqTvFn+2fD8jyGJ++g9hwSXomSRSCAxX6lMqk5WiV
	 WiSN5NDTvtZdzrMlROpKcPYo+KT868J09a3CRHAcZyjStASEKAFtJcx1tMg0/dLkb3
	 i9bXSK0iwk+HTSTVKuwdk8QUuxddV9g5le8w5GFLR6pJr1dykZYSFSVL2PRXWvqS7R
	 06dbdfXtsJ0wr9iof+QpVFVbL/2BDJ3gEhTLBsUl9JUw3bgQTXh+HpaFN4bMTeQoTb
	 i1KbBWvhvqDmPwjT/C0ycd317d05VzqFu+dnQdCF3muJoMRScrySTvDOWZc8ttZ1WA
	 R+6jahvx1fUCw==
Date: Fri, 30 Aug 2024 15:23:32 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Yang Ruibin <11162571@vivo.com>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2] drivers: spi: Insert the missing pci_dev_put()before
 return
Message-ID: <20240830222332.GA3862110@thelio-3990X>
References: <20240829033511.1917015-1-11162571@vivo.com>
 <CAMuHMdWNjo69_W6f+R9QJJOf8uF0htg2XazeS-yjugJv3UM+kg@mail.gmail.com>
 <0a906ee9-7b28-45e4-be67-ab3b6c5f89b1@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a906ee9-7b28-45e4-be67-ab3b6c5f89b1@sirena.org.uk>

On Fri, Aug 30, 2024 at 08:57:47PM +0100, Mark Brown wrote:
> On Fri, Aug 30, 2024 at 10:55:06AM +0200, Geert Uytterhoeven wrote:
> > On Thu, Aug 29, 2024 at 5:35 AM Yang Ruibin <11162571@vivo.com> wrote:
> 
> > > -       if (ret)
> > > +       if (ret) {
> > > +               pci_dev_put(dma_dev);
> 
> > dma_dev is still uninitialized at this point.
> 
> I'm a bit concerned that this isn't picked up by an allmodconfig with
> the -Werror...  I'm currently using GCC 12 for that.

It shows up with -Wmaybe-uninitialized for GCC but that's disabled for
the normal kernel build with commit 78a5255ffb6a ("Stop the ad-hoc games
with -Wno-maybe-initialized"). With GCC 12:

  drivers/spi/spi-pxa2xx-pci.c: In function ‘mrfld_spi_setup’:
  drivers/spi/spi-pxa2xx-pci.c:228:17: error: ‘dma_dev’ may be used uninitialized [-Werror=maybe-uninitialized]
    228 |                 pci_dev_put(dma_dev);
        |                 ^~~~~~~~~~~~~~~~~~~~
  drivers/spi/spi-pxa2xx-pci.c:198:25: note: ‘dma_dev’ was declared here
    198 |         struct pci_dev *dma_dev;
        |                         ^~~~~~~
  drivers/spi/spi-pxa2xx-pci.c: In function ‘lpss_spi_setup’:
  drivers/spi/spi-pxa2xx-pci.c:150:17: error: ‘dma_dev’ may be used uninitialized [-Werror=maybe-uninitialized]
    150 |                 pci_dev_put(dma_dev);
        |                 ^~~~~~~~~~~~~~~~~~~~
  drivers/spi/spi-pxa2xx-pci.c:100:25: note: ‘dma_dev’ was declared here
    100 |         struct pci_dev *dma_dev;
        |                         ^~~~~~~

Clang has it under -Wuninitialized, where it was caught with a regular
allmodconfig build:

  drivers/spi/spi-pxa2xx-pci.c:150:15: error: variable 'dma_dev' is uninitialized when used here [-Werror,-Wuninitialized]
    150 |                 pci_dev_put(dma_dev);
        |                             ^~~~~~~
  drivers/spi/spi-pxa2xx-pci.c:100:25: note: initialize the variable 'dma_dev' to silence this warning
    100 |         struct pci_dev *dma_dev;
        |                                ^
        |                                 = NULL
  drivers/spi/spi-pxa2xx-pci.c:228:15: error: variable 'dma_dev' is uninitialized when used here [-Werror,-Wuninitialized]
    228 |                 pci_dev_put(dma_dev);
        |                             ^~~~~~~
  drivers/spi/spi-pxa2xx-pci.c:198:25: note: initialize the variable 'dma_dev' to silence this warning
    198 |         struct pci_dev *dma_dev;
        |                                ^
        |                                 = NULL

Perhaps a KCFLAGS=-Wmaybe-uninitialized in your make command or adding

  subdir-ccflags-$(CONFIG_CC_IS_GCC) := -Wmaybe-uninitialized

to the makefiles of the drivers that you maintain might not be a bad
idea.

Cheers,
Nathan

