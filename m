Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A54BC1167A5
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 08:43:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLIHnN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 02:43:13 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:19418 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbfLIHnN (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 02:43:13 -0500
Received: from localhost (mailhub1-ext [192.168.12.233])
        by localhost (Postfix) with ESMTP id 47WZtM2Lbjz9txbc;
        Mon,  9 Dec 2019 08:43:07 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=H0WxoXel; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XHi-1B9g5zEx; Mon,  9 Dec 2019 08:43:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 47WZtM1JtWz9txbb;
        Mon,  9 Dec 2019 08:43:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1575877387; bh=Y/U88WJLNVaZQ0g+x2F9rdfo/+YMGllZ5DkbndRF/1Y=;
        h=To:Cc:From:Subject:Date:From;
        b=H0WxoXelHj726GcpHsp2l8dpRRD4WaaZ7nmHmPyUA957bYaBoHnGvnUQpJtU9E23D
         pgig2l/8IxG0iQUD7PB9uQFAGhc2xPgw1DlMphjqYhNvGEl3Qp3OBEIqBGCZ+cDRYp
         kJDwpO2jm3UsYpd7yUqh2yvgjkWP+4r9PA0TT7dU=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B33E68B755;
        Mon,  9 Dec 2019 08:43:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JQXXvHZdkDvp; Mon,  9 Dec 2019 08:43:11 +0100 (CET)
Received: from [172.25.230.100] (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 859B38B7B1;
        Mon,  9 Dec 2019 08:43:11 +0100 (CET)
To:     Liu Xiang <liu.xiang6@zte.com.cn>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi <linux-spi@vger.kernel.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: WARNING: remove_proc_entry: removing non-empty directory 'irq/22',
 leaking at least 'fsl_spi' [bisected to 500a32abaf81 ("spi: fsl: Call
 irq_dispose_mapping in err path")]
Message-ID: <1769abd0-f0e5-83a8-1bf2-b264f7a2a679@c-s.fr>
Date:   Mon, 9 Dec 2019 08:43:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Liu,

While booting latest kernel on by 83xx board, I get the following WARNING.
Reverting your commit 500a32abaf81 ("spi: fsl: Call irq_dispose_mapping 
in err path") removes the warning.

I think that's because irq_dispose_mapping() is called too early, before 
devm frees the irq registered with devm_request_irq() in fsl_spi_probe()

[    1.510229] ------------[ cut here ]------------
[    1.514845] remove_proc_entry: removing non-empty directory 'irq/22', 
leaking at least 'fsl_spi'
[    1.523852] WARNING: CPU: 0 PID: 1 at fs/proc/generic.c:682 
remove_proc_entry+0x198/0x1c0
[    1.532021] CPU: 0 PID: 1 Comm: swapper Not tainted 
5.4.0-02248-g93532430a4ff-dirty #2559
[    1.540860] NIP:  c0197694 LR: c0197694 CTR: c0050d80
[    1.545898] REGS: df4a5af0 TRAP: 0700   Not tainted 
(5.4.0-s3k-dev-02248-g93532430a4ff-dirty)
[    1.554472] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22028222  XER: 00000000
[    1.561178]
[    1.561178] GPR00: c0197694 df4a5ba8 df4a0000 00000054 00000000 
00000000 00004a38 00000010
[    1.561178] GPR08: c07c5a30 00000800 00000000 00001032 22000208 
00000000 c0004b14 00000000
[    1.561178] GPR16: 00000000 00000000 00000000 00000000 00000000 
00000000 c0830000 c07fc078
[    1.561178] GPR24: c08e8ca0 df663d10 fffffdfb c07c9db8 00000001 
df621ae3 df621a80 df43f8e3
[    1.595982] NIP [c0197694] remove_proc_entry+0x198/0x1c0
[    1.601283] LR [c0197694] remove_proc_entry+0x198/0x1c0
[    1.606484] Call Trace:
[    1.608935] [df4a5ba8] [c0197694] remove_proc_entry+0x198/0x1c0 
(unreliable)
[    1.615977] [df4a5bd8] [c0067acc] unregister_irq_proc+0x5c/0x70
[    1.621896] [df4a5bf8] [c005fbc4] free_desc+0x3c/0x80
[    1.626944] [df4a5c18] [c005fe2c] irq_free_descs+0x70/0xa8
[    1.632437] [df4a5c38] [c033d3fc] of_fsl_spi_probe+0xdc/0x3d0
[    1.638184] [df4a5c88] [c02f0f64] platform_drv_probe+0x44/0xa4
[    1.644009] [df4a5c98] [c02eee44] really_probe+0x1ac/0x418
[    1.649489] [df4a5cc8] [c02ed3e8] bus_for_each_drv+0x64/0xb0
[    1.655141] [df4a5cf8] [c02ef950] __device_attach+0xd4/0x128
[    1.660793] [df4a5d28] [c02ed61c] bus_probe_device+0xa0/0xbc
[    1.666443] [df4a5d48] [c02ebbe8] device_add+0x544/0x74c
[    1.671756] [df4a5d88] [c0382b7c] 
of_platform_device_create_pdata+0xa4/0x100
[    1.678791] [df4a5da8] [c0382cf8] of_platform_bus_create+0x120/0x20c
[    1.685135] [df4a5df8] [c0382d54] of_platform_bus_create+0x17c/0x20c
[    1.691479] [df4a5e48] [c0382e8c] of_platform_bus_probe+0x9c/0xf0
[    1.697568] [df4a5e68] [c0751404] 
__machine_initcall_cmpcpro_cmpcpro_declare_of_platform_devices+0x74/0x1a4
[    1.707290] [df4a5e98] [c072a4cc] do_one_initcall+0x8c/0x1d4
[    1.712944] [df4a5ef8] [c072a768] kernel_init_freeable+0x154/0x204
[    1.719118] [df4a5f28] [c0004b2c] kernel_init+0x18/0x110
[    1.724432] [df4a5f38] [c00122ac] ret_from_kernel_thread+0x14/0x1c
[    1.730590] Instruction dump:
[    1.733553] 2c030000 4182004c 3863ffb0 3c80c05f 80e3005c 388436a0 
3c60c06d 7fa6eb78
[    1.741295] 7fe5fb78 38840280 3863417c 4be8c611 <0fe00000> 4bffff6c 
3c60c071 7fe4fb78
[    1.749222] ---[ end trace a98e3613df89cf38 ]---

Christophe
