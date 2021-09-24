Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15584170EF
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 13:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbhIXLho (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 07:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244439AbhIXLhn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 07:37:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48BDF61241;
        Fri, 24 Sep 2021 11:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632483370;
        bh=GVK5jCV+2GJ3l9xXZf3QHWw2lsE24mYjuokUNEhn5jk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4faQon7fKlxX0nkUG5z8vcWUYqa1p+3n5KLHLD1J69CN72oyLLrlk+q7UBz2pm3X
         FqZfEJfMat4qISWxH78KWsi9GOQLTKGnLj1Yd/75rlMkhQJkU/ja8bVrTyQxMa/Tts
         JJqGFTqmryihFozCOEcgOxH4XqXsl38q7B0dWR3g=
Date:   Fri, 24 Sep 2021 13:36:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        git@xilinx.com, saikrishna12468@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH 1/4] firmware: xilinx: Add OSPI Mux selection support
Message-ID: <YU24KEoXQOw/1uZV@kroah.com>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1632478031-12242-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1632478031-12242-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 24, 2021 at 03:37:08PM +0530, Sai Krishna Potthuri wrote:
> Add OSPI Mux selection API support to select the AXI interface to OSPI.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 15b138326ecc..43c3b5a9eef7 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -647,6 +647,23 @@ int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
>  
> +/**
> + * zynqmp_pm_ospi_mux_select() - OSPI Mux selection
> + *
> + * @dev_id:	Device Id of the OSPI device.
> + * @select:	OSPI Mux select value.
> + *
> + * This function select the OSPI Mux.
> + *
> + * Return:	Returns status, either success or error+reason
> + */
> +int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
> +{
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
> +				   select, 0, NULL);
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
> +
>  /**
>   * zynqmp_pm_write_ggs() - PM API for writing global general storage (ggs)
>   * @index:	GGS register index
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 9d1a5c175065..6979a79f553a 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -119,6 +119,7 @@ enum pm_ioctl_id {
>  	IOCTL_READ_PGGS = 15,
>  	/* Set healthy bit value */
>  	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
> +	IOCTL_OSPI_MUX_SELECT = 21,

Why the gap?  What are the commands in the middle for?

thanks,

greg k-h
