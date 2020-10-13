Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF528DD76
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 11:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgJNJYn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 05:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387804AbgJNJUG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Oct 2020 05:20:06 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02039C08EC3D;
        Tue, 13 Oct 2020 16:48:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id o18so1268366edq.4;
        Tue, 13 Oct 2020 16:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:autocrypt:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=HMX3IsBc+vJ1/cQoXAqxUbLWYSuCI0vJduTCBw3Zkac=;
        b=CYKNMbBOMaPMG3z9silqA29uvrmXd9C0jCS06KNyaA+wFNjiwXJbZL1lF+ReR4ab73
         6Fmj5zSeLqccDAXDaj1IShlpMfEV02tSpAJs/sKCYYNOr/m5aQJQg2CorhUSwDqmrLjM
         2q8RZVIvqMBg09+G3KM6sPOZAzgKuKqqvDvx5PggGvwqxmL6JUPXjormU+7X1ElGwm0a
         cehBJgAa/i4DRkOttxcoMnS1/VqJq1ORMM51qghhKGFXB6DEIZnzWxJnUA63jKmeEFsq
         M5r2lexi7/hQO2tUdi9Jsa67IIn/r9PCtdfBG5jhDrIcAr3wXdQBS0oNwSqn7lftafkj
         sYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:autocrypt:cc:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=HMX3IsBc+vJ1/cQoXAqxUbLWYSuCI0vJduTCBw3Zkac=;
        b=UkDOtQjnFgmHuuDGpQgXjbdoDcXQZ+XNjVl+fuascMz3plSvnuncOgGY6oJOmdy2yi
         3llgcgG3OWL0o10U45cKsbcmFL/cUDRcZHHSJWaxR46J2TEDOSe5ODYhVSauplsp3tj+
         kGowJLK/KIztbY/6WWh/NZpg1/YCMAHFGYAuzDuz2tLFM5L++nD4iIFvZKHAdgJIBdxm
         XkP0p1v31WT/TbYoffEAj6p4lvZT8KrZTGDIY+ZeBejbtm9jbq8cGOXPRBJ3GH/DCxMI
         oWsQTHKN5DNIqySgje5tKjnV9qtTsPpn+3erj5Ciab/dAO//DGtdBZhffgDMmW+T5PVm
         2ozQ==
X-Gm-Message-State: AOAM532NVgKFTTxDAq8Ll8khMbipg9wBfFcsY1U4yHwcpHFb8+AVZYyO
        zUNz4ygudb967oUUYZKI+Fh9u+JxvLY=
X-Google-Smtp-Source: ABdhPJzjBi8KimMWDaqnvPNlZRdhptOLwZ9VKVT5Zy5EKqQWcs1O4jcwUhdAUfponQi2wi/tnh0NQg==
X-Received: by 2002:aa7:c984:: with SMTP id c4mr2276072edt.42.1602632926529;
        Tue, 13 Oct 2020 16:48:46 -0700 (PDT)
Received: from [10.67.48.230] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id s6sm661703ejx.79.2020.10.13.16.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 16:48:45 -0700 (PDT)
To:     Lukas Wunner <lukas@wunner.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Use after free in bcm2835_spi_remove()
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Cc:     Mark Brown <broonie@kernel.org>
Message-ID: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
Date:   Tue, 13 Oct 2020 16:48:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Lukas,

With KASAN now working on ARM 32-bit, I was able to get the following
trace upon reboot which invokes bcm2835_spi_shutdown() calling
bcm2835_spi_remove(), the same can be triggered by doing a driver unbind:

# pwd
/sys/devices/platform/rdb/47e204800.spi/driver
# echo 47e204800.spi > unbind

How would you go about fixing this? This was not on a Rpi 4 but in
premise the same problem exists there.

Thanks!

[  229.746516]
==================================================================
[  229.754013] BUG: KASAN: use-after-free in bcm2835_dma_release+0x2c/0x260
[  229.760820] Read of size 4 at addr e0f08358 by task reboot/157
[  229.766727]
[  229.768302] CPU: 0 PID: 157 Comm: reboot Not tainted
5.9.0-gdf4dd84a3f7d #27
[  229.775445] Hardware name: Broadcom STB (Flattened Device Tree)
[  229.781448] Backtrace:
[  229.784017] [<c02120b4>] (dump_backtrace) from [<c02123d8>]
(show_stack+0x20/0x24)
[  229.791738]  r9:ffffffff r8:00000080 r7:c298e3c0 r6:400f0093
r5:00000000 r4:c298e3c0
[  229.799655] [<c02123b8>] (show_stack) from [<c08852a0>]
(dump_stack+0xbc/0xe0)
[  229.807050] [<c08851e4>] (dump_stack) from [<c04522bc>]
(print_address_description.constprop.3+0x3c/0x4b0)
[  229.816863]  r10:c2b771c0 r9:e46d9848 r8:e46d9854 r7:00000000
r6:c0b3ea3c r5:eeea5940
[  229.824815]  r4:e0f08358 r3:00000100
[  229.828510] [<c0452280>] (print_address_description.constprop.3) from
[<c0452944>] (kasan_report+0x15c/0x178)
[  229.838575]  r8:e46d9854 r7:00000000 r6:c0b3ea3c r5:0000009d r4:e0f08358
[  229.845411] [<c04527e8>] (kasan_report) from [<c0452f24>]
(__asan_load4+0x6c/0xbc)
[  229.853109]  r7:e0f08380 r6:e0f08000 r5:e0f08358 r4:e0f08380
[  229.858898] [<c0452eb8>] (__asan_load4) from [<c0b3ea3c>]
(bcm2835_dma_release+0x2c/0x260)
[  229.867318] [<c0b3ea10>] (bcm2835_dma_release) from [<c0b3ecd8>]
(bcm2835_spi_remove+0x68/0xa4)
[  229.876166]  r9:e46d9848 r8:e46d9854 r7:e0f083c0 r6:00000000
r5:e0f08000 r4:e0f08380
[  229.884069] [<c0b3ec70>] (bcm2835_spi_remove) from [<c0b3ed30>]
(bcm2835_spi_shutdown+0x1c/0x38)
[  229.892991]  r7:c2fc7f40 r6:e46d9810 r5:c2a1d854 r4:e46d9800
[  229.898788] [<c0b3ed14>] (bcm2835_spi_shutdown) from [<c0a17010>]
(platform_drv_shutdown+0x40/0x44)
[  229.907958]  r5:c2a1d854 r4:e46d9810
[  229.911653] [<c0a16fd0>] (platform_drv_shutdown) from [<c0a0f91c>]
(device_shutdown+0x248/0x35c)
[  229.920561]  r5:e465b810 r4:e46d9814
[  229.924255] [<c0a0f6d4>] (device_shutdown) from [<c0269418>]
(kernel_restart_prepare+0x4c/0x50)
[  229.933103]  r10:01234567 r9:fee1dead r8:dfdb3f60 r7:c2835240
r6:c2806d48 r5:00000000
[  229.941045]  r4:c2806d40
[  229.943675] [<c02693cc>] (kernel_restart_prepare) from [<c0269528>]
(kernel_restart+0x1c/0x60)
[  229.952405]  r5:00000000 r4:00000000
[  229.956084] [<c026950c>] (kernel_restart) from [<c0269810>]
(__do_sys_reboot+0x148/0x260)
[  229.964380]  r5:00000000 r4:bafb67c0
[  229.968057] [<c02696c8>] (__do_sys_reboot) from [<c0269998>]
(sys_reboot+0x18/0x1c)
[  229.975852]  r10:00000058 r9:dfdb0000 r8:c0200228 r7:00000058
r6:00000000 r5:00000004
[  229.983792]  r4:00000002
[  229.986422] [<c0269980>] (sys_reboot) from [<c0200060>]
(ret_fast_syscall+0x0/0x2c)
[  229.994190] Exception stack(0xdfdb3fa8 to 0xdfdb3ff0)
[  229.999350] 3fa0:                   00000002 00000004 fee1dead
28121969 01234567 000a9864
[  230.007669] 3fc0: 00000002 00000004 00000000 00000058 00000000
00000000 aedbe000 00000000
[  230.015974] 3fe0: aecce8f0 b6a81cec 000982d4 aecce910
[  230.021095]
[  230.022636] Allocated by task 20:
[  230.026039]  kasan_save_stack+0x24/0x48
[  230.029962]  __kasan_kmalloc.constprop.1+0xb8/0xc4
[  230.034842]  kasan_kmalloc+0x10/0x14
[  230.038495]  __kmalloc+0x168/0x2f4
[  230.041976]  __spi_alloc_controller+0x30/0xc0
[  230.046421]  bcm2835_spi_probe+0x90/0x4cc
[  230.050514]  platform_drv_probe+0x70/0xc8
[  230.054612]  really_probe+0x184/0x728
[  230.058361]  driver_probe_device+0xa4/0x278
[  230.062637]  __device_attach_driver+0xe8/0x148
[  230.067169]  bus_for_each_drv+0x108/0x158
[  230.071267]  __device_attach+0x190/0x234
[  230.075279]  device_initial_probe+0x1c/0x20
[  230.079551]  bus_probe_device+0xdc/0xec
[  230.083475]  deferred_probe_work_func+0xd4/0x11c
[  230.088196]  process_one_work+0x420/0x8f0
[  230.092293]  worker_thread+0x4fc/0x91c
[  230.096127]  kthread+0x21c/0x22c
[  230.099427]  ret_from_fork+0x14/0x20
[  230.103075]  0x0
[  230.104957]
[  230.106496] Freed by task 157:
[  230.109627]  kasan_save_stack+0x24/0x48
[  230.113542]  kasan_set_track+0x30/0x38
[  230.117375]  kasan_set_free_info+0x28/0x34
[  230.121553]  __kasan_slab_free+0x110/0x144
[  230.125732]  kasan_slab_free+0x14/0x18
[  230.129556]  kfree+0xbc/0x2b8
[  230.132597]  spi_controller_release+0x18/0x1c
[  230.137037]  device_release+0x4c/0xf0
[  230.140781]  kobject_put+0x14c/0x2d8
[  230.144434]  device_unregister+0x44/0x84
[  230.148438]  spi_unregister_controller+0xcc/0x124
[  230.153233]  bcm2835_spi_remove+0x5c/0xa4
[  230.157328]  bcm2835_spi_shutdown+0x1c/0x38
[  230.161593]  platform_drv_shutdown+0x40/0x44
[  230.165949]  device_shutdown+0x248/0x35c
[  230.169953]  kernel_restart_prepare+0x4c/0x50
[  230.174391]  kernel_restart+0x1c/0x60
[  230.178131]  __do_sys_reboot+0x148/0x260
[  230.182132]  sys_reboot+0x18/0x1c
[  230.185519]  ret_fast_syscall+0x0/0x2c
[  230.189335]  0xb6a81cec
[  230.191829]
[  230.193380] The buggy address belongs to the object at e0f08000
[  230.193380]  which belongs to the cache kmalloc-2k of size 2048
[  230.205354] The buggy address is located 856 bytes inside of
[  230.205354]  2048-byte region [e0f08000, e0f08800)
[  230.215907] The buggy address belongs to the page:
[  230.220806] page:b990e388 refcount:1 mapcount:0 mapping:00000000
index:0x0 pfn:0x20f08
[  230.228841] head:b990e388 order:3 compound_mapcount:0 compound_pincount:0
[  230.235731] flags: 0x2010200(slab|head)
[  230.239688] raw: 02010200 00000000 00000100 00000122 e4401800
00000000 80080008 00000000
[  230.247895] raw: ffffffff 00000001
[  230.251358] page dumped because: kasan: bad access detected
[  230.257000]
[  230.258534] Memory state around the buggy address:
[  230.263412]  e0f08200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  230.270038]  e0f08280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  230.276662] >e0f08300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  230.283272]                                             ^
[  230.288759]  e0f08380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  230.295384]  e0f08400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  230.301992]
==================================================================
[  230.309311] Disabling lock debugging due to kernel taint
[  230.325568] reboot: Restarting system

-- 
Florian
