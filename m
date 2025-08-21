Return-Path: <linux-spi+bounces-9586-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ADC7B30210
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 20:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530C1167E1C
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 18:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77332BEC30;
	Thu, 21 Aug 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdTkHpZe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BCC25B30E
	for <linux-spi@vger.kernel.org>; Thu, 21 Aug 2025 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755800996; cv=none; b=EZPP2MQvu5xBpPja+LIswrxotM1GH+iF9eouhwbBa9FMXDaWSO8nvu7ZYA4hMWqZ8jJWKBM3QOri7piB+0zHfcxZ36W5mN10W9h4PKMqMo9AGTdIUFxvskx/RT3vVHT934Y795aV40uI9cLKeVFiiCyazpTY+lycdJZq+whY8Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755800996; c=relaxed/simple;
	bh=LTMk2b86nHemmdiwJuN9ZEF3oSA5bFCND8tken+Y5EM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NHrsTxZhbKf6SCX1+9s0/NLLfNSaN+kVY9BnikR8J69TANPRYbqdY3rymy3prWRBU80wFcBWbfcrykcBLQHMjhzfFU3KRhIgNzut67PDWV74z/Tj4lU6UhpKnXfYyiA69RorSi9oz9vYRfTcw9DkMBRkFhX1/1tUWiXj6l+41vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdTkHpZe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61509C4CEEB;
	Thu, 21 Aug 2025 18:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755800996;
	bh=LTMk2b86nHemmdiwJuN9ZEF3oSA5bFCND8tken+Y5EM=;
	h=Subject:From:Date:To:From;
	b=jdTkHpZeQ8jHd1YjUlEk9RV6vhDmQNhyrA8aY8GDQGaCrTupHRfAnnk3zYrpxpAVA
	 EY0d9XU/BmEN8ErxPH44W9CXEuyXB8lg9SZuHry0PY7iFDzGcshle3eJsHmDGKY2Y4
	 AUMxoi9L7NFr6zZPc0lzbAiekfb3ZstUiIrpLQU4mtchSm2hYyp0DmTofatNna4omX
	 jWhFS0/0WUUWsiqFy+UgmOnIdhIQfwfxx7eWWolSDeL7ZLTIWvjXgHgDK4ME5XA1EJ
	 9Znh6Ca6GsAnSIxsSIw/Ej79BBjqtWrzLQjTfjafF+fyr9CwBY8AhLYP6Nsl7sQqif
	 +wrOxhGWFwP1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1E2E383BF5B;
	Thu, 21 Aug 2025 18:30:06 +0000 (UTC)
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
 <175580100520.1143001.17310130815554751864.git-patchwork-summary@kernel.org>
Date: Thu, 21 Aug 2025 18:30:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: st: fix PM macros to use CONFIG_PM instead of CONFIG_PM_SLEEP
  Submitter: Raphael Gallais-Pou <rgallaispou@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=993647
  Lore link: https://lore.kernel.org/r/20250820180310.9605-1-rgallaispou@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



