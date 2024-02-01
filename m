Return-Path: <linux-spi+bounces-941-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95D845461
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516A21F23765
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4FD64DA0B;
	Thu,  1 Feb 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhCaKBIE"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DEE4D9F3
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780646; cv=none; b=fhxNiWZqECBeJ7pQF5zfXKaFAiMMqFB9MdSFo9FUhUdN9JS3uapAe5IJz5T0bYGUNG6LyUVnoE0+2mfFT8TXwia6wDnLMGnzQjgj9RPm+d2jjm917G2k+hRmkQ7NTkdDAxROyh/jjcUDa284y3VlUD+dosjukRE38vhpae5L63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780646; c=relaxed/simple;
	bh=hfNt+/QPMpa53eI9gudunueKzxHL5iJp50BiUsg0tN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9RF8lvayET3y0weABiLs7MQhg6FbP2kswAfQQVb3nm1WFZuILdaMlhmZxewcYlY64jNS1vZhMHNUMj/Qc3OJhMZ05UEMnG9GaX9zlhxElIypDPDGmm5EIl6fohvkcUWBQIOrYl872W2q5UYVMoOjlfVmvFRvoqtw1F8kQeSS8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhCaKBIE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d94323d547so5759185ad.3
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780644; x=1707385444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIFlFHvsfhehyqaRP1ouo3BOZo0GfNeez8MgVuBet0s=;
        b=mhCaKBIErbRKcxNUvPJA3yIqN0zaEhuuBH3fBdvGNIuTaK/fTQNodvLSXqTp34GBxa
         we4jK8pKv8enmNhHe16tK5c4qlR5HQBGvBxaAzgNqr6PzciaVbPeOYgEIRwS9KBkQXI8
         vGAWbfiqWTFIDzZLNI1mDJTWkaXeKH214YOplv4Dw6iqB/OXmR/J7sTP8xYwWER6rUEy
         7SMzUsaubt4B4o3ltiYzVBR1mbPDzysatrDVNR4pAi+U6XMkxaDLSZQydP0bPpvKb4y6
         Ip6iOrXeNDgKFLDBcKUKHrINmRF8zuuBxxcc90A0h8FkgKk6QA0OBnBI7w2usPjVhnS9
         c4vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780644; x=1707385444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TIFlFHvsfhehyqaRP1ouo3BOZo0GfNeez8MgVuBet0s=;
        b=tl9PxVK9gTBo+mNUV60H4AS5I9Dxlm69hhqjK/Bx14lPM9jbQJoopnp2HsGT9LTIbF
         lxOKUJQBFERN7W/u23uMPuIhTO0j0ReqpQK+18H2717ap/b3HNvW1+jYYJ2lJy+PUNmD
         7xfGboxBwQQNqXFu4RK0+JfFLPPu9++2FVYAv/VDzdctH5gjpE5Uw3BbA3Wn+b1HxbAh
         MUYa4+VaLCiBSsMXrFt/4tGGv11ccZh7RTcmMAYoXKzcT33Fodc9a/HbC3jhtmpNM/5b
         Dt2VpGdx8peRjoHKEB+iWMBOkAdl8Z+F4F8/cb2tHkXKKoiXsf4Cxq6oX3QezQMNFRfG
         oUTg==
X-Gm-Message-State: AOJu0YzfaTTCmCIVsLPUA7N4iXxDKdDQY7Me5EdcusfKOsCPSifPw/XE
	EbT4uAXXzfA4zeHRkiMW+YiP1rtXU6nlksGua44sGGM12yIMbeNUVey+iX9v
X-Google-Smtp-Source: AGHT+IHlZA9spCAb+BCzW/P1IYWDzYvqxoNQf81FFLcaIHCdMdjqwYATrTEjwhN8oN8793XIbjA/Dg==
X-Received: by 2002:a17:903:124f:b0:1d8:e64d:cd62 with SMTP id u15-20020a170903124f00b001d8e64dcd62mr5067889plh.4.1706780644147;
        Thu, 01 Feb 2024 01:44:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUh5GEk7WVrzJRmvi+GSq9RGnyQ1o6+i0AVQ5YPywzhsI+etuixfFvN1BF5H+HsM/fD2UAZwK1rU10ShwTrV/WhubigKuhDsmdbvlXNbfqWeJ3uvUvPvV0tJsVEL7s3Z3khUwFki/4NeDoIqr6nJqYO9Q6n0NNPmjkiV+MJaYKc67abk9UccjoTTYUAnbcjVqjjuFXTPaG7omA5MYHCxgG+8sK9cNzZ/KbkFt3zqTyHzf2wFeZ2lJnZ6h62YaMB/NNGBO/uPFF1zLxrWO8xn5IODukcUcVbbBJqRp/hMe5aOGEOPDExQKjFJ+ifNEDiyKVZVg==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id e20-20020a170902f1d400b001d8d1a2e5fesm7726309plc.196.2024.02.01.01.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:03 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id CC2F68074F;
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
Subject: [PATCH v8 7/9] mtd: spi-nor: add support for Macronix Octal flash MX66 series with RWW feature
Date: Thu,  1 Feb 2024 17:43:51 +0800
Message-Id: <20240201094353.33281-8-jaimeliao.tw@gmail.com>
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

MX66 series : Serial NOR Flash with stacked die.(Size larger than 1Gb)
LM/UM series : Up to 250MHz clock frequency with both DTR/STR operation.
LW/UW series : Support simultaneous Read-while-Write operation in multiple
               bank architecture. Read-while-write feature which means read
               data one bank while another bank is programing or erasing.

MX66LW : 3.0V Octal I/O with Read-while-Write and stack die
MX66UW : 1.8V Octal I/O with Read-while-Write and stack die

MX66LM : 3.0V Octal I/O with stacked die
Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/8748/MX66LM1G45G,%203V,%201Gb,%20v1.1.pdf

MX66UM : 1.8V Octal I/O with stacked die
Link: https://www.mxic.com.tw/Lists/Datasheet/Attachments/8711/MX66UM1G45G,%201.8V,%201Gb,%20v1.1.pdf

Those flash have been tested on Xilinx Zynq-picozed board using
MXIC SPI controller.
As below are debugfs data, the SFDP table and result of mtd-utils
tests dump.

---

zynq> cat jedec_id
c2843b
zynq> cat manufacturer
macronix
zynq> cat partname
mx66uw1g345g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff3f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff8b7901008f1200e2cc04674630b030b0f4bdd55c
000000ff101000200000147c00007c234800000000008888000000000000
00400fd1fff30fd1fff300050090060500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000000000000000
0000000000000000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043061f0021dcffff
zynq> md5sum sfdp
dd3ef0a8d22ee81fc5bccdcb67dee6ca  sfdp

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
id              c2 84 3b c2 84 3b
size            128 MiB
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
 c7 (128 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-07ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.100350 seconds, 19.9MB/s
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
22b2febd5a62c552b82c4089f511b269bcd2da3ab23aaed44e0a9d1e71349251  spi_read
22b2febd5a62c552b82c4089f511b269bcd2da3ab23aaed44e0a9d1e71349251  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 134217728 (128M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c2813b
zynq> cat manufacturer
macronix
zynq> cat partname
mx66uw1g45g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff3f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff8b7901008f1200e2cc04674630b030b0f4bdd55c
000000ff101000200000000000007ca34800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043060f0021dcffff
zynq> md5sum sfdp
b89a53266007fce06ba7cc4c0956f917  sfdp

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
id              c2 81 3b c2 81 3b
size            128 MiB
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
 c7 (128 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-07ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.100452 seconds, 19.9MB/s
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
85c3736186d77b75a9442c958e6b2610f8e5e0b59f5534fb91db4dbf9130f04e  spi_read
85c3736186d77b75a9442c958e6b2610f8e5e0b59f5534fb91db4dbf9130f04e  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 134217728 (128M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c2843c
zynq> cat manufacturer
macronix
zynq> cat partname
mx66uw2g345g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff7f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff87790100841200e2cc04674630b030b0f4bdd55c
000000ff101000200000147c00007c234800000000007777000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000000001445988043061f0021dcffff
zynq> md5sum sfdp
00447475e039e67c256a8d75d5885ae8  sfdp

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
  dummy cycles  16

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 84 3c c2 84 3c
size            256 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | RWW

opcodes
 read           0xee
  dummy cycles  16
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
 c7 (256 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-0fffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.099340 seconds, 20.1MB/s
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
5d9db592d7964b71151f8b130f27143cef4debd66801571b50f56fcb81f77222  spi_read
5d9db592d7964b71151f8b130f27143cef4debd66801571b50f56fcb81f77222  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 268435456 (256M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c2943c
zynq> cat manufacturer
macronix
zynq> cat partname
mx66uw2g345gx0
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff7f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff87790100841200e2cc04674630b030b0f4bdd55c
000000ff101000200000087c00007c234800000000008888000000000000
00400fd1fff30fd1fff300050090060500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000000000000000
0000000000000000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a00001445988043061f0021dcffff
zynq> md5sum sfdp
e6226263b999578a2f034ea969988d7f  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 1S-1S-8S
  opcode        0x7c
  mode cycles   0
  dummy cycles  8
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
id              c2 94 3c c2 94 3c
size            256 MiB
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
 c7 (256 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-0fffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.098722 seconds, 20.3MB/s
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
51134f432316a683a3375850143a40ca924b7eec21b5ec706039864ac7a8f744  spi_read
51134f432316a683a3375850143a40ca924b7eec21b5ec706039864ac7a8f744  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 268435456 (256M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 467bb5c97d6c..29bd5f0b32ec 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -240,6 +240,18 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x84, 0x3b),
 		.n_banks = 4,
 		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x81, 0x3b),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x84, 0x3c),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x94, 0x3c),
+		.n_banks = 4,
+		.flags = SPI_NOR_RWW,
 	}
 };
 
-- 
2.25.1


