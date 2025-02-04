Return-Path: <linux-spi+bounces-6621-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF874A27B0B
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 20:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765B51623CE
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2025 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF57204F85;
	Tue,  4 Feb 2025 19:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmBShfQZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCA816D4E6
	for <linux-spi@vger.kernel.org>; Tue,  4 Feb 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738696808; cv=none; b=PwHtmdoYsGfPWZq06IkF8hlF/Z8RiK2cOF/zVjVOZPihICFY68GIDMjUxsnutYdaVhBVl2bhjwxUCgirjerZP2TzOV/wvYEjlGirGXILPOmV2GL98/TAqYPEBMnK9AoeIWoBjfHnFKRqAffFUCdGOYZDEyJOFkUTjUH7/RSRBz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738696808; c=relaxed/simple;
	bh=nD1t7Ez7mo1GoOhIV3HWow8ZPtATXfNxLa3fvQE4Q/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YdjeBKJ1LIFv6fCVXnfob/lJxWv1Dy/eP4N36c6aLRfnySOR+ypw39mCurkMY6AZHtWf20GxvcRwh0Lq9jkFF8zu1NJ4Xq8F36xsaxSV4y3foz9ToeTWeR76/7GwK1RbIBmgHcta3pnizD1d73MSOo/P2ojaDaDMkdOSsQ2jE7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmBShfQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623DEC4CEDF;
	Tue,  4 Feb 2025 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738696807;
	bh=nD1t7Ez7mo1GoOhIV3HWow8ZPtATXfNxLa3fvQE4Q/g=;
	h=Subject:From:Date:To:From;
	b=SmBShfQZsO5zpui9ldtCzSN2NhH0ZxdnVUKYShz9hofsuQltzW8c5dDuGQQfiI/Rw
	 4JCpkUIhH/vo1J4usB334iCthU8LthJ00BrjXh+yXnPxYBbAemEumsw4VKjCm9PiIp
	 QnHY/u64hVC6h9gYrrwbxOa0L14e4UCz5OGFfykqgM6LfxncNJNiB3Rqll5qUIIlCg
	 JghbGlVdF3P5L5WCw6G8LuEF9IfRxfi1QXsT2UQCDFNPC1igoM6Bz25lTqNLk9GY+s
	 Tidon1dRfU7gE7mzzLdr7ePKPu28GKF8r3CXLrmVf8sTmxEx1gYQ/kzgjALoFsJzr8
	 kW48kloZtJq4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B6DDB380AA7E;
	Tue,  4 Feb 2025 19:20:35 +0000 (UTC)
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
 <173869683412.114684.9102931538499197114.git-patchwork-summary@kernel.org>
Date: Tue, 04 Feb 2025 19:20:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [for-6.14] spi: atmel-quadspi: Fix warning in doc-comment
  Submitter: Csókás, Bence <csokas.bence@prolan.hu>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=930056
  Lore link: https://lore.kernel.org/r/20250203151249.79876-2-csokas.bence@prolan.hu


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



