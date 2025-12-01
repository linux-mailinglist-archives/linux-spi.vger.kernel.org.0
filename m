Return-Path: <linux-spi+bounces-11681-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEB9C97AA4
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F0AD4E1725
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12D8314A82;
	Mon,  1 Dec 2025 13:43:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD353148D6;
	Mon,  1 Dec 2025 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596605; cv=none; b=CO2Vi9GVJrwEBsC51aTTPOp70Miyg1HfhsEg9lm1wijEt8H3ZfsgX5AIyLbd1jvZDoSgK//A1n3/uZ+2Tn2D1GNCBDfwTnU7V5PzFwHJRFSKFdcXvnlzowbdMv8EFw8ia+l6m9yjVcTqnsj5ODJ7XPpzjVO7a4tkmkrXYRpWz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596605; c=relaxed/simple;
	bh=Fib4tjZyVTB7PnpP79JySpsl6fr2rviiZtpD1YJeTpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FfjRxj/YjUxNqgJFkinQT6cBXr64CIi80fWSGzqTNi56BIMcTnM0Si+rGeAtw4MJYWjMi8YNoFhrwMNamHPz2wDytK/VoTf84/Tr/GFxVTiy1GJoEjHK5Te5PkHnoryDd90m3KvlaF0lwd6beclVWxyDPk2hIfPT2GZ9BPLqBBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: kI/GulQJTuiQStPNoI1fAQ==
X-CSE-MsgGUID: sQGvT46lS4G3QuNm8Wvpnw==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 22:43:23 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 28D594215A4E;
	Mon,  1 Dec 2025 22:43:18 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 01/13] spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
Date: Mon,  1 Dec 2025 15:42:17 +0200
Message-ID: <20251201134229.600817-2-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing space to align to open pararenthesis.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 1db7e4e5d64e..8cffc9cb6b6b 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -225,8 +225,8 @@ static int rzv2h_rspi_receive(struct rzv2h_rspi_priv *rspi, void *rxbuf,
 }
 
 static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
-				  struct spi_device *spi,
-				  struct spi_transfer *transfer)
+				   struct spi_device *spi,
+				   struct spi_transfer *transfer)
 {
 	struct rzv2h_rspi_priv *rspi = spi_controller_get_devdata(controller);
 	unsigned int words_to_transfer, i;
-- 
2.52.0


