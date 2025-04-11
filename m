Return-Path: <linux-spi+bounces-7553-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B85A85DB1
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 14:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D09FA9C220C
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8C42367DC;
	Fri, 11 Apr 2025 12:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="UqoyPyu2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989D82367A2;
	Fri, 11 Apr 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375476; cv=none; b=PWtWzz1vujsXBWPC6uYFDiscGNaxmDzOjjeqlX8LNKJ1Rcd6pIF/StcDffneMn3967UR+gJRC+PxB70+xDYKDJ0DmUHKtzYEDeLGH0P8YePwUxf3KOx4CHcrKJEn4OPrrRustFpCnrdUoK8QpJa24ove4gPCWhGazRU4IkKziWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375476; c=relaxed/simple;
	bh=cnr2ofPU/+fv3m90a/O9lvyNPKaplyiDfTBmUcQLxeQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cpMxi5dtSNeuXLAUniJQFglpvdDz+snw/DBPVhf/rMZTMwzxd1n1gUfCsnkLfU4ZvgFkd71xQCOYK82p2eHWSyGghvKjwtMO0l75FaUfu9oBk7YIYvZEgZ4U0udIt+omcejX3U42hakiirixF2KIpFEVuVmEUuY9kNCn0GrRxXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=UqoyPyu2; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B9W3go002131;
	Fri, 11 Apr 2025 14:43:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=j/lAi5eaVA+wpovEOgd7NZ
	L+lXloOZBsudzotdqZPWU=; b=UqoyPyu2cZP4mweG/lilyfuugIK7/mbywr3lMd
	AgfwdAyouFafno9I0oD9rQsb/gIFq3dAYA/YbKGgEKmL8uQbpaZH9N+Qm6MRZkOm
	KgXO9cd3Xdp8PFwqK30hPEsphF3xBi/9wbNIVUFhaQpbsTLOtf+P4ajc0TyggAfU
	YQg0k3PsF4dbmlq7lvObAPaQU3p9wfIXgX34pWgQdLmcQQGfCFpzEeiCrLOtD6EK
	vNRUbvRvd1qWUyeIRrq/m6qtKSTt50cJtupz2GIFDzqJIfyEuEO0Z/oR2OzTIyH1
	OlCyQnIwKhu8VMS151okJ0buvtJfEQ55rNPOzh7lqORSlEfQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45tw8pwnc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 14:43:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 58FDA400D4;
	Fri, 11 Apr 2025 14:42:43 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 30E629EC282;
	Fri, 11 Apr 2025 14:41:12 +0200 (CEST)
Received: from localhost (10.252.25.37) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 11 Apr
 2025 14:41:11 +0200
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v2 0/2] reset: Add
 devm_reset_control_array_get_exclusive_released()
Date: Fri, 11 Apr 2025 14:41:09 +0200
Message-ID: <20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOUN+WcC/x3MQQrCMBAF0KuUWRtoQiLoVUTC2Hx1FrZhJi1C6
 d0NLt/m7WRQgdF12Emxickyd4TTQNOb5xeclG4KY0hj9N49olurNQV/8mJVssLQ8loLN7h0OU8
 IMXFhT/2oiqd8///tfhw/o5oPsG8AAAA=
X-Change-ID: 20250411-b4-upstream_ospi_reset_update-596ce245ada1
To: Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01

Add the released variant of devm_reset_control_array_get_exclusive().
Needed by spi-smt32-ospi driver as same reset line is also used also
by stm32-omm driver.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>

Changes in v2:
  - Rebased on spi/for-next (7a978d8fcf57).
  - Remove useless check on reset.
  - Add error handling on reset_control_acquire().
  - Link to v1: https://lore.kernel.org/all/20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com/

---
Patrice Chotard (2):
      reset: Add devm_reset_control_array_get_exclusive_released()
      spi: stm32-ospi: Make usage of reset_control_acquire/release() API

 drivers/spi/spi-stm32-ospi.c | 15 +++++++++------
 include/linux/reset.h        |  6 ++++++
 2 files changed, 15 insertions(+), 6 deletions(-)
---
base-commit: 7a978d8fcf57b283cb8c88dd4c9431502bd36ea8
change-id: 20250411-b4-upstream_ospi_reset_update-596ce245ada1

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>


