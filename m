Return-Path: <linux-spi+bounces-11929-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B304CC0260
	for <lists+linux-spi@lfdr.de>; Tue, 16 Dec 2025 00:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAEF53022206
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358D329376;
	Mon, 15 Dec 2025 23:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muqowXvn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162462EF64C;
	Mon, 15 Dec 2025 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765839809; cv=none; b=iccfumScVnDPrGAUI2JXJwUyZNvA6kXyXKXR8MrEg4NCPP/QAQTtVG2khDIeWvigQTe0r8rk8CH2fI7YGoW2KGITHJSA7pYRYaLzjwjTfwAYJfPoCJMPaP9LBb9xGNpf+GczWqLvNKfsVOjHW6Oa/Jal/XT/T5gPsfNrkStZ6BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765839809; c=relaxed/simple;
	bh=6dtfRcJwS64d/mOYJ01AB+IB6alrj85sRjzS2GkfUG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iKiLaIKiBNnJ9I62fnnWi2rsYFpdR/gPk9bq5O0/hZoP0kkG1zmFEYVNN5EUPVhdUD0+qjA7O0r2juGeB+fXENVC+iQU0k7ISXHLA1CwB60aNrIr3BATG27kfwc/5MPZIgHADAVYXOGHiu0gQj/IWfjKEzvxNPO4d1q5ZFzTxt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muqowXvn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78939C19421;
	Mon, 15 Dec 2025 23:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765839808;
	bh=6dtfRcJwS64d/mOYJ01AB+IB6alrj85sRjzS2GkfUG4=;
	h=From:To:Cc:Subject:Date:From;
	b=muqowXvnI5GBGBXf8Dtih9brZLrWO25ZLJKjavi9olUk65t7q7IXBg/PITqCrJ9hu
	 RO0CyOOvt8kY9ZmK2p6+xo6tDXmGg1RYf54LRHlnBaXdlUjgYc7oKn1GXCXIpCjurN
	 axk2ItNe6eOOls3AgXZM7EmXSxGvCxH7bP5zgLzgaaLOP08u9OpkhjkuZ4VbXRhtgz
	 L12BGt7AypgbRUz0PE+g5KXM2xNqrtebmgW8jnHDhrgp2QYlVyW47Gkqf/eiLr3LM8
	 Oobvwxd35mR8xq8i9SEI00i+nFAo/WjhVfQuOvao4o/xJY7SFweLRV4lc/qMmvAFUC
	 5KF4vV4PlZP+A==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: snps,dw-abp-ssi: Allow up to 16 chip-selects
Date: Mon, 15 Dec 2025 17:03:22 -0600
Message-ID: <20251215230323.3634112-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At least the Microchip Sparx5 supports up to 16 chip-selects, so
increase the maximum. The pattern for the child unit-address was
unconstrained, so update it to match the maximum number of
chip-selects.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 5c87fc8a845d..81838577cf9c 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -121,7 +121,7 @@ properties:
   num-cs:
     default: 4
     minimum: 1
-    maximum: 4
+    maximum: 16
 
   dmas:
     items:
@@ -153,14 +153,14 @@ properties:
       provides an interface to override the native DWC SSI CS control.
 
 patternProperties:
-  "@[0-9a-f]+$":
+  "@[0-9a-f]$":
     type: object
     additionalProperties: true
 
     properties:
       reg:
         minimum: 0
-        maximum: 3
+        maximum: 0xf
 
 unevaluatedProperties: false
 
-- 
2.51.0


