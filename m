Return-Path: <linux-spi+bounces-9287-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BE0B1B1E5
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 12:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2695180742
	for <lists+linux-spi@lfdr.de>; Tue,  5 Aug 2025 10:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E3521D5BC;
	Tue,  5 Aug 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KqmKzVQg"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7169156237;
	Tue,  5 Aug 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389543; cv=none; b=So2xtMZjCIxW8Cjrmoo0EcSt/heUYvpdTvTXCCe+ganN07ghBW8ZJVhW5UUVeQ0KvCPKfmZZMMbAKknlK3JXgK2j3wxexDtNB3mv6gbBY5C2LFAbJJKNOkV7ManS3StkpLjIvoEO3x9E0J4TaSmSfAZ5g68wmrYLXvHRgdgQq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389543; c=relaxed/simple;
	bh=/hLTx8DnHTD5nKVwpN/tqzkn2H4ZOTqkf/3P6143jtk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X9dqpPAJ67LiZj7OR1pdQTpLLLoMZE1Uiu1+Afitru4SpAn48495u7vmgwy/Jaf7rjj22Lf/0VhauEGKHpIXGbsC2Q7LJKdwhd1NaxnHtiovuLFKQcEnY/5EXQndEDD1tUJO6elW/3wY3tDhyTBeHQ5y0OZCHm2ITL6jq6cIuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KqmKzVQg; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1754389541; x=1785925541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/hLTx8DnHTD5nKVwpN/tqzkn2H4ZOTqkf/3P6143jtk=;
  b=KqmKzVQgZXWCcm7G6MLXznQcuB9WR+4rmqFJomM3ivf4kT+M5ZiAMkA2
   x4B7vmVnQTEYHnXvB0lyb71ePwIvePVmL80mG7ImtcLkdcNyIfWFUKlhk
   Ur24MWgn1uAw/SIuoyJv8NcF36aHvQJXlaITYT/SIravOt3fhEIa84wtw
   jp17Q6/Fna8OhQFe2p80GT47SXdGzlNNu8MLKMxlkSqND5Z3aa5UFaX3h
   yb1yfzgzKxVJ0vCgKLwz1VteQQWhLfPd3BpYi0m4obeSG7OZvIFmbkzi7
   F+BvtRV4QJDKk16ibT1WgKRaZKczkgg8JT6P+p8KIx3gVQhf/BJ/L4VtH
   g==;
X-CSE-ConnectionGUID: CC5+32jcTAyMHulNICypyQ==
X-CSE-MsgGUID: aRRWOeUKS3em5aoeRe+qYw==
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="44291422"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Aug 2025 03:25:35 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 5 Aug 2025 03:25:29 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 5 Aug 2025 03:25:24 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<ryan.wanner@microchip.com>, <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH v3 0/3] spi: atmel: Add GCLK support and simplify MR update
Date: Tue, 5 Aug 2025 15:55:07 +0530
Message-ID: <20250805102510.36507-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

This patch series introduces support for using the Generic Clock (GCLK)
as a clock source in the Atmel SPI controller, and also includes a small
cleanup to simplify MR register handling in cs_activate().

On platforms like the SAM9X7 SoC, the SPI peripheral clock can run at
266 MHz. This can exceed the maximum value supported by the Serial Clock
Baud Rate (SCBR) divider, leading to SPI transfer failures. To address
this, the Atmel SPI controller can use an alternate clock source — the
Generic Clock (GCLK) — for SPCK generation.

--------
changes in v3:
- Add cover letter
- 2/3 - add explanation for the spi_gclk addition

changes in v2:
- 1/3 - Fixed mail threading
--------

Manikandan Muralidharan (3):
  spi: atmel: simplify MR register update in cs_activate()
  spi: dt-bindings: atmel,at91rm9200-spi: Add support for optional
    'spi_gclk' clock
  spi: atmel: Add support for handling GCLK as a clock source

 .../bindings/spi/atmel,at91rm9200-spi.yaml    | 11 ++-
 drivers/spi/spi-atmel.c                       | 78 ++++++++++++++-----
 2 files changed, 66 insertions(+), 23 deletions(-)


base-commit: 7e161a991ea71e6ec526abc8f40c6852ebe3d946
-- 
2.25.1


