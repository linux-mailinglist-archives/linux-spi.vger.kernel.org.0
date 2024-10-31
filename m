Return-Path: <linux-spi+bounces-5577-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE0A9B8316
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 20:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925BA1F22C15
	for <lists+linux-spi@lfdr.de>; Thu, 31 Oct 2024 19:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C4919D089;
	Thu, 31 Oct 2024 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH506s7a"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBF813C8FF
	for <linux-spi@vger.kernel.org>; Thu, 31 Oct 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401824; cv=none; b=mbnBqiIHocsGkvpHFxKmjASropQCY+U1lF2t9Tc1OEyAQw04J2Xc88ibAFZz5G3PQ+GL4LVJn7t4HcQRcLT45JUx2xPBi2hGLEbtTOQy5V14wlVuuxVrEYrFmLh2+HnAcOtdvYDLN+0auL23ITpGhrn1/QhklkD7EyP+725K8mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401824; c=relaxed/simple;
	bh=6PkBJQMpp22sKgWJBfsUkdubFDQrytl2Fmb2wPbE1Ik=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Nd455kAB8WmpVWHOzqx0MLlDI+EY/457wn5KQjCYBHLSryaqMRi7x6U1DzxWbV9Wr4NmSpzsAukbCyBNgN51IzmkNEj6pxrx53f2mJRQGuRLB6uSKnYYofBQTeWHj889hwYHCTAz4AHGnyGuUtV2ETj5+UHaE2bKEbWUr+rIA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH506s7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD1FC4CEC3;
	Thu, 31 Oct 2024 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730401823;
	bh=6PkBJQMpp22sKgWJBfsUkdubFDQrytl2Fmb2wPbE1Ik=;
	h=Subject:From:Date:To:From;
	b=FH506s7aAP0UYP/xfpNy+Gln8Q6cQ8R3Gzhs1cGNjxaGWRdROuS/SIrVR8qfI6VyB
	 r99ws01W6wljYfoEqDXL/KAsMzp83T2BPrJALvQ4Tl7fF6nWI/5Cak4L5QIBusfy6a
	 mavSqakBMnHDfCtZM0mHd/391ErZDc9RcDSwOPwhg+FcEJikd5YcBb+DUcY8dt5urb
	 KaDUyuXObOP7jeSaZFLfaUF+BzNZUbf0I1HytA2DEh+KyQo0S4Udr/+3bp67QbUBs+
	 y9/pui6gDj8oprVYBvkg+z3o3UkTnJYAl5/q6hZR5Gt4nMKev1HC105cZ7jYEJMLXW
	 9RG2JsmwqYjDQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7632F380AC0A;
	Thu, 31 Oct 2024 19:10:32 +0000 (UTC)
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
 <173040183088.2061780.9124859005299028066.git-patchwork-summary@kernel.org>
Date: Thu, 31 Oct 2024 19:10:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: dt-bindings: spi: sprd,sc9860-spi: convert to YAML
  Submitter: Stanislav Jakubek <stano.jakubek@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=904559
  Lore link: https://lore.kernel.org/r/ZyH2P3FlneLtGxXo@standask-GA-A55M-S2HP


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



