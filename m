Return-Path: <linux-spi+bounces-944-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C4E0845462
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 10:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C793D288217
	for <lists+linux-spi@lfdr.de>; Thu,  1 Feb 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AD64DA12;
	Thu,  1 Feb 2024 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0fDGOpx"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1144D9F8
	for <linux-spi@vger.kernel.org>; Thu,  1 Feb 2024 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706780648; cv=none; b=hA0hI4M2IRXdb89zQCCbgZ/2xQCZfadwkvRl+l6carqRrotv9OxLULLSZDzM89nHRIGGBx/TEoqrtEFf4QWEZXsYxnTzeedvPDRCB33HbVyOUX2QzwsOmY87WTu1NTtIw73V5gxy/agaDtYlQgBTRQxyHGrzcWV9K2M8d6PjS3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706780648; c=relaxed/simple;
	bh=PhW8kwdnxOKAY0cFx5zFsFphEDvehnyU7/l5KbIa3sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SQh2vrpCgTOmLBl47cCnlXHmXT+tZ0WranVBKkkXlhICiTl2CX8FHLKDLaHt7TGkn8dKkwGpyIRWe2k+Nv05hRVbh8/KNlzsCQqrFYgmUdMgHMTr0XWmUkKwtXhOxvk3vzcKnn2U3eDPQMvsMkLD0c2VGFk0nB7RZQGSHjfa6u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0fDGOpx; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bd72353d9fso577759b6e.3
        for <linux-spi@vger.kernel.org>; Thu, 01 Feb 2024 01:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706780645; x=1707385445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Inuyq/YshgmmcSw7cLKnBgk/toIut3pXwiVeDRBPMgc=;
        b=Z0fDGOpxfcSmj6gFJuc1kCNmDgR5hmWQlnia5g9zsWB+b4tW98yZJph/nGaTY/6jCs
         wFaLyvbGbE5pNi5s1l1el9BPx0lNuKY6TaMbeqi7Lvo9x3Yn0ducm8ZH3seCV5Tu/lrU
         9PJdpacpz2fi62A5J+02boFflUqi84lg0coEOPylaEPsrLnc32plPF6dsRnbM5fNsTuw
         VcE2BcdKRygV1J4mHHvkHVjbcMH4Xyur+ezKLiU8OFYcaq5/6er2rLZC/kq2Sq0m666p
         5+jyg41tRgD/0YfVtHqVdadAerRh4Tp/n5W6vI2lchVIRSRJJdOQNpCpqSq4c02fBf5m
         CKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706780645; x=1707385445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Inuyq/YshgmmcSw7cLKnBgk/toIut3pXwiVeDRBPMgc=;
        b=tbjqmazuBCEXTY3SS/55aIsNKFAijPLMe+3MDrBg3iPwUPRuNH0axFeGVnPeEkD1MX
         AWYtbKAdYch+go58mrZ4fDoLTAhj2mAcVEnwQNiv9K5OwkcH4mttBbYvibD4hVdYEwKC
         PMQ+fZ5QOwkzFyjCMyLDpihdRbUQuS6h8ifzS7dHbtyixoDG5D5Q1v/1eKLrTO3LwpFN
         DdC1Ao+z8saQKYuuia+68FaNwPu0jVhdtFftSVXXl1ALcR5rxqArjGhmSFXu2K4ax6n5
         DUY0ECjnR8pTlFnyG3tpViA34sZI4xcokiFsYJL1i0p63yvrH5EwTSkpgMkmuWpMSEW7
         gCCw==
X-Gm-Message-State: AOJu0Yzez4B3238TSsG8bIYiF5GHeFCQ1eEHN9dBLc65PQRnGX2yM6Cv
	sRVXfEOtwlUfEO0vmpKn3zv6C9iJF4gel3K9FNE8rwnfsCqy4cNE
X-Google-Smtp-Source: AGHT+IHbPMRUzo+RR2WnBOsRxhWbETBryz+gVEyijJTbd6h0qSOrDVlHcB3otM2QWdYat9sNyH3yiw==
X-Received: by 2002:a05:6808:4498:b0:3be:c44b:f129 with SMTP id eq24-20020a056808449800b003bec44bf129mr4779516oib.11.1706780645198;
        Thu, 01 Feb 2024 01:44:05 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXyWfq0vLbuxQcCyjJAORQWkpBN0wFsl+PWALSQPGRBuGiam+UkGDXk71tbAEPKJ8zgBkqBRsVSAATcCmDqv911tYZvKI1heL5+S2wU8pqFBRTxUT/iVbVXH4Mm2JGZ1Gy4O+zS6uTXT15BR99Er2OPsQNrPW/oSboJzAn2LlKKoCupMo+8p1/QHr0ZZ2sxoQNXmhoiwgeagB/wh+EQZTDnCh/cltP3fdjYbQeGymqzLBg7tCBevNzcBWifuqJcpu64mv/UpNiwODXBQCc42JMWio6SopkSTD09E6t1I0JModSFS1N31tnLJCLgK4rD4dFwYg==
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id s14-20020a62e70e000000b006ddbeca54e0sm11307606pfh.87.2024.02.01.01.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 01:44:04 -0800 (PST)
Received: from hqs-appsw-appswa2.mp600.macronix.com (linux-patcher [172.17.236.35])
	by twhmp6px (Postfix) with ESMTPS id A46B780DCE;
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
Subject: [PATCH v8 9/9] mtd: spi-nor: add support for Macronix Octal flash MX66 series
Date: Thu,  1 Feb 2024 17:43:53 +0800
Message-Id: <20240201094353.33281-10-jaimeliao.tw@gmail.com>
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
Adding Manufacture ID 0xC2 in last of ID table because of
Octal Flash need manufacturer fixup for enabling/disabling
Octal DTR mode.

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
c2803b
zynq> cat manufacturer
macronix
zynq> cat partname
mx66um1g45g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff3f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff897901008d1200e2cc02674430b030b0f4bdd55c
000000ff101000200000000000007ca34800000000008888000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
000a000014359c8043060f0021dcffff
zynq> md5sum sfdp
eea09d64679e64f627402b39a177e356  sfdp

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
id              c2 80 3b c2 80 3b
size            128 MiB
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
 c7 (128 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-07ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.099845 seconds, 20.0MB/s
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
7f7b735ea26eb74d77203c82347a06b51e1ef1f5b9a0fda956ffc4087caa2ed8  spi_read
7f7b735ea26eb74d77203c82347a06b51e1ef1f5b9a0fda956ffc4087caa2ed8  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 134217728 (128M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

zynq> cat jedec_id
c2853b
zynq> cat manufacturer
macronix
zynq> cat partname
mx66lm1g45g
zynq> xxd -p sfdp
53464450080104fd00070114400000ff8701011c900000ff0a0001080001
00ff05000105200100ff84000102340100ff0000000000000000ffffffff
ffffffffe5208affffffff3f00ff00ff00ff00ffeeffffffffff00ffffff
00ff0c2010d800ff00ff87690100821200e2cc02673830b030b0f4bdd55c
000000ff101000200000000000007ca34800000000006666000000000000
00400fd1fff30fd1fff300050090000500b1002b0095002b0096727103b8
727103b80000000090a3188200c069960000000000000000727100987271
00b8727100990000000072710098727100f872710099727100f900000000
00000000011501d0727106d8000086500000060100000000020001030002
00000000060100000000000072060002000000eec0697272717100d8f7f6
0000000014351c0043060f0021dcffff
zynq> md5sum sfdp
7b46113b529d58a6335531a10f14a76e  sfdp

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
id              c2 85 3b c2 85 3b
size            128 MiB
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
 c7 (128 MiB)

sector map
 region (in hex)   | erase mask | flags
 ------------------+------------+----------
 00000000-07ffffff |     [  23] |
zynq>
zynq> dd if=/dev/urandom of=./spi_test bs=1M count=2
2+0 records in
2+0 records out
2097152 bytes (2.0MB) copied, 0.100305 seconds, 19.9MB/s
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
5607ddcf8d16b481e78fc4e90b21795c19d1f9a7eb77182a20536cab82eb55a2  spi_read
5607ddcf8d16b481e78fc4e90b21795c19d1f9a7eb77182a20536cab82eb55a2  spi_test

zynq> mtd_debug info /dev/mtd0
mtd.type = MTD_NORFLASH
mtd.flags = MTD_CAP_NORFLASH
mtd.size = 134217728 (128M)
mtd.erasesize = 4096 (4K)
mtd.writesize = 1
mtd.oobsize = 0
regions = 0

Signed-off-by: JaimeLiao <jaimeliao@mxic.com.tw>
---
 drivers/mtd/spi-nor/macronix.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index 42b1e2fec4f2..ba729007a92e 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -262,6 +262,13 @@ static const struct flash_info macronix_nor_parts[] = {
 		.id = SNOR_ID(0xc2, 0x80, 0x3a),
 	}, {
 		.id = SNOR_ID(0xc2, 0x85, 0x3a),
+	}, {
+		.id = SNOR_ID(0xc2, 0x80, 0x3b),
+	}, {
+		.id = SNOR_ID(0xc2, 0x85, 0x3b),
+	}, {
+		/* Need the manufacturer fixups. Keep this last */
+		.id = SNOR_ID(0xc2),
 	}
 };
 
-- 
2.25.1


