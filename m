Return-Path: <linux-spi+bounces-5219-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 561C799BCA3
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 00:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3719281843
	for <lists+linux-spi@lfdr.de>; Sun, 13 Oct 2024 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E7E155359;
	Sun, 13 Oct 2024 22:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="yE6pOGFX"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7BD14F117
	for <linux-spi@vger.kernel.org>; Sun, 13 Oct 2024 22:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728859155; cv=none; b=Uo9LjUo4NI2T4mBc7BoFkYoI8LVIRzmPAKnzNhIdAUUPbeL12O0k2d9lX0YGqUUbqYD46/CpbLmGHlAuY27Jk6dT/3A0VCzBq/sJG9vnOZckB2aHNp0Bt2CmQx2D6BALpP8ZMoB7r5wIs1oj0b4H8IhNBGdWjKiC/MV/227wvDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728859155; c=relaxed/simple;
	bh=MQu2My1FyBFYAOcNgYxwTu4ayTpcgi+JzJHWeSwYOFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZ6JQFQvO1rKVB6Q8oHrNdHS5+8dYJM/Lh4prscvVBzwjjlbPZb5Jb+Zbb1GRp7JA62kKNivYfZmdynPtpaq0QZGTEjpLpPRM1WT5ZiVB6VWSxHR3RtkOv/SnMFdDxuTmcizhRzbxNzXnLCRZpEmvW1fP9VxVG5v7FRWJKeLi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=yE6pOGFX; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C1D4D2C0404;
	Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728859149;
	bh=cqGHzue0n4aILgBri5fX5e+DLcXOkXfbyVaLXhH1OTg=;
	h=From:To:Cc:Subject:Date:From;
	b=yE6pOGFXfNjOD/TEsDPw8ZmpoAHagrn025sdRRtcnIYNsyqFRIui6YuJn7788cwlc
	 uYl7zACxYK40sIuOkPy7BDE+/qE9a+t2Hlrf2CnlYVbzJLvyU0iWfbs6y62E4GWLIr
	 wpS4m3n5IYB7GdPh4LAeNjGNHK2OZXAnHMsT5BrJZBH1/PzUMaZSQ45c/eGZ86jIPh
	 W9ug+1+TjcOvOV592GGApCT8TYw3jG4ykmWfZjjGrNe/DyYCjU2ZWzWvSsHuCjxV1i
	 uhiuptRxeL6qQQsEVq+WH/8SvZ35zp5sxUyBKRL4diAq+ag1vsoZEJukg2UCdRlil6
	 Vdsp5424mV8hw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670c4c0d0000>; Mon, 14 Oct 2024 11:39:09 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 8252913ED7B;
	Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 7CFAE280449; Mon, 14 Oct 2024 11:39:09 +1300 (NZDT)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	tsbogend@alpha.franken.de
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/3] Realtek SPI-NAND controller
Date: Mon, 14 Oct 2024 11:39:04 +1300
Message-ID: <20241013223907.2459099-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670c4c0d a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=63fhtx2pClmO-oMQzGgA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

This series adds support for the SPI-NAND flash controller on the RTL9300
family of SoCs.

There are 2 physical chip selects which are called SPI_MST_CS0 and SPI_MS=
T_CS1
in the datasheet. Via some pin-strapping these can be assigned to either =
the
SPI-NOR controller or the SPI-NAND controller. Which means you can end up=
 with
the following permutations

  SPI-Flash
  Boot Model SPI_MST_CS0 SPI_MST_CS1
  ---------- ----------- -----------
  NOR x1     NOR-CS0     X
  NOR x2     NOR-CS0     NOR-CS1
  NAND x1    NAND-CS0    X
  NAND x2    NAND-CS0    NAND-CS1
  NOR+NAND   NOR-CS0     NAND-CS0

Chris Packham (3):
  dt-bindings: spi: Add realtek,rtl9300-snand
  mips: dts: realtek: Add SPI NAND controller
  spi: spi-mem: Add Realtek SPI-NAND controller

 .../bindings/spi/realtek,rtl9301-snand.yaml   |  59 +++
 MAINTAINERS                                   |   6 +
 arch/mips/boot/dts/realtek/rtl930x.dtsi       |  13 +
 drivers/spi/Kconfig                           |  11 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-realtek-rtl-snand.c           | 405 ++++++++++++++++++
 6 files changed, 495 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9301=
-snand.yaml
 create mode 100644 drivers/spi/spi-realtek-rtl-snand.c

--=20
2.47.0


