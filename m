Return-Path: <linux-spi+bounces-3766-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF3B928B53
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 17:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0AEF2818CF
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jul 2024 15:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE7515FA75;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvAHnB89"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7814B940
	for <linux-spi@vger.kernel.org>; Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192367; cv=none; b=d+jTgMRj0sG8gXL7RoDs7hIKid0fs43AbAefNdk1rSBylCTEswJ2G7R+9L7uqaCHlE2xbtdcGt7dbjX8su7mWUWLVrxyCrHSHWxuRRP9ADcrMTU1Wq//h4Xj5JhJgf59OdFdyWDuI2vWQvEi372Ls1c/hJRnu+o94yU9Tk5gpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192367; c=relaxed/simple;
	bh=C3gl2WK1TSzPznrbxiUyJW32vxXqr2qmTN7ggL3NAMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FRohgh+eVn6yg0sshmXqOeiET+CX/biKe3v+EZIkD8hzRK7TRnYYyJEt6mbkcJE3rpOwhULqNmXc7yPfYfaokQacuMOzwT2BjRnkTHmbyIdzzawI8II4DThZhELpqL6Eut6ki2qjBU03THBP1fSQqz3Xkk2wBQqxJrgiv8TyLR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvAHnB89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 682B4C4AF0D;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720192367;
	bh=C3gl2WK1TSzPznrbxiUyJW32vxXqr2qmTN7ggL3NAMk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jvAHnB8907qhKbumFuX8vqMdPGIw+s85MFkGq9RXC9J6uhHhsWEp1vh7r5heH1FqO
	 6WVz1tGlTtReoWZ4lZBUNXV2TfjECsV43r4XTiABvRvMlG4UW6gJpvoQWfsgyvCsbh
	 Kci6uBOWkcVxeiHrdXWKxES394JE8A5kRhlgr++gPg7wBjzTH0Nm3cio/c97m8BN4v
	 o4S1g+RO4h3BBL3+2loPAKdBE0VmBIq+RcidnGyahrwaM8fSzB/dGaazu3d3Wpos3R
	 qEFdW1jOYmcEjCMT6fFbpk2+afiUiHhuuc3lvytEC/bGbg6yczRt7ecR01KdhfXspx
	 pqhKStHrmkMbg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC57C3DA41;
	Fri,  5 Jul 2024 15:12:47 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 05 Jul 2024 17:12:41 +0200
Subject: [PATCH v2 3/4] spi: xcomm: remove i2c_set_clientdata()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240705-dev-spi-xcomm-gpiochip-v2-3-b10842fc9636@analog.com>
References: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
In-Reply-To: <20240705-dev-spi-xcomm-gpiochip-v2-0-b10842fc9636@analog.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720192365; l=719;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vUGNltR14uZYr+gI6pbeIx/V4FQQvYngKNBjnal7db4=;
 b=QMnksO+NgeIlZJm4SjtLwHEjjIEKU9b6RYKXNQWG4OT8MIuBJoNxjOn5FsytaqiixcZY2fZlu
 7kTL7hgbCu/ArFHSp1ZDTkfb8G6ahS5wJmO6EsofmNGw1rR9PhTHTtI
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

i2c_get_clientdata() is not being called anywhere so that we do not need
to set clientdata.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/spi/spi-xcomm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 5bbc250bc0534..1cd7d2b9e11c9 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -261,7 +261,6 @@ static int spi_xcomm_probe(struct i2c_client *i2c)
 	host->flags = SPI_CONTROLLER_HALF_DUPLEX;
 	host->transfer_one_message = spi_xcomm_transfer_one;
 	host->dev.of_node = i2c->dev.of_node;
-	i2c_set_clientdata(i2c, host);
 
 	ret = devm_spi_register_controller(&i2c->dev, host);
 	if (ret < 0)

-- 
2.45.2



