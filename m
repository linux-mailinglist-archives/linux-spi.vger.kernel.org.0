Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8757FCBA91
	for <lists+linux-spi@lfdr.de>; Fri,  4 Oct 2019 14:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfJDMgv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 4 Oct 2019 08:36:51 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54984 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728663AbfJDMgv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 4 Oct 2019 08:36:51 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x94CVOIe004226;
        Fri, 4 Oct 2019 14:36:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=9oA5AaxTGlvSCA+7kZhQxAjTz3xyBtquAeFvHIm8KXc=;
 b=lPZEwKmWqL0/3sPobA7eCwmlggVdc4mJ//JQIIHjMQK7A+KY/9s63aLyUBP0eT92e58Q
 wu+17Fw1miP4WeIKbKf1gyI/PVFy1i86aDnm8zsEugorFln895ATpMPgw8fGXET4qG4/
 C/I/eqAgF8tPn2TCIpOKoeTie6iqKWEtt1X/WrWtzXDR6Chlm3diZPDrU4kRB1UflV8J
 +8trZZgK4mBsm9AD0C9cy0W/S8cCYwkh0fqvnIGLVzRvrZ0fAQgLKGLXchoU8h3eWM0+
 +uywHBfdbwmS1vFbGicNfu2gpkstYcv+om57115Iu27Eb954Ry4nsyMDT6WXa+XFwck6 ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2v9xdham10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Oct 2019 14:36:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BF69810002A;
        Fri,  4 Oct 2019 14:36:37 +0200 (CEST)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B18A02BE246;
        Fri,  4 Oct 2019 14:36:37 +0200 (CEST)
Received: from SAFEX1HUBCAS23.st.com (10.75.90.46) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019
 14:36:37 +0200
Received: from localhost (10.201.23.73) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 4 Oct 2019 14:36:36
 +0200
From:   <patrice.chotard@st.com>
To:     Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <mcoquelin.stm32@gmail.com>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        <stable@vger.kernel.org>
Subject: spi: stm32-qspi: Fix kernel oops when unbinding driver
Date:   Fri, 4 Oct 2019 14:36:06 +0200
Message-ID: <20191004123606.17241-1-patrice.chotard@st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.73]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-04_06:2019-10-03,2019-10-04 signatures=0
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

spi_master_put() must only be called in .probe() in case of error.

As devm_spi_register_master() is used during probe, spi_master_put()
mustn't be called in .remove() callback.

It fixes the following kernel WARNING/Oops when executing
echo "58003000.spi" > /sys/bus/platform/drivers/stm32-qspi/unbind :

------------[ cut here ]------------
WARNING: CPU: 1 PID: 496 at fs/kernfs/dir.c:1504 kernfs_remove_by_name_ns+0x9c/0xa4
kernfs: can not remove 'uevent', no directory
Modules linked in:
CPU: 1 PID: 496 Comm: sh Not tainted 5.3.0-rc1-00219-ga0e07bb51a37 #62
Hardware name: STM32 (Device Tree Support)
[<c0111570>] (unwind_backtrace) from [<c010d384>] (show_stack+0x10/0x14)
[<c010d384>] (show_stack) from [<c08db558>] (dump_stack+0xb4/0xc8)
[<c08db558>] (dump_stack) from [<c01209d8>] (__warn.part.3+0xbc/0xd8)
[<c01209d8>] (__warn.part.3) from [<c0120a5c>] (warn_slowpath_fmt+0x68/0x8c)
[<c0120a5c>] (warn_slowpath_fmt) from [<c02e5844>] (kernfs_remove_by_name_ns+0x9c/0xa4)
[<c02e5844>] (kernfs_remove_by_name_ns) from [<c05833a4>] (device_del+0x128/0x358)
[<c05833a4>] (device_del) from [<c05835f8>] (device_unregister+0x24/0x64)
[<c05835f8>] (device_unregister) from [<c0638dac>] (spi_unregister_controller+0x88/0xe8)
[<c0638dac>] (spi_unregister_controller) from [<c058c580>] (release_nodes+0x1bc/0x200)
[<c058c580>] (release_nodes) from [<c0588a44>] (device_release_driver_internal+0xec/0x1ac)
[<c0588a44>] (device_release_driver_internal) from [<c0586840>] (unbind_store+0x60/0xd4)
[<c0586840>] (unbind_store) from [<c02e64e8>] (kernfs_fop_write+0xe8/0x1c4)
[<c02e64e8>] (kernfs_fop_write) from [<c0266b44>] (__vfs_write+0x2c/0x1c0)
[<c0266b44>] (__vfs_write) from [<c02694c0>] (vfs_write+0xa4/0x184)
[<c02694c0>] (vfs_write) from [<c0269710>] (ksys_write+0x58/0xd0)
[<c0269710>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xdd289fa8 to 0xdd289ff0)
9fa0:                   0000006c 000e20e8 00000001 000e20e8 0000000d 00000000
9fc0: 0000006c 000e20e8 b6f87da0 00000004 0000000d 0000000d 00000000 00000000
9fe0: 00000004 bee639b0 b6f2286b b6eaf6c6
---[ end trace 1b15df8a02d76aef ]---
------------[ cut here ]------------
WARNING: CPU: 1 PID: 496 at fs/kernfs/dir.c:1504 kernfs_remove_by_name_ns+0x9c/0xa4
kernfs: can not remove 'online', no directory
Modules linked in:
CPU: 1 PID: 496 Comm: sh Tainted: G        W         5.3.0-rc1-00219-ga0e07bb51a37 #62
Hardware name: STM32 (Device Tree Support)
[<c0111570>] (unwind_backtrace) from [<c010d384>] (show_stack+0x10/0x14)
[<c010d384>] (show_stack) from [<c08db558>] (dump_stack+0xb4/0xc8)
[<c08db558>] (dump_stack) from [<c01209d8>] (__warn.part.3+0xbc/0xd8)
[<c01209d8>] (__warn.part.3) from [<c0120a5c>] (warn_slowpath_fmt+0x68/0x8c)
[<c0120a5c>] (warn_slowpath_fmt) from [<c02e5844>] (kernfs_remove_by_name_ns+0x9c/0xa4)
[<c02e5844>] (kernfs_remove_by_name_ns) from [<c0582488>] (device_remove_attrs+0x20/0x5c)
[<c0582488>] (device_remove_attrs) from [<c05833b0>] (device_del+0x134/0x358)
[<c05833b0>] (device_del) from [<c05835f8>] (device_unregister+0x24/0x64)
[<c05835f8>] (device_unregister) from [<c0638dac>] (spi_unregister_controller+0x88/0xe8)
[<c0638dac>] (spi_unregister_controller) from [<c058c580>] (release_nodes+0x1bc/0x200)
[<c058c580>] (release_nodes) from [<c0588a44>] (device_release_driver_internal+0xec/0x1ac)
[<c0588a44>] (device_release_driver_internal) from [<c0586840>] (unbind_store+0x60/0xd4)
[<c0586840>] (unbind_store) from [<c02e64e8>] (kernfs_fop_write+0xe8/0x1c4)
[<c02e64e8>] (kernfs_fop_write) from [<c0266b44>] (__vfs_write+0x2c/0x1c0)
[<c0266b44>] (__vfs_write) from [<c02694c0>] (vfs_write+0xa4/0x184)
[<c02694c0>] (vfs_write) from [<c0269710>] (ksys_write+0x58/0xd0)
[<c0269710>] (ksys_write) from [<c0101000>] (ret_fast_syscall+0x0/0x54)
Exception stack(0xdd289fa8 to 0xdd289ff0)
9fa0:                   0000006c 000e20e8 00000001 000e20e8 0000000d 00000000
9fc0: 0000006c 000e20e8 b6f87da0 00000004 0000000d 0000000d 00000000 00000000
9fe0: 00000004 bee639b0 b6f2286b b6eaf6c6
---[ end trace 1b15df8a02d76af0 ]---
8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000050
pgd = e612f14d
[00000050] *pgd=ff1f5835
Internal error: Oops: 17 [#1] SMP ARM
Modules linked in:
CPU: 1 PID: 496 Comm: sh Tainted: G        W         5.3.0-rc1-00219-ga0e07bb51a37 #62
Hardware name: STM32 (Device Tree Support)
PC is at kernfs_find_ns+0x8/0xfc
LR is at kernfs_find_and_get_ns+0x30/0x48
pc : [<c02e49a4>]    lr : [<c02e4ac8>]    psr: 40010013
sp : dd289dac  ip : 00000000  fp : 00000000
r10: 00000000  r9 : def6ec58  r8 : dd289e54
r7 : 00000000  r6 : c0abb234  r5 : 00000000  r4 : c0d26a30
r3 : ddab5080  r2 : 00000000  r1 : c0abb234  r0 : 00000000
Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: dd11c06a  DAC: 00000051
Process sh (pid: 496, stack limit = 0xe13a592d)
Stack: (0xdd289dac to 0xdd28a000)
9da0:                            c0d26a30 00000000 c0abb234 00000000 c02e4ac8
9dc0: 00000000 c0976b44 def6ec00 dea53810 dd289e54 c02e864c c0a61a48 c0a4a5ec
9de0: c0d630a8 def6ec00 c0d04c48 c02e86e0 def6ec00 de909338 c0d04c48 c05833b0
9e00: 00000000 c0638144 dd289e54 def59900 00000000 475b3ee5 def6ec00 00000000
9e20: def6ec00 def59b80 dd289e54 def59900 00000000 c05835f8 def6ec00 c0638dac
9e40: 0000000a dea53810 c0d04c48 c058c580 dea53810 def59500 def59b80 475b3ee5
9e60: ddc63e00 dea53810 dea3fe10 c0d63a0c dea53810 ddc63e00 dd289f78 dd240d10
9e80: 00000000 c0588a44 c0d59a20 0000000d c0d63a0c c0586840 0000000d dd240d00
9ea0: 00000000 00000000 ddc63e00 c02e64e8 00000000 00000000 c0d04c48 dd9bbcc0
9ec0: c02e6400 dd289f78 00000000 000e20e8 0000000d c0266b44 00000055 00000cc0
9ee0: 000000e3 000e3000 dd11c000 dd11c000 00000000 00000000 00000000 00000000
9f00: ffeee38c dff99688 00000000 475b3ee5 00000001 dd289fb0 ddab5080 ddaa5800
9f20: 00000817 000e30ec dd9e7720 475b3ee5 ddaa583c 0000000d dd9bbcc0 000e20e8
9f40: dd289f78 00000000 000e20e8 0000000d 00000000 c02694c0 00000000 00000000
9f60: c0d04c48 dd9bbcc0 00000000 00000000 dd9bbcc0 c0269710 00000000 00000000
9f80: 000a91f4 475b3ee5 0000006c 000e20e8 b6f87da0 00000004 c0101204 dd288000
9fa0: 00000004 c0101000 0000006c 000e20e8 00000001 000e20e8 0000000d 00000000
9fc0: 0000006c 000e20e8 b6f87da0 00000004 0000000d 0000000d 00000000 00000000
9fe0: 00000004 bee639b0 b6f2286b b6eaf6c6 600e0030 00000001 00000000 00000000
[<c02e49a4>] (kernfs_find_ns) from [<def6ec00>] (0xdef6ec00)
Code: ebf8eeab c0dc50b8 e92d40f0 e292c000 (e1d035b0)
---[ end trace 1b15df8a02d76af1 ]---

Fixes: a88eceb17ac7 ("spi: stm32-qspi: add spi_master_put in release function")
Cc: <stable@vger.kernel.org>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 9ac6f9fe13cf..4e726929bb4f 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -528,7 +528,6 @@ static void stm32_qspi_release(struct stm32_qspi *qspi)
 	stm32_qspi_dma_free(qspi);
 	mutex_destroy(&qspi->lock);
 	clk_disable_unprepare(qspi->clk);
-	spi_master_put(qspi->ctrl);
 }
 
 static int stm32_qspi_probe(struct platform_device *pdev)
@@ -626,6 +625,8 @@ static int stm32_qspi_probe(struct platform_device *pdev)
 
 err:
 	stm32_qspi_release(qspi);
+	spi_master_put(qspi->ctrl);
+
 	return ret;
 }
 
-- 
2.17.1

