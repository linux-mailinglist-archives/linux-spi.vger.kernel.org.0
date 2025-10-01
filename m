Return-Path: <linux-spi+bounces-10383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BE8BB021C
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 13:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686933C0597
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 11:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7894E2C3261;
	Wed,  1 Oct 2025 11:26:15 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EF52C237E;
	Wed,  1 Oct 2025 11:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317975; cv=none; b=FVYjHPZY823d3Esfhy0/Lsy6hp9gdRvK9McDfv3yateudLqy7MCLqwboj+JZqSyCTzfeECtEJGvh2BIC0DlKuE+P3oD4OVpI0rzbHz9SFbUtCrOl4YfU3cdnC8M0zDldo+rxHSkf2XhpGWGVgXyKUPLfW1QEQrmspgzGnWnugAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317975; c=relaxed/simple;
	bh=88hrXoPV0DHfKnH2ogvQdgVfKF7ZEDvWEFx7rOVzsZc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qbo48j/B7egeQ5ZZdlsi/pnPayjCDsiEsImiIoWsI0Z4XfRkHBIPJ1ZVh4pC7JgKE24ymS/qWV3X3EcbCddC6hHgegGZpcqmzaf2GV9V+k0Z0eUcbznzhRsA7OK8crbvz9QGTOuF2A3XO+dLuUj69cVzOuFADZAiWREOHOvMfjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Wed, 1 Oct
 2025 19:26:05 +0800
Received: from aspeedtech.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Wed, 1 Oct 2025 19:26:05 +0800
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>, <clg@kaod.org>,
	<broonie@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <openbmc@lists.ozlabs.org>,
	<linux-spi@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH 0/6] spi: aspeed: Improve clock, timing and address decoding logic
Date: Wed, 1 Oct 2025 19:25:59 +0800
Message-ID: <20251001112605.1130723-1-chin-ting_kuo@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

This patch series introduces several improvements to the
ASPEED SPI driver, targeting better stability, compatibility
and, flexibility across multiple ASPEED platforms.

Key changes include:

* Clock selection strategy update
  Improves fallback logic when timing calibration is skipped or
  fails, ensuring reliable boot behavior.

* Timing calibration enhancement for AST2600
  Replaces the previous "first-pass" strategy with a more robust
  algorithm that selects the optimal timing point.

* Default address decoding assignment
  Ensures each chip select (CS) has a valid decoding range during
  probe, avoiding detection failures due to missing or incorrect
  bootloader setup.

* Centralized address decoding management
  Refactors the decoding logic to centrally assign address windows,
  preventing improper trimming and improving layout flexibility.

* Per-platform decoding adjustment
  Introduces platform-specific `adjust_window` callbacks to handle
  platform specific hardware constraints for address decoding range.

* Selective memory mapping
  Optimizes memory usage by mapping only the required address window
  per CS to avoid exhaustion.

Chin-Ting Kuo (6):
  spi: aspeed: Update clock selection strategy
  spi: aspeed: Improve timing calibration algorithm for AST2600 platform
  spi: aspeed: Force default address decoding range assignment for each
    CS
  spi: aspeed: Centralize address decoding region management
  spi: aspeed: Add per-platform adjust_window callback for decoding
    range
  spi: aspeed: Only map necessary address window region

 drivers/spi/spi-aspeed-smc.c | 644 ++++++++++++++++++++++++++---------
 1 file changed, 489 insertions(+), 155 deletions(-)

-- 
2.34.1


