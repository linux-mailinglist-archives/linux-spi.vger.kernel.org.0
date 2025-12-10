Return-Path: <linux-spi+bounces-11842-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 774C8CB27CB
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 10:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7937303D300
	for <lists+linux-spi@lfdr.de>; Wed, 10 Dec 2025 09:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4063C302CB2;
	Wed, 10 Dec 2025 09:05:12 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3312930497C;
	Wed, 10 Dec 2025 09:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765357512; cv=none; b=kvbKAlXYGtMnu/GHg27vz4edJidM+pJVpmGEMX92Y+JFBT0E7BiKoMo1i5QYEIABvM4iSnnWIBW8vwa+A+WVBgs+WZ9fbhnPtBnrBE1/4zHu+YVzYaKQM/HY1NYawCLp/wvTrXzyUTHy67MEQ59+H3yhvnGzCszf2f2EgkIpAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765357512; c=relaxed/simple;
	bh=1pNuUrCkwQCUCVbTWndpLvdT2wMY8V9sH1g+0NmALTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRAIO9+HynpdPL9VmuT/URdUeM6dPSNeh83TeBEAydQPApZhMsZHIwDo/y5fs1nh4RNP+f0Ac1k6aXVCNt4M3BVNJHtOtY/YscEkf5SdZdrNcAAGMMKocNCBbIT9w6dvoiwCPsPQhIgZzV8fh5XdulccU1NGXPYY032tvyQseFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
	by Atcsqr.andestech.com with ESMTPS id 5BA950AK081158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
	Wed, 10 Dec 2025 17:05:00 +0800 (+08)
	(envelope-from cl634@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Dec
 2025 17:05:00 +0800
From: CL Wang <cl634@andestech.com>
To: <cl634@andestech.com>, <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tim609@andestech.com>
Subject: [PATCH V2 3/3] MAINTAINERS: Add MAINTAINERS entry for the ATCSPI200 SPI controller driver
Date: Wed, 10 Dec 2025 17:04:30 +0800
Message-ID: <20251210090430.3602380-4-cl634@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251210090430.3602380-1-cl634@andestech.com>
References: <20251210090430.3602380-1-cl634@andestech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 5BA950AK081158

MAINTAINERS: Add entry for the Andes ATCSPI200 SPI controller driver

Signed-off-by: CL Wang <cl634@andestech.com>
---
Changes for v2:
 - Split the MAINTAINERS update into a separate patch.

---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8b39a55b939a..74ded6a79efd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1804,6 +1804,12 @@ S:	Supported
 F:	drivers/clk/analogbits/*
 F:	include/linux/clk/analogbits*
 
+ANDES ATCSPI200 SPI DRIVER
+M:	CL Wang <cl634@andestech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/spi/andestech,qilai-spi.yaml
+F:	drivers/spi/spi-atcspi200.c
+
 ANDROID DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>
-- 
2.34.1


