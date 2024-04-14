Return-Path: <linux-spi+bounces-2334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C4A8A438B
	for <lists+linux-spi@lfdr.de>; Sun, 14 Apr 2024 17:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82D9C1C2107D
	for <lists+linux-spi@lfdr.de>; Sun, 14 Apr 2024 15:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292B1134CD0;
	Sun, 14 Apr 2024 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFG0ttIO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021A134CCA;
	Sun, 14 Apr 2024 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109745; cv=none; b=fd6q38kz5DgJeVQAyHzB1kCy7tiU+i1iQfnP4vfn23la7fVGb5gwKCDnAFhqQHV6BiYE4eAqrxRbiy9RVTDe6U9BgyfqmNpdu8oRH5Wic08UEDLPJ5LAiClI5kfH/IzAnPFexDaJbuhSHWnyXEvGYl702YO5udYDZC3ojGpthJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109745; c=relaxed/simple;
	bh=kv6cGnOQf3eKFvWuVElyxmAUi393yBmpD5WPaWGl3O4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KBj4JokGhOI50Dh0oEgYLhXS+FWtTWyV6AIm1tFnZOkllJ06dLDOHWvs0rV8u8DjKmv3I7KHctmhJmjoaw5WLrBbFNNapCF+oZc6ugK6OkatJp5RHppdIsIFocuP7UVk08N7GMsYSzDzAKPPLNvAI3Mpxx0HTT7+OXIhLa20A9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFG0ttIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116F3C072AA;
	Sun, 14 Apr 2024 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713109744;
	bh=kv6cGnOQf3eKFvWuVElyxmAUi393yBmpD5WPaWGl3O4=;
	h=From:To:Cc:Subject:Date:From;
	b=CFG0ttIOsvNmq2xzq3nEQTuqxjn1OcIzkHu1WalScGczj5/mec2RXyugl1+VG9bdR
	 ewJOs7aKIkWwxZ7aSvOKbRuV0bJGz9MiGiXO0Jbfb/neeaWY99/t37y43TfvlNtmw8
	 ew8b1AbHJ/s/mX0goxTeSRLrQ3MHKeiPpJjsNKmNwGH0n+qDonzdEjQ37NWPjc/ENi
	 cSM5JT4Asi6m1n/ul20OHcbRw7quRyeT3pkQxjmxCXGuvG6BNcniB9IDJRjuixnaiB
	 tD8WSRF3tdyFby9fNvnvoLerbPftao3/xHM85Zrv7JFWTYgdfxjir9EyXVdcjUsayT
	 gVyyEUIlH4vZw==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] spi: altera: Drop unneeded MODULE_ALIAS
Date: Sun, 14 Apr 2024 17:48:59 +0200
Message-Id: <20240414154859.126931-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ID table already has respective entry and MODULE_DEVICE_TABLE and
creates proper alias for platform driver.  Having another MODULE_ALIAS
causes the alias to be duplicated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/spi/spi-altera-platform.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index 72e7a0f21793..585393802e9f 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -169,4 +169,3 @@ module_platform_driver(altera_spi_driver);
 MODULE_DESCRIPTION("Altera SPI driver");
 MODULE_AUTHOR("Thomas Chou <thomas@wytron.com.tw>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRV_NAME);
-- 
2.34.1


