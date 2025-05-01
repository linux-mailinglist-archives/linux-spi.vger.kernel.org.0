Return-Path: <linux-spi+bounces-7809-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C18ACAA5C8E
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320B44618A0
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A813620E70E;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2X/WuIq"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C38B20F091;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746091265; cv=none; b=WckiApUDGz8kfBQtZZ/LgGKQ7G3EHinV8MKPFXZekoe+fOiwPOiOlvPJITO6mupCS4rqxB97TzEMC56aUQPfuODJJuC78/ideI9sgROntQUPzqKkMxXr+P48rQPcfDQAiwtSCb8SeKcNptCkbua9pgzXOKMgFX/CuMVWDs48cyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746091265; c=relaxed/simple;
	bh=VrVkL3ZKkmH7IRchxu6hs4KunGiXp7bNuu+DRsYoQLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VwyHNur9x7ko4Il5V6PozVqgO1rFYlm0sNJnNtk8bsGr0q9Tpt0tq0bPNUiMVSOO2GNhxqsp6zQmpowxWxqsix1Sfn4RAtoDWlLTLxwV/qFhgSO9+FrJIGSaQs9Wlm+0uszFOakpsgs4+7NfHFS1qFJuVBYWYzsy2mHviJGo8Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2X/WuIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32B5CC4CEED;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746091265;
	bh=VrVkL3ZKkmH7IRchxu6hs4KunGiXp7bNuu+DRsYoQLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=R2X/WuIqE/ACfjAl+TA7NjEX1qW7cHsXZ6Pk4xJuPkUG0jJTleGgcGmddyOWfv+ZC
	 QtSTOUPsOTr9rarM2hqTGJ6p6Eoe1CKfXFY6FHxq+pRdcU55EKiUfPI+ojZ8tVkrb0
	 ad6bBiDFgrF2mwHxku1Vl/bkXRPlPthlBpI9qWQeVpHI8c2sUnjxOSleS+AimDo012
	 icAazWrqqdWYoX5ZxZD/Up/Gu61f/KefTvc1kFSQtZA6sdtsc2r+20vZvniAJZ4sGe
	 rxEm68V0LyjCs6Z9Nl+kzfXDkWMxSvE8y7/LeqTHMlJJJg4NjMxWlZC7lOw+oNFtMI
	 GdEqLRZj7xk7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D006C3ABA9;
	Thu,  1 May 2025 09:21:05 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Thu, 01 May 2025 13:20:51 +0400
Subject: [PATCH 1/2] dt-bindings: spi: spi-qpic-snand: Add IPQ5018
 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250501-ipq5018-spi-qpic-snand-v1-1-31e01fbb606f@outlook.com>
References: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
In-Reply-To: <20250501-ipq5018-spi-qpic-snand-v1-0-31e01fbb606f@outlook.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, sadre Alam <quic_mdalam@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746091263; l=1065;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=Vn57KyOsNu/ySFd+C3/QjJQvANGt6ZH80rH1wCZ1tT8=;
 b=3RrQmearoVavPvbKtCI1KwwwSX1OTyhq6rOVklLPGZFGFKhyVqAfnJoUZCOids4dHNnILQ1AZ
 2W6MX43xx7PAi+38BpFmh99VvSWL/OLtdiAl9MDE8yRrH95LgCMBm/q
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

IPQ5018 contains the QPIC-SPI-NAND flash controller which is the same as
the one found in IPQ9574. So let's document the IPQ5018 compatible and
use IPQ9574 as the fallback.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
index aa3f933192034fe6d54d6149373d50c31ec4aa96..cb1f15224b45574a3c3d603566c859a9bec41937 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
@@ -21,8 +21,12 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - qcom,ipq9574-snand
+    oneOf:
+      - items:
+          - enum:
+              - qcom,ipq5018-snand
+          - const: qcom,ipq9574-snand
+      - const: qcom,ipq9574-snand
 
   reg:
     maxItems: 1

-- 
2.49.0



