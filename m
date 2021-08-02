Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730CC3DD6FC
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 15:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbhHBNYn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 09:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhHBNYl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Aug 2021 09:24:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D234C061760
        for <linux-spi@vger.kernel.org>; Mon,  2 Aug 2021 06:24:31 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x8so20348944lfe.3
        for <linux-spi@vger.kernel.org>; Mon, 02 Aug 2021 06:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=xeiQYb/DNYTGTCzG1b2lHBBv1FSevpdfpV+wEJRHRlw=;
        b=O70geVJn62BiFeJePHhndWM9DlugrXhYZu4Qu5eYB/cvm7ip+eC1PRInYbS6u+cQBm
         DhXtv3YcKsYY+pmNGeW2M8X7YrO+++9QeyLYGbtAiiuY3ELDnX4q9Lx3w9dYe4SEDWux
         uVt3KsQBESIbhGX4qy5LvmR09rRJJDNlPOc5IsUXqx5dfoeCJPIaBQ1M/9qFesU11q19
         WVfBLLH/EymyQ4t5NFD9B5lIxJNzMBNwzgGMvgJWO4ExI6ehIZiDBP2YCqrMnLoCbdmU
         j08R8VzvqebxEHynE8/IZ5dG/8sklK0xPhqcITU/B3gldDXMK5raX8HDCQgAGUzfF1rO
         U36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=xeiQYb/DNYTGTCzG1b2lHBBv1FSevpdfpV+wEJRHRlw=;
        b=Q0Om9f34eo0rY7dqRaDjYhaRxsiLXgSsgZlANp2ES5zhvbSD/eSX3z+xtjmNm5/lfb
         IR20D5r0XxUVC/qc01AUh5DcT80iY3k1ocN6PwPygJroQ8LKUHHgJZC0F74astN3ORAt
         1fFBC4A392w74QOs4nvk7bVA4wr6bDSrm2z1AXY20tYg7nF73T0N7p91/jSJcodHliOL
         g7wPDVhcoYD+1cO+lr2yjvn8+fJoyqY5EFaMlXe13y4tJ/ZkIWp7dJkOeX0IxXz+s9rB
         JjOOl44MDCSVWqdrjHpFMLQvI5p9axaCJmF3X6x2t5QbZPS/Sg3J7FiQjcR+TZ5oHt/W
         nYqQ==
X-Gm-Message-State: AOAM531+ZYVjFrMZdmBGG5gOqbAntzrVMQvzt/GD/IuL2tTROek20ny/
        RUFYAwQLxD9FYoaKg0fYYNI=
X-Google-Smtp-Source: ABdhPJxqAzpHz/oZSjsjOAaXlf6ca53rx+JLB4t2dyDEHo5LjUc2utVBaQTUQUyrkYOC07CRwK5cag==
X-Received: by 2002:a05:6512:3147:: with SMTP id s7mr12162072lfi.189.1627910669521;
        Mon, 02 Aug 2021 06:24:29 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id i7sm310283lfo.239.2021.08.02.06.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Aug 2021 06:24:29 -0700 (PDT)
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: spi-nor 5.11 regression: Division by zero in kernel
To:     MTD Maling List <linux-mtd@lists.infradead.org>
Cc:     linux-spi@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <99bdb1eb-71a8-99e6-be03-a97185246740@gmail.com>
Date:   Mon, 2 Aug 2021 15:24:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

It seems that kernel 5.11 broke spi-nor on Broadcom Northstar (BCM5301X)
platforms.

The problem seems to be spi_nor_spimem_read_data() which calculates:
op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;

On Northstar this happens to be:
op.dummy.nbytes = (0 * 0) / 8;

That results in bcm_qspi_bspi_set_flex_mode() dividing by zero in the:
bpp |= (op->dummy.nbytes * 8) / op->dummy.buswidth;

Could you take a look at that issue, please?

GOOD	5.10.55
BAD	5.11.22
BAD	5.12.19
BAD	5.13.2
BAD	5.13.7

[    1.075513] Division by zero in kernel.
[    1.079354] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.7 #18
[    1.085376] Hardware name: BCM5301X
[    1.088873] [<c0108394>] (unwind_backtrace) from [<c010498c>] (show_stack+0x10/0x14)
[    1.096666] [<c010498c>] (show_stack) from [<c0696470>] (dump_stack+0x94/0xa8)
[    1.103926] [<c0696470>] (dump_stack) from [<c03e7f94>] (Ldiv0+0x8/0x10)
[    1.110653] [<c03e7f94>] (Ldiv0) from [<c0699274>] (bcm_qspi_exec_mem_op+0x3e0/0x744)
[    1.118512] [<c0699274>] (bcm_qspi_exec_mem_op) from [<c0698740>] (spi_mem_exec_op+0x184/0x4fc)
[    1.127234] [<c0698740>] (spi_mem_exec_op) from [<c0698bac>] (spi_mem_dirmap_read+0xf4/0x1c8)
[    1.135780] [<c0698bac>] (spi_mem_dirmap_read) from [<c0697d58>] (spi_nor_spimem_read_data+0x13c/0x1ec)
[    1.145199] [<c0697d58>] (spi_nor_spimem_read_data) from [<c0498d60>] (spi_nor_read+0x16c/0x174)
[    1.154008] [<c0498d60>] (spi_nor_read) from [<c04835d0>] (mtd_read_oob_std+0x9c/0xa4)
[    1.161964] [<c04835d0>] (mtd_read_oob_std) from [<c04855d0>] (mtd_read_oob+0x84/0x148)
[    1.169997] [<c04855d0>] (mtd_read_oob) from [<c04856f4>] (mtd_read+0x60/0x90)
[    1.177237] [<c04856f4>] (mtd_read) from [<c048ab50>] (bcm47xxpart_parse+0x1d4/0x744)
[    1.185089] [<c048ab50>] (bcm47xxpart_parse) from [<c0488568>] (parse_mtd_partitions+0x188/0x424)
[    1.193985] [<c0488568>] (parse_mtd_partitions) from [<c0486018>] (mtd_device_parse_register+0x7c/0x1c0)
[    1.203489] [<c0486018>] (mtd_device_parse_register) from [<c04998b8>] (spi_nor_probe+0x20c/0x2d0)
[    1.212471] [<c04998b8>] (spi_nor_probe) from [<c046fbf8>] (really_probe+0xf0/0x4dc)
[    1.220245] [<c046fbf8>] (really_probe) from [<c046dd40>] (bus_for_each_drv+0x80/0xd0)
[    1.228184] [<c046dd40>] (bus_for_each_drv) from [<c04701d0>] (__device_attach+0xf8/0x15c)
[    1.236468] [<c04701d0>] (__device_attach) from [<c046edd4>] (bus_probe_device+0x84/0x8c)
[    1.244668] [<c046edd4>] (bus_probe_device) from [<c046c6c4>] (device_add+0x300/0x840)
[    1.252606] [<c046c6c4>] (device_add) from [<c04b3dc4>] (spi_add_device+0x9c/0x164)
[    1.260292] [<c04b3dc4>] (spi_add_device) from [<c04b482c>] (spi_register_controller+0x8ac/0xbc0)
[    1.269187] [<c04b482c>] (spi_register_controller) from [<c04b7bd4>] (bcm_qspi_probe+0x600/0x700)
[    1.278092] [<c04b7bd4>] (bcm_qspi_probe) from [<c0471d3c>] (platform_probe+0x48/0x8c)
[    1.286030] [<c0471d3c>] (platform_probe) from [<c046fbf8>] (really_probe+0xf0/0x4dc)
[    1.293880] [<c046fbf8>] (really_probe) from [<c04705dc>] (device_driver_attach+0xf0/0x100)
[    1.302254] [<c04705dc>] (device_driver_attach) from [<c0470678>] (__driver_attach+0x8c/0x11c)
[    1.310888] [<c0470678>] (__driver_attach) from [<c046dc74>] (bus_for_each_dev+0x74/0xc0)
[    1.319086] [<c046dc74>] (bus_for_each_dev) from [<c046efc8>] (bus_add_driver+0xf4/0x1dc)
[    1.327286] [<c046efc8>] (bus_add_driver) from [<c0470cdc>] (driver_register+0x88/0x118)
[    1.335397] [<c0470cdc>] (driver_register) from [<c01016dc>] (do_one_initcall+0x54/0x1d0)
[    1.343598] [<c01016dc>] (do_one_initcall) from [<c08010e8>] (kernel_init_freeable+0x244/0x2ac)
[    1.352337] [<c08010e8>] (kernel_init_freeable) from [<c069a7c8>] (kernel_init+0x8/0x118)
[    1.360536] [<c069a7c8>] (kernel_init) from [<c0100130>] (ret_from_fork+0x14/0x24)
[    1.368125] Exception stack(0xc1035fb0 to 0xc1035ff8)
[    1.373184] 5fa0:                                     00000000 00000000 00000000 00000000
[    1.381384] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.389582] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
