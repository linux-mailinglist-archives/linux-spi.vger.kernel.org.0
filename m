Return-Path: <linux-spi+bounces-8243-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D538FAC0DEA
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125153BB985
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523A523875D;
	Thu, 22 May 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2e5ThCc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF591F09B3
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923592; cv=none; b=SCkBiTi0YudMs7Dd8fiOHvZdhX14SGWlYzzHMRBNML3gHwHrVAH98TSitZE0pm5ysx/YBWKvIWrtcYHitUReo/ZGDwfCRFgGeT3b/QSCg1cKdHTVfc6P0173Uw8J25r9k35GeAhl1FdMt7HM3eP56t8hB3U2D537jYRtNIxBdo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923592; c=relaxed/simple;
	bh=ZKcfGLUfR47DniC11oPsPPeRNV7eBclKhwi8JqBFryo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=og4AQCsiZI/Yq8i8SqPNfmmaNaS18jJOaDk/+LWYnM9qzrHsO0IJh8bwRWyDTBUYWtr/mMdO2FjWw6gRCNicBV6z3uSMtGHAWo2e2axl9hFiXvfwHWpw4rU0mXMTOjw8S4o2mjI8XaP+bBUEbKFcEwasyXN5Q/zAHgV/GY1HRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2e5ThCc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91625C4CEEB;
	Thu, 22 May 2025 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747923591;
	bh=ZKcfGLUfR47DniC11oPsPPeRNV7eBclKhwi8JqBFryo=;
	h=Subject:From:Date:To:From;
	b=M2e5ThCc9qiux+1+kjgIgb5eThqmTSVi9sSw5vrmWRd+WDQ1qctRBqGhfU5wgERqk
	 r9Y8t2VhdnB8jP9R+gRGqasrAJUsmSJBACH4J/QxkwabjxxrttHlmqAxdzrfdz/WDP
	 K3ziiIhSuYZerPkHJos7PZNJXDld5Ja2FAl5Ms/9UA+F+17RpFtwNsAH+xY0JjDU2b
	 QsLhCf0E1CXZgQT/qNCN36QqGusRiOKBIYkcoYayc5jgwkX+w0Yb3hLDE9w6coTIp5
	 TTIcr4yrpU6ae6e797o2JsbN0wKNcfp2RRreXX1qZUrwK3WoZbd9OyK6n4iusCTzww
	 T9RKwRdCg4z0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3739E3805D89;
	Thu, 22 May 2025 14:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174792362681.2892270.4785637631848548867.git-patchwork-summary@kernel.org>
Date: Thu, 22 May 2025 14:20:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: use container_of_cont() for to_spi_device()
  Submitter: Greg KH <gregkh@linuxfoundation.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=965363
  Lore link: https://lore.kernel.org/r/2025052230-fidgeting-stooge-66f5@gregkh


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



