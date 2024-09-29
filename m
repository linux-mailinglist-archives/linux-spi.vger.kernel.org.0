Return-Path: <linux-spi+bounces-5034-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A824B9894A6
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 11:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19A9283153
	for <lists+linux-spi@lfdr.de>; Sun, 29 Sep 2024 09:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F21474D8;
	Sun, 29 Sep 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gIf8yz8o"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D147184D
	for <linux-spi@vger.kernel.org>; Sun, 29 Sep 2024 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727603792; cv=none; b=S8k8QzIycw/o9iVN+zDpd1Whl8Sn2IVaeBBtJHVoPznN4MvGQd7egLQc0PShdMZ/AdAUaq5hLdKW1j2iU72eVDMr1XmGCDDL8P9QGmGtHs+vyWDAuViSUe+2uS7SVWY/+J4QHwIV/fN27DYKw6xBArLenIRUyI9iS2bH+BlZHF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727603792; c=relaxed/simple;
	bh=QHnnaPc3wCy4VAlbEsFYlYTDFdIb/1X3oRYhFEP2Vz0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TBM6baV56oLSUEEwM19z3tTTVSBYhc2ZKbIzFR34tImnMEKzRuJK9lR9VNvuqE2zOe9uua7GsxJwP50CTCrRIGr1rauDpYwkijZVkH3qL8p1Cy/8wgePC1A31UFxGHf2CzIbDDYkKkFBUo5HZqPVaLKi9hek5/x0CyMga6u3yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gIf8yz8o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89EFC4CEC5;
	Sun, 29 Sep 2024 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727603791;
	bh=QHnnaPc3wCy4VAlbEsFYlYTDFdIb/1X3oRYhFEP2Vz0=;
	h=Subject:From:Date:To:From;
	b=gIf8yz8oDhsxSx0F0zrb6oSxhXnqtzmRikIyY2n9e2MIrNBdkjk6Cp2q/kuMMCtak
	 aDJRvL9RoaNRg+lv0cMKXOqRAZIhAp2pHrskrd0yuNPqkTU9K5AeQUXK5II3t49KJH
	 XI9mPW8rtkUab3m355IehnidSZcu5CK8XbKaYCebV4eF/5jt9s4FjAiLR/ZYqoRfZ1
	 O+FRwYwAkyVpHTxOj67+4K+h/OP4pl5hWz2h+/vv5yW3t0J0YEWlmiyZr0g0Fkz/A7
	 blbojAOHTyS1zIdsONF19f3GRMbzem3PKFsWuMJcDvGa3zmidm+2UAIxgrC1MGBIdM
	 N45vJ4vEhtrwQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0A83809A80;
	Sun, 29 Sep 2024 09:56:35 +0000 (UTC)
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
 <172760379440.2483355.5565692252412099601.git-patchwork-housekeeping@kernel.org>
Date: Sun, 29 Sep 2024 09:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add dev_warn_probe() and improve error handling in Rockchip SPI drivers (2024-09-29T09:21:14)
  Superseding: [v2] Add dev_warn_probe() and improve error handling in Rockchip SPI drivers (2024-09-28T04:12:45):
    [v2,1/5] spi: rockchip: Perform trivial code cleanups
    [v2,2/5] spi: rockchip-sfc: Perform trivial code cleanups
    [v2,3/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
    [v2,4/5] driver core: Add device probe log helper dev_warn_probe()
    [v2,5/5] spi: rockchip: Use dev_{err,warn}_probe() in the probe path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


