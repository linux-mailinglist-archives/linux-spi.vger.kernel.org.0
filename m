Return-Path: <linux-spi+bounces-9762-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E757B3B256
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 07:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3A4116B2A5
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 05:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE1D1A2547;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU9pdo1P"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA2BC8EB;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756444580; cv=none; b=PhgI30AIQiC0itpat84xwODoIXPheo1HvxeF154pmudgIVAciBGzG/iSr/teFeVqOIDsmiQDzVNsTdBnYM9FKkGxniMqAcW3pL+FbyVuG7JBk5wVNM3IzUu9uag0jIm9Wy100op1z1gvR/jftx2tLZeoZFPAlsrIw2Fdf4fH6uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756444580; c=relaxed/simple;
	bh=0HKyVc11qco89SpE9cjbxY8QuDwSLcwJI37c2AqdRc0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZHpD2UW14+NIEuCELXAy3r83QMXmV7X+wwb1WviqgYUeltpQOtodnfLJD43dtSDDQmWxdf04PIUmmvGy/QFteMsQT1ynbMh3AqWhkg/PsmkRwU107GTvNJh7A9WfkCtsXOxk76GTfjUaiiH8np7e0kQ0TTULHnq1Q0Cqu2ZxL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU9pdo1P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2656DC4CEF0;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756444580;
	bh=0HKyVc11qco89SpE9cjbxY8QuDwSLcwJI37c2AqdRc0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=IU9pdo1PhtN49YoO/AGgqnybEO6IhVkc9okPWxz5gaojeYCSdzUVwFmy5RmnItvC1
	 urd3Oq1jvGEQcSYITTNrfkqGHtdaaS2NTLHaJbXKBNgOw6EP1ntTCefbQpaoNKGzxg
	 zinYPz8OZtCsiYIujazT0O1DPyjUT/mSR1bYbNyOxKSD5SfoJOfxbx4WjdDbsAdn98
	 yKSt8C3bxEiIks7CKmAAUl/sD9adoCr0OKVWuPEg9aYbHpHi5ADhGBoX2zTN7pE83z
	 e21dMjOqVPB5sSQZFkWawNZT5AJTjiZXHqK0tNXjo1UtiTkox1tGH6rO0OhEjGKCRT
	 q9g8KTkfEd4pg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265DCA0EED;
	Fri, 29 Aug 2025 05:16:20 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v4 0/3] support for Amlogic SPI Flash Controller IP
Date: Fri, 29 Aug 2025 13:16:12 +0800
Message-Id: <20250829-spifc-v4-0-1e57fd39f584@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJw3sWgC/2XMTQqDMBCG4atI1k3Jv9pV71G6MHGigWokKaFFv
 HujVLB0+Q3zvDOKEBxEdClmFCC56PyYhzgVyPTN2AF2bd6IESZJRQSOk7MGy1JR4NJqoBbl3ym
 Ada+tc7vn3bv49OG9ZRNdr3uh+hYSxQRbK4ATYKpR+toMD985czZ+QGsjsYNjdHcsO01pbZXQ0
 pD63/GjU7vj2ZVQM0UEbUurft2yLB+PAWnpDAEAAA==
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>, 
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756444577; l=1779;
 i=xianwei.zhao@amlogic.com; s=20231208; h=from:subject:message-id;
 bh=0HKyVc11qco89SpE9cjbxY8QuDwSLcwJI37c2AqdRc0=;
 b=UyfouoSwtVHlx1WRl75VGX6HTe6cWganyLSUw2IaoA+5TsZrKiSTg9OTDDON4+ckzjoF/oKb1
 Up6EETv31mdA+wjJVvFt27zDU2SLgzRMvWFJIOu6x+5wXCuuJ/+0v/H
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=o4fDH8ZXL6xQg5h17eNzRljf6pwZHWWjqcOSsj3dW24=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20231208 with
 auth_id=107
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

This Flash Controller is derived by adding an SPI path to the original
raw NAND controller. This controller supports two modes: raw mode and
SPI mode. The raw mode has already been implemented in the community
(drivers/mtd/nand/raw/meson_nand.c).
This submission supports the SPI mode.

Add the drivers and bindings corresponding to the SPI Flash Controller.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v4:
- Reword desc of 'amlogic, rx-adj' in bingding file.
- Link to v3: https://lore.kernel.org/r/20250826-spifc-v3-0-7e926041d7f6@amlogic.com

Changes in v3:
- Restore message description and modify subject [1/3] that was omitted in v2. 
- Link to v2: https://lore.kernel.org/r/20250821-spifc-v2-0-b119f64b5c09@amlogic.com

Changes in v2:
- Remove clock reg descriptor and get clock from common clk.
- Remove ecc and ramdom descriptor in bindings.
- Modify the format and message description.
- Link to v1: https://lore.kernel.org/r/20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com

---
Feng Chen (2):
      spi: dt-bindings: add Amlogic A113L2 SFC
      spi: amlogic: add driver for Amlogic SPI Flash Controller

Xianwei Zhao (1):
      MAINTAINERS: Add an entry for Amlogic spifc driver

 .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  |   82 ++
 MAINTAINERS                                        |   10 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-amlogic-spifc-a4.c                 | 1224 ++++++++++++++++++++
 5 files changed, 1327 insertions(+)
---
base-commit: f8b3f0d7b2a91ba84d06343c3ca4522e35a65f56
change-id: 20250804-spifc-5761e35fbe1f

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>



