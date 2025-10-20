Return-Path: <linux-spi+bounces-10721-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D84ABEF6CC
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 08:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 429B1349381
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 06:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D242D640F;
	Mon, 20 Oct 2025 06:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="KGHskoDK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA682D320E
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 06:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940640; cv=none; b=tZpjoCLJ3zmR5G7NXpFFGM+xfQ3HWxazvRHvyyBMRNGnyYMvstFniLDAG0gMgR8hHMy6yQ2LyZ4LYhhAgeQqwvoYRiTOa21v5bd66Ba2tCuH0LoWXx9Zl7xdFA75jEZF2PZo2HjnITuHBMxFD3C7vgKTQrX/6sWnYHQSI01a6dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940640; c=relaxed/simple;
	bh=W94mpYJxiv21HZhC5xqeB3VFFBW5gguL2QkJLKXrolQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH8I2Il3hD+NBmka/ASsONjtoA5yp2FP4xAM3JSn5N52GAlZlwKGgNRBNwK2X2nSefUqmCJCORJWEf9X3+I9anC/PYoImNsV6ABLWoHY/PV4PUS6Mmd38zAILB6S6pzXfKtyw8kALgdK3gtuP5vmnASdYxJ7cleAMQcG80Y++No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=KGHskoDK; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=KY43oKXxykqxhh3dVt+OgTp6ozmD+TNOu+V5dGLYibM=; b=KGHsko
	DKD4ym8kp3K66vCmdRd8pjPZOLCZLX6tmu+V/YuDmV4PTM6/QOL6w2zFlSu6jN7R
	Qh6gQa4qsJToYFs5aejOdSsT7kceG7riAbVrvJSEZKjAlwxW0g+WNrxCD5+Rk93D
	aDg3T41i0f4KgsXsxSlQgai828iiILyGPsmVPM0YvJFhO6KXrnd/eZCL2CiSXZfz
	ctLzkZe2CTJdW3cPakvXFMKbjuKngCvRI7cAxsxhLYUjMbyS5o3xhVkRagOCcHPF
	P3zhDLWmutjNwgWWISKzyHFlm1qeLDpl+7sbjEBia/b++5CsQM9VaVvIuYU6YxbD
	cVTQQVOUllpYuy8Q==
Received: (qmail 941082 invoked from network); 20 Oct 2025 08:10:29 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Oct 2025 08:10:29 +0200
X-UD-Smtp-Session: l3s3148p1@4N6v8JBBQoggAwDNf0fPAEuMhp6AgTGK
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: devicetree@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: spi: don't check node names
Date: Mon, 20 Oct 2025 08:09:53 +0200
Message-ID: <20251020060951.30776-10-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>
References: <20251020060951.30776-6-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Node names are already and properly checked by the core schema. No need
to do it again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
I'd suggest to give subsystems some time to pick this patch before
Rob applies it?

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 +-
 Documentation/devicetree/bindings/spi/spi-controller.yaml  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 0543c526b783..5c87fc8a845d 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -153,7 +153,7 @@ properties:
       provides an interface to override the native DWC SSI CS control.
 
 patternProperties:
-  "^.*@[0-9a-f]+$":
+  "@[0-9a-f]+$":
     type: object
     additionalProperties: true
 
diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 82d051f7bd6e..3b8e990e30c4 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -111,7 +111,7 @@ properties:
       - compatible
 
 patternProperties:
-  "^.*@[0-9a-f]+$":
+  "@[0-9a-f]+$":
     type: object
     $ref: spi-peripheral-props.yaml
     additionalProperties: true
-- 
2.47.2


