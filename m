Return-Path: <linux-spi+bounces-8565-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C179ADABD8
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 11:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E0F1892716
	for <lists+linux-spi@lfdr.de>; Mon, 16 Jun 2025 09:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21442749DC;
	Mon, 16 Jun 2025 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="5ZCpChom"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A5A2741DF;
	Mon, 16 Jun 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750065838; cv=none; b=rSTkvExBuOFyAwi7T/ke1JcDzFneWapaXZbNitCob5Gf6B5J8bcnvuxN0EAqrdPm4dfg33trhvdgKvenLpyn0rpYICvOHmuztyIyKyk3W1A8MESbZeVxbOusitIfvvcx/6yh5sahptPJAx9ytTYJyBo+aW66NZu7TIQdPumKZaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750065838; c=relaxed/simple;
	bh=/NuocV6DaBQUjlKq/ncv6IUkpl7Y4xbpuZPctAEcTI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=nSGbik5Rpb5h8q4OsHm1MD8TC8kiIc+OeTkFN9VUXqWA8oa3NnKYkGJzQYkwGtLxGefYgdm6hXQ6MnpKvdX1v8v7jFMzpeW+fyeLKDo8pfYGaXsx80gVdEUIaihpiILyfMqkMdxAyP8HqyoY4UvHZadw1pYwBgQiU14dh2XppPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=5ZCpChom; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55G8ZTHg015551;
	Mon, 16 Jun 2025 11:23:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	D7+OvSwoVVqlTBMuJc+wtSrz4tCpMidCNQSt7hN5EuU=; b=5ZCpChomjD8v6Dpd
	BSAnGf7q4nAfcJfY0pqThRSytnvP2fFHENUwg0vr3dxsvaVgbeNxpOAaUuImM9BY
	qSWd3CqntARsHX30eJ3Ane5ZfwcUVL3HYKX1NIaVEZNpka9fWSEDjKT78jN0LTTp
	uQI+B3+uej8gnHaAEeNuUs9S4E6VnZSbHPOB21jt7VlaTvJy5xlIVBWl77UobqCv
	s+R+jwlJrszondh2KF7jTv4/6Dym+dtjvWtuNGqXyp41HhCPgbvtFV8gSe+eDixl
	7Cmft5m2p4g2E3RAemd847tDRuVFcJu4nVLHtC0W5PQQJ2Ixav6ImSrj/Yj8lwjb
	+RbWaQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47afw1g9hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 11:23:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5BAD04004F;
	Mon, 16 Jun 2025 11:22:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2068AA7D8DB;
	Mon, 16 Jun 2025 11:21:12 +0200 (CEST)
Received: from localhost (10.252.14.42) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 11:21:11 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Date: Mon, 16 Jun 2025 11:21:07 +0200
Subject: [PATCH 6/6] dt-bindings: spi: stm32: deprecate `st,spi-midi-ns`
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250616-spi-upstream-v1-6-7e8593f3f75d@foss.st.com>
References: <20250616-spi-upstream-v1-0-7e8593f3f75d@foss.st.com>
In-Reply-To: <20250616-spi-upstream-v1-0-7e8593f3f75d@foss.st.com>
To: Alain Volmat <alain.volmat@foss.st.com>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Erwan Leray <erwan.leray@foss.st.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Sumit Semwal
	<sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>
CC: <linux-spi@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-c25d1
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_04,2025-06-13_01,2025-03-28_01

The vendor `st,spi-midi-ns` property is no longer needed and
has been deprecated in favor of a generic solution.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 8fc17e16efb2..8b6e8fc009db 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -115,6 +115,7 @@ properties:
     maxItems: 4
 
   st,spi-midi-ns:
+    deprecated: true
     description: |
       Only for STM32H7, (Master Inter-Data Idleness) minimum time
       delay in nanoseconds inserted between two consecutive data frames.

-- 
2.43.0


