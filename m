Return-Path: <linux-spi+bounces-6365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA58A13C04
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 15:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C510188CE68
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jan 2025 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6994C22A7F1;
	Thu, 16 Jan 2025 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYW32PCN"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388D01DE2B9;
	Thu, 16 Jan 2025 14:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737037291; cv=none; b=NUQtzooocyywAnVlUweOMIcKPpRAgM2qFn+R2c53unV5dRWtzP5v9bAUaQlO6zns7gvEZXYYrSo00ivG4/BF8ig1ID9Z38TepKeNS5KY0EvJmhPbDpsL4MU0xS+pHJpw0D3rnrNODjigdpg+FXqXnIvgRBgl1WBW0mZssvtlzFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737037291; c=relaxed/simple;
	bh=dwaSp5xMRzHktOe682J3LGPLEcV0xhRUzeSBvEX8Mew=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Mo+IBlFQTZ7IoCvyesVlq87lLcIITVxvZFT+HPkTyRmm3yeZ/TOdJ94Ba3SaBORQqY8p2CXuJS32YxBSDR8i9dA3+sTU0d/2IaaiTCHF3NC7xm4TRojhrDI7+VYjLa9pJCNdO4BMa9M48C4TTsErEY2ra6HSCjFHQLNEVwHM6DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYW32PCN; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaeec07b705so192560566b.2;
        Thu, 16 Jan 2025 06:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737037285; x=1737642085; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QmeOLrN3HjD73FIb8e2i1EvlrIVIEl/1nyBa+LHcTNY=;
        b=HYW32PCNREvX3GqPv0LaVRU9P3xcLuNek7RXyS9/HdHAYqqSYF6s9uog+daRy4B/t1
         5Ujw00Y8eT2CYtIF3Xpp+jZp6rzaomdSUxZTp7XK4ofnKtO3RhNwZSBm9XvnI0Bfpcyu
         vpzYm/upZLXa8yjx881IDnPD0lyspO5rtv5CxA0CwuQM+aJNb5yAoHtnxtJv3rtZnrQS
         eFfmc8cOa/GDsx30llsHQMPfxC3c2EslyMRjj9z4N4YOolFeq/evbESoMjNkYHSvnToY
         HltsewMaeosHxr0xwPV5MhlzsgJawOC7979VhnJl/J/xYFh5A22PdXNymr9AFSYHCWhy
         HX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737037285; x=1737642085;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmeOLrN3HjD73FIb8e2i1EvlrIVIEl/1nyBa+LHcTNY=;
        b=XS4jsZbYSMGHvIeOfYPPF/G+rklbHJ7foeugI+b19G9l/70HMvVp6OysXF+uK1uLeL
         Tkopp16Vr4umV2clj4UapJ1+flzI1oW0keWcXxLJIiUSdgJOicz5Rwj5kpHUAcFCE1JO
         Zt3/NixcH1s2ze30vTwRWHm8y3YU4yd+Yi4WpIqVD/EnmIAxxZWOkKgJIWZjJwFMrbqj
         ufWkupi4oy2FNCu1bo+ZV9blCW4Q+geNzu8XFXwLtoO+W1WDWDRarZa5uK0lTidfouJS
         8lvrbzpKzZno6023sDtxGEFjDI5RemAYaGszq7C4trl7PJfRo7cPr1jf4z3uRyjlkLIO
         yYTw==
X-Forwarded-Encrypted: i=1; AJvYcCVn8o6xM7C1U2/mokWK+rW6mensZWmLSwaomQD5D6RPoTpX28/b48oRvPc1m/SlRAJJ/4Juz38ftCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdCme1PEJ0PAGrVYQm6hL8jHuO/lbCHORUwGFAh1+beGKN5IEt
	OrZ0KsHmNIBrCKF/5VUNzEc08myM9rpiFcnjJpjCHYccbFCwKmVJO2L/e98EnPwQoZOu4GnrH50
	jabaTuq/jMnWEigey16BfOSPLRh6hODfk
X-Gm-Gg: ASbGnctdQUr0ThSFGpNFGMpqqECApD7qxB5B3YDXOjFoMya9BLwhUppOWt3WbYbuJ4S
	CfRIGlxLYn4lzswPq06xR8xO9PceYLJrSN66dgQ==
X-Google-Smtp-Source: AGHT+IErJNq6LjOq1QVjak6xidjAVOxzehQ1LA2FQcXYy5NUu+JCa3SmraGguVPI51P2ajvlR679uv4oRBsn396n2hE=
X-Received: by 2002:a17:907:9711:b0:aa6:1e9a:e45a with SMTP id
 a640c23a62f3a-ab2abdc368emr2835635566b.46.1737037285083; Thu, 16 Jan 2025
 06:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lars Pedersen <lapeddk@gmail.com>
Date: Thu, 16 Jan 2025 15:21:13 +0100
X-Gm-Features: AbW1kvYa-f6ncelJyoAvjidcP8g8LNYVNbsLP4Gske-5mxUKYMHiiW9BfZOnumw
Message-ID: <CAKd8=GsoKj5eG6VAMkrxMbzNyoBX=JiwafrfXman8xMNK+XU_w@mail.gmail.com>
Subject: SPI regression seen on ARM am335x in kernel 6.12.8 and 6.6.71
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, broonie@kernel.org, linux-spi@vger.kernel.org, 
	psiddaiah@mvista.com
Content-Type: text/plain; charset="UTF-8"

Hi. We have discovered an SPI regression when upgrading from 6.1.99 to
a newer LTS version. Same error on kernel 6.6.71 and 6.12.8.

I think we have identified the problem down to the reference clock
calculation that seems to end up to zero in the spi-omap2-mcspi
driver.

Also we think it relates to commit
4c6ac5446d060f0bf435ccc8bc3aa7b7b5f718ad, where OMAP2_MCSPI_MAX_FREQ
is used as fallback on error. In our case it seems to hit the else
case.

Snippets for device tree, spi-omap2-mcspi driver and kernel divide by
zero error log with dynamic debug enabled.

/Lars Pedersen

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 67441b2cd603..8fedfc7db1fa 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1559,12 +1559,13 @@ static int omap2_mcspi_probe(struct
platform_device *pdev)
                dev_err(&pdev->dev, "Cannot request IRQ");
                goto free_ctlr;
        }
-
+       dev_dbg(&pdev->dev, "DEBUG_EXTRA pre calc\n");
        mcspi->ref_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
        if (IS_ERR(mcspi->ref_clk))
                mcspi->ref_clk_hz = OMAP2_MCSPI_MAX_FREQ;
        else
                mcspi->ref_clk_hz = clk_get_rate(mcspi->ref_clk);
+       dev_dbg(&pdev->dev, "DEBUG_EXTRA: ref_clk_hz %d\n", mcspi->ref_clk_hz);
        ctlr->max_speed_hz = mcspi->ref_clk_hz;
        ctlr->min_speed_hz = mcspi->ref_clk_hz >> 15;

---8<---
/dts-v1/;

#include "am33xx.dtsi"
#include <dt-bindings/interrupt-controller/irq.h>
...

&spi0 {
status = "okay";
pinctrl-names = "default";
pinctrl-0 = <&spi0_pins_default>;
ti,spi-num-cs = <1>;

flash@0 {
compatible = "jedec,spi-nor";
reg = <0>;
spi-tx-bus-width = <1>;
spi-rx-bus-width = <1>;
spi-max-frequency = <10000000>;

partitions {
compatible = "fixed-partitions";
#address-cells = <1>;
#size-cells = <1>;
partition@0 {
reg = <0x0 0x1f00000>;
label = "radio-program";
};
partition@1f00000 {
reg = <0x1f00000 0xe0000>;
label = "linux-data";
read-only;
};
partition@1fe0000 {
reg = <0x1fe0000 0x10000>;
label = "radio-config";
read-only;
};
partition@1ff0000 {
reg = <0x1ff0000 0x10000>;
label = "baseband-config";
read-only;
};
};
};
};

---8<---
Jan 16 11:30:53 ptxdist kernel: omap2_mcspi 48030000.spi: DEBUG_EXTRA pre calc
Jan 16 11:30:54 ptxdist kernel: omap2_mcspi 48030000.spi: DEBUG_EXTRA:
ref_clk_hz 0
Jan 16 11:30:54 ptxdist kernel: omap2_mcspi 48030000.spi: registered host spi0
Jan 16 11:30:54 ptxdist kernel: Division by zero in kernel.
Jan 16 11:30:54 ptxdist kernel: CPU: 0 UID: 0 PID: 161 Comm:
(udev-worker) Not tainted 6.12.8 #1
Jan 16 11:30:54 ptxdist kernel: Hardware name: Generic AM33XX
(Flattened Device Tree)
Jan 16 11:30:54 ptxdist kernel: Call trace:
Jan 16 11:30:54 ptxdist kernel:  dump_backtrace from show_stack+0x20/0x38
Jan 16 11:30:54 ptxdist kernel:  r7:c4a7ff00 r6:c0cef6bc r5:00000000 r4:600f0113
Jan 16 11:30:54 ptxdist kernel:  show_stack from dump_stack_lvl+0x40/0x78
Jan 16 11:30:54 ptxdist kernel:  dump_stack_lvl from dump_stack+0x18/0x28
Jan 16 11:30:54 ptxdist kernel:  r7:c4a7ff00 r6:00000008 r5:c477dbc0 r4:c4a7ec00
Jan 16 11:30:54 ptxdist kernel:  dump_stack from __div0+0x24/0x34
Jan 16 11:30:54 ptxdist kernel:  __div0 from Ldiv0+0x8/0x10
Jan 16 11:30:54 ptxdist kernel:  omap2_mcspi_setup_transfer
[spi_omap2_mcspi] from omap2_mcspi_setup+0x134/0x20c [spi_omap2_mcspi]
Jan 16 11:30:54 ptxdist kernel:  r9:c4a7ff28 r8:c477dbd0 r7:c4a7ff00
r6:c4a7ec00 r5:c2572c10 r4:00000001
Jan 16 11:30:54 ptxdist kernel:  omap2_mcspi_setup [spi_omap2_mcspi]
from spi_setup+0x124/0x4f8
Jan 16 11:30:54 ptxdist kernel:  r9:c4a7edaf r8:00000000 r7:c2572c10
r6:c4a7fc00 r5:00000000 r4:c4a7ec00
Jan 16 11:30:54 ptxdist kernel:  spi_setup from __spi_add_device+0x15c/0x300
Jan 16 11:30:54 ptxdist kernel:  r6:c4a7fc00 r5:c4a7ec00 r4:c4a7ed9f
Jan 16 11:30:54 ptxdist kernel:  __spi_add_device from
of_register_spi_devices+0x74/0x1a8
Jan 16 11:30:54 ptxdist kernel:  r10:c0fe67cc r9:c4a7fd98 r8:c4a7fdd4
r7:c4a7ec00 r6:c4a7fc00 r5:00000000
Jan 16 11:30:54 ptxdist kernel:  r4:cfce0df4
Jan 16 11:30:54 ptxdist kernel:  of_register_spi_devices from
spi_register_controller+0x3d0/0x4d0
Jan 16 11:30:54 ptxdist kernel:  r9:c4a7fd98 r8:c0fe67d4 r7:c4a7fda0
r6:00000000 r5:c0fe67d4 r4:c4a7fc00
Jan 16 11:30:54 ptxdist kernel:  spi_register_controller from
devm_spi_register_controller+0x54/0xbc
Jan 16 11:30:54 ptxdist kernel:  r10:bf006108 r9:c2572c10 r8:c4a7fc00
r7:c2572c10 r6:c4a7fc00 r5:c4a7ff00
Jan 16 11:30:54 ptxdist kernel:  r4:c46cd2c0
Jan 16 11:30:54 ptxdist kernel:  devm_spi_register_controller from
omap2_mcspi_probe+0x51c/0x5cc [spi_omap2_mcspi]
Jan 16 11:30:54 ptxdist kernel:  r7:c4a7fc00 r6:c2572c10 r5:c4a7ff00 r4:c2572c10
Jan 16 11:30:54 ptxdist kernel:  omap2_mcspi_probe [spi_omap2_mcspi]
from platform_probe+0x6c/0xd0
Jan 16 11:30:54 ptxdist kernel:  r10:d0481ed0 r9:00000001 r8:00000000
r7:c1028ef8 r6:bf004014 r5:c2572c10
Jan 16 11:30:54 ptxdist kernel:  r4:00000000
Jan 16 11:30:54 ptxdist kernel:  platform_probe from really_probe+0xf0/0x3ec
Jan 16 11:30:54 ptxdist kernel:  r7:c1028ef8 r6:bf004014 r5:00000000 r4:c2572c10
Jan 16 11:30:54 ptxdist kernel:  really_probe from
__driver_probe_device+0xac/0x13c
Jan 16 11:30:54 ptxdist kernel:  r8:c27a50b4 r7:0000007d r6:c2572c10
r5:bf004014 r4:c2572c10
Jan 16 11:30:54 ptxdist kernel:  __driver_probe_device from
driver_probe_device+0x40/0xe4
Jan 16 11:30:54 ptxdist kernel:  r5:bf004014 r4:c1071d9c
Jan 16 11:30:54 ptxdist kernel:  driver_probe_device from
__driver_attach+0x154/0x204
Jan 16 11:30:54 ptxdist kernel:  r7:00000000 r6:c2572c54 r5:bf004014 r4:c2572c10
Jan 16 11:30:54 ptxdist kernel:  __driver_attach from bus_for_each_dev+0x8c/0xf0
Jan 16 11:30:54 ptxdist kernel:  r7:00000000 r6:c20e96c0 r5:c06404ec r4:bf004014
Jan 16 11:30:54 ptxdist kernel:  bus_for_each_dev from driver_attach+0x2c/0x44
Jan 16 11:30:54 ptxdist kernel:  r7:c20e96c0 r6:00000000 r5:c27a5080 r4:bf004014
Jan 16 11:30:54 ptxdist kernel:  driver_attach from bus_add_driver+0x104/0x244
Jan 16 11:30:54 ptxdist kernel:  bus_add_driver from driver_register+0x8c/0x164
Jan 16 11:30:54 ptxdist kernel:  r8:00000000 r7:bf004100 r6:c101f840
r5:a7ac7714 r4:bf004014
Jan 16 11:30:54 ptxdist kernel:  driver_register from
__platform_driver_register+0x2c/0x40
Jan 16 11:30:54 ptxdist kernel:  r5:a7ac7714 r4:c0fac2fc
Jan 16 11:30:54 ptxdist kernel:  __platform_driver_register from
omap2_mcspi_driver_init+0x38/0x1000 [spi_omap2_mcspi]
Jan 16 11:30:54 ptxdist kernel:  omap2_mcspi_driver_init
[spi_omap2_mcspi] from do_one_initcall+0x68/0x2b8
Jan 16 11:30:54 ptxdist kernel:  r5:c2a95800 r4:bf008000
Jan 16 11:30:54 ptxdist kernel:  do_one_initcall from do_init_module+0x64/0x218
Jan 16 11:30:54 ptxdist kernel:  r8:bf004100 r7:bf004100 r6:c477d240
r5:00000000 r4:bf004100
Jan 16 11:30:54 ptxdist kernel:  do_init_module from load_module+0x7e4/0xa18
Jan 16 11:30:54 ptxdist kernel:  r6:00000000 r5:00000000 r4:00000000
Jan 16 11:30:54 ptxdist kernel:  load_module from
init_module_from_file+0xa4/0xec
Jan 16 11:30:54 ptxdist kernel:  r10:c477c080 r9:c1054a48 r8:c477c080
r7:c1054a38 r6:b5b1d7f0 r5:c477c080
Jan 16 11:30:54 ptxdist kernel:  r4:00000000
Jan 16 11:30:54 ptxdist kernel:  init_module_from_file from
sys_finit_module+0x244/0x39c
Jan 16 11:30:54 ptxdist kernel:  r6:00000001 r5:000000f4 r4:c2a95800
Jan 16 11:30:54 ptxdist kernel:  sys_finit_module from
__sys_trace_return+0x0/0x10
Jan 16 11:30:54 ptxdist kernel: Exception stack(0xd0481fa8 to 0xd0481ff0)
Jan 16 11:30:54 ptxdist kernel: 1fa0:                   14cb6a00
00000000 0000001a b5b1d7f0 00000000 00000000
Jan 16 11:30:54 ptxdist kernel: 1fc0: 14cb6a00 00000000 00826358
0000017b 008456d0 b6f75934 b5b1739d 00000000
Jan 16 11:30:54 ptxdist kernel: 1fe0: bee9d538 bee9d528 b5b16643 b6c5d262
Jan 16 11:30:54 ptxdist kernel:  r10:0000017b r9:c2a95800 r8:c01002c4
r7:0000017b r6:00826358 r5:00000000
Jan 16 11:30:54 ptxdist kernel:  r4:14cb6a00
Jan 16 11:30:54 ptxdist kernel: Division by zero in kernel.
Jan 16 11:30:54 ptxdist kernel: CPU: 0 UID: 0 PID: 161 Comm:
(udev-worker) Not tainted 6.12.8 #1
Jan 16 11:30:54 ptxdist kernel: Hardware name: Generic AM33XX
(Flattened Device Tree)
Jan 16 11:30:54 ptxdist kernel: Call trace:
Jan 16 11:30:54 ptxdist kernel:  dump_backtrace from show_stack+0x20/0x38
Jan 16 11:30:54 ptxdist kernel:  r7:c4a7ff00 r6:c0cef6bc r5:00000000 r4:600f0113
Jan 16 11:30:54 ptxdist kernel:  show_stack from dump_stack_lvl+0x40/0x78
Jan 16 11:30:54 ptxdist kernel:  dump_stack_lvl from dump_stack+0x18/0x28
Jan 16 11:30:54 ptxdist kernel:  r7:c4a7ff00 r6:00000008 r5:c477dbc0 r4:c4a7ec00
Jan 16 11:30:54 ptxdist kernel:  dump_stack from __div0+0x24/0x34
Jan 16 11:30:54 ptxdist kernel:  __div0 from Ldiv0+0x8/0x10
Jan 16 11:30:54 ptxdist kernel:  omap2_mcspi_setup_transfer
[spi_omap2_mcspi] from omap2_mcspi_setup+0x134/0x20c [spi_omap2_mcspi]
Jan 16 11:30:54 ptxdist kernel:  r9:c4a7ff28 r8:c477dbd0 r7:c4a7ff00
r6:c4a7ec00 r5:c2572c10 r4:00000001
Jan 16 11:30:54 ptxdist kernel:  omap2_mcspi_setup [spi_omap2_mcspi]
from spi_setup+0x124/0x4f8
Jan 16 11:30:54 ptxdist kernel:  r9:c4a7edaf r8:00000000 r7:c2572c10
r6:c4a7fc00 r5:00000000 r4:c4a7ec00
Jan 16 11:30:54 ptxdist kernel:  spi_setup from __spi_add_device+0x15c/0x300
Jan 16 11:30:54 ptxdist kernel:  r6:c4a7fc00 r5:c4a7ec00 r4:c4a7ed9f
Jan 16 11:30:54 ptxdist kernel:  __spi_add_device from
of_register_spi_devices+0x74/0x1a8
Jan 16 11:30:54 ptxdist kernel:  r10:c0fe67cc r9:c4a7fd98 r8:c4a7fdd4
r7:c4a7ec00 r6:c4a7fc00 r5:00000000
Jan 16 11:30:54 ptxdist kernel:  r4:cfce0df4
Jan 16 11:30:54 ptxdist kernel:  of_register_spi_devices from
spi_register_controller+0x3d0/0x4d0
Jan 16 11:30:54 ptxdist kernel:  r9:c4a7fd98 r8:c0fe67d4 r7:c4a7fda0
r6:00000000 r5:c0fe67d4 r4:c4a7fc00
Jan 16 11:30:54 ptxdist kernel:  spi_register_controller from
devm_spi_register_controller+0x54/0xbc
Jan 16 11:30:54 ptxdist kernel:  r10:bf006108 r9:c2572c10 r8:c4a7fc00
r7:c2572c10 r6:c4a7fc00 r5:c4a7ff00
Jan 16 11:30:54 ptxdist kernel:  r4:c46cd2c0
Jan 16 11:30:54 ptxdist kernel:  devm_spi_register_controller from
omap2_mcspi_probe+0x51c/0x5cc [spi_omap2_mcspi]
Jan 16 11:30:54 ptxdist kernel:  r7:c4a7fc00 r6:c2572c10 r5:c4a7ff00 r4:c2572c10
Jan 16 11:30:54 ptxdist kernel:  omap2_mcspi_probe [spi_omap2_mcspi]
from platform_probe+0x6c/0xd0
Jan 16 11:30:54 ptxdist kernel:  r10:d0481ed0 r9:00000001 r8:00000000
r7:c1028ef8 r6:bf004014 r5:c2572c10
Jan 16 11:30:54 ptxdist kernel:  r4:00000000
Jan 16 11:30:54 ptxdist kernel:  platform_probe from really_probe+0xf0/0x3ec
Jan 16 11:30:54 ptxdist kernel:  r7:c1028ef8 r6:bf004014 r5:00000000 r4:c2572c10
Jan 16 11:30:54 ptxdist kernel:  really_probe from
__driver_probe_device+0xac/0x13c
Jan 16 11:30:54 ptxdist kernel:  r8:c27a50b4 r7:0000007d r6:c2572c10
r5:bf004014 r4:c2572c10
Jan 16 11:30:54 ptxdist kernel:  __driver_probe_device from
driver_probe_device+0x40/0xe4
Jan 16 11:30:54 ptxdist kernel:  r5:bf004014 r4:c1071d9c
Jan 16 11:30:54 ptxdist kernel:  driver_probe_device from
__driver_attach+0x154/0x204
Jan 16 11:30:54 ptxdist kernel:  r7:00000000 r6:c2572c54 r5:bf004014 r4:c2572c10
Jan 16 11:30:54 ptxdist kernel:  __driver_attach from bus_for_each_dev+0x8c/0xf0
Jan 16 11:30:54 ptxdist kernel:  r7:00000000 r6:c20e96c0 r5:c06404ec r4:bf004014
Jan 16 11:30:54 ptxdist kernel:  bus_for_each_dev from driver_attach+0x2c/0x44
Jan 16 11:30:54 ptxdist kernel:  r7:c20e96c0 r6:00000000 r5:c27a5080 r4:bf004014
Jan 16 11:30:54 ptxdist kernel:  driver_attach from bus_add_driver+0x104/0x244
Jan 16 11:30:54 ptxdist kernel:  bus_add_driver from driver_register+0x8c/0x164
Jan 16 11:30:54 ptxdist kernel:  r8:00000000 r7:bf004100 r6:c101f840
r5:a7ac7714 r4:bf004014
Jan 16 11:30:54 ptxdist kernel:  driver_register from
__platform_driver_register+0x2c/0x40
Jan 16 11:30:54 ptxdist kernel:  r5:a7ac7714 r4:c0fac2fc
Jan 16 11:30:54 ptxdist kernel:  __platform_driver_register from
omap2_mcspi_driver_init+0x38/0x1000 [spi_omap2_mcspi]
Jan 16 11:30:54 ptxdist kernel:  omap2_mcspi_driver_init
[spi_omap2_mcspi] from do_one_initcall+0x68/0x2b8
Jan 16 11:30:54 ptxdist kernel:  r5:c2a95800 r4:bf008000
Jan 16 11:30:54 ptxdist kernel:  do_one_initcall from do_init_module+0x64/0x218
Jan 16 11:30:54 ptxdist kernel:  r8:bf004100 r7:bf004100 r6:c477d240
r5:00000000 r4:bf004100
Jan 16 11:30:54 ptxdist kernel:  do_init_module from load_module+0x7e4/0xa18
Jan 16 11:30:54 ptxdist kernel:  r6:00000000 r5:00000000 r4:00000000
Jan 16 11:30:54 ptxdist kernel:  load_module from
init_module_from_file+0xa4/0xec
Jan 16 11:30:54 ptxdist kernel:  r10:c477c080 r9:c1054a48 r8:c477c080
r7:c1054a38 r6:b5b1d7f0 r5:c477c080
Jan 16 11:30:54 ptxdist kernel:  r4:00000000
Jan 16 11:30:54 ptxdist kernel:  init_module_from_file from
sys_finit_module+0x244/0x39c
Jan 16 11:30:54 ptxdist kernel:  r6:00000001 r5:000000f4 r4:c2a95800
Jan 16 11:30:54 ptxdist kernel:  sys_finit_module from
__sys_trace_return+0x0/0x10
Jan 16 11:30:54 ptxdist kernel: Exception stack(0xd0481fa8 to 0xd0481ff0)
Jan 16 11:30:54 ptxdist kernel: 1fa0:                   14cb6a00
00000000 0000001a b5b1d7f0 00000000 00000000
Jan 16 11:30:54 ptxdist kernel: 1fc0: 14cb6a00 00000000 00826358
0000017b 008456d0 b6f75934 b5b1739d 00000000
Jan 16 11:30:55 ptxdist kernel: 1fe0: bee9d538 bee9d528 b5b16643 b6c5d262
Jan 16 11:30:55 ptxdist kernel:  r10:0000017b r9:c2a95800 r8:c01002c4
r7:0000017b r6:00826358 r5:00000000
Jan 16 11:30:55 ptxdist kernel:  r4:14cb6a00
Jan 16 11:30:55 ptxdist kernel: spi spi0.0: setup: speed 0, sample
leading edge, clk normal
Jan 16 11:30:55 ptxdist kernel: spi spi0.0: setup mode 0, 8 bits/w,
10000000 Hz max --> 0

