Return-Path: <linux-spi+bounces-1170-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A0684CE11
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B2F1F26B7D
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D3F7FBAD;
	Wed,  7 Feb 2024 15:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NShl4Fqf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54E7FBAB
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 15:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319828; cv=none; b=JQT0dKD16O2figBSkIZgPJ/bONki8Y3iNr72QlQqM2SEOvFTE6ITks3EN+ZQLbF79vwewEG2wgLvYpQmCK2lHH901QH5o9GLIvfVKFJNAPoGsV6xwhtoCQDTl5HxROCk0HGWO1MYTk+ddc0uyDM37z+fyZLRdF2yQrHaM0Rdwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319828; c=relaxed/simple;
	bh=1sbkV8I4ZxVPWrLA+ZjZaSmTyvInOEuo+GE9uLol9OQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=axle8xBe9UYKfINdQLhZFr1IF4vunXzMP/gTV1IccXdsTEMBVsfG8KxOu8knI8+Z0yE9ljpAARrUHJkP464Io5meYC8WG1EwU3mhDdJuMgmo782gFV94b/WPSpkOvihuId382DYgoQyqvIOlYlYH7Pf77jwd2CibV3JEeEAwTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NShl4Fqf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A085AC433C7;
	Wed,  7 Feb 2024 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707319827;
	bh=1sbkV8I4ZxVPWrLA+ZjZaSmTyvInOEuo+GE9uLol9OQ=;
	h=Subject:From:Date:To:From;
	b=NShl4FqfTOBWvP4lAAVgs24d/0lrqkXJMm7mHpkZmu1MS34hqq2LUK+zg2ERxEheM
	 uREV0cO3a/OKUx/BSwFVvqooW8QUOQoVXXWhrInsHM86DRzhMu3ITaf5OwAaXZFpfw
	 EEWKpLQLoJh1OBdHyMKfcEmQ4sPqPlfJ169iYxur2lw/AZ+Jr1NQ3zQXBXA0FnNcpW
	 uIGHGZo7mJXr2o4BKxQJL79n2abnJLw3CJXUWajVb8bsUX0qdRYT3MCVvtSm68XECa
	 0mPDAN0MdTdudFkYzTs98N1nZ7e/HjlY7Bwv6cA7ZgQ6neQui7i4ueeLX8yg1tFafV
	 jsLzNUIV8GJDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C387E2F2F1;
	Wed,  7 Feb 2024 15:30:27 +0000 (UTC)
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
 <170731982742.17981.18058993961811341070.git-patchwork-summary@kernel.org>
Date: Wed, 07 Feb 2024 15:30:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: drop gpf arg from __spi_split_transfer_maxsize()
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=823724
  Lore link: https://lore.kernel.org/r/20240206200648.1782234-1-dlechner@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



