Return-Path: <linux-spi+bounces-2383-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC5C8A79BF
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 02:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659882845DA
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 00:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0C196;
	Wed, 17 Apr 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pE7wbfWC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992C364
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713313231; cv=none; b=CFpFeAaDO+xgK2iu91DcA3YoHjiLl/7MW22nC2GyOYo2vcglh7ADr5kl5QdQbopXL6V3iH92d+L/zUmmAjBxp/mSWrqgDK9+ui6XS3+crt7Mo4On0aktf/rOq6nDhmwh7PDmfsimlReK5zAPCspWTjS87VfYyq4XtIFhNGIRja8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713313231; c=relaxed/simple;
	bh=1GUwzJ0JeTcyuIhWqPI7UBq2Ej5bSauQy7/UfW3dQ8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OdMS4gDrOUARjMvKkxTzKKhmzeI8/Fd3lbAf5yEdwZv3uMNUWSXyowv6d12LiqQTreaWrt5y0uH7IFbp7UrWjftYLOBTR0itJ0n59t4NCZkzMx/0DIj/gqgR1bUDy+kiWmf+NHy4+yniXxqgr8Qq9W1y1Wwh36WACt+D2F26B5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pE7wbfWC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F37FC113CE;
	Wed, 17 Apr 2024 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713313231;
	bh=1GUwzJ0JeTcyuIhWqPI7UBq2Ej5bSauQy7/UfW3dQ8E=;
	h=Subject:From:Date:To:From;
	b=pE7wbfWCu3i1bGRjkQ52YVGzaznz5z/cW0YCCf26KzUhySqIgPphQZcFcvvoSJvT6
	 f9Demnh4ZBNj/y4m08WwHR3IN9fGfdUBVOsX11azmoURQ20YpaXahGQJrJLwoBK7xn
	 cXljJmRhNsMmzQK+NTNl7AhPkZK/sOtohDMlFLMBCIaq9BdDRpnOksshP2F8B8M7Tz
	 3xBqwtUT7fBTP/5vJtB25TUzSoVASqwnHIwmD8REF0a7TNUbaBG/xsQD1r//clWDSL
	 goFeIUFaffDoYKVX3431WYdwqqimt2nDrnASdpMwYyQcqTXMTTqcAR6+8gdTgPavWz
	 8cpzDQq+0IzIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2D0F8D4F15D;
	Wed, 17 Apr 2024 00:20:31 +0000 (UTC)
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
 <171331323113.29224.15352342284342840735.git-patchwork-summary@kernel.org>
Date: Wed, 17 Apr 2024 00:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: More refacroings after multi-CS support
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=844775
  Lore link: https://lore.kernel.org/r/20240415193340.1279360-1-andriy.shevchenko@linux.intel.com
    Patches: [v1,1/2] spi: Extract spi_toggle_csgpiod() helper for better maintanance
             [v1,2/2] spi: Introduce spi_for_each_valid_cs() in order of deduplication


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



