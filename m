Return-Path: <linux-spi+bounces-4977-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E709863E2
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 17:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DFE1F26E87
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C4C1D5ACB;
	Wed, 25 Sep 2024 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ht7cQ0fx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4B1D5ABD
	for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278958; cv=none; b=UYPDDZpX94Hzy3bWDCm5eYRQRWvIT3Qjo3v0XaMOrRKUkuks4opvWB9y1wDOzn067lyDSDC8P7hdNAuAGXqn0GEfkT/GdCb35FyK80lD3VSx2MuJAwhNRJ19ByM67ILhP82kUC7kC3JJFNkmm/gkLsHh64klvlZe/T9Rp8mEdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278958; c=relaxed/simple;
	bh=xvnATvHCa+83G2f/pWeX9sm67m0mNXNq2Eh56EOEAuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0+scapU2AHFUo5PG3ZbfphFFQmdvvkUAyKWw8Tn6WE1lguMnZ0zAEUSaPlzw/gPD8P1NgvSDPZjyP1Ox7Rb2dFNnl4xtfyn5YO2MnAUtLMuM31eQro8cPRoSJmV3BSLHUPGig2TK/UNosd1P+0Py/HSwvD+EDd0BTM0x2iUGt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ht7cQ0fx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so56750425e9.2
        for <linux-spi@vger.kernel.org>; Wed, 25 Sep 2024 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727278954; x=1727883754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g0mFpqnpoinOCXBInQEuDDX6aMSTJM1UcQ5ZlfmwjZY=;
        b=ht7cQ0fxNiApLr3EzG2PLcCXlc/G3QN7e6uEDGmq07RgiXco2w9IWoRtLzSrGXlx5S
         SMRCdarmwNtLA61KQI1TJozgw80ptxncIrfRDZ/1meY2LvnqNNZNcxT9tPIxwLwA/6bE
         R6kSivyPz3aCNWX0yc3mcL4K8DCRAjHXIuhA+sYJUOqQ+Ohn5ss9a6qifALC65nem5bu
         03AeCH+B2kN7m2oLxjMdm9xkETWpPkrUBhQkajZMgyUwpRStKI4Z/zj3I5LoYP8L1uzD
         68iAOuQX3Vef6ZKBzGyfRWVrTv58+sxhoaNx9lzqip3P6PpMPBUJ1gAY3V99fg44F4bu
         oE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727278954; x=1727883754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0mFpqnpoinOCXBInQEuDDX6aMSTJM1UcQ5ZlfmwjZY=;
        b=Xdd34zgL2WvJ+/PDVJ0GiYTp/tBqSUEyXoGFHQQbXOimClhZTQlHeVxjpoojA9BGVz
         2hQyfFk3TvOcLQO9dI/mfcHpmbankMQdfKMsdAlMWeVnR2KH/PmK3T2UA2txP2V5Qqf6
         OnPoMpPUhorGOczyRA8r3y2Kkd69oo+iIsyLcFWQUIpm8kWdcNZg9afksMvDDvp1gsHO
         HD+CVInoZD95wBjE1ugr0LRtcu4B82dv4N5l3MnIuOR7L2J9+BhOV9h3eWYkhR3j1kuY
         JGv1Y39LT8Jnyr5Ou9tSLpauToOxHw6Lsxx9Cny9ZmDwWUH0v5zs2BanJV5Ncf0rMdfO
         a5OQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXnB5YItEjTQFRHjShG2or/9VfitP4YlgwCKEcenHCKIZWYeWGxGN6b+xh8j4A1N6sT9WhipmWnbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGD0nPYSGfkjHI5HvuC3HvFzoEQ8MDBiLY7lgNE+PzAwOrUIk
	OvIyE47GylJBWNf/GVNPSzi9YHLcndI6i0wCZiJJcAwacqrbZSoYpvKlkzDG0JQ=
X-Google-Smtp-Source: AGHT+IEta/pHJEdAqwxpYPQh0rMmpm7cy3Xt5wwkMG/IZHQd+x44gnkhq/00wpsMnZ0byD/D2gbRjA==
X-Received: by 2002:a05:600c:4f54:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-42e9610ac8cmr18509225e9.13.1727278954480;
        Wed, 25 Sep 2024 08:42:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2cec21sm4288174f8f.52.2024.09.25.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 08:42:33 -0700 (PDT)
Date: Wed, 25 Sep 2024 18:42:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Georgi Djakov <djakov@kernel.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>, linux-spi@vger.kernel.org,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 6.1 00/63] 6.1.111-rc1 review
Message-ID: <32aa7502-ae52-4119-9e72-6347c32f1f23@stanley.mountain>
References: <20240916114221.021192667@linuxfoundation.org>
 <CA+G9fYtsjFtddG8i+k-SpV8U6okL0p4zpsTiwGfNH5GUA8dWAA@mail.gmail.com>
 <b0dfa622-f4f7-4f76-9d67-621544cb2212@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0dfa622-f4f7-4f76-9d67-621544cb2212@kernel.org>

On Wed, Sep 18, 2024 at 03:08:13PM +0300, Georgi Djakov wrote:
> > Warning log:
> > --------
> > [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x517f803c]
> > [    0.000000] Linux version 6.1.111-rc1 (tuxmake@tuxmake)
> > (aarch64-linux-gnu-gcc (Debian 13.3.0-5) 13.3.0, GNU ld (GNU Binutils
> > for Debian) 2.43) #1 SMP PREEMPT @1726489583
> > [    0.000000] Machine model: Thundercomm Dragonboard 845c
> > ...
> > [    7.841428] ------------[ cut here ]------------
> > [    7.841431] WARNING: CPU: 4 PID: 492 at
> > drivers/interconnect/core.c:685 __icc_enable
> > (drivers/interconnect/core.c:685 (discriminator 7))
> > [    7.841442] Modules linked in: soundwire_bus(+) venus_core(+)
> > qcom_camss(+) drm_dp_aux_bus bluetooth(+) qcom_stats mac80211(+)
> > videobuf2_dma_sg drm_display_helper i2c_qcom_geni(+) i2c_qcom_cci
> > camcc_sdm845(+) v4l2_mem2mem qcom_q6v5_mss(+) videobuf2_memops
> > reset_qcom_pdc spi_geni_qcom(+) videobuf2_v4l2 phy_qcom_qmp_usb(+)
> > videobuf2_common gpi(+) qcom_rng cfg80211 phy_qcom_qmp_ufs ufs_qcom(+)
> > coresight_stm phy_qcom_qmp_pcie stm_core rfkill slim_qcom_ngd_ctrl
> > qrtr pdr_interface lmh qcom_wdt slimbus icc_osm_l3 qcom_q6v5_pas(+)
> > icc_bwmon llcc_qcom qcom_pil_info qcom_q6v5 qcom_sysmon qcom_common
> > qcom_glink_smem qmi_helpers mdt_loader display_connector
> > drm_kms_helper drm socinfo rmtfs_mem
> > [    7.841494] CPU: 4 PID: 492 Comm: (udev-worker) Not tainted 6.1.111-rc1 #1
> > [    7.841497] Hardware name: Thundercomm Dragonboard 845c (DT)
> > [    7.841499] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > [    7.841502] pc : __icc_enable (drivers/interconnect/core.c:685
> > (discriminator 7))
> > [    7.841505] lr : icc_disable (drivers/interconnect/core.c:708)
> > [    7.841508] sp : ffff800008b23660
> > [    7.841509] x29: ffff800008b23660 x28: ffff800008b23c20 x27: 0000000000000000
> > [    7.841513] x26: ffffdd85da6ea1c0 x25: 0000000000000008 x24: 00000000000f4240
> > [    7.841516] x23: 0000000000000000 x22: ffff46a58b7ca580 x21: 0000000000000001
> > [    7.841519] x20: ffff46a58b7ca5c0 x19: ffff46a58b54a800 x18: 0000000000000000
> > [    7.841522] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> > [    7.841525] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
> > [    7.841528] x11: fefefefefefefeff x10: 0000000000000bf0 x9 : ffffdd85d8c9b0bc
> > [    7.841531] x8 : ffff800008b22f58 x7 : 0000000000000000 x6 : 0000000000024404
> > [    7.841535] x5 : 0000000000000000 x4 : ffff46a58b64b180 x3 : ffffdd85daa5e810
> > [    7.841537] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> > [    7.841541] Call trace:
> > [    7.841542] __icc_enable (drivers/interconnect/core.c:685 (discriminator 7))
> > [    7.841545] icc_disable (drivers/interconnect/core.c:708)
> > [    7.841547] geni_icc_disable (drivers/soc/qcom/qcom-geni-se.c:862)
> > [    7.841553] spi_geni_runtime_suspend+0x3c/0x4c spi_geni_qcom
> > [    7.841561] pm_generic_runtime_suspend (drivers/base/power/generic_ops.c:28)
> > [    7.841565] __rpm_callback (drivers/base/power/runtime.c:395)
> > [    7.841568] rpm_callback (drivers/base/power/runtime.c:532)
> > [    7.841570] rpm_suspend (drivers/base/power/runtime.c:672)
> > [    7.841572] rpm_idle (drivers/base/power/runtime.c:504 (discriminator 1))
> > [    7.841574] update_autosuspend (drivers/base/power/runtime.c:1662)
> > [    7.841576] pm_runtime_disable_action (include/linux/spinlock.h:401
> > drivers/base/power/runtime.c:1703 include/linux/pm_runtime.h:599
> > drivers/base/power/runtime.c:1517)
> > [    7.841579] devm_action_release (drivers/base/devres.c:720)
> > [    7.841581] release_nodes (drivers/base/devres.c:503)
> > [    7.841583] devres_release_all (drivers/base/devres.c:532)
> > [    7.841585] device_unbind_cleanup (drivers/base/dd.c:531)
> > [    7.841589] really_probe (drivers/base/dd.c:710)
> > [    7.841592] __driver_probe_device (drivers/base/dd.c:785)
> > [    7.841594] driver_probe_device (drivers/base/dd.c:815)
> > [    7.841596] __driver_attach (drivers/base/dd.c:1202)
> > [    7.841598] bus_for_each_dev (drivers/base/bus.c:301)
> > [    7.841600] driver_attach (drivers/base/dd.c:1219)
> > [    7.841602] bus_add_driver (drivers/base/bus.c:618)
> > [    7.841604] driver_register (drivers/base/driver.c:246)
> > [    7.841607] __platform_driver_register (drivers/base/platform.c:868)
> > [    7.841609] spi_geni_driver_init+0x28/0x1000 spi_geni_qcom


So it looks like spi_geni_probe() calls geni_icc_get() which fails.  It must
be with -EPROBE_DEFER otherwise we would get a printk.  This could happen if
of_icc_get_from_provider() fails for example.  There are two callers.  These
were the only possibilities that I saw which didn't lead to a warning message.

The automatic cleanup tries to suspend and triggers the warning IS_ERR() warning
in __icc_enable().

	if (WARN_ON(IS_ERR(path) || !path->num_nodes))

The best option is probably to disable the warning for EPROBE_DEFER.  Another
two options would be to disable the warning entirely.  A third option would be
to do a work-around for EPROBE_DEFER in geni_icc_get().

Please, could you take a look and give the Reported-by tag to Naresh?  Or I
could send this patch if you want.

regards,
dan carpenter

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index 4526ff2e1bd5..0caf8ead6573 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -682,6 +682,8 @@ static int __icc_enable(struct icc_path *path, bool enable)
 	if (!path)
 		return 0;
 
+	if (IS_ERR(path) && (PTR_ERR(path) == -EPROBE_DEFER))
+		return 0;
 	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
 		return -EINVAL;
 

