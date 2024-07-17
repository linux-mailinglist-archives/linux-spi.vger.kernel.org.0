Return-Path: <linux-spi+bounces-3888-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EBF933A8E
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2024 12:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01D161C22D4D
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jul 2024 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E718B17F397;
	Wed, 17 Jul 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLbf45OZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40104204D;
	Wed, 17 Jul 2024 10:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210405; cv=none; b=oh/BmJKwWQ+1Ov7aCPOvQ9Xp2pirlDRwqv3RD4cKflr2prb3Vo4kAndlf6MJRz7RpJjxJ+aRqHhPiCmSIoS0leQ2pPluTJkdyOuDfHndReUfr57fr+a2AwOJSRDu+WDoQ4dNlOo6IktNC/v2VLTlhOwaz23pHffIYE6I/rToS9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210405; c=relaxed/simple;
	bh=FB+gkQhT8RGDWncY72r8oB3sgk2ZpbFKbtUPoW8K3ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rx+P4hE6i4j7bbY1/vXcT1d0BP3bca/w5iCftZRt4qYTMVqZo45O/OakxLTg6V+dBjFE6PQxZvy08QhOYXRB4wMDJPl9/EvXfdWrGVyRC/S1sYcwwaqG4Mfcp8yWqrARv0s5pb2shoNeG0vK3y9UeoNqY/lhQl1hqBr8N2yqoxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLbf45OZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4AEC4AF0E;
	Wed, 17 Jul 2024 10:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721210405;
	bh=FB+gkQhT8RGDWncY72r8oB3sgk2ZpbFKbtUPoW8K3ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cLbf45OZYqiYbIcHcRNJb4KrYMYYjFMhVimjgs0C0QtbTsC8jVsjoIGa0WdzLMRZu
	 v/ehkUUqnYmNv+4ZN30fHK0wAy7eCfMWWSUcj/eP7/thoYBkOLgCqQZoFBoEb8Kowo
	 fb2pUCLKEDsj0E+wEdXHcPm/3CES4y6qwaiyuR3B0G99mDFFiew3/xTL1/BPy0+dCw
	 +FZ539tYFAxVVD3CVemJJZv0gq5Otw0iIGy2kkJE5mADZ3MglTn5d+Rd9Mt8/BWdTi
	 yIlyiwoaYff/AsfsylnZP7Tb2yEehaAYB9BinUTP8xbNPLdgoc/lEgvYzatsGTGrkY
	 YD19Ehnp1QLoQ==
From: Conor Dooley <conor@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 2/3] spi: spidev: add correct compatible for Rohm BH2228FV
Date: Wed, 17 Jul 2024 10:59:49 +0100
Message-ID: <20240717-ventricle-strewn-a7678c509e85@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717-impotence-zippy-254b86593069@spud>
References: <20240717-impotence-zippy-254b86593069@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1283; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=CcLwP+5TB3urQavRjMU4fiPAsz1HM8MlYRRdrepViDs=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGnTp4nceKp5cWXHwjXRd7fOEkrkmbDX6bDe+3Pe/2s/8 P7evL/XoqOUhUGMg0FWTJEl8XZfi9T6Py47nHvewsxhZQIZwsDFKQATaaxi+J9b9ovrqNg+x8Rb bq9KHjIstVARn2gYeifsurOtWdyBV6KMDPeWn2898GnGgotrL97pFZh0Yd7StcknX7boTVvdu1a TdS4zAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When Maxime originally added the BH2228FV to the spidev driver, he spelt
it incorrectly - the d should have been a b. Add the correctly spelt
compatible to the driver. Although the majority of users of this
compatible are abusers, there is at least one board that validly uses
the incorrect spelt compatible, so keep it in the driver to avoid
breaking the few real users it has.

Fixes: 8fad805bdc52 ("spi: spidev: Add Rohm DH2228FV DAC compatible string")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spidev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 95fb5f1c91c1..05e6d007f9a7 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -734,6 +734,7 @@ static const struct of_device_id spidev_dt_ids[] = {
 	{ .compatible = "lwn,bk4", .data = &spidev_of_check },
 	{ .compatible = "menlo,m53cpld", .data = &spidev_of_check },
 	{ .compatible = "micron,spi-authenta", .data = &spidev_of_check },
+	{ .compatible = "rohm,bh2228fv", .data = &spidev_of_check },
 	{ .compatible = "rohm,dh2228fv", .data = &spidev_of_check },
 	{ .compatible = "semtech,sx1301", .data = &spidev_of_check },
 	{ .compatible = "silabs,em3581", .data = &spidev_of_check },
-- 
2.43.0


