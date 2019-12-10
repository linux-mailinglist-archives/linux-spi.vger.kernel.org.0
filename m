Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 541A511929E
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2019 22:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLJVCE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Dec 2019 16:02:04 -0500
Received: from muru.com ([72.249.23.125]:44888 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfLJVCE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 10 Dec 2019 16:02:04 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7D9D9820B;
        Tue, 10 Dec 2019 21:02:42 +0000 (UTC)
Date:   Tue, 10 Dec 2019 13:02:00 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Jean Pihet <jean.pihet@newoldbits.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Mark Brown <broonie@kernel.org>,
        linux-omap@vger.kernel.org, linux-spi@vger.kernel.org,
        Ryan Barnett <ryan.barnett@rockwellcollins.com>,
        Conrad Ratschan <conrad.ratschan@rockwellcollins.com>,
        Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH 1/3] TI QSPI: Fix fclk frequency
Message-ID: <20191210210200.GN35479@atomide.com>
References: <20191206160007.331801-1-jean.pihet@newoldbits.com>
 <20191206160007.331801-2-jean.pihet@newoldbits.com>
 <20191206162431.GF35479@atomide.com>
 <CAORVsuUBseM3vnZsSajMmUS1O6rEC4U_aa951HwMsGxyEm+t+g@mail.gmail.com>
 <20191206175731.GG35479@atomide.com>
 <CAORVsuXe7SyAmzLv4VoKMsf4jcYV1bKoCixhsgZ3U0rBHFJA4Q@mail.gmail.com>
 <20191210170329.GM35479@atomide.com>
 <CAORVsuX_bzzsjh+qg_i_sfc=GR6F=S2wgObZiQTdM=w=ghZ9BA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAORVsuX_bzzsjh+qg_i_sfc=GR6F=S2wgObZiQTdM=w=ghZ9BA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

* Jean Pihet <jean.pihet@newoldbits.com> [191210 19:22]:
> On Tue, Dec 10, 2019 at 6:03 PM Tony Lindgren <tony@atomide.com> wrote:
> > Well can test again with the patch below to see if that is
> > enough to make it work :)
> 
> This patch works OK! The correct clock is in use by the driver. The
> hwmod warning shows up at boot:
> [    0.103567] omap_hwmod: qspi: no dt node
> [    0.103599] ------------[ cut here ]------------
> [    0.103639] WARNING: CPU: 0 PID: 1 at
> arch/arm/mach-omap2/omap_hwmod.c:2414 _init.constprop.29+0x198/0x4a0
> [    0.103654] omap_hwmod: qspi: doesn't have mpu register target base

OK good to hear. That warning will go away when the legacy platform
data is removed. So the patch needs to initially still keep the
"ti,hwmods" property until we remove the legacy platform data.

> Glad to help to get to the final solution, please let me know how I
> can help on that.

Well is this needed as a fix or can it wait for the v5.6 merge window?

If it's needed as a fix, some kind of description for the issue
fixed is needed. Any ideas there?

We know the right clock is not found by the driver, but I'm now
wondering if this ever worked or has there been some bootloader
dependency?

Regards,

Tony
