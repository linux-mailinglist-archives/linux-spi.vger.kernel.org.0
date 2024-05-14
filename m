Return-Path: <linux-spi+bounces-2841-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915F88C509B
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 13:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12E42817DC
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 11:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E29413DDA6;
	Tue, 14 May 2024 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P6bGh7JM"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1ED5B5D3;
	Tue, 14 May 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683517; cv=none; b=T96MbkGgIAXwAYcewg79wIUWMo+j1+edTLpJBWHlSNylV/uy7zu2AvgWtm71wbGm/LNwHVaeN2Av6HUHzXGsAzyEowtsOSK18/rPEA7RyFSGRuo48ZsMV01Wh+C+m/oNs4c2v/gOo9EiCz/9Ad9wPVA0RlXyghsnNh224A1LQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683517; c=relaxed/simple;
	bh=0/gq0Od8tn/NFYb5S2ybhGqd4qamz5PoX4ti0poIl0c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Zx5JQ/TWGwoglrcbITFxobcHoPeCp/JaHdPzXHjzCfb81m7SmHOkDTZS24tZFol956ULI9xOJEXexkdkOr+rOJuNVEugro6ArMpgz0f+Cqkk3N0ZqbXL7rvSQbKrzL2QpknvFqhzsLbj5NnwfxuPt5BBXdyUa0/DtZQqqKMaNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P6bGh7JM; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1715683515; x=1747219515;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0/gq0Od8tn/NFYb5S2ybhGqd4qamz5PoX4ti0poIl0c=;
  b=P6bGh7JMyhhiHz25n/SZooK7/F13H88SkzDZCGfd3QDhQTHYt7KSaQHG
   J3XWz4achL+9gz1EMHVH2tRNcbxEDJi1RZHnDjfV28NFR4T0iJK/CL35o
   LlrWju6KLr/WY47VmoVR91o+zombNTp/qYXxulhJXbmY4PlOiGNeAUi2r
   yJELS3kBZUfaznWXwKf6hkCMhV4DDriAGf0RN4w+PV0Qbv5U1I70/x+2I
   95vnlqJ29Y2ndHnCfDB3yNUtO6jJB8QLXKovScwKQvfmR0ESdqomjKx4X
   KzwrjwjFpbBvXYsDESiTpBTBr0RiEDq0Jz5M0J1bFkrwEKmXFzVS9XWGq
   w==;
X-CSE-ConnectionGUID: CRVhllyDQl2XuPQNxlB5Rg==
X-CSE-MsgGUID: p33gXK/ZR+6lRZgA3nAYjw==
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="24625779"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2024 03:45:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 14 May 2024 03:44:53 -0700
Received: from Lily.microchip.com (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 14 May 2024 03:44:51 -0700
From: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
To: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	<valentina.fernandezalanis@microchip.com>,
	<prajna.rajendrakumar@microchip.com>
Subject: [PATCH v2 0/3] Add support for GPIO based CS
Date: Tue, 14 May 2024 11:45:05 +0100
Message-ID: <20240514104508.938448-1-prajna.rajendrakumar@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The Microchip PolarFire SoC SPI "hard" controller supports eight 
chip selects. However, only one chip select is physically wired. 
Therefore, use GPIO descriptors to configure additional chip select 
lines.

v1-> v2: 
 - Modified all commit messages for better understanding
 - driver - added spi_is_csgpiod() API to address review comment
 - bindings - fixed bindings to set the default value of num-cs

Prajna Rajendra Kumar (3):
  spi: dt-bindings: Add num-cs property for mpfs-spi
  spi: spi-microchip-core: Fix the number of chip selects supported
  spi: spi-microchip-core: Add support for GPIO based CS

 .../bindings/spi/microchip,mpfs-spi.yaml      | 29 +++++++++++++++++--
 drivers/spi/spi-microchip-core.c              |  6 +++-
 2 files changed, 31 insertions(+), 4 deletions(-)

-- 
2.25.1

