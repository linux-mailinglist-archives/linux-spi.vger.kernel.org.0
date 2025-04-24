Return-Path: <linux-spi+bounces-7727-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF256A99E96
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 04:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F37C8445AAB
	for <lists+linux-spi@lfdr.de>; Thu, 24 Apr 2025 02:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68BA5282E1;
	Thu, 24 Apr 2025 02:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5GPV34l"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359644A29;
	Thu, 24 Apr 2025 02:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745460213; cv=none; b=SICKQ7+saZPlCX2bFTBbi6BpdL0f+q/K7sLdr1cNeYrvxvUqUBgXVpwEhc77VpPMNbu38QU/nov4SDyKHv1DkQOH4hc2MZgihGBT6lTkNPTwcW9pSd/ahOq0VzAUfTSn/C+5EdfU50LWUiuBZyh/OjyruMaY2prkHzphXofSR8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745460213; c=relaxed/simple;
	bh=frVu7i0unayAF/vcXkdvWuD/HBqvYDiTRKb7kPsqwZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lsPKz3WjND+PtD5C6oxa0VY9SgPg5ftZJYCACLqEKOn3Yj0PwJ4MimpuxgrsXK8FbfwYuq3KvXGAxhhBqKIorWUNRKmTdGKsAlIXJlG9V3AEf/sK/ms2Krrq+HRMskp9cWUcelHSExa/zNAe3XgytE/bpIzjXrwb2tAtLjUuMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5GPV34l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9512EC4CEE2;
	Thu, 24 Apr 2025 02:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745460211;
	bh=frVu7i0unayAF/vcXkdvWuD/HBqvYDiTRKb7kPsqwZ0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=I5GPV34lkCde7VRTCkep1A6AhE40s0M2I7Od+Y67CebqFH2knsHoxGY6YpztwoZCZ
	 8K95mM3nVAjfNuf2Cd1kSd++IaLpRIeeG5MSqlXXP2ZUBq+ZOqzzoL1M/l5yuh8DTk
	 rLjoHLXXedcFY39t14Ifb+OKbIiFUWsE5Uxd/vC6jcISK7ycSU2FtMIXWCIzfPQ7hh
	 kZ/t+0bR2xp/3IPb0tVlfkoDZoAjXevWgBPmsl9RG4/Pmwxg0L65qK+oPmDDaTfrKX
	 5iQkVyVSKErWqxPcsjzPPzjoNXtOAx7ULBOXV1lJF/EDtYyR4rfJCHbUqlbfF/i2Fl
	 WljVyTl2dtlWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B52C369CB;
	Thu, 24 Apr 2025 02:03:31 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Wed, 23 Apr 2025 21:03:03 -0500
Subject: [PATCH] spi: tegra114: Don't fail set_cs_timing when delays are
 zero
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com>
X-B4-Tracking: v=1; b=H4sIANabCWgC/x3MTQqAIBBA4avIrBP8Bekq0cJstNmYaEQg3T1p+
 S3e69CwEjaYWYeKNzU684CcGITD54Sc9mFQQllhlOatEL8wVS+l4ZtzTrlgg4gaRlIqRnr+3bK
 +7wfRnhCvXgAAAA==
X-Change-ID: 20250423-spi-tegra114-b88828c5c0f3
To: Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mason Zhang <Mason.Zhang@mediatek.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745460211; l=1447;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=6Ntl3heYOtSRo+SbZlaWWlJ/8sphcbur4awnUfzmiKk=;
 b=UngeTiHC4/irfiREWVxaOQlDY8BZIa8YqVXnNAGy9+5094zQFFqJTZfL0x7LsHsqt4Xzi66Qi
 /gjS63hepyMAYsfBK0t3ZXzr3Aqn7BW9OywpDOqR/OVYdI1zkQ1Jluu
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

The original code would skip null delay pointers, but when the pointers
were converted to point within the spi_device struct, the check was not
updated to skip delays of zero. Hence all spi devices that didn't set
delays would fail to probe.

Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 drivers/spi/spi-tegra114.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 3822d7c8d8edb9730e937df50d1c75e095dd18ec..2a8bb798e95b954fe573f1c50445ed2e7fcbfd78 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
 	u32 inactive_cycles;
 	u8 cs_state;
 
-	if (setup->unit != SPI_DELAY_UNIT_SCK ||
-	    hold->unit != SPI_DELAY_UNIT_SCK ||
-	    inactive->unit != SPI_DELAY_UNIT_SCK) {
+	if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
+	    (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
+	    (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {
 		dev_err(&spi->dev,
 			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
 			SPI_DELAY_UNIT_SCK);

---
base-commit: a79be02bba5c31f967885c7f3bf3a756d77d11d9
change-id: 20250423-spi-tegra114-b88828c5c0f3

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>



