Return-Path: <linux-spi+bounces-6252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00784A04BBF
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 22:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9209918876A0
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 21:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028291F9F62;
	Tue,  7 Jan 2025 21:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PEpMNyvR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m127207.xmail.ntesmail.com (mail-m127207.xmail.ntesmail.com [115.236.127.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A21F63F4;
	Tue,  7 Jan 2025 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736285452; cv=none; b=HT4G+/c175C6+YjdxADWnqPmDKmKxr8UCsgvaQ8jc+4bBAqzQEQ3obSzHLEawmQXlG739EzIjbvMoxNHaPN1dlyArxHKNzvyZw9BIlf5j3592cwZxyy9nNg1SouPQ+x4lI3rJOB0pheoTtTcKQv/MHNo1YIM7Luj5JycSh/4RoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736285452; c=relaxed/simple;
	bh=YBieXqtRzADDn89tCuYnyP2Vs10O5AFQ/vcpdqlPSQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aIzvGYjWpEBIZ2M3CzUDbMiP7Yv3WV8zcXRXS3E+ck4okoY0wEAPCy+oMKl7bMPQNmDGhigqCNhYBEFoStQ++DYvvCenu7AVwxQIuZh7K4ddRAxqG6I2Gto9OMAwn11WZXlkQmixU7KBgGbt82/fnsjx1DU4EHj1mqFXNL95JCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PEpMNyvR; arc=none smtp.client-ip=115.236.127.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from rockchip.. (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 801e0ada;
	Tue, 7 Jan 2025 23:47:57 +0800 (GMT+08:00)
From: Jon Lin <jon.lin@rock-chips.com>
To: broonie@kernel.org
Cc: linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	heiko@sntech.de,
	jon.lin@rock-chips.com,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: spi: rockchip-sfc: Add rockchip,fspi compatible
Date: Tue,  7 Jan 2025 23:47:54 +0800
Message-Id: <20250107154755.2037197-1-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQhkeS1YeHUNOQh1OS09CQ0tWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a94417385e609d9kunm801e0ada
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PlE6Myo*TjIXAxEqKSoxKAEN
	Ni1PCzBVSlVKTEhNSU1PQ0xDTk9NVTMWGhIXVREUFVUXEhU7CRQYEFYYExILCFUYFBZFWVdZEgtZ
	QVlOQ1VJSVVMVUpKT1lXWQgBWUFKS0lKNwY+
DKIM-Signature:a=rsa-sha256;
	b=PEpMNyvR8BcHN0tcoj6vbenk8oCRdNnkKnCclgmfwjTRBjJJVpoLi0E7QgE45Bd2cNuoVBqof9+9djBscSSb3HReo6rs1SI3Ai7K0thSCuNxxjtcnORuTGG3yb/5wpFQReO8TROfUg0EdrVXKomYLGvE0VRTS+UuA67yDWcIKt8=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=8ZaCjqw3pN3r+klL+dtGLBICAVtHTeQRB+45CR/nm1c=;
	h=date:mime-version:subject:message-id:from;

FSPI is an SFC upgrade IP that adds functions such as XIP.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
---

 Documentation/devicetree/bindings/spi/rockchip-sfc.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
index ac1503de0478..4d64155d03f8 100644
--- a/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
+++ b/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
@@ -15,11 +15,15 @@ allOf:
 
 properties:
   compatible:
-    const: rockchip,sfc
+    enum:
+      - rockchip,fspi
+      - rockchip,sfc
+
     description:
       The rockchip sfc controller is a standalone IP with version register,
       and the driver can handle all the feature difference inside the IP
       depending on the version register.
+      The rockchip flexible spi controller is the next generation IP of sfc.
 
   reg:
     maxItems: 1
-- 
2.34.1


