Return-Path: <linux-spi+bounces-943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23815845463
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FCD1B2BF1F
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79984D9F7;
	Thu,  1 Feb 2024 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9vEgZC3"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5BF4D9EB
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780647; cv=none; b=DuFEuiuJwYgvPV+9Qd+/hbutP3LFelWBjx6LNpTcUUkkyhJAxlbM+53WDgBG55qeK3EVUtAuc593zqr1nloeJoB2zDTlJTGQGLIpxSkg+9CmcAiTxMzn7744zOIEI7nJHs3l/I8jBXmseS7KX2uuFdVNR+ilViryg4o0xXb4SfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780647; c=relaxed/simple;
	bh=KGGT0OA/uDBihl5+Fc6blirHvC2k7N2nKgMhBPcm6/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GbwoJktM/dWF8w9ufxl2uAtdVnzcqI1zhRD72RYYIN49eD03TJngHi8mJwZzQsSt2pW+v84a4UEqbSASQM805nQG7Q3iCHoU1+B2bqov7OxFLN6Ch3d87SspTQf/XIj0HTOxneb4dcRP788OlnKmX11paQMLJ9FxA561hDz0vWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9vEgZC3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6de0ba30994so518488b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780645; x=1707385445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgqnEFuUH1P2U8d8nQigTvfTdCnnxDZVV0FRD9p1CQw=;
        b=F9vEgZC3kBsYQHR4BENyWiHQkSvjEmFBVnrKg1xpKcIcmzDw1u5/BJFVKAaFdzZBqM
         J6bg49oJ9NKzyxUXhgbZzf/LmdMCnkp/TSb5IQcdTQj4E87gUMGxRk3gsYDylDnqRNeB
         fjZ1KxJYA6QMnLUx1KVNiJ2YlEY9TyaPEUEBtBF8sWV5VLpv3SUNT7v08+bvfhVTOTJg
         LuY62GMUt9wU/CGkTlYWmfkAwEzIfh5JVLJcg+87K/yaxrFB+vLH/sQeUOie5xyEFO18
         cEhmEM/45hgi6xE9enHUQDhOzjW0YE0IjVubH4Ey8MnMBikIuN+ZjugFIZ3a5NluM3PU
         pVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780645; x=1707385445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgqnEFuUH1P2U8d8nQigTvfTdCnnxDZVV0FRD9p1CQw=;
        b=W+q8wQcRRz9Ao+3xr2syDehuE6qL5yPV4SHjgxPGorXApc93SucXY+Dd0vHolrXSLY
         v5hcwegbzyjWymz1v1VFQ0FIT7Jky4M1vbHKB2XFnYtzT6Bbd5rSPxRfNwu8qF7e9ocm
         Q8obNe5m2yfRbXN2sxequ74XKj2zI0bkWRHRWtCe3WTPbwW4hGYyvceR2Dszx8ins1pN
         0A0d7by+KN0DnnRK+qi4rhAt+/uIi7N4O4CYIWHeGvW97W8HsZJF4KzJrGOIFCYqzZUU
         4IFE+Co4cz82MDhbdcXe/w0wuk9uoMjZQqkQFShcUps/oAHUopT/d5pSv2qLGshWtnnw
         HfTA==
X-Gm-Message-State: AOJu0YxQAWYMtpfclr2tz7QLdR+e/qs5vRgiVoIgku5CvmIJS2SyuT0k
	CY8WH9SdCTWoMO2Dyw7nyk3dqH056BHlibSDU9wJEQwTpsSALpaa
X-Google-Smtp-Source: AGHT+IFDIIosfhzYjnOzQPVtoGWtkTmmfUvKqh1ZQhCnOMyTXlrG+xrnNEf0tQ84JavP5GMIafWuhw==
X-Received: by 2002:a05:6a00:8815:b0:6df:ee93:570 with SMTP id ho21-20020a056a00881500b006dfee930570mr424749pfb.6.1706780645014;
        Thu, 01 Feb 2024 01:44:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUqnV4ZmnJz26NPw5PAIVGpW9opRoJWJHce9w1Sz17LIy9WXCqk0okosYxTBKPNqrisZ9ht3vuDsywYxk3HlIq+51ETW8lZbHBDrxmPRghyrM/wCr82gvalOIWH9Tvg8uoIsiXm89kgGi59/tiea7ASWb6Pxwl0XmA0C9RiAs3CXDH2+JW6EGDfKDIY8Qd/MiEPvOUO7M6gDX01Gf6+A5FSsUsVv84uodTcZn6ubAkW8tIVHEJl8r8Uan6T+QcZ3yh8TGgwNtxtRFZEEpacCsaZlMf7kOJwcCpYx6cdLAt5H0nYLs6AHBVowC1kXRFqJ4onfA==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b006dfe45dfdb4sm1196742pfo.74.2024.02.01.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:04 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id 39065808AB;
	Thu,  1 Feb 2024 17:50:04 +0800 (CST)
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
Subject: [PATCH v8 8/9] mtd: spi-nor: add support for Macronix Octal flash MX25 series
Date: Thu,  1 Feb 2024 17:43:52 +0800
Message-Id: <20240201094353.33281-9-jaimeliao.tw@gmail.com>
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
MX66 series : Serial NOR Flash with stacked die.(Size larger than 1Gb)
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
c28339
zynq> cat manufacturer
macronix
zynq> cat partname
mx25um25345g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff87690100821200d2cc02673830b030b0f4bdd55c
000000ff101000200000000000007c234800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
040900001445988043060f0021dcffff
zynq> md5sum sfdp
950e623745a002e1747008592e6dbdf9  sfdp

zynq> cat /sys/kernel/debug/spi-nor/spi0.0/capabilities
Supported read modes by the flash
 1S-1S-1S
  opcode        0x13
  mode cycles   0
  dummy cycles  0
 8D-8D-8D
  opcode        0xee
  mode cycles   0
  dummy cycles  18

Supported page program modes by the flash
 1S-1S-1S
  opcode        0x12
 8D-8D-8D
  opcode        0x12
zynq>
zynq> cat /sys/kernel/debug/spi-nor/spi0.0/params
name            (null)
id              c2 83 39 c2 83 39
size            32.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET

opcodes
 read           0xee
  dummy cycles  18
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
2097152 bytes (2.0MB) copied, 0.100104 seconds, 20.0MB/s
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
3bd63265e92e5101716839b337a4c36ab1031f4e34bc462388727aee68cf5e37  spi_read
3bd63265e92e5101716839b337a4c36ab1031f4e34bc462388727aee68cf5e37  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 33554432 (32M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c28039
zynq> cat manufacturer
macronix
zynq> cat partname
mx25um25645g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff87790100841200d2cc02673830b030b0f4bdd55c
000000ff101000200000000000007ca34800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a000014359c8043060f0021dcffff
zynq> md5sum sfdp
d652779f17770dc833cd96262cb2a620  sfdp

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
id              c2 80 39 c2 80 39
size            32.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | 1<<17

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
2097152 bytes (2.0MB) copied, 0.100539 seconds, 19.9MB/s
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
5f37a5bbdade66b0c1b7d0b3934c8b235466af9d435a98fef9b55beeb772e919  spi_read
5f37a5bbdade66b0c1b7d0b3934c8b235466af9d435a98fef9b55beeb772e919  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 33554432 (32M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c28539
zynq> cat manufacturer
macronix
zynq> cat partname
mx25lm25645g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff0f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff87690100821200d2cc02673830b030b0f4bdd55c
000000ff101000200000000000007ca34800000000006666000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
0000000014351c0043060f0021dcffff
zynq> md5sum sfdp
ec258f831ac737454c7eb9f6a8a4495a  sfdp

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
id              c2 85 39 c2 85 39
size            32.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | 1<<17

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
2097152 bytes (2.0MB) copied, 0.100846 seconds, 19.8MB/s
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
bd7d61f6862ac08a0d87bef4c7e04ff7c73ebe3cc785376baa2f0891ca38fc00  spi_read
bd7d61f6862ac08a0d87bef4c7e04ff7c73ebe3cc785376baa2f0891ca38fc00  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 33554432 (32M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c2803a
zynq> cat manufacturer
macronix
zynq> cat partname
mx25um51245g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff1f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff8b7901008f1200e2cc04674630b030b0f4bdd55c
000000ff101000200000000000007ca34800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a000014359c8043060f0021dcffff
zynq> md5sum sfdp
75d81c1eb2fd2767634f1d0dfbb3be35  sfdp

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
id              c2 80 3a c2 80 3a
size            64.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | 1<<17

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
2097152 bytes (2.0MB) copied, 0.101156 seconds, 19.8MB/s
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
bdf2135e7e809e0733400d84f5d13487febd8d45ab27004189efdecc1ae94ce6  spi_read
bdf2135e7e809e0733400d84f5d13487febd8d45ab27004189efdecc1ae94ce6  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 67108864 (64M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c2853a
zynq> cat manufacturer
macronix
zynq> cat partname
mx25lm51245g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff1f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff897901008d1200e2cc02674430b030b0f4bdd55c
000000ff101000200000000000007ca34800000000006666000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
0000000014351c0043060f0021dcffff
zynq> md5sum sfdp
214868617d74e6bfb2c45444d5d6fff0  sfdp

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
id              c2 85 3a c2 85 3a
size            64.0 MiB
write size      1
page size       256
address nbytes  4
flags           4B_OPCODES | HAS_4BAIT | HAS_16BIT_SR | IO_MODE_EN_VOLATILE | SOFT_RESET | 1<<17

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
2097152 bytes (2.0MB) copied, 0.100120 seconds, 20.0MB/s
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
b9e2e3283620cdd6f7e55e116f7bb3b40d9826f86de08fdda27322adad482389  spi_read
b9e2e3283620cdd6f7e55e116f7bb3b40d9826f86de08fdda27322adad482389  spi_test

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
 drivers/mtd/spi-nor/macronix.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 29bd5f0b32ec..42b1e2fec4f2 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -252,6 +252,16 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x94, 0x3c),
 		.n_banks = 4,
 		.flags = SPI_NOR_RWW,
+	}, {
+		.id = SNOR_ID(0xc2, 0x83, 0x39),
+	}, {
+		.id = SNOR_ID(0xc2, 0x80, 0x39),
+	}, {
+		.id = SNOR_ID(0xc2, 0x85, 0x39),
+	}, {
+		.id = SNOR_ID(0xc2, 0x80, 0x3a),
+	}, {
+		.id = SNOR_ID(0xc2, 0x85, 0x3a),
 	}
 };
 
-- 
2.25.1


