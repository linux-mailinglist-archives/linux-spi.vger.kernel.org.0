Return-Path: <linux-spi+bounces-5116-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0807B99224E
	for <lists+linux-spi@lfdr.de>; Mon,  7 Oct 2024 01:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17D71F21534
	for <lists+linux-spi@lfdr.de>; Sun,  6 Oct 2024 23:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A4D18C000;
	Sun,  6 Oct 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="o29KZBAt"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382FC18BBA2
	for <linux-spi@vger.kernel.org>; Sun,  6 Oct 2024 23:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728257637; cv=none; b=jen0VUnG1K3YCW0h5pjMw7KJXmM48WHu6U39OZjcCikqJEUE7DKXNKBYu3/eXfbPNEJkae6C3QQvl1QCZJQw5epdvuSbJS6ayEdADUPORTL3YDthNIYjUvt8IWCD7mosbHjq1/BF/wufjpeyg8Pa/vKNGTfzomkZYajuqNd/epM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728257637; c=relaxed/simple;
	bh=TkD+Y0Pncoiz7ajkmYLhaybPDXJd4qAAxmW73vp2xsU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kxK3Oyo57Ueq3SMb1aF4Jl9QyrActFBN48o8ITn5yAX0XXW5Wt/xFMswU1dcbou59sblx1/ohiS5cBXIByV/loWU5kDZYjRbFRaNIe75vfqWU58uLCUIJ2ny1kX611CT6ArXo1cKcBn6M72+zAsAKNgCuL8jla6CpkmlvMqsrU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=o29KZBAt; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id ED1832C011D;
	Mon,  7 Oct 2024 12:33:51 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728257631;
	bh=OTnLUB/QvEU3ox85j54rCMUtfZT/2XO84th1FGXFSAI=;
	h=From:To:Cc:Subject:Date:From;
	b=o29KZBAtshy+Y87mIDQeuYt+gJf1LMIGKTIjZJo0Azc48JJmf1JSd8jAPx5MWcr9t
	 pFWu78j7eMvHt8Nq2oEu/zK0ncpQKj+TiRGsDQzy6NG8bH3XVg27efxRt6ACbY2+aM
	 Zbx0B0WtEly1MsLSvdm8z9AmBzrKTDNmzu2OX66E1hNOnWnwhqtkqEYYqafT12qZJn
	 0OWdmsDJdVXP6H+djNnIccX5saTf18/DzAm8sCGRQq0/ObKmLPuXRLWgMCez9cuY2P
	 5869Eii4b/xFufuBazzSf9Sc9JL90XyLNizT6r0++W1+My6t3NKKlKX31ugS43j0ik
	 WC/LC9b7gDLKw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B67031e5f0000>; Mon, 07 Oct 2024 12:33:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id B2C0213ED6F;
	Mon,  7 Oct 2024 12:33:51 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id B0C1C2809AD; Mon,  7 Oct 2024 12:33:51 +1300 (NZDT)
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
Subject: [PATCH 0/3] Realtek SPI-NAND controller
Date: Mon,  7 Oct 2024 12:33:44 +1300
Message-ID: <20241006233347.333586-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Id0kWnqa c=1 sm=1 tr=0 ts=67031e5f a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=63fhtx2pClmO-oMQzGgA:9 a=3ZKOabzyN94A:10
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

 .../bindings/spi/realtek,rtl9300-snand.yaml   |  58 +++
 MAINTAINERS                                   |   6 +
 arch/mips/boot/dts/realtek/rtl930x.dtsi       |  12 +
 drivers/spi/Kconfig                           |  11 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-realtek-rtl-snand.c           | 408 ++++++++++++++++++
 6 files changed, 496 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtl9300=
-snand.yaml
 create mode 100644 drivers/spi/spi-realtek-rtl-snand.c

--=20
2.46.2


