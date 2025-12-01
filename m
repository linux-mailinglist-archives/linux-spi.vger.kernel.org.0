Return-Path: <linux-spi+bounces-11682-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD53FC97AAA
	for <lists+linux-spi@lfdr.de>; Mon, 01 Dec 2025 14:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C043A237C
	for <lists+linux-spi@lfdr.de>; Mon,  1 Dec 2025 13:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6814F313554;
	Mon,  1 Dec 2025 13:43:31 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD491313534;
	Mon,  1 Dec 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596611; cv=none; b=bP3N8S41pceeDcoX4P8QJOibiixS89G9r3D8UVmhOAeOshHwxYCgOGAGhO4fIHduviXzRLKrhhsSnYteG48OQGwwnddUYiw/F4hKF0GcONUuLQzeE4aNxk6gTJ00BHXJI6HqcAEoI9RwKGcaKxnW4kJqQKLNNfLLFx+O0pR63GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596611; c=relaxed/simple;
	bh=Wy33NiifHsGZ2jBbQSNKzWdZMQQXU0K2+FtJ2agEbVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cX/y6cCnmjRCx2GcM2PmboAOjE0B53uHz2pfts3t+q9GdjdCxxhN6jsJnteA8VbK7W2h921SalcT/dL4QhJGbfgVGrY+UCzf9ZoGEuZm9r52NvzICnqpbh/mLK4vm+F/RmzDBJyx6K386ssI/dEKIH4dA1tWN97WQJzX/LgcPV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: rKpREmTeQ92SHgn3gB4ayQ==
X-CSE-MsgGUID: KZM1urBQR/KJH1t374WmMg==
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 01 Dec 2025 22:43:28 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.83])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 61F654215A52;
	Mon,  1 Dec 2025 22:43:24 +0900 (JST)
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
Subject: [PATCH 02/13] spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
Date: Mon,  1 Dec 2025 15:42:18 +0200
Message-ID: <20251201134229.600817-3-cosmin-gabriel.tanislav.xa@renesas.com>
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

A call to spi_finalize_current_transfer() is only needed when the SPI
transfer is completed outside of the current context, when the
.transfer_one() implementation returns > 0.

Since the SPI transfer is completed in the current context, and we
return 0 from .transfer_one(), the SPI core assumes that the transfer
has completed and it does not wait for the completion variable that
would be set by a call to spi_finalize_current_transfer().

Remove the call to spi_finalize_current_transfer().

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 8cffc9cb6b6b..beea4fb83d10 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -250,8 +250,6 @@ static int rzv2h_rspi_transfer_one(struct spi_controller *controller,
 	if (ret)
 		transfer->error = SPI_TRANS_FAIL_IO;
 
-	spi_finalize_current_transfer(controller);
-
 	return ret;
 }
 
-- 
2.52.0


