Return-Path: <linux-spi+bounces-9101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9BEB067E8
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 22:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68757A6A21
	for <lists+linux-spi@lfdr.de>; Tue, 15 Jul 2025 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4C926C396;
	Tue, 15 Jul 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+CNcT2F"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B8B1547CC;
	Tue, 15 Jul 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612464; cv=none; b=Zu/zrN67TCr1Ayc96V3Ya50XqRaKZIwXBgU1cLwb8PPNO0rxjEHPUoAZkxj6bfv188ISrw/L5zBOD/yIQmJ7oxFpNqTzhBL8sDpPs25eXvD2cFZqTrG3x6df3WZtci6/0KxaTMrDs1gwOWIy0LZvaWv7tmpq3S1GWadZfVoZWpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612464; c=relaxed/simple;
	bh=+8T87hVWtlP0BU4Aogfqxtkdwo1wc0u0zEZPT4I2M48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZDrRNyaRa7A/qA3Spy3s8deMiqsFhW6kY1BNS003AX+R1ZqKBe+nDWe8mTPG9sdX67FcHwoFjGHZLxQczroYQSusfV1xOQFOf0W4WTjQhclm7IT0MOh8Sid484Xks4n5LPWjYWYhX3LwPU/WU5wAkn7VWi98Z4ON9LqEbCYgIiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+CNcT2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09BA9C4CEE3;
	Tue, 15 Jul 2025 20:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752612464;
	bh=+8T87hVWtlP0BU4Aogfqxtkdwo1wc0u0zEZPT4I2M48=;
	h=From:To:Cc:Subject:Date:From;
	b=P+CNcT2F52zpPJ2setcF32dq18j7Ailx4A20tHCJALUYC6WlJbwQ8ugBXW1fb2q0S
	 K9NcboA7cCQSkxJ1FjEUaRMiKPPMH61Poi4ZQsmAgUmsm5SuZZH8iC6bpriQgbhPqQ
	 xpumZA6VXAoS9240zgL2/ckGxTc6+EDuT64vcGOnTRz4VU5+X4K6KqYWCYPfuuYvsI
	 pzVdK5ecDMX0CGnBub8uyIwv7E+ZWAqNaFaLzgHv1UHpSH3isguxCjxvio97igvSDO
	 vzF51xf1gZ0xoB9IE5ZtgJUpE0gwp0/wnGR/8wrCYwDI8IRRS/Me4W02OLuo6lyCxv
	 dSVwJe3/ZAQhg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: spi-mux: Drop "spi-max-frequency" as required
Date: Tue, 15 Jul 2025 15:27:10 -0500
Message-ID: <20250715202711.1882103-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's little reason to require the SPI mux to define a maximum bus
frequency as the muxing is just the chip select and devices still define
their maximum freq. In fact, several users don't set "spi-max-frequency"
which caused warnings.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/spi-mux.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-mux.yaml b/Documentation/devicetree/bindings/spi/spi-mux.yaml
index fb2a6039928c..b1e2a97be699 100644
--- a/Documentation/devicetree/bindings/spi/spi-mux.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-mux.yaml
@@ -46,7 +46,6 @@ properties:
 required:
   - compatible
   - reg
-  - spi-max-frequency
   - mux-controls
 
 unevaluatedProperties: false
-- 
2.47.2


