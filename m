Return-Path: <linux-spi+bounces-4476-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B39966756
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 18:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A7DB27671
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05009192D98;
	Fri, 30 Aug 2024 16:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/uAuC4+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167A18E34F
	for <linux-spi@vger.kernel.org>; Fri, 30 Aug 2024 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725036628; cv=none; b=NNyzNplhKWtBHPuohIWHRR/71xb9k9Pxa22lek2l+jflZCY0cNi+35+uYMn7hoiXd0Nzt+8LjdjhdKp8e0lVFgm4p44tCm+aDmZfascdllAKvrhmaP+yE0CYSt2F8T8A6CSoj9a2OJj/BVtp/cPE3M/RJhYoDJQyBggZc7RasgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725036628; c=relaxed/simple;
	bh=D9zxo9Wz5mIOGLPKjrBh55Ov00VtLNRRN0kcwCgNLlc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W0/eLiETHSJkkwFBOrimDtYbuiu33Ogo8ZHQeaUf36y1K7UYXRzc26u4cEOc3+B1z55dV5oMwDAmwyOFVHECuWdXJacs65S62L0bYUA27rRY1PwKVC2CysbhvE3FC2FPD3TtCEUn01JUC7kAmkNSXQnzbulYr9tN09yAbgoTVl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/uAuC4+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EC9C4CEC2;
	Fri, 30 Aug 2024 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725036628;
	bh=D9zxo9Wz5mIOGLPKjrBh55Ov00VtLNRRN0kcwCgNLlc=;
	h=Subject:From:Date:To:From;
	b=K/uAuC4+Ksh7F6dbUfqJYTVBMeeKKKAjNVIOS2JitN8F3UDqY6oadhJ653BOs3Q13
	 mAapkNYOvM2LTBJiyCXw7NjQeb94rCVo77zdwV8VXaO9kUgYFti6U9y19xYmmndl1g
	 PH1TbnwEVTqKq8bJMl8UNFcW5y1Pmyud5bBY+2UfjDFWM8YdiwgfDYRUHk1qvRVeS6
	 GWBvvW+ln7W2wSWjOa0FoCp16VPqMH/dOuIoQOZYtawtDonpWhIOOPl0ZeywQVj8pM
	 eRChgDDddD7g4R94qBYBnHX0VkYzl6SnSTl6CRdDA6fR0aBfPKMAorDIfBVlu/4BS9
	 +MxBRxjPR14vw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DE0E83809A80;
	Fri, 30 Aug 2024 16:50:29 +0000 (UTC)
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
 <172503662981.2653872.17272747323254726860.git-patchwork-summary@kernel.org>
Date: Fri, 30 Aug 2024 16:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: intel: Add check devm_kasprintf() returned value
  Submitter: Charles Han <hanchunchao@inspur.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=885083
  Lore link: https://lore.kernel.org/r/20240830074106.8744-1-hanchunchao@inspur.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



