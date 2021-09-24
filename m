Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402434171B4
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 14:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244404AbhIXMXp (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 08:23:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245667AbhIXMXn (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 08:23:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15B5560EC0;
        Fri, 24 Sep 2021 12:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632486129;
        bh=yaIuJc4fCylLr72PbMyGEkx+lSAK/GgR3Rnq7A0ONwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ew/Ic64IxETANxezYJgvb0WPOB0R7NVVOY+gwPWSpMloYwI9Jd7URrC3EEr+sFou4
         ZVBGmm9SCXcYtc4GZ1hZqBzrD//IqQQEwDycRttj13UZIE1IbugFO0Q+hlNSSx+rEP
         0aaQsqu9Fg1Jmasp9jxTHlcqeNmImsdlknAvfTEQ=
Date:   Fri, 24 Sep 2021 14:22:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        git@xilinx.com, saikrishna12468@gmail.com,
        Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Subject: Re: [PATCH 1/4] firmware: xilinx: Add OSPI Mux selection support
Message-ID: <YU3C7y833i9f0+yB@kroah.com>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1632478031-12242-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <YU24KEoXQOw/1uZV@kroah.com>
 <c588c9c4-df4b-a617-35d1-23c32654d5ff@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c588c9c4-df4b-a617-35d1-23c32654d5ff@xilinx.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Sep 24, 2021 at 02:12:55PM +0200, Michal Simek wrote:
> 
> 
> On 9/24/21 1:36 PM, Greg Kroah-Hartman wrote:
> > On Fri, Sep 24, 2021 at 03:37:08PM +0530, Sai Krishna Potthuri wrote:
> >> Add OSPI Mux selection API support to select the AXI interface to OSPI.
> >>
> >> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> >> ---
> >>  drivers/firmware/xilinx/zynqmp.c     | 17 +++++++++++++++++
> >>  include/linux/firmware/xlnx-zynqmp.h | 12 ++++++++++++
> >>  2 files changed, 29 insertions(+)
> >>
> >> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> >> index 15b138326ecc..43c3b5a9eef7 100644
> >> --- a/drivers/firmware/xilinx/zynqmp.c
> >> +++ b/drivers/firmware/xilinx/zynqmp.c
> >> @@ -647,6 +647,23 @@ int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
> >>  }
> >>  EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
> >>  
> >> +/**
> >> + * zynqmp_pm_ospi_mux_select() - OSPI Mux selection
> >> + *
> >> + * @dev_id:	Device Id of the OSPI device.
> >> + * @select:	OSPI Mux select value.
> >> + *
> >> + * This function select the OSPI Mux.
> >> + *
> >> + * Return:	Returns status, either success or error+reason
> >> + */
> >> +int zynqmp_pm_ospi_mux_select(u32 dev_id, u32 select)
> >> +{
> >> +	return zynqmp_pm_invoke_fn(PM_IOCTL, dev_id, IOCTL_OSPI_MUX_SELECT,
> >> +				   select, 0, NULL);
> >> +}
> >> +EXPORT_SYMBOL_GPL(zynqmp_pm_ospi_mux_select);
> >> +
> >>  /**
> >>   * zynqmp_pm_write_ggs() - PM API for writing global general storage (ggs)
> >>   * @index:	GGS register index
> >> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> >> index 9d1a5c175065..6979a79f553a 100644
> >> --- a/include/linux/firmware/xlnx-zynqmp.h
> >> +++ b/include/linux/firmware/xlnx-zynqmp.h
> >> @@ -119,6 +119,7 @@ enum pm_ioctl_id {
> >>  	IOCTL_READ_PGGS = 15,
> >>  	/* Set healthy bit value */
> >>  	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
> >> +	IOCTL_OSPI_MUX_SELECT = 21,
> > 
> > Why the gap?  What are the commands in the middle for?
> 
> Below is the full list. Not everything has been upstream yet. There was
> an attempt on AFI which one colleague is working on and should send new
> version soon. I don't think anybody has started with upstreaming probe
> counters.
> Every part has different owner with unfortunately own upstreaming plan.
> 
> Thanks,
> Michal
> 
> enum pm_ioctl_id {
> 	IOCTL_GET_RPU_OPER_MODE = 0,
> 	IOCTL_SET_RPU_OPER_MODE = 1,
> 	IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
> 	IOCTL_TCM_COMB_CONFIG = 3,
> 	IOCTL_SET_TAPDELAY_BYPASS = 4,
> 	IOCTL_SET_SGMII_MODE = 5,
> 	IOCTL_SD_DLL_RESET = 6,
> 	IOCTL_SET_SD_TAPDELAY = 7,
> 	IOCTL_SET_PLL_FRAC_MODE = 8,
> 	IOCTL_GET_PLL_FRAC_MODE = 9,
> 	IOCTL_SET_PLL_FRAC_DATA = 10,
> 	IOCTL_GET_PLL_FRAC_DATA = 11,
> 	IOCTL_WRITE_GGS = 12,
> 	IOCTL_READ_GGS = 13,
> 	IOCTL_WRITE_PGGS = 14,
> 	IOCTL_READ_PGGS = 15,
> 	/* IOCTL for ULPI reset */
> 	IOCTL_ULPI_RESET = 16,
> 	/* Set healthy bit value */
> 	IOCTL_SET_BOOT_HEALTH_STATUS = 17,
> 	IOCTL_AFI = 18,
> 	/* Probe counter read/write */
> 	IOCTL_PROBE_COUNTER_READ = 19,
> 	IOCTL_PROBE_COUNTER_WRITE = 20,
> 	IOCTL_OSPI_MUX_SELECT = 21,
> 	/* IOCTL for USB power request */
> 	IOCTL_USB_SET_STATE = 22,
> 	/* IOCTL to get last reset reason */
> 	IOCTL_GET_LAST_RESET_REASON = 23,
> 	/* AI engine NPI ISR clear */
> 	IOCTL_AIE_ISR_CLEAR = 24,
> 	/* Register SGI to ATF */
> 	IOCTL_REGISTER_SGI = 25,
> 	/* Runtime feature configuration */
> 	IOCTL_SET_FEATURE_CONFIG = 26,
> 	IOCTL_GET_FEATURE_CONFIG = 27,
> };

Odd mix of comments and no comments...

Anyway, that's fine, just curious as to why there was a gap.  No real
reason why you can't just add them all now right?

thanks,

greg k-h
