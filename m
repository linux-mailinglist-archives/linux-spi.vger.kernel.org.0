Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6A62CA4E8
	for <lists+linux-spi@lfdr.de>; Tue,  1 Dec 2020 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbgLAOFM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Dec 2020 09:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbgLAOFL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 1 Dec 2020 09:05:11 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0C1C0617A6;
        Tue,  1 Dec 2020 06:04:31 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD61922FAD;
        Tue,  1 Dec 2020 15:04:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606831468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LgcoC/q7pyVkhvpyWhlU5Ne9ks4PahNRgu8btRatkvU=;
        b=vhNuVUhQMRWHcrhJL1c/FP27Jc9RIFUipGXA9bN/oNhXtF8MUpxKyJWjyZZLuKP/guYVZV
        haLXNuHV/E46uR3wbwfez76Bp2QXCJnLdEiAjtwIfHcyoe68AgPHEEa+/Xf5pYxCeL3C0T
        dekf0bmKFc5vyb/4UvklIc0JAQp9B3w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 01 Dec 2020 15:04:27 +0100
From:   Michael Walle <michael@walle.cc>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v3] spi: fsl-dspi: fix NULL pointer dereference
In-Reply-To: <160683107674.35139.13937083243515034859.b4-ty@kernel.org>
References: <20200928085500.28254-1-michael@walle.cc>
 <160683107674.35139.13937083243515034859.b4-ty@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <c1dd024150ed624a6b42562573851f84@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

Am 2020-12-01 14:57, schrieb Mark Brown:
> On Mon, 28 Sep 2020 10:55:00 +0200, Michael Walle wrote:
>> Since commit 530b5affc675 ("spi: fsl-dspi: fix use-after-free in 
>> remove
>> path") this driver causes a kernel oops:
>> 
>> [    1.891065] Unable to handle kernel NULL pointer dereference at 
>> virtual address 0000000000000080
>> [..]
>> [    2.056973] Call trace:
>> [    2.059425]  dspi_setup+0xc8/0x2e0
>> [    2.062837]  spi_setup+0xcc/0x248
>> [    2.066160]  spi_add_device+0xb4/0x198
>> [    2.069918]  of_register_spi_device+0x250/0x370
>> [    2.074462]  spi_register_controller+0x4f4/0x770
>> [    2.079094]  dspi_probe+0x5bc/0x7b0
>> [    2.082594]  platform_drv_probe+0x5c/0xb0
>> [    2.086615]  really_probe+0xec/0x3c0
>> [    2.090200]  driver_probe_device+0x60/0xc0
>> [    2.094308]  device_driver_attach+0x7c/0x88
>> [    2.098503]  __driver_attach+0x60/0xe8
>> [    2.102263]  bus_for_each_dev+0x7c/0xd0
>> [    2.106109]  driver_attach+0x2c/0x38
>> [    2.109692]  bus_add_driver+0x194/0x1f8
>> [    2.113538]  driver_register+0x6c/0x128
>> [    2.117385]  __platform_driver_register+0x50/0x60
>> [    2.122105]  fsl_dspi_driver_init+0x24/0x30
>> [    2.126302]  do_one_initcall+0x54/0x2d0
>> [    2.130149]  kernel_init_freeable+0x1ec/0x258
>> [    2.134520]  kernel_init+0x1c/0x120
>> [    2.138018]  ret_from_fork+0x10/0x34
>> [    2.141606] Code: 97e0b11d aa0003f3 b4000680 f94006e0 (f9404000)
>> [    2.147723] ---[ end trace 26cf63e6cbba33a8 ]---
>> 
>> [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> for-next

Is that correct? Some time ago you've already applied that to your spi 
tree:
https://lore.kernel.org/linux-spi/160132174502.55568.11234605078950751454.b4-ty@kernel.org/

-michael
