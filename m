Return-Path: <linux-spi+bounces-8998-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DC9AF5959
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 15:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871DC17AD19
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551CD277035;
	Wed,  2 Jul 2025 13:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLPOxCsh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2927603B
	for <linux-spi@vger.kernel.org>; Wed,  2 Jul 2025 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751462990; cv=none; b=g+INYMrXDX0bZH8BNzb84YLLuBbv5OOZ+ldr1PNdW0A1pssEo8avELky0QN8XsTwM/3gmb15WnJwwEZxe8Bta2YLwS4nLRtvxJqKIOoc356VcpjmSg5JNl8vWCvKlACIg/t1rV8hn8/CWPp/LQsUWWA2ijWSR4jz+R1mRRo1DQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751462990; c=relaxed/simple;
	bh=pkSm0QA81kq+M5bi41ETPNJ7p8Hx7C0o0O45XD9P1lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=C24+CcA5EPlmYcsCNo4rGgwrbYqhV8PaAXyhTLmWB0tOdqccgkRQ/TPo0E5BCIG4RD+nwzrFT8sC6RoADOVd/gfzqgnmylCI0R2YCjz9XE46NgRcBOmnkw8vkWonLMNI5x3iCweDkzZJMvk/wj0Rg6VkmMW/ekbLSZwHhPD1PY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLPOxCsh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF36CC4CEED;
	Wed,  2 Jul 2025 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751462989;
	bh=pkSm0QA81kq+M5bi41ETPNJ7p8Hx7C0o0O45XD9P1lg=;
	h=Subject:From:Date:To:From;
	b=fLPOxCshSKlfyplWnWhceu9gQVc2fcqMNm+Un9Dl/+JRhEmfGCJFgoVrgX2mikrWb
	 tzz68LgPH1trkaffiyKJrRPUYXP3Jk20GZJMELwwForCUTzHV4gtwsVVFXwTdp0Bp0
	 B0MsaFHx3TPBqdWYShY1D74mPFZKweJvU3wJ0nP33UMyvBHYH3HQJHPy7YZKMc6Jjf
	 AZZIGc+JXlJY3KhT1AIpHFpNu3tmez2EsBzXNpQFY3GsnQJbUUSNpHC0UpUJnALxCR
	 SuUAOiebV91Svfdz/VmI3n/CsAJsZBmZNI27HjOi6hnpDZgXnsFl77ETxA7mLZLnKv
	 YnfjAJu4c08sA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74C98383B273;
	Wed,  2 Jul 2025 13:30:15 +0000 (UTC)
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
 <175146301404.719564.5103060221410048792.git-patchwork-summary@kernel.org>
Date: Wed, 02 Jul 2025 13:30:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: iio: adc: ad7173: add SPI offload support
  Submitter: David Lechner <dlechner@baylibre.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=977925
  Lore link: https://lore.kernel.org/r/20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com
    Patches: [v3,01/12] iio: adc: ad_sigma_delta: don't overallocate scan buffer
             [v3,09/12] dt-bindings: trigger-source: add ADI Util Sigma-Delta SPI


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



