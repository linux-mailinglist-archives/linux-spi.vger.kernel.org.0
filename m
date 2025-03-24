Return-Path: <linux-spi+bounces-7286-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3933A6D7C3
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 10:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050B57A64D5
	for <lists+linux-spi@lfdr.de>; Mon, 24 Mar 2025 09:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCC425DCE9;
	Mon, 24 Mar 2025 09:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="o0SeTaSK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0A325DAEF;
	Mon, 24 Mar 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809410; cv=none; b=j31hR0i16zkgmqVzOypUjAg5XqL9ffxvCA7EYAGr08gK3TgqLuyVKv4ErBDiTcugsUsF9Wg1T6dgatnLNWftvx4RYsJI5RUsQYuEXvA8UeXazrMRyyA5u59BkrigpHEjJ73NqCr2Y3L3lurlbtYh10fj1scdGdtnEfjOSEZA1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809410; c=relaxed/simple;
	bh=n3Nby/fIzs+O/ZqCo+jpEq1LFeyxYS3UFTduSwDh0Ks=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=MwbEmnOwRott/JRxb6MJ90S29b9QhLra/fMHq/ApJwoH460hmkUAvwiuBnofPpOyuskWmr3M8c+1UQl0WmsJGBOdiwMdqbgFC0Q2H+w2mW7rkZpSlejzhuvUHGbcFqauI8cHKzhRU3gUMTMoWY/xN0EjoEJx+fN5d2jpi5PmRl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=o0SeTaSK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O7ELVd032168;
	Mon, 24 Mar 2025 10:42:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=5fV2R1E3CKBb4WFfRo1d9P
	Yp2TC8wiqYUiEwsJbh6Qc=; b=o0SeTaSKKMUsYOUmOa4/jofgvOu2CbNHqPZR4J
	0590RDqcPG3Niu91HZ96V9+SDVJLcRZEQxzXpO+NqAsm1OdYKg7GrrGWPHiB5sCq
	eS32CMq9KCaOAzG0KB64861IdL8niNlDmjJiJdaWejHtDhX/i8alovllZCCZyVu5
	YamOpIJRGcro4TNuZ9uI25C0c8Gjk+12Lc+FN9BtTMY7/NUvNvDG9O34TtlN2U7F
	H4LWx37jWYYfr8jMweBJRTkARmFIVR4W3VmvEpYMLV8vFKZgS3jjBxWuygR5X+go
	ufO4+/kzPAsIOeYUpViumltgWd4rZih9TcGGtSNkPku75yvQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45j7n84eqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 10:42:59 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E3BD1400DA;
	Mon, 24 Mar 2025 10:41:40 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 14FE17EE902;
	Mon, 24 Mar 2025 10:40:16 +0100 (CET)
Received: from localhost (10.48.87.62) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Mar
 2025 10:40:15 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 0/2] spi: spi-stm32-ospi: dt-bindings fixes
Date: Mon, 24 Mar 2025 10:40:12 +0100
Message-ID: <20250324-upstream_ospi_required_resets-v2-0-85a48afcedec@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHwo4WcC/42NQQ6CMBBFr0JmbUlbENSV9zCEFBhkFlCcKURDu
 LuVE7j77y/e20CQCQVuyQaMKwn5KYI9JdAObnqioi4yWG3POrNGLbMERjfWXmaqGV8LMXZxCAZ
 RWe4ujSkLY5oComNm7Ol9+B9V5IEkeP4cudX83n/Nq1FaXZ3LS20xc2jvvRdJJaStH6Ha9/0LN
 jJtXcwAAAA=
X-Change-ID: 20250321-upstream_ospi_required_resets-34a8b17611b6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime
 Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <christophe.kerello@foss.st.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SAFCAS1NODE1.st.com (10.75.90.11) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01

Make "resets" property mandatory.
Update spi-stm32-ospi driver and dt-bindings accordingly.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v2:
- Update dt-bindings commit message to explain why OSPI's resets becomes
  a required property.
- Link to v1: https://lore.kernel.org/r/20250321-upstream_ospi_required_resets-v1-0-9aa4702e3ae2@foss.st.com

---
Patrice Chotard (2):
      spi: dt-bindings: st,stm32mp25-ospi: Make "resets" a required property
      spi: spi-stm32-ospi: Make "resets" a required property

 Documentation/devicetree/bindings/spi/st,stm32mp25-ospi.yaml | 1 +
 drivers/spi/spi-stm32-ospi.c                                 | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
---
base-commit: e94bd4ec45ac156616da285a0bf03056cd7430fc
change-id: 20250321-upstream_ospi_required_resets-34a8b17611b6

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


