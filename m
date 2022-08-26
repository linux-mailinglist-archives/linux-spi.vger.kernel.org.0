Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57585A24B3
	for <lists+linux-spi@lfdr.de>; Fri, 26 Aug 2022 11:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245650AbiHZJly (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Aug 2022 05:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245378AbiHZJlx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Aug 2022 05:41:53 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F82D4BCB
        for <linux-spi@vger.kernel.org>; Fri, 26 Aug 2022 02:41:46 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id l8so1271237lfc.12
        for <linux-spi@vger.kernel.org>; Fri, 26 Aug 2022 02:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:organization:message-id:subject:cc
         :to:from:date:from:to:cc;
        bh=unhwDqTjld/jc31jAF8O0bDK9Tbx+Tv8RDGqpEQcxCg=;
        b=DoYE6xkbnjDumNxwk4g468+sR330r87O4HFiea//GfDATyAro75Ml6hrxV6d84TBl5
         eXg9Jwdrrq3pJEjjO3dh5mBCzc7Dy2hfvtIwm7xTYvGj7tnYwgWn4MtW2ZpHj51+A/su
         V3Mpj5JGcDJypZOOTJSAMCH3/fg9ZEPP+kI7JonVNbbt+x57MSdz40l2iapra9KF5f2N
         6JHKcwfTCW/2ArqOCphnNFBpcRWobBu+6YGyn/QUBPW/MycseNPweUa3A4zMwQOquLWy
         rgIqDjPAQjmray3wr0KApzHiiCcHxXhkRHwTdnWUF9Fg8MA3AK4G4lnJF/hrsbYupS1b
         /cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:organization:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc;
        bh=unhwDqTjld/jc31jAF8O0bDK9Tbx+Tv8RDGqpEQcxCg=;
        b=CK7JkKnPDrXmXfjJE74G8rTiZp7lU+dunJNf7UNVjUlo48UrM76CumcG0vV+oTNyUH
         CUK35NNX2HQClJm5tQ9bQh1I8eCZnnlQQXpt5LP/jVTeMnVm4LJaw61s+ebJ4hDenn+d
         nliMXULX1a2lh0m+Vu1b+Goxeo+QkDR/iqAUIQ9cwgNhtUsDKizewFLtviSfbDYSll3g
         RFlhHriGwhKJ/Q9obxNRe8EZiGch/BD6hc+SieTbHv+GMfS03sXMGvYwBkUfdeIrflUl
         bGvXzE2vDpS1usENDnA/1nQ1FAAxJ1VGeNk8IKt/8RtoJjRbZF3nR0mhOHPhg5kiNIvN
         bhnQ==
X-Gm-Message-State: ACgBeo1tWSb4EnkPLnXVEM7pX9TrWV9GR98O8K0b+RQeIbiS6ZD/Cqky
        L/UzTXV2aZBVqYG5h8YOkyk=
X-Google-Smtp-Source: AA6agR7fucDNzgNwdev6y7xfc9HgX4vxrWPwdQRIZLHaCtzm+PKYYQenqlBzt7H5nmAXpI4RaV/nsQ==
X-Received: by 2002:a05:6512:48c:b0:492:eef8:d509 with SMTP id v12-20020a056512048c00b00492eef8d509mr2549931lfq.475.1661506905238;
        Fri, 26 Aug 2022 02:41:45 -0700 (PDT)
Received: from wse-c0155 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id b7-20020a05651c098700b0025dfd2f66d6sm394258ljq.95.2022.08.26.02.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 02:41:44 -0700 (PDT)
Date:   Fri, 26 Aug 2022 11:41:43 +0200
From:   Casper Andersson <casper.casan@gmail.com>
To:     Mark Brown <broonie@kernel.org>, David Jander <david@protonic.nl>
Cc:     linux-spi@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
Organization: Westermo Network Technologies AB
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

I'm having some issues on my SparX5 switch (PCB135) from Microchip.
Since this patch series by David Jander the spi driver errors during boot.
https://lore.kernel.org/all/20220621061234.3626638-1-david@protonic.nl/

ae7d2346dc89 ("spi: Don't use the message queue if possible in spi_sync")
On this commit it starts failing to mount the partitions during boot.
This causes the output marked ERROR 1 below.

69fa95905d40 ("spi: Ensure the io_mutex is held until spi_finalize_current_message()")
On this commit it no longer boots properly. I am able to enter login
info, but then I'm unable to do anything. Though, when running latest
versions of e.g. net and net-next trees it boots sometimes. I have
observed some different errors which seems to occur seemingly at random,
show in ERROR 2-4 below. ERROR 2 and 3 seems to be the most common ones.

ERROR 1:
[    1.333629] Internal error: Oops: 96000044 [#1] PREEMPT SMP
[    1.333636] Modules linked in:
[    1.333644] CPU: 0 PID: 292 Comm: spi0 Not tainted 5.19.0-rc1 #18
[    1.333653] Hardware name: microchip,sparx5 (DT)
[    1.333657] pstate: a0000005 (NzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.333665] pc : ktime_get_real_ts64+0x4c/0x110
[    1.333681] lr : spi_transfer_one_message+0x13c/0x690
[    1.333693] sp : ffff80000aadbce0
[    1.333696] x29: ffff80000aadbce0 x28: 0000000000000000 x27: 00007bff79822ce0
[    1.333709] x26: ffff000004d1f400 x25: ffff000004d1f000 x24: ffff800009d03798
[    1.333720] x23: ffff8000093f3008 x22: 0000006809d03830 x21: 00000000000001c2
[    1.333732] x20: ffff800009a20e80 x19: 0000000000000000 x18: ffffffffffffffff
[    1.333743] x17: 0000000000000002 x16: 000001d25a50f10c x15: 00074f2fcdde90a0
[    1.333754] x14: ffff800008dfb8a0 x13: 000000000000ac08 x12: 00000000f5257d14
[    1.333766] x11: 00000000000002f7 x10: 0000000000000a00 x9 : ffff8000088690bc
[    1.333777] x8 : ffff000005242760 x7 : 0000000000000004 x6 : fffffbffeffcbd28
[    1.333788] x5 : 0000000000000000 x4 : 0000000009a51c00 x3 : 0000000000000000
[    1.333798] x2 : 0000000009a51c00 x1 : 0000000000000000 x0 : 0000000000000001
[    1.333810] Call trace:
[    1.333812]  ktime_get_real_ts64+0x4c/0x110
[    1.333821]  spi_transfer_one_message+0x13c/0x690
[    1.333831]  __spi_pump_transfer_message+0x174/0x550
[    1.333841]  __spi_pump_messages+0xb8/0x330
[    1.333850]  spi_pump_messages+0x24/0x30
[    1.333859]  kthread_worker_fn+0xb8/0x290
[    1.333870]  kthread+0x118/0x120
[    1.333879]  ret_from_fork+0x10/0x20
[    1.333892] Code: 120002b3 370004d5 d50339bf f9403e80 (f90002c0)
[    1.333898] ---[ end trace 0000000000000000 ]---

Error 2:
[    5.527818] Internal error: Oops: 8600000f [#1] PREEMPT SMP
[    5.534020] Modules linked in:
[    5.536959] CPU: 0 PID: 292 Comm: spi0 Not tainted 6.0.0-rc1 #7
[    5.542627] Hardware name: microchip,sparx5 (DT)
[    5.547043] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    5.553704] pc : 0xffff0000042062d8
[    5.557046] lr : spi_finalize_current_message+0x1ac/0x2e0
[    5.562216] sp : ffff80000aa2bc50
[    5.565384] x29: ffff80000aa2bc50 x28: 0000000000000000 x27: 00007bff79858be0
[    5.572217] x26: ffff000007258c20 x25: ffff000007258800 x24: ffff80000cb8b0e0
[    5.579049] x23: ffff80000cb8b1b0 x22: ffff80000cb8b158 x21: ffff000004d1c800
[    5.585881] x20: ffff80000cb8b1b0 x19: ffff80000cb8b1b0 x18: 0000000000000000
[    5.592713] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    5.599544] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[    5.606375] x11: 00000000000001f5 x10: 0000000000000a10 x9 : ffff80000808e890
[    5.613206] x8 : ffff000004966170 x7 : 0000000000000004 x6 : 00000001497a5800
[    5.620037] x5 : 00000000410fd030 x4 : 0000000000c0000e x3 : ffff800076773000
[    5.626869] x2 : 0000000000000000 x1 : ffff0000042062d8 x0 : ffff0000037addb8
[    5.633701] Call trace:
[    5.636040]  0xffff0000042062d8
[    5.639046]  spi_mux_complete_cb+0x48/0x60
[    5.642969]  spi_finalize_current_message+0x1ac/0x2e0
[    5.647803]  spi_transfer_one_message+0x298/0x680
[    5.652304]  __spi_pump_transfer_message+0x188/0x5a0
[    5.657055]  __spi_pump_messages+0xdc/0x330
[    5.661058]  spi_pump_messages+0x24/0x30
[    5.664812]  kthread_worker_fn+0xb8/0x290
[    5.668653]  kthread+0x118/0x120
[    5.671742]  ret_from_fork+0x10/0x20
[    5.675170] Code: 00000000 00000000 08f4b570 ffff8000 (00000000)
[    5.680999] ---[ end trace 0000000000000000 ]---
[    5.678207] note: spi0[291] exited with preempt_count 1

ERROR 3:
[    4.443467] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000108
[    4.443479] Mem abort info:
[    4.443481]   ESR = 0x0000000086000004
[    4.443485]   EC = 0x21: IABT (current EL), IL = 32 bits
[    4.443490]   SET = 0, FnV = 0
[    4.443494]   EA = 0, S1PTW = 0
[    4.443497]   FSC = 0x04: level 0 translation fault
[    4.443502] user pgtable: 4k pages, 48-bit VAs, pgdp=00000007070f2000
[    4.443508] [0000000000000108] pgd=0000000000000000, p4d=0000000000000000
[    4.443520] Internal error: Oops: 86000004 [#1] PREEMPT SMP
[    4.443527] Modules linked in:
[    4.443534] CPU: 0 PID: 292 Comm: spi0 Not tainted 5.19.0-rc1 #25
[    4.443542] Hardware name: microchip,sparx5 (DT)
[    4.443546] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.443555] pc : 0x108
[    4.443564] lr : spi_finalize_current_message+0x1ac/0x2e0
[    4.443578] sp : ffff80000ab03c50
[    4.443581] x29: ffff80000ab03c50 x28: 0000000000000000 x27: 00007bff79822ce0
[    4.443594] x26: ffff0000049c3420 x25: ffff0000049c3000 x24: ffff80000b7733b0
[    4.443607] x23: ffff80000b773480 x22: ffff80000b773428 x21: ffff0000036ac800
[    4.443619] x20: ffff80000b773480 x19: ffff80000b773480 x18: 0000000040bd0097
[    4.443632] x17: 0000000000000004 x16: 0000000000000121 x15: 007c2a66ba4f78c6
[    4.443644] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000002
[    4.443655] x11: 000000000000026b x10: 0000000000000a00 x9 : ffff80000808c94c
[    4.443667] x8 : ffff00000735c460 x7 : 0000000000000001 x6 : 0000000108d9d000
[    4.443679] x5 : 00000000410fd030 x4 : 0000000000c0000e x3 : ffff8000767a9000
[    4.443691] x2 : 0000000000000000 x1 : 0000000000000108 x0 : ffff80000b773750
[    4.443703] Call trace:
[    4.443706]  0x108
[    4.443712]  spi_mux_complete_cb+0x48/0x60
[    4.443720]  spi_finalize_current_message+0x1ac/0x2e0
[    4.443730]  spi_transfer_one_message+0x2b0/0x690
[    4.443739]  __spi_pump_transfer_message+0x188/0x5a0
[    4.443749]  __spi_pump_messages+0xdc/0x330
[    4.443759]  spi_pump_messages+0x24/0x30
[    4.443768]  kthread_worker_fn+0xb8/0x290
[    4.443779]  kthread+0x118/0x120
[    4.443788]  ret_from_fork+0x10/0x20
[    4.443802] Code: bad PC value
[    4.443807] ---[ end trace 0000000000000000 ]---

Error 4:
[    4.012013] Unable to handle kernel execute from non-executable memory at virtual address ffff80000b79b498
[    4.012027] Mem abort info:
[    4.012029]   ESR = 0x000000008600000f
[    4.012033]   EC = 0x21: IABT (current EL), IL = 32 bits
[    4.012038]   SET = 0, FnV = 0
[    4.012042]   EA = 0, S1PTW = 0
[    4.012045]   FSC = 0x0f: level 3 permission fault
[    4.012049] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000007012ec000
[    4.012055] [ffff80000b79b498] pgd=100000077ffff003, p4d=100000077ffff003, pud=100000077fffe003, pmd=10000007036c7003, pte=0068000704f29703
[    4.012077] Internal error: Oops: 8600000f [#1] PREEMPT SMP
[    4.012084] Modules linked in:
[    4.012091] CPU: 0 PID: 292 Comm: spi0 Not tainted 5.19.0-rc1 #25
[    4.012099] Hardware name: microchip,sparx5 (DT)
[    4.012103] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.012112] pc : 0xffff80000b79b498
[    4.012121] lr : 0xffff80000b79b498
[    4.012127] sp : ffff80000ab5bc90
[    4.012130] x29: ffff0000042ea800 x28: 0000000000000000 x27: 00007bff79822ce0
[    4.012143] x26: ffff0000042eac20 x25: ffff0000042ea800 x24: ffff80000b79b420
[    4.012155] x23: ffff80000b79b4f0 x22: ffff80000b79b498 x21: ffff000004c35800
[    4.012168] x20: ffff80000b79b4f0 x19: ffff80000b79b4f0 x18: 0000000000000000
[    4.012180] x17: 0000000000000001 x16: 0000000000000001 x15: 0117d93fc9cfcb72
[    4.012192] x14: 0114def7e22c5168 x13: ffff800008dfb8a0 x12: 00000000fa83b2da
[    4.012204] x11: 0000000000000077 x10: 000000000000008a x9 : ffff8000080b2724
[    4.012216] x8 : 0000000000000000 x7 : 0000000000000001 x6 : 0000000000000096
[    4.012227] x5 : 0000000000000000 x4 : ffff00007fbacd80 x3 : ffff000004dec880
[    4.012239] x2 : 0000000000000000 x1 : ffff000004dec880 x0 : 0000000000000000
[    4.012251] Call trace:
[    4.012254]  0xffff80000b79b498
[    4.012265] Code: 04dfc880 ffff0000 0b79b4b0 ffff8000 (08dd5984)
[    4.012271] ---[ end trace 0000000000000000 ]---
