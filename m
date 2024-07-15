Return-Path: <linux-spi+bounces-3855-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867349312D2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 13:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B49F21C2212A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 11:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AE1188CA6;
	Mon, 15 Jul 2024 11:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rZCQIu2Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE013D8B1;
	Mon, 15 Jul 2024 11:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042088; cv=none; b=YQEmvTGHuV2rq93x828oi69cS4vhbDs01RYBp5yH3M/QutXEmbBXtbOaXaSE1K1DkEwDvaFgCkg0QKL0dhM5YhgAnNUG673Ocz7y34Qw1z6OXXEh6P/0anQIhGcbnAJ26exX2tM0v8GV4HUT7jY9pCloz3Y5ofJK1V20lVP/8mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042088; c=relaxed/simple;
	bh=Gp+2UHDwqlcu36GwJc/06OLXeLVdP9lzbpNxtv4G8No=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSc8YGkmuyxpmfi84cg3vJzr9yFHB8yaO+PocO+np+j9g5xNkrjS7k2zyUrmTp5RzAsJ+Di+qpAJmXtc0at/CSJIhozV7i5QNOsWkFr2H3/rQNUePsHun/VqYKbSM5Joad6j50TKSFV0ZbVmwwHhU9OJHTALgEoJxSJGhunZC9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rZCQIu2Y; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721042086; x=1752578086;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gp+2UHDwqlcu36GwJc/06OLXeLVdP9lzbpNxtv4G8No=;
  b=rZCQIu2YIo7o+LyDvz+LnvqmSuZQLfF0j8bIaH1zz+c8b9VzJ68mdwwT
   U+v1HoZan8lnUqMRWM+6ZgI/Y0j3oxwgXib/+DQ9ZK9wjZYMh7TLaizmj
   jnnW37u0VijQRx7XHFoa85X3DpeiLbGY69MJQwxu75yUdOvbT3PqC5E4/
   sjM+8QUjtUYEllUpyxYXjBnhzuRr6qihITzMEw9T1pSx3D096szSFdGJ0
   vFVEiFF1cboDE25oMxo7cgIpRZI8Gj0aPyOYkF+ihfwKuUQyCwjZOmM/q
   bakXG7uglZkfqPEnfjecmcQRpyi5y103R/IkJOKNBc8m7be7qKltUPc05
   w==;
X-CSE-ConnectionGUID: M47IHorFQcORQBAq4muecw==
X-CSE-MsgGUID: /InWMObERHevghgSCmH3UA==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="196643516"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 04:14:45 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 04:14:27 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jul 2024 04:14:26 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-spi@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Steve Wilkins
	<steve.wilkins@raymarine.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/6] spi-microchip-core fixes & variable word size support
Date: Mon, 15 Jul 2024 12:13:51 +0100
Message-ID: <20240715-retail-magnolia-bbd49a657a89@wendy>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=Gp+2UHDwqlcu36GwJc/06OLXeLVdP9lzbpNxtv4G8No=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlTWQq4jcVivK74uu5RPH73+bGonctYKye+nnXp11Z9w1ee 03c5dZSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAixlUMv9mNmTNsMqSl7a+lL/JVPZ T1wdzTtq1Of/Lak0wCgYt4HzIyXNWxeSvQnPFKTuP/hOOe1yzip1y/d8hLQNd1n26ZpZw8FwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hey Mark,

Got some fixes here for the spi-microchip-core driver, that I am passing
on.. The author of the first patch is no longer at Microchip, so there's
probably gonna be some bounces on the series. The remainder of the
patches got sent in by a user, and, other than one patch, I just wrote
commit messages for those that were missing them and rebased the series
on top of mainline.

There was one other patch in the series submitted by the user to us, that
I opted to drop, adding locking around accesses to tx FIFO in the
interrupt handler and in the transfer_one implementation. I think that
patch is not needed after the first patch in this series since there'll
be no contention any more.

Cheers,
Conor.

CC: Steve Wilkins <steve.wilkins@raymarine.com>
CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Naga Sureshkumar Relli (1):
  spi: microchip-core: fix the issues in the isr

Steve Wilkins (5):
  spi: microchip-core: defer asserting chip select until just before
    write to TX FIFO
  spi: microchip-core: only disable SPI controller when register value
    change requires it
  spi: microchip-core: fix init function not setting the master and
    motorola modes
  spi: microchip-core: ensure TX and RX FIFOs are empty at start of a
    transfer
  spi: microchip-core: add support for word sizes of 1 to 32 bits

 drivers/spi/spi-microchip-core.c | 190 ++++++++++++++++++-------------
 1 file changed, 110 insertions(+), 80 deletions(-)

-- 
2.43.2


