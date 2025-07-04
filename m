Return-Path: <linux-spi+bounces-9053-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD41DAF97FB
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 18:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956A57B0A7A
	for <lists+linux-spi@lfdr.de>; Fri,  4 Jul 2025 16:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024FF2D5A09;
	Fri,  4 Jul 2025 16:20:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB132BE055;
	Fri,  4 Jul 2025 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751646047; cv=none; b=X8Da55vAi3QsWA5IiwQXxARIiSuHN7MCHPwG+EHuhLfjIkIV82TWXz6EvXougfMFjFSdMh4+nVbD+WoPOD5YpUm93NyqFQaCmJeC/Ujz7qJb2svfPJqs+02c/6tdVkM6gKBNMobryx3ad7CHPkh0ye9DnWrhbGCxPeyHueSStDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751646047; c=relaxed/simple;
	bh=j/5w012QmGOXyqU39HbSABjHbhMyZQ+b5yuLbXTZ8tU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SOQn4SZsQFe/A/N5FfOBaacejujb68gORPbnBv1eH00DWzXrnFkJFXZ9mLnt3v0DvhpNUr3n6qiFje/0s0uUpZVzk5HW/1UvCvvCnxz9RFPUbFmFbCnEYgcJ0QCPQzRq1RA8iC82TRSwIF3DV0Kf1gb1riEhLYow0k366Ykg2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: J2OZpv9IQIOZ0aPg2Jr+5Q==
X-CSE-MsgGUID: yf8z09SMRji1FMDAlktTRQ==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jul 2025 01:20:43 +0900
Received: from mulinux.home (unknown [10.26.240.6])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 1558D401DDF3;
	Sat,  5 Jul 2025 01:20:38 +0900 (JST)
From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/3] Add RSPI support for RZ/V2H
Date: Fri,  4 Jul 2025 17:20:33 +0100
Message-Id: <20250704162036.468765-1-fabrizio.castro.jz@renesas.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear All,

This series adds support for the Renesas RZ/V2H RSPI IP.

Cheers,
Fab

v1->v2:
* Addressed build error reported by the kernel test robot.
* Addressed comments from Biju in driver patch.
* Addressed comments from Mark in driver patch.
* The clock patch has been accepted, therefore it's not been included
  in this version.
* The defconfig patch has been accepted (pending acceptance of the
  driver), therefore it's not been included in this version.
* The device tree patch has been accepted (pending acceptance of
  the dt-bindings patch), therefore it's not been included in this
  version.

Fabrizio Castro (3):
  spi: dt-bindings: Document the RZ/V2H(P) RSPI
  spi: Add driver for the RZ/V2H(P) RSPI IP
  MAINTAINERS: Add entries for the RZ/V2H(P) RSPI

 .../bindings/spi/renesas,rzv2h-rspi.yaml      |  96 ++++
 MAINTAINERS                                   |   8 +
 drivers/spi/Kconfig                           |   8 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rzv2h-rspi.c                  | 466 ++++++++++++++++++
 5 files changed, 579 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
 create mode 100644 drivers/spi/spi-rzv2h-rspi.c

-- 
2.34.1


