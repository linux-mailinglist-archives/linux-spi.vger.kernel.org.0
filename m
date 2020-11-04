Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7332A6EF2
	for <lists+linux-spi@lfdr.de>; Wed,  4 Nov 2020 21:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgKDUkI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 4 Nov 2020 15:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730224AbgKDUkI (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 4 Nov 2020 15:40:08 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70C89204EF;
        Wed,  4 Nov 2020 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604522407;
        bh=VBDu1Nb9K5h2DXXxctVoMtIgdLPRTrWevse84KU65aY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b7eqjeWb89hca6r+DWkfPJdmVuZVh3ekAQe5S+3q1lMp7tEwLQmk63aAphqtilJ02
         zXozlYvUxD0NZpWnVaI9A1fq+gSg7zn9Fn/QQr1hx+JsQ/Ifinvsb1DBc6jscaspNO
         lSfJROfTYkkbwmL1110PzuTe3mF0GAQXw+wbrHys=
Date:   Wed, 4 Nov 2020 20:39:55 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     robh+dt@kernel.org, joel@jms.id.au, andrew@aj.id.au, clg@kaod.org,
        bbrezillon@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-spi@vger.kernel.org, BMC-SW@aspeedtech.com
Subject: Re: [v2 4/4] spi: aspeed: Add ASPEED FMC/SPI memory controller driver
Message-ID: <20201104203955.GA4795@sirena.org.uk>
References: <20201103072202.24705-1-chin-ting_kuo@aspeedtech.com>
 <20201103072202.24705-5-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20201103072202.24705-5-chin-ting_kuo@aspeedtech.com>
X-Cookie: Shake well before using.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2020 at 03:22:02PM +0800, Chin-Ting Kuo wrote:
> Add driver for ASPEED BMC FMC/SPI memory controller which
> supports spi-mem interface.

This breaks the build for me with an x86 allmodconfig:

/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_2600_spi_dma_checksum':
/mnt/kernel/drivers/spi/spi-aspeed.c:195:9: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
  writel((uint32_t)ast_ctrl->chips[cs].ahb_base_phy,
         ^
/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_decode_range_config':
/mnt/kernel/drivers/spi/spi-aspeed.c:488:27: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
   chip[cs].ahb_base_phy = (void __iomem *)start_addr_phy;
                           ^
In file included from /mnt/kernel/include/linux/printk.h:409,
                 from /mnt/kernel/include/linux/kernel.h:16,
                 from /mnt/kernel/include/linux/clk.h:13,
                 from /mnt/kernel/drivers/spi/spi-aspeed.c:11:
/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_exec_op':
/mnt/kernel/drivers/spi/spi-aspeed.c:619:44: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   ctrl_val, addr_mode_reg, addr_data_mask, (uint32_t)op_addr);
                                            ^
/mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of macro '__dynamic_func_call'
   func(&id, ##__VA_ARGS__);  \
               ^~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of macro '_dynamic_func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:618:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(dev, "ctrl: 0x%08x, addr_mode: 0x%x, mask: 0x%x, addr:0x%08x\n",
  ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_dirmap_read':
/mnt/kernel/drivers/spi/spi-aspeed.c:651:25: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
  dev_dbg(ast_ctrl->dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of macro '__dynamic_func_call'
   func(&id, ##__VA_ARGS__);  \
               ^~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of macro '_dynamic_func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:23: note: in expansion of macro 'dev_fmt'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:651:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(ast_ctrl->dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
  ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c: In function 'aspeed_spi_dirmap_write':
/mnt/kernel/drivers/spi/spi-aspeed.c:676:25: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
  dev_dbg(ast_ctrl->dev, "write op:0x%x, addr:0x%llx, len:0x%x\n",
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:129:15: note: in definition of macro '__dynamic_func_call'
   func(&id, ##__VA_ARGS__);  \
               ^~~~~~~~~~~
/mnt/kernel/include/linux/dynamic_debug.h:161:2: note: in expansion of macro '_dynamic_func_call'
  _dynamic_func_call(fmt,__dynamic_dev_dbg,   \
  ^~~~~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:2: note: in expansion of macro 'dynamic_dev_dbg'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
  ^~~~~~~~~~~~~~~
/mnt/kernel/include/linux/dev_printk.h:123:23: note: in expansion of macro 'dev_fmt'
  dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
                       ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:676:2: note: in expansion of macro 'dev_dbg'
  dev_dbg(ast_ctrl->dev, "write op:0x%x, addr:0x%llx, len:0x%x\n",
  ^~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c: At top level:
/mnt/kernel/drivers/spi/spi-aspeed.c:820:17: error: initialization of 'ssize_t (*)(struct spi_mem_dirmap_desc *, u64,  size_t,  void *)' {aka 'long int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  void *)'} from incompatible pointer type 'int (*)(struct spi_mem_dirmap_desc *, uint64_t,  size_t,  void *)' {aka 'int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  void *)'} [-Werror=incompatible-pointer-types]
  .dirmap_read = aspeed_spi_dirmap_read,
                 ^~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:820:17: note: (near initialization for 'aspeed_spi_mem_ops.dirmap_read')
/mnt/kernel/drivers/spi/spi-aspeed.c:821:18: error: initialization of 'ssize_t (*)(struct spi_mem_dirmap_desc *, u64,  size_t,  const void *)' {aka 'long int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  const void *)'} from incompatible pointer type 'int (*)(struct spi_mem_dirmap_desc *, uint64_t,  size_t,  const void *)' {aka 'int (*)(struct spi_mem_dirmap_desc *, long long unsigned int,  long unsigned int,  const void *)'} [-Werror=incompatible-pointer-types]
  .dirmap_write = aspeed_spi_dirmap_write,
                  ^~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/spi/spi-aspeed.c:821:18: note: (near initialization for 'aspeed_spi_mem_ops.dirmap_write')
cc1: some warnings being treated as errors

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+jEZsACgkQJNaLcl1U
h9A64Af6A0oO7eHUA31lFFiQcUOMGH8KmmaRxMguzuA9TLxBmt6wSoZsNbi8Ye2w
hWj4isvP37KIg6vQbgNdXQs3id3giOu9cfuq82vuRNsBfnwde8J1y94aHlVBog5l
UH3A1CkuAml8SFNgyy9pL0g123BomTQt0PwaJZqGgQ0wUc7/BFcL/gtkgJ7vF04s
Fg1kkD+4F5wqaHUCGPebKH3j9J5G5Vjs+4bFZzBxliMGOfNRPUAvGtWMn/UXuhs6
FA2wfFpbeINSJJ7CwNKJ8RNbcYbiwA0lXDZkJCYud/7o6D16vfs0sc0akm3qOH0n
XLaOw+WB3xLClyKArqZCQ9TMmuIbXw==
=y195
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
