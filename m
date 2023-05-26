Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558F571292E
	for <lists+linux-spi@lfdr.de>; Fri, 26 May 2023 17:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243506AbjEZPNI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 May 2023 11:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjEZPNH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 May 2023 11:13:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5797313D
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 08:13:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA815650C9
        for <linux-spi@vger.kernel.org>; Fri, 26 May 2023 15:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC43CC433EF;
        Fri, 26 May 2023 15:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685113985;
        bh=jllZZGrA4gsgP+ByBARANyOtGQ+rmmd98Jzv7HPlTtM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=leU2fLqF7TAy3ZQfMA/VaRbD4uDhEmiX15IqnWZOCCw4uRGfKNvDiF6+p5zj0yG8f
         Mrmqi3WVOv4zmpTSvLnDUZ0BGWhcdpM8Rkw7WvCilgqM6pVBBbcMrUX21h5GIStTqJ
         buqU3Rn9DcoiydEaUPXWzX8zRrd30EhbYgM4CKrQl3zi2ObESsisLnyMjYwFMIvoaq
         NvgX0RkFvjAzJTsNIxsjxVQSEIldKRxLcbM8T5xqQuqcO6W8O35CJTIjnaOMS6y4qs
         /TlxqQyBAb8jhugZoGv5rPyp+ZZrg3iZ6SKPs31tTORSpgeiv/iJJ8WvnLKw6dICXm
         P/blECHss4aFg==
Date:   Fri, 26 May 2023 17:13:00 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        jiada wang <jiada_wang@mentor.com>, linux-spi@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] spi: imx: correct handling of MXC_CSPIRXDATA value
 endianness
Message-ID: <ZHDMfC1d5GyhaUb1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd601c80-87dc-c032-4b75-5ac368981f64@pengutronix.de>
 <d29db298-0484-ea6f-3554-fa02b3a077dd@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, May 26, 2023 at 04:09:48PM +0200, Ahmad Fatoum wrote:
> Hello Simon,
> 
> On 26.05.23 16:03, Simon Horman wrote:
> > The existing code seems be intended to handle MXC_CSPIRXDATA values
> > which are in big endian. However, it seems that this is only
> > handled correctly in the case where the host is little endian.
> > 
> > First, consider the read case.
> > 
> > 	u32 val = be32_to_cpu(readl(...))
> > 
> > readl() will read a 32bit value and return it after applying le32_to_cpu().
> > On a little endian host le32_to_cpu() is a noop. So the raw value is
> > returned. This is then converted from big endian to host byte-order -
> > the value is byte-swapped - using be32_to_cpu(). Assuming the raw value
> > is big endian a host byte-order value is obtained. This seems correct.
> > 
> > However, on a big endian system, le32_to_cpu() will perform a byte-swap,
> > while be32_to_cpu() is a noop. Assuming the underlying value is big
> > endian this is incorrect, because it should not be byte-swapped to
> > obtain the value in host byte-order - big endian.
> > 
> > Surveying other kernel code it seems that a correct approach is:
> > 
> > 	 be32_to_cpu((__force __be32)__raw_readl(...))
> 
> How about using ioread32be?

...

On Fri, May 26, 2023 at 04:12:46PM +0200, Ahmad Fatoum wrote:
> On 26.05.23 16:09, Ahmad Fatoum wrote:
> >> -	writel(val, spi_imx->base + MXC_CSPITXDATA);
> >> +	__raw_writel((__force u32)cpu_to_be32(val),
> >> +		     spi_imx->base + MXC_CSPITXDATA);
> >>  }
> 
> On more thing: __raw_writel doesn't involve a write barrier (at least
> on ARM). That means above code introduces a bug as the CPU may now reorder
> writes that were sequential before. Both iowrite32be() and readl()
> have a __iowmb(); on ARM before doing the write itself.

Thanks Ahmad,

I agree that ioread32be() and iowrite32be() look like a better solution.
I'll plan to spin a v2 accordingly.
