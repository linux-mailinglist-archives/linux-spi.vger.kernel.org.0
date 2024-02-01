Return-Path: <linux-spi+bounces-942-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C485284545F
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E94701C2748F
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE714D9F3;
	Thu,  1 Feb 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnr96+8s"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E04DA07
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780647; cv=none; b=mZlDstoYPVrSlbextZdlTdvnWxNy08yxX9xvwbW5kqktJxdhSRGbRV8NyFh8KbkqTrB5RTJyS7k431cr4jecaBV+FYMJKtDgnH/xBFd5IbNaxfIkV7EHrjBcSJDrsPpbY9Um9xCvVuJuv+SWa2D4ZNj+UBTiOM9uqh1mPL6cSB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780647; c=relaxed/simple;
	bh=O31Kw9VQvYDqxgXNWptoriD7tcW5kXHGqFwzI9flHiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nmh39GfxoMY2K45iOGBElF9war3GZjV9loTuzgs4gUHzqksxL6bWBZXxnWRT2iOIDwRpwtC2KGuErZqKAIALolovRwntMX9a3SC7+hHjHRJmH9X9dF9I02KmITjHetkmmNHF7nO+ROjOy+E5hwSNAjqoxBPW327SyUmFioHK5Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnr96+8s; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d93f2c3701so4091395ad.3
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780645; x=1707385445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Pm8SO+DlImf7ynS98REpNX6/bqUyC77SjBqw412Umw=;
        b=Vnr96+8st4RauT+sPxPNzyeK3Skyirts0RLHSFO6rdZkbRBMo/UQoj0ypKncR+sLbp
         z54EjhCG83lqRrkEK9mniIHUVijTtv0aVsMVisscOcWsm075Y2rFt9P+Hsus1MlcYpTT
         JjrUaHIDB/HscrwsTmwZC2vDa/P+uOyTnOPKey8GzpsJTncQReA2OY5K9TxW0EYGpgv6
         vV17M4djoE2+VWQM6bgm4I7wslaJ6ZaxOkxE8eiTV+nUWJIX4eJsapzRufZKItfCvy1y
         SApex93TvM/vwRlYFY2RuViBsk9eiRGVaN9o6W3sSgaaF1pY0ktXUaml6GUlI6L4to4H
         epuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780645; x=1707385445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Pm8SO+DlImf7ynS98REpNX6/bqUyC77SjBqw412Umw=;
        b=eQ/BVpaRhKWZZJ74kE/V1+h5zc6MKm6+Y982WMlsAPhcWspavhF3VsnvvA8F07dTAl
         zlL0KpwvOfrf3u4p+aBn4BxkMcdkZUohW27tBMCMVW0DOMgjyacyJFXeLQYaZdPR5yMH
         lq7OnuO6KFSaisw1nxgriZMBfUCl3pxyVfA1Ziv3t6zoSlwcfJQAJXBkqQWgboGbrmyU
         u/D1oegVRA8NnDcwRrzldbz2/SdUQJAb+qN3M7YURnP0Jn4UEVwCTp8aUtGNdNh6mEG0
         TtQ8xkyHoyULucB0kK+I9ZMPRspL12QcMqxRc5tXGg+JEhCC8/GjS7kxZx/f0DUpB90x
         +ZhQ==
X-Gm-Message-State: AOJu0YyAUrUlvYIUIZOZmgAcsxuSMz5MqWYcWfyTm0lQtDeFIZCzJY5B
	KhR9lPBS6xwA+VfkMkWr6LVBSbSZ26+Yx9hMxdmniwJWEgbfrl7A
X-Google-Smtp-Source: AGHT+IHF2dNQ8tCHUyro63T3yVf/ED0VknFH65T2ibkASXA+lXjd3gbrRlRdF4WsrXcClS5yzMEJ/w==
X-Received: by 2002:a17:902:e54e:b0:1d9:5bcc:e997 with SMTP id n14-20020a170902e54e00b001d95bcce997mr138080plf.10.1706780644496;
        Thu, 01 Feb 2024 01:44:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXqntI2zNjsmQZLyfDUFG/RG52HYn3Wbu36jWoFKTCoKXzLzYsbfndey7HMP1nywlQndmI+OBUUR+YfLzhfE0jvl+yeUn0Jrrb6WRxPHf/IRw7OV8K3egBjt3rnTD+5FDTiF9yvU+XOlqd1t87yYGCoHPfOh/iv1XenUC/O4EHn7AemTdKbU3sN3os11gMzv+/KawWDuEej/8817yMVc8iad5x94UjFnO/Or83UHFZwWilKTJQ1+YFuzD+0XeIRAGxz3f6ngtt/wqZFiX7A/EGoF7SUZc1ZyM+JG0ErJX0I3x8McvYGDyM10IhYDKzk/Izicg==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902d10300b001d8f3b0ba18sm1198589plw.2.2024.02.01.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:03 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id 777AA80671;
	Thu,  1 Feb 2024 17:50:03 +0800 (CST)
From: Jaime Liao <jaimeliao.tw@gmail.com>
To: linux-mtd@lists.infradead.org,
	linux-spi@vger.kernel.org,
	tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	broonie@kernel.org
Cc: leoyu@mxic.com.tw,
	jaimeliao@mxic.com.tw
Subject: [PATCH v8 6/9] mtd: spi-nor: add support for Macronix Octal flash MX25 series with RWW feature
Date: Thu,  1 Feb 2024 17:43:50 +0800
Message-Id: <20240201094353.33281-7-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
References: <20240201094353.33281-1-jaimeliao.tw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: JaimeLiao <jaimeliao@mxic.com.tw>

Adding Macronix Octal flash for Octal DTR support.

The octaflash series can be divided into the following types:

MX25 series : Serial NOR Flash.
LM/UM series : Up to 250MHz clock frequency with both DTR/STR operation.
LW/UW series : Support simultaneous Read-while-Write operation in multiple
               bank architecture. Read-while-write feature which means read
               data one bank while another bank is programing or erasing.

MX25LW : 3.0V Octal I/O with Read-while-Write
MX25UW : 1.8V Octal I/O with Read-while-Write

MX25LM : 3.0V Octal I/O
Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/8729/MX25LM51245G,%203V,%20512Mb,%20v1.1.pdf

MX25UM : 1.8V Octal I/O
Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/8967/MX25UM51245G,%201.8V,%20512Mb,%20v1.5.pdf

Those flash have been tested on Xilinx Zynq-picozed board using
MXIC SPI controller.
As below are debugfs data, the SFDP table and result of mtd-utils
tests dump.

---

zynq> cat jedec_id
c28437
zynq> cat manufacturer
macronix
zynq> cat partname
mx25uw6345g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0300ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff8b7901008f1200c4cc04674630b030b0f4bdd55c
000000ff101000200000000000007c234800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043060f0021dcffff
zynq> md5sum sfdp
c6fb57b8fdd4c35b5f0dacc4a1f7d4f4  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  20

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 84 37 c2 84 37
size            8.00 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW

opcodes
 read           0xee
  dummy cycles  20
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (8.00 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-007fffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.099455 seconds, 20.1MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
893a6650d6ab3622b5d8f0110541b4dbe9f6adc2ab68dd2609c376d38cd58e98  spi_read
893a6650d6ab3622b5d8f0110541b4dbe9f6adc2ab68dd2609c376d38cd58e98  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 8388608 (8M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c28137
zynq> cat manufacturer
macronix
zynq> cat partname
mx25uw6445g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0300ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff897901008d1200c4cc04674630b030b0f4bdd55c
000000ff101000200000000000007ca34800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043060f0021dcffff
zynq> md5sum sfdp
b09aeedb0cfd0f77adc7e08592d295a9  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  20

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 81 37 c2 81 37
size            8.00 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW | 1<<17

opcodes
 read           0xee
  dummy cycles  20
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (8.00 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-007fffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.099360 seconds, 20.1MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
1f9fc3b1c9ab9c20b38d8cd5e9331c0806017561f844761237909fb41ae94f4c  spi_read
1f9fc3b1c9ab9c20b38d8cd5e9331c0806017561f844761237909fb41ae94f4c  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 8388608 (8M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c28438
zynq> cat manufacturer
macronix
zynq> cat partname
mx25uw12345g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0700ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff8b7901008f1200c9cc04674630b030b0f4bdd55c
000000ff101000200000000000007c234800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043060f0021dcffff
zynq> md5sum sfdp
a3eb609c08894c84270ad06efc03766c  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  20

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 84 38 c2 84 38
size            16.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW

opcodes
 read           0xee
  dummy cycles  20
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (16.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-00ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.100084 seconds, 20.0MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
c930efc31337aa6f45d2f5a64a68bc7f74db4866144e4ad4b87a6bbae0538916  spi_read
c930efc31337aa6f45d2f5a64a68bc7f74db4866144e4ad4b87a6bbae0538916  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 16777216 (16M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c28138
zynq> cat manufacturer
macronix
zynq> cat partname
mx25uw12845g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff000000000000000000000000
00000000e5208affffffff0700ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff8b7901008f1200c9cc04674630b030b0f4bdd55c
000000ff101000200000000000007ca34800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043060f0021dcffff
zynq> md5sum sfdp
9eacff90d7aa7cf737b970e0f2a7f2c6  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  20

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 81 38 c2 81 38
size            16.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW | 1<<17

opcodes
 read           0xee
  dummy cycles  20
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (16.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-00ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.100118 seconds, 20.0MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
0b843b2638d248f4e520ed96fa15f480800a2e210ef69762ed3a176f2d16268c  spi_read
0b843b2638d248f4e520ed96fa15f480800a2e210ef69762ed3a176f2d16268c  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 16777216 (16M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c28439
zynq> cat manufacturer
macronix
zynq> cat partname
mx25uw25345g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff897901008d1200d2cc04674630b030b0f4bdd55c
000000ff101000200000147c00007c234800000000008888000000000000
00400fd1fff30fd1fff300050090060500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000000000000000
0000000000000000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043061f0021dcffff
zynq> md5sum sfdp
765e310356fb92fdd77b2af1c725fbcb  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 1S-1S-8S
  opcode        0x7c
  mode cycles   0
  dummy cycles  20
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  20

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 84 39 c2 84 39
size            32.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW

opcodes
 read           0xee
  dummy cycles  20
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (32.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-01ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.099890 seconds, 20.0MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
d0996b13ba4b92f55270c47f3abcf91a44f00856e5c3307c50a40a21bca9f2b0  spi_read
d0996b13ba4b92f55270c47f3abcf91a44f00856e5c3307c50a40a21bca9f2b0  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 33554432 (32M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c28139
zynq> cat manufacturer
macronix
zynq> cat partname
mx25uw25645g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff897901008d1200d2cc04674630b030b0f4bdd55c
000000ff101000200000000000007ca34800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043060f0021dcffff
zynq> md5sum sfdp
e43ab2dbcbcf99cebc74964c5dcf3ee2  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  20

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 81 39 c2 81 39
size            32.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW | 1<<17

opcodes
 read           0xee
  dummy cycles  20
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (32.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-01ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.099750 seconds, 20.0MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
92f0ac2c79c4ff3b7a71942ce1a9a4937107b48bffd94135962340213b9caea1  spi_read
92f0ac2c79c4ff3b7a71942ce1a9a4937107b48bffd94135962340213b9caea1  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 33554432 (32M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c28639
zynq> cat manufacturer
macronix
zynq> cat partname
mx25lw25645g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff897901008d1200d2cc04674630b030b0f4bdd55c
000000ff101000200000000000007ca34800000000006666000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
0000000014351c0043060f0021dcffff
zynq> md5sum sfdp
b5db9fe24f814b5cc6a392c4c56ed331  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  14

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 86 39 c2 86 39
size            32.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW | 1<<17

opcodes
 read           0xee
  dummy cycles  14
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (32.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-01ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.100542 seconds, 19.9MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
d8ba27cdac64fc61c761ad0718058435768bb7d1f5afbade8e4ad039b361691d  spi_read
d8ba27cdac64fc61c761ad0718058435768bb7d1f5afbade8e4ad039b361691d  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 33554432 (32M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c2843a
zynq> cat manufacturer
macronix
zynq> cat partname
mx25uw51345g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff1f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff8b7901008f1200e2cc04674630b030b0f4bdd55c
000000ff101000200000147c00007c234800000000008888000000000000
00400fd1fff30fd1fff300050090060500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000000000000000
0000000000000000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043061f0021dcffff
zynq> md5sum sfdp
b3c82acb473b65117fe0c063be9d8546  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 1S-1S-8S
  opcode        0x7c
  mode cycles   0
  dummy cycles  20
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  20

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 84 3a c2 84 3a
size            64.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW

opcodes
 read           0xee
  dummy cycles  20
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (64.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-03ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.100939 seconds, 19.8MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
e86eff36985f6517c78981422a39d047c80de424d98c09d274fcff8890744727  spi_read
e86eff36985f6517c78981422a39d047c80de424d98c09d274fcff8890744727  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 67108864 (64M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c2863a
zynq> cat manufacturer
macronix
zynq> cat partname
mx25lw51245g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff000000000000000000000000
00000000e5208affffffff1f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff8b7901008f1200e2cc04674630b030b0f4bdd55c
000000ff101000200000000000007ca34800000000006666000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
0000000014351c0043060f0021dcffff
zynq> md5sum sfdp
bb32ccaca6814f3104b985ac91bd65ac  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  14

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 86 3a c2 86 3a
size            64.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW | 1<<17

opcodes
 read           0xee
  dummy cycles  14
 erase          0x21
 program        0x12
 8D extension   invert

protocols
 read           8D-8D-8D
 write          8D-8D-8D
 register       8D-8D-8D

erase commands
 21 (4.00 KiB) [2]
 dc (64.0 KiB) [3]
 c7 (64.0 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-03ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.100369 seconds, 19.9MB/s
zynq> mtd_debug erase /dev/mtd0 0 2097152
Erased 2097152 bytes from address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> hexdump spi_read
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0200000
zynq> sha256sum spi_read
4bda3a28f4ffe603c0ec1258c0034d65a1a0d35ab7bd523a834608adabf03cc5  spi_read
zynq> mtd_debug write /dev/mtd0 0 2097152 spi_test
Copied 2097152 bytes from spi_test to address 0x00000000 in flash
zynq> mtd_debug read /dev/mtd0 0 2097152 spi_read
Copied 2097152 bytes from address 0x00000000 in flash to spi_read
zynq> sha256sum spi_*
3b2a81e0e8f3a6f8e09d905a5c0d77598e9b41bdba0c4974eb3a35bc7f87f2a7  spi_read
3b2a81e0e8f3a6f8e09d905a5c0d77598e9b41bdba0c4974eb3a35bc7f87f2a7  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 67108864 (64M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index dee71776b1a8..467bb5c97d6c 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -200,6 +200,46 @@ static const struct flash_info macronix_nor_parts[] = {
 		.name = "mx25l3255e",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
+	}, {
+		.id = SNOR_ID(0xc2, 0x84, 0x37),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x81, 0x37),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x84, 0x38),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x81, 0x38),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x84, 0x39),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x81, 0x39),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x86, 0x39),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x84, 0x3a),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x86, 0x3a),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x84, 0x3b),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
 	}
 };
 
-- 
2.25.1


