Return-Path: <linux-spi+bounces-5628-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB559BCD8A
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 14:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C8028239E
	for <lists+linux-spi@lfdr.de>; Tue,  5 Nov 2024 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792E51D935E;
	Tue,  5 Nov 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9/jCfAP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ECD1D9A46
	for <linux-spi@vger.kernel.org>; Tue,  5 Nov 2024 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730812221; cv=none; b=q3XsNwNLHJjFfsAgVJyzDkFRkWNX0DxXVgJAxRricuNjeitXbc8BRV5KMI+WODA8l46dZgBRXL6ZaY7jRiIu26P7mRbLIsnU+piyUhj0XHVBYX6SJfzcWfrJA854MYFkXjCLUgwvudkukEuT+W+eyqw2f2Li9J4wn3i9ru90IAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730812221; c=relaxed/simple;
	bh=A61sInKOlH56BumFSJF6w38EwMLlnjE5QxTWqAUJQ7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I7soAtYlS/dIrxF6rI56w/GBlAvHhAK38asZlIluE/RrLhGasQcogCKRnGDCS8FS2wXaoqh2bM1KH8inJ+E0y1NwSM86e4v8nRqSHZ0kIqGJV6Zl2qoF37BdYQ9SOac8xQAx3dr2vG/qmAT9DveVZLwmm6Vp0EVKmmS8jLVGmOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9/jCfAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB23CC4CEDB;
	Tue,  5 Nov 2024 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730812220;
	bh=A61sInKOlH56BumFSJF6w38EwMLlnjE5QxTWqAUJQ7s=;
	h=Subject:From:Date:To:From;
	b=l9/jCfAPkI3KHPMB9ovbWh19UEDKlrWEwCAGYCtYsUCYEZuTi/eNw2pe9XKNj8hwt
	 9MJLYj3Zs3qpK7AuiznwN/zIHP9/QHkR+Ji+iO79lWMxMu3yAAhqBJNP/Gwgc2N4c/
	 cpfFO3mEAzfVzUWllU/7GiLOyRDNXhpSIWZ53a9gGqGI6z5y5/D1WS/PRnyppaX/+t
	 k+YmPFflkkUMrDEzrjDetIGtT8KHvYEu2/NZ1StrK8PdMfb4zNBy7wZ+mOzShpGGQZ
	 CGrZnJZOmn7xLPXWgKDaGwcoLUsm0IAY7O43mft91iBzutCf8ptMIzHxuFVCnbycXA
	 zCM7WUJcvoI3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4A6F3809A80;
	Tue,  5 Nov 2024 13:10:30 +0000 (UTC)
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
 <173081222911.551228.17598380828317780730.git-patchwork-summary@kernel.org>
Date: Tue, 05 Nov 2024 13:10:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Use of_property_present() for non-boolean properties
  Submitter: Rob Herring <robh@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=906201
  Lore link: https://lore.kernel.org/r/20241104190759.277184-2-robh@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



