Return-Path: <linux-spi+bounces-6712-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E58A2EABA
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 12:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489E91883A26
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A0A1DF960;
	Mon, 10 Feb 2025 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="QI/aT7t/"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19281EF1D;
	Mon, 10 Feb 2025 11:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739185820; cv=none; b=hS8MX2/pbb/1rgwFl2SlRcw/XATvEAvHgdvm0YpMTW7kngHKxwQSsCu2fDcyviim0/qptbo5rEPsY9PzoWKP+SBhSUb3dxwlpizM95vPjkXbeD/HUeGcKyng+yhh1yy6AjfCHz/69tkWogl0DZPNtewVndmP2gm3RdAM5fHR94E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739185820; c=relaxed/simple;
	bh=VDiIUf3hSRXCXLXCrJZy53jmb5EAldDkUmcpks1+V8s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jDuR52B0o+SR9zyoIoWS+rWminX8KCZ6apofEWwBgiychICh2jV9mOYUywulowa4ekPyUUfV6dzSa6lK4OFUYykC2OVnAdfmhRqJTAz/N+31wR1v9r/5LW/OzukJUDIkdJJZ4fYWQ/8dAB6bCy3CM8G/sNQ8rhZpLAEaQw3PIeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=QI/aT7t/; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 14CD1A0748;
	Mon, 10 Feb 2025 12:10:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=2zJoI4zUhnQFWnhkAmCA/G6I5XpawwTFf8gjoo1QOYE=; b=
	QI/aT7t/diqN7H9jybwNT2W3yN4oxmBwNbPh3vYnTLj2R4D0FHQx7ZOM3MfV6/Um
	j6YP8qzSxoahWnlYZjXhj+h8e8ksVUcMNA1d5Lt3l2L59YvtI7jkw6wn263c7rsx
	pxLtzpY4cXg/tHXgVPJf1O3+vlMDrnqHgssw6R9yArCCs4tZ1b4mIt+9AFujgxuZ
	/Aq9fbv4Jt62FS4SLsAjhOv9pKkdVx0lcBF3kh4GthEmt42T1FcrNoKRIbKUdvjn
	Ikm8yGUNAOCwuBlYIHPeWeXwPBRmy5e6Uu+lM3jNUpT5RUlk0mMXpLspSPXvsqKN
	c91NjQpWs/qfGMedAkszrLOcDIikTJFSUa5neFsaE4PzPMx8cvWhHxptbvVQdlTW
	RAaT764DEC6mvLy/d7rocaJXC85bq358RxQq75GiRKAggoxka0ZVK9+qxevEd+sA
	wyPSII0IWnYl7RRe7JJz4P6HUJg5zN6QJaRzFBuTe1VzE5PaW4W7DPfd0bIoJm/g
	9dw67GwjmHmOMNAMs3GK+Q+FB9ZVPtl4VAga4DbKpDcZS6pFcgBb+Qlwg8B1/D36
	qCGs8Ma0sAWAiDEMdtKHTQcIYNybvtlwhgLTIFJ2xo6Ak4u4K/7Z14Rqp7rRJ89b
	x86IZF7S2iFUyug1ZreAZYfr3gusurix7bsUCBM+NMM=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	=?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>, "Varshini
 Rajendran" <varshini.rajendran@microchip.com>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Mark Brown <broonie@kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, Alexander Dahl <ada@thorsis.com>,
	"Nicolas Ferre" <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH for-6.14 v4 0/2] Add more devm_ functions to fix PM imbalance in spi/atmel-quadspi.c
Date: Mon, 10 Feb 2025 12:10:05 +0100
Message-ID: <20250210111008.248929-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1739185812;VERSION=7985;MC=1898231991;ID=637647;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A29ACD9485261776A

The probe() function of the atmel-quadspi driver got quite convoluted,
especially since the addition of SAMA7G5 support, that was forward-ported
from an older vendor kernel. During the port, a bug was introduced, where
the PM get() and put() calls were imbalanced. To alleivate this - and
similar problems in the future - an effort was made to migrate as many
functions as possible, to their devm_ managed counterparts. The few
functions, which did not yet have a devm_ variant, are added in patch 1 of
this series. Patch 2 then uses these APIs to fix the probe() function.

Change in v4:
* the DMA cleanup was split out and will be submitted separately for 6.15

Links to previous versions:
pre-series:
https://lore.kernel.org/linux-kernel/20250114222851.1023194-1-csokas.bence@prolan.hu/
v1:
https://lore.kernel.org/linux-kernel/20250115160244.1102881-1-csokas.bence@prolan.hu/
v2:
https://lore.kernel.org/linux-kernel/20250124085221.766303-8-csokas.bence@prolan.hu/
v3:
https://lore.kernel.org/linux-kernel/20250207124802.165408-1-csokas.bence@prolan.hu/

Bence Csókás (2):
  pm: runtime: Add new devm functions
  spi: atmel-quadspi: Fix unbalanced pm_runtime by using devm_ API

 drivers/base/power/runtime.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/spi/atmel-quadspi.c  | 18 +++++-------------
 include/linux/pm_runtime.h   |  4 ++++
 3 files changed, 45 insertions(+), 13 deletions(-)


base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.48.1



