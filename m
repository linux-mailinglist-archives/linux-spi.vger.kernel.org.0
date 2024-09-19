Return-Path: <linux-spi+bounces-4888-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3094397CCC4
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 18:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A11F1B2113D
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 16:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033C219F433;
	Thu, 19 Sep 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjeH7S+K"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D393A19992E
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 16:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765071; cv=none; b=mTIXQ0avpbu3eOgPfBT/XtubV629Cfe7ZORMnZGtqbcv26GU0XL6hMQgZABdLf02qTmhO1j6PXUhl9Y3pZ9dGizYyT5pQA6qHeBOCfAgeRkIcE7aH6hU+eQ5bqyV2Qf63ZlkzOGJvbk4jAcNKV6Nn1kp7btD8Jj7pcrt53hDKcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765071; c=relaxed/simple;
	bh=2wBsVemxnucLVjjWLtWlWIo9BgP7+shmVOdBCmN7i+8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LNaVsOr/2zrV07y3xgeElACIBYLwBhOkkj6T6YMOLWHoqxR2DgrYYuvaewpM+J8vYA/QQBQOYS0LctOvd7IEjyNU7F2+SGeOn4/MZ3Ro2f9d9OlqNer/t0xSWUrAZi0KBfljmGKfUGp0vtaf4feJDMryPfBQdyXAo5hMlleUrlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjeH7S+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED662C4CEC4;
	Thu, 19 Sep 2024 16:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765071;
	bh=2wBsVemxnucLVjjWLtWlWIo9BgP7+shmVOdBCmN7i+8=;
	h=From:Subject:Date:To:Cc:From;
	b=jjeH7S+KEPw+ljQvf601o703h/21Txa8lABPxhFnMMTeAzX+G3P22MwF55sQFl129
	 2LqByD2UUh4D3twjfvmkySq+9fDQrORnqwkqEWOUQbQ50G8yMF11CnY1KcPYAnLkgt
	 zYMk43Ct2EMOfObT4O9onPtvtcZVs4AIfZ9gdXrAvulbJWWjP7+wokhIGc7Fz7CHiS
	 9JUg14zi5IFb7nTEOdRERu8PH8b0Wy54/R859f+Z8ciQYRD8TMRscocX8KoEVFv8Mg
	 AyKrOzdQa/plNS4qzvfXlJxBAcQjtrbUStyaVt1PclS7L0XlU/sUuh7hFyOHQB11nu
	 oc6HoF3D9D1DA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 0/2] spi: airoha: Fix errors reported by mtd_test kernel
 modules
Date: Thu, 19 Sep 2024 18:57:15 +0200
Message-Id: <20240919-airoha-spi-fixes-v2-0-cb0f0ed9920a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtX7GYC/32NQQrCMBBFr1Jm7UiaxkhdeQ/pIjGTZlCaMpGil
 N7d2AO4fP/z/l+hkDAVuDQrCC1cOE8V9KGBe3LTSMihMmiljerbDh1LTg7LzBj5TQVP1nvTqej
 7PkLVZqG9qNZtqJy4vLJ89oel/aV/xpYWFQbSdDYUjLXm+iCZ6HnMMsKwbdsXZJE/6LEAAAA=
To: Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>, 
 Mark Brown <broonie@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 upstream@airoha.com
X-Mailer: b4 0.14.1

Fix errors detected running mtd_test kernel test modules.

---
Changes in v2:
- repost patch 3/4 and 4/4 improving commit log
- Link to v1: https://lore.kernel.org/r/20240913-airoha-spi-fixes-v1-0-de2e74ed4664@kernel.org

---
Lorenzo Bianconi (2):
      spi: airoha: remove read cache in airoha_snand_dirmap_read()
      spi: airoha: do not keep {tx,rx} dma buffer always mapped

 drivers/spi/spi-airoha-snfi.c | 173 +++++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 104 deletions(-)
---
base-commit: 220bc4acfbc26376962b155db5160de942a5e4cf
change-id: 20240913-airoha-spi-fixes-56bb430fb99f

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


