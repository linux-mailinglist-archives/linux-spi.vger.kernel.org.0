Return-Path: <linux-spi+bounces-3763-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCD5928B54
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75397B25553
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA215FA60;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJt5Pav5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3113C8F9
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192367; cv=none; b=njKGAP2T52PjXr/6yjdlWHbWaGc7dQOlBnp4kmcsOI9cVv47zDdHZ+1dhO0Y3E8ct1DiCZ2+zEI1hlE/f33QzGIruUTeSdzOLGRyUlvPxisrHqwXz5uACAZ+0cnRmewNAzW2IfgMFvPJXsAfyz3N6R3ZK/LZ/1HMPhDAuJSPQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192367; c=relaxed/simple;
	bh=YsQxoqRb0qm/DMyEY5p3KivTlb4LK+jdMPeUhUZ8Q+8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PsJ9Mcug3tt6/zu4So8UqCBNGQ3iYJprS/xB8nBP033sxmSMoZ8Jf580B4iLKMyADRwTFppkKOkidO1jmwRzHFM2q94IQwRRCggnVZVIqchgNzpa4gk6rTX8h6LjWqKVgTKpG3BS0g6472rMv1gVpG56i3yH123meNERSTg99b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJt5Pav5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 375E0C32781;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720192367;
	bh=YsQxoqRb0qm/DMyEY5p3KivTlb4LK+jdMPeUhUZ8Q+8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ZJt5Pav5jD7C8LRZtjbm8Yr6BXeVv2WoY+8x8q+oDNyU3xbghPMYbIKcR8hunErJD
	 DVkmj1qU+4FOej/OlHJ+pqDm9ZvPUmVmVOCh7fZoXbARTeopB+3VqOt2KCHbFc1MF3
	 fzNclwVzMDgZGq4WW3ps750jn2baBz+WdPqlMKb97MzPZFNcUfUDZidmYUx9Q2DIc7
	 jrqNNtv54Q+BSYQPw9lXo6CB+apG58ssy5+jeGfSQdYoUAi/DORV8b/iOoEG4l5tri
	 9ilq9PiFXhM9tMFWE8FpEMJoPnyahs0dBILpyHbgRFXkLNppspHGS+TySTEC4GJZVw
	 TAnydVmuCYInw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC21C3271E;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v2 0/4] spi: xcomm: support GPO pin
Date: Fri, 05 Jul 2024 17:12:38 +0200
Message-Id: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGYNiGYC/x3MTQqAIBBA4avIrBtQEfq5SrQInWoW5aAgQnj3p
 OW3eO+FTIkpw6JeSFQ4c3w67KDAX/tzEnLoBqut06N2GKhgFsbq433jKRz9xYKTMc7P0+wOPUK
 PJdHB9R+vW2sfKeDC4WgAAAA=
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720192365; l=690;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YsQxoqRb0qm/DMyEY5p3KivTlb4LK+jdMPeUhUZ8Q+8=;
 b=hRo5JyF/I8Qao5LUJV5XUlrBeaiBcWKxlX7Z9yZHZuNoD1mOI2MXulRPFcaXNWWFJbc2f8A4N
 /VrRGlHbhV3CTeD2Dl7M9lZ0J5vZJy18GLtKjSj9ZE3v/hEPRHTkWFX
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

Here it goes v2 without get() support.

v1
 * https://lore.kernel.org/linux-spi/20240704-dev-spi-xcomm-gpiochip-v1-0-653db6fbef36@analog.com/

v2
 * Remove get() from gpiochip ops.

---
Michael Hennerich (1):
      spi: xcomm: add gpiochip support

Nuno Sa (3):
      spi: xcomm: make use of devm_spi_alloc_host()
      spi: xcomm: remove i2c_set_clientdata()
      spi: xcomm: fix coding style

 drivers/spi/spi-xcomm.c | 75 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 18 deletions(-)
---
base-commit: 56b6e631686eacbaf1970043027aadafea2b8438
change-id: 20240704-dev-spi-xcomm-gpiochip-8114c9894f07
--

Thanks!
- Nuno Sá



