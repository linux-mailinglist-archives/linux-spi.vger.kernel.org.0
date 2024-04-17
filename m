Return-Path: <linux-spi+bounces-2409-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF418A8299
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 13:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB12AB242B0
	for <lists+linux-spi@lfdr.de>; Wed, 17 Apr 2024 11:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2C13CF9D;
	Wed, 17 Apr 2024 11:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m70uLdAW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245313CF94
	for <linux-spi@vger.kernel.org>; Wed, 17 Apr 2024 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355033; cv=none; b=enw76iB5dVEG2/C3i3x36SH/Xqu3hm6X4NEDEKAu9z/tZOpAnzmsHFdftYqKFtULY0v5IV0MYA8fvhOpdYrMYpNJM+soK6fthq2zNeJR51fyVIkH3z3QkdSQwlhu28j3BqdkRCwtI9DRMHoV3yf9c46FQs1BDFgvJINXgDQqN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355033; c=relaxed/simple;
	bh=b8pmpBfcsEwtmeo67Ipy8OSeEVN1ZQkGn9f75rgcaxI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=igWqrRl3xF1lZhzMb+D3s246n3idXBtxqEa1x8vYsjHWxEfnEhUsvWEuG+/xwT70Wf5yNFcSf99dugU8h2qS48/A1xWlYO6zP16edTgqSX2ICXcLocWJcdmjSr3ZZio2BFGh9+JmDJU1ortVt9PWjqexMEW7Egp0rHSd/TL22Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m70uLdAW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 778CDC2BD10;
	Wed, 17 Apr 2024 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713355032;
	bh=b8pmpBfcsEwtmeo67Ipy8OSeEVN1ZQkGn9f75rgcaxI=;
	h=Subject:From:Date:To:From;
	b=m70uLdAWNOzy81HMFPg3zQvLPCJLpopWy53Z4VjDaiU2I+jau1kjCzfZnakkc7G4+
	 +Mpk3gVJbqChND0imHt2VGkhV57TgKj4UqZhTB6f98xkay6yUsj3FgE63cbSqDFuHI
	 4mpzC5WZAuxLu8olrlTqwwV7yO/f8t4duCSAXhOtBydRQ5RBpH8qsAdRi4YigDTxo8
	 UdUDyMj2BJYb+b2ll3E4sQW6ddaxR1rNs/Z1dGrBx7LEhOk9ElnEa2wJkdw38uI9+u
	 r2WlQnSAKNeLybsKFjMd9e2caHR+Q02haMFvCCtu6BZXyIaRgSSP2dBJhxhsTNsGAu
	 annoMx60imWWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 65B56D5B3FD;
	Wed, 17 Apr 2024 11:57:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <171335503241.23172.4310499621969996668.git-patchwork-housekeeping@kernel.org>
Date: Wed, 17 Apr 2024 11:57:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h (2024-04-17T10:54:28)
  Superseding: [v2] spi: pxa2xx: Drop linux/spi/pxa2xx_spi.h (2024-03-27T19:29:20):
    [v2,1/9] spi: pxa2xx: Narrow the Kconfig option visibility
    [v2,2/9] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
    [v2,3/9] spi: pxa2xx: Extract pxa2xx_spi_init_ssp() helper
    [v2,4/9] spi: pxa2xx: Skip SSP initialization if it's done elsewhere
    [v2,5/9] spi: pxa2xx: Allow number of chip select pins to be read from property
    [v2,6/9] spi: pxa2xx: Provide num-cs for Sharp PDAs via device properties
    [v2,7/9] spi: pxa2xx: Move contents of linux/spi/pxa2xx_spi.h to a local one
    [v2,8/9] spi: pxa2xx: Remove outdated documentation
    [v2,9/9] spi: pxa2xx: Don't use "proxy" headers


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


