Return-Path: <linux-spi+bounces-5221-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD399BD73
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 03:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97077B21777
	for <lists+linux-spi@lfdr.de>; Mon, 14 Oct 2024 01:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F6827470;
	Mon, 14 Oct 2024 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="ZA9QVnWI"
X-Original-To: linux-spi@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6936817BD3
	for <linux-spi@vger.kernel.org>; Mon, 14 Oct 2024 01:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728870777; cv=none; b=YkBMNlNrKDZ5S6lYgE21qWfGLytr6udEosS/XW6D3oGaHgAnw7xFqGSjAmbJ8vau54iPoux62pW7rRyXe23hIV257EHpaBr3VwpkkAUzNALkQGabv1FPffKoyEpCjQgliXOnd0xgWfDaNjUVKKfdfecOr2PsSVjWc1NUovjJkcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728870777; c=relaxed/simple;
	bh=ClyJf77WMwJhYRtlV65bUUfuTqGqXSG85K7TOdYkVJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZfpaQm4TWe+7CmigJW4pCs83D+3frqe8XRVskGu297D4jSFv0NbLgekn8Wgw7YWeKKi2nH2x4mi/Ac/MzIZkdTgFbkmzReI/N43SqaEZzPpl4zHqX4xKWGGkUC5MCB0gM2KUQ8zIAc1U4/ZKncmB6OaBIhwxz6g7ylnklbg7ANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=ZA9QVnWI; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DC76C2C0404;
	Mon, 14 Oct 2024 14:52:51 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1728870771;
	bh=a5ssNrOQTXajXVF6sjA3PEFxVHVs7LZ+OAyyPL5DsL8=;
	h=From:To:Cc:Subject:Date:From;
	b=ZA9QVnWI/0nft9C4QuWSu3dwd+3u8+N/BkjTM/BrPbeYnZXbM+NWaTQhmUfa7Mfx0
	 pD8LaXh2G6AMzJq6BgMv7LodvTiebg4U35N/qyNVBBShor68G6QJkigGzGYNR13ZCH
	 MdQ8LMkxeNyOtbnD1tx2qG35Bg8ERtNWEgCXBgvophrheD4R0KTsmw6xLGv/XJBozd
	 ofbc0sfVBpK8CDRaEfTugREVj4j2Qs7XWntAe4YIhZyCD014sz6IXNzeF9KDwTixEd
	 eCgwrwwSZU0dWhZ0XAPo/iTNEhIHcIrWLln1XWDbh98rqo6H0w91gqoQXqK4lsCYnU
	 61BbAIADiCRPg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B670c79730000>; Mon, 14 Oct 2024 14:52:51 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 84F1813ED7B;
	Mon, 14 Oct 2024 14:52:51 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 836202806F1; Mon, 14 Oct 2024 14:52:51 +1300 (NZDT)
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
Subject: [PATCH v4 0/3] Realtek SPI-NAND controller
Date: Mon, 14 Oct 2024 14:52:42 +1300
Message-ID: <20241014015245.2513738-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=ca1xrWDM c=1 sm=1 tr=0 ts=670c7973 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=DAUX931o1VcA:10 a=63fhtx2pClmO-oMQzGgA:9 a=3ZKOabzyN94A:10
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
  dt-bindings: spi: Add realtek,rtl9301-snand
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


