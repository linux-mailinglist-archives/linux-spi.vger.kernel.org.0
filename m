Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302983DDEF5
	for <lists+linux-spi@lfdr.de>; Mon,  2 Aug 2021 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhHBSMX (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Aug 2021 14:12:23 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42620 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSMW (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Aug 2021 14:12:22 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 172IC3iL075966;
        Mon, 2 Aug 2021 13:12:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1627927923;
        bh=6jKNCNgnOk/jr23qOQNV3EWRpcXfYEqxPGAv2dk/mMk=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=g5lt/89WzFOtxGWjxwuVJoEADXZJCczHHMOSwuuCZ/e3Ui24FnsyxKYKlDOEnnWSQ
         yW7WL87NRSxTsiSucSgrSzAjdqP3NsYqAH8dpHgtlR0P13tiJAdzyX0FuFzZ91dQ8c
         xJiZGzY5k9IZXeMLKhWTPsEVGx7jPdd52sh8SUAc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 172IC2wD036760
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 2 Aug 2021 13:12:03 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 2 Aug
 2021 13:12:02 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2 via
 Frontend Transport; Mon, 2 Aug 2021 13:12:02 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 172IC2f8074437;
        Mon, 2 Aug 2021 13:12:02 -0500
Date:   Mon, 2 Aug 2021 23:42:01 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <Tudor.Ambarus@microchip.com>
CC:     <zajec5@gmail.com>, <linux-mtd@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <kdasu.kdev@gmail.com>,
        <boris.brezillon@collabora.com>, Mark Brown <broonie@kernel.org>
Subject: Re: spi-nor 5.11 regression: Division by zero in kernel
Message-ID: <20210802181201.wkff3k32to3lin4n@ti.com>
References: <99bdb1eb-71a8-99e6-be03-a97185246740@gmail.com>
 <b3d23f9d-5c84-c4cc-dede-85ec85135276@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b3d23f9d-5c84-c4cc-dede-85ec85135276@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+ Mark

On 02/08/21 02:39PM, Tudor.Ambarus@microchip.com wrote:
> On 8/2/21 4:24 PM, Rafał Miłecki wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi,
> 
> Hi, Rafał!
> 
> > 
> > It seems that kernel 5.11 broke spi-nor on Broadcom Northstar (BCM5301X)
> > platforms.
> > 
> > The problem seems to be spi_nor_spimem_read_data() which calculates:
> > op.dummy.nbytes = (nor->read_dummy * op.dummy.buswidth) / 8;
> > 
> > On Northstar this happens to be:
> > op.dummy.nbytes = (0 * 0) / 8;
> > 
> > That results in bcm_qspi_bspi_set_flex_mode() dividing by zero in the:
> > bpp |= (op->dummy.nbytes * 8) / op->dummy.buswidth;
> > 
> > Could you take a look at that issue, please?
> > 
> > GOOD    5.10.55
> > BAD     5.11.22
> > BAD     5.12.19
> > BAD     5.13.2
> > BAD     5.13.7
> > 
> 
> It's hard to guess. Would you please bisect and identify the commit that introduces
> the regression?

I think the bug is pretty obvious here. op->dummy.buswidth is 0 when 
there is no dummy phase, and that's why there is a division by zero. The 
controller driver does not check if the dummy phase exists (by checking 
op->dummy.nbytes) before performing the calculation. I saw a similar 
patch posted for spi-cadence-quadspi.c [0]. The fix is obvious IMO.

BTW, I think this was introduced by 0e30f47232ab ("mtd: spi-nor: add 
support for DTR protocol"). It set buswidths of non-existent phases to 
0.

The main question is: do we want to keep the buswidth 0 when the dummy 
phase does not exist? It seems to be tripping up controller drivers. 
FWIW, I think we should keep it 0 since I think that when dummy.nbytes 
== 0 the other fields should be "don't care". The responsibility should 
lie on the controller driver to check this.

Thoughts?

[0] https://patchwork.kernel.org/project/spi-devel-general/patch/92eea403-9b21-2488-9cc1-664bee760c5e@nskint.co.jp/

> 
> Thanks,
> ta
> 
> > [    1.075513] Division by zero in kernel.
> > [    1.079354] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.13.7 #18
> > [    1.085376] Hardware name: BCM5301X
> > [    1.088873] [<c0108394>] (unwind_backtrace) from [<c010498c>] (show_stack+0x10/0x14)
> > [    1.096666] [<c010498c>] (show_stack) from [<c0696470>] (dump_stack+0x94/0xa8)
> > [    1.103926] [<c0696470>] (dump_stack) from [<c03e7f94>] (Ldiv0+0x8/0x10)
> > [    1.110653] [<c03e7f94>] (Ldiv0) from [<c0699274>] (bcm_qspi_exec_mem_op+0x3e0/0x744)
> > [    1.118512] [<c0699274>] (bcm_qspi_exec_mem_op) from [<c0698740>] (spi_mem_exec_op+0x184/0x4fc)
> > [    1.127234] [<c0698740>] (spi_mem_exec_op) from [<c0698bac>] (spi_mem_dirmap_read+0xf4/0x1c8)
> > [    1.135780] [<c0698bac>] (spi_mem_dirmap_read) from [<c0697d58>] (spi_nor_spimem_read_data+0x13c/0x1ec)
> > [    1.145199] [<c0697d58>] (spi_nor_spimem_read_data) from [<c0498d60>] (spi_nor_read+0x16c/0x174)
> > [    1.154008] [<c0498d60>] (spi_nor_read) from [<c04835d0>] (mtd_read_oob_std+0x9c/0xa4)
> > [    1.161964] [<c04835d0>] (mtd_read_oob_std) from [<c04855d0>] (mtd_read_oob+0x84/0x148)
> > [    1.169997] [<c04855d0>] (mtd_read_oob) from [<c04856f4>] (mtd_read+0x60/0x90)
> > [    1.177237] [<c04856f4>] (mtd_read) from [<c048ab50>] (bcm47xxpart_parse+0x1d4/0x744)
> > [    1.185089] [<c048ab50>] (bcm47xxpart_parse) from [<c0488568>] (parse_mtd_partitions+0x188/0x424)
> > [    1.193985] [<c0488568>] (parse_mtd_partitions) from [<c0486018>] (mtd_device_parse_register+0x7c/0x1c0)
> > [    1.203489] [<c0486018>] (mtd_device_parse_register) from [<c04998b8>] (spi_nor_probe+0x20c/0x2d0)
> > [    1.212471] [<c04998b8>] (spi_nor_probe) from [<c046fbf8>] (really_probe+0xf0/0x4dc)
> > [    1.220245] [<c046fbf8>] (really_probe) from [<c046dd40>] (bus_for_each_drv+0x80/0xd0)
> > [    1.228184] [<c046dd40>] (bus_for_each_drv) from [<c04701d0>] (__device_attach+0xf8/0x15c)
> > [    1.236468] [<c04701d0>] (__device_attach) from [<c046edd4>] (bus_probe_device+0x84/0x8c)
> > [    1.244668] [<c046edd4>] (bus_probe_device) from [<c046c6c4>] (device_add+0x300/0x840)
> > [    1.252606] [<c046c6c4>] (device_add) from [<c04b3dc4>] (spi_add_device+0x9c/0x164)
> > [    1.260292] [<c04b3dc4>] (spi_add_device) from [<c04b482c>] (spi_register_controller+0x8ac/0xbc0)
> > [    1.269187] [<c04b482c>] (spi_register_controller) from [<c04b7bd4>] (bcm_qspi_probe+0x600/0x700)
> > [    1.278092] [<c04b7bd4>] (bcm_qspi_probe) from [<c0471d3c>] (platform_probe+0x48/0x8c)
> > [    1.286030] [<c0471d3c>] (platform_probe) from [<c046fbf8>] (really_probe+0xf0/0x4dc)
> > [    1.293880] [<c046fbf8>] (really_probe) from [<c04705dc>] (device_driver_attach+0xf0/0x100)
> > [    1.302254] [<c04705dc>] (device_driver_attach) from [<c0470678>] (__driver_attach+0x8c/0x11c)
> > [    1.310888] [<c0470678>] (__driver_attach) from [<c046dc74>] (bus_for_each_dev+0x74/0xc0)
> > [    1.319086] [<c046dc74>] (bus_for_each_dev) from [<c046efc8>] (bus_add_driver+0xf4/0x1dc)
> > [    1.327286] [<c046efc8>] (bus_add_driver) from [<c0470cdc>] (driver_register+0x88/0x118)
> > [    1.335397] [<c0470cdc>] (driver_register) from [<c01016dc>] (do_one_initcall+0x54/0x1d0)
> > [    1.343598] [<c01016dc>] (do_one_initcall) from [<c08010e8>] (kernel_init_freeable+0x244/0x2ac)
> > [    1.352337] [<c08010e8>] (kernel_init_freeable) from [<c069a7c8>] (kernel_init+0x8/0x118)
> > [    1.360536] [<c069a7c8>] (kernel_init) from [<c0100130>] (ret_from_fork+0x14/0x24)
> > [    1.368125] Exception stack(0xc1035fb0 to 0xc1035ff8)
> > [    1.373184] 5fa0:                                     00000000 00000000 00000000 00000000
> > [    1.381384] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> > [    1.389582] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> > 
> > ______________________________________________________
> > Linux MTD discussion mailing list
> > http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
