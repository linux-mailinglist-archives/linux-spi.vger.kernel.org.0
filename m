Return-Path: <linux-spi+bounces-10403-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A1EBB17E2
	for <lists+linux-spi@lfdr.de>; Wed, 01 Oct 2025 20:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4AD919473C6
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2857A29B8C0;
	Wed,  1 Oct 2025 18:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3ULQYPP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B0049620;
	Wed,  1 Oct 2025 18:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343495; cv=none; b=EhP7rslDzU9C0+vWECdZjBJDT8fKICa5+SyF+gS2xM7ewDxEdawruQBsbuG77ME8tDNZp0Q6yNHMvwYaCgF99HF4iWA1y9bI6H5g9GCLwBbbs+zWCT625EATu2+RBB7S5QwyHyRO8rk0FSNy0YvpbeKky6QT2nb57ADcVa+xjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343495; c=relaxed/simple;
	bh=Dk4SYITbrE5C3jBQ0rRmH1my75LpjgKREbgHSO0H9BU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCKFbsAg/Zo4kg/ONSuo8rgyBjCWSUNDsLhvQmDHO3Mryt66YEnHba6N36PJdWnG8kmiSOWylL7OQ2TOmgJ9mXYCNlYlJoChKUgFYZhLiwLzojCrv5/1yhtSdpLpxOxlqB+a7YkgU4S1f+Yu/PO2eS0b/S754utvJOmWeSXpNbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3ULQYPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CEFC4CEF1;
	Wed,  1 Oct 2025 18:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759343494;
	bh=Dk4SYITbrE5C3jBQ0rRmH1my75LpjgKREbgHSO0H9BU=;
	h=From:To:Cc:Subject:Date:From;
	b=B3ULQYPPrKB+zytHQTmAzDsVbcijmXu55ePTyqiaykUlEwh3Z7RkKzLcPOVPoZWlk
	 EBuPJ/vAig0NC9Wml8/cbfTqRRujqdJQ4AQL+/LxjeTNs2EWp5nPj77NMulrlYsOA5
	 eBbH9rl9FzhF+noFh8KR/RWHRDue1XpUXtOmAHPRmsAzZfIn9OUbfijvNh65+8EmiI
	 I1ZJmrej4soKRyZZ+g0VG9Rff6XPMj5dR742TIPqZEgqW1tfib8wUAPOjU/QILxNPJ
	 sxCCDumRWpk2MaPm21aDQdTUqtznSzqPxOrLdXkcjGvb0Mru3uJSD4tO40fyqa8CqN
	 XfDsdiXpMSLYg==
From: Conor Dooley <conor@kernel.org>
To: linux-spi@vger.kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Jun Guo <Jun.Guo@cixtech.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/2] spi: dt-bindings: cadence: add soc-specific compatible strings for zynqmp and versal-net
Date: Wed,  1 Oct 2025 19:31:12 +0100
Message-ID: <20251001-basics-grafting-a1a214ef65ac@spud>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1832; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=1SEoBl3IkinUMLRK+FNSvbKHIkHI8aGP3E2c2HCbUXE=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBl3iyuEJ/2tqjwefr1vrX7loe6Jn/18eTrijgoeO5LwJ EFe/xlXRykLgxgXg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACbSYMXw37vG+tQNuVObtj65 mr9d+2bQ1Kx7k2LX710oEtb2P/NySC0jw9Zv6wquh9d2MEgUmxk+2nR1sazM/1bR7ZGz70ypsfZ 4yA0A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

When the binding for the Cadence spi controller was written, a dedicated
compatible was added for the zynq device. Later when zynqmp and
versal-net, which also use this spi controller IP, were added they did
not receive soc-specific compatibles. Add them now, with a fallback to
the existing compatible for the r1p6 version of the IP so that there
will be no functional change. Retain the r1p6 in the string, to match
what was done for zynq.

Disallow the cdns,spi-r1p6 compatible in isolation to "encourage" people
to actually add soc-specific compatible strings in the future.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Jun Guo <Jun.Guo@cixtech.com>
CC: Mark Brown <broonie@kernel.org>
CC: Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Conor Dooley <conor+dt@kernel.org>
CC: Michal Simek <michal.simek@amd.com>
CC: linux-spi@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 .../devicetree/bindings/spi/spi-cadence.yaml          | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
index 8de96abe9da1..27414b78d61d 100644
--- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
@@ -14,9 +14,14 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - cdns,spi-r1p6
-      - xlnx,zynq-spi-r1p6
+    oneOf:
+      - enum:
+          - xlnx,zynq-spi-r1p6
+      - items:
+          - enum:
+              - xlnx,zynqmp-spi-r1p6
+              - xlnx,versal-net-spi-r1p6
+          - const: cdns,spi-r1p6
 
   reg:
     maxItems: 1
-- 
2.47.3


