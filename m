Return-Path: <linux-spi+bounces-3379-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297D5904F88
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 11:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC2C283D13
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128B316E866;
	Wed, 12 Jun 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQgXUG9q"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4616E863;
	Wed, 12 Jun 2024 09:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718185493; cv=none; b=fZkLazbWM4M145BhA6xPD1JY6ZQFLLCMh2YSZhGNRHnniTBNnHcFSSXrJvfLPf2H+/5JuCCXX0rP/iQpwLLbiVw7X4c8c/YspRAZ5PdobCOrO6yc1hWnc8Ssqx93XwW07hIvjSYIR7acbbQo5LRihThW3z8p31KhBP/q1ChoI7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718185493; c=relaxed/simple;
	bh=ipSLKvscIHjvTT9FXo+JM1SUJKLQb0dy1cZ4uZ3Z7jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K81klzltK7xL5jmWxz7URHasWWSWamD38zTJ4r+tQL5besDMHDbvibBAKvIS5EuawtQr8UzDAFLgMmojQXFbGahf3J/NhWlUwn3zTCGCNlcdWax2Zr0BWt9F97ZXn6QQkGi6LJD8nAtWj/kNAEwMVLmCKHPMu1iBhv0kGoKtkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQgXUG9q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C15EC32789;
	Wed, 12 Jun 2024 09:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718185492;
	bh=ipSLKvscIHjvTT9FXo+JM1SUJKLQb0dy1cZ4uZ3Z7jA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=LQgXUG9quIv5wypp3e08V2W6wvGCWX+kfLm0SZv7pq0GJq1hJcSQ66g0YbR2FI7i7
	 rnEfm6wPXplRLsb7cr8rsku0rgPb4t5PnUh3SOjkLIIrabut5C1I+2YTi56U9YW7Sh
	 Yc+wZrQoKLCk1uE2KM/HyrXdCxzCauypt4uoQQolBYMrhJn1a4Q7TGIW3A0KC+aC6o
	 NUmdUspwCoAYxwoRbc97zC7hvgjxYxXkhxljB7pp3lptqNm+UBsIvy8ur7uJhSxRjX
	 XN0h/kzCVUpi5puKqiMy3T0Fz/Ivsi/hZd805FjOCjhtdE8Qe/wwD34+hGXLtBycWE
	 Nxeg1jnWVy/OQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE65C27C53;
	Wed, 12 Jun 2024 09:44:52 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Wed, 12 Jun 2024 17:44:50 +0800
Subject: [PATCH] spi: meson-spicc: add spicc loopback mode
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240612-spi_lbc-v1-1-d52e8c8011bd@amlogic.com>
X-B4-Tracking: v=1; b=H4sIABFuaWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0ND3eKCzPicpGRdAwtTy+TUpGRTC4NUJaDqgqLUtMwKsEnRsbW1AOo
 n511ZAAAA
To: Mark Brown <broonie@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sunny Luo <sunny.luo@amlogic.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718185490; l=1402;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=b+Ry5KyDug4yW2aXOoBaVaLUbknmRYKeqBgQWvQYE0Q=;
 b=scoKl7griElcwsQYJ5MkTT9KMG5KoHWGW0pBIMKlZcXQ0qwTcMxpVklWONNq0cdQQ62ieUpzt
 RN+ICCezNmlD8L7HkC0Z/Dqe3qZrHGu2q7QJievDZcWACky1WpdqNLI
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Add spicc loopback mode for debugging convenience.

Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/spi/spi-meson-spicc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 8a4a8ba9dfed..8838a98b04c2 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -514,7 +514,9 @@ static int meson_spicc_prepare_message(struct spi_controller *host,
 	/* Setup no wait cycles by default */
 	writel_relaxed(0, spicc->base + SPICC_PERIODREG);
 
-	writel_bits_relaxed(SPICC_LBC_W1, 0, spicc->base + SPICC_TESTREG);
+	writel_bits_relaxed(SPICC_LBC_W1,
+			    spi->mode & SPI_LOOP ? SPICC_LBC_W1 : 0,
+			    spicc->base + SPICC_TESTREG);
 
 	return 0;
 }
@@ -850,7 +852,7 @@ static int meson_spicc_probe(struct platform_device *pdev)
 
 	host->num_chipselect = 4;
 	host->dev.of_node = pdev->dev.of_node;
-	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH;
+	host->mode_bits = SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LOOP;
 	host->bits_per_word_mask = SPI_BPW_MASK(32) |
 				   SPI_BPW_MASK(24) |
 				   SPI_BPW_MASK(16) |

---
base-commit: ec0d19f2b59699e2e148091debaa0d9d6af5800a
change-id: 20240611-spi_lbc-0859cebc580e

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



